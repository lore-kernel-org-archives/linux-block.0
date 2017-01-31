Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:53760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751656AbdAaMSU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:20 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        "Simon A . F . Lund" <slund@cnexlabs.com>
Subject: [PATCH 08/12] lightnvm: add ioctls for vector I/Os
Date: Tue, 31 Jan 2017 13:17:16 +0100
Message-ID: <20170131121720.10971-9-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Enable user-space to issue vector I/O commands through ioctls. To issue
a vector I/O, the ppa list with addresses is also required and must be
mapped for the controller to access.

For each ioctl, the result and status bits are returned as well, such
that user-space can retrieve the open-channel SSD completion bits.

The implementation covers the traditional use-cases of bad block
management, and vectored read/write/erase.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
Metadata implementation, test, and fixes.
Signed-off-by: Simon A.F. Lund <slund@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/nvme/host/core.c      |   4 +
 drivers/nvme/host/lightnvm.c  | 220 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |   6 ++
 include/uapi/linux/lightnvm.h |  50 ++++++++++
 4 files changed, 280 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fc86dc..037ee99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -784,6 +784,10 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_sg_io(ns, (void __user *)arg);
 #endif
 	default:
+#ifdef CONFIG_NVM
+		if (ns->ndev)
+			return nvme_nvm_ioctl(ns, cmd, arg);
+#endif
 		return -ENOTTY;
 	}
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 733992a..3b6cd9b 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -26,6 +26,8 @@
 #include <linux/bitops.h>
 #include <linux/lightnvm.h>
 #include <linux/vmalloc.h>
+#include <linux/sched/sysctl.h>
+#include <uapi/linux/lightnvm.h>
 
 enum nvme_nvm_admin_opcode {
 	nvme_nvm_admin_identity		= 0xe2,
@@ -583,6 +585,224 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.max_phys_sect		= 64,
 };
 
