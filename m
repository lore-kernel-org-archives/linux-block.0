Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C7C433E1
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1760220853
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446311;
	bh=k1ZxySueWw5uiQ4KNZ28OQLRLGP/3URh6hCc+SNbtf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3x58zdtRJB/BgG5EHn9Sdc3xsQgQabNyS8I1M9Z1tKgs3DSgHMquu0GyyrcnhOmZ
	 2Wi3ZmsNGdPjgMAx51MM5wEITHatlO9pULMDAhbmjT1TuzWt6mNyMVeG8LQz+gESU5
	 yhLjVyeJ6i9Mhc9jyVqflCrrxumu/LKYQAyWQEJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgFRBVe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgFRBVc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB69A21927;
        Thu, 18 Jun 2020 01:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443292;
        bh=k1ZxySueWw5uiQ4KNZ28OQLRLGP/3URh6hCc+SNbtf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dkh9FJTsOk4wHiePYix07Gvzr99Hr0Xl3JDnWgF4OaaydmXkrQpSxud4pEIFKnZrt
         XPs+FFO41FNQ2uzblknQYuoi1UMmHYFUb5R3gWiW+Znc29qwyK/0hthbdjoA5OAKLY
         tOn5tbOSiYZPeNTsXdMohPSj1lkd/QcaN0I8aXtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 233/266] blktrace: fix endianness in get_pdu_int()
Date:   Wed, 17 Jun 2020 21:15:58 -0400
Message-Id: <20200618011631.604574-233-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
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
index 9e02e1ce0ac0..23e5f86c9921 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1262,7 +1262,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.25.1

