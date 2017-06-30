Return-Path: <arvind.yadav.cs@gmail.com>
Return-Path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: axboe@kernel.dk,
	axboe@fb.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: constify attribute_group structures.
Date: Fri, 30 Jun 2017 15:36:27 +0530
Message-Id: <2e7b0369e63edbd7819bdddd0ddb431260e8195a.1498816266.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-block@vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  11622	    912	   2076	  14610	   3912	block/genhd.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  11686	    848	   2076	  14610	   3912	block/genhd.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d252d29..be42e4a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1071,7 +1071,7 @@ static umode_t disk_visible(struct kobject *kobj, struct attribute *a, int n)
 	return a->mode;
 }
 
-static struct attribute_group disk_attr_group = {
+static const struct attribute_group disk_attr_group = {
 	.attrs = disk_attrs,
 	.is_visible = disk_visible,
 };
-- 
1.9.1
