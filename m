Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5241C433E7
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5009C20878
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RsJH7UvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgJMKaz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgJMKaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 06:30:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D097C0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so23356377wrw.9
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8NhYOoVB9Nf2uKF0P9dlPP87rVMd52Szhw4LJlmJqg=;
        b=RsJH7UvHJHQr39cHmUlxsVOWUKfLQhQ4q6Gwyygr53QdSwmPqkrxbEmLZlJJETerBp
         Tg8OGJ7XsmOuGMZmPhP18CQ43lLLM8sbq7TR3+sAzWjr6XNx9UYn91Eym1o/VQqXzNS/
         qjYCGsSIMAUeLClTtGrELTbUrkzziOMXJGVAIKaL3FzAB5ZXoFYvWmm6Gri7leL2tXic
         6QXYoZcB8szkmAm2vR/w6rmG7MtWu6xcQRV4UsUhnCZolcw4MVd8qUAqRyDtkPcuZYl1
         3DMpQCr5+kfWwJSt6XkIZXTS8HVk+Kbgh+Tp3WHe3Gh698BxsFv+NsyCdWH1pXITv69p
         2S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8NhYOoVB9Nf2uKF0P9dlPP87rVMd52Szhw4LJlmJqg=;
        b=M69+F0R8OgKK5pGqP49nxUo2spH3SBaEjLMRJcOPltHMtaXK9bq15unLAAfr1fsEmY
         0A7uJDBM6Z/+kkXBZnc1lp2Ypan3Z8gQS8lJM5pt+0XRx2ADQPm3k9JqZQF6mj2u8KWq
         LhGoej10pl7JTu/cuPk9bAHxsNCSwVwri1GTAckAy6t/ohaHWh8IHMxB1r1ULwFxooQV
         3jNRqH9R/fALy/gsZr6Q4IfFP15ji4wfHxsxvqUCb70uqtepIYIPgc1z9uDOXnK2p+0l
         lrWun+Xq2OSnYKZp3HqctyaJFeSNR6TeVMk8NKajpVZnph4qzw9uck3uZqzOBzCCxa07
         WR0A==
X-Gm-Message-State: AOAM531Q2vBigNqhIHJmOiiyQVMfRcD2vLYZlMf80FiPoSQrSzDbNBu+
        rMB+12oVrTHv0xR+NMr1fXn/da550V06Wg==
X-Google-Smtp-Source: ABdhPJzRu4AvsHW13mfY+Bfa3Tam0kqA2rzno1nvc4prUFn+xKaC0d70elO8fObaIxbQVm0fIbcpKQ==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr26801081wrn.94.1602585053639;
        Tue, 13 Oct 2020 03:30:53 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4969:6200:8c9c:36cf:ff31:229e])
        by smtp.gmail.com with ESMTPSA id p4sm28458634wru.39.2020.10.13.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:30:53 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 2/3] block/rnbd-clt: do not cap max_hw_sectors & max_segments with remote device
Date:   Tue, 13 Oct 2020 12:30:49 +0200
Message-Id: <20201013103050.33269-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
References: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The max_hw_secotrs is only limited by the transport, not remote device,
block layer on server side will split to the device limit if it's too
big.

The max_segments, similar, and rtrs server will submit single buffer, so
no need to cap.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index cffb750db7a4..22381aee1cf4 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -91,11 +91,6 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
 	dev->max_segments = BMAX_SEGMENTS;
 
-	dev->max_hw_sectors = min_t(u32, dev->max_hw_sectors,
-				    le32_to_cpu(rsp->max_hw_sectors));
-	dev->max_segments = min_t(u16, dev->max_segments,
-				  le16_to_cpu(rsp->max_segments));
-
 	return 0;
 }
 
-- 
2.25.1

