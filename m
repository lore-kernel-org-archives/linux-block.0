Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB45C10F14
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8333E2086A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571155432;
	bh=M9kXklKQtDuIvjGPM+103N6ZWmJrDyymrDVn0xJ8W+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ky9BQvpDSbnMMRl+dLn2G1v7lH/WVAY0dJtKzNwLgosM5hK1uP64H0DL+NLZ8y2dP
	 0d0hCE6TjNgXo1Ah1qt+QR//Rnv9Gcn/HSZVCrAVBngS6pTR02rOvZXDUlOSB29bLX
	 MF81LrwzHa+OtJ00R1BIazw8vUn7ECW6V6gLsyJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfJOQDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:03:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43963 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbfJOQDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 12:03:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so19658046qke.10;
        Tue, 15 Oct 2019 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMyf6ZXYS8qjB9onybnxryGH4tAciA0KjRR6DT1/pjY=;
        b=BNQrpDQFWulDLr2mX3ppadrcwlzELRfgirbxAAC+JB7I1Yyf3jL7eRuGETyXp4YTTm
         4adEtoakHhDftsOCU4xa+bbbd8YGAMoXPIwfqLPDB9HTACL+gxB+82CIGZv+3Y2fbLT8
         xYB7VMR3vmL3UrN7FHXCg06roe2KZYyQS40y7NEFhVHF1E8oFLZdEEyxypQt7XRtdj4V
         0d03XKkgKwuEqrHqssUDDmvs6Y2muLFGxCEzhYA8b58dPH6PGtT3METm9rOGvT6u5xxR
         2dktkIUhBhsT7btT0vMC74xlArltkS9oA8VXmpQlMQBh4CH4yjiy7MCNO97TbA5E7gpW
         ooQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMyf6ZXYS8qjB9onybnxryGH4tAciA0KjRR6DT1/pjY=;
        b=Rv/Hlanpj8PX9bQVzDRSUDQPKvufsRRG/Sjjv4VHpMLyprOECjc2I8RgYKgPnYE76V
         j3i3ChQbSFXzkmyPKhAQR+EVSYmwHakWHoTUOnM+Nu03E+Kw+lah0MFXEK1Se62Tcvci
         koy/xWBZ/A4+y5cHvWnP85EgbfPALSJf7Z5VcImZIPr8Fo0DfwASjDPjDmEyI1yfP9ys
         EQOotnkhIou+GlcvQzO/oxdBtPHIPyVW04PguyVACAdUdQC/OqHds2zwGRdexI5Q5wg1
         +zF6SzbjNOC71TgehPlqNYcGtuUGU03XNEzxVZzcMxtqcvNakIDZG4qkgtG5CpfQq2PR
         FOSA==
X-Gm-Message-State: APjAAAWTshMTiPyWjgRUZIzBrPphILa1yFdPqYT8MOPat+xNE/opHBj2
        KTP00vOXPriUV4LEt9eoZjbaZcbs
X-Google-Smtp-Source: APXvYqxV/kTCSy/+mAr7w00KVvG6wQC5YatNY/DStqjTAArZLZ1d4wdaVOXnBdiPmH0K8LwKb13xPA==
X-Received: by 2002:a05:620a:21dc:: with SMTP id h28mr13419840qka.48.1571155429679;
        Tue, 15 Oct 2019 09:03:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2a53])
        by smtp.gmail.com with ESMTPSA id n17sm10576897qke.103.2019.10.15.09.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:03:49 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:03:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org
Subject: [PATCH block/for-linus] blkcg: Fix multiple bugs in
 blkcg_activate_policy()
Message-ID: <20191015160347.GM18794@devbig004.ftw2.facebook.com>
References: <alpine.DEB.2.21.1910151232480.2818@hadrien>
 <20191015154827.GK18794@devbig004.ftw2.facebook.com>
 <07cbc404-65db-b236-9ae2-558197b8cdb6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07cbc404-65db-b236-9ae2-558197b8cdb6@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg_activate_policy() has the following bugs.

