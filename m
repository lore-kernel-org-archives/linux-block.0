Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C68C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E9920897
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444870;
	bh=F2lXI3qesTQ+5ktrZF+jSSye8OoC8cc88VkD4w4IXdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qTQaMPzXJ2z+9lwQ0oYbgNxrEldOQyNGlVnY5ZwrvALbGvD3HoXlU9n0JviL5X5ls
	 oBqdXVs003hJqW8t6BMWt394Z2cHtKVXQOl6b/EF/CPF+UYllDJL35QdrgsnRkbP9O
	 Q8DYlhR7la7ZjU58tGmIWu1azhMMRNoSni5ScZW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgFRBr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732037AbgFRB2L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265D5221FC;
        Thu, 18 Jun 2020 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443690;
        bh=F2lXI3qesTQ+5ktrZF+jSSye8OoC8cc88VkD4w4IXdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm/nkT+7whofmDy9HelW4/DHTvMmsIu34MU53lFO9B8ReP32GAFjvRr8sQNltjWUZ
         82TMt5le/YicyGQkMebJAgEy/sAbL2pE1iZ9WyKUJ1eiJFdL1eyXGmuLJHjmR4mYFv
         twRd5KuM3anEqLU/GLF6OzkRYNhgCJcvFmCb/mjs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 102/108] blktrace: fix endianness in get_pdu_int()
Date:   Wed, 17 Jun 2020 21:25:54 -0400
Message-Id: <20200618012600.608744-102-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 71df3fd82e7cccec7b749a8607a4662d9f7febdd ]

In function get_pdu_len() replace variable type from __u64 to
__be64. This fixes sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 30a98156f474..be97e0b4ae7d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1285,7 +1285,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.25.1

