Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A149C43461
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E87613CE
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbhDPVWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:22:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344180AbhDPVVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 17:21:46 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GLE32v023075
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 14:18:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=rVOjIab3/UmOkpea85Hbp6lL2pKC2eJzDok4el+NCvk=;
 b=fGHhAwBkAjvPON+1T8V2z03F0KZQAd7tUn+lMThzBcJZ6UAb3jz667jW2Bgwc5/GAK7M
 pxYZBNkmxspNk6D49MI5EcOrGr/XM+nsriowgeaW5GEZQ5morkAoXdYhBzYV3bwrYNCm
 ig/wuAkZNuP5jB+0Sre3mDec0h+nfJXRnSw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37yjahr0t0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 14:18:41 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 14:18:39 -0700
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id 8BEDA5921F57;
        Fri, 16 Apr 2021 14:18:38 -0700 (PDT)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 13GLIbun4003249;
        Fri, 16 Apr 2021 14:18:37 -0700
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jkkm@fb.com>, <tj@kernel.org>, <kernel-team@fb.com>,
        Saravanan D <saravanand@fb.com>,
        Calvin Owens <calvinowens@fb.com>
Subject: [PATCH] brd: expose number of allocated pages in debugfs
Date:   Fri, 16 Apr 2021 14:18:29 -0700
Message-ID: <20210416211829.4002947-1-saravanand@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: rnpLsAeG5A2uSd55n2HCPF2rLT9U2BLO
X-Proofpoint-ORIG-GUID: rnpLsAeG5A2uSd55n2HCPF2rLT9U2BLO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Calvin Owens <calvinowens@fb.com>

While the maximum size of each ramdisk is defined either
as a module parameter, or compile time default, it's impossible
to know how many pages have currently been allocated by each
ram%d device, since they're allocated when used and never freed.

This patch creates a new directory at this location:

=C2=BB       /sys/kernel/debug/ramdisk_pages/

...which will contain a file named "ram%d" for each instantiated
ramdisk on the system. The file is read-only, and read() will
output the number of pages currently held by that ramdisk.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
[cleaned up the !CONFIG_DEBUG_FS case and API changes for HEAD]
Signed-off-by: Kyle McMartin <jkkm@fb.com>
[rebased]
Signed-off-by: Saravanan D <saravanand@fb.com>
---
 drivers/block/brd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 18bf99906662..6e622c1327ee 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
+#include <linux/debugfs.h>
=20
 #include <linux/uaccess.h>
=20
@@ -48,6 +49,7 @@ struct brd_device {
 	 */
 	spinlock_t		brd_lock;
 	struct radix_tree_root	brd_pages;
+	u64			brd_nr_pages;
 };
=20
 /*
@@ -116,6 +118,8 @@ static struct page *brd_insert_page(struct brd_device=
 *brd, sector_t sector)
 		page =3D radix_tree_lookup(&brd->brd_pages, idx);
 		BUG_ON(!page);
 		BUG_ON(page->index !=3D idx);
+	} else {
+		brd->brd_nr_pages++;
 	}
 	spin_unlock(&brd->brd_lock);
=20
@@ -365,11 +369,13 @@ __setup("ramdisk_size=3D", ramdisk_size);
  */
 static LIST_HEAD(brd_devices);
 static DEFINE_MUTEX(brd_devices_mutex);
+static struct dentry *brd_debugfs_dir;
=20
 static struct brd_device *brd_alloc(int i)
 {
 	struct brd_device *brd;
 	struct gendisk *disk;
+	char buf[DISK_NAME_LEN];
=20
 	brd =3D kzalloc(sizeof(*brd), GFP_KERNEL);
 	if (!brd)
@@ -382,6 +388,11 @@ static struct brd_device *brd_alloc(int i)
 	if (!brd->brd_queue)
 		goto out_free_dev;
=20
+	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
+	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
+		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
+				&brd->brd_nr_pages);
+
 	/* This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
 	 * (This is only a problem on very small devices <=3D 4M,
@@ -397,7 +408,7 @@ static struct brd_device *brd_alloc(int i)
 	disk->fops		=3D &brd_fops;
 	disk->private_data	=3D brd;
 	disk->flags		=3D GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "ram%d", i);
+	strlcpy(disk->disk_name, buf, DISK_NAME_LEN);
 	set_capacity(disk, rd_size * 2);
=20
 	/* Tell the block layer that this is not a rotational device */
@@ -495,6 +506,8 @@ static int __init brd_init(void)
=20
 	brd_check_and_reset_par();
=20
+	brd_debugfs_dir =3D debugfs_create_dir("ramdisk_pages", NULL);
+
 	mutex_lock(&brd_devices_mutex);
 	for (i =3D 0; i < rd_nr; i++) {
 		brd =3D brd_alloc(i);
@@ -519,6 +532,8 @@ static int __init brd_init(void)
 	return 0;
=20
 out_free:
+	debugfs_remove_recursive(brd_debugfs_dir);
+
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
 		list_del(&brd->brd_list);
 		brd_free(brd);
@@ -534,6 +549,8 @@ static void __exit brd_exit(void)
 {
 	struct brd_device *brd, *next;
=20
+	debugfs_remove_recursive(brd_debugfs_dir);
+
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
=20
--=20
2.30.2

