Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/2] block, bfq: two pending patches
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180113110518.2519-1-paolo.valente@linaro.org>
Date: Thu, 18 Jan 2018 09:25:43 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <8EB4BACE-3D6D-4EB7-844E-45092AC7644B@linaro.org>
References: <20180113110518.2519-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 13 gen 2018, alle ore 12:05, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
> here are again the two pending patches you asked me to resend [1]. One
> of them, fixing read-starvation problems, was accompanied by a cover
> letter. I'm pasting the content of that cover letter below.
>=20
> The patch addresses (serious) starvation problems caused by
> request-tag exhaustion, as explained in more detail in the commit
> message. I started from the solution in the function
> kyber_limit_depth, but then I had to define more articulate limits, to
> counter starvation also in cases not covered in kyber_limit_depth.
> If this solution proves to be effective, I'm willing to port it
> somehow to the other schedulers.
>=20

Hi Jens,
have had to time to check these patches?  Sorry for pushing, but I
guess 4.16 is getting closer, and these patches are performance
critical; especially the first, which solves a starvation problem.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> [1] https://www.spinics.net/lists/linux-block/msg21586.html
>=20
> Paolo Valente (2):
>  block, bfq: limit tags for writes and async I/O
>  block, bfq: limit sectors served with interactive weight raising
>=20
> block/bfq-iosched.c | 158 =
+++++++++++++++++++++++++++++++++++++++++++++++++---
> block/bfq-iosched.h |  17 ++++++
> block/bfq-wf2q.c    |   3 +
> 3 files changed, 169 insertions(+), 9 deletions(-)
>=20
> --
> 2.15.1
