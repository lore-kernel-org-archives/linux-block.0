Return-Path: <BATV+d7add8a7bef99f8e6f52+4817+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 31 Oct 2016 08:39:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Mike Christie <mchristi@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 28/60] block: introduce QUEUE_FLAG_SPLIT_MP
Message-ID: <20161031153915.GL30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-29-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-29-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 29, 2016 at 04:08:27PM +0800, Ming Lei wrote:
> Some drivers(such as dm) should be capable of dealing with multipage
> bvec, but the incoming bio may be too big, such as, a new singlepage bvec
> bio can't be cloned from the bio, or can't be allocated to singlepage
> bvec with same size.
> 
> At least crypt dm, log writes and bcache have this kind of issue.

We already have the segment_size limitation for request based drivers.
I'd rather extent it to bio drivers if really needed.

But then again we should look into not having this limitation.  E.g.
for bcache I'd be really surprised if it's that limited, given that
Kent came up with this whole multipage bvec scheme.
