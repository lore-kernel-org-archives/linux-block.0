Return-Path: <mst@redhat.com>
Date: Thu, 9 Feb 2017 18:01:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, jasowang@redhat.com, axboe@kernel.dk,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: automatic IRQ affinity for virtio V3
Message-ID: <20170209180130-mutt-send-email-mst@kernel.org>
References: <20170205171526.6224-1-hch@lst.de>
 <20170209135031.GA5771@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209135031.GA5771@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 05:50:31AM -0800, Christoph Hellwig wrote:
> On Sun, Feb 05, 2017 at 06:15:17PM +0100, Christoph Hellwig wrote:
> > Hi Michael, hi Jason,
> > 
> > This patches applies a few cleanups to the virtio PCI interrupt handling
> > code, and then converts the virtio PCI code to use the automatic MSI-X
> > vectors spreading, as well as using the information in virtio-blk
> > and virtio-scsi to automatically align the blk-mq queues to the MSI-X
> > vectors.
> 
> Any chance to get this in for 4.11 after I got reviews from Jason
> for most of the patches?

Absolutely, I intend to merge it.

-- 
MST
