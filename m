Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeCOKnC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 06:43:02 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 2/4] bcache-tools: only set/display sb.bucket_size for cache devices
Date: Thu, 15 Mar 2018 18:42:38 +0800
Message-Id: <20180315104240.24647-3-colyli@suse.de>
In-Reply-To: <20180315104240.24647-1-colyli@suse.de>
References: <20180315104240.24647-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bucket_size of struct cached_dev is not shared between cache devices
and backing devices. Currently make-bcache.c assigns bucket_size to
backing devices, and bcache-super-show.c displays bucket_size for
backing devices, all these are incorrect.

This patch fixes it by only set and display sb.bucket_size for cache
device super block.

Signed-off-by: Coly Li <colyli@suse.de>
---
 bcache-super-show.c | 9 ++++-----
 make-bcache.c       | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/bcache-super-show.c b/bcache-super-show.c
index 26cc40e..515c596 100644
--- a/bcache-super-show.c
+++ b/bcache-super-show.c
@@ -160,20 +160,19 @@ int main(int argc, char **argv)
 	uuid_unparse(sb.uuid, uuid);
 	printf("dev.uuid\t\t%s\n", uuid);
 
-	printf("dev.sectors_per_block\t%u\n"
-	       "dev.sectors_per_bucket\t%u\n",
-	       sb.block_size,
-	       sb.bucket_size);
+	printf("dev.sectors_per_block\t%u\n", sb.block_size);
 
 	if (!SB_IS_BDEV(&sb)) {
 		// total_sectors includes the superblock;
-		printf("dev.cache.first_sector\t%u\n"
+		printf("dev.sectors_per_block\t%u\n"
+		       "dev.cache.first_sector\t%u\n"
 		       "dev.cache.cache_sectors\t%ju\n"
 		       "dev.cache.total_sectors\t%ju\n"
 		       "dev.cache.ordered\t%s\n"
 		       "dev.cache.discard\t%s\n"
 		       "dev.cache.pos\t\t%u\n"
 		       "dev.cache.replacement\t%ju",
+		       sb.bucket_size,
 		       sb.bucket_size * sb.first_bucket,
 		       sb.bucket_size * (sb.nbuckets - sb.first_bucket),
 		       sb.bucket_size * sb.nbuckets,
diff --git a/make-bcache.c b/make-bcache.c
index c626eae..14c605d 100644
--- a/make-bcache.c
+++ b/make-bcache.c
@@ -217,7 +217,6 @@ static void write_sb(char *dev, unsigned block_size, unsigned bucket_size,
 	uuid_generate(sb.uuid);
 	memcpy(sb.set_uuid, set_uuid, sizeof(sb.set_uuid));
 
-	sb.bucket_size	= bucket_size;
 	sb.block_size	= block_size;
 
 	uuid_unparse(sb.uuid, uuid_str);
@@ -242,6 +241,7 @@ static void write_sb(char *dev, unsigned block_size, unsigned bucket_size,
 		       sb.block_size,
 		       data_offset);
 	} else {
+		sb.bucket_size		= bucket_size;
 		sb.nbuckets		= getblocks(fd) / sb.bucket_size;
 		sb.nr_in_set		= 1;
 		sb.first_bucket		= (23 / sb.bucket_size) + 1;
-- 
2.16.2
