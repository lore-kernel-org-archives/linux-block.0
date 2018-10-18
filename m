Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1539877834.36349.14.camel@acm.org>
Subject: Re: [PATCH 0/5] block: introduce helpers for allocating io buffer
 from slab
From: Bart Van Assche <bvanassche@acm.org>
To: Matthew Wilcox <willy@infradead.org>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Dave Chinner <dchinner@redhat.com>, Linux
 FS Devel <linux-fsdevel@vger.kernel.org>, "Darrick J . Wong"
 <darrick.wong@oracle.com>,  xfs@vger.kernel.org, Christoph Hellwig
 <hch@lst.de>
Date: Thu, 18 Oct 2018 08:50:34 -0700
In-Reply-To: <20181018140342.GB32429@bombadil.infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
	 <20181018140342.GB32429@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-18 at 07:03 -0700, Matthew Wilcox wrote:
+AD4 On Thu, Oct 18, 2018 at 09:18:12PM +-0800, Ming Lei wrote:
+AD4 +AD4 Filesystems may allocate io buffer from slab, and use this buffer to
+AD4 +AD4 submit bio. This way may break storage drivers if they have special
+AD4 +AD4 requirement on DMA alignment.
+AD4 
+AD4 Before we go down this road, could we have a discussion about what
+AD4 hardware actually requires this?  Storage has this weird assumption that
+AD4 I/Os must be at least 512 byte aligned in memory, and I don't know where
+AD4 this idea comes from.  Network devices can do arbitrary byte alignment.
+AD4 Even USB controllers can do arbitrary byte alignment.  Sure, performance
+AD4 is going to suck and there are definite risks on some architectures
+AD4 with doing IOs that are sub-cacheline aligned, but why is storage such a
+AD4 special snowflake that we assume that host controllers are only capable
+AD4 of doing 512-byte aligned DMAs?
+AD4 
+AD4 I just dragged out the NCR53c810 data sheet from 1993, and it's capable of
+AD4 doing arbitrary alignment of DMA.  NVMe is capable of 4-byte aligned DMA.
+AD4 What hardware needs this 512 byte alignment?

How about starting with modifying the queue+AF8-dma+AF8-alignment() function? The
current implementation of that function is as follows:

static inline int queue+AF8-dma+AF8-alignment(struct request+AF8-queue +ACo-q)
+AHs
	return q ? q-+AD4-dma+AF8-alignment : 511+ADs
+AH0

In other words, for block drivers that do not set the DMA alignment
explicitly it is assumed that these drivers need 512 byte alignment. I think
the +ACI-512 byte alignment as default+ACI was introduced in 2002. From Thomas
Gleixner's history tree, commit ad519c6902fb:

+-static inline int queue+AF8-dma+AF8-alignment(request+AF8-queue+AF8-t +ACo-q)
+-+AHs
+-       int retval +AD0 511+ADs
+-
+-       if (q +ACYAJg q-+AD4-dma+AF8-alignment)
+-               retval +AD0 q-+AD4-dma+AF8-alignment+ADs
+-
+-       return retval+ADs
+-+AH0
+-
+-static inline int bdev+AF8-dma+AF8-aligment(struct block+AF8-device +ACo-bdev)
+-+AHs
+-       return queue+AF8-dma+AF8-alignment(bdev+AF8-get+AF8-queue(bdev))+ADs
+-+AH0
+-

Bart.
