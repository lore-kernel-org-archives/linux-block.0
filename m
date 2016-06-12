Return-Path: <axboe@kernel.dk>
Date: Sun, 12 Jun 2016 07:33:18 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: general preparation for NVMe over Fabrics support
Message-ID: <20160612133318.GA16543@kernel.dk>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
 <20160609163854.GF1696@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160609163854.GF1696@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 09 2016, Keith Busch wrote:
> On Mon, Jun 06, 2016 at 11:20:42PM +0200, Christoph Hellwig wrote:
> > This patch set adds some needed preparations for the upcoming NVMe over
> > Fabrics support.
> > 
> > Contains:
> > - Allow transfer size limitations for NVMe transports
> > - Add the get_log_page command definition required by the NVMe target
> > - more helpers in core code that can be used by various transports
> > - add some missing constants and identify attributes
> 
> This series looks good.
> 
> Reviewed-by: Keith Busch <keith.busch@inte.com>

Added 1-8, 9/10 throws a lot of rejects and it's pre-coffee here. What
is this against?

I corrected your email, unless you joined a hot new startup called Inte.

> For patch ordering, I had thought there were no issues with these
> I submitted:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2016-May/004704.html

This looks fine for 4.7.

>   http://lists.infradead.org/pipermail/linux-nvme/2016-May/004709.html

This one is a bit involved...

-- 
Jens Axboe
