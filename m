Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] blk-mq: Add a polling specific stats function
To: sbates@raithlin.com
References: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
 <1491413957-30885-3-git-send-email-sbates@raithlin.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Damien.LeMoal@wdc.com, osandov@osandov.com, sagi@grimberg.me
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <370c8854-1735-b0e7-089f-4b04068ca4f1@kernel.dk>
Date: Wed, 5 Apr 2017 12:14:33 -0600
MIME-Version: 1.0
In-Reply-To: <1491413957-30885-3-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/05/2017 11:39 AM, sbates@raithlin.com wrote:
> @@ -42,6 +42,33 @@ static LIST_HEAD(all_q_list);
>  static void blk_mq_poll_stats_start(struct request_queue *q);
>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>  
> +static int blk_mq_poll_stats_bkt(const struct request *rq)
> +{
> +	int dir, bytes;
> +
> +	dir = blk_stat_rq_ddir(rq);
> +	bytes = blk_rq_bytes(rq);
> +
> +	if (bytes <= 512)
> +		return dir;
> +	else if (bytes <= 4096)
> +		return dir + 2;
> +	else if (bytes <= 8192)
> +		return dir + 4;
> +	else if (bytes <= 16384)
> +		return dir + 6;
> +	else if (bytes <= 32768)
> +		return dir + 8;
> +	else if (bytes <= 65536)
> +		return dir + 10;
> +	else
> +		return dir + 12;

Why not just have 8 buckets, and make it:

	bucket = ddir + ilog2(bytes) - 9;

and cap it at MAX_BUCKET (8) and put all those above into the top
bucket.

-- 
Jens Axboe
