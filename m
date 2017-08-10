Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 10 Aug 2017 05:11:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 21/49] blk-merge: compute bio->bi_seg_front_size
 efficiently
Message-ID: <20170810121139.GD14607@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-22-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-22-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 04:45:20PM +0800, Ming Lei wrote:
> It is enough to check and compute bio->bi_seg_front_size just
> after the 1st segment is found, but current code checks that
> for each bvec, which is inefficient.
> 
> This patch follows the way in  __blk_recalc_rq_segments()
> for computing bio->bi_seg_front_size, and it is more efficient
> and code becomes more readable too.

As far as I can tell this doesn't depend on anything else in the
series and could be sent standalone?
