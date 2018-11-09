Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 9 Nov 2018 05:20:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181109132011.GA2706@infradead.org>
References: <20181109065654.GA12805@infradead.org>
 <6b8d8562-a31d-bf11-557b-7f33a17d6e60@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6b8d8562-a31d-bf11-557b-7f33a17d6e60@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 09, 2018 at 06:16:09AM -0700, Jens Axboe wrote:
> On 11/8/18 11:56 PM, Christoph Hellwig wrote:
> >  - revert an RDMA commit that didn't help but caused problems
> >  - fix another minor P2P fallout
> >  - make sure the multipath device inherits the devices limits of
> >    the controllers below
> > 
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git nvme-4.20
> 
> This is based on 4.20-rc1 for some reason, not my for-linus. So I get
> a few thousand extra commits... I pulled the patches and applied
> manually.

That is because your for-linus was still 4.20-rc based when
I created it.
