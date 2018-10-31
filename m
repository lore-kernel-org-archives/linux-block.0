Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: call rq_qos_exit() after queue is frozen
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20181024131809.23070-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c360715e-fecf-18e0-9e00-91e831efeb56@kernel.dk>
Date: Wed, 31 Oct 2018 08:40:54 -0600
MIME-Version: 1.0
In-Reply-To: <20181024131809.23070-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/18 7:18 AM, Ming Lei wrote:
> rq_qos_exit() removes the current q->rq_qos, this action has to be
> done after queue is frozen, otherwise the IO queue path may never
> be waken up, then IO hang is caused.
> 
> So fixes this issue by moving rq_qos_exit() after queue is frozen.

Looks good, thanks. Applied for 4.20.

-- 
Jens Axboe
