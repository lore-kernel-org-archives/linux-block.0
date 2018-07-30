Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH][v3] block: don't account for split bio's size in cgroup
 stats
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180730141001.2617-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <45eddc00-14f7-271d-367d-8df93d757dee@kernel.dk>
Date: Mon, 30 Jul 2018 08:26:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180730141001.2617-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/30/18 8:10 AM, Josef Bacik wrote:
> We need to check in blkcg_bio_issue_check if the bio is flagged as
> QUEUE_ENTERED, because if it is then we've already accounted for the
> size of the IO in the cgroup stats.  We can still however account for
> the extra IO since it'll be another request.

Applied, thanks.

-- 
Jens Axboe
