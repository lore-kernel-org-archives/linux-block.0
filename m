Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <450d81c7d03a33005e7d49a9499fe20b6748c019.camel@wdc.com>
Date: Thu, 10 May 2018 18:13:13 +0200
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "broonie@linaro.org" <broonie@linaro.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <8402D464-3403-4129-90A9-ABF4E67282B0@linaro.org>
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
 <6C49304C-D506-4719-9365-E7D35BEC9851@linaro.org>
 <1519868123.2777.28.camel@wdc.com>
 <10BDC305-A874-477C-9545-5617036C2E91@linaro.org>
 <2dcb12b92e50a31c55dd3ab0e464cc819432c3d3.camel@wdc.com>
 <7E372E2C-83A8-4EF4-B52E-E3AC6ED01C74@linaro.org>
 <a6e512dff10d0cff12a688bbf1b30e275a91633e.camel@wdc.com>
 <6A355080-C9A8-475D-9A35-32850D771ABB@linaro.org>
 <450d81c7d03a33005e7d49a9499fe20b6748c019.camel@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 10 mag 2018, alle ore 18:12, Bart Van Assche =
<Bart.VanAssche@wdc.com> ha scritto:
>=20
> On Fri, 2018-05-04 at 22:11 +0200, Paolo Valente wrote:
>>> Il giorno 30 mar 2018, alle ore 18:57, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>>>=20
>>> On Fri, 2018-03-30 at 10:23 +0200, Paolo Valente wrote:
>>>> Still 4.16-rc1, being that the version for which you reported this
>>>> issue in the first place.
>>>=20
>>> A vanilla v4.16-rc1 kernel is not sufficient to run the srp-test =
software
>>> since RDMA/CM support for the SRP target driver is missing from that =
kernel.
>>> That's why I asked you to use the for-next branch from my github =
repository
>>> in a previous e-mail. Anyway, since the necessary patches are now in
>>> linux-next, the srp-test software can also be run against =
linux-next. Here
>>> are the results that I obtained with label next-20180329 and the =
kernel
>>> config attached to your previous e-mail:
>>>=20
>>> # while ./srp-test/run_tests -c -d -r 10 -e bfq; do :; done
>>>=20
>>> BUG: unable to handle kernel NULL pointer dereference at =
0000000000000200
>>> PGD 0 P4D 0=20
>>> Oops: 0002 [#1] SMP PTI
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.0.0-prebuilt.qemu-project.org 04/01/2014
>>> RIP: 0010:rb_erase+0x284/0x380
>>> Call Trace:
>>> <IRQ>
>>> elv_rb_del+0x24/0x30
>>> bfq_remove_request+0x9a/0x2e0 [bfq]
>>> ? rcu_read_lock_sched_held+0x64/0x70
>>> ? update_load_avg+0x72b/0x760
>>> bfq_finish_requeue_request+0x2e1/0x3b0 [bfq]
>>> ? __lock_is_held+0x5a/0xa0
>>> blk_mq_free_request+0x5f/0x1a0
>>> blk_put_request+0x23/0x60
>>> multipath_release_clone+0xe/0x10
>>> dm_softirq_done+0xe3/0x270
>>> __blk_mq_complete_request_remote+0x18/0x20
>>> flush_smp_call_function_queue+0xa1/0x150
>>> generic_smp_call_function_single_interrupt+0x13/0x30
>>> smp_call_function_single_interrupt+0x4d/0x220
>>> call_function_single_interrupt+0xf/0x20
>>> </IRQ>
>>=20
>> I suspect my recent fix [1] might fix your failure too.
>>=20
>> [1] =
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1682264.html
>=20
> Hello Paolo,
>=20
> With patch [1] applied I can't reproduce the aforementioned crash. I =
will add
> my Tested-by.
>=20

Great, thanks!

Paolo

> Thanks,
>=20
> Bart.
>=20
>=20
