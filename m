Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 19 Oct 2018 11:26:37 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org, Pavel
 Machek <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Bart Van Assche <bvanassche@acm.org>, Jan Kara
 <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Mark
 Brown <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Johannes
 Thumshirn <jthumshirn@suse.de>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
In-Reply-To: <CACRpkdZgethKLu3P4taLfzqjGULyoP-T7bhUUpRKtjDRteNnxA@mail.gmail.com>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <18744e21b9f5aa4b3ab721a007a3e9a2@natalenko.name>
 <CACRpkdZgethKLu3P4taLfzqjGULyoP-T7bhUUpRKtjDRteNnxA@mail.gmail.com>
Message-ID: <42fc6a366e88335b72517ea7d58847fd@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

On 19.10.2018 10:33, Linus Walleij wrote:
>> > +     /*
>> > +      * Zoned devices must use a deadline scheduler because currently
>> > +      * that is the only scheduler respecting zoned writes.
>> > +      */
>> > +     if (blk_queue_is_zoned(q))
>> > +             policy = "mq-deadline";
>> > +     else if (IS_ENABLED(CONFIG_IOSCHED_BFQ))
>> > +             policy = "bfq";
>> > +     else
>> > +             policy = "mq-deadline";
>> 
>> If more rules will be needed in the future, shall we just add extra 
>> ifs,
>> or it would be better to craft some struct/table now + policy search
>> helper?
> 
> Let's do it when it happens. Premature optimization is the root
> of all evil ;)

I'd say, this is a matter of code readability, not optimisations. I do 
not strongly object against current approach, though.

-- 
   Oleksandr Natalenko (post-factum)
