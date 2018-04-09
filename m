Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <2679696.GDoj5zcZOu@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com> <2679696.GDoj5zcZOu@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Apr 2018 11:32:17 -0700
Message-ID: <CAGXu5jLG9ia+zBNcPt+q+BpJayoUuYwXitOgeHmh=7sPp-s87A@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
	paolo.valente@linaro.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 8, 2018 at 12:07 PM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> So far, I wasn't able to trigger this with mq-deadline (or without blk-mq).
> Maybe, this has something to do with blk-mq+BFQ re-queuing, or it's just me
> not being persistent enough.

Ah, this detail I didn't have. I've changed my environment to

build with:

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_IOSCHED_BFQ=y

boot with scsi_mod.use_blk_mq=1

and select BFQ in the scheduler:

# cat /sys/block/sd?/queue/scheduler
mq-deadline kyber [bfq] none
mq-deadline kyber [bfq] none

Even with this, I'm not seeing anything yet...

> It looks like this code path was re-written completely with 17cb960f29c2, but
> it went merged for the upcoming v4.17 only, and thus I haven't tried it yet.
>
> Kees took a brief look at it already: [1]. This is what smartctl does [2]
> (just a usual strace capture when the bug is not triggered).
>
> Christoph, do you have some idea on why this can happen?
>
> Thanks.
>
> Regards,
>   Oleksandr
>
> [1] https://marc.info/?l=linux-scsi&m=152287333013845&w=2
> [2] https://gist.github.com/pfactum/6f58f8891468aeba1ab2cc9f45668735

The thing I can't figure out is how req->sense is slipping forward in
(and even beyond!) the allocation.

-Kees

-- 
Kees Cook
Pixel Security
