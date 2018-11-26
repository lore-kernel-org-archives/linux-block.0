Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB8C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9623B20873
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9623B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeK0IP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38587 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0IP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:26 -0500
Received: by mail-yw1-f65.google.com with SMTP id i20so8202162ywc.5;
        Mon, 26 Nov 2018 13:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9xekZP3TtUleL4NnYxq5C7gaEG7DPFgD4vMSS6wpM4=;
        b=kupITkDmntviWpeR3vkJNVKFYKMultr52QXRp0GlcLUbriMGRUqlBbtbzMq1WHoUs1
         ul0jpjdlcwm8tWh6e6l4j2OjujGa3k7bZLFn4SWjbsOAIbLeR7moDVglQSrbCODX5rpJ
         QvQBty2KHi7ltOovKeDW3QBjq2ZzdW8W/jttSagdB69i7+D03mjytlf4CKS0Tha3p3lU
         9VJt9KKkA2qMrVC9xlxMBBYlmvi8HLhIwY3YqK9KFCCAyBiEPvuh5neF2UQ1DW8iS//k
         9A1b5HfQsZgUzGM+RrhT5nalOq79lM/vUy1BdHpempUsnD+Y9AG4gm7pjsYUnlNTBcIG
         SYOA==
X-Gm-Message-State: AA+aEWaUiMyyuDJV01c50o4rt4fPkZVirVN+uuAPSU1zSg2U9P5YLw2w
        Oa2awvxLT24gJspXDByXi3inVdstj6E=
X-Google-Smtp-Source: AFSGD/XB5GaRhATYuxlmLimQ3McNNaWmhUml3yRQ5IvTJN+/qXVSykHj8kof/O8bWNX5e+B4nhMQRw==
X-Received: by 2002:a81:9b8e:: with SMTP id s136mr11329054ywg.85.1543267200540;
        Mon, 26 Nov 2018 13:20:00 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:19:59 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/13] blkcg: associate a blkg for pages being evicted by swap
Date:   Mon, 26 Nov 2018 16:19:40 -0500
Message-Id: <20181126211946.77067-8-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
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
index efca5ae607a4..4600808ac606 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1958,30 +1958,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
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
@@ -2059,6 +2035,44 @@ static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
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
+	if (!bio_has_queue(bio) || !page->mem_cgroup)
+		return;
+
+	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+	bio->bi_css = css;
+	__bio_associate_blkg_from_css(bio, css);
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_blkg - associate a bio with a blkg from q
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8bc9d9b29fd3..ad322232db3e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -510,10 +510,10 @@ do {						\
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
index 257fdd67308d..409dcd438488 100644
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

