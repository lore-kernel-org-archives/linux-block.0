Return-Path: <BATV+1231baeb55c0b05cfb44+5315+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 13 Mar 2018 01:23:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, jiufei.xue@linux.alibaba.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: bio_check_eod() needs to consider partition
Message-ID: <20180313082352.GA29190@infradead.org>
References: <20180308074648.6037-1-hch@lst.de>
 <20180308210921.GA3932@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308210921.GA3932@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 02:09:23PM -0700, Jens Axboe wrote:
> On Thu, Mar 08 2018, Christoph Hellwig wrote:
> > bio_check_eod() should check partiton size not the whole disk if
> > bio->bi_partno is non-zero.
> > 
> > Based on an earlier patch from Jiufei Xue.
> 
> This doesn't apply, what did you generate it against?

Linux 4.15.  I'll respin it against latests 4.16-rc.
