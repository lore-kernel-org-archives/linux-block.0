Return-Path: <kidegamoses88@gmail.com>
Return-Path: <kidegamoses88@gmail.com>
Date: Wed, 20 Jun 2018 19:14:35 +0300
From: kidega <kidegamoses88@gmail.com>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 4.17.0-rc3 1/1]partition: Remove trailing spaces and correct
 indenting
Message-ID: <20180620161434.GA3513@kidega-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Reply-To:

>remove trailing spaces
>correct indenting 

Signed-off-by: kidega <kidegamoses88@gmail.com>
---
 block/partitions/mac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b609533..ec6dea5 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -97,16 +97,14 @@ int mac_partition(struct parsed_partitions *state)
 			int goodness = 0;
 
 			mac_fix_string(part->processor, 16);
-			mac_fix_string(part->name, 32);
-			mac_fix_string(part->type, 32);					
-		    
+			mac_fix_string(part->name, 32); mac_fix_string(part->type, 32);
 			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
 			    && strcasecmp(part->processor, "powerpc") == 0)
 				goodness++;
 
 			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
-			    || (strncasecmp(part->type, "Linux", 5) == 0
-			        && strcasecmp(part->type, "Linux_swap") != 0)) {
+				|| (strncasecmp(part->type, "Linux", 5) == 0
+				&& strcasecmp(part->type, "Linux_swap") != 0)) {
 				int i, l;
 
 				goodness++;
-- 
2.7.4
