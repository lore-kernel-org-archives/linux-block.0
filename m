Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: code clean-up by adding an API to clear
 set->mq_map
To: Minwoo Im <minwoo.im.dev@gmail.com>, linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>
References: <1530539150-9591-1-git-send-email-minwoo.im.dev@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <12de6f1b-8a0b-89ac-7900-b78be605ad63@kernel.dk>
Date: Mon, 2 Jul 2018 08:31:19 -0600
MIME-Version: 1.0
In-Reply-To: <1530539150-9591-1-git-send-email-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 7:45 AM, Minwoo Im wrote:
> set->mq_map is now currently cleared if something goes wrong when
> establishing a queue map in blk-mq-pci.c.  It's also cleared before
> updating a queue map in blk_mq_update_queue_map().
> 
> This patch provides an API to clear set->mq_map to make it clear.

I'm fine with this change, but the declaration should go into
block/blk-mq.h, it's not a driver API.

-- 
Jens Axboe
