Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8542C76186
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFA220818
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGQI3j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:29:39 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:5928 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfGQI3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 04:29:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TX6Y9GM_1563352168;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TX6Y9GM_1563352168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 16:29:36 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH blktests] block/024: disable IO requests merging
Date:   Wed, 17 Jul 2019 16:29:22 +0800
Message-Id: <1563352162-2756-1-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/024 works in a way that, if we submit N bio requests and each bio
requests will consume M ns, then the total time consumed should be
(N * M) ns.

However there may be some merging of write bio requests, and thus the value
of the "write ticks" filed of "/sys/block/<dev>/stat" may be less than
what we expect.

For example, running the following script,

```sh

modprobe -r null_blk
modprobe null_blk queue_mode=2 irqmode=2 completion_nsec=500000
dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
wait
cat /sys/block/nullb0/stat
```

and we get output

```
       1        0        8        0     2626      411    28800     1388        0      943     1444        0        0        0        0
```

In this case, we submit 3600 (1800 * 2) write bio requests, among which 411 bio requests
are merged (2626 + 411 * 2 = 3448).

Thus we need to disable the merging of bio requests by

```
```

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tests/block/024 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/block/024 b/tests/block/024
index b40a869..0ffc63f 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -42,6 +42,9 @@ test() {
 		return 1
 	fi
 
+    # Disable IO request merging
+    echo 2 > /sys/block/nullb0/queue/nomerges
+
 	init_times
 	show_times
 
-- 
1.8.3.1

