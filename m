Return-Path: <jiufei.xue@linux.alibaba.com>
Subject: Re: [PATCH 2/4] block: bio_check_eod() needs to consider partition
To: Christoph Hellwig <hch@lst.de>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
 <9827cd58-0044-19a2-6bc1-bc4357ed846d@linux.alibaba.com>
 <20180227001140.GC5249@lst.de>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <5dde9695-a68a-ca6b-3fa8-75e53db354c1@linux.alibaba.com>
Date: Tue, 27 Feb 2018 12:51:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180227001140.GC5249@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 2018/2/27 上午8:11, Christoph Hellwig wrote:
> The issue looks real, but please try to do this without another
> partition lookup. 
> 
Yes, I think the partition size test can be moved to
blk_partition_remap(). I will send version 2 later.
