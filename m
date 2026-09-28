Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46B448B9A
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576085; cv=none; b=m2a632+KKrmiZF5bDyx6vg/t3s96QI1TxULmuru1szHUXlsTwhKjok1pDTn+E+69tMoORp03W2eLrYVup48Hj/5zP+F/ZiwM0QB8MQVgtX6tkv+UMvj/qF8YOZL21V6Ufvx4UseYjCdmQ0mFfF5QY/47mqozfHwd71eswWrwUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576085; c=relaxed/simple;
	bh=7r+V+jVPQrC5LcsAZf6x1aQgjVtgaSej7Xy58Quao3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+Q8QaoT9ZTNSCjwJOg0nL7IbkLyccmx27c2+ylTC4m2uyD1CWFQA1NqP0a9tJGTzdKrgsQ5/Xm8CkKIjg2lg9hWYwUjyVspMPfNPW9pfPv3FnIk5coapkcBrfTkHGD/XHenlm2EkbJnqFuJS6G+JKx540+M4J5dUAnv1wSEEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9DwN8+M; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9DwN8+M"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e5eso1137019a12.3
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2026 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790576068; x=1791180868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xfUgcfdNrsOahIl/sWmrbAKM5SnGIujr5IFt5eyfbtk=;
        b=p9DwN8+MFgBYpx1Qe5M/tz7rRoFghRSHQfWtobXFeMbC6/d3zQAAuMHfQxPPjGFVT5
         QW6wAnsd2W3aSbJd7ZxQ2Lf23yKXRxZHeApvnAmqkG0BbE9Sj3Ez8HjDY4qUtJnsNh8n
         ge1i0STBkGQQ0e1DwqYjXgmljQ0oqU4V6uFJCyjREeq5LKgP0NgtxBWvinS8FfqHw6Ju
         yGLhDu24JWbHE4mqzfnbs1uCWzz4N3Fad3rAxwEv1I5r3wIg6xaKAycrVUOvuEgoKUSf
         kPa3EduyCaWr3MBKY7xR8et976vgP0z4X0MU3xeIX1fDE9ubGbmz0AXgxzpKEWN+OzJd
         y6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576068; x=1791180868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xfUgcfdNrsOahIl/sWmrbAKM5SnGIujr5IFt5eyfbtk=;
        b=RH0TnpENz3pTA9p40UUCEym7D5mcmHPaSuI/fe3t+Q5o3LSl+x2eAVXmSrGdROywcB
         IAMSimEW42EGtrVd6HIsWd3KtitmpQu8A//I+LPvUQ/IiOsYR6eXjhPp96E221zMDjlI
         DdGlS2VjdddR0zMx3qBCKvQrNT3tmS+L+2rPBEP8vfkmtGrbUbRfv+gAhzgTj+WOnrb3
         /MaFHG+sxy5N0ourd/Sq9Zhs26Z9s0u4G1cLPbEzxa/k4IrE2DIzrRFTVom4ahfnTjc1
         zha4wAzguz60FRlndfsSKQuHTaTZK6Wg1gMykKGDzoeKM/wdNhDnATdXk5qlwfhT2etz
         p2HA==
X-Forwarded-Encrypted: i=1; AKwUvBywRYYryZ8+PPyngzLQRzLZ91t+2mWJwKAlOPB5zn994ditDaEgGc45Y5zFT76Y+oyMQbsF37uz6Fk3Pw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoZqZlV4XTEsjODb/vOd8kYzRjXnJygjDDujDxyfd7yA2K3nIt
	drnB/Pt5vz9w7vcv+ExgoQhugyKtkmRpnsanXuWEA9ow/eOdhiiPD1jJ
X-Gm-Gg: AYBFou0NcEQ897xpaukvtCK+eWo785ULcRsofAizharWqH2oq02WW5Zn+q7Gih2HhEh
	xxnH679z+PzCiQVmhzpBvba3jSZ+F6Ixn/5SVzLieOeADPYRLhTg+o+VS7hGeg8vTuMBQuS3Hi/
	ysd2bIJ2pYClMbbCY3Bp/0nwEc7oMog0r8K/N/aqWBmg9nY/fjrQ8lBiaTRW1RELR4Y+M0NdEYi
	s1ThZB6lDNjo79Bxf/v3laGIr/G2v3K8x0p1SU3cb2g6tZ3MBEf1QcvoDKiN9DcTQH0ddcYuWfl
	ldftjF8Hsog95CSFlEY31mvHVHjItVnQ8j4eCfF1rgTcrhFoXyAvLBZ6dzmXhINwkWYeuAi0Jje
	O7ewkRX9o3yWdq+KUfoa6WFfk2xp0vvdQH7LLRndzbWsotnbi9f1cdmByOK1T3CJBJOafk07f3M
	dtgFSCOj9j68KbtcG4BAXl6r+3lm/4FE/rmdMW3IGkGftGtV9r/0pgmh5I7GXXT/znMvk7Gdzzn
	PYthOgvSH7gQAMiZXkUs2hhXG8mVo905SjcIjZuhJiadetihAX0BHPn7m1Ra5CutXPIKX8HsZqG
	kJI=
