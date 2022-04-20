Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbiDTBAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348110AbiDTBAJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:00:09 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB713E0C
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650416245; x=1681952245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gG8cNEjHHGS7EhNii3fkPIs1UZgkdOiV/85oPTNQSnA=;
  b=LfEL0bnJQil7kl9QbH47mxQCx/VBEqtM7lWb82Rfy02TudZuFcTLI1eM
   aail+NXik2Tc7a1ZQPuL2Xv6XA9Bi5kkmwGdSMqOII+p0NGliTNc3lDjS
   3jUcrtKY3QKHqKkwtBKnv6jHulABYPFTselvFYDD1nasAAm1cMPcc6Jb1
   Kgx9cFXRj0X0+H11m6dxtfLdM/8/7FveYrvs8421Ii1q1+qqyNbQ0lPF2
   bP/zrG35aCQ79JrtBdv7QacnjTd7l42US6Txgi5jB04VfmRD7xsk7BZGH
   5j0OoVYDEsqscj/OMgeEFeBz9MZCyLU5KQL5GmdaKjnPhcNzLv1ck4IwL
   A==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="310283703"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:57:24 +0800
IronPort-SDR: +2sXqO0oZQU2vN4+ayAB7qY0CR31mXnD0zODWkauMHiDJUWvPUQbzSSohcNAU2K1hkQKQlaJeo
 tCudKapyOnIr0EOpFV2Uvm2WOi1z3VPnrY6w8pKB0RqWMLRZKf0Rh3StXuBe2vBDcq9YUYwV2u
 mLAD0dmc3A8c7q1iaW0Cm9MAjwEezLfLiTmr8cg9nAdjPoiKpq1A+RiDW6lVc3ZWl0sbT91srd
 auYQB8qnf/857Kms0eohb2Ml45L1Zp/QzOz2IbFsXEJJf05+pY3DSCbFKS0/DLFQGny36xQX+U
 CNipSfZ74aIM8yTZ5r0yYZUq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:28:29 -0700
IronPort-SDR: tpa8/rRTrb9o00A5aci2bTyRYS+UYqU6BhuS62uonk5tfqUQ0AfS+gufi0LFo/IIbYDuf4mx/G
 EB4YOw4ed+ke/RMG+vDPyxyfVw7X51AwSdpDjHanIk9lJVLCRGIpeuDdFO9WxpktH9anV7sjdD
 IjAAny+dkz+Fsb6dIHS0tIn9n3MLBZzieALk9S7gq+w6ihQmrySYVgIEKIsrHjIuhu3plkltYe
 TyfYcA0+A2u99AVzSDvPfk4fecxgHRVoNPssTCpVnKJlz47o4WCmHiJRBB1OHx8ucFHkX7+C+7
 h2M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:57:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjj1w5dYQz1SVnx
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650416244; x=1653008245; bh=gG8cNEjHHGS7EhNii3
        fkPIs1UZgkdOiV/85oPTNQSnA=; b=JuIMGY93wTZ8zxFDowLVJ3SWn1bak+T8Gn
        E94UBtQIQl+Pe4ZKzPdoHINqHAqPr/keTt0WPX+mquE8djnwt1sGsBF9uKhXox+m
        j/0n9Dnc8Qv7b0H4bzcurqdHSMl/l/yCDJz6gQ18xiUgQNWtqmi2p4yVcucRD8d7
        DTvr6dXj8MQpJf83C9LqZXxgCroexBvq7pF3PnJFNcb7+fpTTzGuA+r8yAP/K5Uc
        5MtPphr59rvwcTafc0ZVslw98ATo7UPG79x24nNBL3I/dDRssLqip8+5ajwY7I/o
        PQP2ge1AkLb2m3CsTtpyYrLrzQj4jQFZTNbe95k/oy1csVJIsKAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G8AVTSKSg_9S for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:57:24 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjj1v5LKMz1Rvlx;
        Tue, 19 Apr 2022 17:57:23 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 4/4] block: null_blk: Improve device creation with configfs
Date:   Wed, 20 Apr 2022 09:57:18 +0900
Message-Id: <20220420005718.3780004-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the directory name used to create a nullb device through
sysfs is not used as the device name, potentially causing headaches for
users if devices are already created through the modprobe operation
withe the nr_device module parameter not set to 0. E.g. a user can do
"mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device even
though /dev/nullb0 was already created by modprobe. In this case, the
configfs nullb device will be named nullb1, causing confusion for the
user.

Simplify this by using the configfs directory name as the nullb device
name, always, unless another nullb device is already using the same
name. E.g. if modprobe created nullb0, then:

$ mkdir /sys/kernel/config/nullb/nullb0
mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
exists

will be reported to the user.

To implement this, the function null_find_dev_by_name() is added to
check for the existence of a nullb device with the name used for a new
configfs device directory. nullb_group_make_item() uses this new
function to check if the directory name can be used as the disk name.
Finally, null_add_dev() is modified to use the device config item name
as the disk name for a new nullb device created using configfs.
The naming of devices created though modprobe remains unchanged.

Of note is that it is possible for a user to create through configfs a
nullb device with the same name as an existing device. E.g.

$ mkdir /sys/kernel/config/nullb/null

will successfully create the nullb device named "null" but this block
device will however not appear under /dev/ since /dev/null already
exists.

Suggested-by: Joseph Bacik <josef@toxicpanda.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 7bc36d5114a9..9ee72f484fc6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -235,6 +235,7 @@ static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
 static int null_add_dev(struct nullb_device *dev);
+static struct nullb *null_find_dev_by_name(const char *name);
 static void null_free_device_storage(struct nullb_device *dev, bool is_c=
ache);
=20
 static inline struct nullb_device *to_nullb_device(struct config_item *i=
tem)
@@ -563,6 +564,9 @@ config_item *nullb_group_make_item(struct config_grou=
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
@@ -2064,7 +2068,13 @@ static int null_add_dev(struct nullb_device *dev)
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
@@ -2093,6 +2103,22 @@ static int null_add_dev(struct nullb_device *dev)
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

