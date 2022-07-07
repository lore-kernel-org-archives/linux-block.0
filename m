Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD3FC43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 14:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiGGOcQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiGGOcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 10:32:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA652F66B
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 07:32:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g1so15758182edb.12
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2022 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fp9c2KAW0ZiIzC4UH8Ejj/09aHdNPelMrTwcQrHF278=;
        b=NwBHcBlTjlFb9yekdeQjfLXtle93uftEHdL0LQwnZB+tR7eTfgV1V7Hh5H8wSajWA/
         DKLmHAQig4VCrizcWG9A2RoDnz8XcJk+WEs+yvaeARREEu0zg9BcyExpNTMdFYXj30C+
         +R9mt8JkIqHgLV5Jr05kFy8VoRd7C0Thi5SBSjWv78RWrBKYr/Cafj3/85yaAZgvoGuU
         16xRuitnKK7z/vbsjoTwVQGwfQ6T/YVoEZ9Q/szONt59ZsjmJZc9V0DSw75oivM65pEf
         /qEtSWDnlpfsSii0L8T55BG37Qcd7zxLRO1O6x23fucSjn55Fe85B7G5dkj+LxstitD5
         IFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fp9c2KAW0ZiIzC4UH8Ejj/09aHdNPelMrTwcQrHF278=;
        b=vtqgYsbszEa16razDRiH8VsvgA4N6aiUuYw6T4DY3Hcjppsop2y42leL97PcMXe7OG
         9DklfXqKK7dk0WzgE1IhZjXWc8vaUC8Y2haisdrwcb5lQkzkn+rxctIDVoj9617dB9FM
         qh2ezKU7lArtcuqQ7Gm0mh0NKxL5NTXCBwJQyA9Kets9xPjTXBSRb22LYhQ3FaCbxlEM
         wut/JuZe/XPYOM0SVjvB7f2VXNIF2zbrl1zsditfmOJ74gJuwWgh68IVwnftWlJQz6u2
         qLk4s/F1OUzwy34AzDPZr6qOKo26acWZCf319rhgXa6JETOUDvyCkk4OC4mXhwMH9B0Y
         wzbA==
X-Gm-Message-State: AJIora+vSF0fS1Tj8y1ODfuERs4rpD8jbCOCqlqWfNWolM9Uj3pB7oBw
        rcfQD99uQeJnhmANThKnwVMPHBF52/m35w==
X-Google-Smtp-Source: AGRyM1vZKRg6eRl/baa6D4dh3ObyPHeZlyxKkwKDgLywAbMdpEihnWXZFPYpltWL/quBmCj/Az+NFw==
X-Received: by 2002:a05:6402:4301:b0:43a:9e3d:3bce with SMTP id m1-20020a056402430100b0043a9e3d3bcemr3230151edc.194.1657204332529;
        Thu, 07 Jul 2022 07:32:12 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7c70b000000b0043a5004e714sm9970896edq.64.2022.07.07.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:32:12 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 2/2] block/rnbd-srv: Replace sess_dev_list with index_idr
Date:   Thu,  7 Jul 2022 16:31:22 +0200
Message-Id: <20220707143122.460362-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707143122.460362-1-haris.iqbal@ionos.com>
References: <20220707143122.460362-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The structure rnbd_srv_session maintains a list and an xarray of
rnbd_srv_dev. There is no need to keep both as one of them can serve the
purpose.

Since one of the places where the lookup of rnbd_srv_dev using
rnbd_srv_session is IO path, an xarray would serve us better than a list
traversal. Hence remove sess_dev_list from rnbd_srv_session, and replace
its uses from xarray.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 17 +++++++----------
 drivers/block/rnbd/rnbd-srv.h |  4 ----
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index cf9e29a08db2..9a80fbce775a 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -224,7 +224,6 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
 	rnbd_dev_close(sess_dev->rnbd_dev);
-	list_del(&sess_dev->sess_list);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (sess_dev->open_flags & FMODE_WRITE)
@@ -239,14 +238,14 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 
 static void destroy_sess(struct rnbd_srv_session *srv_sess)
 {
-	struct rnbd_srv_sess_dev *sess_dev, *tmp;
+	struct rnbd_srv_sess_dev *sess_dev;
+	unsigned long index;
 
-	if (list_empty(&srv_sess->sess_dev_list))
+	if (xa_empty(&srv_sess->index_idr))
 		goto out;
 
 	mutex_lock(&srv_sess->lock);
-	list_for_each_entry_safe(sess_dev, tmp, &srv_sess->sess_dev_list,
-				 sess_list)
+	xa_for_each(&srv_sess->index_idr, index, sess_dev)
 		rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&srv_sess->lock);
 
@@ -281,7 +280,6 @@ static int create_sess(struct rtrs_srv_sess *rtrs)
 
 	srv_sess->queue_depth = rtrs_srv_get_queue_depth(rtrs);
 	xa_init_flags(&srv_sess->index_idr, XA_FLAGS_ALLOC);
-	INIT_LIST_HEAD(&srv_sess->sess_dev_list);
 	mutex_init(&srv_sess->lock);
 	mutex_lock(&sess_lock);
 	list_add(&srv_sess->list, &sess_list);
@@ -667,11 +665,12 @@ static struct rnbd_srv_sess_dev *
 find_srv_sess_dev(struct rnbd_srv_session *srv_sess, const char *dev_name)
 {
 	struct rnbd_srv_sess_dev *sess_dev;
+	unsigned long index;
 
-	if (list_empty(&srv_sess->sess_dev_list))
+	if (xa_empty(&srv_sess->index_idr))
 		return NULL;
 
-	list_for_each_entry(sess_dev, &srv_sess->sess_dev_list, sess_list)
+	xa_for_each(&srv_sess->index_idr, index, sess_dev)
 		if (!strcmp(sess_dev->pathname, dev_name))
 			return sess_dev;
 
@@ -782,8 +781,6 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
 	mutex_unlock(&srv_dev->lock);
 
-	list_add(&srv_sess_dev->sess_list, &srv_sess->sess_dev_list);
-
 	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->id);
 
 	kfree(full_path);
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index be2ae486d407..30e403557c67 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -25,8 +25,6 @@ struct rnbd_srv_session {
 	int			queue_depth;
 
 	struct xarray		index_idr;
-	/* List of struct rnbd_srv_sess_dev */
-	struct list_head        sess_dev_list;
 	struct mutex		lock;
 	u8			ver;
 };
@@ -48,8 +46,6 @@ struct rnbd_srv_dev {
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
 	struct list_head		dev_list;
-	/* Entry inside rnbd_srv_session struct */
-	struct list_head		sess_list;
 	struct rnbd_dev			*rnbd_dev;
 	struct rnbd_srv_session		*sess;
 	struct rnbd_srv_dev		*dev;
-- 
2.25.1

