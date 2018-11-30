Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A765C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F3F2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Yz2C2dPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F3F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLAHNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:13:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45692 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAHNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:13:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so3307531pfd.12
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+c5VFPvunG02QlMYJxePIp5kXylxUS7nYV6dPMRKuE=;
        b=Yz2C2dPS6K3PzDWHGDrlg/6YCShAd5U7Tl3WB0dW95t8IrxXBUpPSjNQbEXPLIgCBN
         +RP4rmvAafJ/97ztenErAyu/se3gRt/YNAEWsytPCteGWP9dPsEDfcMQAkY+JX+hzP2u
         lP3/gpAQrFz+JBb5MJ0gJ4l9aM8xYgtS7k74VsOblkMH1Y+7ViH94f87lv8zzzBlmkX6
         6V+9xLsfc3U2m2ue7CIJzVLuqjTVVBOQcKV2ylKDIK+6GAWx4bGCA8cJ71yV114SOrIF
         tkbUlBmG9ZudzKinKPxixzPy6UsveXveRWGLN02m1WP96eQOmVIuM7cbaLNfJEcM152D
         sB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+c5VFPvunG02QlMYJxePIp5kXylxUS7nYV6dPMRKuE=;
        b=Uy5phMMpP7SYkB2HWx3FuU/OMC8DjQGh3dHweyU3Lj+cPMgLb8PEMizakx26KAqp7L
         5mPdpAmg4YkKq3taNv40qNf4QMFP+e2wNjECz5D+dcHBnmB23jyEaeYeDWfXaWe1wD41
         lk04yzU5D4U0HW9B8r2TopQtWskA1/zr8GZDYji5jMNa+XuF+Fzokn0BlaP/VuwCxeek
         kvEAMPL0FLIL1JaIXrX7HL8EqLlbTNsygk6zamhvZXrsgNM/pHX88UkkxfmsfbxaPBKG
         VBA6K8uuyc66mS6g9j2KAcGvSWu+5Nc2Kt0LbZDM1knKA0b6/o+h39Jont2+xPwRLHks
         adhw==
X-Gm-Message-State: AA+aEWa3HtGfRHDOAZmVgibwyTJqodJ+YHQYcktZs5NGMA5F6Moa94Gd
        Ys0cy8qEUkIAthh3YMzn47Fr4Q==
X-Google-Smtp-Source: AFSGD/VItq/dnDpMBMYxVwCC0KaGNnSBV12sPB+9E+clkniOHOoVcDt5OSe+59FZOnGzyNewxGdL6A==
X-Received: by 2002:a63:e545:: with SMTP id z5mr5901695pgj.195.1543608189950;
        Fri, 30 Nov 2018 12:03:09 -0800 (PST)
Received: from vader ([2620:10d:c090:200::4:705d])
        by smtp.gmail.com with ESMTPSA id k191sm7283368pgd.9.2018.11.30.12.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 12:03:09 -0800 (PST)
Date:   Fri, 30 Nov 2018 12:03:08 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] sbitmap: ammortize cost of clearing bits
Message-ID: <20181130200308.GB27411@vader>
References: <20181130160118.24683-1-axboe@kernel.dk>
 <20181130160118.24683-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130160118.24683-2-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 09:01:17AM -0700, Jens Axboe wrote:
