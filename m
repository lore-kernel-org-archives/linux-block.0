Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
Message-ID: <1530542687.13674.17.camel@gmail.com>
Subject: Re: [PATCH V2] blk-mq: code clean-up by adding an API to clear
 set->mq_map
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Date: Mon, 02 Jul 2018 23:44:47 +0900
In-Reply-To: <12de6f1b-8a0b-89ac-7900-b78be605ad63@kernel.dk>
References: <1530539150-9591-1-git-send-email-minwoo.im.dev@gmail.com>
	 <12de6f1b-8a0b-89ac-7900-b78be605ad63@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-02 at 08:31 -0600, Jens Axboe wrote:
> On 7/2/18 7:45 AM, Minwoo Im wrote:
> > 
> > set->mq_map is now currently cleared if something goes wrong when
> > establishing a queue map in blk-mq-pci.c.  It's also cleared before
> > updating a queue map in blk_mq_update_queue_map().
> > 
> > This patch provides an API to clear set->mq_map to make it clear.
> I'm fine with this change, but the declaration should go into
> block/blk-mq.h, it's not a driver API.

Hi Jens,

Thanks for your kindly directives.

I got your point.  I'll make it up for V3 patch with place it into
block/blk-mq.h instead include/linux/blk-mq.h.

Thanks, really.

	Minwoo Im
