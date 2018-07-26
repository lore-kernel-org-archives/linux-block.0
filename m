Return-Path: <mfo@canonical.com>
From: Mauricio Faria de Oliveira <mfo@canonical.com>
To: axboe@kernel.dk
Cc: phdm@macqel.be,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.axtens@canonical.com
Subject: [PATCH 2/2] partitions/aix: append null character to print data from disk
Date: Wed, 25 Jul 2018 22:46:29 -0300
Message-Id: <20180726014629.30411-3-mfo@canonical.com>
In-Reply-To: <20180726014629.30411-1-mfo@canonical.com>
References: <20180726014629.30411-1-mfo@canonical.com>
List-ID: <linux-block@vger.kernel.org>

Even if properly initialized, the lvname array (i.e., strings)
is read from disk, and might contain corrupt data (e.g., lack
the null terminating character for strings).

So, make sure the partition name string used in pr_warn() has
the null terminating character.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Suggested-by: Daniel J. Axtens <daniel.axtens@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 block/partitions/aix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 850cbd1860d4..903f3ed175d0 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -283,10 +283,14 @@ int aix_partition(struct parsed_partitions *state)
 				next_lp_ix += 1;
 		}
 		for (i = 0; i < state->limit; i += 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);
-- 
2.17.1