X-Received: by 2002:a17:90b:4406:b0:39e:261:4e0d with SMTP id 98e67ed59e1d1-3a098b4b1a6mr11163739a91.25.1790576067568;
        Sun, 27 Sep 2026 23:14:27 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9892dbfsm18864088a91.11.2026.09.27.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:27 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v6 3/3] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Sun, 27 Sep 2026 23:14:17 -0700
Message-ID: <20260928061417.1574676-4-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928061417.1574676-1-yupeng0921@gmail.com>
References: <20260928061417.1574676-1-yupeng0921@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implementation:
* Add a `cgroup_id` attribute under the nvmet namespace folder, e.g.:
  /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/cgroup_id
* We can write a cgroup id to it, then that cgroup will control
  the IOs used by the namespace.
* Write 0 to clear it.
* The cgroup_id could be modified when the namespace is disabled.
* Support both block device backed namespaces and file backed namespaces.
* Only the direct io scenario is supported, enabling a namespace that
  has both cgroup_id and buffered_io set fails with -EINVAL.

Change since v2:
* Fix the in ns->cgroup_path error free issue nvmet_ns_cgroup_path_store.
* Use nvmet_blkcg_begin/end in nvmet_bdev_zmgmt_send_work.

Change since v3:
* Use cgroup_id instead of cgroup_path.

Signed-off-by: Peng Yu <yupeng0921@gmail.com>
Assisted-by: Claude:claude-fable-5 [Claude Code]
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
---
 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 59 +++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 6 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6286e38436dd..cef832303d72 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -561,6 +561,50 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+#ifdef CONFIG_BLK_CGROUP
+static ssize_t nvmet_ns_cgroup_id_show(struct config_item *item, char *page)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	ssize_t ret;
+
+	mutex_lock(&subsys->lock);
+	ret = snprintf(page, PAGE_SIZE, "%llu\n", ns->cgroup_id);
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+static ssize_t nvmet_ns_cgroup_id_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	u64 cgroup_id;
+	int ret;
+
+	ret = kstrtou64(page, 0, &cgroup_id);
+	if (ret)
+		return ret;
+
+	mutex_lock(&subsys->lock);
+
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Writing 0 clears the association. */
+	ns->cgroup_id = cgroup_id;
+	ret = count;
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, cgroup_id);
+#endif /* CONFIG_BLK_CGROUP */
+
 #ifdef CONFIG_PCI_P2PDMA
 static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page)
 {
@@ -833,6 +877,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+#ifdef CONFIG_BLK_CGROUP
+	&nvmet_ns_attr_cgroup_id,
+#endif
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43871a8f56ca..6d9d55eb11eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/cgroup.h>
 #include <linux/hex.h>
 #include <linux/module.h>
 #include <linux/random.h>
@@ -474,8 +475,57 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+#ifdef CONFIG_BLK_CGROUP
+static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	struct cgroup *cgrp;
+
+	if (!ns->cgroup_id)
+		return 0;
+
+	/*
+	 * Buffered writes will be handled by a separate thread,
+	 * these IOs have no namespace/cgroup information at that time,
+	 * so we don't support buffered io.
+	 */
+	if (ns->buffered_io) {
+		pr_err("cgroup_id is not supported with buffered_io: %s\n",
+		       ns->device_path);
+		return -EINVAL;
+	}
+
+	cgrp = cgroup_get_from_id(ns->cgroup_id);
+	if (IS_ERR(cgrp)) {
+		pr_err("failed to resolve cgroup id %llu: %ld\n",
+		       ns->cgroup_id, PTR_ERR(cgrp));
+		return PTR_ERR(cgrp);
+	}
+
+	ns->cgrp = cgrp;
+	return 0;
+}
+
+static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+	if (ns->cgrp) {
+		cgroup_put(ns->cgrp);
+		ns->cgrp = NULL;
+	}
+}
+#else
+static inline int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
+{
+	return 0;
+}
+
+static inline void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 {
+	nvmet_blkcg_ns_disable(ns);
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
 }
@@ -602,6 +652,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_unlock;
 
+	ret = nvmet_blkcg_ns_enable(ns);
+	if (ret)
+		goto out_dev_disable;
+
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
 		goto out_dev_disable;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..0014e5ef2853 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -297,6 +297,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
 				GFP_KERNEL);
 	}
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
@@ -322,6 +323,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
 					opf, GFP_KERNEL);
+			nvmet_blkcg_set_bio(req->ns, bio);
 			bio->bi_iter.bi_sector = sector;
 
 			bio_chain(bio, prev);
@@ -358,6 +360,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 	bio_init(bio, req->ns->bdev, req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
 
@@ -366,10 +369,16 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
+	bool associated;
+	int ret;
+
 	if (!bdev_write_cache(req->ns->bdev))
 		return 0;
 
-	if (blkdev_issue_flush(req->ns->bdev))
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = blkdev_issue_flush(req->ns->bdev);
+	nvmet_blkcg_end(associated);
+	if (ret)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	return 0;
 }
