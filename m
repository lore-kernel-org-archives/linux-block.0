Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Adrian Hunter
 <adrian.hunter@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Jan Kara <jack@suse.cz>, Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>, Mark Brown <broonie@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa57d440-dff1-e260-c8c9-6d4bf04221a8@kernel.dk>
Date: Mon, 22 Oct 2018 02:21:47 -0600
MIME-Version: 1.0
In-Reply-To: <E2DDE0B9-F693-4EF3-B90C-C57F787B4DB3@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/19/18 4:59 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 15 ott 2018, alle ore 20:26, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> ...
>>> This kind of policy does not belong in the kernel, at least
>>> not in the current form. If we had some sort of "enable best
>>> options for a desktop" then it could fall under that umbrella.
>>>
>>
>> I don't think bfq can be considered a scheduler for only desktops any
>> longer.
>>
> 
> Hi Jens,
> this reply of mine went on bugging me, until I understood my mistake.
> 
> The fact that I consider bfq good also for servers *does not* imply
> that having bfq in desktops is to be refused.
> 
> As for the option that you are hinting at, I also acknowledge that it
> would be trivial for an admin/developer to know whether a given kernel
> is meant for a desktop/personal system, while it is more difficult to
> choose explicitly among the various I/O schedulers available.
> 
> So, I apologize for my shortsighted, initial reply, and ask you if can
> elaborate a little more on this.  I'm willing to help, if I can.

I think I've written about this multiple times now, but for me it
really just boils down to sane default, and policy in the kernel.
BFQ is very complicated, about 10K lines of code. I'm not comfortable
making that the default right now - as I've mentioned in other
replies, I think something like that should be driven by the distros
as they will ultimately be the ones that usually get complaints
about behavioral changes that impact performance adversely. This isn't
just about running some benchmarks and calling it a day.

Maybe some day we can make it the default on mq for single queue
devices, but I just don't think we are there yet in terms of
coverage. 

While I don't work for a distro anymore, I do have my hands dirty
with a fairly substantial deployment at work. There we run mq-deadline
on single queue devices, and kyber on multiqueue capable devices.

-- 
Jens Axboe
