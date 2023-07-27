Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A9C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 15:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjG0PVr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjG0PVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 11:21:45 -0400
Received: from out-80.mta0.migadu.com (out-80.mta0.migadu.com [IPv6:2001:41d0:1004:224b::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D130F0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 08:21:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690471299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sKpoCtxUkYnH2WqkRrOBZ45YFGekx6TcrM1LcTi34Y=;
        b=GoAulQGyGJtzXSa5IKoRcjIs0s8QPP3zFwnYNiNs+kPVJnExsYqEOYEtlR8fhSpj47xKUw
        YJMSo28qz6Ff2+WhW4F2MDPA7X0bZeGdSFiNNk7xJAPXm25ysAo4/ta6xcQFVsJP/ROKoX
        B4SM3TA0HMPPk371Wjn8U3jkybITGKc=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 2/3] sbitmap: fix strict round-robin non-wrap with hint > 0
Date:   Thu, 27 Jul 2023 23:20:19 +0800
Message-ID: <20230727152020.3633009-2-chengming.zhou@linux.dev>
In-Reply-To: <20230727152020.3633009-1-chengming.zhou@linux.dev>
References: <20230727152020.3633009-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If we have alloc_hint > 0 and don't wrap, we need to recheck
sb->map[index] with hint == 0 to exhaust the map.

For example: we have 8 words to search, index == 4, hint > 0

In sb->map[4] word, we only search [hint, 63] bits in the first
word search. Then we search left 7 words, the sb->map[4] [0, hint-1]
bits aren't searched.

This patch fix it by searching 9 words in this case, so we will
search sb->map[4] the second time at last with hint == 0.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ac4027884765..6e098a46be26 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -199,10 +199,18 @@ static int sbitmap_find_bit(struct sbitmap *sb,
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

