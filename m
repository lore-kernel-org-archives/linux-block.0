Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <14538128.U7izDYD32A@wuerfel>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk> <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <14538128.U7izDYD32A@wuerfel>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 28 Oct 2016 14:17:28 +0200
Message-ID: <CAFLxGvzdsCGahFNaCVxd1LVq33URERRS8oD3XBNyO7ymw6OkXw@mail.gmail.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Daniel Walter <dwalter@sigma-star.at>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 28, 2016 at 2:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > I don't think that's an accurate statement. In terms of coverage, most
>> > drivers do support blk-mq. Anything SCSI, nvme, virtio-blk, SATA runs on
>> > (or can run on) top of blk-mq.
>>
>> Well, I just used "git grep" and found that many drivers didn't use
>> blkmq. Apologize if I gave the wrong impressions.
>
> To clarify, this seems to be a complete list:
>
> $ git grep -wl '\(__\|\)blk_\(fetch\|end\|start\)_request' | xargs grep -L blk_mq
> Documentation/scsi/scsi_eh.txt
> arch/um/drivers/ubd_kern.c

AFAICT Daniel looked at the UML block driver and did an initial
conversion some time ago.
Daniel?
Anton is also working on a patch series to speed up the driver.
Maybe it is time to bite the bullet and do the conversion.

-- 
Thanks,
//richard
