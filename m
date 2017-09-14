Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:48563 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINPS2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 11:18:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id v66so5772564pgb.5
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2017 08:18:27 -0700 (PDT)
Date: Thu, 14 Sep 2017 08:18:22 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V4 02/14] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170914151822.GA15813@vader>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-3-ming.lei@redhat.com>
 <20170908204341.GA13673@vader.DHCP.thefacebook.com>
 <20170909093812.GE26081@ming.t460p>
 <20170910172027.GA2579@vader>
 <20170911040827.GB27079@ming.t460p>
 <20170913183720.GB30473@vader>
 <20170914015647.GA2258@ming.t460p>
 <20170914145943.GA10238@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914145943.GA10238@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 14, 2017 at 07:59:43AM -0700, Omar Sandoval wrote:

[snip]

> Honestly I prefer your original patch with a comment on depth += nr. I'd
> be happy with the following incremental patch on top of your original v4
> patch.

Oh, and the change renaming the off parameter to start would be good to
include, too.

> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 2329b9e1a0e2..8d747048ae4f 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -218,7 +218,7 @@ typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
>  
>  /**
>   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
> - * @off: Where to start the iteration
> + * @off: Where to start the iteration.
>   * @sb: Bitmap to iterate over.
>   * @fn: Callback. Should return true to continue or false to break early.
>   * @data: Pointer to pass to callback.
> @@ -230,11 +230,16 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  					  unsigned int off,
>  					  sb_for_each_fn fn, void *data)
>  {
> -	unsigned int index = SB_NR_TO_INDEX(sb, off);
> -	unsigned int nr = SB_NR_TO_BIT(sb, off);
> +	unsigned int index;
> +	unsigned int nr;
>  	unsigned int scanned = 0;
>  
> -	while (1) {
> +	if (off >= sb->depth)
> +		off = 0;
> +	index = SB_NR_TO_INDEX(sb, off);
> +	nr = SB_NR_TO_BIT(sb, off);
> +
> +	while (scanned < sb->depth) {
>  		struct sbitmap_word *word = &sb->map[index];
>  		unsigned int depth = min_t(unsigned int, word->depth - nr,
>  					   sb->depth - scanned);
> @@ -243,6 +248,11 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  		if (!word->word)
>  			goto next;
>  
> +		/*
> +		 * On the first iteration of the outer loop, we need to add the
> +		 * bit offset back to the size of the word for find_next_bit().
> +		 * On all other iterations, nr is zero, so this is a noop.
> +		 */
>  		depth += nr;
>  		off = index << sb->shift;
>  		while (1) {
> @@ -254,9 +264,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  
>  			nr++;
>  		}
> - next:
> -		if (scanned >= sb->depth)
> -			break;
> +next:
>  		nr = 0;
>  		if (++index >= sb->map_nr)
>  			index = 0;
> @@ -268,9 +276,6 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>   * @sb: Bitmap to iterate over.
>   * @fn: Callback. Should return true to continue or false to break early.
>   * @data: Pointer to pass to callback.
> - *
> - * This is inline even though it's non-trivial so that the function calls to the
> - * callback will hopefully get optimized away.
>   */
>  static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
>  					void *data)
