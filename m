Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] sx8: use a per-host tag_set
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20181109135110.32386-1-hch@lst.de>
 <20181109135110.32386-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee69bb73-8d95-b727-c8f2-c90188e37602@kernel.dk>
Date: Fri, 9 Nov 2018 08:13:50 -0700
MIME-Version: 1.0
In-Reply-To: <20181109135110.32386-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 6:51 AM, Christoph Hellwig wrote:
> The current sx8 code spends a lot of effort dealing with the fact that
> tags are per-host, but there might be multiple queues.  Now that the
> driver has been converted to blk-mq it can take care of the blk-mq
> tag_set concept that has been designed just for that.

This is a thing of beauty, it should be on the poster for "why
drivers should be as trivial as possible".

-- 
Jens Axboe
