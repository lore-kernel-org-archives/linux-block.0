Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD6C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A52020838
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 10:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="iHpNVE2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfBKKUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:20:12 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:41719 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfBKKUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 05:20:12 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 05:20:11 EST
Received: from mxback12j.mail.yandex.net (mxback12j.mail.yandex.net [IPv6:2a02:6b8:0:1619::87])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 6F9685F820EB;
        Mon, 11 Feb 2019 13:13:12 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback12j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Ru6WfEz2fU-DCSeehcZ;
        Mon, 11 Feb 2019 13:13:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1549879992;
        bh=ISPu5tIpHwpshOYfg8lSfgKtASJCv4J8FWzh/LEOkbQ=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=iHpNVE2i1G1nFwU8mco0qSaQNsTT/7CVLlCe7CxKe8uTRcU9JurMcER3dg2HdpfEC
         tJ8lvOLK2kjEiMm/0h47YrkynCElphtoaYLVd0mOrtcjeQwr7J7RPFyAZz6M1SDfD7
         DBbrJkp52cs/c45i/leNaTSrOFhxM8oHkCn9k55A=
Authentication-Results: mxback12j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id YPvs6NoGcc-DBGCWst4;
        Mon, 11 Feb 2019 13:13:11 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Aleksei Zakharov <zakharov.a.g@yandex.ru>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Aleksei Zakharov <zakharov.a.g@yandex.ru>
Subject: [PATCH] block: avoid setting wbt_lat_usec to current value
Date:   Mon, 11 Feb 2019 13:10:34 +0300
Message-Id: <1549879834-24837-1-git-send-email-zakharov.a.g@yandex.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's no reason to set wbt min lat and freeze request queue
if current value is the same.

Signed-off-by: Aleksei Zakharov <zakharov.a.g@yandex.ru>
---
 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 590d1ef..d0df883 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -468,6 +468,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	else if (val >= 0)
 		val *= 1000ULL;
 
+	if (wbt_get_min_lat(q) == val)
+		return count;
+
 	/*
 	 * Ensure that the queue is idled, in case the latency update
 	 * ends up either enabling or disabling wbt completely. We can't
-- 
2.7.4

