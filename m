Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3CBECAAD8
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiIVSbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiIVSa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 14:30:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C0B10D666
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 11:28:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p202so2165329iod.6
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kQJ1C1SjENmgCWeZQvNCbMqCIh5TAvtoZAf25z/EVT4=;
        b=pDHEDqNu7gIG1tZwKjXkijlAv3FbeAirIAJbQJQAChrlUlJo/pXRxqh4kPVNmZHRN0
         ho2TBXNKrJRs0X0PuTx/XSnV1N/3gEMyvAD+PKLBJABAtrtukOHMYmJlaoXTrGEBJZYu
         Wz9Bnx81LWQKMEHsI3dQbaXqmEUiiUrrFm3n9mgBmkwa1hddM0Bnm5cAAjO9D4tR+m7F
         xGfFlpuxYbyEkJe3z68GYesMmaq9y6k6UwVXEc1/rc68JCnvYnX+blLE1vt0O+IbMk3C
         63jF4C+tW0MfbGRhjK3il/WqkrNi9L+bhW9W4BEXr3cIS/fKD6C/TMNWY747CKcKVQhe
         r35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kQJ1C1SjENmgCWeZQvNCbMqCIh5TAvtoZAf25z/EVT4=;
        b=uqCoUQyoSOZbvglPXQ93Zji8DzOtDwNa3CRaPP5xYwJwgUzSajVo3cZdLgYAt1jbR4
         BbVHRS5FUzSv2VOsqawBzKDvdzODTAAzJcaAUGX+r87iDcEhxCsoN14MyZk0CrzSl7Ka
         Zuy9aQitszUh2aY954oskFkk+/Yp2fxm8ZbiTLHMsiE4eNIxMG+Dndaiw3XTW7UGzmXd
         6J0DEq8canUqoqL1V/hWr2J5pSAQ5CadGkheBwo3wuxjZNzfMHt4PaC5TY7OYR9hgcar
         MYmwomjpYTNSWyXFBoZNWGMaZELeIzz+aXgGQ9M39Nltmmj3PDGLl504HCo0+SeSNK8y
         22gQ==
X-Gm-Message-State: ACrzQf21Ir0gtcJhPrRbdAnbHztvEj1VAm7czM3GwjL3CYqbOdHnw00y
        YNR1hmyQEIbaHg0Ul2I1OWBnZTFiodhMFg==
X-Google-Smtp-Source: AMsMyM7wM97v1Oqw5RrX8wIN6VT4gEUijfOCbtCcdhJgZwn4LHZr9RZRcQ17ytyb3H0/RwWNoOeDOw==
X-Received: by 2002:a05:6602:1352:b0:69d:e793:abd with SMTP id i18-20020a056602135200b0069de7930abdmr2341538iov.172.1663871292289;
        Thu, 22 Sep 2022 11:28:12 -0700 (PDT)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q20-20020a05663810d400b0035a468b7fbesm2440646jad.71.2022.09.22.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:28:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, Stefan Roesch <shr@fb.com>
Subject: [PATCH 5/5] nvme: enable batched completions of passthrough IO
Date:   Thu, 22 Sep 2022 12:28:05 -0600
Message-Id: <20220922182805.96173-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922182805.96173-1-axboe@kernel.dk>
References: <20220922182805.96173-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the normal passthrough end_io path doesn't need the request
anymore, we can kill the explicit blk_mq_free_request() and just pass
back RQ_END_IO_FREE instead. This enables the batched completion from
freeing batches of requests at the time.

This brings passthrough IO performance at least on par with bdev based
O_DIRECT with io_uring. With this and batche allocations, peak performance
goes from 110M IOPS to 122M IOPS. For IRQ based, passthrough is now also
about 10% faster than previously, going from ~61M to ~67M IOPS.

Co-developed-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1ccc9dd6d434..25f2f6df1602 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -430,8 +430,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 
-	blk_mq_free_request(req);
-	return RQ_END_IO_NONE;
+	return RQ_END_IO_FREE;
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
-- 
2.35.1

