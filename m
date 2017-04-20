Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
To: Stephen Bates <sbates@raithlin.com>, Omar Sandoval <osandov@osandov.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
Date: Thu, 20 Apr 2017 14:34:31 -0600
MIME-Version: 1.0
In-Reply-To: <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 02:33 PM, Stephen  Bates wrote:
> 
>> Nah, let's just leave it as-is then, even though I don't think it's the
>> prettiest thing I've ever seen.
> 
> I did look at making the stats buckets in the request_queue struct
> based on dir and size. Something like:
> 
> -       struct blk_rq_stat      poll_stat[2];
> +       struct blk_rq_stat      poll_stat[2][BLK_MQ_POLL_STATS_BKTS/2];
> 
> This actually did clean up some in some places but because the
> callback still uses a linear array of buckets we do get this:
> 
> -       if (cb->stat[READ].nr_samples)
> -               q->poll_stat[READ] = cb->stat[READ];
> -       if (cb->stat[WRITE].nr_samples)
> -               q->poll_stat[WRITE] = cb->stat[WRITE];
> +       for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
> +               if (cb->stat[bucket].nr_samples)
> +                       q->poll_stat[bucket%2][bucket/2] = cb->stat[bucket];
> 
> I tend to agree with Omar that keeping the buckets in a linear array
> is overall cleaner and more generalized.

I agree, it's fine as-is. We should queue it up for 4.12.

> However right now I am stuck as I am seeing the kernel oops I reported
> before in testing of my latest patchset [1]. I will try and find some
> time to bisect that but it looks like it was introduced when the
> support for mq schedulers was added (on or around bd166ef18).

Just replied to that one, let me know if the suggestion works.

-- 
Jens Axboe
