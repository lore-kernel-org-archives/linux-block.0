Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2BC611F2
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKDLvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:51:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65424 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhKDLvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Nov 2021 07:51:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A49rxVo000770;
        Thu, 4 Nov 2021 11:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=aYh456xSFnHL5iEvCrBhqLQOvdA9AcDlrpkj3ZVc4IQ=;
 b=x2EgcbYsUyZY3kt9cCItRNz9ghLrj9bAVQKzk4VpPTjaQnwZIl8bt0lPnTQZkPZ1Gj9s
 QrF9K7ylwb6BHE12ySuJ+H39ijpOAn0+q3QMoP3r+IgifeqSDsIPpoS/ofXCHEBbv+ex
 zynYJbfw4YVChE5dpVrPJyFHvU5UnJ9JFJBYn2fj28PXUi6ET0W1wnTu6A0AlxBXOuxF
 rRJJuEEvfpgbzEgkaH2E88OcoyVgTeDvYR+E0a4HYEX1IAsUoudWkMA+bfYz+PLggjZW
 dmLqVE5+J4SgH0n1qPx1Zc4/l/rJZyXiTfiBswN/pPLCb4fjq65i14Uyxax6weET1NnK Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n8p7em6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:48:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4Bk1Zs049807;
        Thu, 4 Nov 2021 11:48:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3c0wv7pkt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6v7RBL4OZCoOVYmGv6IcAb8E+JxStC3WoHGXqNQMc8HArJAEGcw8tMR0NQvn6lMaxXQr9T2qwV8CjS4vSN10EDVZaPAfcIcGIsQY9be6DYNTRlDkhamoIp/WaWK5QGfret7h+KB3pLD0+3ljxJyU0s6meOk9IEvrJi2vvPERcihVFSxDlJmHfVg1RTnRQ+Gjh+ze+WzzhsXr0OZfB4YpI0F1lp6RjChr+9OHK8ebVFqg1JffinvpC+nHr2N5k3Ex8LXUnVJ+SL1hOB4SJB+mMmpkoecqHc+luPG4hcvfCofmv+VqdYxLBJwmIYDYw71kw/x/QO5tKIEwZI6t4nXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYh456xSFnHL5iEvCrBhqLQOvdA9AcDlrpkj3ZVc4IQ=;
 b=HTMvnI/SWHl79HrcXg7g/ReLFvw1bYqyEeOhh4n7pQ/M+7N69CMN0ixxP+K/35tUBIc/Z3Rw6g8jkJ7vDPST5hgPSUyTDiJtGtajdkOe1GWjhrMkVJ4lMf2UYKxw4OV9Rrnw7l5W4N1mU5nBoPyZnnN1AeW/qmGyIq96dgBh8x7ahhJv0IkExFLaonaTu9WhKzGQpUeBpldWj8dPKvSozko5zn3/9tTarV28y5K9m3VL4jvD314N9P9W+1SZV7Z5zoqaUJpxFVQT0vJLIQ59wXNNZIokErF85GEAx/KNfg4N9FXaUZPIJloXPGJrNLR29NHvCOGBzBImtToOhsu8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYh456xSFnHL5iEvCrBhqLQOvdA9AcDlrpkj3ZVc4IQ=;
 b=uSZ4jZRC9NlAcGNSqVVaK9AYLQN/9/0SjEB3aZtMBiZXvHDtzptnhSqlmXK7hmTTC2yNGKJqMCG+IVfCl4BA/ITnNQs7cDevfvFPeHzm/9p4oF7PT1NWiEhzcg9ehnwX/mh7x24On4UgxPVkK9txcB5SC/B1x3YBprL3mnEnjwM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 11:48:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 11:48:40 +0000
