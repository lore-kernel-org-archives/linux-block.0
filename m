Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37156EB64D8
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFUQvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjFUQvJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 12:51:09 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21D1BFE
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 09:51:00 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-668723729c5so2707099b3a.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 09:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366260; x=1689958260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYtprP5m30Jdts25EMNZrKTbphL4l+vxdtzR8o2UAK4=;
        b=FJFYPntEw15gWzSPKS2JkEjymiqBrGArv6DeUVwMKyLDCL5PkIgfY/ROcadA3zCN4a
         jcE5iE0Jjwhu/CeZPjdrc/hN2kab88h5YKKleI1j0ixF16WIBIz687OliOo2BujUirfX
         jQpAbRwV9eStYwmGKElYe/sKJFjOcBhelQV/rzPMFELebkBcYqAVuRmSLJ5Fu5ubeImi
         LA5B6l6zio7nxREJQX88rii5rFv57ANy4yDxQ6Vh0uu0he2YYgvRwlNfOD6j8vrUjM74
         fSG8cm816NGiZy+7ZV4OjtCPy+vJ9hm/Oxd76+5zrPsx8pMn54lu1a4p6ck88D1EUvBK
         YhHQ==
X-Gm-Message-State: AC+VfDxCF1MasuMb3RtMEFsEzMZF828OvkF2ORw3Jkc2+9sS3dy8bhDh
        dz1thB4pW7OPtuG53S7dnRM=
X-Google-Smtp-Source: ACHHUZ55RNOaGfyMYKbPFxUHzCpLU073/3JDT6r5W5daOlClSNYL4LcsEDv7xr1cu0TGqLuvCjw9ew==
X-Received: by 2002:a05:6a20:4294:b0:114:c11c:7ad5 with SMTP id o20-20020a056a20429400b00114c11c7ad5mr17063300pzj.52.1687366260101;
        Wed, 21 Jun 2023 09:51:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id p23-20020a62ab17000000b00668843bee48sm3108443pff.218.2023.06.21.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:50:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: Improve kernel-doc headers
Date:   Wed, 21 Jun 2023 09:50:54 -0700
Message-ID: <20230621165054.743815-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the documentation of the devt_from_partuuid() return value.

Fix the following two recently introduced kernel-doc warnings:

block/bdev.c:570: warning: Function parameter or member 'hops' not described in 'bd_finish_claiming'
block/early-lookup.c:46: warning: Function parameter or member 'devt' not described in 'devt_from_partuuid'

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 0718afd47f70 ("block: introduce holder ops")
Fixes: cf056a431215 ("init: improve the name_to_dev_t interface")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bdev.c         | 1 +
 block/early-lookup.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 9bb54d9d02a6..979e28a46b98 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -561,6 +561,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
  * bd_finish_claiming - finish claiming of a block device
  * @bdev: block device of interest
  * @holder: holder that has claimed @bdev
+ * @hops: block device holder operations
  *
  * Finish exclusive open of a block device. Mark the device as exlusively
  * open by the holder and wake up all waiters for exclusive open to finish.
diff --git a/block/early-lookup.c b/block/early-lookup.c
index a5be3c68ed07..91002b19d09c 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -32,6 +32,7 @@ static int __init match_dev_by_uuid(struct device *dev, const void *data)
 /**
  * devt_from_partuuid - looks up the dev_t of a partition by its UUID
  * @uuid_str:	char array containing ascii UUID
+ * @devt:	dev_t result
  *
  * The function will return the first partition which contains a matching
  * UUID value in its partition_meta_info struct.  This does not search
@@ -40,7 +41,7 @@ static int __init match_dev_by_uuid(struct device *dev, const void *data)
  * If @uuid_str is followed by a "/PARTNROFF=%d", then the number will be
  * extracted and used as an offset from the partition identified by the UUID.
  *
- * Returns the matching dev_t on success or 0 on failure.
+ * Returns 0 on success or a negative error code on failure.
  */
 static int __init devt_from_partuuid(const char *uuid_str, dev_t *devt)
 {
