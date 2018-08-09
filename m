Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V3] blk-mq: count the hctx as active before allocate tag
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: tom.leiming@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3b980395-5030-34e0-7736-4a5227d8d860@kernel.dk>
Date: Thu, 9 Aug 2018 08:35:25 -0600
MIME-Version: 1.0
In-Reply-To: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/8/18 8:09 PM, Jianchao Wang wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. If a previously inactive hctx try to get tag first
> time, it may fails and need to wait. However, due to the stale tag
> ->active_queues, the other shared-tags users are still able to
> occupy all driver tags while there is someone waiting for tag.
> Consequently, even if the previously inactive hctx is waked up, it
> still may not be able to get a tag and could be starved.
> 
> To fix it, we count the hctx as active before try to allocate driver
> tag, then when it is waiting the tag, the other shared-tag users
> will reserve budget for it.

Hand-applied for 4.19 (didn't apply directly).

-- 
Jens Axboe
