Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1518547636.2796.15.camel@wdc.com>
Date: Wed, 14 Feb 2018 18:55:58 +0100
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Message-Id: <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
 <1518547636.2796.15.camel@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 13 feb 2018, alle ore 19:47, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> On Tue, 2018-02-13 at 19:38 +0100, Paolo Valente wrote:
>> as a first attempt, I've followed your steps, but got:
>> Error: could not find sg_reset
>=20
> Please install the sg3_utils package. Every Linux distro I know of =
supports that
> package.

I happened to do this test on a Fedora.

> And in case you would like to install it from source, the source code =
of
> that package is available from http://sg.danny.cz/sg/sg3_utils.html.
>=20
>> For ib_srp-backport, I get a lot of warnings like the following one,
>> at "make install" (preceded by corresponding warnings at the end of
>> the compilation):
>> depmod: WARNING: /lib/modules/4.16.0-rc1+/extra/ib_srp.ko needs =
unknown symbol rdma_resolve_addr
>>=20
>> Unfortunately, it gets worse while executing "make scst srpt":
>=20
> Please neither install the ib_srp-backport driver nor SCST. These =
drivers have
> not yet been tested against kernel v4.16-rc1. I provided you a kernel =
tree in
> which both the SRP initiator and target drivers support RoCE such that =
you don't
> need to install these out-of-tree drivers. I think all that you need =
from the
> srp-test README document are the instructions to configure =
/etc/multipath.conf
> and the instructions for installing the required packages. =46rom that =
README
> document:
>=20
> Install the following software packages if these have not yet been =
installed:
> fio, gcc-c++, make, multipath-tools or device-mapper-multipath, =
sg3_utils,
> srptools, e2fsprogs and xfsprogs.
>=20

Thank you very much for these instructions Bart.

After following all of them (and taking some other step needed), I
invoked:
sudo ./run_tests -c -d -r 10 -t 02-mq -e bfq

But I got the following:
./lib/functions: riga 34: /sys/class/block/ram0/size: No such file or =
directory
./lib/functions: riga 34: * 512: errore di sintassi: atteso un operando =
(il token dell'errore =C3=A8 "* 512")
Unloaded the ib_srpt kernel module
Unloaded the rdma_rxe kernel module
modprobe: FATAL: Module ib_uverbs not found in directory =
/lib/modules/4.16.0-rc1+
modprobe: FATAL: Module ib_umad not found in directory =
/lib/modules/4.16.0-rc1+
SoftRoCE network interfaces: rxe0
modprobe: FATAL: Module target_core_iblock not found in directory =
/lib/modules/4.16.0-rc1+

So I think I need a little more help, to have this working in a
reasonable amount of time.  In particular, could you tell me all what
is missing?

Thanks,
Paolo

> Thanks,
>=20
> Bart.
>=20
>=20
