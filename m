Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 10 Aug 2017 05:11:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 20/49] block: introduce bio_for_each_segment_mp()
Message-ID: <20170810121110.GC14607@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-21-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-21-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

First: as mentioned in the previous patches I really hate the name
scheme with the _sp and _mp postfixes.

To be clear and understandable we should always name the versions
that iterate over segments *segment* and the ones that iterate over
pages *page*.  To make sure we have a clean compile break for code
using the old _segment name I'd suggest to move to pass the bvec_iter
argument by reference, which is the right thing to do anyway.

As far as the implementation goes I don't think we actually need
to pass the mp argument down.  Instead we always call the full-segment
version of  bvec_iter_len / __bvec_iter_advance and then have an
inner loop that moves the fake bvecs forward inside each full-segment
one - that is implement the per-page version on top of the per-segment
one.
