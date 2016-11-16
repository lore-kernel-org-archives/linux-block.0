Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8520 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754186AbcKPXZN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:25:13 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH v1 1/7] Include: Add definitions for sed
Date: Wed, 16 Nov 2016 16:17:26 -0700
Message-Id: <1479338252-8777-2-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds the definitions and structures for the SED
Opal code.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 include/linux/sed-opal.h      |  58 +++++++++++++++++++++
 include/linux/sed.h           |  91 ++++++++++++++++++++++++++++++++
 include/uapi/linux/sed-opal.h | 118 ++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/sed.h      |  55 ++++++++++++++++++++
 4 files changed, 322 insertions(+)
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed.h

diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
new file mode 100644
index 0000000..e0ee21e
--- /dev/null
+++ b/include/linux/sed-opal.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright © 2016 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli@intel.com>
+ *    Scott  Bauer      <scott.bauer@intel.com>
+ */
+
+#ifndef LINUX_OPAL_H
+#define LINUX_OPAL_H
+
+#include <linux/sed.h>
+#include <linux/kernel.h>
+
+enum {
+	TCG_SECP_00 = 0,
+	TCG_SECP_01,
+};
+
+struct opal_suspend_unlk {
+	void *data;
+	const char *name;
+	struct sec_ops ops;
+};
+
+int opal_save(struct block_device *bdev, struct sed_key *key);
+int opal_lock_unlock(struct block_device *bdev, struct sed_key *key);
+int opal_take_ownership(struct block_device *bdev, struct sed_key *key);
+int opal_activate_lsp(struct block_device *bdev, struct sed_key *key);
+int opal_set_new_pw(struct block_device *bdev, struct sed_key *key);
+int opal_activate_user(struct block_device *bdev, struct sed_key *key);
+int opal_reverttper(struct block_device *bdev, struct sed_key *key);
+int opal_setup_locking_range(struct block_device *bdev, struct sed_key *key);
+int opal_add_user_to_lr(struct block_device *bdev, struct sed_key *key);
+int opal_enable_disable_shadow_mbr(struct block_device *bdev, struct sed_key *key);
+int opal_unlock_from_suspend(struct opal_suspend_unlk *data);
+int opal_erase_locking_range(struct block_device *bdev, struct sed_key *key);
+
+#endif /* LINUX_OPAL_H */
diff --git a/include/linux/sed.h b/include/linux/sed.h
new file mode 100644
index 0000000..6c9bae9
--- /dev/null
+++ b/include/linux/sed.h
@@ -0,0 +1,91 @@
+/*
+ * Self-Encrypting Drive interface - sed.h
+ *
+ * Copyright (C) 2016 Intel Corporation <jonathan.derrick@intel.com>
+ *
+ * This code is the generic layer to interface with self-encrypting
+ * drives. Specific command sets should advertise support to sed uapi
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef LINUX_SED_H
+#define LINUX_SED_H
+
+#include <linux/blkdev.h>
+#include <uapi/linux/sed.h>
+
+/*
+ * sec_ops - transport specific Trusted Send/Receive functions
+ * See SPC-4 for specific definitions
+ *
+ * @sec_send: sends the payload to the trusted peripheral
+ *	SPSP: Security Protocol Specific
+ *	SECP: Security Protocol
+ *	buf: Payload
+ *	len: Payload length
+ * @recv: Receives a payload from the trusted peripheral
+ *	SPSP: Security Protocol Specific
+ *	SECP: Security Protocol
+ *	buf: Payload
+ *	len: Payload length
+ */
+
+typedef void (sec_cb)(int error, void *data);
+
+struct sec_ops {
+	int (*send)(void *data, __u16 SPSP, __u8 SECP,
+			void *buffer, size_t len,
+			sec_cb *cb, void *cb_data);
+	int (*recv)(void *data, __u16 SPSP, __u8 SECP,
+			void *buffer, size_t len,
+			sec_cb *cb, void *cb_data);
+};
+
+
+#ifdef CONFIG_SED
+int sed_save(struct block_device *bdev, struct sed_key *key);
+int sed_lock_unlock(struct block_device *bdev, struct sed_key *key);
+int sed_take_ownership(struct block_device *bdev, struct sed_key *key);
+int sed_activate_lsp(struct block_device *bdev, struct sed_key *key);
+int sed_set_pw(struct block_device *bdev, struct sed_key *key);
+int sed_activate_user(struct block_device *bdev, struct sed_key *key);
+int sed_reverttper(struct block_device *bdev, struct sed_key *key);
+int sed_setup_locking_range(struct block_device *bdev, struct sed_key *key);
+int sed_adduser_to_lr(struct block_device *bdev, struct sed_key *key);
+int sed_do_mbr(struct block_device *bdev, struct sed_key *key);
+int sed_erase_lr(struct block_device *bdev, struct sed_key *key);
+#else
+static inline int sed_save(struct block_device *bdev, struct sed_key *key)
+		{ return -EOPNOTSUPP; }
+static inline int sed_lock_unlock(struct block_device *bdev, struct sed_key *key)
+		{ return -EOPNOTSUPP; }
+static inline int sed_take_ownership(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_activate_lsp(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_set_pw(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_activate_user(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_reverttper(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_setup_locking_range(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_adduser_to_lr(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_do_mbr(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+static inline int sed_erase_lr(struct block_device *bdev, struct sed_key *key)
+                { return -EOPNOTSUPP; }
+#endif
+
+#endif /* LINUX_SED_H */
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
new file mode 100644
index 0000000..527eb9a
--- /dev/null
+++ b/include/uapi/linux/sed-opal.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright © 2016 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Author:
+ *    Rafael Antognolli <rafael.antognolli@intel.com>
+ *    Scott  Bauer      <rafael.antognolli@intel.com>
+ */
+
+#ifndef _UAPI_OPAL_H
+#define _UAPI_OPAL_H
+
+#include <linux/types.h>
+
+#define OPAL_KEY_MAX 256
+
+enum opal_mbr {
+	OPAL_MBR_ENABLE,
+	OPAL_MBR_DISABLE,
+};
+
+enum opal_user {
+	OPAL_ADMIN1,
+	OPAL_USER1,
+	OPAL_USER2,
+	OPAL_USER3,
+	OPAL_USER4,
+	OPAL_USER5,
+	OPAL_USER6,
+	OPAL_USER7,
+	OPAL_USER8,
+	OPAL_USER9,
+};
+
+struct opal_user_info {
+	bool SUM;
+	enum opal_user who;
+};
+
+enum opal_key_type {
+	OPAL_KEY_PLAIN,
+	OPAL_KEY_KEYRING,
+};
+
+enum opal_lock_state {
+	OPAL_RO = 0x01, /* 0001 */
+	OPAL_RW = 0x02, /* 0010 */
+	OPAL_LK = 0x04, /* 0100 */
+};
+
+struct opal_key {
+	__u8	lr;
+	__u8	key_type;
+	__u8	key_len;
+	__u8	key[OPAL_KEY_MAX];
+};
+
+struct opal_activate_user {
+	struct opal_user_info who;
+	struct opal_key key;
+};
+
+struct opal_user_lr_setup {
+	struct opal_user_info who;
+	struct opal_key key;
+	size_t range_start;
+	size_t range_length;
+	int    RLE; /* Read Lock enabled */
+	int    WLE; /* Write Lock Enabled */
+};
+
+struct opal_lock_unlock {
+	struct opal_user_info authority;
+	enum opal_lock_state l_state;
+	struct opal_key key;
+};
+
+struct opal_new_pw {
+	struct opal_user_info who;
+
+	/* When we're not operating in SUM, and we first set
+	 * passwords we need to set them via ADMIN authority.
+	 * After passwords are changed, we can set them via,
+	 * User authorities.
+	 * Because of this restriction we need to know about
+	 * Two different users. One in 'who' which we will use
+	 * to start the session and user_for_pw as the user we're
+	 * chaning the pw for.
+	 */
+	enum opal_user user_for_pw;
+	struct opal_key current_pin;
+	struct opal_key new_pin;
+};
+
+struct opal_mbr_data {
+	u8 enable_disable;
+	struct opal_key key;
+};
+
+#endif /* _UAPI_SED_H */
diff --git a/include/uapi/linux/sed.h b/include/uapi/linux/sed.h
new file mode 100644
index 0000000..6973044
--- /dev/null
+++ b/include/uapi/linux/sed.h
@@ -0,0 +1,55 @@
+/*
+ * Definitions for the self-encrypting drive interface
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _UAPI_SED_H
+#define _UAPI_SED_H
+
+#include <linux/types.h>
+
+enum sed_key_type {
+	OPAL,
+	OPAL_PW,
+	OPAL_ACT_USR,
+	OPAL_LR_SETUP,
+	OPAL_LOCK_UNLOCK,
+	OPAL_MBR_DATA,
+};
+
+struct sed_key {
+	__u32 sed_type;
+	union {
+		struct opal_key           __user *opal;
+		struct opal_new_pw        __user *opal_pw;
+		struct opal_activate_user __user *opal_act;
+		struct opal_user_lr_setup __user *opal_lrs;
+		struct opal_lock_unlock   __user *opal_lk_unlk;
+		struct opal_mbr_data      __user *opal_mbr;
+		/* additional command set key types */
+	};
+};
+
+
+#define IOC_SED_SAVE		   _IOW('p', 220, struct sed_key)
+#define IOC_SED_LOCK_UNLOCK	   _IOW('p', 221, struct sed_key)
+#define IOC_SED_TAKE_OWNERSHIP	   _IOW('p', 222, struct sed_key)
+#define IOC_SED_ACTIVATE_LSP       _IOW('p', 223, struct sed_key)
+#define IOC_SED_SET_PW             _IOW('p', 224, struct sed_key)
+#define IOC_SED_ACTIVATE_USR       _IOW('p', 225, struct sed_key)
+#define IOC_SED_REVERT_TPR         _IOW('p', 226, struct sed_key)
+#define IOC_SED_LR_SETUP           _IOW('p', 227, struct sed_key)
+#define IOC_SED_ADD_USR_TO_LR      _IOW('p', 228, struct sed_key)
+#define IOC_SED_ENABLE_DISABLE_MBR _IOW('p', 229, struct sed_key)
+#define IOC_SED_ERASE_LR           _IOW('p', 230, struct sed_key)
+
+#endif /* _UAPI_SED_H */
-- 
2.7.4

