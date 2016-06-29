Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33051 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so14878139wme.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:11 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 01/11] lightnvm: remove checkpatch warning for unsigned ints
Date: Wed, 29 Jun 2016 16:41:46 +0200
Message-Id: <1467211316-22373-2-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Checkpatch found two incidents where the type was preferred to be
written out in full.

./drivers/lightnvm/rrpc.h:184: WARNING: Prefer 'unsigned int' to bare
use of 'unsigned'
./drivers/lightnvm/rrpc.h:209: WARNING: Prefer 'unsigned int' to bare
use of 'unsigned'
./drivers/lightnvm/rrpc.c:51: WARNING: Prefer 'unsigned int' to bare use
of 'unsigned'

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 2 +-
 drivers/lightnvm/rrpc.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 736e669..90c7cb4 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -48,7 +48,7 @@ static void rrpc_page_invalidate(struct rrpc *rrpc, struct rrpc_addr *a)
 }
 
 static void rrpc_invalidate_range(struct rrpc *rrpc, sector_t slba,
-								unsigned len)
+							unsigned int len)
 {
 	sector_t i;
 
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 87e84b5..5797343 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -188,7 +188,7 @@ static inline int request_intersects(struct rrpc_inflight_rq *r,
 }
 
 static int __rrpc_lock_laddr(struct rrpc *rrpc, sector_t laddr,
-			     unsigned pages, struct rrpc_inflight_rq *r)
+			     unsigned int pages, struct rrpc_inflight_rq *r)
 {
 	sector_t laddr_end = laddr + pages - 1;
 	struct rrpc_inflight_rq *rtmp;
@@ -213,7 +213,7 @@ static int __rrpc_lock_laddr(struct rrpc *rrpc, sector_t laddr,
 }
 
 static inline int rrpc_lock_laddr(struct rrpc *rrpc, sector_t laddr,
-				 unsigned pages,
+				 unsigned int pages,
 				 struct rrpc_inflight_rq *r)
 {
 	BUG_ON((laddr + pages) > rrpc->nr_sects);
-- 
2.1.4

