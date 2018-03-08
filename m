Return-Path: <hch@lst.de>
Date: Thu, 8 Mar 2018 15:40:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: bio_check_eod() needs to consider partition
Message-ID: <20180308144030.GA23266@lst.de>
References: <20180308074648.6037-1-hch@lst.de> <760fb684-8267-7747-69a7-a11eca4d3424@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <760fb684-8267-7747-69a7-a11eca4d3424@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 04:17:19PM +0800, Jiufei Xue wrote:
> Hi Christoph,
> 
> On 2018/3/8 下午3:46, Christoph Hellwig wrote:
> > bio_check_eod() should check partiton size not the whole disk if
> > bio->bi_partno is non-zero.
> > 
> I think the check should be done twice if the bio->bi_partno is not zero,
> one for the partition, and another for the whole disk after remap which
> is add in the commit 5ddfe9691c91
> ("md: check bio address after mapping through partitions").

I disagree.  See my other mail - if it fits inside the partition the
partition rescan code already made sure it also fits inside the device.
