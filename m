Return-Path: <hch@lst.de>
Date: Fri, 15 Sep 2017 20:07:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
Cc: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 00/10] nvme multipath support on top of nvme-4.13 branch
Message-ID: <20170915180701.GA8981@lst.de>
References: <20170912042048.pdbyl6vsoeui6bnp@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170912042048.pdbyl6vsoeui6bnp@haynes>
List-ID: <linux-block@vger.kernel.org>

Hi Anish,

I looked over the code a bit, and I'm rather confused by the newly
added commands.  Which controller supports them?  Also the NVMe
working group went down a very different way with the ALUA approch,
which uses different grouping concepts and doesn't require path
activations - for Linux we'd really like to stick to only standardized
multipath implementations.
