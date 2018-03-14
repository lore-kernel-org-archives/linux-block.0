Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8.1/8.4] block: sed-opal: ioctl for writing to shadow mbr
Date: Wed, 14 Mar 2018 07:15:42 +0100
Message-Id: <81404de84e5c3967e014e508e2d9f655301ece08.1521006596.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5> <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

Allow modification of the shadow mbr. If the shadow mbr is not marked as
done, this data will be presented read only as the device content. Only
after marking the shadow mbr as done and unlocking a locking range the
actual content is accessible.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c              | 76 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  8 +++++
 3 files changed, 85 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index b201c96d23a3..aa49fcc30462 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1491,6 +1491,54 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int write_shadow_mbr(struct opal_dev *dev, void *data)
+{
+	struct opal_shadow_mbr *shadow = data;
+	const u8 __user *src;
+	u8 *dst;
+	size_t off;
+	u64 len;
+	int err = 0;
+
+	/* FIXME: this is the maximum we can use for IO_BUFFER_LENGTH=2048.
+	 *        Instead of having constant, it would be nice to compute the
+	 *        actual value depending on IO_BUFFER_LENGTH
+	 */
+	len = 1950;
+
+	/* do the actual transmission(s) */
+	src = (u8 *) shadow->data;
+	for (off = 0 ; off < shadow->size; off += len) {
+		len = min(len, shadow->size - off);
+
+		pr_debug("MBR: write bytes %zu+%llu/%llu\n",
+			 off, len, shadow->size);
+		err = start_opal_cmd(dev, opaluid[OPAL_MBR],
+				     opalmethod[OPAL_SET]);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_WHERE);
+		add_token_u64(&err, dev, shadow->offset + off);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_VALUES);
+		dst = add_bytestring_header(&err, dev, len);
+		if (!dst)
+			break;
+		if (copy_from_user(dst, src + off, len))
+			err = -EFAULT;
+
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		if (err)
+			break;
+
+		err = finalize_and_send(dev, parse_and_check_status);
+		if (err)
+			break;
+	}
+	return err;
+}
+
 static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 			  struct opal_dev *dev)
 {
@@ -2036,6 +2084,31 @@ static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
 	return ret;
 }
 
+static int opal_write_shadow_mbr(struct opal_dev *dev,
+				 struct opal_shadow_mbr *info)
+{
+	const struct opal_step mbr_steps[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &info->key },
+		{ write_shadow_mbr, info },
+		{ end_opal_session, },
+		{ NULL, }
+	};
+	int ret;
+
+	if (info->size == 0)
+		return 0;
+
+	if (!access_ok(VERIFY_READ, info->data, info->size))
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, mbr_steps);
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
 static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 {
 	struct opal_suspend_data *suspend;
@@ -2368,6 +2441,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_MBR_STATUS:
 		ret = opal_mbr_status(dev, p);
 		break;
+	case IOC_OPAL_WRITE_SHADOW_MBR:
+		ret = opal_write_shadow_mbr(dev, p);
+		break;
 	case IOC_OPAL_ERASE_LR:
 		ret = opal_erase_locking_range(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index b38dc602cae3..cf08cdc13cbd 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
+	case IOC_OPAL_WRITE_SHADOW_MBR:
 	case IOC_OPAL_MBR_STATUS:
 		return true;
 	}
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 0cb9890cdc04..ab4b69778bd0 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -104,6 +104,13 @@ struct opal_mbr_data {
 	__u8 __align[7];
 };
 
+struct opal_shadow_mbr {
+	struct opal_key key;
+	const __u64 data;
+	__u64 offset;
+	__u64 size;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -117,5 +124,6 @@ struct opal_mbr_data {
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
 #define IOC_OPAL_MBR_STATUS         _IOW('p', 232, struct opal_mbr_data)
+#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 233, struct opal_shadow_mbr)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.16.1
