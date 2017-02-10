Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
To: Paolo Valente <paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
 <1486745110.2840.3.camel@sandisk.com>
 <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org>
CC: "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com>
Date: Fri, 10 Feb 2017 10:13:41 -0800
MIME-Version: 1.0
In-Reply-To: <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/10/2017 08:49 AM, Paolo Valente wrote:
>> $ grep '^C.*_MQ_' .config
>> CONFIG_BLK_MQ_PCI=3Dy
>> CONFIG_MQ_IOSCHED_BFQ=3Dy
>> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
>> CONFIG_MQ_IOSCHED_NONE=3Dy
>> CONFIG_DEFAULT_MQ_BFQ_MQ=3Dy
>> CONFIG_DEFAULT_MQ_IOSCHED=3D"bfq-mq"
>> CONFIG_SCSI_MQ_DEFAULT=3Dy
>> CONFIG_DM_MQ_DEFAULT=3Dy
>>
> =

> Could you reconfigure with none or mq-deadline as default, check
> whether the system boots, and, it it does, switch manually to bfq-mq,
> check what happens, and, in the likely case of a failure, try to get
> the oops?

Hello Paolo,

I just finished performing that test with the following kernel config:
$ grep '^C.*_MQ_' .config
CONFIG_BLK_MQ_PCI=3Dy
CONFIG_MQ_IOSCHED_BFQ=3Dy
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
CONFIG_MQ_IOSCHED_NONE=3Dy
CONFIG_DEFAULT_MQ_DEADLINE=3Dy
CONFIG_DEFAULT_MQ_IOSCHED=3D"mq-deadline"
CONFIG_SCSI_MQ_DEFAULT=3Dy
CONFIG_DM_MQ_DEFAULT=3Dy

After the system came up I logged in, switched to the bfq-mq scheduler
and ran several I/O tests against the boot disk. Sorry but nothing
interesting appeared in the kernel log.

Bart.
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
