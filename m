Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C921C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EACF613DE
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhELVmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 17:42:02 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:41562 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386006AbhELUSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 16:18:43 -0400
Received: by mail-pf1-f175.google.com with SMTP id v191so19473674pfc.8
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Q9lWtKp6O3MX37famVeyX5YRjGCnCKdUkNEU+oA8LM=;
        b=o9pgESDFo10I8xv91e2CaIkmBRGc798Tijx9Pb4HhHq2F6uPc0oSJ2LgxePRp+AGvu
         BquhmvpupaUxjCbpChMMGJ7SclYJAbWIYJIeBXBsOf9ARRVuasRdIKN0QG05LKSKMhtN
         mPJMTa7wLfYLlWhKCc00xGQhDy7qqCjb35t9UA46gC2sdG4Me0xrnPUFrvjylTaOmRxU
         gkAvoibppI1/yYN/jwV5g1L60ptqeBKcQuMdd8JS8dP/hR5+YaQtZDeYvUqxwS5sqqTy
         gtg2yw86GZzIz5/C2uQU4HRcZa/CPAdi19v9fUEfQuuqa+jBIIucsS4QruoQyTNyO8P5
         +lvg==
X-Gm-Message-State: AOAM531iJ6mFPsTH3/RdYZJ1h2yrgB1bNQ39TrVjnhZqWF8wXHoqnYkh
        iWOL+EaXgfUWPAELAGd0J5Q=
X-Google-Smtp-Source: ABdhPJwooP4+C2+dIhEOJ8BwHaOP2iaMAf4KSP3aPckjKrmXWjiHfrNzPRtQiRc0ap63ucDM2x0b+A==
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr276730pjh.87.1620850626080;
        Wed, 12 May 2021 13:17:06 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:993e:1516:b2ba:76fe])
        by smtp.gmail.com with ESMTPSA id v21sm562570pgh.12.2021.05.12.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:17:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] block/partitions/efi.c: Fix the efi_partition() kernel-doc header
Date:   Wed, 12 May 2021 13:17:00 -0700
Message-Id: <20210512201700.9788-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following kernel-doc warning:

block/partitions/efi.c:685: warning: wrong kernel-doc identifier on line:
 * efi_partition(struct parsed_partitions *state)

Cc: Alexander Viro <viro@math.psu.edu>
Fixes: a22f8253014b ("[PATCH] partition parsing cleanup")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index b64bfdd4326c..e2716792ecc1 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 }
 
 /**
- * efi_partition(struct parsed_partitions *state)
+ * efi_partition - scan for GPT partitions
  * @state: disk parsed partitions
  *
  * Description: called from check.c, if the disk contains GPT
