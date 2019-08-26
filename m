Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735AC3A59F
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9B021872
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566835650;
	bh=75sevnElSVQkSWHj0jk5tjITBnjjmYiMrbnKf2uzbbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbKLaX43CLhK/XBj2urX364jWt3HJJ71UOBXSvOAmPtO38GFKB7dWsdAvM4VjUZW2
	 BEX3p8dg6RCrWcHrTNpn76PeGgenryu85mMSWuShwxGxmnq5i0v58RIO4sBR8Ack8w
	 H9Su+wTymWjtBG1WjwyhTuI4Ylxr2CPDljp44oiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfHZQHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:07:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38970 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbfHZQHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 12:07:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so18371244qtu.6;
        Mon, 26 Aug 2019 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sbi9AtPpKs90xX0XCzYWXMGLwoRRPZP34bqUM0NUXLs=;
        b=gX5n0n0Iya2r+6HfxSBgduwjqnM9PRtJlmoEm5ghngBsve/UtQYFYtPDwNviTIYOMH
         yLHoMeNJ+DWQ0bdNx4cvSVgcN681dV36+OkH/g1jKJgRguOi7VsP0NlyTZAz7cNUZOE6
         zqnuyTGB/QvBuFExLTGnei+AosOZ6sQ0y8LkGtkVWGqoLaIqdMokGxmf43BnVYTMWOsm
         TfgrfDI+kUfbZopDzIk1PUoIxNGEh7GWOOExZRBb6f7AdZPpR69VNoZkY4jlUDeGLJQo
         pcOBl6W9Exf/K3YN+IZmyKLnwa/O+zqQugMqiuDEyPBkAwPlHoZuAITEWOR87u2+0DCW
         ok0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sbi9AtPpKs90xX0XCzYWXMGLwoRRPZP34bqUM0NUXLs=;
        b=lAu9S9iex0vX+b+i6BGbhCh4rCDjb43qIoeBVZA0tbOjfj9vr7MNd+YwOwUVM+3D41
         a+zUZF1tLNpg9fHAP4GFK5BhpDv9XOQlzIBq7p48d3Wpf+PFOjU6/3+w8r3Kv2vMq+JG
         blol3er/fN5nVDAtoCLtcSbQDrbPcv4LuOHHpZ5cfDL299hxyOZpg9s+BeBNyEM0Zl60
         aj0SN8Ve3bnRDLy0VipTz1b0OgcIHH7yTQEmMGt9iQDX0J4t0FXNWTvF1cee4rUEdud7
         Yd1Pp99OZnjfU7JBoSoxf0iSkeniqtgwPI82tFPH0mieM3PKz5WX8ZsLSYXpCXzwLqP9
         WtHQ==
X-Gm-Message-State: APjAAAWoMp9YiSRWdG7FmtrDlswnL6gZa+W1wRtHZUDG+2Ms+Nf8WIxN
        9O1K00hRYQ1w8Wq97WVAuQ0=
X-Google-Smtp-Source: APXvYqwfRmoFj279L2wsJx3QYrn8JRDZ4xVVrNIXLn3zjcDpszmBL7Yzn1lB3z9lIiUyrSDzWNyx1Q==
X-Received: by 2002:ac8:4789:: with SMTP id k9mr18184801qtq.41.1566835630468;
        Mon, 26 Aug 2019 09:07:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id 131sm6410446qkn.7.2019.08.26.09.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:07:09 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] writeback: Separate out wb_get_lookup() from wb_get_create()
Date:   Mon, 26 Aug 2019 09:06:54 -0700
Message-Id: <20190826160656.870307-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
References: <20190826160656.870307-1-tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Separate out wb_get_lookup() which doesn't try to create one if there
isn't already one from wb_get_create().  This will be used by later
patches.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev.h |  2 ++
 mm/backing-dev.c            | 55 +++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 84cdcfbc763f..97967ce06de3 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -230,6 +230,8 @@ static inline int bdi_sched_wait(void *word)
 struct bdi_writeback_congested *
 wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp);
 void wb_congested_put(struct bdi_writeback_congested *congested);
+struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+				    struct cgroup_subsys_state *memcg_css);
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 612aa7c5ddbd..d9daa3e422d0 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,13 +618,12 @@ static int cgwb_create(struct backing_dev_info *bdi,
 }
 
 /**
- * wb_get_create - get wb for a given memcg, create if necessary
+ * wb_get_lookup - get wb for a given memcg
  * @bdi: target bdi
  * @memcg_css: cgroup_subsys_state of the target memcg (must have positive ref)
- * @gfp: allocation mask to use
  *
- * Try to get the wb for @memcg_css on @bdi.  If it doesn't exist, try to
- * create one.  The returned wb has its refcount incremented.
+ * Try to get the wb for @memcg_css on @bdi.  The returned wb has its
+ * refcount incremented.
  *
  * This function uses css_get() on @memcg_css and thus expects its refcnt
  * to be positive on invocation.  IOW, rcu_read_lock() protection on
@@ -641,6 +640,39 @@ static int cgwb_create(struct backing_dev_info *bdi,
  * each lookup.  On mismatch, the existing wb is discarded and a new one is
  * created.
  */
+struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+				    struct cgroup_subsys_state *memcg_css)
+{
+	struct bdi_writeback *wb;
+
+	if (!memcg_css->parent)
+		return &bdi->wb;
+
+	rcu_read_lock();
+	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	if (wb) {
+		struct cgroup_subsys_state *blkcg_css;
+
+		/* see whether the blkcg association has changed */
+		blkcg_css = cgroup_get_e_css(memcg_css->cgroup, &io_cgrp_subsys);
+		if (unlikely(wb->blkcg_css != blkcg_css || !wb_tryget(wb)))
+			wb = NULL;
+		css_put(blkcg_css);
+	}
+	rcu_read_unlock();
+
+	return wb;
+}
+
+/**
+ * wb_get_create - get wb for a given memcg, create if necessary
+ * @bdi: target bdi
+ * @memcg_css: cgroup_subsys_state of the target memcg (must have positive ref)
+ * @gfp: allocation mask to use
+ *
+ * Try to get the wb for @memcg_css on @bdi.  If it doesn't exist, try to
+ * create one.  See wb_get_lookup() for more details.
+ */
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp)
@@ -653,20 +685,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 		return &bdi->wb;
 
 	do {
-		rcu_read_lock();
-		wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
-		if (wb) {
-			struct cgroup_subsys_state *blkcg_css;
-
-			/* see whether the blkcg association has changed */
-			blkcg_css = cgroup_get_e_css(memcg_css->cgroup,
-						     &io_cgrp_subsys);
-			if (unlikely(wb->blkcg_css != blkcg_css ||
-				     !wb_tryget(wb)))
-				wb = NULL;
-			css_put(blkcg_css);
-		}
-		rcu_read_unlock();
+		wb = wb_get_lookup(bdi, memcg_css);
 	} while (!wb && !cgwb_create(bdi, memcg_css, gfp));
 
 	return wb;
-- 
2.17.1

