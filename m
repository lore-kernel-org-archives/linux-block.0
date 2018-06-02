Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: update nr_requests when switching to 'none'
 scheduler
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 "Ewan D. Milne" <emilne@redhat.com>
References: <20180602071809.4277-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <12c6487b-9bb6-d208-35a3-e8fadbd2acf2@kernel.dk>
Date: Sat, 2 Jun 2018 14:08:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180602071809.4277-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/2/18 1:18 AM, Ming Lei wrote:
> Now we setup q->nr_requests when switching to one new scheduler,
> but not do it for 'none', then q->nr_requests may not be correct
> for 'none'.
> 
> This patch fixes this issue by always updating 'nr_requests' when
> switching to 'none'.

Looks fine, applied.

-- 
Jens Axboe
