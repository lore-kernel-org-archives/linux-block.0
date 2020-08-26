Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBFC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327122078D
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GXpcbbq3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QADrUwcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZPUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:20:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11306 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgHZPUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 11:20:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QF8Ymp005892;
        Wed, 26 Aug 2020 08:20:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=facebook;
 bh=Y40tzn/MzlJFl3UufAT/Jd8ik40Ux22ol5osxUPe54I=;
 b=GXpcbbq3DtGZiIUYYOvy06sFjwGjUWKEth6MkgAlqWAWwvagBgS0w3EoGKXK4ZHKYJaG
 BQdSdUtM6IgBXUbLWI0Y9lzv7UYj3VW1z+F0v/RF52rVU1303pUFJHFk65G9E7bJjMQo
 CIX96Q7DRIpCA7gu+s8VakeuNrmxIeJMTGo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33316fcvhm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Aug 2020 08:20:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 26 Aug 2020 08:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae47A2wdeu1osnL53kXBNHqRqThjCOoYUmI40FtIoARy6QLFRw7CIt1tUfEI4uPHopi2SX5IALMzmrybpOkCQe3IomuiWMRy2ptfnkeX2Q0IoPmC4WwmYgyqpbt9zRO2FQfxu0hH6osgEqEKiYXMxpilm1yYLwLw3PUKEcrX01OiAHcmgfDfe1Op+YhmiY/QnG5/Ou14DzeS/NOEmgH+0i0a2BFR6f3YR/h+l0cQOjtM/AxRdYZo4wxyWaqxBROBH3AY8K2rbI3pphgNdcfSpOmB8eOnkc97rMkm9q+5d+23YleBrXb45WSxC5rnu1nvy7onXtXeUo5S06Y7TRomfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y40tzn/MzlJFl3UufAT/Jd8ik40Ux22ol5osxUPe54I=;
 b=T4NyrNb6Q00Rm11SsL4XEJ2987GFlHYVYGbT8EkwwEjfYhzl4YginBwhNrnhwxOYDRKLQOX+vx6sAP6H5C50lg5W4FNoD6OVCjJQ0oRN3aS1ykD6IuOkfQ2fRKtq+l/KzOCZdahUgT1Ubn3Gk/py3T4/8h+32nttboL3WZNz2AJz3+873qO6Z0nX+Ct/GgHz2WX09yhuQHkmXs3CXuL0Bbt+BPJSWie/i6BQd/6lPHWmTInFNCaC2/6k9EaRFUvKuwSDFQlM6L5Z9uQu8akTGzaEygOvj/6YeyPOcXitf7KalpRXIn42j7x0ai7eqsHjHWodqmyaFoOQn9xdDoSQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y40tzn/MzlJFl3UufAT/Jd8ik40Ux22ol5osxUPe54I=;
 b=QADrUwcJg9UOMY4pande9ScCXcpRPb91F5Qq1OPCyYjgNG3mruncb/FldUfdJJXZd4JdZQXx8A5oMc77enqEbBnJ+9gcX8Jdp0JRjfs3mC3NDqEEeLO7EChPFeMoaHTmRJU1Ul+BQ/2I2vMP8VQqIbtYrIHzN5OsW4hxAbW5C+k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 15:20:15 +0000
