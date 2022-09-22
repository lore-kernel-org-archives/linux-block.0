Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD82BC54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiIVOQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiIVOQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C2F08BC
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:16:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A63852197E;
        Thu, 22 Sep 2022 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663856190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQfmjxow22E9ErucqnIRe3m8H7/+7GKXTXRnb9gkKro=;
        b=WyQrdb6nDHNd5W7Pk8Jlc9MKE2mxxwS2GGd6fNGFH8XYyqMezyOGbW+9+F3JbVdJ7vavO+
        PVs3T38y3rlvyPXCECk87jYVf7wJUSvtnp4+NiYPWWI1gsIfZSZxXZaFttqKwFl0Xs3rwc
        LWIEc1X4YEFCty3jV0BSU70kVmWiZM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663856190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQfmjxow22E9ErucqnIRe3m8H7/+7GKXTXRnb9gkKro=;
        b=6QtNHboQUaJmR5cGpIg/vmjN0c0wJBjanyB20Ju+Sgf7JZeC/q007xyXqH9YgYuh/Wn3mR
        Tqe861K7u6H3U+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EDC413AA5;
        Thu, 22 Sep 2022 14:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GZqiHT5uLGOgDwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 14:16:30 +0000
Date:   Thu, 22 Sep 2022 16:16:29 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/17] blk-cgroup: remove blkg_lookup_check
Message-ID: <YyxuPeXuThDhyLjG@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:49PM +0200, Christoph Hellwig wrote:
> The combinations of an error check with an ERR_PTR return and a lookup
> with a NULL return leads to ugly handling of the return values in the
> callers.  Just open coding the check and the lookup is much simpler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 36 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d1216760d0255..1306112d76486 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -602,25 +602,6 @@ u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
>  }
>  EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
>  
> -/* Performs queue bypass and policy enabled checks then looks up blkg. */
> -static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
> -					  const struct blkcg_policy *pol,
> -					  struct request_queue *q)
> -{
> -	struct blkcg_gq *blkg;
> -
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -	lockdep_assert_held(&q->queue_lock);
> -
> -	if (!blkcg_policy_enabled(q, pol))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
> -	blkg = blkg_lookup(blkcg, q);
> -	if (blkg)
> -		blkg_update_hint(blkcg, blkg);
> -	return blkg;
> -}
> -
>  /**
>   * blkcg_conf_open_bdev - parse and open bdev for per-blkg config update
>   * @inputp: input string pointer
> @@ -697,14 +678,16 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	rcu_read_lock();
>  	spin_lock_irq(&q->queue_lock);
>  
> -	blkg = blkg_lookup_check(blkcg, pol, q);
> -	if (IS_ERR(blkg)) {
> -		ret = PTR_ERR(blkg);
> +	if (!blkcg_policy_enabled(q, pol)) {
> +		ret = -EOPNOTSUPP;
>  		goto fail_unlock;
>  	}
>  
> -	if (blkg)
> +	blkg = blkg_lookup(blkcg, q);
> +	if (blkg) {
> +		blkg_update_hint(blkcg, blkg);
>  		goto success;
> +	}
>  
>  	/*
>  	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
> @@ -740,14 +723,15 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		rcu_read_lock();
>  		spin_lock_irq(&q->queue_lock);
>  
> -		blkg = blkg_lookup_check(pos, pol, q);
> -		if (IS_ERR(blkg)) {
> -			ret = PTR_ERR(blkg);
> +		if (!blkcg_policy_enabled(q, pol)) {
>  			blkg_free(new_blkg);
> +			ret = -EOPNOTSUPP;
>  			goto fail_preloaded;
>  		}
>  
> +		blkg = blkg_lookup(pos, q);
>  		if (blkg) {
> +			blkg_update_hint(pos, blkg);
>  			blkg_free(new_blkg);
>  		} else {
>  			blkg = blkg_create(pos, q, new_blkg);
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
