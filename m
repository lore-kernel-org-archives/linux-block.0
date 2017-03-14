Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0DA827@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Date: Tue, 14 Mar 2017 15:12:06 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <3498DE72-65D0-4D1A-9CA6-9176137AF6CE@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <1D08B61A9CF0974AA09887BE32D889DA0DA827@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 mar 2017, alle ore 01:22, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On 03/04/2017 08:01 AM, Paolo Valente wrote:
>> Some patch generates WARNINGS with checkpatch.pl, but these WARNINGS
>> seem to be either unavoidable for the involved pieces of code (which
>> the patch just extends), or false positives.
>=20
> The code in this series looks reasonably clean from a code style point
> of view,

Great, thanks!

> but please address all checkpatch warnings that can be
> addressed easily. A few examples of such checkpatch warnings:
>=20
> ERROR: "foo * bar" should be "foo *bar"
>=20

The offending line is:
*(__PTR) =3D (u64)__data * NSEC_PER_USEC;

so this seems a false positive.

> WARNING: Symbolic permissions 'S_IRUGO|S_IWUSR' are not preferred.
> Consider using octal permissions '0644'.
>=20

I have used symbolic permissions because I find them much easier to
remember and decode than numeric constants, and because it is done so
in cfq-iosched.c, deadline-iosched.c and now mq-deadline.c.  But,
since you share this checkpatch complain, I will switch to constants.

Thanks,
Paolo

> Thanks,
>=20
> Bart.
