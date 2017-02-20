Return-Path: <adrian.hunter@intel.com>
Subject: Re: Some throughput tests with MQ and BFQ on MMC/SD
To: Linus Walleij <linus.walleij@linaro.org>
References: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
 <e4836ece-d990-667c-27d0-4b19a2b4b160@marvell.com>
 <CACRpkda+p4erE9CdMUWi55-Ji8rj8TNOeJadHeOkHT7a1wbLmA@mail.gmail.com>
 <2995d066-ebee-c05c-a4cc-63d5b86df0be@intel.com>
 <CACRpkdZADpiD8KNUqyhqdpf4HoVJQx3Z2_5dkw6BG2MG-5r8Jg@mail.gmail.com>
Cc: Ziji Hu <huziji@marvell.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ritesh Harjani <riteshh@codeaurora.org>,
 Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, =?UTF-8?Q?Per_F=c3=b6rlin?=
 <per.forlin@axis.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <b168dd87-ca06-032d-40d1-fb8c209cb74a@intel.com>
Date: Mon, 20 Feb 2017 17:32:31 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdZADpiD8KNUqyhqdpf4HoVJQx3Z2_5dkw6BG2MG-5r8Jg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 20/02/17 15:46, Linus Walleij wrote:
> On Mon, Feb 20, 2017 at 9:03 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> MQ is not better - it is just different.
> 
> Well it is better in the sense that it has active maintainers and is
> not scheduled
> for depreciation.
> 
>> Because mmc devices do not have
>> multiple hardware queues, blk-mq essentially offers nothing but a different
>> way of doing the same thing.
> 
> I think what Ziji is pointing out is the hourglass-shaped structure of MQ.
> It has multiple *issue* queues as well, not just multiple *hardware*
> queues. That means that processes can have issue queues on different
> CPUs and not all requests end up in a single nexus like with the old blk
> layer.

blk-mq has a lighter touch, but if you use BLK_MQ_F_BLOCKING and only have
one hardware context, then you are still putting everything through a single
work item.

> 
> Whether it benefits MMC/SD in the end is a good question. It might,
> testing on multicores with multiple issue threads is needed.
> 
>> It would be better if blk-mq support was experimental until we can see how
>> well it works in practice.
> 
> Do you mean experimental in the MMC/SD stack, such that we should
> merge it as an additional scheduler instead of as the only scheduler
> replacement?

Not sure what you mean by "scheduler".

> 
> I think SCSI did/still does things like that.

A quick look at SCSI shows a module parameter use_blk_mq that defaults based
on a config option CONFIG_SCSI_MQ_DEFAULT i.e. defaults to false unless
selected.

Yes, something like that.

>                                               On the other hand, UBI
> just replaced the old block layer with MQ in commit
> ff1f48ee3bb3, and it is also very widely
> used, so there are example of both approaches. (How typical.)

UBI block is read-only and does not benefit from an I/O scheduler, and has
nothing like a command queue.   It doesn't seem unreasonable that very
different kinds of devices would take different approaches.

Unfortunately, ff1f48ee3bb3 mixes together switching the underlying I/O to
using a scatter gather list and removing a serializing mutex, so it is hard
to tell if improvements came from that or from blk-mq.
