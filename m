Return-Path: <hch@lst.de>
Date: Tue, 7 Jun 2016 12:51:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, keith.busch@intel.com,
	linux-block@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme: add fabrics sysfs attributes
Message-ID: <20160607105101.GA17113@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de> <1465248119-17875-5-git-send-email-hch@lst.de> <20160607085217.mp7ppvdmvzwwi36b@c203.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160607085217.mp7ppvdmvzwwi36b@c203.arch.suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 07, 2016 at 10:52:17AM +0200, Johannes Thumshirn wrote:
> Can you please add this to Documentation/ABI/ as well?

None of the NVMe files are documented there..  But maybe it's worth
a separate little project to document all of them.
