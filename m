Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbdBPH6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2017 02:58:13 -0500
Date: Wed, 15 Feb 2017 23:58:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] opal: Use empty structure when not defined
Message-ID: <20170216075812.GA7662@infradead.org>
References: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487204187-4004-1-git-send-email-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'd rather prefer to make the structure separately allocated as
discussed before.  Scott, can you test the patch below?  I'm not near
my devices I could test on.

---
>From b2cda0c7ec5c0ec66582655751838f519cfa1706 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 16 Feb 2017 08:49:56 +0100
Subject: block/sed-opal: make struct opal_dev private

This moves the definition of struct opal_dev into sed-opal.c.  For this a
new private data field is added to it that is passed to the send/receive
callback.  After that a lot of internals can be made private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/opal_proto.h       |  23 ++++++++++
 block/sed-opal.c         | 101 +++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/core.c |   9 ++--
 drivers/nvme/host/nvme.h |  14 ++----
 drivers/nvme/host/pci.c  |   8 +++-
 include/linux/sed-opal.h | 116 ++---------------------------------------------
 6 files changed, 131 insertions(+), 140 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index af9abc56c157..f40c9acf8895 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -19,6 +19,29 @@
 #ifndef _OPAL_PROTO_H
 #define _OPAL_PROTO_H
 
+/*
+ * These constant values come from:
+ * SPC-4 section
+ * 6.30 SECURITY PROTOCOL IN command / table 265.
+ */
+enum {
+	TCG_SECP_00 = 0,
+	TCG_SECP_01,
+};
+
+/*
+ * Token defs derived from:
+ * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
+ * 3.2.2 Data Stream Encoding
+ */
+enum opal_response_token {
+	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
+	OPAL_DTA_TOKENID_SINT = 0xe1,
+	OPAL_DTA_TOKENID_UINT = 0xe2,
+	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
+	OPAL_DTA_TOKENID_INVALID = 0X0
+};
+
 #define DTAERROR_NO_METHOD_STATUS 0x89
 #define GENERIC_HOST_SESSION_NUM 0x41
 
diff --git a/block/sed-opal.c b/block/sed-opal.c
index bf1406e5159b..bdab4dfcbafd 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -31,6 +31,77 @@
 
 #include "opal_proto.h"
 
+#define IO_BUFFER_LENGTH 2048
+#define MAX_TOKS 64
+
+typedef int (*opal_step)(struct opal_dev *dev);
+
+enum opal_atom_width {
+	OPAL_WIDTH_TINY,
+	OPAL_WIDTH_SHORT,
+	OPAL_WIDTH_MEDIUM,
+	OPAL_WIDTH_LONG,
+	OPAL_WIDTH_TOKEN
+};
+
+/*
+ * On the parsed response, we don't store again the toks that are already
+ * stored in the response buffer. Instead, for each token, we just store a
+ * pointer to the position in the buffer where the token starts, and the size
+ * of the token in bytes.
+ */
+struct opal_resp_tok {
+	const u8 *pos;
+	size_t len;
+	enum opal_response_token type;
+	enum opal_atom_width width;
+	union {
+		u64 u;
+		s64 s;
+	} stored;
+};
+
+/*
+ * From the response header it's not possible to know how many tokens there are
+ * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
+ * if we start dealing with messages that have more than that, we can increase
+ * this number. This is done to avoid having to make two passes through the
+ * response, the first one counting how many tokens we have and the second one
+ * actually storing the positions.
+ */
+struct parsed_resp {
+	int num;
+	struct opal_resp_tok toks[MAX_TOKS];
+};
+
+struct opal_dev {
+	bool supported;
+
+	void *data;
+	sec_send_recv *send_recv;
+
+	const opal_step *funcs;
+	void **func_data;
+	int state;
+	struct mutex dev_lock;
+	u16 comid;
+	u32 hsn;
+	u32 tsn;
+	u64 align;
+	u64 lowest_lba;
+
+	size_t pos;
+	u8 cmd[IO_BUFFER_LENGTH];
+	u8 resp[IO_BUFFER_LENGTH];
+
+	struct parsed_resp parsed;
+	size_t prev_d_len;
+	void *prev_data;
+
+	struct list_head unlk_lst;
+};
+
+
 static const u8 opaluid[][OPAL_UID_LENGTH] = {
 	/* users */
 	[OPAL_SMUID_UID] =
@@ -243,14 +314,14 @@ static u16 get_comid_v200(const void *data)
 
 static int opal_send_cmd(struct opal_dev *dev)
 {
-	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
+	return dev->send_recv(dev->data, dev->comid, TCG_SECP_01,
 			      dev->cmd, IO_BUFFER_LENGTH,
 			      true);
 }
 
 static int opal_recv_cmd(struct opal_dev *dev)
 {
-	return dev->send_recv(dev, dev->comid, TCG_SECP_01,
+	return dev->send_recv(dev->data, dev->comid, TCG_SECP_01,
 			      dev->resp, IO_BUFFER_LENGTH,
 			      false);
 }
@@ -1943,16 +2014,24 @@ static int check_opal_support(struct opal_dev *dev)
 	return ret;
 }
 
-void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv)
+struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 {
-	if (opal_dev->initialized)
-		return;
-	INIT_LIST_HEAD(&opal_dev->unlk_lst);
-	mutex_init(&opal_dev->dev_lock);
-	opal_dev->send_recv = send_recv;
-	if (check_opal_support(opal_dev) < 0)
+	struct opal_dev *dev;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	INIT_LIST_HEAD(&dev->unlk_lst);
+	mutex_init(&dev->dev_lock);
+	dev->data = data;
+	dev->send_recv = send_recv;
+	if (check_opal_support(dev) < 0) {
 		pr_warn("Opal is not supported on this device\n");
-	opal_dev->initialized = true;
+		kfree(dev);
+		return NULL;
+	}
+	return dev;
 }
 EXPORT_SYMBOL(init_opal_dev);
 
