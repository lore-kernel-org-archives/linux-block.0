Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [RESEND PATCH V5 33/33] block: document usage of bio iterator
 helpers
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525034621.31147-34-ming.lei@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00b2a0e5-431c-1fc3-7cc8-602148c56457@infradead.org>
Date: Fri, 25 May 2018 09:16:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180525034621.31147-34-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 05/24/2018 08:46 PM, Ming Lei wrote:
> Now multipage bvec is supported, and some helpers may return page by
> page, and some may return segment by segment, this patch documents the
> usage for helping us use them correctly.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/biovecs.txt | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovecs.txt
> index b4d238b8d9fc..32a6643caeca 100644
> --- a/Documentation/block/biovecs.txt
> +++ b/Documentation/block/biovecs.txt
> @@ -117,3 +117,35 @@ Other implications:
>     size limitations and the limitations of the underlying devices. Thus
>     there's no need to define ->merge_bvec_fn() callbacks for individual block
>     drivers.
> +
> +Usage of helpers:
> +=================
> +
> +* The following helpers which name has suffix of "_all" can only be used on

   * The following helpers, whose names have the suffix "_all", can only be used on

> +non-BIO_CLONED bio, and ususally they are used by filesystem code, and driver

                           usually

> +shouldn't use them becasue bio may have been splitted before they got to the

                      because                   split

> +driver:
> +
> +	bio_for_each_segment_all()
> +	bio_for_each_page_all()
> +	bio_pages_all()
> +	bio_first_bvec_all()
> +	bio_first_page_all()
> +	bio_last_bvec_all()
> +	segment_for_each_page_all()
> +
> +* The following helpers iterate bio page by page, and the local variable of
> +'struct bio_vec' or the reference records single page io vector during the
> +itearation:

   iteration:

> +
> +	bio_for_each_page()
> +	bio_for_each_page_all()
> +	segment_for_each_page_all()
> +
> +* The following helpers iterate bio segment by segment, and each segment may
> +include multiple physically contiguous pages, and the local variable of
> +'struct bio_vec' or the reference records multi page io vector during the
> +itearation:

   iteration:

> +
> +	bio_for_each_segment()
> +	bio_for_each_segment_all()
> 


-- 
~Randy
