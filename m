Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CCECA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A7620867
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eO2sEvBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505884AbfJYRbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:31:41 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43863 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502803AbfJYRao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:30:44 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so2511206ilh.10
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xtMxYmqRKSbwDpEY25WYyVtGPb61T4kFCH3oEpXXy68=;
        b=eO2sEvBRfDw2BEa78HcquHbYUy0RhJZx4eUsUoRTxcYx8NzQ+73cAFHIAlT+BdJvSM
         RR8Zng9yyw7W34H3jsoTaueTKN8ZFTbuhDNY7Uv0XHv2SnVDrUTmDHtC+SvNaE9d0ve3
         4iq0/mbqiJ+O0NfwqTid1112TlmXnayjlpAdFmdM5D2BUhhEDehX6c6h8jIH950u3ZGn
         /yAUcMG0kANuUIiXPnqhrxqACGlG6eIVyp+PpjRqEyCPfJCDLLcypWKswqopy3+ynjAq
         W1aKTavU+7DSDLIbarMLXWYNjYTy+27+I6kK7e875Shizwvt0oR8AdErvNVjK8REwsKd
         e/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xtMxYmqRKSbwDpEY25WYyVtGPb61T4kFCH3oEpXXy68=;
        b=S6gXk5aG7BtslXhkfurAxTM+HrLf64lxzAJ2RWDNc64rsPmUFbuTqcuESR50LAq+6o
         H0xOlq8t3oMUuYUo2rZLi52nWNrwU2Nwm/GcG2GAfE6gUaODynkvIZIbbSvX4PgPvcrc
         rON0VV3JeZWd8Z1+ssnBXzKomc5FvwcbJUCxqFKQCP+52fkz0HSrs5KCShHrtzv2ky93
         XWbdrEpaaP8MYX/T8iRGWEx1hioXprxNt693wjz+Y/qNKXEFKIFOFSrDQUwfWBPFFlZP
         VZ+qXEVCBISbcBo6gR2+n2qZPnRAfGO8Y/s+KZGgMDCYz/PIa7ejngMCWEUNefUqO2Ri
         3p9Q==
X-Gm-Message-State: APjAAAU56ScGU0nocDFAf+Ki0bnEJ+aioQkvP9J/lKQ0KiQ33+2VM0F1
        RCAfXd2wgyuTlLkDZJQ4VDYn94LWpki8zA==
X-Google-Smtp-Source: APXvYqzLUoLBx6alLytHVjGHDF10wjNoUs8zmUqhKKGfDvC3ay9LiURfxPT3wAjapKuZrMIKv7ZwPg==
X-Received: by 2002:a92:5c4f:: with SMTP id q76mr5363295ilb.158.1572024643144;
        Fri, 25 Oct 2019 10:30:43 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g23sm323674ioe.73.2019.10.25.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:30:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] io_uring: reorder struct sqe_submit
Date:   Fri, 25 Oct 2019 11:30:34 -0600
Message-Id: <20191025173037.13486-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025173037.13486-1-axboe@kernel.dk>
References: <20191025173037.13486-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reorder it to pack it better, takes it from 24 bytes to 16 bytes,
and io_kiocb from 192 to 184 bytes.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 13c1ebf96626..effa385ebe72 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -260,10 +260,10 @@ struct io_ring_ctx {
 struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	unsigned short			index;
+	bool				has_user : 1;
+	bool				in_async : 1;
+	bool				needs_fixed_file : 1;
 	u32				sequence;
-	bool				has_user;
-	bool				in_async;
-	bool				needs_fixed_file;
 };
 
 /*
-- 
2.17.1

