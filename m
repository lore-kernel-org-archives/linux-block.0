Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4796C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbiCWTrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FA508B6D1
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648064732;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:in-reply-to:in-reply-to:
         references:references; bh=tfNH+5/HwjgUfw+cvmAnjvE/JE7439RWvRdUdw80No0=;
        b=c/aPRBOKUWhpqNx38GbKq9jKBtvofhDFACrwhMSHoIniDTtTXH8Edz+IfiX7uj1KG2Ep/Q
        4aE+iP5KybyDVT2kwpN57OSePkhbPmhd/Dazk1mdQ7RhgEM44FeQwkYZZz6uwNacltuepW
        hEZRbHslr/NaEatiA2yfMZXnbdX45vE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-f_n-DH5SOBWNd_FVkNn8WA-1; Wed, 23 Mar 2022 15:45:31 -0400
X-MC-Unique: f_n-DH5SOBWNd_FVkNn8WA-1
Received: by mail-qk1-f197.google.com with SMTP id d12-20020a379b0c000000b0067d8cda1aaaso1687543qke.8
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tfNH+5/HwjgUfw+cvmAnjvE/JE7439RWvRdUdw80No0=;
        b=vF8YBNQ64Hr4HzrjyL9ULBabIM03u3rJvOn6jGi9sJxXwgeKVTbZ25Rys9fPybquMp
         SPHaoLJ1viM7yVs3Q3rJqYnuAXy2aZVB4qlRY+afJ8zrqUV34ZEIToBd/Byze6BpRnTg
         Uz7vLzMrg3vOmJaaymvfgYd6dgoXgOAHgxRivJPyX44/mO+nIRFl6vsXSdx100W60INV
         HK1cLTRe/X74ysNGGbQp85eABt/pflFU54YUCDLz64aP7YD0ciQ2cnQDfK3HyreCGXhP
         CyJnJyO7YEetEja1yyMkInxXYRFVhG5E5wA4uwyB0DyUMMbOcQlwu1zyXRY3s7IQnH45
         5RHQ==
X-Gm-Message-State: AOAM532KL1LNPe7gXR+oBEFRoqKb78K/+HG48wiUYnYQbFCFlbma42eH
        2DUVdJgvqV89FvY3Ie0Q2ZYJHpNRxqVap9seyKEpAmMPOGksCACPCseB5qHGXP7Ug6hApf8CmmP
        uxpPg7dtFp8FwhjC6nBYGnQ==
X-Received: by 2002:a37:64a:0:b0:67d:430e:2a20 with SMTP id 71-20020a37064a000000b0067d430e2a20mr1067535qkg.265.1648064730571;
        Wed, 23 Mar 2022 12:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkwWOh6Well00wZWN3Pa0vtdo4r0dGuz4vGTky++LCnVcOeEJg91pOXt2yuaRFGau8p357xw==
X-Received: by 2002:a37:64a:0:b0:67d:430e:2a20 with SMTP id 71-20020a37064a000000b0067d430e2a20mr1067522qkg.265.1648064730301;
        Wed, 23 Mar 2022 12:45:30 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm481848qki.33.2022.03.23.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:29 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 3/4] dm: enable BIOSET_PERCPU_CACHE for dm_io bioset
Date:   Wed, 23 Mar 2022 15:45:23 -0400
Message-Id: <20220323194524.5900-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220323194524.5900-1-snitzer@kernel.org>
References: <20220323194524.5900-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also change dm_io_complete() to use bio_clear_polled() so that it
properly clears all associated bio state (REQ_POLLED, BIO_PERCPU_CACHE,
etc).

This commit improves DM's hipri bio polling (REQ_POLLED) perf by ~7%.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1c4d1e12d74b..b3cb2c1aea2a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -899,9 +899,9 @@ static void dm_io_complete(struct dm_io *io)
 		/*
 		 * Upper layer won't help us poll split bio, io->orig_bio
 		 * may only reflect a subset of the pre-split original,
-		 * so clear REQ_POLLED in case of requeue
+		 * so clear REQ_POLLED and BIO_PERCPU_CACHE on requeue.
 		 */
-		bio->bi_opf &= ~REQ_POLLED;
+		bio_clear_polled(bio);
 		return;
 	}
 
@@ -3016,7 +3016,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, enum dm_qu
 		pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
 		front_pad = roundup(per_io_data_size, __alignof__(struct dm_target_io)) + DM_TARGET_IO_BIO_OFFSET;
 		io_front_pad = roundup(per_io_data_size,  __alignof__(struct dm_io)) + DM_IO_BIO_OFFSET;
-		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, 0);
+		ret = bioset_init(&pools->io_bs, pool_size, io_front_pad, BIOSET_PERCPU_CACHE);
 		if (ret)
 			goto out;
 		if (integrity && bioset_integrity_create(&pools->io_bs, pool_size))
-- 
2.15.0