Date:   Thu, 4 Nov 2021 14:48:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ming.lei@redhat.com
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-block@vger.kernel.org
Subject: [bug report] zram: avoid race between zram_remove and disksize_store
Message-ID: <20211104114830.GA4962@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Thu, 4 Nov 2021 11:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a665f7-9010-486c-4fa1-08d99f890bb0
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-Microsoft-Antispam-PRVS: <CO6PR10MB541277D1A2E7DBCE6567AA908E8D9@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+lWuxfEWeutGEsG2Xhs/iLTPgpAo7N80y7dkqMmLOUCaQ1haqCjE19YNSOVvyhZF3UdVLUCoqV6ets8pa5BTRarkXHKVw1IKxFxkuVWUEgbL6wLK3BeqfYleHPsTBPgq7v3Bo+/9T3EcVWTVF2PDBT8OilMKHtLn6rzbGlEOY0GANf+hYbO5z44LzJM6B1RFDbroe12NIu7AYHskeaClEZky9UaO9sUB0FIOBmX6zRRVrZOAKM/HOVnHS9hZuq9tcul0+LrlumZqzt86Zx07X/JbF1D4gD2m9RZNs13k+Cs8+hqZcqyH5yNNXOaC1cN4ET2+shEuLYHM9Xr2Tr21hrK65xOWeaXBEIh/zM4JscYAlIGAZZZGFGE56dAE6IALFj1OkMgz4EU0KfPuCC2L80absNUOHJdh7Z+O6TiW4EGP7fFfoB1xGcrp0nqpVJOvVJS9sB3a4klnmCOpzS82wFF50FTXIj+9muBYjIt4FCPWkHuCbeMPJ7cjHJOiHczjulJG4xnsvi1lNFtlaKcdC4rzBPq+/hV3DgG4wGJrOeHwRW8TZ74IT6v6Vn8JVoZNZxCbgkUkr1NqAWYflutg/bJ56rgXZeJ8jtL7ZPm0LcUZT+AgXllK2cMegR3TbWbT7Vz+8pPVfvfxXP15RqFMIpcaBZhc+Zx39dn5FZdDWb8wLzYXTox6f/FuICHdnEerRU/jtAS3Y+1/irL8cIvCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(26005)(9686003)(956004)(55016002)(8936002)(186003)(38100700002)(44832011)(38350700002)(33656002)(316002)(52116002)(6496006)(508600001)(66946007)(33716001)(6916009)(83380400001)(6666004)(4326008)(66556008)(66476007)(1076003)(2906002)(5660300002)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjBJLQtRgCoKCFxGzdaSu+ZU2YBr6sLakrSmVlbQS3GHo2bFt6jxvSEW1R9A?=
 =?us-ascii?Q?co1257kAYymv0A6oimqFzNpYHRVMsn2DXgUOEE9eMmepFnMzUTHxVIi/ab7e?=
 =?us-ascii?Q?KcdkTNsurSTYnl+pJDuT7z1O2dhMsBlgyLRPRUhURpr3EI2WLE5L8vJdXO1H?=
 =?us-ascii?Q?rZm/xZyaSkvV088kR4JEHda9mmRsYKNXyQLomV55QmgxQPTbCyUigsdBY3CO?=
 =?us-ascii?Q?uKQ8krSRbd9d0wufL7ozGgtVdRC8JGwKTb6QN1VhvhlxtRZu1xH7yulPYs0M?=
 =?us-ascii?Q?UKvXTRMyshWemPpuD2i2/wXZxNi/UIlRMWcOOb2G17vri1c6HFJsqW4ZR83D?=
 =?us-ascii?Q?U0lJIjbHedRYGEZ2OYF3nRpIKWak1Bn8vszBftW5j5Aju1lOBtgk4P2KhzlM?=
 =?us-ascii?Q?pRdoRFbauubkpGFIntuVrRwrhuiyAfW+2IORj6FjDEAYdDzSlZ26XhjdFuo6?=
 =?us-ascii?Q?Qsm66RwDXvv5+arjq++wSlA3FsSOp0gVEd3ve7Gf3z2MrMDEioy3Lqbyk8mv?=
 =?us-ascii?Q?WcNm4nnh/ERU0fn4MobDAD1WpD+IO01H1qTo1BrCyBaW5OESMprbu9D/VqlS?=
 =?us-ascii?Q?EFEUAOA/ENltF/Wq4ypkS09RYYvP5ObY91Pnio03+tNGLmcfeAZaN4SO8pev?=
 =?us-ascii?Q?g8qsDk6W4WufrfR5Z71MniWoG9sKCtvX/s79vczk9ZYLoleskBs5YWjyrHI3?=
 =?us-ascii?Q?mFAcq4APc+4zqQgrOzU6odmIC1yJYbOe9hZ/clwDf6QYn3dl8H4QpPR4HhU1?=
 =?us-ascii?Q?inVuNqHxTph0X0g4y56SPufomHcNsDs9mh20S2+Bvf6RP/HS7+QZEoahPU2U?=
 =?us-ascii?Q?Kj6Sy0yxWCUiqNlcO/H4g2fI51hRGYRNV0SJnEKyacvMSd4UzvYRPVoSOlON?=
 =?us-ascii?Q?p4YNCnZ+2EO9RCTyU1bWnWSQg5ur58+ygihUwCgWrsnGFEHDgHY3WrDaaxGF?=
 =?us-ascii?Q?kXvFJNU/OioZnygZ2LLUhpCet6fdNJ+xnJgbFz+PE4rGSOJbJN7fsSMgxb/T?=
 =?us-ascii?Q?JOCFCjIGZanGenjwN9fHxDCrbQYnsTub+y6vshpY6GCS833nBkpYTlXKG+01?=
 =?us-ascii?Q?d4J4krgJYbGGM0cL551HUlEQcFvW7Hq0fQv0i8qdi3YxH/xLyEelLmFjOVhV?=
 =?us-ascii?Q?eV3VvnxyTBdk4gr9ckimsWKR2eFdbffe0JnMdowWngGO8bOT/XaHUsSG9FpB?=
 =?us-ascii?Q?yFn+7jmjDk6jGS0+kEeGV4bZ2+oQJ/Syhwx52tDdFSASqhzt2MopcFhL7PSR?=
 =?us-ascii?Q?u/VeS9UFGWXiRbSfmOalePnil7B/2c8oJougTy4OY5/VfFuQqkyI3r2LRejp?=
 =?us-ascii?Q?I5UhwTS5K28ZsGRL3WtbYhTPDeY8ceL4avRSE+RV3CFmp0dwl4lGDBQkJcBx?=
 =?us-ascii?Q?7xy+oTEe4BWkprHIANxkjXWF79dVSoAljJ4CoFTjd/6DeRTcPDJNm69gVFNj?=
 =?us-ascii?Q?0zsqhQZQRxgVoLUcomALzO9J+sNqi9SA3wCd6kJnsDTgGN6/EKwy7WyyZFP8?=
 =?us-ascii?Q?ZHObGtO81GxuD72dt5LH0aRCo2AsHZgaTeMqTioQoGSWfmz5bgrnH+Vk9wUS?=
 =?us-ascii?Q?0ZJnomyXAmIs41ZkcuE4tJbmEKD5QftP00u+FjDMATRtFtPPnW/9DsRoV3lM?=
 =?us-ascii?Q?MJv1a3cIIFRG5r/RVymIQVYTvnKhbkAjY9nvIBH1ZVwFlF+9EDw6fd0vY9xS?=
 =?us-ascii?Q?Ofn6neZ8O++xbGwXUvaxTMlLxy4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a665f7-9010-486c-4fa1-08d99f890bb0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 11:48:40.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a4tijYnwcToeylwmhqYRKUxH3rbgJMDT899TxmF5WbWCx71p7N2XXsI2M0ftelGauWkS4MrEKq+i4bOKByJIaLLItKEF/hmXTC7M7Wvcyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=736 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040049
