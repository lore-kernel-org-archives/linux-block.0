Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E25C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1335020892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZL/gTdA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1335020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGWU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38018 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLGWU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so2573368pfi.5
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=ZL/gTdA+jDOXWytYxbU1Mio0kBomwG7eHy6S3fDMGw8O7hB28SwuEKU7bdpsxFQZez
         3SP0A9yhs36LpazT092SAtFkbNWaA8iFIsGNZMEv03gm/zxCCvdSCvAhSHQ9Tm+VuyqO
         WCWoN7Y0EuqRoPSovdDFtfoD3xB57k6c+Vpm602k5cPQsfIwPoAdQkueKIvxLVhbspil
         qisvbKXQzmKRsGCjRV3DX/XWhq83l6oOcmO4T0hgqEBNkLbdAjVzEHTClOzqduEJzzmh
         U/9V0gDP793gI4uI8rsu1xZMKaPSXGPJcuZXSdOk6A6dm7+DCePmf4OMmwZVpFyWGJTg
         sDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=HlSsJybbZNmZVhMDVfdZFHRnWWo1ukmi5ABcsCg1Q8EVbvW27XZRrLNGERjcXhc0lk
         p/I5Ub07JFvn+RlkwA7sUrW03jN4o0CD7OY8mBrjqNcrsJgL3zoyFVQuAAXPMMjFXeZS
         RxxeiVFoRpbfFyWeKx1e9iRGW3GOwVrEDEa4YxiAqsRGR6Hbh/GyUgpJ5L/iP2IB6xfG
         uShbQvfXCofRsDulvQJgwCjrAnscUVU4IhFyNS2d6sqLRkIOjtfV79Ow43+2ANUuYIyG
         BtAx8AY946fg/3kEF4ROK/jA7ubDpWQo3bA7GMGW2Ln6pgpUETr3mqOdiNm77eR0JZ4E
         sJgA==
X-Gm-Message-State: AA+aEWZnLurkdTD/BiF4531sXAdYVdlyZuqqNJONxxKl5bOYhL1obkMW
        vL140q04JEkpTJWH6kQhdUgRaEIaMIw=
X-Google-Smtp-Source: AFSGD/V4NslnNK5Ts3XuaMSUGIbwZgGI8x4/73fJAJXH1Psih0xnCjPyFhZZJnyIP3C8vH2NDG+gpw==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr3443454pgk.241.1544221226860;
        Fri, 07 Dec 2018 14:20:26 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/26] block: add REQ_HIPRI_ASYNC
Date:   Fri,  7 Dec 2018 15:19:52 -0700
Message-Id: <20181207222016.29387-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 46c005d601ac..921d734d6b5d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -347,6 +347,7 @@ enum req_flag_bits {
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_HIPRI_ASYNC		(REQ_HIPRI | REQ_NOWAIT)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.17.1

