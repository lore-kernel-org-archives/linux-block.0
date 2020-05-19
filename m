Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38519C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218CE2070A
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgESEHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:07:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54218 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgESEHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:07:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id ci21so761649pjb.3
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+XZgtzhZ50zAEpNB8bt8Dg2WvJOaCyGo8regQfWBaw=;
        b=qyKbCyfihsj/A33X+fE0eh/+nf7FTu8Elrxzeb19JB3aUwsHQdExz5+Agv0QxRado/
         1jmlN5EhZz6kEXt7vmy1icO9J+59ZHev+32fYYGfYLGUcCqu2kLuTNqellsd6XdARxs9
         5uKc/GvPBXXi/oYX2SBTWQeafgUE/s4/V2pg737VDbRWlg5iDQZvP4C2jTPuGDjSS4C2
         gvaTRHXf4A4O9YYeKDYKGZx3TEGtjRkHCPfe6HhcL8Q1K3I0ZBlgZlf0Ms64OtCKF8oS
         /0yfMPp8h+8bivOivwHpwD+bLjMDcmWf5ER8N2Ts5bDqtwACc1lNkC5dIh6AA9Larf9k
         5Bwg==
X-Gm-Message-State: AOAM531Q+jUv4veWYQgc4hMqwrda95Wlsvt+BCjN21J7HbGEB4mm6EgC
        i1eis5NdnXPT/fNe9slOaLTfXniZ
X-Google-Smtp-Source: ABdhPJzvRkrMnpLL/7fLsLtoDouus72Wgsb92STo44wJi37MrpKpM8YtbpWexbkbI1npg8ked+Iitg==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr15245768plp.286.1589861267361;
        Mon, 18 May 2020 21:07:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id l3sm823479pju.38.2020.05.18.21.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 21:07:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/4] block: Fix type of first compat_put_{,u}long() argument
Date:   Mon, 18 May 2020 21:07:34 -0700
Message-Id: <20200519040737.4531-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519040737.4531-1-bvanassche@acm.org>
References: <20200519040737.4531-1-bvanassche@acm.org>
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
