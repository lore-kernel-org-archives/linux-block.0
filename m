Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>, Mark Brown <broonie@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
Date: Wed, 17 Oct 2018 07:48:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181017100526.GB23493@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/17/18 3:05 AM, Jan Kara wrote:
> Well, the problem with this is that big distro people really don't care
> much because they already use udev for tuning the IO scheduler. So whatever
> defaults the kernel is going to pick likely won't be seen by distro
> customers. Embedded people seem to be driving this effort because they
> either don't run udev or they feel not all their teams building new
> products have enough expertise to come up with a proper set of rules...

What's missing in this discussion is a definition of "embedded system". 
Is that a system like a streaming player for TV channels that neither 
has a keyboard nor a display or a system that can run multiple apps 
simultaneously like a smartphone? I think the difference matters because 
some embedded devices hardly do any background I/O nor load any 
executable code from storage after boot. So at least for some embedded 
devices the problem discussed in this e-mail thread does not exist.

Bart.
