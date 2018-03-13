Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] block: sed-opal: add ioctl for done-mark of shadow mbr
Date: Tue, 13 Mar 2018 14:09:00 +0100
Message-Id: <f130c3075e74406bb9d0a53d65468970e960a018.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Enable users to mark the shadow mbr as done without completely
deactivating the shadow mbr feature. This may be useful on reboots,
when the power to the disk is not disconnected in between and the shadow
mbr stores the required boot files. Of course, this saves also the
(few) commands required to enable the feature if it is already enabled
and one only wants to mark the shadow mbr as done.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f169e621279a..b201c96d23a3 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1987,13 +1987,39 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 					  struct opal_mbr_data *opal_mbr)
 {
+	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
+		? OPAL_TRUE : OPAL_FALSE;
 	const struct opal_step mbr_steps[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_done, &opal_mbr->enable_disable },
+		{ set_mbr_done, &token },
 		{ end_opal_session, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
+		{ set_mbr_enable_disable, &token },
+		{ end_opal_session, },
+		{ NULL, }
+	};
+	int ret;
+
+	if (opal_mbr->enable_disable != OPAL_MBR_ENABLE &&
+	    opal_mbr->enable_disable != OPAL_MBR_DISABLE)
+		return -EINVAL;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev, mbr_steps);
+	ret = next(dev);
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
+static int opal_mbr_status(struct opal_dev *dev, struct opal_mbr_data *opal_mbr)
+{
+	u8 token = opal_mbr->enable_disable == OPAL_MBR_ENABLE
+		? OPAL_TRUE : OPAL_FALSE;
+	const struct opal_step mbr_steps[] = {
+		{ opal_discovery0, },
+		{ start_admin1LSP_opal_session, &opal_mbr->key },
+		{ set_mbr_done, &token },
 		{ end_opal_session, },
 		{ NULL, }
 	};
@@ -2339,6 +2365,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 		ret = opal_enable_disable_shadow_mbr(dev, p);
 		break;
+	case IOC_OPAL_MBR_STATUS:
+		ret = opal_mbr_status(dev, p);
+		break;
 	case IOC_OPAL_ERASE_LR:
 		ret = opal_erase_locking_range(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 04b124fca51e..b38dc602cae3 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ENABLE_DISABLE_MBR:
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
+	case IOC_OPAL_MBR_STATUS:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 627624d35030..0cb9890cdc04 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -116,5 +116,6 @@ struct opal_mbr_data {
 #define IOC_OPAL_ENABLE_DISABLE_MBR _IOW('p', 229, struct opal_mbr_data)
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
+#define IOC_OPAL_MBR_STATUS         _IOW('p', 232, struct opal_mbr_data)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.16.1
