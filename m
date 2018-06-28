Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 08:08:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Simplify the bio cloning implementation
Message-ID: <20180628000846.GF7583@ming.t460p>
References: <20180626222624.11739-1-bart.vanassche@wdc.com>
 <20180627011259.GC9970@ming.t460p>
 <5766ea06-4016-6ad1-a18a-b2c9f31788cf@wdc.com>
 <20180627232039.GA7583@ming.t460p>
 <6d9bb0d0-52fd-8f16-6443-dcd8867bdb7c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d9bb0d0-52fd-8f16-6443-dcd8867bdb7c@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 04:55:20PM -0700, Bart Van Assche wrote:
> On 06/27/18 16:21, Ming Lei wrote:
> > What we need to do is to only copy the 1st bvec for WRITE_SAME, your patch
> > changes to copy (bio->bi_iter.bi_size / block size) bvecs, then memory corruption
> > may be triggered. So bio_for_each_segment() can't be used here.
> 
> Has it been considered to use memcpy() to copy the bi_vcnt bio_vecs instead
> of using bio_for_each_segment() in bio_clone_bioset()? That will in this
> context probably be even faster than using bio_for_each_segment().

After immutable bvec is introduced:

1) there is little chance in which bvec table need to copy, so performance
may not be a issue, as you see, bio_clone_bioset() is going to die now.

2) bi_vcnt/bi_io_vec can't be used directly on fast-cloned bio

2) code is simplified a lot by using iterator helper since bio can be
advanced in unit of byte. In theory, we may cook a special helper to
speed up the copy, but still depends on use cases.

thanks,
Ming
