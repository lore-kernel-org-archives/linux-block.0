Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
Date: Tue, 13 Feb 2018 19:38:34 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 12 feb 2018, alle ore 17:31, Bart Van Assche =
<bart.vanassche@wdc.com> ha scritto:
>=20
> On 02/11/18 23:35, Paolo Valente wrote:
>> Also this smells a little bit like some spurious elevator call.
>> Unfortunately I have no clue on the cause.  To go on, I need at least
>> to reproduce it.  In this respect: Bart, could you please tell me how
>> to setup the offending configuration, and to cause the failure?
>> Possibly with just one, or at most two PCs.  I don't have fancier hw
>> at the moment.
>=20
> Hello Paolo,
>=20
> Although I expect that it is possible to reproduce this with an =
unmodified v4.16-rc1 kernel, this is how I ran into this issue:
> * Clone the for-next branch of https://github.com/bvanassche/linux.
> * Build and install that kernel in a virtual machine.
> * Clone https://github.com/bvanassche/srp-test.
> * Run the following command:
>  srp-test/run_tests -c -d -r 10 -t 02-mq -e bfq
>=20

Hi Bart,
as a first attempt, I've followed your steps, but got:
Error: could not find sg_reset
expectedly because of dependencies that you are implying in your steps.

So, I have followed the instructions in the srp-test README for the
case "Running the Tests on an Ethernet Setup", directly on a 4.16-rc1.

For ib_srp-backport, I get a lot of warnings like the following one,
at "make install" (preceded by corresponding warnings at the end of
the compilation):
depmod: WARNING: /lib/modules/4.16.0-rc1+/extra/ib_srp.ko needs unknown =
symbol rdma_resolve_addr

Unfortunately, it gets worse while executing "make scst srpt":

  CC [M]  /home/paolo/scst/srpt/src/ib_srpt.o
In file included from /home/paolo/scst/srpt/src/ib_srpt.c:62:0:
/home/paolo/scst/srpt/src/ib_srpt.h:481:8: error: redefinition of =
=E2=80=98struct srp_login_req_rdma=E2=80=99
 struct srp_login_req_rdma {
        ^~~~~~~~~~~~~~~~~~
In file included from /home/paolo/scst/srpt/src/ib_srpt.h:44:0,
                 from /home/paolo/scst/srpt/src/ib_srpt.c:62:
/mnt/linux-dev/linux/include/scsi/srp.h:139:8: note: originally defined =
here
 struct srp_login_req_rdma {
        ^~~~~~~~~~~~~~~~~~

Could you please give me some help, so as to not get lost among these =
issues?

Thanks,
Paolo

> Thanks,
>=20
> Bart.
