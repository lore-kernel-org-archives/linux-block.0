Return-Path: <prvs=3214458fc9=axboe@fb.com>
Subject: Re: [PATCH] block: set make_request_fn manually in
 blk_mq_update_nr_hw_queues
To: Josef Bacik <jbacik@fb.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
References: <1486749813-2167-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <48721192-ebbd-0e66-616d-948d918d1315@fb.com>
Date: Fri, 10 Feb 2017 11:15:22 -0700
MIME-Version: 1.0
In-Reply-To: <1486749813-2167-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 02/10/2017 11:03 AM, Josef Bacik wrote:
> Calling blk_queue_make_request resets a bunch of settings on the
> request_queue, but all we really want is to update the make_request_fn,
> so do this directly so we don't lose things like the logical and
> physical block sizes.

Applied, thanks Josef.

-- 
Jens Axboe
