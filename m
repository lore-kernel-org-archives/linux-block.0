Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B80C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ECC2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0knEyz1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ECC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeLKAQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeLKAQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so6178759pfe.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=0knEyz1uqw0GoyqJeJKJmtLkY7cgBPkxw9sp3uWk0EtLP5xk2lhP2JX85lGxPKDwT5
         kYeb6eH0yz0mMvhX4gyEdGXBfRYWRjb+7BCXBhxl6wS/CJQ2HZboinKYeo4pEp96NT5B
         +KE+esbrn2fFyVvonlR3PXQT52U+1rvWmWrnHVQS56E/M9tcv42Q1+beXZ27HRqXBB4U
         Z3fmkPf2kwn+MZNs9ZJIdFfan1TE9nrSvkCZclSs6GBGNkyOvbyWbwgduc1HZ9QOMe1W
         wRpJ4UYmrSKTYH3ejEQiHADxgGLOTaCT6ZLm2e/N16vlpdB7YHw4YlwGxNc7aqpqLRgC
         Ywyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYR2nYossn2CYfY6XYD4jgz1urOe8gSQ6v8WOe22hMY=;
        b=TNE6Yc4mRIpSGMnSDrLHMXZPmM+diYN1rrJQyz7w6LaEhqSGmCaPmvm0Sbl2wlo4rK
         IyG5ADJZrVMX/Lwtdiic7yRB6uX9oY4cD03A9SDfbNximWdbPEaOyQSI/8yObTIibt2c
         TOiU2ENRi7qAjHn9rpjcYg5iTpZn9EALpNA186vmNGJUvJTfLFKCQaZPflG9gaZ41d75
         BcFcWocevuks2D12mRdv2K4i9yXG13kQhgFLCy0ay9hITPz/8tHIcvRN4a7wMIVrk0EW
         nzYv3RZRk4q9HiDuA+iCfzC1RSjq9paatBBPQdAZBMdE3Z21FI7mkmTYubm1GSRytzJo
         5A1Q==
X-Gm-Message-State: AA+aEWYVBtMawpn3eEiHgdcLWIL+DEtLJAlrP8+oqrJeEVl6XYvL2U/C
        L/8GZlu7tXHpCwXJrkrpB4IzaFCNK49xUQ==
X-Google-Smtp-Source: AFSGD/V306dR82B0XzUcnbvwhmQnpzSIiP8i10v9YaUUgWNyKtsS6JHNvkxLrUvzMUXrZrnDlsr4Bw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr12782513pgh.39.1544487362018;
        Mon, 10 Dec 2018 16:16:02 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/27] block: add REQ_HIPRI_ASYNC
Date:   Mon, 10 Dec 2018 17:15:24 -0700
Message-Id: <20181211001549.30085-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

