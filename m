Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A0C433EA
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06D961955
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhC3Hik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhC3HiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F7C0613DA
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so23297338ejc.9
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdgX4znbSbRT87gcC/hvyjTwqemHSW7vhlSYDeMUDTc=;
        b=h/w53RSEvs+1BUVdsJ7V2P81Tw3tc+ZGfi1ZZoQ8yeeg4cyndnDqpBj5iOhpVU4Pip
         JaYKgdU2SVd4k2WqTeIlqOVrR5TGRl7sfe9aRCQ4E1AY0zUcakGAy8opoPxPwFX2QvUW
         xDlt3ZDzTM5BwRtg0htDrZxQR8tMVi6lKjElcOOMCo7x/bqMPEEUKUVjJGMedZ3lcM2m
         HMLdxMdaW23HrpaR20DY/4YFHpa+/E2S2EzGLA1mtiPXrsBEX/jHmvIOvfk5BV1jfQAg
         sCAr2izh15PPTUFb55HOBAuTqJc0bAcppG55JBrzkTbvSSgaU9ZdLThK8MQuTwbaI7+F
         6Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdgX4znbSbRT87gcC/hvyjTwqemHSW7vhlSYDeMUDTc=;
        b=UlFSFlsA5KVCMHJ7Kwagcy1l/S8J51dwwbmodsSuFK819vgnnfi8UJCikTWqvD1aDh
         Z0kZrBMEm9pYkqP73JgQp1JbSpvqkRLZXB6qrmWwfSPs+rerkBJflaaO53Vd2sAuc/6S
         1W89Y6N1upAfnrraYhQw6nB2a2FPb6wQWnTyrDeiO7udAVhwlTn5X32ggBvaA1pGfsEX
         +Q4loH12YDL8vp3youTTE2uvcefbAoeu9HcyCJNF9yDOol7+rple9B5WzTk2FQB8+OJF
         o0NYbOYITvQXIFOhKxb19C7mOqLKDhqYdrVsxTihisHrvnnPVbQqzJGYT987Sl6WYPuA
         jTUw==
X-Gm-Message-State: AOAM532a9fmj0WiuOciQSkrvY9U91V2FevietsD0KV2BBRMb1mUSUrZN
        Wpi9T87Ww7VmJcjmocRjZvHMSDhh3crLtre4
X-Google-Smtp-Source: ABdhPJyRPruDJnC6HaEWj+pxK6CxNFI1tMbGQeV3BRKTZk47KxA7VX5n8fUlTxW5eBNFcXzwBBdSmA==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr31076641ejb.264.1617089882521;
        Tue, 30 Mar 2021 00:38:02 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 08/24] block/rnbd-clt: Remove some arguments from insert_dev_if_not_exists_devpath
Date:   Tue, 30 Mar 2021 09:37:36 +0200
Message-Id: <20210330073752.1465613-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove 'pathname' and 'sess' since we can dereference it from 'dev'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8c9a02c8b8bd..c8de016553a9 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1477,14 +1477,13 @@ static bool exists_devpath(const char *pathname, const char *sessname)
 	return found;
 }
 
-static bool insert_dev_if_not_exists_devpath(const char *pathname,
-					     struct rnbd_clt_session *sess,
-					     struct rnbd_clt_dev *dev)
+static bool insert_dev_if_not_exists_devpath(struct rnbd_clt_dev *dev)
 {
 	bool found;
+	struct rnbd_clt_session *sess = dev->sess;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname, sess->sessname);
+	found = __exists_dev(dev->pathname, sess->sessname);
 	if (!found) {
 		mutex_lock(&sess->lock);
 		list_add_tail(&dev->list, &sess->devs_list);
@@ -1528,7 +1527,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = PTR_ERR(dev);
 		goto put_sess;
 	}
-	if (insert_dev_if_not_exists_devpath(pathname, sess, dev)) {
+	if (insert_dev_if_not_exists_devpath(dev)) {
 		ret = -EEXIST;
 		goto put_dev;
 	}
-- 
2.25.1

