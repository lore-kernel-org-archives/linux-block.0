Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB372C4332F
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 01:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhKYBuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351945AbhKYBsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 20:48:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B023C07E5C3;
        Wed, 24 Nov 2021 16:54:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y7so3285847plp.0;
        Wed, 24 Nov 2021 16:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfw9u2dgKWMvFM+zv9k6Og/5ORjy5xYA+ZKABDcLG0I=;
        b=JPf4Zlb8stgQin4wu9U2SPJdBOkXEjJWj5xZpZsGHWHV3aHFQE+ZeTUtD8S/iHDceh
         KB+GfVzT4+7ap93df0I/eZIORH50vjjvF0cFsxLkid4ySMGflKVwfCXpyiAtjFeLilee
         bI4kSU9yxEsDo71/cIht2ygmqTBn1SuoT1SNQpA5jNO8U64xL8heOc6ciVq+NlTl2DQA
         293snpeq6DPCfxlpoHIsVLylODjvc0kLIZAdc5AY2SGmoMCliUaed47bXaI6ossDa2ki
         6KjpDZsxl+NGbahSaTiE8ziV6jr2qr2lRJxt+cpF09NMel/hDng+gr35vPYvbr7xibi/
         JT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfw9u2dgKWMvFM+zv9k6Og/5ORjy5xYA+ZKABDcLG0I=;
        b=S9i14o3WWB5XdiIeTBmMziM0X3Ag2b8Bw53dyHSd3hq2nYWsc4htkTQs52KCj3psf1
         Ol8F2/nGeACAl4Wd9yVesehfQ6PzL++QOoldJ6aEeMhviWDR3L63SkP6YwcmoF5CLvfo
         0zHCrDlUGjyp6u1bWBpHDaDKIB+MUISdQMYhYZ8GNxN/F+OLJwXnfUgyM1XuNZf5Jt80
         9vAiAp955aswwBVfEjuyhyv4wRJPhkPVKSROPDTCJFv5+Mm1nzR1iRSopIt9aipLq7zs
         BkzfYv2ZeLwC/CWiq37MGHqmYjoSJq3XIONeS3nFdyL9cgXHNXomznBKflSzwuoLLsEH
         6EWA==
X-Gm-Message-State: AOAM532JNAfrYnmObg93h9ZA5Cz3TXa+9wGBMF0piZt2XtVMlkQc2m0s
        f7nNH1JSMef5+RxZH/spkws=
X-Google-Smtp-Source: ABdhPJxW9UHirSi0C8d6l7D4hHExfez0M7O4YPi0gKSOyE2fv/HPLMQk9KyfcTe8oXt67764zowOXA==
X-Received: by 2002:a17:902:c7d5:b0:143:72b7:2ca5 with SMTP id r21-20020a170902c7d500b0014372b72ca5mr25069292pla.20.1637801669207;
        Wed, 24 Nov 2021 16:54:29 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id f18sm888112pfk.105.2021.11.24.16.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:54:28 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     axboe@kernel.dk
Cc:     davidcomponentone@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] block: fix parameter not described warning
Date:   Thu, 25 Nov 2021 08:54:15 +0800
Message-Id: <3ece7228314e89177d022cd514215d8c76485fb8.1637735436.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The build warning:
block/blk-core.c:968: warning: Function parameter or member 'iob'
not described in 'bio_poll'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6ae8297b033f..2053d1b0e90e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -956,6 +956,7 @@ EXPORT_SYMBOL(submit_bio);
 /**
  * bio_poll - poll for BIO completions
  * @bio: bio to poll for
+ * @iob: batches of IO
  * @flags: BLK_POLL_* flags that control the behavior
  *
  * Poll for completions on queue associated with the bio. Returns number of
-- 
2.30.2

