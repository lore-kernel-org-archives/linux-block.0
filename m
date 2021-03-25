Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD2C433F2
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6474761A3A
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCYPag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhCYPaE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF448C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jy13so3622595ejc.2
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fPRExy/th2Wxi81rNTwbnWXQ+KI4WdiMLN79pZ5LSY=;
        b=RLtG/AVT+z4VCmeg3rqcgm+IBqLYCFj3SougvFOZcBbPyOzAzltz1YlukfGQlDXVMP
         suC9ESQiZozRREmnjcth5mbKyeJI/o9PbBCgfFucH3sFhve7Bns7jtBt/CnWVoi9u101
         J+MlOrahH0SLXYZOsXl77YG0ZMjmz1hl4/bEB3VS7o18lE9KWCMmQnR8pT47l4le9K7F
         sh0yY3ru6ZSO8f09eLVw2vSvUBYEnf4NYYm/l8u9Kn41OhjrNqebv0oWsshDZHPJqeWh
         S/GuSg/32KA43Bt0u65KSmVNBFJMpL0HMoylOTCIsGMVG/GpGjVgzRrp0QqtRy4CX00j
         i7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fPRExy/th2Wxi81rNTwbnWXQ+KI4WdiMLN79pZ5LSY=;
        b=dJid0fCdSdNP56Q/9uy41RPQVTbMxKZQOGLVBgXV8g4BXiCLbpMMkKLc+m/J4uRtTa
         hR4lqC5xy848syFnf1o1LtXiQupRackrtVR5Js/TnkNQuGbIxo/qcnXGQ8dZ3iX4Tbjt
         sF7QPlK59sZbAzPXn3pSQOu5sy/U3H4h7uWQSilLAH/sVawMcAcCwxqIxlSXYPkj7z6T
         /mHpveBCojzbTmSrygFELawl1qObiE3O8e1mqQkupVZMkpqjxYfbl8Hug8zwZub33Wis
         KaU4hIJrvX0L0OeXckIusafxMDtRYTknWVmev+n7ctA713XzcUGnoelv71B/yKxDKBHr
         hwAQ==
X-Gm-Message-State: AOAM531bZnKNE/pIr7C24aA0zfE4Y6aRnR116XdpG1/luPuP5dNSLAP0
        bBr5nV0kSKNA40RDeftEqiGqibvmS2W61OQT
X-Google-Smtp-Source: ABdhPJwPijzgqYnlyTrfqG+48d8H5NA6GxYWlE4pRPiTtdoMjvgjxDFD8RMMTp8r6K92vhB41cG0nA==
X-Received: by 2002:a17:907:9e6:: with SMTP id ce6mr9847051ejc.207.1616686202493;
        Thu, 25 Mar 2021 08:30:02 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 15/24] block/rnbd-srv: Remove force_close file after holding a lock
Date:   Thu, 25 Mar 2021 16:29:02 +0100
Message-Id: <20210325152911.1213627-16-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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

