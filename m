Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC6EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1403620758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgERBsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:48:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERBsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:48:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id w19so1787090ply.11
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 18:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+XZgtzhZ50zAEpNB8bt8Dg2WvJOaCyGo8regQfWBaw=;
        b=b+HjcAv1+IA55XpK4NZWOzSJX4I0cJa/ngRMX31M/dgVFKsnuUII68OgCXiAewVNFP
         sa1TdtBJvnzkQC1lW9J3rFh9+Hn6Ac+eBgCthEX4I6VlEfd3tYFnR1B2IZE9G/tCQPP8
         waeaqK5O6gTNmX795eSKnwsewlYI/r+0MZeOxRNhLIFwpiqZMjo2TT4KdKpsDmOdAx07
         bH5OpbOe4LRpQ6q8jimxNQxYISnuMlSUqMwfIhMjPyOmEyPdqST5U8uBSumAj0E2hehs
         nrgX5tes3bTZGv5Mebq8DJgJkgMlJQMZriQOLhbINH7HPNF/nFdSuSrJMcbagK0R733z
         pWRQ==
X-Gm-Message-State: AOAM531CORV+63WADT1FLSqW4y3PlXtl7ibo9wl+UgJuXVadFpseh3uh
        rzpLxwLwGjUwYWoom0ZLmhcnN9jT
X-Google-Smtp-Source: ABdhPJzK0mZ5ItsIWu/KWyHpw28/iXVRN9dV3wvpiroLSybWsVWEM9caATzRD/O7iSOLyh77S7GiNA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr6762788pjo.127.1589766497787;
        Sun, 17 May 2020 18:48:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3778353pjl.45.2020.05.17.18.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 18:48:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/4] block: Fix type of first compat_put_{,u}long() argument
Date:   Sun, 17 May 2020 18:48:04 -0700
Message-Id: <20200518014807.7749-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518014807.7749-1-bvanassche@acm.org>
References: <20200518014807.7749-1-bvanassche@acm.org>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
