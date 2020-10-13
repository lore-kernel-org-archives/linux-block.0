Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8155C43467
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778BE20872
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QR9G5qPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgJMKa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgJMKa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 06:30:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06774C0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so23362241wrq.11
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkcSdHk5HTR7MlJZO8r78NsxY1UaKI0aJwFJpY0/hM4=;
        b=QR9G5qPgSyvURJ/SEi2utg2YDMqzDE9lKaocv+ULFlMt6i5CU2ouAfNXMuDpPaKmwO
         QLAoPQyeG/eVJ+pILTFlGhtjAkfTyQzMdQ70HOE/9UZ4IiPy6GSl6n/5IrtqwuU8dM/F
         ++deUWIW/4qkfoq0jUF0ZuLG9OlVwc7mHzrv1zXwOhF6S4htgq+tjmPcD0jUIVvSmt3F
         uglrFq7i5rHJd6GXN7egvHXD08uBw+t9J7S/NpZnjMtQ80LcCl5rJB0yRsOPUMh3aZeH
         im60czhm5zgh5WAxIoB+ddAJVIMI68RwjFh+Mwe2RhysRrFmktvD4RM8utoroFxznEJI
         YXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkcSdHk5HTR7MlJZO8r78NsxY1UaKI0aJwFJpY0/hM4=;
        b=CEHVBVExXpETEdbDK+H4PXvzh7vWpQ4AJgU80ENF+G4vjNkc2K18ja5vMZevq55GSO
         QihmL5OcWzsPwGymF/JHx2tYceEoVwefKbalL/Hu/aEc4JRBQPrqWRuTCImLpjrNJRR7
         +o++pQZ+9nHZ42pyxE61/Ga58/4JD7OE52N6iiVK4fTsIv85HlDvsidWIdwsp7D54Ep2
         PDLM90ZqaF9UhWKAJrghZTLW8jqw2rH12HLwEuuQGS3Y5crCWmvnBpEW8WQBDrp65SVw
         xXcfR596JIORfrfHKkCF2FufNKBvfBJTONawObfSCQB6JrZRcDkHmf9wSowQdHLSHa34
         eRlA==
X-Gm-Message-State: AOAM530TOOnWY6z0xLxfB4Qno4z/92SAISkeLClBFOGxEPAtee1GDxCc
        Bjkcd/UWNAUtk5hsUUdBUGQ7ofmijxyJPQ==
X-Google-Smtp-Source: ABdhPJyBYZvqm9jumZh35CckGAGyqGUiK5i933hKAS4wN4X5wL+nqPBvREArs4F9mWecTl4rSD21iw==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr8338221wro.197.1602585054687;
        Tue, 13 Oct 2020 03:30:54 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4969:6200:8c9c:36cf:ff31:229e])
        by smtp.gmail.com with ESMTPSA id p4sm28458634wru.39.2020.10.13.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:30:54 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 3/3] block/rnbd-clt: send_msg_close if any error occurs after send_msg_open
Date:   Tue, 13 Oct 2020 12:30:50 +0200
Message-Id: <20201013103050.33269-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
References: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

After send_msg_open is done, send_msg_close should be done
if any error occurs and it is necessary to recover
what has been done.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 22381aee1cf4..9ab9c467f272 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1515,7 +1515,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 			      "map_device: Failed to configure device, err: %d\n",
 			      ret);
 		mutex_unlock(&dev->lock);
-		goto del_dev;
+		goto send_close;
 	}
 
 	rnbd_clt_info(dev,
@@ -1534,6 +1534,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 
 	return dev;
 
+send_close:
+	send_msg_close(dev, dev->device_id, WAIT);
 del_dev:
 	delete_dev(dev);
 put_dev:
-- 
2.25.1

