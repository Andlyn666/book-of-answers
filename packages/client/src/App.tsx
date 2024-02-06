import { useMUD } from "./MUDContext";
import React, { Component, useState } from 'react';
import  { runQuery, Has, HasValue, getComponentValueStrict } from "@latticexyz/recs";
const styleUnset = { all: "unset" } as const;
import { setup } from "./mud/setup";
import { async } from './mud/setupNetwork';
import { v4 as uuidv4 } from 'uuid';
import { Spin } from 'antd';


const getRandomAnswer = async (Answers, getRandomness) => {
  const entityID = generateUniqueBytes32KeyFromUUID();
  const randomness = await getRandomness(entityID, 0);
  // uint256 is BigInt, so need to convert to BigInt
  const randomIndex = BigInt(randomness % BigInt(20));
  const result = runQuery([HasValue(Answers, {page: BigInt(randomIndex)})]);
  const answerEntity = result.values().next().value;
  const answer = getComponentValueStrict(Answers, answerEntity);
  console.log(randomIndex);

  return answer.answers;
};

function generateUniqueBytes32KeyFromUUID(): string {
  // Generate a UUID
  const uuid = uuidv4();
  
  // Remove hyphens and convert to a hex string
  const hexUuid = uuid.replace(/-/g, '');
  
  // Pad the hexUuid if necessary to make sure it's 32 bytes long
  const paddedHexUuid = hexUuid.padEnd(64, '0');
  
  // Ensure that the string is exactly 32 bytes long (in case of an oversized UUID)
  const bytes32Key = `0x${paddedHexUuid.substring(0, 64)}`;
  
  return bytes32Key;
}

export const App = () => {
  const {
    components: { Answers },
    systemCalls: { getRandomness },
  } = useMUD();

  const [isOpen, setIsOpen] = useState(false);
  const [answer, setAnswer] = useState('');
  const [isLoading, setIsLoading] = useState(false);


  // Define the inline styles for the container and book opened div
  const containerStyle = {
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    height: '100vh', // Full viewport height
    backgroundColor: '#003399',
  };

  const bookOpenedStyle = {
    margin: '0 auto', // Center the text horizontally
    color: 'white', // White text color
    fontSize: '24px', // Larger font size for readability
    textAlign: 'center', // Center the text
  };

  const toggleBook = async () => {
    if (!isOpen) {
      setIsLoading(true);
      const result = await getRandomAnswer(Answers, getRandomness);
      setIsLoading(false);
      setAnswer(result);
    }
    setIsOpen(!isOpen);
  };

  return (
    <>
      <div style={{ ...containerStyle}}>
        {!isOpen ? (
          // When the book is not open, show the book cover image.
          <Spin size="large" spinning={isLoading}>
            <img
              src="../book.jpeg"
              className="book-img"
              onClick={toggleBook}
              alt="Book cover"
              style={{ height: "100vh" }}
            />
          </Spin>
        ) : (
          // When the book is open, show the content and the content image.
            <div>
              <img
                src="../content.jpeg"
                className="book-img"
                onClick={toggleBook}
                alt="Book content"
                style={{
                  height: "100vh",
                }}
              />
              <h3 style={{ position: 'absolute', top: '38%', left: '50%', color: "gray", textShadow: "white", transform: 'translate(-50%, -50%)' }}>
                {answer}
              </h3>
            </div>
        )}
      </div>
    </>
  );
};
