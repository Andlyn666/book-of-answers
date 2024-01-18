import { useMUD } from "./MUDContext";
import React, { Component, useState } from 'react';
import  { runQuery, Has, HasValue, getComponentValueStrict } from "@latticexyz/recs";
const styleUnset = { all: "unset" } as const;
import "./book.css"
import { setup } from "./mud/setup";
const {
  components: { Answers },
  systemCalls: { getRandomness },
} = await setup();

const getRandomAnswer = (Answers) => {
  const randomIndex = getRandomness();
  console.log(randomIndex);
  // // uint256 is BigInt, so need to convert to BigInt
  // const result = runQuery([HasValue(Answers, {page: BigInt(randomIndex)})]);
  // const answerEntity = result.values().next().value;
  // const answer = getComponentValueStrict(Answers, answerEntity);
  // return answer.answers;
};

export const App = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [answer, setAnswer] = useState('');


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

  const toggleBook = () => {
    if (!isOpen) {
      setAnswer(getRandomAnswer(Answers));
    }
    setIsOpen(!isOpen);
  };

  return (
    <>
      <div style={{ ...containerStyle}}>
        {!isOpen ? (
          // When the book is not open, show the book cover image.
          <img
            src="../book.jpeg"
            className="book-img"
            onClick={toggleBook}
            alt="Book cover"
            style={{ height: "100vh" }}
          />
        ) : (
          // When the book is open, show the content and the content image.
          <>
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
          </>
        )}
      </div>
      {/* <table>
        <tbody>
          {tasks.map((task) => (
            <tr key={task.id}>
              <td align="right">
                <input
                  type="checkbox"
                  checked={task.value.completedAt > 0n}
                  title={task.value.completedAt === 0n ? "Mark task as completed" : "Mark task as incomplete"}
                  onChange={async (event) => {
                    event.preventDefault();
                    const checkbox = event.currentTarget;

                    checkbox.disabled = true;
                    try {
                      await toggleTask(task.key.key);
                    } finally {
                      checkbox.disabled = false;
                    }
                  }}
                />
              </td>
              <td>{task.value.completedAt > 0n ? <s>{task.value.description}</s> : <>{task.value.description}</>}</td>
              <td align="right">
                <button
                  type="button"
                  title="Delete task"
                  style={styleUnset}
                  onClick={async (event) => {
                    event.preventDefault();
                    if (!window.confirm("Are you sure you want to delete this task?")) return;

                    const button = event.currentTarget;
                    button.disabled = true;
                    try {
                      await deleteTask(task.key.key);
                    } finally {
                      button.disabled = false;
                    }
                  }}
                >
                  &times;
                </button>
              </td>
            </tr>
          ))}
        </tbody>
        <tfoot>
          <tr>
            <td>
              <input type="checkbox" disabled />
            </td>
            <td colSpan={2}>
              <form
                onSubmit={async (event) => {
                  event.preventDefault();
                  const form = event.currentTarget;
                  const fieldset = form.querySelector("fieldset");
                  if (!(fieldset instanceof HTMLFieldSetElement)) return;

                  const formData = new FormData(form);
                  const desc = formData.get("description");
                  if (typeof desc !== "string") return;

                  fieldset.disabled = true;
                  try {
                    await addTask(desc);
                    form.reset();
                  } finally {
                    fieldset.disabled = false;
                  }
                }}
              >
                <fieldset style={styleUnset}>
                  <input type="text" name="description" />{" "}
                  <button type="submit" title="Add task">
                    Add
                  </button>
                </fieldset>
              </form>
            </td>
          </tr>
        </tfoot>
      </table> */}
    </>
  );
};
