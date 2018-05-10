Return-Path: <udknight@gmail.com>
Return-Path: <udknight@gmail.com>
Date: Thu, 10 May 2018 11:06:37 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
        caizhiyong@hisilicon.com, rdunlap@infradead.org,
        jiangheng@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] block: add verifier for cmdline partition
Message-ID: <20180510030637.GA25734@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

I meet strange filesystem corruption issue recently, the reason
is there are overlaps partitions in cmdline partition argument.

This patch add verifier for cmdline partition, then if there are
overlaps partitions, cmdline_partition will log a warning. We don't
treat overlaps partition as a error:
"
Caizhiyong <caizhiyong@hisilicon.com> said:
Partition overlap was intentionally designed in this cmdline partition.
reference http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html
"

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes
 v4-v5:
 1:Delete unnecessary blank line at begin and end of logs.
 2:Delete newline character in log, pr_* will add newline
   automatically.

 v3-v4:
 1:Fix grammar typo, reported by Randy Dunlap.
 2:Delete unnecessary type casting, reported by Caizhiyong.
 3:Record the reason why we can't treat overlapping partitions
   as errors into changelog.

 v2-v3:
 1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
 2:Fix out of bound access in cmdline_parts_verifier.

 v1-v2:
 1:Don't treat overlaps partition as a error, but log a warning.

 Hi! Jens Axboe

 What is your suggestion?

 block/partitions/cmdline.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index e333583..60fb3df 100644
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
+static inline void overlaps_warns_header(void)
+{
+	pr_warn("Overlapping partitions are used in command line partitions.");
+	pr_warn("Don't use filesystems on overlapping partitions:");
+}
+
+static void cmdline_parts_verifier(int slot, struct parsed_partitions *state)
+{
+	int i;
+	bool header = true;
+
+	for (; slot < state->limit && state->parts[slot].has_info; slot++) {
+		for (i = slot+1; i < state->limit && state->parts[i].has_info;
+		     i++) {
+			if (has_overlaps(state->parts[slot].from,
+					 state->parts[slot].size,
+					 state->parts[i].from,
+					 state->parts[i].size)) {
+				if (header) {
+					header = false;
+					overlaps_warns_header();
+				}
+				pr_warn("%s[%llu,%llu] overlaps with "
+					"%s[%llu,%llu].",
+					state->parts[slot].info.volname,
+					(u64)state->parts[slot].from << 9,
+					(u64)state->parts[slot].size << 9,
+					state->parts[i].info.volname,
+					(u64)state->parts[i].from << 9,
+					(u64)state->parts[i].size << 9);
+			}
+		}
+	}
+}
+
 /*
  * Purpose: allocate cmdline partitions.
  * Returns:
@@ -93,6 +149,7 @@ int cmdline_partition(struct parsed_partitions *state)
 	disk_size = get_capacity(state->bdev->bd_disk) << 9;
 
 	cmdline_parts_set(parts, disk_size, 1, add_part, (void *)state);
+	cmdline_parts_verifier(1, state);
 
 	strlcat(state->pp_buf, "\n", PAGE_SIZE);
 
-- 
1.8.5.6.2.g3d8a54e.dirty
