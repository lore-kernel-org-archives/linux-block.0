Return-Path: <arvind.yadav.cs@gmail.com>
Return-Path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: axboe@kernel.dk,
	axboe@fb.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Constify attribute_group structures.
Date: Fri, 30 Jun 2017 15:44:35 +0530
Message-Id: <8f55a9617ff8ac9ce8154d5bb7dc0181fd37bee4.1498817631.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-block@vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5302	    544	      0	   5846	   16d6	block/partition-generic.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   5342	    480	      0	   5822	   16be	block/partition-generic.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index ff07b91..47fa20d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -196,7 +196,7 @@ static DEVICE_ATTR(discard_alignment, S_IRUGO, part_discard_alignment_show,
 	NULL
 };
 
-static struct attribute_group part_attr_group = {
+static const struct attribute_group part_attr_group = {
 	.attrs = part_attrs,
 };
 
-- 
1.9.1
