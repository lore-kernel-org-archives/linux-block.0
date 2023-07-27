Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3EC0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 15:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjG0PVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjG0PVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 11:21:42 -0400
Received: from out-111.mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCC30CA
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 08:21:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690471295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IlwsvGNRJnMmWnx4X81rM4zHsMyVpGxID3lfp4Wm+1A=;
        b=UnKls/jjqZcZzftvuk3ljzIPLwoprqIWOu7LoFbkkVSAIBhLiG4rj7MDXbC/wSvtMI359l
        N6V7bn3EnXoWjtBGCXe0jAO/FTTa0piMOgDtLsfDpCDWkAJsdhdkz/EHKYdP3PVjE+UdzQ
        hRtC43R6653je6/DHV9wtgV6FW0mNXk=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 1/3] sbitmap: fix hint wrap in the failure case
Date:   Thu, 27 Jul 2023 23:20:18 +0800
Message-ID: <20230727152020.3633009-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

```
hint = nr + 1;
if (hint >= depth - 1)
	hint = 0;
```

Now we wrap the hint to 0 in the failure case, but has two problems:
1. hint == depth - 1, is actually an available offset hint, in which
   case we shouldn't wrap hint to 0.
2. In the strict round_robin non-wrap case, we shouldn't wrap at all.

```
wrap = wrap && hint;
```

We only need to check wrap based on the original hint ( > 0), don't need
to recheck the new hint which maybe updated in the failure case, which
may cause second wrap. We set wrap to false after we wrap once to avoid
repeated wrap, which is clearer than rechecking the hint.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d0a5081dfd12..ac4027884765 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -149,7 +149,8 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			 * offset to 0 in a failure case, so start from 0 to
 			 * exhaust the map.
 			 */
-			if (hint && wrap) {
+			if (wrap) {
+				wrap = false;
 				hint = 0;
 				continue;
 			}
@@ -160,8 +161,14 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			break;
 
 		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
+		if (unlikely(hint >= depth)) {
+			if (wrap) {
+				wrap = false;
+				hint = 0;
+				continue;
+			}
+			return -1;
+		}
 	}
 
 	return nr;
-- 
2.41.0

