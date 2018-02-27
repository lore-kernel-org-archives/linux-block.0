Return-Path: <hch@lst.de>
Date: Tue, 27 Feb 2018 01:10:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 1/4] block: fix the count of PGPGOUT for WRITE_SAME
Message-ID: <20180227001037.GB5249@lst.de>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com> <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ccd2433b-c197-bce3-fec7-14467f864d19@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
