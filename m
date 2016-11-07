Return-Path: <hch@lst.de>
Date: Mon, 7 Nov 2016 15:46:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: add a first_vec argument to
	blk_mq_pci_map_queues
Message-ID: <20161107144615.GA10584@lst.de>
References: <1478473646-12524-1-git-send-email-hch@lst.de> <1478473646-12524-3-git-send-email-hch@lst.de> <c9322061-cbd0-8347-6581-d0a91c8b144f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c9322061-cbd0-8347-6581-d0a91c8b144f@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 07, 2016 at 10:37:16AM +0100, Hannes Reinecke wrote:
> With this patch smartpqi doesn't compile anymore; it still uses the old
> interface.
> So to get this merged you probably should send a patch for that one, too.

I have a fixup patch for it, but as these two patches aren't against
the SCSI tree I couldn't include it.
