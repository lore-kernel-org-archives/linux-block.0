Return-Path: <jack@suse.cz>
Date: Thu, 24 Aug 2017 16:31:41 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: support IOCB_NOWAIT in generic_file_buffered_read
Message-ID: <20170824143141.GB8969@quack2.suse.cz>
References: <20170822161712.11716-1-hch@lst.de>
 <20170822161712.11716-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170822161712.11716-3-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue 22-08-17 18:17:10, Christoph Hellwig wrote:
> From: Milosz Tanski <milosz@adfin.com>
> 
> Allow generic_file_buffered_read to bail out early instead of waiting for
> the page lock or reading a page if IOCB_NOWAIT is specified.
> 
> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Acked-by: Sage Weil <sage@redhat.com>
> ---
>  mm/filemap.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4bcfa74ad802..9f60255fb7bb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1937,6 +1937,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  		page = find_get_page(mapping, index);
>  		if (!page) {
> +			if (iocb->ki_flags & IOCB_NOWAIT)
> +				goto would_block;
>  			page_cache_sync_readahead(mapping,
>  					ra, filp,
>  					index, last_index - index);

Hum, we have:

                if (!PageUptodate(page)) {
                        /*
                         * See comment in do_read_cache_page on why
                         * wait_on_page_locked is used to avoid
                         * unnecessarily
                         * serialisations and why it's safe.
                         */
                        error = wait_on_page_locked_killable(page);
                        if (unlikely(error))
                                goto readpage_error;
                        if (PageUptodate(page))
                                goto page_ok;

And wait_on_page_locked_killable() above does not seem to be handled in
your patch. I would just check IOCB_NOWAIT in !PageUptodate(page) branch
above and bail - which also removes the need for the two checks below...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
