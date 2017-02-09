Return-Path: <BATV+0bef769f1c4d4d9eae97+4918+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 9 Feb 2017 05:50:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
	pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: automatic IRQ affinity for virtio V3
Message-ID: <20170209135031.GA5771@infradead.org>
References: <20170205171526.6224-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sun, Feb 05, 2017 at 06:15:17PM +0100, Christoph Hellwig wrote:
> Hi Michael, hi Jason,
> 
> This patches applies a few cleanups to the virtio PCI interrupt handling
> code, and then converts the virtio PCI code to use the automatic MSI-X
> vectors spreading, as well as using the information in virtio-blk
> and virtio-scsi to automatically align the blk-mq queues to the MSI-X
> vectors.

Any chance to get this in for 4.11 after I got reviews from Jason
for most of the patches?
