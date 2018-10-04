Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181004202553.71c2599c@alans-desktop>
Date: Thu, 4 Oct 2018 22:19:34 +0200
Cc: Bart Van Assche <bvanassche@acm.org>,
 Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 Andreas Herrmann <aherrmann@suse.com>,
 Mel Gorman <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>
Message-Id: <466C47DB-02D7-490C-91E3-8C7AA41B8D79@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 04 ott 2018, alle ore 21:25, Alan Cox =
<gnomes@lxorguk.ukuu.org.uk> ha scritto:
>=20
>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>> select a default I/O scheduler.
>=20
> That assumes such a thing exists.

Well, as of now the default is more or less in the Schrdinger's cat =
state :)

Metaphors apart, I do agree with your point.  As for me, what you
point out is one of the core issues at stake here.

Thanks,
Paolo

> The kernel knows what devices it is
> dealing with. The kernel 'default' ought to be 'whatever is usually =
best
> for this device'. A distro cannot just pick a correct single default
> because NVME and USB sticks are both normal and rather different in =
needs.
>=20
> Alan
