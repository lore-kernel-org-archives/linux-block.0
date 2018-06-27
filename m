Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [PATCH V7 24/24] block: document usage of bio iterator helpers
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
 <20180627124548.3456-25-ming.lei@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98d6ba9d-ec7a-b05b-94bb-e798ad0e0ea7@infradead.org>
Date: Wed, 27 Jun 2018 11:13:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180627124548.3456-25-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 06/27/2018 05:45 AM, Ming Lei wrote:
> Now multipage bvec is supported, and some helpers may return page by
> page, and some may return segment by segment, this patch documents the
> usage for helping us use them correctly.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/biovecs.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovecs.txt
> index 25689584e6e0..f63af564ae89 100644
> --- a/Documentation/block/biovecs.txt
> +++ b/Documentation/block/biovecs.txt
> @@ -117,3 +117,30 @@ Other implications:
>     size limitations and the limitations of the underlying devices. Thus
>     there's no need to define ->merge_bvec_fn() callbacks for individual block
>     drivers.
> +
> +Usage of helpers:
> +=================
> +
> +* The following helpers which name has suffix of "_all" can only be used on

                   helpers whose names have the suffix of "_all" can only be used on

> +non-BIO_CLONED bio, and ususally they are used by filesystem code, and driver

                           usually

> +shouldn't use them becasue bio may have been splitted before they got to the

                      because                   split

> +driver:
> +
> +	bio_for_each_segment_all()
> +	bio_first_bvec_all()
> +	bio_first_page_all()
> +	bio_last_bvec_all()
> +
> +* The following helpers iterate over singlepage bvec, and the local

                   preferably:          single-page

> +variable of 'struct bio_vec' or the reference records single page io

                                                                     IO or I/O

> +vector during the itearation:
> +
> +	bio_for_each_segment()
> +	bio_for_each_segment_all()
> +
> +* The following helper iterates over multipage bvec, and each bvec may

                          preferably:   multi-page

> +include multiple physically contiguous pages, and the local variable of
> +'struct bio_vec' or the reference records multi page io vector during the

                                             multi-page IO or I/O

> +itearation:
> +
> +	bio_for_each_bvec()
> 


-- 
~Randy
