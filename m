Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC32C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41C220851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Zv++0qf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41C220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeLMR45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33494 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeLMR45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:57 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so16925114itk.0
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=Zv++0qf7pOlzIejiXXnGJHxdh3pd8gwSfHuAwXOQWn6ms9gsaqOqVgQtWPZOs/EsDS
         A49rgPPy1wbAUC/IsJDhN6AT1xvDSXDadF6SFFEGZIi3hUI/j5eZT5prpRTdUVVwSVKw
         k44KOR+aA3AnBXcTwWQ/TDKzWeNbt9pJ6b5S+Jd2v8ABRGXZ8nWe7a79N/+hwa3UtYP9
         QDM+RWTi0KJy8KtKkXZwdkMc9YNR1TcP87J29N1sxayaAbxikT37XOGRWseXy+N8wKvi
         K+whc0Hn7uXqMJb3sPbiZr/3StUiXvy5A560wfS0iznWcwMjPgMTMKnQbyGEHUgQMDS6
         pwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=XkkAqjrgTYg9qWVhqqZeKwZw7px8jAC8Fuy4vkI6WEZUDsTVn6EijWXAPa60uCQ192
         X28wpTz5Wt4ubLVzQOoU8ZE6CLjyXhzSl6clC27o8b4FG9tJyb1A3mRqUc97vlZhsooR
         RJFu0tNfrszyZdmbwS5icWlEON0aoWLJwI4av8tknoCgWwsIgfjDbk9eIcQqjYagxHE9
         cZvB5KzZPhiCngK/iHLExQHX0e2gTFG1Cw4W7jmPsjMheiyYZowFbycO4v44DWDKUJuF
         Z5KrHHC10uStZovsaKgdvsDb4/uIRr7m4Rl3k/WNS1PJrdBWJYYFoUetDpqpQHaCzmFR
         26ew==
X-Gm-Message-State: AA+aEWZDCPBxBcz+2guxQ/ONUNIDlXPRWDHrT2Tg+uj9xA5hFV/yoRvS
        ZJJizrYXuUhyYAp174F4b54ejzGc0S/1/Q==
X-Google-Smtp-Source: AFSGD/X9Yild44el5oSgDAn+5C8ocz5JyFXvLP6AwfbFqd0er5gP0hCG7XfHKU50Oa73vsdALVg1oA==
X-Received: by 2002:a24:4f07:: with SMTP id c7mr277879itb.107.1544723815549;
        Thu, 13 Dec 2018 09:56:55 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/26] block: add REQ_HIPRI_ASYNC
Date:   Thu, 13 Dec 2018 10:56:21 -0700
Message-Id: <20181213175645.22181-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

