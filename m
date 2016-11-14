Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 2/3] irq-poll: micro optimize some branch predictions
To: Christoph Hellwig <hch@lst.de>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
 <1478991755-28153-3-git-send-email-sagi@grimberg.me>
 <20161113151312.GC7578@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ec78c118-a4be-8f0c-ec47-2965d9e2d14b@grimberg.me>
Date: Mon, 14 Nov 2016 02:49:17 +0200
MIME-Version: 1.0
In-Reply-To: <20161113151312.GC7578@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

> Are they really that unlikely?  I don't like these annotations unless
> it's clearly an error path or they have a high, demonstrable benefit.

IRQ_POLL_F_DISABLE is set when disabling the iop (in the end of the
world). IRQ_POLL_F_SCHED is set on irq_poll_sched() itself so this cond
would match only if the user called irq_poll_sched() twice which it
shouldn't ever do.

So yes, I think these are really unlikely()

But now I noticed that I typo'ed the IRQ_POLL_F_SCHED from
unlikely to likely :(

need to fix that...
