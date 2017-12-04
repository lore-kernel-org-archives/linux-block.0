Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:47011 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbdLDFQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 00:16:48 -0500
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, jack@suse.cz, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, npiggin@gmail.com,
        rgoldwyn@suse.com, vbabka@suse.cz, mhocko@suse.com,
        pombredanne@nexb.com, vinmenon@codeaurora.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 4/4] lockdep: Add a boot parameter enabling to track page locks using lockdep and disable it by default
Date: Mon,  4 Dec 2017 14:16:23 +0900
Message-Id: <1512364583-26070-5-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
References: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

To track page locks using lockdep, we need a huge memory space for
lockdep_map per page. So, it would be better to make it disabled by
default and provide a boot parameter to turn it on. Do it.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 lib/Kconfig.debug                               |  5 ++++-
 mm/filemap.c                                    | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f20ed5e..5e8d15d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -712,6 +712,13 @@
 	crossrelease_fullstack
 			[KNL] Allow to record full stack trace in cross-release
 
+	lockdep_pagelock=
+			[KNL] Boot-time lockdep_pagelock enabling option.
+			Storage of lockdep_map per page to track lock_page()/
+			unlock_page() is disabled by default. With this switch,
+			we can turn it on.
+			on: enable the feature
+
 	cryptomgr.notests
                         [KNL] Disable crypto self-tests
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 45fdb3a..c609e97 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1185,7 +1185,10 @@ config LOCKDEP_PAGELOCK
 	select PAGE_EXTENSION
 	help
 	 PG_locked lock is a kind of crosslock. Using crossrelease feature,
-	 PG_locked lock can work with lockdep.
+	 PG_locked lock can work with lockdep. Even if you include this
+	 feature on your build, it is disabled in default. You should pass
+	 "lockdep_pagelock=on" to boot parameter in order to enable it. It
+	 consumes a fair amount of memory if enabled.
 
 config BOOTPARAM_LOCKDEP_CROSSRELEASE_FULLSTACK
 	bool "Enable the boot parameter, crossrelease_fullstack"
diff --git a/mm/filemap.c b/mm/filemap.c
index 34251fb..cb7b20b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1231,8 +1231,24 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 
 #ifdef CONFIG_LOCKDEP_PAGELOCK
 
+static int lockdep_pagelock;
+static int __init allow_lockdep_pagelock(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "on"))
+		lockdep_pagelock = 1;
+
+	return 0;
+}
+early_param("lockdep_pagelock", allow_lockdep_pagelock);
+
 static bool need_lockdep_pagelock(void)
 {
+	if (!lockdep_pagelock)
+		return false;
+
 	return true;
 }
 
@@ -1286,6 +1302,10 @@ static void init_zones_in_node(pg_data_t *pgdat)
 static void init_lockdep_pagelock(void)
 {
 	pg_data_t *pgdat;
+
+	if (!lockdep_pagelock)
+		return;
+
 	for_each_online_pgdat(pgdat)
 		init_zones_in_node(pgdat);
 }
@@ -1305,6 +1325,9 @@ struct lockdep_map *get_page_map(struct page *p)
 {
 	struct page_ext *e;
 
+	if (!lockdep_pagelock)
+		return NULL;
+
 	e = lookup_page_ext(p);
 	if (!e)
 		return NULL;
-- 
1.9.1
