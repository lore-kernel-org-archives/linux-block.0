Return-Path: <prvs=576cf723c=bart.vanassche@wdc.com>
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
To: Paolo Valente <paolo.valente@linaro.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
 <1518547636.2796.15.camel@wdc.com>
 <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
Date: Wed, 14 Feb 2018 10:11:49 -0800
MIME-Version: 1.0
In-Reply-To: <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 02/14/18 09:55, Paolo Valente wrote:
> After following all of them (and taking some other step needed), I
> invoked:
> sudo ./run_tests -c -d -r 10 -t 02-mq -e bfq
> 
> But I got the following:
> ./lib/functions: riga 34: /sys/class/block/ram0/size: No such file or directory
> ./lib/functions: riga 34: * 512: errore di sintassi: atteso un operando (il token dell'errore è "* 512")
> Unloaded the ib_srpt kernel module
> Unloaded the rdma_rxe kernel module
> modprobe: FATAL: Module ib_uverbs not found in directory /lib/modules/4.16.0-rc1+
> modprobe: FATAL: Module ib_umad not found in directory /lib/modules/4.16.0-rc1+
> SoftRoCE network interfaces: rxe0
> modprobe: FATAL: Module target_core_iblock not found in directory /lib/modules/4.16.0-rc1+
> 
> So I think I need a little more help, to have this working in a
> reasonable amount of time.  In particular, could you tell me all what
> is missing?

Hello Paolo,

Can you check whether CONFIG_BLK_DEV_RAM, CONFIG_INFINIBAND, 
CONFIG_INFINIBAND_USER_MAD, CONFIG_INFINIBAND_USER_ACCESS, 
CONFIG_INFINIBAND_USER_MEM, CONFIG_INFINIBAND_IPOIB, 
CONFIG_INFINIBAND_SRP, CONFIG_INFINIBAND_SRPT and CONFIG_RDMA_RXE were 
enabled in your kernel config?

Thanks,

Bart.
