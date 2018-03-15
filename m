Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeCOKm4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 06:42:56 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 1/4] bcache-tools: change bcache.c:crc64() to non-inline function
Date: Thu, 15 Mar 2018 18:42:37 +0800
Message-Id: <20180315104240.24647-2-colyli@suse.de>
In-Reply-To: <20180315104240.24647-1-colyli@suse.de>
References: <20180315104240.24647-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bcache.o is used as a static lib but not explicitly compile and linked as
position independent code. The only routine in bcache.c is inline function
crc64(). For gcc 7.X this inline function will be optimized out in such
situation, and when linking bcache.o to make-bcache or bcache-show-super
there will be an error "no reference to crc64()".

The simplest way to fix the compiling failure is to change crc64() to be
a non-inline function, then there will be an entry of crc64() in symbols
table of bcache.o.

Signed-off-by: Coly Li <colyli@suse.de>
---
 bcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bcache.c b/bcache.c
index 8f37445..8b4b986 100644
--- a/bcache.c
+++ b/bcache.c
@@ -115,7 +115,7 @@ static const uint64_t crc_table[256] = {
 	0x9AFCE626CE85B507ULL
 };
 
-inline uint64_t crc64(const void *_data, size_t len)
+uint64_t crc64(const void *_data, size_t len)
 {
 	uint64_t crc = 0xFFFFFFFFFFFFFFFFULL;
 	const unsigned char *data = _data;
-- 
2.16.2
