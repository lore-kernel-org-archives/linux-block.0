Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1539894986.81977.32.camel@acm.org>
Subject: Re: [PATCH 2/5] block: move .dma_alignment into q->limits
From: Bart Van Assche <bvanassche@acm.org>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Chinner <dchinner@redhat.com>, Linux FS Devel
 <linux-fsdevel@vger.kernel.org>, "Darrick J . Wong"
 <darrick.wong@oracle.com>, xfs@vger.kernel.org, Christoph Hellwig
 <hch@lst.de>,  Matthew Wilcox <willy@infradead.org>
Date: Thu, 18 Oct 2018 13:36:26 -0700
In-Reply-To: <20181018131817.11813-3-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
	 <20181018131817.11813-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-18 at 21:18 +-0800, Ming Lei wrote:
+AD4 Turns out q-+AD4-dma+AF8-alignement should be stack limit because now bvec table
               +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXg
               dma+AF8-alignment?
+AD4 is immutalbe, the underlying queue's dma alignment has to be perceptible
     +AF4AXgBeAF4AXgBeAF4AXgBe                                                 +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXg
     immutable?                                                observable?
+AD4 by stack driver, so IO buffer can be allocated as dma aligned before
     +AF4AXgBeAF4AXg
     stacked?

Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
