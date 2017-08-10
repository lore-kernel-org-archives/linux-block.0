Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 10 Aug 2017 05:01:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 19/49] block: implement sp version of bvec iterator
 helpers
Message-ID: <20170810120146.GB14607@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-20-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-20-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 08, 2017 at 04:45:18PM +0800, Ming Lei wrote:
> This patch implements singlepage version of the following
> 3 helpers:
> 	- bvec_iter_offset_sp()
> 	- bvec_iter_len_sp()
> 	- bvec_iter_page_sp()
> 
> So that one multipage bvec can be splited to singlepage
> bvec, and make users of current bvec iterator happy.

Please merge this into the previous patch, and keep the existing
non postfixed names for the single page version, and use
bvec_iter_segment_* for the multipage versions.
