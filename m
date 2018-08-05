Return-Path: <BATV+fb6f8c4579abdce3116e+5460+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 5 Aug 2018 00:33:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme updates for 4.19
Message-ID: <20180805073305.GA31663@infradead.org>
References: <20180804084354.GA26103@infradead.org>
 <df1c976e-8ea7-ba14-d1d2-caf8511de527@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <df1c976e-8ea7-ba14-d1d2-caf8511de527@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 04, 2018 at 12:39:13PM -0600, Jens Axboe wrote:
> On 8/4/18 2:43 AM, Christoph Hellwig wrote:
> This one:
> 
> > Christoph Hellwig (9):
> >       nvme: add ANA support
> 
> Has a stupid conflict with:
> 
> commit fa441b71aa27d06fa79d5e7f7c329981dccd94d1
> Author: Weiping Zhang <zhangweiping@didichuxing.com>
> Date:   Tue Jul 3 00:34:38 2018 +0800
> 
>     nvme: don't enable AEN if not supported
> 
> from mainline. Please keep changes like that in mind, that change should
> never have been in the "nvme: add ANA support" patch.

The addition of the supported bit is because the released version
of the ANA spec was buggy and didn't add the supported bit to the
oaes field.  This hasn't been fixed in an erratate and I dropped
the manual addition of the support, but I failed to remove the
local supported variable (which modulo the conflict actually makes
sense, but should indeed not have been part of the commit).
