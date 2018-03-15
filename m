Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54831 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbeCOKnH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 06:43:07 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 3/4] bcache-tools: print more super block information in bcache-super-show
Date: Thu, 15 Mar 2018 18:42:39 +0800
Message-Id: <20180315104240.24647-4-colyli@suse.de>
In-Reply-To: <20180315104240.24647-1-colyli@suse.de>
References: <20180315104240.24647-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch prints out more super block information. The more
detailed and exact information is helpful to analyse and debug
cache device and backing device states.

Signed-off-by: Coly Li <colyli@suse.de>
---
 bcache-super-show.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bcache-super-show.c b/bcache-super-show.c
index 515c596..2d46cac 100644
--- a/bcache-super-show.c
+++ b/bcache-super-show.c
@@ -131,12 +131,18 @@ int main(int argc, char **argv)
 		case BCACHE_SB_VERSION_CDEV:
 		case BCACHE_SB_VERSION_CDEV_WITH_UUID:
 			printf(" [cache device]\n");
+			printf("sb.nbuckets\t\t%" PRIu64 "\n", sb.nbuckets);
+			printf("sb.bucket_size\t\t%d\n", sb.bucket_size);
+			printf("sb.nr_in_set\t\t%d\n", sb.nr_in_set);
+			printf("sb.nr_this_dev\t\t%d\n", sb.nr_this_dev);
 			break;
 
 		// The second adds data offset support
 		case BCACHE_SB_VERSION_BDEV:
 		case BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
 			printf(" [backing device]\n");
+			printf("sb.data_offset\t\t%" PRIu64 "\n",
+			       sb.data_offset);
 			break;
 
 		default:
@@ -145,6 +151,14 @@ int main(int argc, char **argv)
 			return 0;
 	}
 
+	printf("sb.block_size\t\t%d\n", sb.block_size);
+	printf("sb.offset\t\t%" PRIu64 "\n", sb.offset);
+	printf("sb.flags\t\t%" PRIx64 "\n", sb.flags);
+	printf("sb.seq\t\t\t%" PRIu64 "\n", sb.seq);
+	printf("sb.last_mount\t\t%" PRIu32 "\n", sb.last_mount);
+	printf("sb.first_bucket\t\t%d\n", sb.first_bucket);
+	printf("sb.keys\t\t\t%d\n", sb.keys);
+
 	putchar('\n');
 
 	char label[SB_LABEL_SIZE + 1];
-- 
2.16.2
