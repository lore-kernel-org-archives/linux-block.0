Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDEFC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557F5223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErPm6oUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557F5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeKOI3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732950AbeKOI3d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:33 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849042252A;
        Wed, 14 Nov 2018 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234269;
        bh=cIE+yFrQzinuDjq5MKHLnNwG71W/rr/ziVgLzcaAX0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErPm6oUoLuqerGl9hp32UJRh0kvM7h+1EKarDZuJH8udiGxbWmvLBB/L/xiIoJ1qG
         XzQIOajbOL3DQTGVQiEJl1XEW5oko+uiiLS3gzl/Iw6jU/7iefl9xFUW9m9RSDHmFp
         QDRUslHFctXpHAm4w2vyKonZPBO3dItDpLmVmvMA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 32/59] block: Clear kernel memory before copying to user
Date:   Wed, 14 Nov 2018 17:23:04 -0500
Message-Id: <20181114222335.99339-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit f3587d76da05f68098ddb1cb3c98cc6a9e8a402c ]

If the kernel allocates a bounce buffer for user read data, this memory
needs to be cleared before copying it to the user, otherwise it may leak
kernel memory to user space.

Laurence Oberman <loberman@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index ff94640bc734..5ad106e765fc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1336,6 +1336,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
+		zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.17.1