@@ -2350,6 +2429,8 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (!dev)
+		return -ENOTSUPP;
 	if (!dev->supported) {
 		pr_err("Not supported\n");
 		return -ENOTSUPP;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d9f49036819c..84eb86cc4a45 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -811,7 +811,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 			return nvme_nvm_ioctl(ns, cmd, arg);
 #endif
 		if (is_sed_ioctl(cmd))
-			return sed_ioctl(&ns->ctrl->opal_dev, cmd, arg);
+			return sed_ioctl(ns->ctrl->opal_dev, cmd, arg);
 		return -ENOTTY;
 	}
 }
@@ -1084,18 +1084,17 @@ static const struct pr_ops nvme_pr_ops = {
 };
 
 #ifdef CONFIG_BLK_SED_OPAL
-int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
-		    void *buffer, size_t len, bool send)
+int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
+		bool send)
 {
+	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd;
-	struct nvme_ctrl *ctrl = NULL;
 
 	memset(&cmd, 0, sizeof(cmd));
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
 	else
 		cmd.common.opcode = nvme_admin_security_recv;
-	ctrl = container_of(dev, struct nvme_ctrl, opal_dev);
 	cmd.common.nsid = 0;
 	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw10[1] = cpu_to_le32(len);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 569cba14cede..5126c4bbee1a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -126,7 +126,7 @@ struct nvme_ctrl {
 	struct list_head node;
 	struct ida ns_ida;
 
-	struct opal_dev opal_dev;
+	struct opal_dev *opal_dev;
 
 	char name[12];
 	char serial[20];
@@ -270,16 +270,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
-#ifdef CONFIG_BLK_SED_OPAL
-int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
-		    void *buffer, size_t len, bool send);
-#else
-static inline int nvme_sec_submit(struct opal_dev *dev, u16 spsp, u8 secp,
-				  void *buffer, size_t len, bool send)
-{
-	return 0;
-}
-#endif /* CONFIG_BLK_DEV_SED_OPAL */
+int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
+		bool send);
 
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e25d632bd9f2..5db8a38a8b43 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1739,6 +1739,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
+	kfree(dev->ctrl.opal_dev);
 	kfree(dev);
 }
 
@@ -1788,10 +1789,13 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	init_opal_dev(&dev->ctrl.opal_dev, &nvme_sec_submit);
+	if (!dev->ctrl.opal_dev) {
+		dev->ctrl.opal_dev =
+			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+	}
 
 	if (was_suspend)
-		opal_unlock_from_suspend(&dev->ctrl.opal_dev);
+		opal_unlock_from_suspend(dev->ctrl.opal_dev);
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index af1a85eae193..da39002285d0 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -21,117 +21,14 @@
 #include <uapi/linux/sed-opal.h>
 #include <linux/kernel.h>
 
