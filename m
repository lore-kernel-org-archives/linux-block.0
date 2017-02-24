Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "tj@kernel.org"
	<tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
Date: Fri, 24 Feb 2017 18:44:55 +0000
Message-ID: <1487961857.2575.8.camel@sandisk.com>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
	 <1486745110.2840.3.camel@sandisk.com>
	 <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org>
	 <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com>
	 <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org>
	 <1A8DF6A8-C251-472A-9CE1-ACB1BCD0E9AB@linaro.org>
	 <1487023626.2719.9.camel@sandisk.com>
	 <1487025524.2719.11.camel@sandisk.com>
	 <62F8F65E-A376-44EB-B53C-C2CFB8F8693F@linaro.org>
In-Reply-To: <62F8F65E-A376-44EB-B53C-C2CFB8F8693F@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-22 at 22:29 +0100, Paolo Valente wrote:
> thanks for this second attempt of yours.  Although, unfortunately, not
> providing some clear indication of the exact cause of your hang (apart
> from a possible deadlock), your log helped me notice another bug.
>=20
> At any rate, as I have just written to Jens, I have pushed a new
> version of the branch [1] (not just added new commits, but also
> integrated some old commit with new changes, to make it more quickly).
> The branch now contains both a fix for the above bug, and, more
> importantly, a fix for the circular dependencies that were still
> lurking around.  Could you please test it?

Hello Paolo,

I have good news: the same test system boots normally with the same
kernel config I used during my previous tests and with the latest
bfq-mq code (commit a965d19585c0) merged with kernel v4.10.

Thanks,

Bart.=
