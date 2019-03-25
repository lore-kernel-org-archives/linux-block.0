Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BADC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679720879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCYOhQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:37:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYOhQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 10:37:16 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MmQUL-1gi8Mn4AZV-00iUks; Mon, 25 Mar 2019 15:36:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
Date:   Mon, 25 Mar 2019 15:34:53 +0100
Message-Id: <20190325143521.34928-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OWwNbX2m3xkVaKxTRKGlmRyvOLYLbsTmGhlI5VKBU+6k1xUVw6U
 qFSHxwasMwhNuYUViKOLDxszTGqikFO3ZIzFi9lv2kulti9t56mUdo9z5V7ArIWoT06WLbd
 59/vjaFyWCQg/aiZL2n9kBizFLXIqKl8rLa8eZstmZnsNcSst5s/0zIlY1+T0miwPEz7nlq
 TDRCPn0Og9DcCeVR2qfXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2oDqk2OFGo=:lS2Zp12zO4LYbc7SiuDsIG
 7rg2CqXOxZquKw7QMF/WLSZIS8QYUnaqvoLbaD9fI2lH8fAziCYGGglf085H3pa9aOU0i3kia
 53McurYMouGfR5YLTkevf3Ilsg+j1G2aRRyGIXP3e+mp/4aqn9p9/0njjgx//oQuveeJajv42
 LGM624PellCn71aXHJd9QYT1Ix7tFrRx9B3tn+H8u0sHMUBP7yS7AxEirE+fGarAIGsPsGS9l
 724OSm6HO4/m6RqXH6benxZTQnSOcR/73ANyiOq9U/7ed6dhYlt7f3QojhaBKwnwaWtkakRYZ
 ssG2Nk5dDE9x0nifEcMewDbVkRdWnYcMQIOYdlA/8yz7hc0eu2VQCfDwb9j1udpZ+w/SG6UTr
 vMk7VC0DxIhL+eQBSdgcj5FOVMftq0s+XrX0X+MjPA0McMYwbr5os9YBBv5qFh9kXSGNBeE3A
 RdYg4y5j8o/xxfDuv0t6gixcxeh2lTWQRYZxyfAN4VS16TnkmKtLHQX5fZRBcaC7H8YuAkyFh
 BWOqzE3b7IG1pzqDuyX2yZH8XzJv61UsVk/o8rsR9B+z5oM0+phHu/pchW5FrWbbvhNfa5PxI
 qq0WVZE3t7gxd32c/gxg/CAWeHnSE6ZJulx8hLLsGCSTvI9NqFJbxQ3x5jwdG/E5cwIjwBmj4
 dbmT37U1gp+FhhQu18eyUeKlOZNyydbTHXsnydaWQigMx4pyDKOf137zFldvlENOgwK/tOtRj
 nS8z7QaVcC9GJlm4SxIcAnBelZ4BBqGocspJmA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On big-endian architectures, the signal masks are differnet
between 32-bit and 64-bit tasks, so we have to use a different
function for reading them from user space.

io_cqring_wait() initially got this wrong, and always interprets
this as a native structure. This is ok on x86 and most arm64,
but not on s390, ppc64be, mips64be, sparc64 and parisc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/io_uring.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aaa30580a2b..8f48d29abf76 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1968,7 +1968,15 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		return 0;
 
 	if (sig) {
-		ret = set_user_sigmask(sig, &ksigmask, &sigsaved, sigsz);
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = set_compat_user_sigmask((const compat_sigset_t __user *)sig,
+						      &ksigmask, &sigsaved, sigsz);
+		else
+#endif
+			ret = set_user_sigmask(sig, &ksigmask,
+					       &sigsaved, sigsz);
+
 		if (ret)
 			return ret;
 	}
-- 
2.20.0

