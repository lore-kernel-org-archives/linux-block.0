Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E21AC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D2A20892
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029909;
	bh=0a7MG6E+Z71NvOC7e+IcjxQjMg1F6QgntJz3Vkl3ZZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EzcaUwI078PvUbgyZNVIyyPTupUIARV8VG+MFLhp3I0GbAyy9qXcgm0pBvJ1wilVK
	 jVhAIGO9WhoAyzaFmuAUW2i+9WulxNZhhl2iEk7bfvmhU/tMiZDr04czBgyIehJuQP
	 OuewvKIP2SeYKRBmXd7ytegN68+vMdjg6uSqRPCA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D2A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeLERLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:11:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33310 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbeLERKy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so23137292qtp.0;
        Wed, 05 Dec 2018 09:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hz95MKJyUN7o6BiAIb6U29q8tBi4HHpnn/9TiI2pVhA=;
        b=pKgVJOofZk4rIj0tH8YEhZK+JTHenmku+to0wE4xd7RONr/7xAPmskTyc1V5Jblq1p
         qraLgVXOsTgH5/bVwrbp1IknVLJnR5Zy+MvHN4WvZzLhf8ABFstcgxdLpj/l/DRTPAzA
         RSVcsXSOi9G2UWjMNXbykTDlkzJkTu7LmzcwHXp/xwVwNozPumzbbXpazlCsPaiPt4Qz
         QoxTEz73+59lrhASq6kzTBl9wULQOkbzsDTwbTnXJ0YkVMSF683GJDQIqARix3up68ga
         3Fs/SFe0ZM2R9983dOjQZTMXxlZVwDWPQ1j+ttN111BnL1A+mLebIy3ckHH5ZN3Yd7fy
         LNAg==
X-Gm-Message-State: AA+aEWbjtlBc4m2e1qn3jUgpqNA5wmXSDadk3X0BxqieLCtFtgDsSobs
        Cumjve1AYcJNwFYLage5bio=
X-Google-Smtp-Source: AFSGD/VbE+xWASlOUOoCGee+Aa5tHO3nOvGUm3aatE+xZQeKFMyvFplrmvslXKUn/MdcdyZSwnyuvQ==
X-Received: by 2002:aed:3784:: with SMTP id j4mr23730345qtb.50.1544029853481;
        Wed, 05 Dec 2018 09:10:53 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:52 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 08/14] blkcg: associate a blkg for pages being evicted by swap
Date:   Wed,  5 Dec 2018 12:10:33 -0500
Message-Id: <20181205171039.73066-9-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A prior patch in this series added blkg association to bios issued by
cgroups. There are two other paths that we want to attribute work back
to the appropriate cgroup: swap and writeback. Here we modify the way
swap tags bios to include the blkg. Writeback will be tackle in the next
patch.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c         | 62 +++++++++++++++++++++++++++------------------
 include/linux/bio.h |  6 ++---
 mm/page_io.c        |  2 +-
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 90089124b512..f0f069c1823c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1957,30 +1957,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-#ifdef CONFIG_MEMCG
-/**
- * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
- * @bio: target bio
- * @page: the page to lookup the blkcg from
- *
- * Associate @bio with the blkcg from @page's owning memcg.  This works like
- * every other associate function wrt references.
- */
-int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
-{
-	struct cgroup_subsys_state *blkcg_css;
-
-	if (unlikely(bio->bi_css))
-		return -EBUSY;
-	if (!page->mem_cgroup)
-		return 0;
-	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
-				     &io_cgrp_subsys);
-	bio->bi_css = blkcg_css;
-	return 0;
-}
-#endif /* CONFIG_MEMCG */
-
 /**
  * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
@@ -2045,6 +2021,44 @@ static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	bio->bi_blkg = blkg_try_get_closest(blkg);
 }
 
+static void __bio_associate_blkg_from_css(struct bio *bio,
+					  struct cgroup_subsys_state *css)
+{
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_disk->queue);
+	__bio_associate_blkg(bio, blkg);
+
+	rcu_read_unlock();
+}
+
+#ifdef CONFIG_MEMCG
+/**
+ * bio_associate_blkg_from_page - associate a bio with the page's blkg
+ * @bio: target bio
+ * @page: the page to lookup the blkcg from
+ *
+ * Associate @bio with the blkg from @page's owning memcg and the respective
+ * request_queue.  This works like every other associate function wrt
+ * references.
+ */
+void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *css;
+
+	if (unlikely(bio->bi_css))
+		return;
+	if (!page->mem_cgroup)
+		return;
+
+	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+	bio->bi_css = css;
+	__bio_associate_blkg_from_css(bio, css);
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_blkg - associate a bio with a blkg
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 6ee2ea8b378a..f13572c254a7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -505,10 +505,10 @@ do {						\
 	disk_devt((bio)->bi_disk)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
+void bio_associate_blkg_from_page(struct bio *bio, struct page *page);
 #else
-static inline int bio_associate_blkcg_from_page(struct bio *bio,
-						struct page *page) {  return 0; }
+static inline void bio_associate_blkg_from_page(struct bio *bio,
+						struct page *page) { }
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
diff --git a/mm/page_io.c b/mm/page_io.c
index 5bdfd21c1bd9..3475733b1926 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,7 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
-	bio_associate_blkcg_from_page(bio, page);
+	bio_associate_blkg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.17.1

