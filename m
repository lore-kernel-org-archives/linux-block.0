Return-Path: <udknight@gmail.com>
Return-Path: <udknight@gmail.com>
Date: Thu, 3 May 2018 19:17:48 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: add verifier for cmdline partition
Message-ID: <20180503111748.GA904@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

I meet strange filesystem corruption issue recently, the reason
is there are overlaps partitions in cmdline partition argument.

This patch add verifier for cmdline partition, then if there are
overlaps partitions, cmdline_partition will return error and log
a error message.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 block/partitions/cmdline.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..6754c2a 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -58,6 +58,62 @@ static int __init cmdline_parts_setup(char *s)
 }
 __setup("blkdevparts=", cmdline_parts_setup);
 
+static bool has_overlaps(sector_t from, sector_t size,
+			 sector_t from2, sector_t size2)
+{
+	sector_t end = from + size;
+	sector_t end2 = from2 + size2;
+
+	if (from >= from2 && from < end2)
+		return true;
+
+	if (end > from2 && end <= end2)
+		return true;
+
+	if (from2 >= from && from2 < end)
+		return true;
+
+	if (end2 > from && end2 <= end)
+		return true;
+
+	return false;
+}
+
+static bool cmdline_parts_verifier(int slot, struct parsed_partitions *state)
+{
+	int i, j = slot;
+	bool ret = true;
+
+	for (; state->parts[slot].has_info; slot++) {
+		for (i = j; state->parts[i].has_info; i++) {
+			if (i == slot)
+				continue;
+
+			if (has_overlaps(state->parts[slot].from,
+					 state->parts[slot].size,
+					 state->parts[i].from,
+					 state->parts[i].size)) {
+				pr_err("Invalid cmdline partition:"
+				       "%s[%llu,%llu] overlaps with "
+				       "%s[%llu,%llu]",
+				       state->parts[slot].info.volname,
+				       (u64)state->parts[slot].from << 9,
+				       (u64)state->parts[slot].size << 9,
+				       state->parts[i].info.volname,
+				       (u64)state->parts[i].from << 9,
+				       (u64)state->parts[i].size << 9);
+				ret = false;
+				break;
+			}
+		}
+
+		if (!ret)
+			break;
+	}
+
+	return ret;
+}
+
 /*
  * Purpose: allocate cmdline partitions.
  * Returns:
@@ -70,6 +126,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	sector_t disk_size;
 	char bdev[BDEVNAME_SIZE];
 	struct cmdline_parts *parts;
+	int ret;
 
 	if (cmdline) {
 		if (bdev_parts)
@@ -93,8 +150,12 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	if (!cmdline_parts_verifier(1, (void *)state))
+		ret = -1;
+	else
+		ret = 1;
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-	return 1;
+	return ret;
 }
-- 
1.8.5.6.2.g3d8a54e.dirty
