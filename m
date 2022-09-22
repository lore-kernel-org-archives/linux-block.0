Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B917BC54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIVNRt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVNRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:17:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05EECCC5
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:17:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B1C121A32;
        Thu, 22 Sep 2022 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663852634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxjEygI40tr227FCk8ln4tWPYDPY4XgfCiHVMgxdG4M=;
        b=lRdYpb+NjsPqA7l956iO21YAueSReep+aD5Q7EhY31V+i8xK1doOL65BHRV6uKcQqSlmEW
        r/w7wrI3HfhPlp2VzrmWOH23SEgZPjFW9+ueW3iRlg1IOL4nQaRFdL+VDYjzvOtEiIa9m/
        hdG7bUTPzKu3d4GKw5fNLSahi/svezE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663852634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxjEygI40tr227FCk8ln4tWPYDPY4XgfCiHVMgxdG4M=;
        b=oFYJTCRYhdcN1xeSE08vHrgkv8ibIcDfXCUxDyagBqvtU8AEAshEi4kVVpE3NJ0xpLcaSJ
        Qgso0xhtTNyodiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B971346B;
        Thu, 22 Sep 2022 13:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0MAJE1pgLGPZcQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:17:14 +0000
Date:   Thu, 22 Sep 2022 15:17:12 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 03/17] blk-cgroup: remove open coded blkg_lookup instances
Message-ID: <YyxgWIbTbonF3QPP@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:47PM +0200, Christoph Hellwig wrote:
> Use blkg_lookup instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 6 +++---
>  block/blk-cgroup.h | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 4180de4cbb3e1..b9a1dcee5a244 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -324,7 +324,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  
>  	/* link parent */
>  	if (blkcg_parent(blkcg)) {
> -		blkg->parent = __blkg_lookup(blkcg_parent(blkcg), q, false);
> +		blkg->parent = blkg_lookup(blkcg_parent(blkcg), q);
>  		if (WARN_ON_ONCE(!blkg->parent)) {
>  			ret = -ENODEV;
>  			goto err_put_css;
> @@ -412,7 +412,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  		struct blkcg_gq *ret_blkg = q->root_blkg;
>  
>  		while (parent) {
> -			blkg = __blkg_lookup(parent, q, false);
> +			blkg = blkg_lookup(parent, q);
>  			if (blkg) {
>  				/* remember closest blkg */
>  				ret_blkg = blkg;
> @@ -724,7 +724,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		struct blkcg_gq *new_blkg;
>  
>  		parent = blkcg_parent(blkcg);
> -		while (parent && !__blkg_lookup(parent, q, false)) {
> +		while (parent && !blkg_lookup(parent, q)) {
>  			pos = parent;
>  			parent = blkcg_parent(parent);
>  		}
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index c1fb00a1dfc03..30396cad50e9a 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -362,8 +362,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>   */
>  #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
> -		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
> -					      (p_blkg)->q, false)))
> +		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> +					    (p_blkg)->q)))
>  
>  /**
>   * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
> @@ -377,8 +377,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
>   */
>  #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
>  	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
> -		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
> -					      (p_blkg)->q, false)))
> +		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
> +					    (p_blkg)->q)))
>  
>  bool __blkcg_punt_bio_submit(struct bio *bio);
>  
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
