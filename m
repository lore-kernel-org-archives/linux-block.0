Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE6ECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4D2086A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571154512;
	bh=JfsvFua5FyEIyFW8ezrzFQkkYQdxhQpb+BL72cPktkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pH7O5qHn5odEhnLDqevXNBECdmPA5WVxG2cuYdd+feCEhde1JMOOS85ecPth9SwAt
	 bQJw1c0ljogMwWp+WyU0+CuhTY+vL6AzchFs6FTjAtu5p/av2/0KNCLdHu7kEXznw+
	 qmg8hJMHJForIKSoXqwdIW+KIXdSdSC/gGp4y/O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJOPsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:48:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34393 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOPsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 11:48:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id q203so19626475qke.1;
        Tue, 15 Oct 2019 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4UV/vP6Ak7zlZSSUsFjQtQPToq6GnlOm1PHifs316U4=;
        b=LsoAypu+QZFDZOOMgWj57DzO9NJX1FgAGXdYolZJAF3A/bnTKstO7wULawxUrkeLnF
         LIZALF6eFW4JRe91stBT6ts8IaIkGyHBFFDmQnJfq2yT/aAqEAZSmvDelPxyuKUqHiRE
         VEwh2YBOJgmKRUXKRKcELaCCvsJquUZJXkI3j2Lut0LhIZ6BmmRPQ0juk5aiZifh2sKB
         BuM8uI/lEYzA7uFjLvNJU3wOK31R6M8dqKpmvI5hACGwcYhs7HzPViT4DiEGTY1DLndY
         CGuRlYOGOjQ4Xosg93QM8Wpixg799Rm48Zf7pRmxjbeVnB5ewpnrDMl2kKbzbTbqENgt
         RRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4UV/vP6Ak7zlZSSUsFjQtQPToq6GnlOm1PHifs316U4=;
        b=GrZalv11NN+/wA0njRs2vKNHTW1S/iJnkexzABWjDgaGK5/wpz8UAteCPPVdo5hwWs
         sNmrGXFsZmuhi1Lav0ZwIIBLwOenUT/jMMosY7t1Kyx9KDT3H/1pcrkGbaE4FnfqFgnq
         7pULvn10XYdvLvkqc+lTPiIxt/xKOciWM+3O1/wTKEu1owZOp1eKgV5BAF0eD2C1bsa0
         /mG+nBTP5lOAVmlFRoFmWCKJWLlBu2i9r+lfggtDhVY9wXmJx2B6fwU8SsFIayOdknbl
         C5L6ZFx8LOMGIaHJ+e6nHdFtmHGyjSQqjbmSCYFRZbUwBwg0XZ5sdNsUakJ176krKHkZ
         38sw==
X-Gm-Message-State: APjAAAW1QYFuk8MDjzbr3aYC5x8NjjKaLbU6D461vugrE7XmVEbXsZHW
        +5rCuotivBBGHVebtEnIB/w=
X-Google-Smtp-Source: APXvYqzK7AJnTuTyVvinEDnBafFaa0S4oM2gipW8LqP+1d6TT52IrNHq2jpxXWuOvsik/AY376SHyQ==
X-Received: by 2002:a37:a50a:: with SMTP id o10mr35684316qke.115.1571154509896;
        Tue, 15 Oct 2019 08:48:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2a53])
        by smtp.gmail.com with ESMTPSA id p77sm10954411qke.6.2019.10.15.08.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 08:48:29 -0700 (PDT)
Date:   Tue, 15 Oct 2019 08:48:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jens Axboe <axboe@kernel.dk>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org
Subject: [PATCH block/for-linus] blkcg: fix botched pd_prealloc error
 handling in blkcg_activate_policy()
Message-ID: <20191015154827.GK18794@devbig004.ftw2.facebook.com>
References: <alpine.DEB.2.21.1910151232480.2818@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910151232480.2818@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While fixing ->pd_alloc_fn() bug, ab94b0382d81 ("blkcg: Fix
->pd_alloc_fn() being called with the wrong blkcg on policy
activation") broke the pd_prealloc error handling.

* pd's were freed using kfree().  They should be freed with
  ->pd_free_fn().

* pd_prealloc could be kfree()'d and then ->pd_free_fn()'d again.

* When GFP_KERNEL allocation fails, pinned_blkg wasn't put.

There are also a couple existing issues.

* Each pd is initialized as they get allocated.  If alloc fails, the
  policy will get freed with pd's initialized on it.

* After the above partial failure, the partial pds are not freed.

This patch fixes all of the above issues.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: ab94b0382d81 ("blkcg: Fix ->pd_alloc_fn() being called with the wrong blkcg on policy activation")
---
 block/blk-cgroup.c |   44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1373,13 +1373,14 @@ int blkcg_activate_policy(struct request
 retry:
 	spin_lock_irq(&q->queue_lock);
 
-	/* blkg_list is pushed at the head, reverse walk to init parents first */
+	/* blkg_list is pushed at the head, reverse walk to allocate parents first */
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
 			continue;
 
+		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
 		if (blkg == pinned_blkg) {
 			pd = pd_prealloc;
 			pd_prealloc = NULL;
@@ -1389,6 +1390,10 @@ retry:
 		}
 
 		if (!pd) {
+			/*
+			 * GFP_NOWAIT failed.  Free the existing one and
+			 * prealloc for @blkg w/ GFP_KERNEL.
+			 */
 			if (pinned_blkg)
 				blkg_put(pinned_blkg);
 			blkg_get(blkg);
@@ -1396,38 +1401,51 @@ retry:
 
 			spin_unlock_irq(&q->queue_lock);
 
-			kfree(pd_prealloc);
+			if (pd_prealloc)
+				pol->pd_free_fn(pd_prealloc);
 			pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q,
 						       blkg->blkcg);
-			if (pd_prealloc) {
+			if (pd_prealloc)
 				goto retry;
-			} else {
-				ret = -ENOMEM;
-				goto out_bypass_end;
-			}
+			else
+				goto enomem;
 		}
 
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		if (pol->pd_init_fn)
-			pol->pd_init_fn(pd);
 	}
 
-	if (pinned_blkg)
-		blkg_put(pinned_blkg);
-	kfree(pd_prealloc);
+	/* all allocated, init in the same order */
+	if (pol->pd_init_fn)
+		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+			pol->pd_init_fn(blkg->pd[pol->plid]);
 
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
 
