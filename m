Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: don't do cgroup accounting for split bio's
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180727211407.24318-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <838a33f4-90e4-f939-f0e4-4434122e7f2e@kernel.dk>
Date: Fri, 27 Jul 2018 15:17:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180727211407.24318-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/27/18 3:14 PM, Josef Bacik wrote:
> We need to check in blkcg_bio_issue_check if the bio is flagged as
> QUEUE_ENTERED, because if it is then we've already accounted for the IO
> in the cgroup stats.

That's a bit of a flag overload, I think that at least warrants a
comment.


-- 
Jens Axboe
