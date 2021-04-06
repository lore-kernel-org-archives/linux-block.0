Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0AC43461
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FF3613BD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhDFHHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbhDFHHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A080C06175F
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r22so2717442edq.9
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WusjvsYw5StKARzVGPy5VqECBTOsgPT1toBxn5pBW8=;
        b=NWVVj+xsbec1zi5irfFY60twDIp2xhY45HkRjOWKXLfDEK7kT5z+tVqfZmbVxA1YQ2
         dhb8IXFyzZKGJGu1tGWEHBCC3OjaKfyUGGlKsfSYQT+JphXuN8a45Jbdz1QRoPe8MHWS
         vec/FaYgDYTXhX7SP08PRKLCIDwdqs6cMdG4TmIRnRadNYwokZ2qHxK7eY6PxWps6UP/
         E6f7+Rot4/yVjg10MB+6zHkLxLC641W+lemtXH8X69EEGC1pP7Y5U+nCQkiaMTBIk4EX
         pa1Ql5r2Ai9PHSYpEok0PnBGW/JjC8VImzSMgFivaaHhPPqZjEsbr+twTQUg9NPm6pxj
         gGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WusjvsYw5StKARzVGPy5VqECBTOsgPT1toBxn5pBW8=;
        b=c7b66KVIa6u64ROuiQHSoblt3yGJCufTXSF6xoh0Z3+BfSCs9dfhGJboIAW6xx7t4d
         Ix4sQK5UdfPhBIk0MVLtdKVZSlR3UxcFeSIEeJIJZS+h8Sbx5uR2sIqf6JKhAi+/AxPX
         GAij160sOX3mj5ObAiqK6cVW9yRcB5art/P6+R/vJ8wPEypRQq0Hic65PZQy8pZAfGz7
         WVWM0XXI/Un6nID5Bo+Ncleg1y0RDFIt7q/Em6EzH27Sye3FLwpuLO8tG5WIaRiqsorj
         8rKxd/yYL3kZpBMIQh957BrlxqrpBczJBXtW9faPLfTSea6bQxsOzGs1sPg3jogbn9zL
         zyWw==
X-Gm-Message-State: AOAM533IY/BGwLC6rRB9zG4SFjjStAz9Q9dknha+QRsM86tcDU6Ck67q
        INmx33ek4aQv4G12Gce0QhoEoTg/eqjZrC3y
X-Google-Smtp-Source: ABdhPJzfHZjDCaSxZMZCqSvGZZAnCtXbuJ9dcytYS4TgNxTV0+XodGf9U1kK+TYXhLgYylCQaVYRsQ==
X-Received: by 2002:a05:6402:430c:: with SMTP id m12mr37036358edc.138.1617692847015;
        Tue, 06 Apr 2021 00:07:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:26 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 10/19] block/rnbd-srv: Remove force_close file after holding a lock
Date:   Tue,  6 Apr 2021 09:07:07 +0200
Message-Id: <20210406070716.168541-11-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

We changed the rnbd_srv_sess_dev_force_close to use try-lock
because rnbd_srv_sess_dev_force_close and process_msg_close
can generate a deadlock.

Now rnbd_srv_sess_dev_force_close would do nothing
if it fails to get the lock. So removing the force_close
file should be moved to after the lock. Or the force_close
file is removed but the others are not removed.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 5 +----
 drivers/block/rnbd/rnbd-srv.c       | 5 ++++-
 drivers/block/rnbd/rnbd-srv.h       | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 05ffe488ddc6..acf5fced11ef 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -147,10 +147,7 @@ static ssize_t rnbd_srv_dev_session_force_close_store(struct kobject *kobj,
 	}
 
 	rnbd_srv_info(sess_dev, "force close requested\n");
-
-	/* first remove sysfs itself to avoid deadlock */
-	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
-	rnbd_srv_sess_dev_force_close(sess_dev);
+	rnbd_srv_sess_dev_force_close(sess_dev, attr);
 
 	return count;
 }
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1549a6361630..a9bb414f7442 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -329,7 +329,8 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 	}
 }
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr)
 {
 	struct rnbd_srv_session	*sess = sess_dev->sess;
 
@@ -337,6 +338,8 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 	/* It is already started to close by client's close message. */
 	if (!mutex_trylock(&sess->lock))
 		return;
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&sess->lock);
 }
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index b157371c25ed..98ddc31eb408 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -64,7 +64,8 @@ struct rnbd_srv_sess_dev {
 	enum rnbd_access_mode		access_mode;
 };
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr);
 /* rnbd-srv-sysfs.c */
 
 int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
-- 
2.25.1

