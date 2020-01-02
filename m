Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D3C3276C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D20721835
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgABPEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:04:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgABPEh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 10:04:37 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MA7b8-1it7cR1DjO-00BZs1; Thu, 02 Jan 2020 16:04:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Hans Holmberg <hans.holmberg@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/22] compat_ioctl: block: simplify compat_blkpg_ioctl()
Date:   Thu,  2 Jan 2020 15:55:38 +0100
Message-Id: <20200102145552.1853992-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l3+5zbd4lrbw4tzQblHwKZzHCHX3uYKJ+57JHSO7m7iTNY7IOEM
 Yy069NpLdeHeOMEiF3xar5cgusQ397iBTWnVGx6VGMtXKZUZ4bo9wW43SIyXi61v3w3PZpj
 nVHeTCHtXQ1vhS5hTzRWLv/Ok4iUqwKr+anhilMAKd3/yHip4vPJsX/NVOK7G4U/bBEPEPe
 N8OwSazo3DlmxRxuVVLgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vZkgOPk0SmE=:UUaFhhZiT8Vbhirn0LsbAo
 DHnOaaqxmEnaJOqdy7gDh4Yh7W3WBSbzPp0eNZo28MBdVQiuO1hRkvAtozlI9Ehn32VcQCsqB
 gVQv05f++A/BIo7ffzCqCriJo4h0CvohJCf8B0asn71wSVmg1ydyYcAb8J5xVU8JkkL7P5R6M
 9rW++tUp7NBf/kIGiOMwDXxXJCztzngQ1LC3CTvnzi80QFl7eyYIHbhB/qZHRVtYx/59WjWWg
 zBXV5BDg+HpyrNovRvSYQbLZn9i5ztNfp8gTkjfA5t2x/20Uoa58WIEvbaZ8N7jNMHSPmnJHh
 2QaoadHCHAxvPav3Y9LZh5jkhhymPSbog0KTnN2zX5RnLapEb3ejYEjdoMtw8B5d9MPhDx+l0
 A59yUlKApXvZNZpQcObhknCw2V2lVFYsbr8ECw88zRTkCl0FSSYno0gdhS84OuaIRqA0rQitR
 /BPSzagNKB7phFkPPG7Ctd9KINoKaOyvgIQWSElKQoqgbND73EmsbJBaY9TWEWmf6yH2+XlrE
 N19Hz65Ryo+Ek7HOTInYkUS6OmxvcLq0y8ylQzX8fjQ8TEIKZ0yAC3T+EC1NfV9SbJPYylG2N
 daLJCd3K3ST9IM73tYcBQM3NVKDIMePGZQ/a/8OpoN9YnsT6bpzS89pFGYeuKG/unMa8iZWuo
 GOMrn+Xkns9h0LdL4KSnnwzQsQiHIveijqkp+SsGUpvxaeWAo/0phbGlIfFRX188sfBVkDBXn
 qzNiBobFvz9pf8A/4teSnsmxUvfJgUVVSjtaAXiB8NQq8tcJG4DJTGcw821tBw5vpHX9yhGCu
 ilx5PikHGgtqbpvtALY8exNNtanX3OEUHv6FQoNqlikcRJODn2PEg6zVyox9GrjZ53uSQ+9v3
 C0JPfJxloAvsnWjrCLXA==
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

