Return-Path: <jthumshirn@suse.de>
Date: Mon, 2 Jul 2018 10:15:39 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
Message-ID: <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 01, 2018 at 01:21:39AM +0900, Minwoo Im wrote:
> set->mq_map is now currently cleared if something goes wrong when
> establishing a queue map in blk-mq-pci.c.  It's also cleared before
> updating a queue map in blk_mq_update_queue_map().
> 
> This patch provides an API to clear set->mq_map to make it clear.

Is there a follow up patch to this which justifies the change?

With no 2nd consumer of the function I fear this will be disregarded
as useless code churn.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
