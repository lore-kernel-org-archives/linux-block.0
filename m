Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B93C433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959772339E
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MqimT0fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgFTDdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732928AbgFTDah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 23:30:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000BC061798
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so5371550pfh.7
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IA+yT7PCs96a2QLkRTxqRX0+cmxfGmmmnF6nm+mE/f4=;
        b=MqimT0fbxuqxM+QmcrwARR+/amwNiuCI+hP1wCfX1g7kgv7NJcSBiwI/l7uGyvqsK2
         Oxc/+t3p4QpbDzYvQgitVypdVq8W23fO1zrrGQ69Qr0YZljTlWhw1Ev4MY87zvbvDu1N
         bh/IFvhDf4w/OsdEMgGvGYEdX6xS6wWHv8oxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IA+yT7PCs96a2QLkRTxqRX0+cmxfGmmmnF6nm+mE/f4=;
        b=KvjS97B/Q72CLKxUVJCPSx0vrrLV9cJS8B8eWy82W7jOMCLxprXcOBv/PcWomJFcMB
         XilwileaK9W4jfUXizPJz7QHMunti/0MSP+oiY1o+/VTYHBWa/NkTvmXm8O9+8hmeOkn
         PHnSgNQ1ESGEkNHC/gePaL6kWmv+rLHnRw0r1VbboT3PPMoDYIpZYH2taAhoF3PGsCR2
         1/6wzy8oYhYiiDv77gxjOEpF6SZikhs/jzbNNyISTcL7gMhFKYJcek4DXgDDZeS7ZR/D
         86AdPvbPKqIgXfAGfK99svn+w0wfzCKmBLjWrS2u6Tu07KudZ98Fg3npA0w3B5SVnymM
         4Gag==
X-Gm-Message-State: AOAM532eaq71rjmhjRFAm+heEzvA0Xzz/J6QBexWoCtuk7Fq0tFvjkwK
        WeKO2P3lYgu90QL7S5xzfI8xPA==
X-Google-Smtp-Source: ABdhPJzWXmNsQYGlo/XoAt7rJ3XMQnqVn/2emw/g557qtVZoXAJYxangSZ/rdwKB6suIvTYXAUcnDQ==
X-Received: by 2002:a65:5645:: with SMTP id m5mr5147418pgs.434.1592623822112;
        Fri, 19 Jun 2020 20:30:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm7138426pfr.44.2020.06.19.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 06/16] ide: Remove uninitialized_var() usage
Date:   Fri, 19 Jun 2020 20:29:57 -0700
Message-Id: <20200620033007.1444705-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just remove this variable since it was
actually unused:

drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
        unsigned long uninitialized_var(flags);
                                        ^

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Fixes: ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ide/ide-taskfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index aab6a10435b6..a26f85ab58a9 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 	struct scatterlist *cursg = cmd->cursg;
-	unsigned long uninitialized_var(flags);
 	struct page *page;
 	unsigned int offset;
 	u8 *buf;
-- 
2.25.1

