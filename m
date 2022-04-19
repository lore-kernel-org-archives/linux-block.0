Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiDSLD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350821AbiDSLD1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:03:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AADC1FA4E
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366043; x=1681902043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AO7XZBEhi1By4NanAu/ixvqdG8OOolfgUjOvr2Ll2gE=;
  b=pD/E0n4ZnnVigxRHACbV48Pa5fpu6m29lqQAivI6gXpaShDmNx3ZQtwK
   EuBOEbQus7gDrooCJmaLDje1/Piq+QYuBzMKjLBF/xU2YTJhEDb0mdUT8
   ytdROIROFOZBwvdFn+06dXR2vBCsGy83ZWmRlop19gJrZ0AUV+59qAhRl
   RjaruaeC9nyt8oP049WASc/+DZaABGx0/6k6+eDEHv94QdmczqqPReq23
   56m+LNqPIlWkKGB+HeLRR79P0ODmoxHx6J1jDFD8ybT+qapPLTZg1tgHi
   /MZWVxZpxoj1ieO/tX3fyBaTcLXRlkEZoECVuNU39tWZTFnZVkS+cBJTn
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198252961"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:43 +0800
IronPort-SDR: lii3IllGKbnl4DEr7GN7QKcUZTnvzlZWKxczOs1ctoUdU3r+t1onX5wrRDf1oJGZHGwu0QZG9m
 FcqqKyZZpogymRPaIS+/u5T60NKOtt9PXkNI/2baQ15Ij4oGjju7zsz4J2xbqwsmoPtFOpAAk5
 amgB8uEh1UH4ehO9UMiqOvtv1T97vBmYM+MGvQRhRe3jRsOuiBxKqos0mxbaeIuFo+LimGXSik
 l4B2czLVsLcN3fVnjhSxs/rJeSzyW/3tuvqL0LtKYd7sn2wvo4I5IyvyAGsMNiLSbD1Jqpj7c0
 BHK7m+75EsbprLxcn5c2yTok
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:31:50 -0700
IronPort-SDR: sHAFCa4Z2VXgltVU3RcrkPtY1lzI4m1MWT4lY3bUBjnBhYmi5JVp/yoGn3xoRl0PFMU+0Qtfer
 aJN7rf7zkU4MTb2yzhw+2tuD/QX1wSCjpdvkuzH5e9Lc4McRN4Sq9F4U2I1qHCE51cvi7SB/kV
 S/Yx4q6CDCFe6Mdx9NcxRDcR/hMKZYyCduDGiT3gsrBlwZyQdCsnacVqQNdji8CJq6YkQPV2M6
 RO1lG/YAi22UWOuTQkcKkTUJ6p7TbZpYZh5Nefz/x/NB7X67iJshuoWCLPKkfVeuBeCIQguVqO
 DJ0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:00:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLSX3tT7z1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650366044; x=1652958045; bh=AO7XZBEhi1By4NanAu
        /ixvqdG8OOolfgUjOvr2Ll2gE=; b=BfDhITdlCIK/EQoRlrpSo2oPfQfxIU2w8q
        KcWKLuTSzszt9Cw2hk3Kx1Y59QHAf0BIvEXRBtmD3jUlIl6cZRXXesmjbApPLVdt
        rd+BEpcy9c1udY/yNB/VQd8ztNckzxhScBBr4CHTlqQgbJyGsfwPI8xPL+fHABfL
        Xc+crn6hS5/hh5p9TzesPEHcXB/0HlhR+ZpMoBpwX2dOiKE4h682H48sr7R5Y/ZK
        NpoJHWsWP+4Ziy303/9YWS18N60icHFqD1WuXzm8397lF/rlJ3xhbTPn68sYJNu+
        1R/8qkFU3AjMPKvzqviAYLgE4NZvyNkVMmjZrHKTI1WS0nhdCi4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6XVBuiwTdvll for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 04:00:44 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLSW42n1z1Rvlx;
        Tue, 19 Apr 2022 04:00:43 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 4/4] block: null_blk: Improve device creation with configfs
Date:   Tue, 19 Apr 2022 20:00:38 +0900
Message-Id: <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the directory name used to create a nullb device through
sysfs is not used as the device name, potentially causing headaches for
users if devices are already created through the modprobe operation
withe the nr_device module parameter not set to 0. E.g. a user can do
"mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
/dev/nullb0 wasalready created from modprobe. In this case, the configfs
nullb device will be named nullb1, causing confusion for the user.

Simplify this by using the configfs directory name as the nullb device
name, always, unless another nullb device is already using the same
name. E.g. if modprobe created nullb0, then:

$ mkdir /sys/kernel/config/nullb/nullb0
mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
exists

will be reported to th user.

To implement this, the function null_find_dev_by_name() is added to
check for the existence of a nullb device with the name used for a new
configfs device directory. nullb_group_make_item() uses this new
function to check if the directory name can be used as the disk name.
Finally, null_add_dev() is modified to use the device config item name
as the disk name for new nullb device, for devices created using
configfs. The naming of devices created though modprobe remains
unchanged.

Of note is that it is possible for a user to create through configfs a
nullb device with the same name as an existing device. E.g.

$ mkdir /sys/kernel/config/nullb/null will successfully create the nullb
device "null" but this device will however not appear under /dev/ since
/dev/null already exists.

Suggested-by: Joseph Bacik <josef@toxicpanda.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 96b6eb4ca60a..49d89ae013de 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -232,6 +232,7 @@ static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
 static int null_add_dev(struct nullb_device *dev);
+static struct nullb *null_find_dev_by_name(const char *name);
 static void null_free_device_storage(struct nullb_device *dev, bool is_c=
ache);
=20
 static inline struct nullb_device *to_nullb_device(struct config_item *i=
tem)
@@ -560,6 +561,9 @@ config_item *nullb_group_make_item(struct config_grou=
p *group, const char *name)
 {
 	struct nullb_device *dev;
=20
+	if (null_find_dev_by_name(name))
+		return ERR_PTR(-EEXIST);
+
 	dev =3D null_alloc_dev();
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
@@ -2061,7 +2065,13 @@ static int null_add_dev(struct nullb_device *dev)
=20
 	null_config_discard(nullb);
=20
-	sprintf(nullb->disk_name, "nullb%d", nullb->index);
+	if (config_item_name(&dev->item)) {
+		/* Use configfs dir name as the device name */
+		snprintf(nullb->disk_name, sizeof(nullb->disk_name),
+			 "%s", config_item_name(&dev->item));
+	} else {
+		sprintf(nullb->disk_name, "nullb%d", nullb->index);
+	}
=20
 	rv =3D null_gendisk_register(nullb);
 	if (rv)
@@ -2090,6 +2100,22 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }
=20
+static struct nullb *null_find_dev_by_name(const char *name)
+{
+	struct nullb *nullb =3D NULL, *nb;
+
+	mutex_lock(&lock);
+	list_for_each_entry(nb, &nullb_list, list) {
+		if (strcmp(nb->disk_name, name) =3D=3D 0) {
+			nullb =3D nb;
+			break;
+		}
+	}
+	mutex_unlock(&lock);
+
+	return nullb;
+}
+
 static int null_create_dev(void)
 {
 	struct nullb_device *dev;
--=20
2.35.1

