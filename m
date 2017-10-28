Return-Path: <hch@lst.de>
Date: Sat, 28 Oct 2017 08:38:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171028063825.GA14261@lst.de>
References: <20171023145126.2471-1-hch@lst.de> <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171024213959.GB23307@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 24, 2017 at 05:40:00PM -0400, Mike Snitzer wrote:
> Having the NVme driver go to such lengths to hide its resources from
> upper layers is certainly the work of an evil genius experiencing some
> serious territorial issues.  Not sugar-coating it.. you wouldn't.

I'm pretty surre Hannes will appreciate being called an evil genius :)

> I kept meaning to reply to your earlier iterations on this series to
> ask: can we please get a CONFIG_NVME_MULTIPATHING knob to make it so
> that the NVMe driver doesn't implicitly consume (and hide) all
> per-controler devices?

I thought about adding it, but mostly for a different reason: it's
quite a bit of code, and we now start to see NVMe in deeply embedded
contexts, e.g. the latest Compact Flash spec is based on NVMe, so it
might be a good idea to give people a chance to avoid the overhead.

> Ah well.  There is only one correct way to do NVMe multipathing after
> all right?

I don't think you'll get very useful results, even if you try.  But I
guess we'll just have to tell people to use SuSE if they want NVMe
multipathing to work then :)
