Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F12C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1A86525B
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCILqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCILpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 06:45:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5EDC06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 03:45:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g4so8593411pgj.0
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sl9b/us0C0jdpcXHOmeBKnY/z8CpUYEmxoA0HRkJGCs=;
        b=tPyvuChJRrlUTV6o1eBLoop/el+ZIZ+l36l9W+juy5G+AFeYBEJty94urmN2bhRvYM
         gmhGa1qsg+Z5ozP/LF0SruB6sfIIFGp+cVkJYe70iQv8l49RXs0+ivdfaNg9EcKcsYmo
         WAVbecrHziWana5QvOKa+RT8KGp3u+dRBdUWur0wtudrhGpfUGneP9Vz/nX5QKuSSQK1
         FaCLhzUqJMaR2uAbTtUp+ykkjYrgEm13YO8Jf9B8ffsbO8d5vibr+8N4WkWemRdpNiwI
         JWXvKi3Kb/yPqxOurV+sJdCrFCVfyLB/pyvyq2HFJ/XwP6JCORhqlZXIxvngpxTz9LXh
         g6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sl9b/us0C0jdpcXHOmeBKnY/z8CpUYEmxoA0HRkJGCs=;
        b=faS2UJo5pHcA1sU1bAG5S7XGuhjSTnQIWiPD4jBTwaOqemDwLWGG+iG4edJKNfjOAR
         x6lYb1lx56+NPGVhlE8lYWcC6EcmMlUr4rZxgxNbEZ+qFASVykda0U4n+ubHOLeI36EE
         jn//2Ev2+V6bNqIIPGOiplR5wOmPXEAyracwe3tRvSFbW+4mKvOhxtANZj3pnmrBZFLj
         Or7zxvyEgeG0ljHqH4HBNE/qcWy+fyNnTbHEUhf2Qb2sTUwrHsGKnHk9TYTmZpwraT7F
         UmQRLy4oF0CRdM6JZQHXqLBmdDkBGp2KBPoUsiSJCx7pONpx4xYKMTTmpe48dYPkdgAy
         EjRw==
X-Gm-Message-State: AOAM530US0gs3y3d2kM9f5hhTsBBCgFw9FtyGDUH/Zf9uZuJX7wMbTkT
        fBapz+8qFNABUWietk8L1dPw0Q==
X-Google-Smtp-Source: ABdhPJz6MrnnoCyvgci+UWqV8dD5wlkg6JLQmfVwo3Z1QLe4jbhSP53q9Vi0HyHDSYPVyUCGxvOs2w==
X-Received: by 2002:aa7:99c4:0:b029:1f6:c0bf:43d1 with SMTP id v4-20020aa799c40000b02901f6c0bf43d1mr3190310pfi.37.1615290350850;
        Tue, 09 Mar 2021 03:45:50 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id il6sm2536154pjb.56.2021.03.09.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 03:45:50 -0800 (PST)
Date:   Tue, 9 Mar 2021 11:45:46 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: keyslot-manager: fix error return code of
 blk_ksm_evict_key()
Message-ID: <YEdf6utvWih7mToY@google.com>
References: <20210309091812.26029-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309091812.26029-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 09, 2021 at 01:18:12AM -0800, Jia-Ju Bai wrote:
> When blk_ksm_find_keyslot() returns NULL to slot, no error return code
> of blk_ksm_evict_key() is assigned.
> To fix this bug, err is assigned with -ENOENT in this case.
> 
> Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  block/keyslot-manager.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 2c4a55bea6ca..4dd5da0645bc 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -375,8 +375,10 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
>  
>  	blk_ksm_hw_enter(ksm);
>  	slot = blk_ksm_find_keyslot(ksm, key);
> -	if (!slot)
> +	if (!slot) {
> +		err = -ENOENT;
>  		goto out_unlock;
> +	}
>  
>  	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
>  		err = -EBUSY;
> -- 
> 2.17.1
> 
This function was deliberately designed to return 0 on success *and also*
if there's no keyslot found with the specified key - i.e. it returns 0 if
the key is no longer programmed into the keyslot manager, which is what the
callers care about, so I don't think there's a bug here.

Also if we were to apply this patch, we'd also need to change the callers
to handle this new -ENOENT case (and not treat it as an error/not propogate
-ENOENT in e.g. dm_keyslot_evict_callback()).

Is there a reason we want to change the behaviour of this function?
