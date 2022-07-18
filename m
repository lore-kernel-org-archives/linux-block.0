Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 11:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiGRLO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiGRLOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 07:14:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413F100F;
        Mon, 18 Jul 2022 04:14:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB4KK1018771;
        Mon, 18 Jul 2022 11:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=M7fAHJoROFocPGuf4DzIUHyj2Ge6OLDGBxCMt3dHYHc=;
 b=Nce90reZrOtHUTdS2w4mQWLTAtmnTkrBz+UqrrNMCaOURk1ogPsESHTn+LCXs9SQ3bdG
 aDwUDWpQQqv57l46+JZngigOa2SQbw/4f+bPLF8MH6ki7WEJ9fM+83Lf2xiVwdGO0Xsl
 tWqPdXdrx3hAFh/gF9hXdfioVIpm4BwupT2ZF3JZ487waZje0D9fBGP087vWsc8tuaQV
 xGeL5rYRiwclCha9DueGe2CmuyKhMvvzHS1z1sWhTHrWhbYDmzFzqD5mKs68h/ybHhgq
 IXg2Zr1ey1F8bB9BtE/myvC4RARd5M65602LZhoAeKkrqR00K1uONEudPsTRz2C74T34 Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a2x8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26I7pumG028008;
        Mon, 18 Jul 2022 11:14:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma5pqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 11:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NueZjKQFVJPKhp56bPuULj1pAnzyNTiRpf3/HEuxlPOAzIaEjNl9z4/D1/LyILe9X8lWF93rUVOfgtYpTlNEwp98jewLR9cV1MfHaNNnFY5iC5bldQzOauDRRxYhpuW6RG6YCmAROx1E72nxb+R7nfUW6XTr7u/KfoIfHS6YqPr9kS8eADO+mDLe3fAb4EFAifAwfFFJvccaciYuZ3Wz1M3HQ7mVJCXxR+1DJC3EldvLQLt+n9ThQH4+S5MFoy7vtqHX5qgIq4a15v+bS/mo1vnMM24KIkZajvPIlOsL7qJQg+xHSc5Jsni8IZw5rl+eEKPgTRkW1BJ/yjpO62LHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7fAHJoROFocPGuf4DzIUHyj2Ge6OLDGBxCMt3dHYHc=;
 b=Yj5vZHq8vx1duhpUCZAfNUW19knj5RnAQodMXpRMYpD3n6E45bGS+6dDuSx5YMcnNsjEkXI+Mooue/CzHAsodaf8iY0Q3TCzknawd8HhcYOv96Ea6Bfzr3EHEa4a8SDcDHfspLBwOGSaMBbzlfcvrkSPB/vmeeTd29f/k6cs1YrqRLtlObXlf0kefXhYLPtUaxttuSxHWjkK8+YclndSwD90Kkbq3AfZ5uKSTKD878I6DVq2HVcBbpyj2ciZxnn8xLxW/ReS/XHk7eABIFnAoI2G2uMEZgRdGcKjOlZa+wd37jGIrZ1L2Cm242y3IWFohsRcBmtMVXytoUJiaCcKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7fAHJoROFocPGuf4DzIUHyj2Ge6OLDGBxCMt3dHYHc=;
 b=xwXnTfxmSwrhGTV2cFlNb08xEc2XJLkyt6wuppQ9TukApgUoaWENq0scqXiuUQUuKwsZlE6UaACLJWXMUnWhuvV3q0mnbWr3l6noO0LNYwW1g34PhfUwMlHRUm8uEt1aSdDlJ+6/ffqMUZdxOYgH9ZlbPtvpteyRRGYP3rMiVNI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4757.namprd10.prod.outlook.com
 (2603:10b6:510:3f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 11:14:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 11:14:19 +0000
Date:   Mon, 18 Jul 2022 14:14:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] ublk_drv: fix an IS_ERR() vs NULL check
Message-ID: <YtVAgedTsQVK1oTM@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee45123f-f81a-46da-30e8-08da68aea884
X-MS-TrafficTypeDiagnostic: PH0PR10MB4757:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdaHa3FisMneDYTF9k54gEcYNaRsKabrwKnoQhzOP0QzLfcWsHuulgFLslaYeY7AhjYWr/o3nMihckmo9SKBneReg3AoiW5s+zC7cPKD36ffyGB3bS1IaNoia+rXlG9q4ZUh0lBHukwOEkkODjtcrr5+o1jtEiLF6XEr5eX1U6VSQ3dP5xchM3pV3eto08Y/jvsMV0QOkyrAkhQmb3yAKN6hZbrwrDJYhZdrelPIH1Rhg3sdhAm+FKp8WwreU25Bmo5tiVY8roBZ1++bPJe+2tD14e72Kvbrjwpig+JM6JlYE/KrgpIkD8lcLYDCo4dR8gyQZIFoOX8mUAdt5nuXnWizeu3d2OE8r+Lx6iomDQaAQ9Ypwt0OEDo3my4COi7t2ijlFePcDm1uul+Yi/prkgo5VJ8xQZW/3qY7xXvAuQOQMLI1NNkUngd3dOa3FP4IhaWQ7Gu3UOsHwlzlef4anmqxmuS/EWxzrftox1hTKwKCmoU9omdqHDDlm2ykLNRNVngLvgYx4pw28G9VSyuwT6qSqIWP1wBt27nXL4Q4d2y6u85LZp6h/z/NAEOQmYKZ8tXQBHddWDlkCZSOVOtxLUrr+RQGhnwMFYL8qZLw/jSY9DZNvNC4zO912AtEbRV2wFY6t8hQf+Y9sFiLuLLykP6pHSf8Cm0tPBcwqBqUX30gS8DG+G8Dqv0dT4JjNfrs+YMVE0wXFfwDbKeio/G8xjGnvn8PDHi4v+vB7iaaQaR4Z6kR6nXOAlHXwrRbNXqin0i2AQiqx7tjyWDMv4PO6/4JaDtLJ+6XEIir95oQ8/Zzln7pWjOorsOmr9t5uS88
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(186003)(6512007)(9686003)(33716001)(52116002)(41300700001)(26005)(83380400001)(38100700002)(6666004)(2906002)(6506007)(86362001)(110136005)(5660300002)(8936002)(478600001)(8676002)(38350700002)(66556008)(66946007)(66476007)(4744005)(4326008)(44832011)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvglOwljHia7m79v1h4O4GVnXjth6w8BJxh3l9dtWjL+jm1SCSZWYLuPtZe6?=
 =?us-ascii?Q?2OdbvzI7VkXqGNnVehySSeF5KV9WJB76toD9rZHCkNUSrx6joINHPu58zqs9?=
 =?us-ascii?Q?Z4kMo56szLO2KEKYmJeHmV4tYby+mf0665c0cvLkFT/dZY0cK8LcQrgj2u5v?=
 =?us-ascii?Q?sKi72LxKCySk8ZO8iXTr5C9GpE9LyXuTk0KbMLw9Mas497FDOfIqyFRCIL/G?=
 =?us-ascii?Q?CZPGYI5ZT8bGOxwq6olR5lIx1DRB8XIPgu+HYlO4wTUn+bJhqAaH3TB67adX?=
 =?us-ascii?Q?MAs6xrgZja/13d8sikfwdKBf4ZuTOva9N9rc/OshBo/q/sKRXHCgdXE8iIuS?=
 =?us-ascii?Q?hwkJtGw17hXaxgRWG43oJ12QvPz3G7rhp0Fiji9UrgGSpTTtwADVNYiaciOq?=
 =?us-ascii?Q?qNxxzWjvC+uMwINPTDsp/N58DgcS4V+cdRPXh8+gZ6NQOt5Zrv0SLcYlNolX?=
 =?us-ascii?Q?SJ5ivc1iHAY5ZqVTSd2C5ZI4y3YnRiDA+WCqK51EYOcqhS7U6Hfs5XO3LX0M?=
 =?us-ascii?Q?JJnOi6ydXN3JC67U8gp6zMvtmQr/1nPjKhbE2aFCz5drTnE+LHow496Jx7Hs?=
 =?us-ascii?Q?9msXG+1j58PRlSd2RMHsk0bRMSFQ1izjQJmieMmpbUffYjmLTOx/AmIsDzlg?=
 =?us-ascii?Q?h0yumZ7QRsEz7V6uRy7sZZChbV+OBilbt4wQf3iGojOdVgHaMbuO9AasW7M+?=
 =?us-ascii?Q?X+gxKAoV65/mcHgS1Ifs5KV0KQtX/gl40tA4zY3GtRSRxIsotXoZi2SQhWG+?=
 =?us-ascii?Q?9bwbnXJn7DCdjt3JSmWcM/pUgaS2kYrx74UEu7buegjqdPZhaQjoDCziKV/b?=
 =?us-ascii?Q?x9fDleBDXIRvY7IuoFiJubMQM9SYTXtZV8hdAOczVTU7IT1IsrY3eqJdFWNW?=
 =?us-ascii?Q?Jt8SLjaFt/XdWPXuzBdyU5TAcs0myrcwrYpz0cC+/AWqOv4WXLKHfXYEbx78?=
 =?us-ascii?Q?x3O6gwcTj2A25aspAnf9ab/bGBxCk9hJnkWfeCIsJtyZ8H9k3k+LNprln2wI?=
 =?us-ascii?Q?NPpxhaOA55y2aww3qqYUuDsIWsdKe+mRmBttLFjGfsAXdR+9Li3XMoKz0UFl?=
 =?us-ascii?Q?UjxnsY+07BZS7PVGmcZcD8TLZqOBAsV5fud1puy/xudX/Ok+ZoDL0/D8Mioc?=
 =?us-ascii?Q?NgsrqRS7M8N5f8DqY7JHFQ1Y7iJMhZ8abPfzCYHAi8T42BIpz9Kfcu7cwzDK?=
 =?us-ascii?Q?mqB2kgvKRceFIFsitcrf16KWmkqv8lcFfc4pBk7xlGWvvgn328URWz853PD0?=
 =?us-ascii?Q?VoPSyh8PHoA6MvOfj6Ef+eCf7wisv7fYpEQYZelaisaSM85DSi2dYgQqdY7S?=
 =?us-ascii?Q?ux8cCyBhdXKD87yOPG7WkSMYoPlMg8/dg9To8ameuTb4e+853I7GY/NNUfko?=
 =?us-ascii?Q?TLaoI2E+522Ej/MmLyN8fAe3EyW/sK44So++pAHU07S7mxwFJA9HdrU5b/pu?=
 =?us-ascii?Q?Nlip+FBv9rbu96XnL5wEM4KLEKz2cA/RgJXMb1amiHaPtwq6rx91LbMjZNph?=
 =?us-ascii?Q?CQoVBD4X6s8Y80Ll0qCrcTj+jeceWvU/vQg3yq7N1JDpuBEqEyye4wuPHm+d?=
 =?us-ascii?Q?MZMMnDdq9F08MUrBKh5naM+OnGZ+dHu48Pk8DJ3JKrvHFk9UB1stILrkPFkx?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee45123f-f81a-46da-30e8-08da68aea884
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 11:14:18.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIm1WvIbV1CWQSW0RnkEy+KSGsiQPdl0yCj0woZDdUWd90N6NUeMuo/AFups9vhaSBM2ik2/I1xIXGaaGIw+iDi/uPg7EjlDyV1XtPDt6XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180049
X-Proofpoint-ORIG-GUID: hO85E_zWRunB4AnCsvNn9pqndzCC6NVG
X-Proofpoint-GUID: hO85E_zWRunB4AnCsvNn9pqndzCC6NVG
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk_mq_alloc_disk_for_queue() doesn't return error pointers, it
returns NULL on error.

Fixes: cebbe577cb17 ("ublk_drv: fix request queue leak")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 52fd0af8a4f2..97725d13e4bd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1175,8 +1175,8 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,
 						 &ublk_bio_compl_lkclass);
-	if (IS_ERR(disk)) {
-		err = PTR_ERR(disk);
+	if (!disk) {
+		err = -ENOMEM;
 		goto out_free_request_queue;
 	}
 
-- 
2.35.1