Received: from BYAPR15MB2645.namprd15.prod.outlook.com
 ([fe80::65ce:fcd5:ac62:a6e4]) by BYAPR15MB2645.namprd15.prod.outlook.com
 ([fe80::65ce:fcd5:ac62:a6e4%5]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 15:20:15 +0000
Date:   Wed, 26 Aug 2020 11:20:11 -0400
From:   Kyle McMartin <jkkm@fb.com>
To:     <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] brd: expose number of allocated pages in debugfs
Message-ID: <20200826152011.GC385700@kestrel5.jkkm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To BYAPR15MB2645.namprd15.prod.outlook.com
 (2603:10b6:a03:156::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:208:23b::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 15:20:14 +0000
X-Originating-IP: [2620:10d:c091:480::1:40a4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5cbd6c3-ffc5-4cbc-a95e-08d849d388b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB226291C27E72C0C4D0B145B5B6540@BYAPR15MB2262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1NH2G8SQOx+wjzHDb56Y8SMvC9v+G92kdrHGJcRUDwelRlrTWbkhU++3YEJeGkZ+YsF12Oam9WMRDPWAFcN5IoZXaz1dU8obT57abSy5vLXMNmluYktdVZB2osgWnNDgPc+KawyN9pgkQPU2Ihzz1+1uYcG7liif26q/zhcBK4e+PMh97GZZQXXAmPVSJSUrHbL6d6bWzg3hm9thvsakWt90xSWbU36Eslq0k/XKsOsj+x4UMYBY0Z7MNp+JRxz6Jex4nF6O8DR6PjqrSgJKwgU2TATPZ+jsr+fTQylnoxQ/dxqOHHbIpi5fHfd6h+9qrO2ygjVJwt1jy0kyVUAcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2645.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(6666004)(8936002)(2906002)(450100002)(4326008)(9686003)(16576012)(316002)(186003)(86362001)(52116002)(956004)(8676002)(33656002)(6486002)(6916009)(478600001)(66946007)(83380400001)(66556008)(1076003)(5660300002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2PM6KFMkZQkMbI7qChrg2Dd/5j8Cpiw6XGufNbUJ5FITVh8zlphvUFJAUrKPrjVASG/9vbIY0kwI0X7tQE3l1PRQSvAJFjTO28LKoR3Zn/N4Z140+nedZb9nhU7pVH9FzHT7SLmVcIORo1UqfaE1pcmc+S+KkGv+Zix876F1jBLZNE1FLSqTlOmfhhZujoJ/3W8SLXj1echTZORyyaHnQJh1hm1IO9Xxz05UG7fkegHiaoQM426UZGLSAGonSmlUZLDO4q5kY3gBrYSGIJWpL4BhS8BFMCnEvjXh3w9sV/KsgB6u7M+OVY1aQj8y2NqvnZMjMVIhwxv8H92QUP+x7M0rwI3idFA2UwfFdM7Ib9nI3X48otJXndu2xUxdqzDcZfdv/zCohRois7w13+kHsIBz9erqHDerJrb9rBT4G2cz/hIv+kKNt4LM+ZEhbNSYt3KGP0t7LXyuqjmh270yBKAqJAVBxQimeCoxnhZIVv9Es0u9TGHWj05rmFZB8hxAf6XBd2MkBrtssdZJSNao4N1Msj2KUC7YU/QaRJompvOykw+14YZMxeeHhaHpc+XhnQsWpVyLIYd99UIFcizuPmBnfxRSc8a+y4c1WOm6uhkX8cCPe5LvoS0XD8N/q5fnpB34fEA7zCxmulUgrC163RKs2KVfAQg567vKdAWJ78WOJdQMhI4BVb49V/Ao7FvF
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cbd6c3-ffc5-4cbc-a95e-08d849d388b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2645.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 15:20:15.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq+qXL48cAM4ri+aJNe7hz6JJFU/yJM5GMm7VGz8t2sLbusc7rzVTEQcfuMWI6o9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_09:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=10
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260115
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Calvin Owens <calvinowens@fb.com>

While the maximum size of each ramdisk is defined either
as a module parameter, or compile time default, it's impossible
to know how many pages have currently been allocated by each
ram%d device, since they're allocated when used and never freed.

This patch creates a new directory at this location:

	/sys/kernel/debug/ramdisk_pages/

...which will contain a file named "ram%d" for each instantiated
ramdisk on the system. The file is read-only, and read() will
output the number of pages currently held by that ramdisk.

Signed-off-by: Calvin Owens <calvinowens@fb.com>
[cleaned up the !CONFIG_DEBUG_FS case and API changes for HEAD]
Signed-off-by: Kyle McMartin <jkkm@fb.com>
---
 drivers/block/brd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2723a70eb855..39b9d6aee5b8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
+#include <linux/debugfs.h>
 
 #include <linux/uaccess.h>
 
@@ -48,6 +49,7 @@ struct brd_device {
 	 */
 	spinlock_t		brd_lock;
 	struct radix_tree_root	brd_pages;
+	u64			brd_nr_pages;
 };
 
 /*
@@ -116,6 +118,8 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 		page = radix_tree_lookup(&brd->brd_pages, idx);
 		BUG_ON(!page);
 		BUG_ON(page->index != idx);
+	} else {
+		brd->brd_nr_pages++;
 	}
 	spin_unlock(&brd->brd_lock);
 
@@ -369,11 +373,13 @@ __setup("ramdisk_size=", ramdisk_size);
  */
 static LIST_HEAD(brd_devices);
 static DEFINE_MUTEX(brd_devices_mutex);
+static struct dentry *brd_debugfs_dir;
 
 static struct brd_device *brd_alloc(int i)
 {
 	struct brd_device *brd;
 	struct gendisk *disk;
+	char buf[DISK_NAME_LEN];
 
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
 	if (!brd)
@@ -386,6 +392,11 @@ static struct brd_device *brd_alloc(int i)
 	if (!brd->brd_queue)
 		goto out_free_dev;
 
+	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
+	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
+		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
+				   &brd->brd_nr_pages);
+
 	/* This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
 	 * (This is only a problem on very small devices <= 4M,
@@ -401,7 +412,7 @@ static struct brd_device *brd_alloc(int i)
 	disk->fops		= &brd_fops;
 	disk->private_data	= brd;
 	disk->flags		= GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "ram%d", i);
+	strlcpy(disk->disk_name, buf, DISK_NAME_LEN);
 	set_capacity(disk, rd_size * 2);
 	brd->brd_queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 
@@ -516,6 +527,8 @@ static int __init brd_init(void)
 
 	brd_check_and_reset_par();
 
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
+
 	for (i = 0; i < rd_nr; i++) {
 		brd = brd_alloc(i);
 		if (!brd)
@@ -541,6 +554,8 @@ static int __init brd_init(void)
 	return 0;
 
 out_free:
+	debugfs_remove_recursive(brd_debugfs_dir);
+
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
 		list_del(&brd->brd_list);
 		brd_free(brd);
@@ -555,6 +570,8 @@ static void __exit brd_exit(void)
 {
 	struct brd_device *brd, *next;
 
+	debugfs_remove_recursive(brd_debugfs_dir);
+
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
 
-- 
2.26.2

