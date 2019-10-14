Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598CECE58C
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA32067B
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571079032;
	bh=Cww9TSGnod9F0B8ddeqxqDczdSVLgo2BUsAISizOWdc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OU5g7s2PAoWnNL7cQLiEVfytKI6tsDaUIyoHtbxtKesUjpdcJTzNEjib19E7qDDVu
	 wN1xIXoJaz+l0CwuvXsb+K1KXnQrACV1Kh3zA+e7JDewaFxEAG3+fO8KPQJlr3aEwd
	 qCoYJEIJ9XRJ/huqwUWchkhut0Umnem6oh0+2xdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfJNSub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:50:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38859 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731149AbfJNSub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 14:50:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id x4so12892210qkx.5;
        Mon, 14 Oct 2019 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g7fjAjGpffs0qGSw9Zw3h1P0ZmgciCK8ISjc2ELqOLg=;
        b=WsXD7B71URX9qt4oD4s6S/P9sc9RIDXUOS+UTtspwA9XTg84YaEr62+DyRQ2dReZCB
         n/HOl4vdlE3iv19wa8V7GPUzYor5FSGvmOwztw7nhKsdpSp25l7Aexm/dfL2TjKet5Cu
         epndsDNQxK3IDLmpuwnirZ3r9+RqElg8tkajtb2sz1XJ3Clx5E0Qju+Jqu60bzkyG8ta
         8HsV7bw7FdnHgrovk1vEcrsXPxk1m/WBoHpqOgsC6+m32mE97aq0AATcNzFCef3ci5+X
         pjNiy63NxGcvNWjPWyNm3d41isW8sGvzflmErSh1Kj+acqzCexP0MjEDkb/ajpPzxpJZ
         hBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=g7fjAjGpffs0qGSw9Zw3h1P0ZmgciCK8ISjc2ELqOLg=;
        b=ENiWYFi549wrxgR9cuYqEAmy/KyD9UiOIwDgYFl2z6hxyUGImizlbvpfXlLmhoGgqQ
         Q+p6kxCQgmKuVOoMd4s/ECoo0/aMLJvLUI7YzhZ7SwJBsn4bmeFFrni6O4hzL7IkY6If
         ivmv9Mf2RMtYnt8Cmgtu1PheAOhTkfV71PwdS73EQ15If6M9Q4C7ZuFiUa3k4sI3YC79
         66EQsO7C+ujOv4Sl1gF3D0uTVgEu8Sf8c4ex1h3SLFIPu9sLPVhm3Tnt3DsPCvzTNRK5
         TQg228mH5S0HMnUCvlNMci00BrlNS/iUiFd/nmfP7qSg+SC2eb6+X/J/JAiBJ+duFJsR
         8ikw==
X-Gm-Message-State: APjAAAU4CKGo1esRXPQvmsjvt2Nz2o8Qp7kDyQQr6HZN35DPtRF0XBl2
        D5y/NI/z5QTGK/ZadKmNRZI=
X-Google-Smtp-Source: APXvYqy5v/TfqVTrr+295J1rYjdEA234Qb9cUqmLvA7SrOLplSjEa52K/hLt6pYX8OgqwI85KOQPZQ==
X-Received: by 2002:a37:bd03:: with SMTP id n3mr713929qkf.52.1571079030181;
        Mon, 14 Oct 2019 11:50:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:50c5])
        by smtp.gmail.com with ESMTPSA id y22sm9355501qka.59.2019.10.14.11.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:50:29 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:50:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, newella@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH block/for-linus] blkcg: Fix ->pd_alloc_fn() being called with
 the wrong blkcg on policy activation
Message-ID: <20191014185027.GH18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cf09a8ee19ad ("blkcg: pass @q and @blkcg into
blkcg_pol_alloc_pd_fn()") added @blkcg to ->pd_alloc_fn(); however,
blkcg_activate_policy() ends up using pd's allocated for the root
blkcg for all preallocations, so ->pd_init_fn() for non-root blkcgs
can be passed in pd's which are allocated for the root blkcg.

For blk-iocost, this means that ->pd_init_fn() can write beyond the
end of the allocated object as it determines the length of the flex
array at the end based on the blkcg's nesting level.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: cf09a8ee19ad ("blkcg: pass @q and @blkcg into blkcg_pol_alloc_pd_fn()")
---
 block/blk-cgroup.c |   43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

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
@@ -1370,15 +1370,7 @@ int blkcg_activate_policy(struct request
 
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
 
 	/* blkg_list is pushed at the head, reverse walk to init parents first */
@@ -1388,12 +1380,31 @@ pd_prealloc:
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q, &blkcg_root);
-		if (!pd)
-			swap(pd, pd_prealloc);
+		if (blkg == pinned_blkg) {
+			pd = pd_prealloc;
+			pd_prealloc = NULL;
+		} else {
+			pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q,
+					      blkg->blkcg);
+		}
+
 		if (!pd) {
+			if (pinned_blkg)
+				blkg_put(pinned_blkg);
+			blkg_get(blkg);
+			pinned_blkg = blkg;
+
 			spin_unlock_irq(&q->queue_lock);
-			goto pd_prealloc;
+
+			kfree(pd_prealloc);
+			pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q,
+						       blkg->blkcg);
+			if (pd_prealloc) {
+				goto retry;
+			} else {
+				ret = -ENOMEM;
+				goto out_bypass_end;
+			}
 		}
 
 		blkg->pd[pol->plid] = pd;
@@ -1403,6 +1414,10 @@ pd_prealloc:
 			pol->pd_init_fn(pd);
 	}
 
+	if (pinned_blkg)
+		blkg_put(pinned_blkg);
+	kfree(pd_prealloc);
+
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
 
