Return-Path: <hch@lst.de>
Date: Mon, 23 Jan 2017 19:31:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Merlin <marc@merlins.org>
Subject: Re: [PATCH 3/6] nvme/pci: Start queues after tagset is updated
Message-ID: <20170123183129.GB23791@lst.de>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com> <1483569671-1462-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483569671-1462-4-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
