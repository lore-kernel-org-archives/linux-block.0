Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E339E193
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683386; cv=none; b=ERlesN2rFal0SD5UeUp3pOYOonI1Oo8OT9GmutyeZmpZBPT40cM1beiTQqiHxs3Qv5g8AyxR3JXxY40PZM2LYuwtab3ukfDU4n9Ka5osYGENQ7uPxh4MBoIXO+etfIBlTUwObfzWzVCmNFP3LVmf0pHZ5pxu5hsXI334WvLk5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683386; c=relaxed/simple;
	bh=dj8PD0bV7WxDaz50jZsoJvVW74sj3zxOrvB0e5eyf7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwr7FqSgjiecz2l+me1LJGhGMcXtG03uTCxpQYdqFDr1EyYD2q0aZ6JjnXXFnOaAF2ChreQU6kR/HmhMFoZfYeX5MM+hKUrztA03rf6DIDBEECPCqntkOEFo0IxwqbdpMQaWXC+mJQwKnMHWG5xQpCCmt8WzNKQwUPg3OzBLzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bd05GOhO; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bd05GOhO"
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-12c726f46baso3281582c88.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683377; x=1777288177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75yCVnzGKfJT2emEspO0FE+TDcVr+9HkteEyYz8G0CI=;
        b=TJ2Cz4TGrVD8lczij3yRC72AjN0U33p82ptnXokPPPMoIBYnMXKoYYE5jS4QRzPqIg
         C98LTGkOjX/XwZWkzXX+CZFyDdkJkUh6zUEIXgSQugORCxBbB4OnP1XNN09YWgUlBCoH
         NGRe8fY2Qrvop0Tw1hxNmqw8G1w/JTM6oCqZfHDyLKQmCI6bmumYGwjhEUjlJ+lYWF2n
         TVy7Ax/A2y3BMxF1KB0Aq7eW+2/O8uLxVZ+g2ACmrAfTUgjghlQEMmV7f0i3eUJ+2198
         nO2INLOuZAyuclEJUEwWvQaoutjsuiln+gU7lQS3z6+H/MyRBG0WnmnmVlJ080k4GMIt
         cvlw==
X-Forwarded-Encrypted: i=1; AFNElJ/flfifY3h4Lj6VKWn2dfnhnVTxghTS5monhKBzwyPbKfWS2mQS934DzmYfTSMwu3E1rS+XpCsPwhK12Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1vmJM+yPjvVvZ/zXI/Hnv31KYy/SkSvUacvQ+pAOLc+yj/MU
	hWi3VRAVNbGQB0dgIGs5wFS9tXeyUU3z0RN41hXmdydjm4DVkchEhIAZi8jV/E4RrGN81eMcjoN
	vKxIe5L1uFyIZbXUl8Vs9iJzGYxM5nYaB2rMP/6XrpBbD5UUdrw0BiMFUlJgrtZQCJsosI/q4pC
	pmb0LQZrK+ek3NaqdoJSv+1n76zw/MGkOTuQhtdXfqsyAsDaHA9EQgs2LdJjzTVbRZ5KaGe5OUt
	4Uy4zZ9cjiMTKtt1w==
X-Gm-Gg: AeBDies9P2U0o3RsvC00hMQODAaVUxiS8MOr0IMWCantS9wJ76RuasqWKiMsczCIWlm
	7jhUNg0Hf5SlK9Zdqf2bgLVCkChIiBAFMJrUlglcOS3H73KytgGMEwgAeHB1kWKBZUz1VhT+d6G
	M+GuAZnUpLaT8BIo8wdnmIIyIDxBqs6Zdevi/CpaWJJP2qcUyOpyxnxF+4JSxukN9bsIw3XwCjG
	JpZoOw1DpqwpUTBMq5PRCtcrXf7gqCL4zbYGb7DcFdpe6NSfTTh/bD9vCwzmpWp560W78Y5fuNm
	WP+o3MJIplDyh9wcQbNArl+nbE1yy4jxEbJsnkfTKtd9jdKZ+HqYGYPCwvNHoAJfsHE8AtJUVgw
	ClGFbgVGfQcICckITt9k97htrqH59Mt2lXzR2tXyFC3QZQ/FnuqxLZnP84+jJwp4QMWvXPcmAF1
	4IFoHGVhp9R2RMA1v6BfK4/2CWmYhA3l7QQ6Os2nWZJh5wjF1YeXMo05XBrvGw3iCSPPc=
