Return-Path: <hch@lst.de>
Date: Thu, 9 Jun 2016 19:12:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: general preparation for NVMe over Fabrics support
Message-ID: <20160609171205.GA2628@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de> <20160609163854.GF1696@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160609163854.GF1696@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 09, 2016 at 12:38:55PM -0400, Keith Busch wrote:
> For patch ordering, I had thought there were no issues with these
> I submitted:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2016-May/004704.html
>   http://lists.infradead.org/pipermail/linux-nvme/2016-May/004709.html
> 
> It's the ones adding the SCHED_RESET state to fixup synchronizing
> continuous user initiated resets, and think it should still go in for 4.7.
> There will be a minor conflict with 10/10 in this set it does go first.

The 4.8 tree has forked already. I'm fine with adding these to 4.7,
but we'll also need them in 4.8 going forward.

Jens: are you fine with merging them for 4.7 for now, and merging them
for 4.8 separately once I've finished the fabrics bits?
