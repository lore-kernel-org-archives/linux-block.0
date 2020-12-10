Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09783C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B097123AC4
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgLJKT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLJKTz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:55 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14004C06138C
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:36 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so6560408ejb.3
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Knp0gAEhpnBnofpihCTn4KOe6yD4tuQQlDjccaInD6E=;
        b=BMz53dqpO38dB+5KPM6lYgaLtlBENivLclTqhYfZGPVwcAXjWpSPhLRoQDbUTiFipM
         KPWjtKPZZrfRi7sM7OsPRCSGJGTOwdQK2JT10p2T0ZU/dQgTq5iSInm+FHcTspf2DmZ/
         6dUWGuB6hR/b5fZro+7TDgDTMOqo2p6wPxbCxSbznP45u7k5kKkUgHwNTzq7usNQeyao
         S7hJG5tRdo+xIkkvu0a0Jn7t33DcJPv5o2SOFH+3LOSr7+8TwaF9vcY9HOlKtBrXfO5Z
         BhLtBjwnzMTkrS+ukLSR+9YMukPpYlgwDwD5q/LjobpC+dEReG9C52h+0GdmhXdpuZiI
         /TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Knp0gAEhpnBnofpihCTn4KOe6yD4tuQQlDjccaInD6E=;
        b=SXcZrC0G/w1FWyh6Qj6ARmVtCT7nNrpk6MNwBC3wazfgZWlHkUcxejBdghibmWb3Iv
         qc9zjSwXBEHe5ZvNwM/9X1owv0yZwN0801z//gh1JwNI8OAmq2bDmcjP4KcQ4eIdvxZ/
         LKqHWeB0IfCBDJi/fnUzB4IcVeNyt3QoomeTOB2V9HOJlpnSweC4dwlv/OdElpako0xU
         C9BgyFviEJ5hBRNIeEm0zu75xKdtS69osQijk1LjBqJ6mxghArppRl0nnMt90D0UZw2b
         /j/TVllL+XENbVEd4tw/2c4cqEHaiAR2q5zhMImNJs1QXcjPgvyZbAkHKpN6PICTofzM
         mkag==
X-Gm-Message-State: AOAM53297vIzTX8dBo1pEpuAC2G+4l5LG2OOsv8A4Zl9YJMPW6Xv5X0a
        zYNtnO7Q8TD3Xv5OAfb6ifrcrS4GFy0jxA==
X-Google-Smtp-Source: ABdhPJz/1eKp2m2h0bsPcUIH2SrwJy9HCOGsp3mzgR0BIGdg2xrgA9L9xcwq461gJDxI30ckwrit5w==
X-Received: by 2002:a17:906:369b:: with SMTP id a27mr5909682ejc.183.1607595514616;
        Thu, 10 Dec 2020 02:18:34 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:34 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 7/7] block/rnbd-clt: Does not request pdu to rtrs-clt
Date:   Thu, 10 Dec 2020 11:18:26 +0100
Message-Id: <20201210101826.29656-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
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
index 5941ff7c83a8..96e3f9fe8241 100644
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
@@ -1218,7 +1227,7 @@ find_and_get_or_create_sess(const char *sessname,
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

