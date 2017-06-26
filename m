Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35664 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdFZJ6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id w126so2844510wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:15 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 05/20] lightnvm: pblk: expose max sec per write on sysfs
Date: Mon, 26 Jun 2017 11:57:14 +0200
Message-Id: <1498471049-25505-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Allow to configure the number of maximum sectors per write command
through sysfs. This makes it easier to tune write command sizes for
different controller configurations.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  |  7 ++++++-
 drivers/lightnvm/pblk-init.c  |  2 ++
 drivers/lightnvm/pblk-sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk.h       |  2 ++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4e0de995cd90..567ed5aa5a0f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -397,6 +397,11 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
 #endif
 }
 
+void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write)
+{
+	pblk->sec_per_write = sec_per_write;
+}
+
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -478,7 +483,7 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
 		   unsigned long secs_to_flush)
 {
-	int max = pblk->max_write_pgs;
+	int max = pblk->sec_per_write;
 	int min = pblk->min_write_pgs;
 	int secs_to_sync = 0;
 
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3ec3deff709f..6dd85860e419 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -249,6 +249,8 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->pgs_in_buffer = NVM_MEM_PAGE_WRITE * geo->sec_per_pg *
 						geo->nr_planes * geo->nr_luns;
 
+	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
+
 	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
 		pr_err("pblk: cannot support device max_phys_sect\n");
 		return -EINVAL;
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 3c1a586c09a2..bf8fc6699299 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -290,6 +290,11 @@ static ssize_t pblk_sysfs_lines_info(struct pblk *pblk, char *page)
 	return sz;
 }
 
+static ssize_t pblk_sysfs_get_sec_per_write(struct pblk *pblk, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n", pblk->sec_per_write);
+}
+
 #ifdef CONFIG_NVM_DEBUG
 static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
 {
@@ -354,6 +359,29 @@ static ssize_t pblk_sysfs_gc_force(struct pblk *pblk, const char *page,
 	return len;
 }
 
+static ssize_t pblk_sysfs_set_sec_per_write(struct pblk *pblk,
+					     const char *page, size_t len)
+{
+	size_t c_len;
+	int sec_per_write;
+
+	c_len = strcspn(page, "\n");
+	if (c_len >= len)
+		return -EINVAL;
+
+	if (kstrtouint(page, 0, &sec_per_write))
+		return -EINVAL;
+
+	if (sec_per_write < pblk->min_write_pgs
+				|| sec_per_write > pblk->max_write_pgs
+				|| sec_per_write % pblk->min_write_pgs != 0)
+		return -EINVAL;
+
+	pblk_set_sec_per_write(pblk, sec_per_write);
+
+	return len;
+}
+
 static struct attribute sys_write_luns = {
 	.name = "write_luns",
 	.mode = 0444,
@@ -399,6 +427,11 @@ static struct attribute sys_gc_force = {
 	.mode = 0200,
 };
 
+static struct attribute sys_max_sec_per_write = {
+	.name = "max_sec_per_write",
+	.mode = 0644,
+};
+
 static struct attribute sys_gc_rl_max = {
 	.name = "gc_rl_max",
 	.mode = 0200,
@@ -417,6 +450,7 @@ static struct attribute *pblk_attrs[] = {
 	&sys_errors_attr,
 	&sys_gc_state,
 	&sys_gc_force,
+	&sys_max_sec_per_write,
 	&sys_gc_rl_max,
 	&sys_rb_attr,
 	&sys_stats_ppaf_attr,
@@ -449,6 +483,8 @@ static ssize_t pblk_sysfs_show(struct kobject *kobj, struct attribute *attr,
 		return pblk_sysfs_lines(pblk, buf);
 	else if (strcmp(attr->name, "lines_info") == 0)
 		return pblk_sysfs_lines_info(pblk, buf);
+	else if (strcmp(attr->name, "max_sec_per_write") == 0)
+		return pblk_sysfs_get_sec_per_write(pblk, buf);
 #ifdef CONFIG_NVM_DEBUG
 	else if (strcmp(attr->name, "stats") == 0)
 		return pblk_sysfs_stats_debug(pblk, buf);
@@ -465,6 +501,8 @@ static ssize_t pblk_sysfs_store(struct kobject *kobj, struct attribute *attr,
 		return pblk_sysfs_rate_store(pblk, buf, len);
 	else if (strcmp(attr->name, "gc_force") == 0)
 		return pblk_sysfs_gc_force(pblk, buf, len);
+	else if (strcmp(attr->name, "max_sec_per_write") == 0)
+		return pblk_sysfs_set_sec_per_write(pblk, buf, len);
 
 	return 0;
 }
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 70b65d308dea..c18fda522b34 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -499,6 +499,7 @@ struct pblk {
 	/* pblk provisioning values. Used by rate limiter */
 	struct pblk_rl rl;
 
+	int sec_per_write;
 	struct semaphore erase_sem;
 
 	unsigned char instance_uuid[16];
@@ -613,6 +614,7 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
  * pblk core
  */
 struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw);
+void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
 void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int rw);
-- 
2.7.4
