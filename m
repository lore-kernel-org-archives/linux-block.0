Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BCC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A3D206A3
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="ohM6AEXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfGaJmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:42:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35377 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfGaJmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so65006590ljh.2
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCrB5ySZUcR28Rx9lWPqtsy+QKHPyb7HykwAFaRFqlU=;
        b=ohM6AEXwlJ8JvsmmDKw7ZGh4xVhzDWdJplwFu7vnXSndsSC3nHaIVCeKCraa7czupb
         j9MK5E4NpZf7yMl2Xy6hDqpSOyyWMdmE+ejqsEo4Ud4xqfl4tDK7qrWsBZJC6KOldfmO
         j0kCSWCQORgN1gRrrcFRZ8IYDt0l6t1fIE3BQhKCL1+FeigsAwQVMHyxfN3r0OTiJVHr
         XSwHg08zBqZJ51gjqwARIziUHDj3P746h1qPfUAYDtFn0Fs0lO7uEaRyGG/Zrq/h8QeT
         KyhkFuMxeEBWGJEDwwRPqKcmTSoVwfuVJi+13RiBAMfX+sw/5g+8zqhEYP7YvKVRbNOp
         Y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCrB5ySZUcR28Rx9lWPqtsy+QKHPyb7HykwAFaRFqlU=;
        b=o+/5Swm+o4HyV74x7fHSes4RTUPVSxuIg0Fo3lV0RPt8GCcUMSKyy0WzzH1hyKnrVT
         eGrVoZbDHSrV/l4gQ1CgWV62BaSmSoF5pnFtesuBe0kwcAlBbjeH840lLh84j4P1BwtK
         3u90J/hysAclLHocxMwwsfIJvdbgo8VxEp4U1kCIHisEunnb/Ote3ZP6JTABK1Ph3x7T
         oUBIv7Kf11ILfeLhToUx+eIhZu9rMGrzaE1IWxAwGLzBpqy6ApW3YP6O0OXmIWAaapp9
         SjcL+T+k0yaUsJDAsLyv+WfLgT13VSWM64vGaHFwHH+16V2c0t6VCmEm9mXmSVa6CAmL
         mY4A==
X-Gm-Message-State: APjAAAXo+a+w5fW0qcUB+uDicSjLNUogz7sRP9rtlrOa0CcIA+LY1CaG
        N9iircKBeDQESrreRlLME5o=
X-Google-Smtp-Source: APXvYqyBegkSyiU4m9zufYeMcW3WRboBF6uzdFMkPzmlZiDBXYx7+7BVn4rE8c+1CuTM7jKd+LIGOQ==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr64670727ljk.70.1564566138274;
        Wed, 31 Jul 2019 02:42:18 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:17 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 4/4] block: stop exporting bio_map_kern
Date:   Wed, 31 Jul 2019 11:41:36 +0200
Message-Id: <1564566096-28756-5-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that there no module users left of bio_map_kern, stop
exporting the symbol.

Signed-off-by: Hans Holmberg <hans@owltronix.com>
---
 block/bio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7651ec..96ca0b4e73bb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1521,7 +1521,6 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
-EXPORT_SYMBOL(bio_map_kern);
 
 static void bio_copy_kern_endio(struct bio *bio)
 {
-- 
2.7.4