X-Received: by 2002:a05:7022:6ba1:b0:12b:ee92:a60e with SMTP id a92af1059eb24-12c73f6c422mr5219846c88.8.1776683377179;
        Mon, 20 Apr 2026 04:09:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12c906d34f6sm66384c88.2.2026.04.20.04.09.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:09:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so55512715ad.0
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776683375; x=1777288175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75yCVnzGKfJT2emEspO0FE+TDcVr+9HkteEyYz8G0CI=;
        b=Bd05GOhOu8lCZI3y9bydzYdSIAw7mNbSylb8+jZR3eOp+4x8Bg8A/QCNQ1d9X3er68
         A8diatdK0uQKX01B3N44iTgIkdEeAnXwMbOw6/7ReebAGjJxdW2F7y0wztKRROv0J5LU
         g+cbU1wJgFWY6juoGk+jucncIIHwmSL3tvpI0=
X-Forwarded-Encrypted: i=1; AFNElJ86UQgZMTXP413ceUH2kg2p3pANuX8kK26PWQo/btXFfg0Z95TNkF470+7j+0DX3pfrbBjrK8OrVbQH0Q==@vger.kernel.org
X-Received: by 2002:a17:902:b493:b0:2b0:c451:ae8a with SMTP id d9443c01a7336-2b5f9eaf437mr84032065ad.13.1776683374898;
        Mon, 20 Apr 2026 04:09:34 -0700 (PDT)
X-Received: by 2002:a17:902:b493:b0:2b0:c451:ae8a with SMTP id d9443c01a7336-2b5f9eaf437mr84031865ad.13.1776683374415;
        Mon, 20 Apr 2026 04:09:34 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm103115415ad.22.2026.04.20.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:33 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	axboe@kernel.dk
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/3] scsi: use percpu counters for iorequest_cnt and iodone_cnt
Date: Mon, 20 Apr 2026 17:08:39 +0530
Message-ID: <20260420113846.1401374-4-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
References: <20260420113846.1401374-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

iorequest_cnt and iodone_cnt are updated on every command dispatch and
completion, often from different CPUs on high queue depth workloads.
Using adjacent atomic_t fields caused cache line contention between the
submission and completion paths.

Represent these statistics with struct percpu_counter so increments are
mostly local to each CPU, avoiding false sharing without growing
struct scsi_device further for cache-line padding.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/scsi_error.c  |  2 +-
 drivers/scsi/scsi_lib.c    |  8 ++++----
 drivers/scsi/scsi_scan.c   |  9 +++++++++
 drivers/scsi/scsi_sysfs.c  | 27 +++++++++++++++++++++++----
 include/scsi/scsi_device.h |  5 +++--
 5 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 147127fb4db9..c7424ce92f3e 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -370,7 +370,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 	 */
 	if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
 		return BLK_EH_DONE;
