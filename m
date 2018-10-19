Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Bryan Gurney <bgurney@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
 Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
 <CAHhmqcSb45qePdKsidQcEk7bNeZC5h6Oew-qH=LA7dsQL_uhSg@mail.gmail.com>
 <CACRpkdZZ6RU0aJpUqRn1ndyob1_COhaEs6B9QVRWfa+a60n+Lg@mail.gmail.com>
 <CAHhmqcQinFN9ez5MTRquY0FPaYO2BmOKMn0avy84QPWLK1g2Gg@mail.gmail.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <e7687ded-bf95-5b76-a56b-99dc27434b8c@suse.de>
Date: Fri, 19 Oct 2018 15:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAHhmqcQinFN9ez5MTRquY0FPaYO2BmOKMn0avy84QPWLK1g2Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 19/10/18 15:36, Bryan Gurney wrote:
> I like this idea.  I don't have enough experience to write this patch
> myself, but I imagine something like adding "bool is_zoned_aware" to
> "struct elevator_type", and setting that true only for the schedulers
> that are currently zoned-device aware (which is currently deadline on
> single queue, mq-deadline on blk-mq).

I don't think this is needed currently as a) Jens is working on getting
rid of the legacy path, which leaves us with mq-deadline only and Linus'
patch has:

+	if (blk_queue_is_zoned(q))
+		policy = "mq-deadline";

Which chooses mq-deadline on a zoned device.

So nothing to worry about here now.

All this only given Linus' patch actually gets merged.

Byte,
	Johannes
-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
