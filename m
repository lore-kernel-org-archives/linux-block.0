Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034176AbeE1PWR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 May 2018 11:22:17 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 3/4] bcache: Move couple of functions to sysfs.c
Date: Mon, 28 May 2018 15:37:43 +0800
Message-Id: <20180528073744.71258-4-colyli@suse.de>
In-Reply-To: <20180528073744.71258-1-colyli@suse.de>
References: <20180528073744.71258-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is couple of functions that are used exclusively in sysfs.c.
Move it to there and make them static.

Besides above, it will allow further clean up.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/md/bcache/util.c  | 35 -----------------------------------
 drivers/md/bcache/util.h  |  5 -----
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0275450a0da9..36f4396dbd63 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -132,6 +132,41 @@ rw_attribute(btree_shrinker_disabled);
 rw_attribute(copy_gc_enabled);
 rw_attribute(size);
 
+static ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[],
+			    size_t selected)
+{
+	char *out = buf;
+	size_t i;
+
+	for (i = 0; list[i]; i++)
+		out += snprintf(out, buf + size - out,
+				i == selected ? "[%s] " : "%s ", list[i]);
+
+	out[-1] = '\n';
+	return out - buf;
+}
+
+static ssize_t bch_read_string_list(const char *buf, const char * const list[])
+{
+	size_t i;
+	char *s, *d = kstrndup(buf, PAGE_SIZE - 1, GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	s = strim(d);
+
+	for (i = 0; list[i]; i++)
+		if (!strcmp(list[i], s))
+			break;
+
+	kfree(d);
+
+	if (!list[i])
+		return -EINVAL;
+
+	return i;
+}
+
 SHOW(__bch_cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index 74febd5230df..fc479b026d6d 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -120,41 +120,6 @@ ssize_t bch_hprint(char *buf, int64_t v)
 		return sprintf(buf, "%llu.%i%c", q, t * 10 / 1024, units[u]);
 }
 
-ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[],
-			    size_t selected)
-{
-	char *out = buf;
-	size_t i;
-
-	for (i = 0; list[i]; i++)
-		out += snprintf(out, buf + size - out,
-				i == selected ? "[%s] " : "%s ", list[i]);
-
-	out[-1] = '\n';
-	return out - buf;
-}
-
-ssize_t bch_read_string_list(const char *buf, const char * const list[])
-{
-	size_t i;
-	char *s, *d = kstrndup(buf, PAGE_SIZE - 1, GFP_KERNEL);
-	if (!d)
-		return -ENOMEM;
-
-	s = strim(d);
-
-	for (i = 0; list[i]; i++)
-		if (!strcmp(list[i], s))
-			break;
-
-	kfree(d);
-
-	if (!list[i])
-		return -EINVAL;
-
-	return i;
-}
-
 bool bch_is_zero(const char *p, size_t n)
 {
 	size_t i;
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 268024529edd..cced87f8eb27 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -365,11 +365,6 @@ ssize_t bch_hprint(char *buf, int64_t v);
 bool bch_is_zero(const char *p, size_t n);
 int bch_parse_uuid(const char *s, char *uuid);
 
-ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[],
-			    size_t selected);
-
-ssize_t bch_read_string_list(const char *buf, const char * const list[]);
-
 struct time_stats {
 	spinlock_t	lock;
 	/*
-- 
2.17.0