X-Proofpoint-ORIG-GUID: MOM-z8lrfEy4cd-95l1DL05cPjWdXWHF
X-Proofpoint-GUID: MOM-z8lrfEy4cd-95l1DL05cPjWdXWHF
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming Lei,

The patch 5a4b653655d5: "zram: avoid race between zram_remove and
disksize_store" from Oct 25, 2021, leads to the following Smatch
static checker warning:

	drivers/block/zram/zram_drv.c:2044 zram_remove()
	warn: 'zram->mem_pool' double freed

drivers/block/zram/zram_drv.c
    2002 static int zram_remove(struct zram *zram)
    2003 {
    2004         struct block_device *bdev = zram->disk->part0;
    2005         bool claimed;
    2006 
    2007         mutex_lock(&bdev->bd_disk->open_mutex);
    2008         if (bdev->bd_openers) {
    2009                 mutex_unlock(&bdev->bd_disk->open_mutex);
    2010                 return -EBUSY;
    2011         }
    2012 
    2013         claimed = zram->claim;
    2014         if (!claimed)
    2015                 zram->claim = true;
    2016         mutex_unlock(&bdev->bd_disk->open_mutex);
    2017 
    2018         zram_debugfs_unregister(zram);
    2019 
    2020         if (claimed) {
    2021                 /*
    2022                  * If we were claimed by reset_store(), del_gendisk() will
    2023                  * wait until reset_store() is done, so nothing need to do.
    2024                  */
    2025                 ;
    2026         } else {
    2027                 /* Make sure all the pending I/O are finished */
    2028                 sync_blockdev(bdev);
    2029                 zram_reset_device(zram);
                         ^^^^^^^^^^^^^^^^^^^^^^^^
This frees zram->mem_pool in zram_meta_free().

    2030         }
    2031 
    2032         pr_info("Removed device: %s\n", zram->disk->disk_name);
    2033 
    2034         del_gendisk(zram->disk);
    2035 
    2036         /* del_gendisk drains pending reset_store */
    2037         WARN_ON_ONCE(claimed && zram->claim);
    2038 
    2039         /*
    2040          * disksize_store() may be called in between zram_reset_device()
    2041          * and del_gendisk(), so run the last reset to avoid leaking
    2042          * anything allocated with disksize_store()
    2043          */
--> 2044         zram_reset_device(zram);

This double frees it.

    2045 
    2046         blk_cleanup_disk(zram->disk);
    2047         kfree(zram);
    2048         return 0;
    2049 }

regards,
dan carpenter
