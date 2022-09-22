Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE95C54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiIVOPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIVOPx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:15:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3FFE99B1
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:15:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E250F219B6;
        Thu, 22 Sep 2022 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663856150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpY/7VMhqgjgQjq3b0U3/5wHIlJmJCOnRDNbBs6nPgA=;
        b=f5OR5TJL6ermScrJ3ecGOwmqcsv6g/b4mCkxsMg+cQBd1n2nO5abw/8jnAU+YhanELbOol
        u7KyfMir/1aL1w6xqcFi9poBiXn6j4TUuhRbQCj9yU+aRvqj5l7Rdnn0n5iDkbIFb7cyDn
        64GPddal5i0tdI3tdPIf+jj/ePyg3Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663856150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpY/7VMhqgjgQjq3b0U3/5wHIlJmJCOnRDNbBs6nPgA=;
        b=etj2jW2lj2FIaQFes+LQ1riecrkwpvygMCWw5ofealK/kNp18t4KtxNPeCX5mWaERomQdE
        Z+jzHRZ7vAmX8WAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA90213AA5;
        Thu, 22 Sep 2022 14:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NJkdLBZuLGMpDwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 14:15:50 +0000
Date:   Thu, 22 Sep 2022 16:15:49 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] blk-cgroup: cleanup the blkg_lookup family of
 functions
Message-ID: <YyxuFZeoM9RzGad+@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:48PM +0200, Christoph Hellwig wrote:
> Add a fully inlined blkg_lookup as the extra two checks aren't going
> to generated a lot more code vs the call to the slowpath routine, and

s/generated/generate/

> open code the hint update in the two callers that care.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 38 +++++++++++++++-----------------------
>  block/blk-cgroup.h | 39 ++++++++++++---------------------------
>  2 files changed, 27 insertions(+), 50 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index b9a1dcee5a244..d1216760d0255 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -263,29 +263,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>  	return NULL;
>  }
>  
> -struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
> -				      struct request_queue *q, bool update_hint)
> +static void blkg_update_hint(struct blkcg *blkcg, struct blkcg_gq *blkg)
>  {
> -	struct blkcg_gq *blkg;
> -
> -	/*
> -	 * Hint didn't match.  Look up from the radix tree.  Note that the
> -	 * hint can only be updated under queue_lock as otherwise @blkg
> -	 * could have already been removed from blkg_tree.  The caller is
> -	 * responsible for grabbing queue_lock if @update_hint.
> -	 */
> -	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
> -	if (blkg && blkg->q == q) {
> -		if (update_hint) {
> -			lockdep_assert_held(&q->queue_lock);
> -			rcu_assign_pointer(blkcg->blkg_hint, blkg);
> -		}
> -		return blkg;
> -	}
> +	lockdep_assert_held(&blkg->q->queue_lock);
>  
> -	return NULL;
> +	if (blkcg != &blkcg_root && blkg != rcu_dereference(blkcg->blkg_hint))
> +		rcu_assign_pointer(blkcg->blkg_hint, blkg);
>  }
> -EXPORT_SYMBOL_GPL(blkg_lookup_slowpath);
>  
>  /*
>   * If @new_blkg is %NULL, this function tries to allocate a new one as
> @@ -397,9 +381,11 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  		return blkg;
>  
>  	spin_lock_irqsave(&q->queue_lock, flags);
> -	blkg = __blkg_lookup(blkcg, q, true);
> -	if (blkg)
> +	blkg = blkg_lookup(blkcg, q);
> +	if (blkg) {
> +		blkg_update_hint(blkcg, blkg);
>  		goto found;
> +	}
>  
>  	/*
>  	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
> @@ -621,12 +607,18 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
>  					  const struct blkcg_policy *pol,
>  					  struct request_queue *q)
>  {
> +	struct blkcg_gq *blkg;
> +
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  	lockdep_assert_held(&q->queue_lock);
>  
>  	if (!blkcg_policy_enabled(q, pol))
>  		return ERR_PTR(-EOPNOTSUPP);
> -	return __blkg_lookup(blkcg, q, true /* update_hint */);
> +
> +	blkg = blkg_lookup(blkcg, q);
> +	if (blkg)
> +		blkg_update_hint(blkcg, blkg);
> +	return blkg;
>  }
>  
>  /**
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 30396cad50e9a..91b7ae0773be6 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -178,8 +178,6 @@ struct blkcg_policy {
>  extern struct blkcg blkcg_root;
>  extern bool blkcg_debug_stats;
>  
> -struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
> -				      struct request_queue *q, bool update_hint);
>  int blkcg_init_queue(struct request_queue *q);
>  void blkcg_exit_queue(struct request_queue *q);
>  
> @@ -227,22 +225,21 @@ static inline bool bio_issue_as_root_blkg(struct bio *bio)
>  }
>  
>  /**
> - * __blkg_lookup - internal version of blkg_lookup()
> + * blkg_lookup - lookup blkg for the specified blkcg - q pair
>   * @blkcg: blkcg of interest
>   * @q: request_queue of interest
> - * @update_hint: whether to update lookup hint with the result or not
>   *
> - * This is internal version and shouldn't be used by policy
> - * implementations.  Looks up blkgs for the @blkcg - @q pair regardless of
> - * @q's bypass state.  If @update_hint is %true, the caller should be
> - * holding @q->queue_lock and lookup hint is updated on success.
> + * Lookup blkg for the @blkcg - @q pair.
> +
> + * Must be called in a RCU critical section.
>   */
> -static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
> -					     struct request_queue *q,
> -					     bool update_hint)
> +static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
> +					   struct request_queue *q)
>  {
>  	struct blkcg_gq *blkg;
>  
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
>  	if (blkcg == &blkcg_root)
>  		return q->root_blkg;
>  
> @@ -250,22 +247,10 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
>  	if (blkg && blkg->q == q)
>  		return blkg;
>  
> -	return blkg_lookup_slowpath(blkcg, q, update_hint);
> -}
> -
> -/**
> - * blkg_lookup - lookup blkg for the specified blkcg - q pair
> - * @blkcg: blkcg of interest
> - * @q: request_queue of interest
> - *
> - * Lookup blkg for the @blkcg - @q pair.  This function should be called
> - * under RCU read lock.
> - */
> -static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
> -					   struct request_queue *q)
> -{
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return __blkg_lookup(blkcg, q, false);
> +	blkg = radix_tree_lookup(&blkcg->blkg_tree, q->id);
> +	if (blkg && blkg->q != q)
> +		blkg = NULL;
> +	return blkg;
>  }
>  
>  /**
> -- 
> 2.30.2
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
