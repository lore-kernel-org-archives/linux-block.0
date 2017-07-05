Subject: Re: [PATCH] mtip32xx: avoid to read HOST_CAP from HW in .queue_rq()
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20170705041427.9887-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5b272cd9-3479-6b79-312d-11f1dedc7ed0@fb.com>
Date: Wed, 5 Jul 2017 12:11:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170705041427.9887-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/04/2017 10:14 PM, Ming Lei wrote:
> It is observed reading the register from HW takes a bit long,
> for example in my box, the following difference of 'perf report
> --no-children fio ...' can be seen when running I/O:
> 
> 1) V4.12 without patch
> +    9.28%       fio  [mtip32xx]           [k] mtip_irq_handler
> +    8.48%       fio  [mtip32xx]           [k] mtip_init_cmd_header
> 
> 2) V4.12 with the following patch
> +    9.14%       fio  [mtip32xx]           [k] mtip_irq_handler
> ......
> +    1.14%       fio  [mtip32xx]           [k] mtip_init_cmd_header
> 
> IOPS can be increased by ~5% with this patch too.

Thanks, this is definitely problematic since we don't just do it
at init time anymore. Applied for 4.13.

-- 
Jens Axboe
