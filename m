Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 13 Jun 2018 07:48:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 13/30] block: introduce rq_for_each_chunk()
Message-ID: <20180613144818.GD4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-14-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180609123014.8861-14-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 09, 2018 at 08:29:57PM +0800, Ming Lei wrote:
> There are still cases in which rq_for_each_chunk() is required, for
> example, loop.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/blkdev.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bca3a92eb55f..4eaba73c784a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -941,6 +941,10 @@ struct req_iterator {
>  	__rq_for_each_bio(_iter.bio, _rq)			\
>  		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
>  
> +#define rq_for_each_chunk(bvl, _rq, _iter)			\
> +	__rq_for_each_bio(_iter.bio, _rq)			\
> +		bio_for_each_chunk(bvl, _iter.bio, _iter.iter)

We have a single users of this in the loop driver.  I'd rather
see the obvious loop open coded.
