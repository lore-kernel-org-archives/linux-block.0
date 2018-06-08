Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Fri, 8 Jun 2018 11:57:13 +0300
From: Kitone ELvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] Signed-off-by: Kitone ELvis Peter <elviskitone@gmail.com>
Message-ID: <20180608085712.GA5389@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Subject: REMOVE CODING STYLE ERRORS AND WARNINGS

Removed trailing spaces, used tab instead of spaces and also removed the
space between a variable and the '++' operator to improve code readability
---
 block/partitions/acorn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index fbeb697..3bfe39d 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -79,7 +79,7 @@ static int riscix_partition(struct parsed_partitions *state,
 {
 	Sector sect;
 	struct riscix_record *rr;
-	
+
 	rr = read_part_sector(state, first_sect, &sect);
 	if (!rr)
 		return -1;
@@ -152,7 +152,7 @@ static int linux_partition(struct parsed_partitions *state,
 		put_partition(state, slot++, first_sect +
 				 le32_to_cpu(linuxp->start_sect),
 				 le32_to_cpu(linuxp->nr_sects));
-		linuxp ++;
+		linux++;
 	}
 	strlcat(state->pp_buf, " >", PAGE_SIZE);
 
@@ -269,7 +269,7 @@ int adfspart_check_ADFS(struct parsed_partitions *state)
 	dr = adfs_partition(state, "ADFS", data, 0, slot++);
 	if (!dr) {
 		put_dev_sector(sect);
-    		return 0;
+		return 0;
 	}
 
 	heads = dr->heads + ((dr->lowsector >> 6) & 1);
@@ -365,10 +365,10 @@ int adfspart_check_ICS(struct parsed_partitions *state)
 	 */
 	data = read_part_sector(state, 0, &sect);
 	if (!data)
-	    	return -1;
+		return -1;
 
 	if (!valid_ics_sector(data)) {
-	    	put_dev_sector(sect);
+		put_dev_sector(sect);
 		return 0;
 	}
 
-- 
2.7.4
