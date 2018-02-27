Return-Path: <hch@lst.de>
Date: Tue, 27 Feb 2018 01:11:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/4] block: bio_check_eod() needs to consider partition
Message-ID: <20180227001140.GC5249@lst.de>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com> <9827cd58-0044-19a2-6bc1-bc4357ed846d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9827cd58-0044-19a2-6bc1-bc4357ed846d@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

The issue looks real, but please try to do this without another
partition lookup. 
