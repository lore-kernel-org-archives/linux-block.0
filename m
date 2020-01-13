Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD4C33CAD
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D3E21739
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 13:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMNng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:43:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbgAMNng (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 08:43:36 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48A226060FD661410D1E;
        Mon, 13 Jan 2020 21:43:34 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 21:43:24 +0800
To:     <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH V2] brd: check parameter validation before register_blkdev
 func
Message-ID: <8b32ff09-74aa-3b92-38e4-aab12f47597b@huawei.com>
Date:   Mon, 13 Jan 2020 21:43:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In brd_init func, rd_nr num of brd_device are firstly allocated
and add in brd_devices, then brd_devices are traversed to add each
brd_device by calling add_disk func. When allocating brd_device,
the disk->first_minor is set to i * max_part, if rd_nr * max_part
is larger than MINORMASK, two different brd_device may have the same
devt, then only one of them can be successfully added.
when rmmod brd.ko, it will cause oops when calling brd_exit.

Follow those steps:
  # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
  # rmmod brd
then, the oops will appear.

Oops log:
[  726.613722] Call trace:
[  726.614175]  kernfs_find_ns+0x24/0x130
[  726.614852]  kernfs_find_and_get_ns+0x44/0x68
[  726.615749]  sysfs_remove_group+0x38/0xb0
[  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
[  726.617320]  blk_unregister_queue+0x98/0x100
[  726.618105]  del_gendisk+0x144/0x2b8
[  726.618759]  brd_exit+0x68/0x560 [brd]
[  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
[  726.620384]  el0_svc_common+0x78/0x130
[  726.621057]  el0_svc_handler+0x38/0x78
[  726.621738]  el0_svc+0x8/0xc
[  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)

Here, we add brd_check_par_valid func to check parameter
validation before register_blkdev func.

--
V1->V2: add more checks in brd_check_par_valid as suggested by Ming Lei.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/block/brd.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index df8103dd40ac..f211ee7d32b3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -330,16 +330,16 @@ static const struct block_device_operations brd_fops = {
 /*
  * And now the modules code and kernel interface.
  */
-static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
-module_param(rd_nr, int, 0444);
+static unsigned int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
+module_param(rd_nr, uint, 0444);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");

 unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
 module_param(rd_size, ulong, 0444);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");

-static int max_part = 1;
-module_param(max_part, int, 0444);
+static unsigned int max_part = 1;
+module_param(max_part, uint, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");

 MODULE_LICENSE("GPL");
@@ -468,10 +468,31 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
 	return kobj;
 }

+static inline int brd_check_par_valid(void)
+{
+	if (unlikely(!rd_nr))
+		rd_nr = 1;
+
+	if (unlikely(!max_part))
+		max_part = 1;
+
+	if (max_part > DISK_MAX_PARTS) {
+		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
+			DISK_MAX_PARTS, DISK_MAX_PARTS);
+		max_part = DISK_MAX_PARTS;
+	}
+
+	if (rd_nr > MINORMASK / max_part)
+		return -EINVAL;
+
+	return 0;
+
+}
+
 static int __init brd_init(void)
 {
 	struct brd_device *brd, *next;
-	int i;
+	int i, ret;

 	/*
 	 * brd module now has a feature to instantiate underlying device
@@ -488,11 +509,15 @@ static int __init brd_init(void)
 	 *	dynamically.
 	 */

+	ret = brd_check_par_valid();
+	if (ret) {
+		pr_err("brd: invalid parameter setting!!!\n");
+		return ret;
+	}
+
 	if (register_blkdev(RAMDISK_MAJOR, "ramdisk"))
 		return -EIO;

-	if (unlikely(!max_part))
-		max_part = 1;

 	for (i = 0; i < rd_nr; i++) {
 		brd = brd_alloc(i);
-- 
2.19.1


