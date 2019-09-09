Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCFBC4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757CC218AF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9VNdLOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfIIM5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:57:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35631 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIIM5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 08:57:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so13780854wrx.2;
        Mon, 09 Sep 2019 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPHSShEVgX1o3hoQrHIRgOlZyiwWjYnloOHsAiyPNjI=;
        b=F9VNdLOA8XjYjrsC7+AwkfLub3TsiRkARzX4PXB6kh1oZ6gnmiCIUBuEWnLSrq5Ye9
         dW2otbl0bWImTd3MgOj5qSzNUnte+paWlk1fr4RDgZTfx9KWsdVoF1PP16DOoSNR58h5
         n+W38KZkIUnxvv0Br9VQjXxLXHOPbuOmFA9f+pKVBJKGVXN3+/f6kk/+yrQ0ejCKiFYA
         iocFpc9QPUu3b/w11P7jJtVYguEarsX83N/W/SNzjPjbBmxS9EHOrNv9V9iju0r+q0oE
         2Yc53y0JntSs410kodXn7UmnDe9x5jDdppLq7jipLVdbUvqEyq5YOpr9oeLgc5r1d9d2
         5dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPHSShEVgX1o3hoQrHIRgOlZyiwWjYnloOHsAiyPNjI=;
        b=WdIiFVfOQWlGrXzZQVMg/xjBUC1u++Kfwh2D3m8fjW/3j4UCdJgVvEbUav/e387vKY
         Av+1MFmbkTYqM0YdSzUpX4pAtNcnGzaohcxIVAY/M522DbuWC0B6/zglPGXcItJf5VYT
         bgKnlAkpYjdPQsnEQOOJcuaYb/WPEiybozY6QzgR740yEsPSXUYqJI8KOlJ3WodT46A1
         hdk1FZNhpIKhM1/z1c/iFQ+qbsMZ7311y0GCR8WKlwqxKcYi0h1CgxCTH3MTKJ8JDpGl
         x55xFTfSb4qUmaZjRSlt16JY2yksmAztIzpUEJ13y/67XuIh7voinFyBAjq94VMP3Ftt
         N2DQ==
X-Gm-Message-State: APjAAAUzqw2k/rDrK0f3xrCqJ3dAzp2qDYhPhta+R1x9ZV7oOD2QVCaA
        pTmFsjKyaPtfJ/al4vUz3wk=
X-Google-Smtp-Source: APXvYqx73APToU6Hahs0k7eqcalmsnDikGPQwWdcHU66pqu16WZ7ydCQs8MHpdYJdkUdfx2uXGxo5Q==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr19983012wrr.334.1568033822637;
        Mon, 09 Sep 2019 05:57:02 -0700 (PDT)
Received: from localhost (p2E5BE0B8.dip0.t-ipconnect.de. [46.91.224.184])
        by smtp.gmail.com with ESMTPSA id m3sm12917929wmc.44.2019.09.09.05.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:57:01 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christoph Hellwig <hch@lst.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/3] block: Respect the device's maximum segment size
Date:   Mon,  9 Sep 2019 14:56:56 +0200
Message-Id: <20190909125658.30559-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909125658.30559-1-thierry.reding@gmail.com>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

When enabling the DMA map merging capability for a queue, ensure that
the maximum segment size does not exceed the device's limit.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 block/blk-settings.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 70b39f14e974..9fb1288fbc12 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -738,12 +738,8 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
 }
 EXPORT_SYMBOL(blk_queue_segment_boundary);
 
-/**
- * blk_queue_virt_boundary - set boundary rules for bio merging
- * @q:  the request queue for the device
- * @mask:  the memory boundary mask
- **/
-void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
+void __blk_queue_virt_boundary(struct request_queue *q, unsigned long mask,
+			       unsigned int max_segment_size)
 {
 	q->limits.virt_boundary_mask = mask;
 
@@ -754,7 +750,17 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	 * of that they are not limited by our notion of "segment size".
 	 */
 	if (mask)
-		q->limits.max_segment_size = UINT_MAX;
+		q->limits.max_segment_size = max_segment_size;
+}
+
+/**
+ * blk_queue_virt_boundary - set boundary rules for bio merging
+ * @q:  the request queue for the device
+ * @mask:  the memory boundary mask
+ **/
+void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
+{
+	__blk_queue_virt_boundary(q, mask, UINT_MAX);
 }
 EXPORT_SYMBOL(blk_queue_virt_boundary);
 
@@ -843,13 +849,13 @@ EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 				       struct device *dev)
 {
+	unsigned int max_segment_size = dma_get_max_seg_size(dev);
 	unsigned long boundary = dma_get_merge_boundary(dev);
 
 	if (!boundary)
 		return false;
 
-	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
-	blk_queue_virt_boundary(q, boundary);
+	__blk_queue_virt_boundary(q, boundary, max_segment_size);
 
 	return true;
 }
-- 
2.23.0

