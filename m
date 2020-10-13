Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8349C43457
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5946320878
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Tg/l4JTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgJMKay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgJMKay (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 06:30:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B5C0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t9so23362139wrq.11
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GevoxMiSfxAK6DWxOjcnTXy4acQvtt6FLw9M5kaA7GE=;
        b=Tg/l4JTilvQW/5dLDy4GUMFoeU5ko5zVicRICfYtkbJuhIXBMx+12jgDCoYnFK0CsZ
         Gx6YGgDipYR2FsiAExjdXsC4R6/KCNySNFTDz7RlvlLbbF5enMf8UuPSShGnTipZEHq7
         VbeZ9LRbbvJNQ9gI2PGbLSC+tvMzYh7Rt11hJl+GNeNZ/iTfyRz9bYBhLHn6CV+iv7KW
         AN9CMwlP6SDjlfI/CltxJYHXQ17FqeCg0BTOH8IbxvENI3/ClYU9B0iFdO6s70cZ+ls3
         7/md1sr7bxy23QtBxeKZrIqTEc/7bbkUCs2vZ9UxFyCU3HfvMt6/ki/Wnhaq9fjQz9cr
         iyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GevoxMiSfxAK6DWxOjcnTXy4acQvtt6FLw9M5kaA7GE=;
        b=E027Lbw1E7fx0WxoGhC26CSzmU5YcxLqHIBdmzHYrOr6dPFzlUYZatnETvciZ2iZot
         JtwTn1o1XPrTodEGs1pcjRz3DEMh0ysw2tqFj1UsUoVV9YqR8bCqOqckqvceho7070wr
         Cy9PAoTNlMqZ0mYLUgGJFROTW7+ma5VJylaJP5ZDxaP5H7CKqStFKwTI2Buys612eITG
         UjK4JOZuEAt6w8umuwqtCvNidZh5Nxppd6lg7ZLW4XrGakCBRLadVxgP63qCqIA3gzUO
         RXuQorG+/QV5RqO6JQaTfbyRB3TCCIdY3o+W8fGbTPTXBPqepyajdFzfgl64y+H2E0dd
         umsQ==
X-Gm-Message-State: AOAM5307bd2dLdFX9Wueh2sFXtXpCamW8Lg6qfjkUyPL5AlC/FPvzmwx
        OQyLBTup7UMqOJ3oi38i/A1HrglhazX9gQ==
X-Google-Smtp-Source: ABdhPJwgZZd6Bd0z84qMNricPpxhUMa9QRg6Igl29sY8Qw3jgTBUDQyNLZp2hVfjpkUPzTohtWzkXw==
X-Received: by 2002:adf:9e43:: with SMTP id v3mr35896441wre.306.1602585052655;
        Tue, 13 Oct 2020 03:30:52 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4969:6200:8c9c:36cf:ff31:229e])
        by smtp.gmail.com with ESMTPSA id p4sm28458634wru.39.2020.10.13.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:30:52 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 1/3] block/rnbd-clt: remove nr argument from send_usr_msg
Date:   Tue, 13 Oct 2020 12:30:48 +0200
Message-Id: <20201013103050.33269-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
References: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The argument is not needed since all callers pass 1 for it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index cc6a4e2587ae..cffb750db7a4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -433,7 +433,7 @@ enum wait_type {
 };
 
 static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
-			struct rnbd_iu *iu, struct kvec *vec, size_t nr,
+			struct rnbd_iu *iu, struct kvec *vec,
 			size_t len, struct scatterlist *sg, unsigned int sg_len,
 			void (*conf)(struct work_struct *work),
 			int *errno, enum wait_type wait)
@@ -447,7 +447,7 @@ static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
 		.conf_fn = msg_conf,
 	};
 	err = rtrs_clt_request(dir, &req_ops, rtrs, iu->permit,
-				vec, nr, len, sg, sg_len);
+				vec, 1, len, sg, sg_len);
 	if (!err && wait) {
 		wait_event(iu->comp.wait, iu->comp.errno != INT_MAX);
 		*errno = iu->comp.errno;
@@ -492,7 +492,7 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
 	msg.device_id	= cpu_to_le32(device_id);
 
 	WARN_ON(!rnbd_clt_get_dev(dev));
-	err = send_usr_msg(sess->rtrs, WRITE, iu, &vec, 1, 0, NULL, 0,
+	err = send_usr_msg(sess->rtrs, WRITE, iu, &vec, 0, NULL, 0,
 			   msg_close_conf, &errno, wait);
 	if (err) {
 		rnbd_clt_put_dev(dev);
@@ -581,7 +581,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 
 	WARN_ON(!rnbd_clt_get_dev(dev));
 	err = send_usr_msg(sess->rtrs, READ, iu,
-			   &vec, 1, sizeof(*rsp), iu->sglist, 1,
+			   &vec, sizeof(*rsp), iu->sglist, 1,
 			   msg_open_conf, &errno, wait);
 	if (err) {
 		rnbd_clt_put_dev(dev);
@@ -635,7 +635,7 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 		goto put_iu;
 	}
 	err = send_usr_msg(sess->rtrs, READ, iu,
-			   &vec, 1, sizeof(*rsp), iu->sglist, 1,
+			   &vec, sizeof(*rsp), iu->sglist, 1,
 			   msg_sess_info_conf, &errno, wait);
 	if (err) {
 		rnbd_clt_put_sess(sess);
-- 
2.25.1

