Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55523C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BBE2073D
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLKUwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:52:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34987 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:52:46 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkpnF-1i0tY73E6R-00mONm; Wed, 11 Dec 2019 21:52:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Keith Busch <kbusch@kernel.org>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-block@vger.kernel.org
Subject: [PATCH 22/24] compat_ioctl: block: simplify compat_blkpg_ioctl()
Date:   Wed, 11 Dec 2019 21:42:56 +0100
Message-Id: <20191211204306.1207817-23-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BbWzZIYxlkvkGnmBtN0ziB6S5/uESa+bJrxblk1rX616Ql4YYLK
 5MK3lyq7Jym7f9Cmi7sW5LYeFVgNlPHDELBXZQAruWnP+9jCcHBQx8Geltv9K6mixksBnrY
 xrZbEeXFSAL7VL3NkEJysUQo07KPAfKwOWVS3xoELkgAHEUQux6H06XX9GL6AS6s0rCdRmT
 yzOSN0G7rYmA+yuznFnDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjE7ay0x2Rc=:pmtBqh/ZmwAP8NTZfyRKoI
 uYwmPxZfNw2/ejLudLUcqZR6VtOSAJF38BBr8LwhIBuycO95G17wr3h7ekst//npcdCcz7y8X
 xId0UVOKQNTkWrszDX7WSY2yrboWo+c8gLocLEbHOmcp1n4q8zHlMVmrEIFKiWyFYlEwBrRg6
 bv8xTGdnW9gsFpsoWEIJS3VK4t1iaruWHjPOK3PId5hxoMutlPzeD+8DvQC9XTUSM4fj2wAOA
 mo9KbIxSkKdj8x2bl9sOlkjDGvtmbQoHMR+To7Wmt9iniXZnSkQivpg1ZEohNKd/mWbZsqUyL
 ip7xe9Lj4MCim0+Uwt3gvJ/1YzSOGFmgz2ohzJ5mMO1k5wUXQ11oMb1HTwmjadR1bAJtg+OaU
 ky6DqnxOwwPDMDkYpnEyHklOyP1haKOT+wlj1Ls6BActccSq9LKyJgl/NHUddO6IAxS5OEdqJ
 o34sCDgieBh+dBIqYRt6thks/RiGnlobOPKjkmqnBIvWIIXRw1ZuM1yjlrNoyd1UyLidTtbzf
 nG3OxH0a1/V8SJfu73m5b9kmNtgMpYN0wfUa3bz6CqPTwrzUPzmA0XRvLGaSdkz16XgOGOTFX
 J+MIPFfqDU3dGnJCnSHrkgZmWcXLXd8rutpOIQ5/sJ8V2Sof7OS1PTh1Vziz4V7tfdu204pKL
 PkLfr3BbE0kiNJNxR79fGTJ55odCAi1x3oNU2nePjpamXpKdhRTyJAHRhakK+GjxxtYC7hgxp
 L8bwqgNd/etV0V3tEOQRMFVEkw+ZrCY4E7HUTMixWmK/6GUqIOYnn3/rf9TBeatrMhKISlsAi
 kh9KpfBHAOUabKAoNfsu2CCA22d7cADUOk38jI45tdc6Ui5g17mj1P271pp4jfHVcaoV+CUyT
 9CEtqy0P9F3mfCAIcNRg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to go through a compat_alloc_user_space()
copy any more, just wrap the function in a small helper that
works the same way for native and compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c | 74 ++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f8c4e2649335..d6911a1149f5 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -12,12 +12,12 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 
-static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
+static int blkpg_do_ioctl(struct block_device *bdev,
+			  struct blkpg_partition __user *upart, int op)
 {
 	struct block_device *bdevp;
 	struct gendisk *disk;
 	struct hd_struct *part, *lpart;
-	struct blkpg_ioctl_arg a;
 	struct blkpg_partition p;
 	struct disk_part_iter piter;
 	long long start, length;
@@ -25,9 +25,7 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (copy_from_user(&a, arg, sizeof(struct blkpg_ioctl_arg)))
-		return -EFAULT;
-	if (copy_from_user(&p, a.data, sizeof(struct blkpg_partition)))
+	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
 		return -EFAULT;
 	disk = bdev->bd_disk;
 	if (bdev != bdev->bd_contains)
@@ -35,7 +33,7 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	partno = p.pno;
 	if (partno <= 0)
 		return -EINVAL;
-	switch (a.op) {
+	switch (op) {
 		case BLKPG_ADD_PARTITION:
 			start = p.start >> 9;
 			length = p.length >> 9;
@@ -156,6 +154,39 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	}
 }
 
+static int blkpg_ioctl(struct block_device *bdev,
+		       struct blkpg_ioctl_arg __user *arg)
+{
+	struct blkpg_partition __user *udata;
+	int op;
+
+	if (get_user(op, &arg->op) || get_user(udata, &arg->data))
+		return -EFAULT;
+
+	return blkpg_do_ioctl(bdev, udata, op);
+}
+
+#ifdef CONFIG_COMPAT
+struct compat_blkpg_ioctl_arg {
+	compat_int_t op;
+	compat_int_t flags;
+	compat_int_t datalen;
+	compat_caddr_t data;
+};
+
+static int compat_blkpg_ioctl(struct block_device *bdev,
+			      struct compat_blkpg_ioctl_arg __user *arg)
+{
+	compat_caddr_t udata;
+	int op;
+
+	if (get_user(op, &arg->op) || get_user(udata, &arg->data))
+		return -EFAULT;
+
+	return blkpg_do_ioctl(bdev, compat_ptr(udata), op);
+}
+#endif
+
 static int blkdev_reread_part(struct block_device *bdev)
 {
 	int ret;
@@ -676,35 +707,6 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 EXPORT_SYMBOL_GPL(blkdev_ioctl);
 
 #ifdef CONFIG_COMPAT
-struct compat_blkpg_ioctl_arg {
-	compat_int_t op;
-	compat_int_t flags;
-	compat_int_t datalen;
-	compat_caddr_t data;
-};
-
-static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
-{
-	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
-	compat_caddr_t udata;
-	compat_int_t n;
-	int err;
-
-	err = get_user(n, &ua32->op);
-	err |= put_user(n, &a->op);
-	err |= get_user(n, &ua32->flags);
-	err |= put_user(n, &a->flags);
-	err |= get_user(n, &ua32->datalen);
-	err |= put_user(n, &a->datalen);
-	err |= get_user(udata, &ua32->data);
-	err |= put_user(compat_ptr(udata), &a->data);
-	if (err)
-		return err;
-
-	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
-}
-
 #define BLKBSZGET_32		_IOR(0x12, 112, int)
 #define BLKBSZSET_32		_IOW(0x12, 113, int)
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
@@ -767,7 +769,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return blkdev_ioctl(bdev, mode, BLKBSZSET,
 				(unsigned long)compat_ptr(arg));
 	case BLKPG:
-		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
+		return compat_blkpg_ioctl(bdev, compat_ptr(arg));
 	case BLKRAGET:
 	case BLKFRAGET:
 		if (!arg)
-- 
2.20.0