@@ -380,9 +389,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
 	sector_t nr_sects;
+	bool associated;
 	int i;
 	u16 status = NVME_SC_SUCCESS;
 
+	associated = nvmet_blkcg_begin(ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 				sizeof(range));
@@ -394,6 +405,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
 	}
+	nvmet_blkcg_end(associated);
 
 	if (bio) {
 		bio->bi_private = req;
@@ -431,6 +443,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	struct bio *bio = NULL;
 	sector_t sector;
 	sector_t nr_sector;
+	bool associated;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, 0))
@@ -440,8 +453,11 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
+	nvmet_blkcg_end(associated);
+
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f927..570e65259ad8 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -79,6 +79,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	struct kiocb *iocb = &req->f.iocb;
 	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
 	struct iov_iter iter;
+	bool associated;
+	ssize_t ret;
 	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -97,7 +99,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
-	return call_iter(iocb, &iter);
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = call_iter(iocb, &iter);
+	nvmet_blkcg_end(associated);
+	return ret;
 }
 
 static void nvmet_file_io_done(struct kiocb *iocb, long ret)
@@ -251,7 +256,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 u16 nvmet_file_flush(struct nvmet_req *req)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	bool associated;
+	int ret;
+
+	associated = nvmet_blkcg_begin(req->ns);
+	ret = vfs_fsync(req->ns->file, 1);
+	nvmet_blkcg_end(associated);
+	return errno_to_nvme_status(req, ret);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
@@ -274,10 +285,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
 	loff_t offset, len;
+	bool associated;
 	u16 status = 0;
 	int ret;
 	int i;
 
+	associated = nvmet_blkcg_begin(req->ns);
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
@@ -300,6 +313,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		}
 	}
+	nvmet_blkcg_end(associated);
 
 	nvmet_req_complete(req, status);
 }
@@ -336,6 +350,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	bool associated;
 	int ret;
 
 	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
@@ -347,7 +362,9 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 		return;
 	}
 
+	associated = nvmet_blkcg_begin(req->ns);
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	nvmet_blkcg_end(associated);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..494091d7c88b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -21,6 +21,8 @@
 #include <linux/radix-tree.h>
 #include <linux/t10-pi.h>
 #include <linux/kfifo.h>
+#include <linux/kthread.h>
+#include <linux/cgroup.h>
 
 #define NVMET_DEFAULT_VS		NVME_VS(2, 1, 0)
 
@@ -115,6 +117,16 @@ struct nvmet_ns {
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
+#ifdef CONFIG_BLK_CGROUP
+	u64			cgroup_id;
+	/*
+	 * Resolved from ->cgroup_id when the namespace is enabled and
+	 * released when it is disabled, so it has the same lifetime and
+	 * visibility rules as ->bdev and ->file.
+	 */
+	struct cgroup		*cgrp;
+#endif
+
 	struct config_group	device_group;
 	struct config_group	group;
 
@@ -732,6 +744,53 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 
+#ifdef CONFIG_BLK_CGROUP
+static inline void nvmet_blkcg_set_bio(struct nvmet_ns *ns, struct bio *bio)
+{
+	struct cgroup_subsys_state *css;
+
+	if (!ns->cgrp)
+		return;
+
+	rcu_read_lock();
+	css = cgroup_e_css(ns->cgrp, &io_cgrp_subsys);
+	bio_associate_blkg_from_css(bio, css);
+	rcu_read_unlock();
+}
+
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	struct cgroup_subsys_state *css;
+
+	if (!ns->cgrp || !in_task() || !(current->flags & PF_KTHREAD))
+		return false;
+
+	css = cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
+	kthread_associate_blkcg(css);
+	css_put(css);
+	return true;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+	if (associated)
+		kthread_associate_blkcg(NULL);
+}
+#else
+static inline void nvmet_blkcg_set_bio(struct nvmet_ns *ns, struct bio *bio)
+{
+}
+
+static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
+{
+	return false;
+}
+
+static inline void nvmet_blkcg_end(bool associated)
+{
+}
+#endif /* CONFIG_BLK_CGROUP */
+
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 23a17c02abee..a9836d44f5e6 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -480,8 +480,11 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 	struct block_device *bdev = req->ns->bdev;
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	u16 status = NVME_SC_SUCCESS;
+	bool associated;
 	int ret;
 
+	associated = nvmet_blkcg_begin(req->ns);
+
 	if (op == REQ_OP_LAST) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
 		status = NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_DNR;
@@ -511,6 +514,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 		status = blkdev_zone_mgmt_errno_to_nvme_status(ret);
 
 out:
+	nvmet_blkcg_end(associated);
 	nvmet_req_complete(req, status);
 }
 
@@ -580,6 +584,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		bio = bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
 	}
 
+	nvmet_blkcg_set_bio(req->ns, bio);
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
 	bio->bi_iter.bi_sector = sect;
 	bio->bi_private = req;
-- 
2.53.0