* cf09a8ee19ad ("blkcg: pass @q and @blkcg into
  blkcg_pol_alloc_pd_fn()") added @blkcg to ->pd_alloc_fn(); however,
  blkcg_activate_policy() ends up using pd's allocated for the root
  blkcg for all preallocations, so ->pd_init_fn() for non-root blkcgs
  can be passed in pd's which are allocated for the root blkcg.

  For blk-iocost, this means that ->pd_init_fn() can write beyond the
  end of the allocated object as it determines the length of the flex
  array at the end based on the blkcg's nesting level.

* Each pd is initialized as they get allocated.  If alloc fails, the
  policy will get freed with pd's initialized on it.

* After the above partial failure, the partial pds are not freed.

This patch fixes all the above issues by

* Restructuring blkcg_activate_policy() so that alloc and init passes
  are separate.  Init takes place only after all allocs succeeded and
  on failure all allocated pds are freed.

* Unifying and fixing the cleanup of the remaining pd_prealloc.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: cf09a8ee19ad ("blkcg: pass @q and @blkcg into blkcg_pol_alloc_pd_fn()")
---
 block/blk-cgroup.c |   69 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 18 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1362,7 +1362,7 @@ int blkcg_activate_policy(struct request
 			  const struct blkcg_policy *pol)
 {
 	struct blkg_policy_data *pd_prealloc = NULL;
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg, *pinned_blkg = NULL;
 	int ret;
 
 	if (blkcg_policy_enabled(q, pol))
@@ -1370,49 +1370,82 @@ int blkcg_activate_policy(struct request
 
 	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
-pd_prealloc:
-	if (!pd_prealloc) {
-		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q, &blkcg_root);
-		if (!pd_prealloc) {
-			ret = -ENOMEM;
-			goto out_bypass_end;
-		}
-	}
-
+retry:
 	spin_lock_irq(&q->queue_lock);
 
-	/* blkg_list is pushed at the head, reverse walk to init parents first */
+	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q, &blkcg_root);
-		if (!pd)
-			swap(pd, pd_prealloc);
+		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
+		if (blkg == pinned_blkg) {
+			pd = pd_prealloc;
+			pd_prealloc = NULL;
+		} else {
+			pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q,
+					      blkg->blkcg);
+		}
+
 		if (!pd) {
+			/*
+			 * GFP_NOWAIT failed.  Free the existing one and
+			 * prealloc for @blkg w/ GFP_KERNEL.
+			 */
+			if (pinned_blkg)
+				blkg_put(pinned_blkg);
+			blkg_get(blkg);
+			pinned_blkg = blkg;
+
 			spin_unlock_irq(&q->queue_lock);
-			goto pd_prealloc;
+
+			if (pd_prealloc)
+				pol->pd_free_fn(pd_prealloc);
+			pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q,
+						       blkg->blkcg);
+			if (pd_prealloc)
+				goto retry;
+			else
+				goto enomem;
 		}
 
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		if (pol->pd_init_fn)
-			pol->pd_init_fn(pd);
 	}
 
+	/* all allocated, init in the same order */
+	if (pol->pd_init_fn)
+		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+			pol->pd_init_fn(blkg->pd[pol->plid]);
+
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
 	spin_unlock_irq(&q->queue_lock);
-out_bypass_end:
+out:
 	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
+	if (pinned_blkg)
+		blkg_put(pinned_blkg);
 	if (pd_prealloc)
 		pol->pd_free_fn(pd_prealloc);
 	return ret;
+
+enomem:
+	/* alloc failed, nothing's initialized yet, free everything */
+	spin_lock_irq(&q->queue_lock);
+	list_for_each_entry(blkg, &q->blkg_list, q_node) {
+		if (blkg->pd[pol->plid]) {
+			pol->pd_free_fn(blkg->pd[pol->plid]);
+			blkg->pd[pol->plid] = NULL;
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
+	ret = -ENOMEM;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
 
