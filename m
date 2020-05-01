Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A905C47254
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5169B205C9
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgEANqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 09:46:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41127 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbgEANo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 09:44:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id j3so2625727ljg.8;
        Fri, 01 May 2020 06:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfgY/DHsULUZEl+7rWuesO+JiGINR2RoKVUEnFZIbxY=;
        b=pxXj1FjY94uKiY9NjZ20d37GK+1O1u7oXO9tUyCiEc0ovwW2BufjqFedJyGDc0Ilik
         H7IOODCIGaTPLp2BBkTp80LTjeaCasB377ri6AIYpbUO50nR4GcRHGoGwlUPDPwUjl3y
         krcxBl0CXex5g1po9+OSMxCTRd9JkH6v0BjYgoigBJDTmBNLykM3pwmCyrjP9ur1D4CF
         viuOc3AVKU9OHTmVj+RZBiqPSG3fHiEoN3zqOKnAXcoqE8ZOTPtlWPSyPfj2EoCbL/Rs
         ONL0sWoUiJ68coTmv4LK7EDIHfILo114XLGOtpj7e+y5snA3QOU5+qQ5oca1VmAOY7eU
         AdDw==
X-Gm-Message-State: AGi0PuZcqvRHFNkoUrzYa9Oefr4qpGWV71qxcGO225lRHBeoqHZrOB4U
        MVaPTjKBOtXSCp0qW2096+Jou24KDoY=
X-Google-Smtp-Source: APiQypLLnLvr4dk8xp7GQLrt6zVvZS8jE+F2qmlVymQDLmCndkfNoRtlWTL3RdGAcX7Y5jA6B94WvQ==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr2628367ljn.19.1588340695103;
        Fri, 01 May 2020 06:44:55 -0700 (PDT)
Received: from localhost.localdomain ([213.87.150.177])
        by smtp.googlemail.com with ESMTPSA id b2sm2269194lfi.14.2020.05.01.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:44:54 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] floppy: use print_hex_dump() in setup_DMA()
Date:   Fri,  1 May 2020 16:44:13 +0300
Message-Id: <20200501134416.72248-2-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove pr_cont() and use print_hex_dump() in setup_DMA() to print the
contents of the cmd buffer.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 2817170dd403..3ab6e804b5ec 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1069,12 +1069,9 @@ static void setup_DMA(void)
 	unsigned long f;
 
 	if (raw_cmd->length == 0) {
-		int i;
-
-		pr_info("zero dma transfer size:");
-		for (i = 0; i < raw_cmd->cmd_count; i++)
-			pr_cont("%x,", raw_cmd->cmd[i]);
-		pr_cont("\n");
+		print_hex_dump(KERN_INFO, "zero dma transfer size: ",
+			       DUMP_PREFIX_NONE, 16, 1,
+			       raw_cmd->cmd, raw_cmd->cmd_count, false);
 		cont->done(0);
 		fdc_state[current_fdc].reset = 1;
 		return;
-- 
2.25.3

