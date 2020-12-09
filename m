Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4439FC19425
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C5923B97
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgLIIWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLIIWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:22:16 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853BC0617B0
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:21:01 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v22so574568edt.9
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywpjMsHON3M/dUVBVN/LPgCWwxFLN82iOCwXIqn+k/A=;
        b=iDdzn6b86ed3KJmzMOcoeo19Fj16OaXmaqzSmrLVAb5nkASf+K1TQ34LPiji7L9LTK
         6Z7yPmmEEHjBTXScdHdQevk5ZmtbrZVa9Y2Nu7kJZopsxzK5Qbdo7huPQ5FbXF2MzSay
         yOg50CXlb20MVgMp0UZK9Dl/cD1oD/LES8XYn+JR+Vxjomm1OLN0XLCdX1Op07uBdPnb
         EASUhTVEvT0gzkQnp06iEUtWGF5WNha0p4VZCc+Rx8KmVKxMNDtNCKG6c0yvkaWx/74J
         fB5+J8URhpc4yUmutW5aOP5woBPsztIIQai89mUPmg7/8iGp959RmNe5VQOHQQ93C7a3
         Fy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywpjMsHON3M/dUVBVN/LPgCWwxFLN82iOCwXIqn+k/A=;
        b=twNgAMRGieKep1UzSLFfl8ZYZBTL987zFUMMmyiRG8fgD8uLttLgXz6M4XNt4VVUCb
         8L9/1r1x7ao1Q9jrfJ2RTw3c2+is90l0vIQwJUk3GMjwMuMBOuo4InWHl4IMDWPKne1S
         kOlCkGdRS5BsVvWf6NjiINmBI9IDP47nP8kPOTYi9z3/VTW/wupGJrJx72q+2P8mhpt6
         jeCsJpN5V9Dzmao1lVNLcNX1lwUhOUj0GkEoogRKD7cLG6RWH52JpBZk5kGYLQmcVht6
         YGCuqOWqiJD5uOBLlSIstwvKrq7aBLDZa7OxRBKiQ5rX11c+d2S791e0f0kB4mHeZNb8
         5Drg==
X-Gm-Message-State: AOAM5329w63Q/9XQgNtW/LUlwIsyQn/QEhDjAqTIo6x463zaP8TJW0J7
        Voa/v+4ODwUN5qK+BzvWM+vF37jh9lDTNg==
X-Google-Smtp-Source: ABdhPJzlyhaBnNQqNaBh7L69fdAJvLtaOVlYbABJGxK8FlD9KqrqfCXzFuWAqwV759BNzJ+ETZz7nA==
X-Received: by 2002:a50:b002:: with SMTP id i2mr914864edd.99.1607502059894;
        Wed, 09 Dec 2020 00:20:59 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:59 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 7/7] block/rnbd-clt: Does not request pdu to rtrs-clt
Date:   Wed,  9 Dec 2020 09:20:51 +0100
Message-Id: <20201209082051.12306-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Previously the rnbd client requested the rtrs to allocate rnbd_iu
just after the rtrs_iu. So the rnbd client passes the size of
rnbd_iu for rtrs_clt_open() and rtrs creates an array of
rnbd_iu and rtrs_iu.

For IO handling, rnbd_iu exists after the request because we pass
the size of rnbd_iu when setting the tag-set. Therefore we do not
use the rnbd_iu allocated by rtrs for IO handling.
We only use the rnbd_iu allocated by rtrs when doing session
initialization. Almost all rnbd_iu allocated by rtrs are wasted.

By this patch the rnbd client does not request rnbd_iu allocation
to rtrs but allocate it for itself when doing session initialization.

Also remove unused rtrs_permit_to_pdu from rtrs.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c          | 17 +++++++++++++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  6 ------
 drivers/infiniband/ulp/rtrs/rtrs.h     |  7 -------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c37d94181ff4..9165e70bee0c 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -349,12 +349,19 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 	struct rnbd_iu *iu;
 	struct rtrs_permit *permit;
 
+	iu = kzalloc(sizeof(*iu), GFP_KERNEL);
+	if (!iu) {
+		return NULL;
+	}
+
 	permit = rnbd_get_permit(sess, con_type,
 				  wait ? RTRS_PERMIT_WAIT :
 				  RTRS_PERMIT_NOWAIT);
-	if (unlikely(!permit))
+	if (unlikely(!permit)) {
+		kfree(iu);
 		return NULL;
-	iu = rtrs_permit_to_pdu(permit);
+	}
+
 	iu->permit = permit;
 	/*
 	 * 1st reference is dropped after finishing sending a "user" message,
@@ -373,8 +380,10 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 
 static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
 {
-	if (atomic_dec_and_test(&iu->refcount))
+	if (atomic_dec_and_test(&iu->refcount)) {
 		rnbd_put_permit(sess, iu->permit);
+		kfree(iu);
+	}
 }
 
 static void rnbd_softirq_done_fn(struct request *rq)
@@ -1216,7 +1225,7 @@ find_and_get_or_create_sess(const char *sessname,
 	 */
 	sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
 				   paths, path_cnt, port_nr,
-				   sizeof(struct rnbd_iu),
+				   0, /* Do not use pdu of rtrs */
 				   RECONNECT_DELAY, BMAX_SEGMENTS,
 				   BLK_MAX_SEGMENT_SIZE,
 				   MAX_RECONNECTS);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index bcfa6258a7af..7644c3f627ca 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -157,12 +157,6 @@ void rtrs_clt_put_permit(struct rtrs_clt *clt, struct rtrs_permit *permit)
 }
 EXPORT_SYMBOL(rtrs_clt_put_permit);
 
-void *rtrs_permit_to_pdu(struct rtrs_permit *permit)
-{
-	return permit + 1;
-}
-EXPORT_SYMBOL(rtrs_permit_to_pdu);
-
 /**
  * rtrs_permit_to_clt_con() - returns RDMA connection pointer by the permit
  * @sess: client session pointer
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 9af750f4d783..8738e90e715a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -63,13 +63,6 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 
 void rtrs_clt_close(struct rtrs_clt *sess);
 
-/**
- * rtrs_permit_to_pdu() - converts rtrs_permit to opaque pdu pointer
- * @permit: RTRS permit pointer, it associates the memory allocation for future
- *          RDMA operation.
- */
-void *rtrs_permit_to_pdu(struct rtrs_permit *permit);
-
 enum {
 	RTRS_PERMIT_NOWAIT = 0,
 	RTRS_PERMIT_WAIT   = 1,
-- 
2.25.1