-	atomic_inc(&scmd->device->iodone_cnt);
+	percpu_counter_inc(&scmd->device->iodone_cnt);
 	if (scsi_abort_command(scmd) != SUCCESS) {
 		set_host_byte(scmd, DID_TIME_OUT);
 		scsi_eh_scmd_add(scmd);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6e8c7a42603e..0b05cb63f630 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1554,7 +1554,7 @@ static void scsi_complete(struct request *rq)
 
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
-	atomic_inc(&cmd->device->iodone_cnt);
+	percpu_counter_inc(&cmd->device->iodone_cnt);
 	if (cmd->result)
 		atomic_inc(&cmd->device->ioerr_cnt);
 
@@ -1592,7 +1592,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	struct Scsi_Host *host = cmd->device->host;
 	int rtn = 0;
 
-	atomic_inc(&cmd->device->iorequest_cnt);
+	percpu_counter_inc(&cmd->device->iorequest_cnt);
 
 	/* check if the device is still usable */
 	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
@@ -1614,7 +1614,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
-		atomic_dec(&cmd->device->iorequest_cnt);
+		percpu_counter_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1647,7 +1647,7 @@ static enum scsi_qc_status scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
-		atomic_dec(&cmd->device->iorequest_cnt);
+		percpu_counter_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 9749a8dbe964..0b4fa89149af 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -351,6 +351,15 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 
 	scsi_sysfs_device_initialize(sdev);
 
+	ret = percpu_counter_init(&sdev->iorequest_cnt, 0, GFP_KERNEL);
+	if (ret)
+		goto out_device_destroy;
+	ret = percpu_counter_init(&sdev->iodone_cnt, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&sdev->iorequest_cnt);
+		goto out_device_destroy;
+	}
+
 	if (scsi_device_is_pseudo_dev(sdev))
 		return sdev;
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dfc3559e7e04..1f5b2dc156a8 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -516,6 +516,10 @@ static void scsi_device_dev_release(struct device *dev)
 	if (vpd_pgb7)
 		kfree_rcu(vpd_pgb7, rcu);
 	kfree(sdev->inquiry);
+	if (percpu_counter_initialized(&sdev->iodone_cnt))
+		percpu_counter_destroy(&sdev->iodone_cnt);
+	if (percpu_counter_initialized(&sdev->iorequest_cnt))
+		percpu_counter_destroy(&sdev->iorequest_cnt);
 	kfree(sdev);
 
 	if (parent)
@@ -936,11 +940,26 @@ static ssize_t
 show_iostat_counterbits(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	return snprintf(buf, 20, "%d\n", (int)sizeof(atomic_t) * 8);
+	/*
+	 * iorequest_cnt and iodone_cnt are per-CPU sums (s64); ioerr_cnt and
+	 * iotmo_cnt remain atomic_t.  Report the widest counter for tools.
+	 */
+	return snprintf(buf, 20, "%zu\n", sizeof(s64) * 8);
 }
 
 static DEVICE_ATTR(iocounterbits, S_IRUGO, show_iostat_counterbits, NULL);
 
+#define show_sdev_iostat_percpu(field)					\
+static ssize_t								\
+show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
+		    char *buf)						\
+{									\
+	struct scsi_device *sdev = to_scsi_device(dev);			\
+	unsigned long long count = percpu_counter_sum(&sdev->field);	\
+	return snprintf(buf, 20, "0x%llx\n", count);			\
+}									\
+static DEVICE_ATTR(field, 0444, show_iostat_##field, NULL)
+
 #define show_sdev_iostat(field)						\
 static ssize_t								\
 show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
@@ -950,10 +969,10 @@ show_iostat_##field(struct device *dev, struct device_attribute *attr,	\
 	unsigned long long count = atomic_read(&sdev->field);		\
 	return snprintf(buf, 20, "0x%llx\n", count);			\
 }									\
-static DEVICE_ATTR(field, S_IRUGO, show_iostat_##field, NULL)
+static DEVICE_ATTR(field, 0444, show_iostat_##field, NULL)
 
-show_sdev_iostat(iorequest_cnt);
-show_sdev_iostat(iodone_cnt);
+show_sdev_iostat_percpu(iorequest_cnt);
+show_sdev_iostat_percpu(iodone_cnt);
 show_sdev_iostat(ioerr_cnt);
 show_sdev_iostat(iotmo_cnt);
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 9c2a7bbe5891..ad80b500ced9 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -8,6 +8,7 @@
 #include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
+#include <linux/percpu_counter.h>
 #include <linux/sbitmap.h>
 
 struct bsg_device;
@@ -271,8 +272,8 @@ struct scsi_device {
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
 #define SCSI_DEFAULT_DEVICE_BLOCKED	3
 
-	atomic_t iorequest_cnt;
-	atomic_t iodone_cnt;
+	struct percpu_counter iorequest_cnt;
+	struct percpu_counter iodone_cnt;
 	atomic_t ioerr_cnt;
 	atomic_t iotmo_cnt;
 
-- 
2.43.7

