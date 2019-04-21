Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F5C282DD
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28620850
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfDUCh4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 22:37:56 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17541 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUCh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 22:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555811567; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jQy+j/FswfcE2+YNXXBo1/6xl3K4Lsj7p4k/i+qJ57FQ1zg1fcqh82KVtCtYjNj2WQFHK3sjQaPDiabTGmRKlgCz6gt+MvxtZBssotUiIPGa7REcAr7ImFj7nTh3tyuJh5sxfiwwnA8eOnLdwKwHLJLMDwIJ+wMSa4FhEUVACU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1555811567; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=ZPlmM9qckxGwnSHPDlXozAa6/CMdSVtwqXgff50qTps=; 
        b=BoR45m74FS5ZYPZD/w8eN//xhynDEmiK5By4ZDOgeoigVyecTIohzYFewWx67OyJmPR5GY6+tLqQt7VWhwUClWivx0vCp8F3L7TVvtsg2Uw1gISAQJ5hvPb6Bm7B+7oWkcqhKdniK0k/sNN6pqI4tLWqckio5wp60bk2EMN9Lg0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1555811566329723.9803619974329; Sat, 20 Apr 2019 18:52:46 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Message-ID: <20190421014245.17652-2-dan@dlrobertson.com>
Subject: [PATCH 1/1] io_uring: fix bad free in io_sqe_files_register
Date:   Sun, 21 Apr 2019 01:42:45 +0000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421014245.17652-1-dan@dlrobertson.com>
References: <20190421014245.17652-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given bad input to the io_uring_register syscall the io_ring_ctx
user_files member is cleaned up in io_sqe_files_register, but a
following call to io_uring_release will result in a double-free.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bbdbd56cf2ac..07d6ef195d05 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2215,6 +2215,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			fput(ctx->user_files[i]);
 
 		kfree(ctx->user_files);
+		ctx->user_files = NULL;
 		ctx->nr_user_files = 0;
 		return ret;
 	}
-- 
2.21.0