> sbitmap maintains a set of words that we use to set and clear bits, with
> each bit representing a tag for blk-mq. Even though we spread the bits
> out and maintain a hint cache, one particular bit allocated will end up
> being cleared in the exact same spot.
> 
> This introduces batched clearing of bits. Instead of clearing a given
> bit, the same bit is set in a cleared/free mask instead. If we fail
> allocating a bit from a given word, then we check the free mask, and
> batch move those cleared bits at that time. This trades 64 atomic bitops
> for 2 cmpxchg().
> 
> In a threaded poll test case, half the overhead of getting and clearing
> tags is removed with this change. On another poll test case with a
> single thread, performance is unchanged.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/sbitmap.h | 31 +++++++++++++---
>  lib/sbitmap.c           | 80 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 100 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 804a50983ec5..07f117ee19dc 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -30,14 +30,24 @@ struct seq_file;
>   */
>  struct sbitmap_word {
>  	/**
> -	 * @word: The bitmap word itself.
> +	 * @depth: Number of bits being used in @word/@cleared
>  	 */
> -	unsigned long word;
> +	unsigned long depth;
>  
>  	/**
> -	 * @depth: Number of bits being used in @word.
> +	 * @word: word holding free bits
>  	 */
> -	unsigned long depth;
> +	unsigned long word ____cacheline_aligned_in_smp;

Still splitting up word and depth in separate cachelines?

> +	/**
> +	 * @cleared: word holding cleared bits
> +	 */
> +	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_lock: Held while swapping word <-> cleared
> +	 */
> +	spinlock_t swap_lock;
>  } ____cacheline_aligned_in_smp;
>  
>  /**
> @@ -310,6 +320,19 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
>  	clear_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
>  }
>  
> +/*
> + * This one is special, since it doesn't actually clear the bit, rather it
> + * sets the corresponding bit in the ->cleared mask instead. Paired with
> + * the caller doing sbitmap_batch_clear() if a given index is full, which
> + * will clear the previously freed entries in the corresponding ->word.
> + */
> +static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
> +{
> +	unsigned long *addr = &sb->map[SB_NR_TO_INDEX(sb, bitnr)].cleared;
> +
> +	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
> +}
> +
>  static inline void sbitmap_clear_bit_unlock(struct sbitmap *sb,
>  					    unsigned int bitnr)
>  {
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 45cab6bbc1c7..f6a9553617bd 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -59,6 +59,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>  	for (i = 0; i < sb->map_nr; i++) {
>  		sb->map[i].depth = min(depth, bits_per_word);
>  		depth -= sb->map[i].depth;
> +		spin_lock_init(&sb->map[i].swap_lock);
>  	}
>  	return 0;
>  }
> @@ -111,6 +112,57 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  	return nr;
>  }
>  
> +/*
> + * See if we have deferred clears that we can batch move
> + */
> +static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> +{
> +	unsigned long mask, val;
> +	bool ret = false;
> +
> +	spin_lock(&sb->map[index].swap_lock);
> +
> +	if (!sb->map[index].cleared)
> +		goto out_unlock;
> +
> +	/*
> +	 * First get a stable cleared mask, setting the old mask to 0.
> +	 */
> +	do {
> +		mask = sb->map[index].cleared;
> +	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
> +
> +	/*
> +	 * Now clear the masked bits in our free word
> +	 */
> +	do {
> +		val = sb->map[index].word;
> +	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
> +
> +	ret = true;
> +out_unlock:
> +	spin_unlock(&sb->map[index].swap_lock);
> +	return ret;
> +}

Okay, I couldn't find any holes in this one :)

> +static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
> +				     unsigned int alloc_hint, bool round_robin)
> +{
> +	int nr;
> +
> +	do {
> +		nr = __sbitmap_get_word(&sb->map[index].word,
> +					sb->map[index].depth, alloc_hint,
> +					!round_robin);
> +		if (nr != -1)
> +			break;
> +		if (!sbitmap_deferred_clear(sb, index))
> +			break;
> +	} while (1);
> +
> +	return nr;
> +}
> +
>  int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  {
>  	unsigned int i, index;
> @@ -129,9 +181,8 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  		alloc_hint = 0;
>  
>  	for (i = 0; i < sb->map_nr; i++) {
> -		nr = __sbitmap_get_word(&sb->map[index].word,
> -					sb->map[index].depth, alloc_hint,
> -					!round_robin);
> +		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint,
> +						round_robin);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
>  			break;
> @@ -206,23 +257,37 @@ bool sbitmap_any_bit_clear(const struct sbitmap *sb)
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
>  
> -unsigned int sbitmap_weight(const struct sbitmap *sb)
> +static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
>  {
>  	unsigned int i, weight = 0;
>  
>  	for (i = 0; i < sb->map_nr; i++) {
>  		const struct sbitmap_word *word = &sb->map[i];
>  
> -		weight += bitmap_weight(&word->word, word->depth);
> +		if (set)
> +			weight += bitmap_weight(&word->word, word->depth);

Should probably do
			weight -= bitmap_weight(&word->cleared, word->depth);

too, right?

> +		else
> +			weight += bitmap_weight(&word->cleared, word->depth);
>  	}
>  	return weight;
>  }
> +
> +unsigned int sbitmap_weight(const struct sbitmap *sb)
> +{
> +	return __sbitmap_weight(sb, true);
> +}
>  EXPORT_SYMBOL_GPL(sbitmap_weight);
>  
> +static unsigned int sbitmap_cleared(const struct sbitmap *sb)
> +{
> +	return __sbitmap_weight(sb, false);
> +}
> +
>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
>  {
>  	seq_printf(m, "depth=%u\n", sb->depth);
> -	seq_printf(m, "busy=%u\n", sbitmap_weight(sb));
> +	seq_printf(m, "busy=%u\n", sbitmap_weight(sb) - sbitmap_cleared(sb));
> +	seq_printf(m, "cleared=%u\n", sbitmap_cleared(sb));
>  	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
>  	seq_printf(m, "map_nr=%u\n", sb->map_nr);
>  }
> @@ -514,7 +579,8 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>  void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>  			 unsigned int cpu)
>  {
> -	sbitmap_clear_bit_unlock(&sbq->sb, nr);
> +	sbitmap_deferred_clear_bit(&sbq->sb, nr);
> +
>  	/*
>  	 * Pairs with the memory barrier in set_current_state() to ensure the
>  	 * proper ordering of clear_bit_unlock()/waitqueue_active() in the waker
> -- 
> 2.17.1
> 
