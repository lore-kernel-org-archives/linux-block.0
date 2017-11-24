Return-Path: <BATV+9841fd955d20a8654d38+5206+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 24 Nov 2017 00:32:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 4.15
Message-ID: <20171124083259.GA10952@infradead.org>
References: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
 <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
 <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 23, 2017 at 10:04:55PM -0700, Jens Axboe wrote:
> > +       NVME_FC_Q_LIVE = (1 << 1),                                              
> > }; 
> > 
> > for flags that are used with set_bit() and friends? That's just
> > misleading, should be 0, 1, etc, not a shift.
> > 
> > The rest looks pretty straight forward, but the above is an eye sore.

Yes, it is misleading, but so far harmless.

Your fixup looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
