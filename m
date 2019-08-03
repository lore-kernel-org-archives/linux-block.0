Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCDC31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9387F21773
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564840941;
	bh=uC3hLV8Vdd6pU/aPrXuamysCCgg+9etpBqi5fAXT8X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2izfOqWVEPVKeNiB0Gey3PVSTaUWYWRs/VMxvzyQeOhCcA8OSUenx8cptIRII3WF1
	 l7cSgSLAkcGS+mNVNr3Jd0FoIEt3NFLPeovJ+IDsl8uqtWQcyVjYMFL87zHjADYsK3
	 ZPdeZ6bGx2rdzXaiZHyXghNo0hA+0egeFNysO6c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391281AbfHCOCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:02:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42907 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391220AbfHCOCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Aug 2019 10:02:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so76879718qtm.9;
        Sat, 03 Aug 2019 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D9orjRjfDP9pgbxu2ifvLHy1ukGCDC2EnGjf/tPTneg=;
        b=cYPLPoMt3nONdxSxEBH2DXkIoLL+c9kekNeZLQCrDU7eCfsa88/QnKRrpo2uMjGpnt
         8yr36k8tiB7bRtBvd+j8pp9LWfqhmue6miSiyxYELzY5FOgfWc3t58Snbg5xMh32u7rt
         53KM77N+vC78kPnMnfPjHh98M4fvvJg+TDfRrGu/otL4kB49lI+RXnGcUJn6ggTljn6T
         9eY1HB5jWO32Zsqkc6HchBQ3JKLeJC5KoocZEgyb7QzmFt3SrF//DO0yYyQMG7d5kpQr
         HLMxXYD/noRAOoXbQ7C1kXaOd/Rh95WKAb4novdD59drxwXue25gMwWDx4RmQHus7pYV
         t6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=D9orjRjfDP9pgbxu2ifvLHy1ukGCDC2EnGjf/tPTneg=;
        b=ehgp3uUV42wj8ZD3UceWkL8fKNHhXJtqi4mZmqhCqP5p0Q3iLWGFp2uxl5OxX5SCfu
         xcJ/xEBXDOL4CyMTM4wzpHmiVL91NohD8PQQCpY6LEsgxNJDY+jzETYY1tgOMETU6P39
         G71MEAoIVBM2q7nKIyn+xgB8X8bS9YVz0QA9TGzMZqz6hlgmVoooUOGGK8Qz9EijQS9i
         LfdHiRIhP//eWuoQWum/k8I49owwuugibgtUqeYq4A6qq4MTkmTC2bnuXpE1Yz1v6zQ2
         /OI/TIX4BeUMACiITqq+pDXGIjCsZQ4ane5IiTk3/Vk3pS72B9Vuup9QCzvmFbH8Eo+L
         Gzsw==
X-Gm-Message-State: APjAAAXljUJ19k3B+rBiFEwtdjjz5eVUm/dTxIoRP+aumYfuvlFUTnmc
        pnYcd3tlX5hpdLEoSaiq8dY=
X-Google-Smtp-Source: APXvYqzq4ivE4tAq5lf09J8xU7TbLV1kaIEe1KkD0cgBL2Q8YLk017OZlnCCIbvPhSic+6Qi+z3/Ew==
X-Received: by 2002:ac8:c45:: with SMTP id l5mr96088707qti.63.1564840929275;
        Sat, 03 Aug 2019 07:02:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::efce])
        by smtp.gmail.com with ESMTPSA id 18sm35265973qkh.77.2019.08.03.07.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:02:08 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] writeback, memcg: Implement cgroup_writeback_by_id()
Date:   Sat,  3 Aug 2019 07:01:54 -0700
Message-Id: <20190803140155.181190-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803140155.181190-1-tj@kernel.org>
References: <20190803140155.181190-1-tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement cgroup_writeback_by_id() which initiates cgroup writeback
from bdi and memcg IDs.  This will be used by memcg foreign inode
flushing.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/fs-writeback.c         | 64 +++++++++++++++++++++++++++++++++++++++
 include/linux/writeback.h |  4 +++
 2 files changed, 68 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6129debdc938..5c79d7acefdb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -880,6 +880,70 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		wb_put(last_wb);
 }
 
+/**
+ * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
+ * @bdi_id: target bdi id
+ * @memcg_id: target memcg css id
+ * @nr_pages: number of pages to write
+ * @reason: reason why some writeback work initiated
+ * @done: target wb_completion
+ *
+ * Initiate flush of the bdi_writeback identified by @bdi_id and @memcg_id
+ * with the specified parameters.
+ */
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
+			   enum wb_reason reason, struct wb_completion *done)
+{
+	struct backing_dev_info *bdi;
+	struct cgroup_subsys_state *memcg_css;
+	struct bdi_writeback *wb;
+	struct wb_writeback_work *work;
+	int ret;
+
+	/* lookup bdi and memcg */
+	bdi = bdi_get_by_id(bdi_id);
+	if (!bdi)
+		return -ENOENT;
+
+	rcu_read_lock();
+	memcg_css = css_from_id(memcg_id, &memory_cgrp_subsys);
+	if (memcg_css && !css_tryget(memcg_css))
+		memcg_css = NULL;
+	rcu_read_unlock();
+	if (!memcg_css) {
+		ret = -ENOENT;
+		goto out_bdi_put;
+	}
+
+	/* and find the associated wb */
+	wb = wb_get_create(bdi, memcg_css, GFP_NOWAIT | __GFP_NOWARN);
+	if (!wb) {
+		ret = -ENOMEM;
+		goto out_css_put;
+	}
+
+	/* issue the writeback work */
+	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
+	if (work) {
+		work->nr_pages = nr;
+		work->sync_mode = WB_SYNC_NONE;
+		work->reason = reason;
+		work->done = done;
+		work->auto_free = 1;
+		wb_queue_work(wb, work);
+		ret = 0;
+	} else {
+		ret = -ENOMEM;
+	}
+
+	wb_put(wb);
+out_css_put:
+	css_put(memcg_css);
+out_bdi_put:
+	bdi_put(bdi);
+	return ret;
+}
+
 /**
  * cgroup_writeback_umount - flush inode wb switches for umount
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8945aac31392..ad794f2a7d42 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -217,6 +217,10 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 void wbc_detach_inode(struct writeback_control *wbc);
 void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
+			   enum wb_reason reason, struct wb_completion *done);
+int writeback_by_id(int id, unsigned long nr, enum wb_reason reason,
+		    struct wb_completion *done);
 void cgroup_writeback_umount(void);
 
 /**
-- 
2.17.1

