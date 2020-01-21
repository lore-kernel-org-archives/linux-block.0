Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40C5C33CAA
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 04:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813F724125
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 04:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgAUEEx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jan 2020 23:04:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUEEx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 23:04:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F144E91CBE44BAC7734;
        Tue, 21 Jan 2020 12:04:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 12:04:43 +0800
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        <wubo40@huawei.comwubo>, Louhongxiang <louhongxiang@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH V4] brd: check and limit max_part par
Message-ID: <76ad8074-c2ba-4bb3-3e8b-3a4925999964@huawei.com>
Date:   Tue, 21 Jan 2020 12:04:41 +0800
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

Here, we add brd_check_and_reset_par func to check and limit max_part par.

--
V3->V4:(suggested by Ming Lei)
 - remove useless change
 - add one limit of max_part

V2->V3: (suggested by Ming Lei)
 - clear .minors when running out of consecutive minor space in brd_alloc
 - remove limit of rd_nr

V1->V2: add more checks in brd_check_par_valid as suggested by Ming Lei.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/block/brd.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index df8103dd40ac..4684f95e3369 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -389,11 +389,12 @@ static struct brd_device *brd_alloc(int i)
 	 *  is harmless)
 	 */
 	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
-	disk = brd->brd_disk = alloc_disk(max_part);
+	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
+			0 : max_part);
 	if (!disk)
 		goto out_free_queue;
 	disk->major		= RAMDISK_MAJOR;
-	disk->first_minor	= i * max_part;
+	disk->first_minor	= i * disk->minors;
 	disk->fops		= &brd_fops;
 	disk->private_data	= brd;
 	disk->queue		= brd->brd_queue;
@@ -468,6 +469,25 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
 	return kobj;
 }

+static inline void brd_check_and_reset_par(void)
+{
+	if (unlikely(!max_part))
+		max_part = 1;
+
+	if (max_part > DISK_MAX_PARTS) {
+		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
+			DISK_MAX_PARTS, DISK_MAX_PARTS);
+		max_part = DISK_MAX_PARTS;
+	}
+
+	/*
+	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
+	 * otherwise, it is possiable to get same dev_t when adding partitions.
+	 */
+	if ((1U << MINORBITS) % max_part != 0)
+		max_part = 1UL << fls(max_part);
+}
+
 static int __init brd_init(void)
 {
 	struct brd_device *brd, *next;
@@ -491,8 +511,7 @@ static int __init brd_init(void)
 	if (register_blkdev(RAMDISK_MAJOR, "ramdisk"))
 		return -EIO;

-	if (unlikely(!max_part))
-		max_part = 1;
+	brd_check_and_reset_par();

 	for (i = 0; i < rd_nr; i++) {
 		brd = brd_alloc(i);
-- 
2.19.1

