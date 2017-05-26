Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/2] blk-mq: merge bio into sw queue before plugging
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20170526115320.13612-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <425be0a8-628d-2da6-8a6a-e78f7f9d947e@kernel.dk>
Date: Fri, 26 May 2017 07:30:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170526115320.13612-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/26/2017 05:53 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch moves sw queue's bio merge before plugging, then
> the sequential I/O performance regression by blk-mq can be fixed.
> 
> The 2nd patch makes the sw queue's bio merge as the default .bio_merge
> if no io scheduler is used or the io scheduler doesn't provide
> .bio_merge.
> 
> This post splits the orginal one into two patches to make diff easy-read
> as suggested by Christoph.

Looks good to me now, thanks Ming. I'll queue this up for 4.13 when
I open that up, which is very soon.

-- 
Jens Axboe
