Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org>
Date: Mon, 13 Feb 2017 22:07:12 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <1A8DF6A8-C251-472A-9CE1-ACB1BCD0E9AB@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486745110.2840.3.camel@sandisk.com> <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org> <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com> <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 feb 2017, alle ore 20:49, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 10 feb 2017, alle ore 19:13, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>=20
>> On 02/10/2017 08:49 AM, Paolo Valente wrote:
>>>> $ grep '^C.*_MQ_' .config
>>>> CONFIG_BLK_MQ_PCI=3Dy
>>>> CONFIG_MQ_IOSCHED_BFQ=3Dy
>>>> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
>>>> CONFIG_MQ_IOSCHED_NONE=3Dy
>>>> CONFIG_DEFAULT_MQ_BFQ_MQ=3Dy
>>>> CONFIG_DEFAULT_MQ_IOSCHED=3D"bfq-mq"
>>>> CONFIG_SCSI_MQ_DEFAULT=3Dy
>>>> CONFIG_DM_MQ_DEFAULT=3Dy
>>>>=20
>>>=20
>>> Could you reconfigure with none or mq-deadline as default, check
>>> whether the system boots, and, it it does, switch manually to =
bfq-mq,
>>> check what happens, and, in the likely case of a failure, try to get
>>> the oops?
>>=20
>> Hello Paolo,
>>=20
>> I just finished performing that test with the following kernel =
config:
>> $ grep '^C.*_MQ_' .config
>> CONFIG_BLK_MQ_PCI=3Dy
>> CONFIG_MQ_IOSCHED_BFQ=3Dy
>> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
>> CONFIG_MQ_IOSCHED_NONE=3Dy
>> CONFIG_DEFAULT_MQ_DEADLINE=3Dy
>> CONFIG_DEFAULT_MQ_IOSCHED=3D"mq-deadline"
>> CONFIG_SCSI_MQ_DEFAULT=3Dy
>> CONFIG_DM_MQ_DEFAULT=3Dy
>>=20
>> After the system came up I logged in, switched to the bfq-mq =
scheduler
>> and ran several I/O tests against the boot disk.
>=20
> Without any failure, right?
>=20
> Unfortunately, as you can imagine, no boot failure occurred on
> any of my test systems so far :(
>=20
> This version of bfq-mq can be configured to print all its activity in
> the kernel log, by just defining a macro.  This will of course slow
> down the system so much to make it probably unusable, if bfq-mq is
> active from boot.  Yet, the failure may still occur so early to make
> this approach useful to discover where bfq-mq gets stuck.  As of now I
> have no better ideas.  Any suggestion is welcome.
>=20

Hi Bart,
I have found a machine crashing at boot, yet not only when bfq-mq is
chosen, but also when mq-deadline is chosen as the default
scheduler.  I have found and just reported the cause of the failure,
together with a fix.  Probably this is not the cause of your failure,
but what do you think about trying this fix?  BTW, I have rebased the
branch [1] against the new commits in Jens for-4.11/next.

Otherwise, if you have no news or suggestions, would you be willing to
try my micro-logging proposal?

Thanks,
Paolo

[1] https://github.com/Algodev-github/bfq-mq

> Thanks,
> Paolo
>=20
>> Sorry but nothing
>> interesting appeared in the kernel log.
>>=20
>> Bart.
>> Western Digital Corporation (and its subsidiaries) E-mail =
Confidentiality Notice & Disclaimer:
>>=20
>> This e-mail and any files transmitted with it may contain =
confidential or legally privileged information of WDC and/or its =
affiliates, and are intended solely for the use of the individual or =
entity to which they are addressed. If you are not the intended =
recipient, any disclosure, copying, distribution or any action taken or =
omitted to be taken in reliance on it, is prohibited. If you have =
received this e-mail in error, please notify the sender immediately and =
delete the e-mail in its entirety from your system.
