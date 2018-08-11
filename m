Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 14/17] bcache: move open brace at end of function definitions to next line
Date: Sat, 11 Aug 2018 13:19:57 +0800
Message-Id: <20180811052000.103680-15-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This is not a preferred style to place open brace '{' at the end of
function definition, checkpatch.pl reports error for such coding
style. This patch moves them into the start of the next new line.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 01fc3c015a58..e3ecf08a10fc 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2152,7 +2152,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 kobj_attribute_write(register,		register_bcache);
 kobj_attribute_write(register_quiet,	register_bcache);
 
-static bool bch_is_open_backing(struct block_device *bdev) {
+static bool bch_is_open_backing(struct block_device *bdev)
+{
 	struct cache_set *c, *tc;
 	struct cached_dev *dc, *t;
 
@@ -2166,7 +2167,8 @@ static bool bch_is_open_backing(struct block_device *bdev) {
 	return false;
 }
 
-static bool bch_is_open_cache(struct block_device *bdev) {
+static bool bch_is_open_cache(struct block_device *bdev)
+{
 	struct cache_set *c, *tc;
 	struct cache *ca;
 	unsigned int i;
@@ -2178,7 +2180,8 @@ static bool bch_is_open_cache(struct block_device *bdev) {
 	return false;
 }
 
-static bool bch_is_open(struct block_device *bdev) {
+static bool bch_is_open(struct block_device *bdev)
+{
 	return bch_is_open_cache(bdev) || bch_is_open_backing(bdev);
 }
 
-- 
2.18.0
