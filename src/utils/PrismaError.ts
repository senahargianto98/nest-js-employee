const prismaClientError = (error) => {
  switch (error) {
    case 'P2025':
      console.log('ok');
      return `data tidak ditemukan`;
      break;
    case 'P2002':
      return `${error.meta.target[0]} sudah terdaftar, gunakan ${error.meta.target[0]} lain`;
      break;
    case 'P2003':
      return `${error.meta.field_name} tidak ditemukan`;
      break;
    default:
      return error;
      break;
  }
};

export { prismaClientError };
