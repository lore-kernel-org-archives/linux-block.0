Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: count the hctx as active before allocate tag
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: tom.leiming@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <faf3e267-b6e6-7a44-2c14-91fd9bf63371@kernel.dk>
Date: Wed, 8 Aug 2018 08:40:26 -0600
MIME-Version: 1.0
In-Reply-To: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/8/18 3:56 AM, Jianchao Wang wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. The other shared-tags users could exhaust the driver
> tags and starve a non-active and waiting-tag hctx. Count the hctx as
> active before try to allocate driver tag to fix this.

Patch looks good, but please add some comments along the way.

-- 
Jens Axboe