+static void nvme_nvm_end_user_vio(struct request *rq, int error)
+{
+	struct completion *waiting = rq->end_io_data;
+
+	complete(waiting);
+}
+
+static int nvme_nvm_submit_user_cmd(struct request_queue *q,
+				struct nvme_ns *ns,
+				struct nvme_nvm_command *vcmd,
+				void __user *ubuf, unsigned int bufflen,
+				void __user *meta_buf, unsigned int meta_len,
+				void __user *ppa_buf, unsigned int ppa_len,
+				u32 *result, u64 *status, unsigned int timeout)
+{
+	bool write = nvme_is_write((struct nvme_command *)vcmd);
+	struct nvm_dev *dev = ns->ndev;
+	struct gendisk *disk = ns->disk;
+	struct request *rq;
+	struct bio *bio = NULL;
+	__le64 *ppa_list = NULL;
+	dma_addr_t ppa_dma;
+	__le64 *metadata = NULL;
+	dma_addr_t metadata_dma;
+	DECLARE_COMPLETION_ONSTACK(wait);
+	int ret;
+
+	rq = nvme_alloc_request(q, (struct nvme_command *)vcmd, 0,
+			NVME_QID_ANY);
+	if (IS_ERR(rq)) {
+		ret = -ENOMEM;
+		goto err_cmd;
+	}
+
+	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+
+	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
+	rq->end_io_data = &wait;
+
+	if (ppa_buf && ppa_len) {
+		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
+		if (!ppa_list) {
+			ret = -ENOMEM;
+			goto err_rq;
+		}
+		if (copy_from_user(ppa_list, (void __user *)ppa_buf,
+						sizeof(u64) * (ppa_len + 1))) {
+			ret = -EFAULT;
+			goto err_ppa;
+		}
+		vcmd->ph_rw.spba = cpu_to_le64(ppa_dma);
+	} else {
+		vcmd->ph_rw.spba = cpu_to_le64((uintptr_t)ppa_buf);
+	}
+
+	if (ubuf && bufflen) {
+		ret = blk_rq_map_user(q, rq, NULL, ubuf, bufflen, GFP_KERNEL);
+		if (ret)
+			goto err_ppa;
+		bio = rq->bio;
+
+		if (meta_buf && meta_len) {
+			metadata = dma_pool_alloc(dev->dma_pool, GFP_KERNEL,
+								&metadata_dma);
+			if (!metadata) {
+				ret = -ENOMEM;
+				goto err_map;
+			}
+
+			if (write) {
+				if (copy_from_user(metadata,
+						(void __user *)meta_buf,
+						meta_len)) {
+					ret = -EFAULT;
+					goto err_meta;
+				}
+			}
+			vcmd->ph_rw.metadata = cpu_to_le64(metadata_dma);
+		}
+
+		if (!disk)
+			goto submit;
+
+		bio->bi_bdev = bdget_disk(disk, 0);
+		if (!bio->bi_bdev) {
+			ret = -ENODEV;
+			goto err_meta;
+		}
+	}
+
+submit:
+	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_user_vio);
+
+	wait_for_completion_io(&wait);
+
+	ret = nvme_error_status(rq->errors);
+	if (result)
+		*result = rq->errors & 0x7ff;
+	if (status)
+		*status = le64_to_cpu(nvme_req(rq)->result.u64);
+
+	if (metadata && !ret && !write) {
+		if (copy_to_user(meta_buf, (void *)metadata, meta_len))
+			ret = -EFAULT;
+	}
+err_meta:
+	if (meta_buf && meta_len)
+		dma_pool_free(dev->dma_pool, metadata, metadata_dma);
+err_map:
+	if (bio) {
+		if (disk && bio->bi_bdev)
+			bdput(bio->bi_bdev);
+		blk_rq_unmap_user(bio);
+	}
+err_ppa:
+	if (ppa_buf && ppa_len)
+		dma_pool_free(dev->dma_pool, ppa_list, ppa_dma);
+err_rq:
+	blk_mq_free_request(rq);
+err_cmd:
+	return ret;
+}
+
+static int nvme_nvm_submit_vio(struct nvme_ns *ns,
+					struct nvm_user_vio __user *uvio)
+{
+	struct nvm_user_vio vio;
+	struct nvme_nvm_command c;
+	unsigned int length;
+	int ret;
+
+	if (copy_from_user(&vio, uvio, sizeof(vio)))
+		return -EFAULT;
+	if (vio.flags)
+		return -EINVAL;
+
+	memset(&c, 0, sizeof(c));
+	c.ph_rw.opcode = vio.opcode;
+	c.ph_rw.nsid = cpu_to_le32(ns->ns_id);
+	c.ph_rw.control = cpu_to_le16(vio.control);
+	c.ph_rw.length = cpu_to_le16(vio.nppas);
+
+	length = (vio.nppas + 1) << ns->lba_shift;
+
+	ret = nvme_nvm_submit_user_cmd(ns->queue, ns, &c,
+			(void __user *)(uintptr_t)vio.addr, length,
+			(void __user *)(uintptr_t)vio.metadata,
+							vio.metadata_len,
+			(void __user *)(uintptr_t)vio.ppa_list, vio.nppas,
+			&vio.result, &vio.status, 0);
+
+	if (ret && copy_to_user(uvio, &vio, sizeof(vio)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
+					struct nvm_passthru_vio __user *uvcmd)
+{
+	struct nvm_passthru_vio vcmd;
+	struct nvme_nvm_command c;
+	struct request_queue *q;
+	unsigned int timeout = 0;
+	int ret;
+
+	if (copy_from_user(&vcmd, uvcmd, sizeof(vcmd)))
+		return -EFAULT;
+	if ((vcmd.opcode != 0xF2) && (!capable(CAP_SYS_ADMIN)))
+		return -EACCES;
+	if (vcmd.flags)
+		return -EINVAL;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = vcmd.opcode;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+	c.common.cdw2[0] = cpu_to_le32(vcmd.cdw2);
+	c.common.cdw2[1] = cpu_to_le32(vcmd.cdw3);
+	/* cdw11-12 */
+	c.ph_rw.length = cpu_to_le16(vcmd.nppas);
+	c.ph_rw.control  = cpu_to_le32(vcmd.control);
+	c.common.cdw10[3] = cpu_to_le32(vcmd.cdw13);
+	c.common.cdw10[4] = cpu_to_le32(vcmd.cdw14);
+	c.common.cdw10[5] = cpu_to_le32(vcmd.cdw15);
+
+	if (vcmd.timeout_ms)
+		timeout = msecs_to_jiffies(vcmd.timeout_ms);
+
+	q = admin ? ns->ctrl->admin_q : ns->queue;
+
+	ret = nvme_nvm_submit_user_cmd(q, ns,
+			(struct nvme_nvm_command *)&c,
+			(void __user *)(uintptr_t)vcmd.addr, vcmd.data_len,
+			(void __user *)(uintptr_t)vcmd.metadata,
+							vcmd.metadata_len,
+			(void __user *)(uintptr_t)vcmd.ppa_list, vcmd.nppas,
+			&vcmd.result, &vcmd.status, timeout);
+
+	if (ret && copy_to_user(uvcmd, &vcmd, sizeof(vcmd)))
+		return -EFAULT;
+
+	return ret;
+}
+
+int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case NVME_NVM_IOCTL_ADMIN_VIO:
+		return nvme_nvm_user_vcmd(ns, 1, (void __user *)arg);
+	case NVME_NVM_IOCTL_IO_VIO:
+		return nvme_nvm_user_vcmd(ns, 0, (void __user *)arg);
+	case NVME_NVM_IOCTL_SUBMIT_VIO:
+		return nvme_nvm_submit_vio(ns, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 {
 	struct request_queue *q = ns->queue;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6377e14..330713c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -326,6 +326,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 int nvme_nvm_register_sysfs(struct nvme_ns *ns);
 void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
+int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 				    int node)
@@ -343,6 +344,11 @@ static inline int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *i
 {
 	return 0;
 }
+static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
+							unsigned long arg)
+{
+	return -ENOTTY;
+}
 #endif /* CONFIG_NVM */
 
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index 774a431..fd19f36 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -122,6 +122,44 @@ struct nvm_ioctl_dev_factory {
 	__u32 flags;
 };
 
+struct nvm_user_vio {
+	__u8 opcode;
+	__u8 flags;
+	__u16 control;
+	__u16 nppas;
+	__u16 rsvd;
+	__u64 metadata;
+	__u64 addr;
+	__u64 ppa_list;
+	__u32 metadata_len;
+	__u32 data_len;
+	__u64 status;
+	__u32 result;
+	__u32 rsvd3[3];
+};
+
+struct nvm_passthru_vio {
+	__u8 opcode;
+	__u8 flags;
+	__u8 rsvd[2];
+	__u32 nsid;
+	__u32 cdw2;
+	__u32 cdw3;
+	__u64 metadata;
+	__u64 addr;
+	__u32 metadata_len;
+	__u32 data_len;
+	__u64 ppa_list;
+	__u16 nppas;
+	__u16 control;
+	__u32 cdw13;
+	__u32 cdw14;
+	__u32 cdw15;
+	__u64 status;
+	__u32 result;
+	__u32 timeout_ms;
+};
+
 /* The ioctl type, 'L', 0x20 - 0x2F documented in ioctl-number.txt */
 enum {
 	/* top level cmds */
@@ -137,6 +175,11 @@ enum {
 
 	/* Factory reset device */
 	NVM_DEV_FACTORY_CMD,
+
+	/* Vector user I/O */
+	NVM_DEV_VIO_ADMIN_CMD = 0x41,
+	NVM_DEV_VIO_CMD = 0x42,
+	NVM_DEV_VIO_USER_CMD = 0x43,
 };
 
 #define NVM_IOCTL 'L' /* 0x4c */
@@ -154,6 +197,13 @@ enum {
 #define NVM_DEV_FACTORY		_IOW(NVM_IOCTL, NVM_DEV_FACTORY_CMD, \
 						struct nvm_ioctl_dev_factory)
 
+#define NVME_NVM_IOCTL_IO_VIO		_IOWR(NVM_IOCTL, NVM_DEV_VIO_USER_CMD, \
+						struct nvm_passthru_vio)
+#define NVME_NVM_IOCTL_ADMIN_VIO	_IOWR(NVM_IOCTL, NVM_DEV_VIO_ADMIN_CMD,\
+						struct nvm_passthru_vio)
+#define NVME_NVM_IOCTL_SUBMIT_VIO	_IOWR(NVM_IOCTL, NVM_DEV_VIO_CMD,\
+						struct nvm_user_vio)
+
 #define NVM_VERSION_MAJOR	1
 #define NVM_VERSION_MINOR	0
 #define NVM_VERSION_PATCHLEVEL	0
-- 
2.9.3

