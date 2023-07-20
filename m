Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE2EEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGTJsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjGTJsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:11 -0400
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732E2706
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:47:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HexLk5YdZ9UMqQVRKs36MeqJ3bE8mocAttG9oHtUF6A=;
        b=T3g0daIqsxUtbedfWKPmCc61Qc12FtWKResFJpeO2mr/aRXdYhFQp9Pq27ndDZNyrYc5Kt
        7uDJsxRP4E45zPxPxh7vmCqiZoRPQfuQmeTGRkOu8Atn66cRWwHReZ+iWGrbu+ify0SdMJ
        eCiiqpd8AYC3WMEkSJGYMsndmZ5Jq5E=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 2/6] sbitmap: fix round-robin non-wrap find with hint > 0
Date:   Thu, 20 Jul 2023 17:45:51 +0800
Message-ID: <20230720094555.1397621-3-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If we have alloc_hint > 0 and don't wrap, we need to recheck
sb->map[index] with hint == 0 to exhaust the map.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 5ed6c2adf58e..ccb96d1f92ba 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -192,10 +192,18 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 			    unsigned int alloc_hint,
 			    bool wrap)
 {
+	unsigned int map_nr = sb->map_nr;
 	unsigned int i;
 	int nr = -1;
 
-	for (i = 0; i < sb->map_nr; i++) {
+	/*
+	 * If we have alloc_hint > 0 and don't wrap, we need to
+	 * recheck sb->map[index] with hint == 0 to exhaust the map.
+	 */
+	if (alloc_hint && !wrap)
+		map_nr += 1;
+
+	for (i = 0; i < map_nr; i++) {
 		nr = sbitmap_find_bit_in_word(&sb->map[index],
 					      min_t(unsigned int,
 						    __map_depth(sb, index),
-- 
2.41.0

