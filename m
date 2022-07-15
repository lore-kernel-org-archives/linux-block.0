Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFBCCA482
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiGOSrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiGOSrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 14:47:46 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2223C8EA
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:45 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b133so1570086pfb.6
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3eHuEl5s+o4BUs6B7cGxx4/p/uTNMi3vU7THX5iw5Y=;
        b=RLO7Q3LDTvCUs3fdUBwHFt5xN012m0L+q9jPVSxtUZNfQKvQNQCA18H0SmkriNe0EN
         fG5axBpazYrTztArTNfXTiu8IrHkRpyinq9/GPqD/Fixl5ieXlJlKjlKW/jr9K8go9/U
         RUzUQAobOAZu29KyfZVlPzEwjW1EVzW2Ajv0LefvhDoXNdbAfn4b/Y+DSYubKmxx/ScJ
         5soKz7C+DOTVwaDkJfQOpEoJEFTRZdp+OT5tRZ9+YKsWNP3gQ4/P1ga4eq+aZCN3SqVi
         4Ni/mlJ/15qo/FvGlYXu+nGBwDxe88/DdjmHwSQIb9BXD55QqS9vIHniEEREeKU6E6We
         aYcQ==
X-Gm-Message-State: AJIora/+R7OSZ2XdIzAekEK51qbRkK3ChouBS+j3zo2I/77aYp+QIrZQ
        iQh0Wtt98+ZIOKeLmK02LPg=
X-Google-Smtp-Source: AGRyM1vaqoI+sRfhcExYQzfld5AThsL55q3uUCTK9mqbYl1oGoIbneCwfHERJ+vGRabGm0HTpQTRqw==
X-Received: by 2002:a63:ec47:0:b0:419:7e6d:19b5 with SMTP id r7-20020a63ec47000000b004197e6d19b5mr13648913pgj.256.1657910865380;
        Fri, 15 Jul 2022 11:47:45 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2e39:7b26:bf0e:fb58])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0016c2cdea409sm3880490plc.280.2022.07.15.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:47:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Li Zefan <lizf@cn.fujitsu.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] blktrace: Fix the blk_fill_rwbs() kernel-doc header
Date:   Fri, 15 Jul 2022 11:47:35 -0700
Message-Id: <20220715184735.2326034-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220715184735.2326034-1-bvanassche@acm.org>
References: <20220715184735.2326034-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reflect recent changes in the blk_fill_rwbs() kernel-doc header.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 919dbca8670d ("blktrace: Use the new blk_opf_t type")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/trace/blktrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 150058f5daa9..7f5eb295fe19 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1873,11 +1873,11 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 /**
  * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.
  * @rwbs:	buffer to be filled
- * @op:		REQ_OP_XXX for the tracepoint
+ * @opf:	request operation type (REQ_OP_XXX) and flags for the tracepoint
  *
  * Description:
- *     Maps the REQ_OP_XXX to character and fills the buffer provided by the
- *     caller with resulting string.
+ *     Maps each request operation and flag to a single character and fills the
+ *     buffer provided by the caller with resulting string.
  *
  **/
 void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
