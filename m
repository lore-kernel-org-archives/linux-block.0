Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A8C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649D216F4
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHUTJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:09:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:63958 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfHUTJH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 15:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="169519764"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 12:09:06 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 3/3] block: sed-opal: Add support to read/write opal tables generically
Date:   Wed, 21 Aug 2019 13:10:51 -0600
Message-Id: <20190821191051.3535-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821191051.3535-1-revanth.rajashekar@intel.com>
References: <20190821191051.3535-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This feature gives the user RW access to any opal table with admin1
authority.

The flags described in the new structure determines if the user
wants to read/write the data. Flags are checked for valid values in
order to allow future features to be added to the ioctl.

Previously exposed opal UIDs allows the user to easily select the
desired table to retrieve its UID.

The ioctl provides a size and offset field and internally will loop
data accesses to return the full data block.

The ioctl provides a private field with the intentiont to accommodate
any future expansions to the ioctl.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/sed-opal.c              | 140 ++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  16 ++++
 3 files changed, 157 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 7179582730b6..3f41fc56f3cb 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1896,6 +1896,108 @@ static int get_msid_cpin_pin(struct opal_dev *dev, void *data)
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
+	int err = 0;
+	const char *data_read;
+
+	err = parse_and_check_status(dev);
+	if (err)
+		return err;
+
+	dev->prev_d_len = response_get_string(&dev->parsed, 1, &data_read);
+
+	dev->prev_data = data_read;
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
+	int err = 0;
+	size_t off = 0, max_read_size = OPAL_MAX_READ_TABLE;
+	u64 table_len = 0, len = 0;
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
+		add_token_u64(&err, dev, offset + off + len); /* end row value */
+
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
@@ -2382,6 +2484,41 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);

+static int opal_generic_read_write_table(struct opal_dev *dev,
+                                         struct opal_read_write_table *rw_tbl)
+{
+	const struct opal_step write_table_steps[] = {
+		{ start_admin1LSP_opal_session, &rw_tbl->key },
+		{ write_table_data, rw_tbl },
+		{ end_opal_session, }
+	};
+
+	const struct opal_step read_table_steps[] = {
+		{ start_admin1LSP_opal_session, &rw_tbl->key },
+		{ read_table_data, rw_tbl },
+		{ end_opal_session, }
+	};
+	int ret = 0;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	if (rw_tbl->flags & OPAL_TABLE_READ) {
+		if (rw_tbl->size > 0)
+			ret = execute_steps(dev, read_table_steps,
+					    ARRAY_SIZE(read_table_steps));
+	} else if (rw_tbl->flags & OPAL_TABLE_WRITE) {
+		if (rw_tbl->size > 0)
+			ret = execute_steps(dev, write_table_steps,
+					    ARRAY_SIZE(write_table_steps));
+	} else {
+		pr_debug("Invalid bit set in the flag.\n");
+		ret = -EINVAL;
+	}
+	mutex_unlock(&dev->dev_lock);
+
+	return ret;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -2444,6 +2581,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
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
index 59eed0bdffd3..a803ed0534da 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -65,6 +65,7 @@ enum opal_uid {
 	OPAL_C_PIN_TABLE,
 	OPAL_LOCKING_INFO_TABLE,
 	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
+	OPAL_DATASTORE,
 	/* C_PIN_TABLE object ID's */
 	OPAL_C_PIN_MSID,
 	OPAL_C_PIN_SID,
@@ -128,6 +129,8 @@ static const __u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
+	[OPAL_DATASTORE] =
+		{ 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00 },

 	/* C_PIN_TABLE object ID's */
 	[OPAL_C_PIN_MSID] =
@@ -223,6 +226,18 @@ struct opal_shadow_mbr {
 	__u64 size;
 };

+struct opal_read_write_table {
+	struct opal_key key;
+	const __u64 data;
+	const __u8 table_uid[OPAL_UID_LENGTH];
+	__u64 offset;
+	__u64 size;
+	#define OPAL_TABLE_READ (1 << 0)
+	#define OPAL_TABLE_WRITE (1 << 1)
+	__u64 flags;
+	__u64 priv;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -238,5 +253,6 @@ struct opal_shadow_mbr {
 #define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)
 #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
 #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
+#define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)

 #endif /* _UAPI_SED_OPAL_H */
--
2.17.1

