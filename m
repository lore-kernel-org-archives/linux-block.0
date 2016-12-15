Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Omar Sandoval <osandov@osandov.com>
References: <1481779568-10642-1-git-send-email-axboe@fb.com>
 <1481779568-10642-6-git-send-email-axboe@fb.com>
 <20161215192940.GA29747@vader.dhcp.TheFacebook.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <82dd217d-2631-131a-a006-8b80908bf0ee@fb.com>
Date: Thu, 15 Dec 2016 14:44:17 -0700
MIME-Version: 1.0
In-Reply-To: <20161215192940.GA29747@vader.dhcp.TheFacebook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/15/2016 12:29 PM, Omar Sandoval wrote:
> Hey, Jens, a couple of minor nits below.
> 
> One bigger note: adding the blk_mq_sched_*() helpers and keeping the
> blk_mq_*() helpers that they replaced seems risky. For example,
> blk_mq_free_request() is superseded by blk_mq_sched_put_request(), but
> we kept blk_mq_free_request(). There are definitely some codepaths that
> are still using blk_mq_free_request() that are now wrong
> (__nvme_submit_user_cmd() is the most obvious one I saw).
> 
> Can we get rid of the old, non-sched functions? Or maybe even make old
> interface do the sched stuff instead of adding blk_mq_sched_*()?

I fixed this up. blk_mq_free_request() is now what we still use as an
exported interface, and that just calls blk_mq_sched_put_request().  The
old (__)blk_mq_free_request() are now (__)blk_mq_finish_request() and
internal only.

-- 
Jens Axboe
