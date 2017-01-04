Return-Path: <BATV+571a12579731380ce5cc+4882+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	mst@redhat.com,
	jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: 4.10 and -stable fix for virtio_blk and virtually mapped stacks
Date: Wed,  4 Jan 2017 08:25:04 +0300
Message-Id: <1483507505-26797-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Without this fix attempts to do scsi passthrough on virtio_blk will crash
the system on virtually mapped stacks, which is something happening during
boot with many distros.
