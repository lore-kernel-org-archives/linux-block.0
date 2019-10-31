Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F73CA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5AF208C0
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfJaQKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:10:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:11861 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaQKh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 12:10:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 09:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="190675615"
Received: from revanth.lm.intel.com ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2019 09:10:36 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v3 2/3] block: sed-opal: Add support to read/write opal tables generically
Date:   Thu, 31 Oct 2019 10:13:21 -0600
Message-Id: <20191031161322.16624-3-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031161322.16624-1-revanth.rajashekar@intel.com>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This feature gives the user RW access to any opal table with admin1
authority. The flags described in the new structure determines if the user
wants to read/write the data. Flags are checked for valid values in
order to allow future features to be added to the ioctl.

The user can provide the desired table's UID. Also, the ioctl provides a
size and offset field and internally will loop data accesses to return
the full data block. Read overrun is prevented by the initiator's
sec_send_recv() backend. The ioctl provides a private field with the
intention to accommodate any future expansions to the ioctl.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h            |   1 -
 block/sed-opal.c              | 172 ++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  20 ++++
 4 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 5532412d567c..710911864e1d 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -76,7 +76,6 @@ enum opal_response_token {
  * Derived from: TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Section: 6.3 Assigned UIDs
  */
-#define OPAL_UID_LENGTH 8
 #define OPAL_METHOD_LENGTH 8
 #define OPAL_MSID_KEYLEN 15
 #define OPAL_UID_LENGTH_HALF 4
diff --git a/block/sed-opal.c b/block/sed-opal.c
index d6e2ec0d8a3a..1d5afaaf0826 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1967,6 +1967,113 @@ static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
 	return 0;
 }
 
+static int write_table_data(struct opal_dev *dev, void *data)
+{
+	struct opal_read_write_table *write_tbl = data;
+
+	return generic_table_write_data(dev, write_tbl->data, write_tbl->offset,
+					write_tbl->size, write_tbl->table_uid);
+}
+
+static int read_table_data_cont(struct opal_dev *dev)
+{
+	int err;
+	const char *data_read;
+
+	err = parse_and_check_status(dev);
+	if (err)
+		return err;
+
+	dev->prev_d_len = response_get_string(&dev->parsed, 1, &data_read);
+	dev->prev_data = (void *)data_read;
+	if (!dev->prev_data) {
+		pr_debug("%s: Couldn't read data from the table.\n", __func__);
+		return OPAL_INVAL_PARAM;
+	}
+
+	return 0;
+}
+
+/*
+ * IO_BUFFER_LENGTH = 2048
+ * sizeof(header) = 56
+ * No. of Token Bytes in the Response = 11
+ * MAX size of data that can be carried in response buffer
+ * at a time is : 2048 - (56 + 11) = 1981 = 0x7BD.
+ */
+#define OPAL_MAX_READ_TABLE (0x7BD)
+
+static int read_table_data(struct opal_dev *dev, void *data)
+{
+	struct opal_read_write_table *read_tbl = data;
+	int err;
+	size_t off = 0, max_read_size = OPAL_MAX_READ_TABLE;
+	u64 table_len, len;
+	u64 offset = read_tbl->offset, read_size = read_tbl->size - 1;
+	u8 __user *dst;
+
+	err = generic_get_table_info(dev, read_tbl->table_uid, OPAL_TABLE_ROWS);
+	if (err) {
+		pr_debug("Couldn't get the table size\n");
+		return err;
+	}
+
+	table_len = response_get_u64(&dev->parsed, 4);
+
+	/* Check if the user is trying to read from the table limits */
+	if (read_size > table_len || offset > table_len - read_size) {
+		pr_debug("Read size exceeds the Table size limits (%llu vs. %llu)\n",
+			  offset + read_size, table_len);
+		return -EINVAL;
+	}
+
+	while (off < read_size) {
+		err = cmd_start(dev, read_tbl->table_uid, opalmethod[OPAL_GET]);
+
+		add_token_u8(&err, dev, OPAL_STARTLIST);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_STARTROW);
+		add_token_u64(&err, dev, offset + off); /* start row value */
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_ENDROW);
+
+		len = min(max_read_size, (size_t)(read_size - off));
+		add_token_u64(&err, dev, offset + off + len); /* end row value
+							       */
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		add_token_u8(&err, dev, OPAL_ENDLIST);
+
+		if (err) {
+			pr_debug("Error building read table data command.\n");
+			break;
+		}
+
+		err = finalize_and_send(dev, read_table_data_cont);
+		if (err)
+			break;
+
+		/* len+1: This includes the NULL terminator at the end*/
+		if (dev->prev_d_len > len + 1) {
+			err = -EOVERFLOW;
+			break;
+		}
+
+		dst = (u8 __user *)(uintptr_t)read_tbl->data;
+		if (copy_to_user(dst + off, dev->prev_data, dev->prev_d_len)) {
+			pr_debug("Error copying data to userspace\n");
+			err = -EFAULT;
+			break;
+		}
+		dev->prev_data = NULL;
+
+		off += len;
+	}
+
+	return err;
+}
+
 static int end_opal_session(struct opal_dev *dev, void *data)
 {
 	int err = 0;
@@ -2453,6 +2560,68 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);
 
