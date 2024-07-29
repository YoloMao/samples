目前使用 samples/provider_shopper 进行测试 Flutter On HarmonyOS

按照以下步骤运行：

1. 
```shell
git clone -b feat/ohos_integration https://github.com/YoloMao/samples
```
2. 
```shell
cd samples/provider_shopper && flutter clean && flutter build hap --release
```
3. 使用 DevEco Studio 打开 samples/provider_shopper/ohos 项目，并在真机或模拟器上运行