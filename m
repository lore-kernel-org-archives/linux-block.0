Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85DC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6923206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qlMYd37o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6923206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeLDXhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLDXhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so8084253pgp.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FSmFyxdzuP5ug/6YEtOiiyUa72y6iXE8GKTBze9pRyY=;
        b=qlMYd37o2DkQ1ult2b2Q7Vs9z4B4VNJMb2oQLB4pmOOOM+ETqKmU+ek2WqcteOS/hf
         3fk+oxqXy/Ap2ZAVmGRSHOomawgkwGibsgtT2J/vGTH4hNsE5dvMwIA56ufTa5yycteo
         zy0ALXXboieiifhKsgq4NT97odnaFaZStYGHkEOrYM3YKULleA93Bj8aiKraVQc558AI
         dCEIfx3LBgPxl6B4RNhZuk49v1r7tjbTOLYk7NX23HIhhZDe6yvWz0TLDZu9P2gkk7VC
         ZToJmvbqYF6EhWv+YiyJTWD0o8pXj8mDW3KHun/1ywcvZnYVv+03ZknyR5xgRFbpe2TH
         Dopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FSmFyxdzuP5ug/6YEtOiiyUa72y6iXE8GKTBze9pRyY=;
        b=sWokffGJekUyHmb7QsgNQXCTSfrQfW/zeymhXugef4+W0JS3KbrCIEvyyd/OMY5V14
         ZuhGOXghh6CKqXnvCq8y3fHupWdrIk5VJjvr+Ftui1lmKLOnly1EUmoandG1bvEo3rL1
         7UCRgy2oB5eOJqkqM9lzBKtfQGiZjrhGT85+2l0xArsLyKCwhMIERrE4HMF+tbOizFqp
         QbDj2Ov4vDbP8OFnz8SK1uouwgoW6YeDxr5gjewuvhAbXKNzGVho0ajssQRvsO3uESA4
         0lH7HyWm6lRuRKX59QvJGje7gZLwmtWFtpDFLekYMZEgZVlaTxQRqWiqAMIHcLrnq6Nc
         Fd5g==
X-Gm-Message-State: AA+aEWZmAgspgJ9KSTufKCJRvXnYl+tlKFEk3orE0X+lzFXZ4pJDV/kR
        0Qr+e71HVNgDjbf/PouZBFehSCK5G9o=
X-Google-Smtp-Source: AFSGD/UVk0jn174qmJfatEBZtlMDsDTIbnBGv5Qzzs3/ZmsrkcOjoekCOck9thzDRUl5Dal/0aLw5A==
X-Received: by 2002:a65:564b:: with SMTP id m11mr17957051pgs.216.1543966661174;
        Tue, 04 Dec 2018 15:37:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/26] block: add REQ_HIPRI_ASYNC
Date:   Tue,  4 Dec 2018 16:37:05 -0700
Message-Id: <20181204233729.26776-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index c0ba1a038ff3..1d9c3da0f2a1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -346,6 +346,7 @@ enum req_flag_bits {
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_HIPRI_ASYNC		(REQ_HIPRI | REQ_NOWAIT)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.17.1

