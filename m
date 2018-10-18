Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 17:21:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/5] block: introduce helpers for allocating io buffer
 from slab
Message-ID: <20181018152133.GA28300@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018140342.GB32429@bombadil.infradead.org> <20181018140551.GA26500@lst.de> <20181018150605.GC32429@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018150605.GC32429@bombadil.infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 08:06:05AM -0700, Matthew Wilcox wrote:
> Can you name one that does require 512-byte alignment, preferably still
> in use?  Or even >4-byte alignment.  I just checked AHCI and that requires
> only 2-byte alignment.

Xen-blkfront, rsxx, various SD/MMC card readers for example.

> I have reason to believe that these are uncommon because of the feedback
> we got in the NVMe committee after releasing 1.0 which required 4-byte
> alignment from people whining that they just couldn't guarantee 4-byte
> alignment in their host devices and they absolutely needed to have no
> alignment requirements (!)

See how things turned - after NVMe SGLs followed the no alignment
rule enough controller vendors rebelled so that NVMe 1.3 has an option
of SGL support only if 4-byte aligned.
