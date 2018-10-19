Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
Date: Fri, 19 Oct 2018 12:59:04 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Jan Kara <jack@suse.cz>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
Message-Id: <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 15 ott 2018, alle ore 20:26, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> ...
>> This kind of policy does not belong in the kernel, at least
>> not in the current form. If we had some sort of "enable best
>> options for a desktop" then it could fall under that umbrella.
>>=20
>=20
> I don't think bfq can be considered a scheduler for only desktops any
> longer.
>=20

Hi Jens,
this reply of mine went on bugging me, until I understood my mistake.

The fact that I consider bfq good also for servers *does not* imply
that having bfq in desktops is to be refused.

As for the option that you are hinting at, I also acknowledge that it
would be trivial for an admin/developer to know whether a given kernel
is meant for a desktop/personal system, while it is more difficult to
choose explicitly among the various I/O schedulers available.

So, I apologize for my shortsighted, initial reply, and ask you if can
elaborate a little more on this.  I'm willing to help, if I can.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> --=20
>> Jens Axboe
