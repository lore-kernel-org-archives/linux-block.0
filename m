Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
Message-ID: <1530536157.13674.4.camel@gmail.com>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date: Mon, 02 Jul 2018 21:55:57 +0900
In-Reply-To: <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
	 <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Johannes,

Thanks for you kindly comment.

On Mon, 2018-07-02 at 10:15 +0200, Johannes Thumshirn wrote:
> On Sun, Jul 01, 2018 at 01:21:39AM +0900, Minwoo Im wrote:
> > 
> > set->mq_map is now currently cleared if something goes wrong when
> > establishing a queue map in blk-mq-pci.c.  It's also cleared before
> > updating a queue map in blk_mq_update_queue_map().
> > 
> > This patch provides an API to clear set->mq_map to make it clear.
> Is there a follow up patch to this which justifies the change?
> 
> With no 2nd consumer of the function I fear this will be disregarded
> as useless code churn.

No 2nd follow-up patch will be there.  I thought these two parts are
using a same unit-function to clear the set->mq-map.  Also thought it
would be great for the future use when it needs to be cleared.
However, as you mentioned, I totally agree with your point.  It seems
just churns for churns' sake with no more usage for now.

Thanks for your comment, again.

	Minwoo Im

> 
> Byte,
> 	Johannes
