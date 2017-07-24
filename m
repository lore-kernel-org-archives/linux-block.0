Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: map queues to all present CPUs
To: Christoph Hellwig <hch@lst.de>
Cc: maxg@mellanox.com, linux-block@vger.kernel.org
References: <20170718150440.27360-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0a6d5b67-35cd-7c6d-3c1b-6bdda1896a3d@kernel.dk>
Date: Mon, 24 Jul 2017 10:01:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170718150440.27360-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/18/2017 09:04 AM, Christoph Hellwig wrote:
> We already do this for PCI mappings, and the higher level code now
> expects that CPU on/offlining doesn't have an affect on the queue
> mappings.

Applied for 4.13, thanks.

-- 
Jens Axboe
