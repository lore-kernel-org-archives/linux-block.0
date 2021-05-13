Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B85C433B4
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030CA6143B
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEMRSZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 13:18:25 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44823 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhEMRSZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 13:18:25 -0400
Received: by mail-pg1-f179.google.com with SMTP id y32so22063604pga.11
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ijXWusd5UMBKPJOoFLTSljTj1G5hxRKirrkYAXWQM0=;
        b=imeFYUL+IrdeRnuEHordBAcaPjiypVxPwd0LlB+jzPXIIe80JULfUPzUXbFEm9t2ZW
         bTfA6eXxGPTOziZuP/daegHTXx46nApBVlK36I50hJzur8DeZTPaiMOUv6zAWK1aswx6
         h6hDzxepvXoEKnrvZfARQiRbrpAwedt3T22TGrfH/7jHui7wcXxBQRgym6ghihyJi9l7
         cqNKmskZ/LH7eCxEx5N/u9bsTRsiyma9SD40KF9XWiT7yKlM0PSzZIgdPSCVdwNWZoqq
         miL7PK90ukQTANfEfHWNrt1viNrz2qzZGFhh7m0O92+nE99RdsW0hfeXuGLiG6x3vHlB
         u4GA==
X-Gm-Message-State: AOAM5333emJxZ4fboUyu2uDW/vXudXydUwYl8qEomnYqJQ4jAYdfKJpQ
        IKBV95HSjlv5SwLeBia8R1s=
X-Google-Smtp-Source: ABdhPJwjH8xDKySySivFgzU1AjRp1L2Y3Kae5N9DcewrpQ0IhP2V2i4iigX3IbHmeWTXhFJOy2XkOQ==
X-Received: by 2002:a63:e709:: with SMTP id b9mr4576005pgi.153.1620926234037;
        Thu, 13 May 2021 10:17:14 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6dd7:5386:8c63:ccae])
        by smtp.gmail.com with ESMTPSA id d26sm2436750pfq.215.2021.05.13.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: [PATCH v2] block/partitions/efi.c: Fix the efi_partition() kernel-doc header
Date:   Thu, 13 May 2021 10:17:08 -0700
Message-Id: <20210513171708.8391-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

v2: Removed Fixes: tag since it referred to a commit in a historical git tree.

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
