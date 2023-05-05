import React from 'react'
import { Text, View, StyleSheet, WebView } from 'react-native'

export default class App extends React.Component {
  render() {
    return (
      <View style = {styles.container}>
        <Text> App Class </Text>
      </View>
    )
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#bbaaaa',
    width: 300,
    borderRadius: 10,
  }
})

