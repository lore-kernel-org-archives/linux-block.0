Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
Date: Fri, 16 Feb 2018 08:39:36 +0100
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <6C49304C-D506-4719-9365-E7D35BEC9851@linaro.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
 <1518547636.2796.15.camel@wdc.com>
 <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
 <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 14 feb 2018, alle ore 19:11, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> On 02/14/18 09:55, Paolo Valente wrote:
>> After following all of them (and taking some other step needed), I
>> invoked:
>> sudo ./run_tests -c -d -r 10 -t 02-mq -e bfq
>> But I got the following:
>> ./lib/functions: riga 34: /sys/class/block/ram0/size: No such file or =
directory
>> ./lib/functions: riga 34: * 512: errore di sintassi: atteso un =
operando (il token dell'errore =C3=A8 "* 512")
>> Unloaded the ib_srpt kernel module
>> Unloaded the rdma_rxe kernel module
>> modprobe: FATAL: Module ib_uverbs not found in directory =
/lib/modules/4.16.0-rc1+
>> modprobe: FATAL: Module ib_umad not found in directory =
/lib/modules/4.16.0-rc1+
>> SoftRoCE network interfaces: rxe0
>> modprobe: FATAL: Module target_core_iblock not found in directory =
/lib/modules/4.16.0-rc1+
>> So I think I need a little more help, to have this working in a
>> reasonable amount of time.  In particular, could you tell me all what
>> is missing?
>=20
> Hello Paolo,
>=20
> Can you check whether CONFIG_BLK_DEV_RAM, CONFIG_INFINIBAND, =
CONFIG_INFINIBAND_USER_MAD, CONFIG_INFINIBAND_USER_ACCESS, =
CONFIG_INFINIBAND_USER_MEM, CONFIG_INFINIBAND_IPOIB, =
CONFIG_INFINIBAND_SRP, CONFIG_INFINIBAND_SRPT and CONFIG_RDMA_RXE were =
enabled in your kernel config?
>=20

(+Linus, Ulf)

Hi Bart,
after enabling the listing options in your list, and a few other
related options, such iblock support, I get this:

$ sudo ./run_tests -c -d -r 10 -t 02-mq -e bfq
Unloaded the ib_srpt kernel module
Unloaded the rdma_rxe kernel module
SoftRoCE network interfaces: rxe0
Zero-initializing /dev/ram0 ... done
Zero-initializing /dev/ram1 ... done
mkdir: impossibile creare la directory "021c:42ff:fe4c:fac9": Invalid =
argument
Retrying with old port name format
mkdir: impossibile creare la directory =
"0xfe80000000000000021c42fffe4cfac9": Invalid argument

Thanks for your patience and collaboration,
Paolo

> Thanks,
>=20
> Bart.
