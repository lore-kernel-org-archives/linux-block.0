Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD346C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968DB2078B
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEPATY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 20:19:24 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39019 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPATX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 20:19:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id n15so1720279pjt.4
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 17:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLMMsSw27YBOag3G8i7RTR5iYZnCqgBWGGZ3X0hdOFc=;
        b=DOOzsuMoRggIyTrb47DE4QxgP+pWafQzZyWCDDhxJKN7k6SjLMSD7ByvMCfPMs/S9d
         yjIBDhuMHal3hqF+8X0FqmGFsCXyXTR9m0e1bSKWr2imrXwQ//cWtXkoCqnPJGCkRJ2W
         nCdH8DZ1aZ3t5tdM87CledP/PXLmyg5r/oequvIncYaYBAGeNeHHls7HNDrcPUCdM5Xr
         jloUGJmlrBJ4RjUdICfXXeY42DDk1kw/UzXOCcZs3v94RRdF19TPx5JYCj393xcCvXA/
         rHwJf63BTwBEEAGtloj07MtrpqI3ZJ9BRlABfFddToQ9hF34EzUy8ajPA4DxtZA5FHLO
         +4Ng==
X-Gm-Message-State: AOAM5317TFzzj9mv2wA40oiT5JYpZ/899y8nCpTMf/ttioHTBXgkt3MU
        BwEwM8qv9Y5io5GoEhaoRj/36tCd
X-Google-Smtp-Source: ABdhPJx4id/1ufh3pkdE8Kr01ugcnwliiSncK/MCdYdhcLlyzIRhZksfwZQ3fizGojM9mqynwN26LA==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr6227571pjg.185.1589588362985;
        Fri, 15 May 2020 17:19:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:f99a:ee92:9332:42a])
        by smtp.gmail.com with ESMTPSA id 30sm2542383pgp.38.2020.05.15.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:19:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] block: Fix type of first compat_put_{,u}long() argument
Date:   Fri, 15 May 2020 17:19:10 -0700
Message-Id: <20200516001914.17138-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516001914.17138-1-bvanassche@acm.org>
References: <20200516001914.17138-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes the following sparse warnings:

block/ioctl.c:209:16: warning: incorrect type in argument 1 (different address spaces)
block/ioctl.c:209:16:    expected void const volatile [noderef] <asn:1> *
block/ioctl.c:209:16:    got signed int [usertype] *argp
block/ioctl.c:214:16: warning: incorrect type in argument 1 (different address spaces)
block/ioctl.c:214:16:    expected void const volatile [noderef] <asn:1> *
block/ioctl.c:214:16:    got unsigned int [usertype] *argp
block/ioctl.c:666:40: warning: incorrect type in argument 1 (different address spaces)
block/ioctl.c:666:40:    expected signed int [usertype] *argp
block/ioctl.c:666:40:    got void [noderef] <asn:1> *argp
block/ioctl.c:672:41: warning: incorrect type in argument 1 (different address spaces)
block/ioctl.c:672:41:    expected unsigned int [usertype] *argp
block/ioctl.c:672:41:    got void [noderef] <asn:1> *argp

Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 9b81648cb5e3 ("compat_ioctl: simplify up block/ioctl.c")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 75c64811b534..bdb3bbb253d9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -204,12 +204,12 @@ static int put_u64(u64 __user *argp, u64 val)
 }
 
 #ifdef CONFIG_COMPAT
-static int compat_put_long(compat_long_t *argp, long val)
+static int compat_put_long(compat_long_t __user *argp, long val)
 {
 	return put_user(val, argp);
 }
 
-static int compat_put_ulong(compat_ulong_t *argp, compat_ulong_t val)
+static int compat_put_ulong(compat_ulong_t __user *argp, compat_ulong_t val)
 {
 	return put_user(val, argp);
 }
