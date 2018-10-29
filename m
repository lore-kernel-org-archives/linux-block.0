Return-Path: <hare@suse.de>
Subject: Re: [PATCH 05/14] blk-mq: allow software queue to map to multiple
 hardware queues
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-6-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <50bef908-1c9e-e16c-6856-c9bdd745302a@suse.de>
Date: Mon, 29 Oct 2018 08:37:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> The mapping used to be dependent on just the CPU location, but
> now it's a tuple of { type, cpu} instead. This is a prep patch
> for allowing a single software queue to map to multiple hardware
> queues. No functional changes in this patch.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-sched.c   |  2 +-
>   block/blk-mq.c         | 18 ++++++++++++------
>   block/blk-mq.h         |  2 +-
>   block/kyber-iosched.c  |  6 +++---
>   include/linux/blk-mq.h |  3 ++-
>   5 files changed, 19 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