-/*
- * These constant values come from:
- * SPC-4 section
- * 6.30 SECURITY PROTOCOL IN command / table 265.
- */
-enum {
-	TCG_SECP_00 = 0,
-	TCG_SECP_01,
-};
 struct opal_dev;
 
-#define IO_BUFFER_LENGTH 2048
-#define MAX_TOKS 64
-
-typedef int (*opal_step)(struct opal_dev *dev);
-typedef int (sec_send_recv)(struct opal_dev *ctx, u16 spsp, u8 secp,
-			    void *buffer, size_t len, bool send);
-
-
-enum opal_atom_width {
-	OPAL_WIDTH_TINY,
-	OPAL_WIDTH_SHORT,
-	OPAL_WIDTH_MEDIUM,
-	OPAL_WIDTH_LONG,
-	OPAL_WIDTH_TOKEN
-};
-
-/*
- * Token defs derived from:
- * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
- * 3.2.2 Data Stream Encoding
- */
-enum opal_response_token {
-	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
-	OPAL_DTA_TOKENID_SINT = 0xe1,
-	OPAL_DTA_TOKENID_UINT = 0xe2,
-	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
-	OPAL_DTA_TOKENID_INVALID = 0X0
-};
-
-/*
- * On the parsed response, we don't store again the toks that are already
- * stored in the response buffer. Instead, for each token, we just store a
- * pointer to the position in the buffer where the token starts, and the size
- * of the token in bytes.
- */
-struct opal_resp_tok {
-	const u8 *pos;
-	size_t len;
-	enum opal_response_token type;
-	enum opal_atom_width width;
-	union {
-		u64 u;
-		s64 s;
-	} stored;
-};
-
-/*
- * From the response header it's not possible to know how many tokens there are
- * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
- * if we start dealing with messages that have more than that, we can increase
- * this number. This is done to avoid having to make two passes through the
- * response, the first one counting how many tokens we have and the second one
- * actually storing the positions.
- */
-struct parsed_resp {
-	int num;
-	struct opal_resp_tok toks[MAX_TOKS];
-};
-
-/**
- * struct opal_dev - The structure representing a OPAL enabled SED.
- * @supported: Whether or not OPAL is supported on this controller.
- * @send_recv: The combined sec_send/sec_recv function pointer.
- * @opal_step: A series of opal methods that are necessary to complete a command.
- * @func_data: An array of parameters for the opal methods above.
- * @state: Describes the current opal_step we're working on.
- * @dev_lock: Locks the entire opal_dev structure.
- * @parsed: Parsed response from controller.
- * @prev_data: Data returned from a method to the controller.
- * @unlk_lst: A list of Locking ranges to unlock on this device during a resume.
- */
-struct opal_dev {
-	bool initialized;
-	bool supported;
-	sec_send_recv *send_recv;
-
-	const opal_step *funcs;
-	void **func_data;
-	int state;
-	struct mutex dev_lock;
-	u16 comid;
-	u32 hsn;
-	u32 tsn;
-	u64 align;
-	u64 lowest_lba;
-
-	size_t pos;
-	u8 cmd[IO_BUFFER_LENGTH];
-	u8 resp[IO_BUFFER_LENGTH];
-
-	struct parsed_resp parsed;
-	size_t prev_d_len;
-	void *prev_data;
-
-	struct list_head unlk_lst;
-};
+typedef int (sec_send_recv)(void *data, u16 spsp, u8 secp, void *buffer,
+		size_t len, bool send);
 
 #ifdef CONFIG_BLK_SED_OPAL
 bool opal_unlock_from_suspend(struct opal_dev *dev);
-void init_opal_dev(struct opal_dev *opal_dev, sec_send_recv *send_recv);
+struct opal_dev * init_opal_dev(void *data, sec_send_recv *send_recv);
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr);
 
 static inline bool is_sed_ioctl(unsigned int cmd)
@@ -168,11 +65,6 @@ static inline bool opal_unlock_from_suspend(struct opal_dev *dev)
 {
 	return false;
 }
-static inline void init_opal_dev(struct opal_dev *opal_dev,
-				 sec_send_recv *send_recv)
-{
-	opal_dev->supported = false;
-	opal_dev->initialized = true;
-}
+#define init_opal_dev(data, send_recv)		NULL
 #endif /* CONFIG_BLK_SED_OPAL */
 #endif /* LINUX_OPAL_H */
-- 
2.11.0
