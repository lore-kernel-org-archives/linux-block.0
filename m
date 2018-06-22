Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix timeout handling in case the timeout handler
 returns BLK_EH_DONE
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Jianchao Wang <jianchao.w.wang@oracle.com>,
 Andrew Randrianasulu <randrianasulu@gmail.com>
References: <20180622201809.25519-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3eb3aa0a-06ce-1a35-c990-878ae3c814b7@kernel.dk>
Date: Fri, 22 Jun 2018 14:32:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180622201809.25519-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/22/18 2:18 PM, Bart Van Assche wrote:
> Make sure that RQF_TIMED_OUT is cleared when a request is reused
> after a block driver timeout handler has returned BLK_EH_DONE.

Thanks Bart, I think this looks good. I'm going to try and take some
time to go over the timeout parts, to ensure that we're good for
4.18.

-- 
Jens Axboe
