Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
CC: Fabio Checconi <fchecconi@gmail.com>, Arianna Avanzini
	<avanzini.arianna@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Date: Tue, 7 Mar 2017 00:22:16 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0DA827@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 08:01 AM, Paolo Valente wrote:=0A=
> Some patch generates WARNINGS with checkpatch.pl, but these WARNINGS=0A=
> seem to be either unavoidable for the involved pieces of code (which=0A=
> the patch just extends), or false positives.=0A=
=0A=
The code in this series looks reasonably clean from a code style point=0A=
of view, but please address all checkpatch warnings that can be=0A=
addressed easily. A few examples of such checkpatch warnings:=0A=
=0A=
ERROR: "foo * bar" should be "foo *bar"=0A=
=0A=
WARNING: Symbolic permissions 'S_IRUGO|S_IWUSR' are not preferred.=0A=
Consider using octal permissions '0644'.=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=0A=