+static int opal_read_table(struct opal_dev *dev,
+			   struct opal_read_write_table *rw_tbl)
+{
+	const struct opal_step read_table_steps[] = {
+		{ start_admin1LSP_opal_session, &rw_tbl->key },
+		{ read_table_data, rw_tbl },
+		{ end_opal_session, }
+	};
+	int ret = 0;
+
+	if (!rw_tbl->size)
+		return ret;
+
+	return execute_steps(dev, read_table_steps,
+			     ARRAY_SIZE(read_table_steps));
+}
+
+static int opal_write_table(struct opal_dev *dev,
+			    struct opal_read_write_table *rw_tbl)
+{
+	const struct opal_step write_table_steps[] = {
+		{ start_admin1LSP_opal_session, &rw_tbl->key },
+		{ write_table_data, rw_tbl },
+		{ end_opal_session, }
+	};
+	int ret = 0;
+
+	if (!rw_tbl->size)
+		return ret;
+
+	return execute_steps(dev, write_table_steps,
+			     ARRAY_SIZE(write_table_steps));
+}
+
+static int opal_generic_read_write_table(struct opal_dev *dev,
+					 struct opal_read_write_table *rw_tbl)
+{
+	int ret, bit_set;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+
+	bit_set = fls64(rw_tbl->flags) - 1;
+	switch (bit_set) {
+	case OPAL_READ_TABLE:
+		ret = opal_read_table(dev, rw_tbl);
+		break;
+	case OPAL_WRITE_TABLE:
+		ret = opal_write_table(dev, rw_tbl);
+		break;
+	default:
+		pr_debug("Invalid bit set in the flag (%016llx).\n",
+			 rw_tbl->flags);
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -2515,6 +2684,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_PSID_REVERT_TPR:
 		ret = opal_reverttper(dev, p, true);
 		break;
+	case IOC_OPAL_GENERIC_TABLE_RW:
+		ret = opal_generic_read_write_table(dev, p);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 53c28d750a45..1ac0d712a9c3 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -42,6 +42,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_PSID_REVERT_TPR:
 	case IOC_OPAL_MBR_DONE:
 	case IOC_OPAL_WRITE_SHADOW_MBR:
+	case IOC_OPAL_GENERIC_TABLE_RW:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index c6d035fa1b6c..6f5af1a84213 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -113,6 +113,25 @@ struct opal_shadow_mbr {
 	__u64 size;
 };
 
+/* Opal table operations */
+enum opal_table_ops {
+	OPAL_READ_TABLE,
+	OPAL_WRITE_TABLE,
+};
+
+#define OPAL_UID_LENGTH 8
+struct opal_read_write_table {
+	struct opal_key key;
+	const __u64 data;
+	const __u8 table_uid[OPAL_UID_LENGTH];
+	__u64 offset;
+	__u64 size;
+#define OPAL_TABLE_READ (1 << OPAL_READ_TABLE)
+#define OPAL_TABLE_WRITE (1 << OPAL_WRITE_TABLE)
+	__u64 flags;
+	__u64 priv;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -128,5 +147,6 @@ struct opal_shadow_mbr {
 #define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)
 #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
+#define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.17.1

