Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3] blk-mq: code clean-up by adding an API to clear
 set->mq_map
To: Minwoo Im <minwoo.im.dev@gmail.com>, linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>
References: <1530542803-25212-1-git-send-email-minwoo.im.dev@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <04695ac3-256e-4061-b84f-bf666856b3cc@kernel.dk>
Date: Mon, 2 Jul 2018 09:08:41 -0600
MIME-Version: 1.0
In-Reply-To: <1530542803-25212-1-git-send-email-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/2/18 8:46 AM, Minwoo Im wrote:
> set->mq_map is now currently cleared if something goes wrong when
> establishing a queue map in blk-mq-pci.c.  It's also cleared before
> updating a queue map in blk_mq_update_queue_map().
> 
> This patch provides an API to clear set->mq_map to make it clear.

Applied for 4.19, thanks.

-- 
Jens Axboe
