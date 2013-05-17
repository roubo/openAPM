
//延迟函数
void delay(uint32_t ms)
{
    hal.scheduler->delay(ms);
}
//mavlink延迟函数
void mavlink_delay(uint32_t ms)
{
    hal.scheduler->delay(ms);
}

uint32_t millis()
{
    return hal.scheduler->millis();
}

uint32_t micros()
{
    return hal.scheduler->micros();
}
//设置引脚的输出模式
void pinMode(uint8_t pin, uint8_t output)
{
    hal.gpio->pinMode(pin, output);
}
//设置引脚的输出值（数字量）
void digitalWrite(uint8_t pin, uint8_t out)
{
    hal.gpio->write(pin,out);
}
//读取引脚的输入值
uint8_t digitalRead(uint8_t pin)
{
    return hal.gpio->read(pin);
}

