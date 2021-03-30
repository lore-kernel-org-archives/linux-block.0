Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084EC433F8
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CDD61883
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhC3Hio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC3HiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDAC061765
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y6so17067927eds.1
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fPRExy/th2Wxi81rNTwbnWXQ+KI4WdiMLN79pZ5LSY=;
        b=QySgObKFhq+YYsvXa7tHvjm8IGZV0mRsvwysN+8OIXE7er/UJ3RVgHjD2nxiTyZMYv
         hS2jnN9tklMnVYmMxtAcYXJGZw2djHOTrp4DyNRa7SRwwxZkqAPN1YSC2jJkpj7Zx1Pe
         ++cEJx6P6gwY6NiTzl3zTfIaAo9laVOWA2IlP5ENNiI4K19zfUwOJgsZnYBayL2FKOpu
         HacYk1OFwA5PzsPP+3B+R1fVxbQMzsgdOU442BH8KQfdOZddqC0A9Vz4a7rRBgXnwnuQ
         tn1DaVR5PzyCLvnyL+YyG96k9y/vHjL4lOWH8z1iq4OmWRSwmJFLzLR5ilmyN+JC8XMP
         8arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fPRExy/th2Wxi81rNTwbnWXQ+KI4WdiMLN79pZ5LSY=;
        b=FU059FkXA2qL17im8Cyx3m/XJc2xBVEsCoJTiB+pTUK+utBnLwKgGJpzqVmK4I4viH
         l/V9tQ5+0nU3ub8D6AhpHtsUzYsfPjl/JaDhZY49qABAyGt0LMg5wKsJg1FNtZMUvw9f
         N+v9dcpb+NWCGOibv5z0U0k+kiiFNmuIDF+yLM4NbSI953K5HHl28ff8OGRTkEeaNxJk
         JVBLTf7fF8X2GD7ZRAEgxNERysjXR6H4kNZrZWFAdBHlV8Q/U/S+pgSDu7BTZ2r5o8KE
         GGw64Fr57XKBSG2LKlFb9ASNfidhBXkM14OLyZjUJR+XaPZ9gU+ebU/vMkekb9Wc1iNd
         oq4w==
X-Gm-Message-State: AOAM530crMI9X7D1cye8Wnt/Ee3PMF31XMtU/bch9lQTtlunbJx2ln9T
        1RUc4aayrgi/uBq3I0dHfoZks75sW2ixECfB
X-Google-Smtp-Source: ABdhPJzds/SbUvrD1Wn7gGVlnmL6XVEbS0hEVtaYiBvT/ZE1YeFLq6kzaDDiR67HnLbUmdWJy/ERTg==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr31833190edv.44.1617089889143;
        Tue, 30 Mar 2021 00:38:09 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 15/24] block/rnbd-srv: Remove force_close file after holding a lock
Date:   Tue, 30 Mar 2021 09:37:43 +0200
Message-Id: <20210330073752.1465613-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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
index 278a981302b9..76f9c08f611f 100644
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
index f284620ef0d3..a71b6f7662f5 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -335,7 +335,8 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 	}
 }
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr)
 {
 	struct rnbd_srv_session	*sess = sess_dev->sess;
 
@@ -343,6 +344,8 @@ void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 	/* It is already started to close by client's close message. */
 	if (!mutex_trylock(&sess->lock))
 		return;
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess_dev->kobj, &attr->attr);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&sess->lock);
 }
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 120e6d64cb82..b513021efc92 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -72,7 +72,8 @@ struct rnbd_srv_sess_dev {
 	struct rnbd_srv_fault_inject    fault_inject;
 };
 
-void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev);
+void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev,
+				   struct kobj_attribute *attr);
 /* rnbd-srv-sysfs.c */
 
 int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
-- 
2.25.1

