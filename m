Return-Path: <axboe@kernel.dk>
Date: Sat, 6 Jan 2018 09:19:11 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH V4 15/45] block: rename bio_for_each_segment* with
 bio_for_each_page*
Message-ID: <20180106161909.GA6343@kernel.dk>
References: <20171218122247.3488-1-ming.lei@redhat.com>
 <20171218122247.3488-16-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218122247.3488-16-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Dec 18 2017, Ming Lei wrote:
> It is a tree-wide mechanical replacement since both bio_for_each_segment()
> and bio_for_each_segment_all() never returns real segment at all, and
> both just return one page per bvec and deceive us for long time, so fix
> their names.
> 
> This is a pre-patch for supporting multipage bvec. Once multipage bvec
> is in, each bvec will store a real multipage segment, so people won't be
> confused with these wrong names.

No, we're not doing this, it's a pretty pointless tree wide replacement
with a fairly weak justification.

-- 
Jens Axboe
