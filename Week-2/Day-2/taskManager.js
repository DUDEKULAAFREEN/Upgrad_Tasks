// task.js

let tasks = [];

// --------------------
// 1️⃣ Callback Version
// --------------------
const addTaskCallback = (task, callback) => {
  setTimeout(() => {
    tasks.push(task);
    callback(`Task added (Callback): ${task}`);
  }, 1000);
};

// --------------------
// 2️⃣ Promise Version
// --------------------
const addTaskPromise = (task) => {
  return new Promise((resolve) => {
    setTimeout(() => {
      tasks.push(task);
      resolve(`Task added (Promise): ${task}`);
    }, 1000);
  });
};

// --------------------
// 3️⃣ Async/Await Version
// --------------------
const addTaskAsync = async (task) => {
  const message = await addTaskPromise(task);
  return message;
};

// Delete Task
const deleteTask = (task) => {
  tasks = tasks.filter(t => t !== task);
  return `Task deleted: ${task}`;
};

// List Tasks
const listTasks = () => {
  return tasks.map((task, index) => `${index + 1}. ${task}`);
};


// --------------------
// Execution
// --------------------

// Callback
addTaskCallback("Learn JS", (msg) => {
  console.log(msg);
});

// Promise
addTaskPromise("Practice Coding")
  .then(msg => console.log(msg));

// Async/Await
const run = async () => {
  const msg = await addTaskAsync("Build Project");
  console.log(msg);

  console.log("\nTask List:");
  listTasks().forEach(task => console.log(task));

  console.log("\n" + deleteTask("Practice Coding"));

  console.log("\nUpdated Task List:");
  listTasks().forEach(task => console.log(task));
};

run();