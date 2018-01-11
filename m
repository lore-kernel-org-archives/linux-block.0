Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/2] Rework blk_mq_mark_tag_wait()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180110214122.15452-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0bc6375d-f168-5fe2-6766-64f9562ee3e8@kernel.dk>
Date: Thu, 11 Jan 2018 10:00:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180110214122.15452-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 2:41 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> This patch series reworks the blk_mq_mark_tag_wait() implementation and also
> fixes a race condition in that function. Please consider these two patches for
> kernel v4.16.

Applied 1/2 for now, need to mull over 2/2 a bit more.

-- 
Jens Axboe
