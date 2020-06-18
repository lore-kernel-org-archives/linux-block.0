Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0502C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE372221FC
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445373;
	bh=+PpjlUb1dxhq4JKmEBeSoRDBzT5KQsOuracHEapIOys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=07WLnFblkeSwSUV3MWlWBYKh7VbG4nPvHuv2wyZ0bZ8Cu3MZIXz1z3JZ4RS/1yevi
	 9iWoFcWoKyeBqxJx690VKpNRqo8GWbA7SZ2VpJKgSUkOGM+X9OsEwfDaIw7rM4+XcO
	 Tq7iQi53zFLoZiMF0WUIaoHUaAm/8tAZ5p5XDvDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgFRB4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbgFRBZb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1C72075E;
        Thu, 18 Jun 2020 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443531;
        bh=+PpjlUb1dxhq4JKmEBeSoRDBzT5KQsOuracHEapIOys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGTNnFeQKVuBiIucZWGtODWQuJ8WA7xG0Xiji85PzzorfngmGusxwNFDN1rENfkIk
         XLEgLhy/PBAKOUndDtdFx7NUp/KwUUUx4GYNK6GE/aTSN9y9cP0+UXOuZRbXwOukNb
         8WZvIi5e/oQxc9XtaIS4OjBjqIj+SnzAYH27hxlg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 150/172] blktrace: fix endianness in get_pdu_int()
Date:   Wed, 17 Jun 2020 21:21:56 -0400
Message-Id: <20200618012218.607130-150-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
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
index 5c84f7421871..42027cf4ea91 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1267,7 +1267,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.25.1

