Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D27EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F9961250
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKDVP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDVP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 17:15:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FEC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 14:13:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s24so9460876plp.0
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=52DV6cBtZaYVrnaaoETDY/1/+4li/7mcMcQzrTKASaE=;
        b=dhm0HG5uS2DYZmlkJ0e77pWwlX5dcW6f4WUgAWsrnsWrw74VFQslkVOTMmHQV3dnhX
         F48cJsuqZJrjQjXjqKgM2u3JImoQxAyy9jMAQFjdI8fX9oYfg4ufRg2DBAnCIy3bx50i
         YmiYgJ7diuDCXaz8ZAUnitxdfyh8nCzyvbRFDXxAi/nYPdIF4JP+CAqnng5mMOe1+gCv
         iJXbya6Gh9ymo8riINFWLQVFUK8stslLnPYPCAmck7jnmgO1NejYFISZLMU7GLcMTwIw
         45ekL33Ru7GdMIPNLpsa6uPLvv4uJmpsALMowlSK1z9LilXhqOMuq0BlFrG1SNqwkx/q
         hlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=52DV6cBtZaYVrnaaoETDY/1/+4li/7mcMcQzrTKASaE=;
        b=JLFSWaOVNkVVg+uuOHsSa7eUB0PDRzCADApllQMsVeWC6JFGOTjf4F+N8tmaM2vW/0
         0KCNutqUYL3inNPNAed3Hp4D66MIoZmRqrYSprXAzGfznog+0qqAh8VYVTv3O1vIOGYi
         yi4jEfKGpOjMQpN3TnT76ezl67CNGD8jES58zlle3TBImxHbWQPrfutNrP9R/amloZyy
         vLW7Px27MP24TgXAYK4grX4RbKv0Tud90LG3i5X+eZumOKUSvPDuYln6MM/gle+EDplF
         dVWsOtfRzubesc5e8TDRkfL6tkXYMcsr5W/h/i/MlRPMUHNhSyqjUejLBLiCYPOPg061
         25sw==
X-Gm-Message-State: AOAM531ijzsnApQkhRRTBM1nS9Csz2Lf22vDngLILfxgNmN5X0AE/Myv
        7htk2y/96WldBZrSNSbLS7ax9lfwXMoe5C7b
X-Google-Smtp-Source: ABdhPJwFY8OWcPOvpq1llJQs+iqj25mhYkBEdEKAslQUmAZPN2+D0NWZVgQT72CkaUj2goJPilzgPA==
X-Received: by 2002:a17:902:7d89:b0:13c:a5e1:f0f1 with SMTP id a9-20020a1709027d8900b0013ca5e1f0f1mr46840415plm.24.1636060399965;
        Thu, 04 Nov 2021 14:13:19 -0700 (PDT)
Received: from ?IPv6:2600:380:b436:eb3a:fef9:fbe6:909f:2d6a? ([2600:380:b436:eb3a:fef9:fbe6:909f:2d6a])
        by smtp.gmail.com with ESMTPSA id m22sm5707863pfo.176.2021.11.04.14.13.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 14:13:19 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: use new bdev_nr_bytes() helper for
 blkdev_{read,write}_iter()
Message-ID: <a72767cd-3c6d-47f7-80f4-aa025a17b2cb@kernel.dk>
Date:   Thu, 4 Nov 2021 15:13:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have new helpers for this, use them rather than the slower inode
size reads. This makes the read/write path consistent with most of
the rest of block as well.
    
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/fops.c b/block/fops.c
index a2f492e50782..d5de5451fb08 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -527,7 +527,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct inode *bd_inode = bdev->bd_inode;
-	loff_t size = i_size_read(bd_inode);
+	loff_t size = bdev_nr_bytes(bdev);
 	struct blk_plug plug;
 	size_t shorted = 0;
 	ssize_t ret;
@@ -565,7 +565,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
-	loff_t size = i_size_read(bdev->bd_inode);
+	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
 	ssize_t ret;

-- 
Jens Axboe

