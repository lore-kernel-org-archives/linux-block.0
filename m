Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AF0C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F8061205
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKDLw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:52:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54298 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhKDLw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Nov 2021 07:52:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A49rxqL000771;
        Thu, 4 Nov 2021 11:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XUqfSJouTtbsL6ckt2c4lWluMSpdgYME9cij2vg+3hQ=;
 b=Rks18zEHbjtsjNMTkd8cIpxAYcuGL07ow0GW37ADvhfE3T54HtTMjMvY9WVhEjicZfzr
 j7kPelUJpE0cVfS2z8yYXwiQOfzKTrcmGfh4Rcr+4ICPC+gurzTsfEZ3QrDTHwZ3Xlmm
 6JSfFMdgXkG7Jhi/CNMuwpV0rdsd9TA16wvqiGa8TVr8ngz9bRmPxg3uwyfpC5nDc6wj
 uFZ0FZIKyv6PT3WjefgCXcd9EsqK4/U3L66E2KyeZRmiCy50k35m6ZFQQLGLktUyJ7kj
 xqereV7Bg7gFMNY4TrHAgVWVhunxrjBS+PWpQXD3mKNCdGmtJP0WIyjbX75TrQA2q0OI iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n8p7erc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:50:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4Bl8uM000808;
        Thu, 4 Nov 2021 11:50:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3c27k8jaa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJqXzMjezmwyj+m+P+uUxBArTynH46blPjFjHn6DUuZDTsYWxLAcPm0r7UYGVmMF7WkgySCIPASksA3hTX1WUIfRYdIYUHICQh4Q3z7jS4pHE4ibQpcgjCbeZz4Ja7ZJJpV9UdW1I0j5CfhzTkMpgvs/czNbmg2iuEDDlf0Ls6uiaeTcjZ71E2ABUYQOEV8VpfCASyeZ4KDjBQkUjp5VcE0QzgXIZnOArJFGR8+7YZuQ51VqfTG68f7gazzbUTzTXi4fJBjravTfdgte2R9uOrYbO66NlruniYNVa2V/vvyvTNjjQLp/k7OSR6S7zFvRSbgfB2/ueMNVmqfJ8EnnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUqfSJouTtbsL6ckt2c4lWluMSpdgYME9cij2vg+3hQ=;
 b=Pn+RNHRNXdN/Kid7rSuFBZUglddaKMxH4MCGk9Fh3Yjk+FnydgmGf073zdLSpODmn1SiVa9xl3aXZPF1wRXO6thOw3dSQXNRWkT3VBdviEVp5FBwTrDis6uoadajy6fC53AteEvyfHEYQ/ZXy0P7iXv44g9w+AmIfEMGvhYS185f0kTmfMLZZtq5UimkGQ6HjnSybjRvB6/2E/+HpSNG+4emL27ydafsxrqHotoFL/yStp+dITE12j6Pk3WpAtse3zWIMLBlqYiv6irBGUnY5UB49JvDFb9DOqU6jKsRUJrmaw8Fwd6lKvVLSHiA8w1pHEEkH3hHXp1s3fkkKyRaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUqfSJouTtbsL6ckt2c4lWluMSpdgYME9cij2vg+3hQ=;
 b=U73TG6OGmyYvIJ8PoZF5xBWpKZoUDFNI52AfMQB5xnnwS0DflQzeIWGITuCQ68E4AeBLLozH/WYNjtyH456qWNCezJzzxMD3E9GMXnUg+u+GpCldmB8qH1J/uI1kjRUucBL2RoUChGU8rnTQ3Ebw6i5v/P4dEMU8LMRfazhARCg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4547.namprd10.prod.outlook.com
 (2603:10b6:303:96::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 11:50:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 11:50:14 +0000
Date:   Thu, 4 Nov 2021 14:49:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ming.lei@redhat.com
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-block@vger.kernel.org
Subject: Re: [bug report] zram: avoid race between zram_remove and
 disksize_store
Message-ID: <20211104114955.GC3164@kadam>
References: <20211104114830.GA4962@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104114830.GA4962@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 11:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 139ff00f-2942-4f8b-ef90-08d99f894345
X-MS-TrafficTypeDiagnostic: CO1PR10MB4547:
X-Microsoft-Antispam-PRVS: <CO1PR10MB45475569C793E49A9AB54E398E8D9@CO1PR10MB4547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gICU1Yu8zz693Du9dqg+fO+R0cxVmWXW5odSpO5mGM8f2Gc4Vpf+Uw/j0qKQuY7KFk2iII+eR62DrEEuri05X2JtlJ/SBN6De5OzxYBZZaUSilPOiQtguVmjP5X+fHujioBRR6ZzkcKzHRiyF1uiy78jYjTcSRpMD52nUAxNPUjHSAMnNoudqC3jK5tbFWMHf+HwaWb1DyKQS91bmnqM2W4KHGepvYLB7A5x3SzDSmoueCDOp2TquMhIyBs1Mugu2MsePepA8frMTzgWsfgdF5ROh9UUNT+S81nLAKtQJUxs98bOlVbZKSIIw7i9XgTSaKwuHL1h9xj7QIGXxcrKYFIipJdzZ97DRcqxI3GevQeaOzrug0xnKOh9t1nTzRMntIdXlbHZWUeKuNyssjSY4hnvChyNH11J+dM7DjjhrJ0Bas2Oexh2RlmsjVhQEwzQrVS/FtKsceWY2CoSh1Yjqixx46Ced+rzrK3lyELfWC3mw1UciDpzHKS4NpifF5fpdEpgQUtIH+y3pFIiGY8YFxRaOfuvUr0Y4YYNAPcfqZkcQPQIx0g49q5PrO8Dp0fWOZFXPhtnWrUuxDqDJ4YiKTfmA8siXMB3ThJWG70PgN0GED0LoGHdoVJVv6339JC9KgQEAPlj6SoCSLvZ1A1cXNoc2Ye335VTX8fYr3OIsaFaqA/qqZ3VPSxMzTiNCqOkdmC7REkzuxZOaTEoc24/1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(55016002)(508600001)(8676002)(52116002)(9686003)(2906002)(86362001)(66476007)(8936002)(316002)(5660300002)(1076003)(956004)(186003)(66946007)(9576002)(44832011)(83380400001)(33716001)(26005)(33656002)(66556008)(38350700002)(4326008)(6666004)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L78IXRuJVqFQd91PM1hRmmE2Pq0uaXaZNPPsgA6UrEEc0TnFqkujI3xcwQ7O?=
 =?us-ascii?Q?k59HiMJzWD8KoZMFqa94MdUKRP4p1G1KaMbW50pR29uQ8+t/aRYm4q2XGTGo?=
 =?us-ascii?Q?StBOmRR23EaGvD8uSXu4/80ko93JEcDU6Y8R47SfJ8ILVW9EOmT4/+Lx8Und?=
 =?us-ascii?Q?MzDsP6WN4sOO+fbzd6dAQ+Tk/bTmFMH8+7+IdJY3eXxh/ka4rx8NTmiA7fmU?=
 =?us-ascii?Q?dLi88ej3TsCT99wSH+e5YjerfI7EE3SzKl3L3Bu13U1xSh5E34Sj/6uvOuh+?=
 =?us-ascii?Q?yFISb6BnA1e7ILeywXv/51OcA1WDFCdt5yQzkRczRSS2d80Izd110UBQV62P?=
 =?us-ascii?Q?g+RZEd9kx8JXliBt2/y6VM2Lhml9Ma+pMZnQ9KyEH08c0fs3fqVo5swgtIKB?=
 =?us-ascii?Q?guLnhnYlWOECpIphKFTCpyTwVLBuQxB1EBVCGNYqDgfwwQQtVaPVUiqgIH+T?=
 =?us-ascii?Q?Ed9/Pj80IlY78Ia1a4GU0J0zqdNXyIzry43O9jONNf0Q8usNcgkrQXmzuPBn?=
 =?us-ascii?Q?YRKv1WZbnW6pN2XkQfVH62UtuxFxZhL44sJWuX5FyviAhEblhjnRJFf1Du8l?=
 =?us-ascii?Q?GxmO1Cj5ZqCRFJoH7yvehVc8tUzc1/BMqUk2Yo2QwiKOCawiRJVcC7YfVuuy?=
 =?us-ascii?Q?s8JQmT8Qyfn8/KQsrh0oqJECXc4AhY8OACEi/vZZZA9q8IR25RAF9Cq5hDno?=
 =?us-ascii?Q?IJ0j470tWc6NtKJINwXaMKSz9PDbUS0DFT/6iWnTC1a4boNjpr/MB2TzmnEh?=
 =?us-ascii?Q?mPKoKXkkACrTPgGerJm3ognMM2uPx45oa/1MLJnNPCmvUVp4Fg8yM0xZ8ahq?=
 =?us-ascii?Q?PnIMzvSpA5oe0U+tyeWVS1d/CTBQBcCza9HklBrTSV76nQoP5O+UKqw7HHiM?=
 =?us-ascii?Q?od5peoowBUe+BnX/+0QFSoV1eaGAwWgqKxeW7HE67+m/IdrdbSXugbhwPMCb?=
 =?us-ascii?Q?W8B/0oHUT+dJb3Te5LYgD+aJpjjYRtrWwurni2jyf76HzlSAnjO+hsHCJxFE?=
 =?us-ascii?Q?6aWTvmHy9tTO4UnpJHuumV377kTtG2hcsarJl8e+CzYOHd7KC1jWMo5utxgb?=
 =?us-ascii?Q?ZGzvszLWg4e5EAGG9marZ98QhzjFktk4od4E+6oTVCNvYWpyjG5cGptBarRY?=
 =?us-ascii?Q?vwIdcp+/l/npyogKM2QTfdHBuedqqu5y0A8/3Dhbc3eBq8WUX4o5cLk3uI2K?=
 =?us-ascii?Q?GZJAsmictjQCjUkF66LKszSuc3ajP/21mrthi19b330fPrGy2a/p26rspP32?=
 =?us-ascii?Q?VxyjtFFo601sgzq1ZOMRqDX9OcYaif8wmKB3O52RVseIgU4PzGHkDjTElZW9?=
 =?us-ascii?Q?KYxJU3htVbVcvJ9EgmScprBuSJAW9GRl9GWtWMndV1G+MMfaJhfMNR+R/m9W?=
 =?us-ascii?Q?rikQ1bCsDCf550T2RACWEfxItKKqRgq7js4Qo0Lli5ZZih9uMcA2Ex8vQaNh?=
 =?us-ascii?Q?UmuiveJZTUiH6UoeRAa7K9BMSMBLcObg1YehIoLQs1dhHbf0g54pVcGjgCR9?=
 =?us-ascii?Q?GQKfC7JfBKXn6qKrnElBa1iPJgJRyJvMoIFQTV9wm31B1Bk0BH0wImUuqu7K?=
 =?us-ascii?Q?BgMOCKwrYEOK4qD+O6OWjuHghtzumQolIfdmUJcFtwMsjBrj5zgpn3uQOc7c?=
 =?us-ascii?Q?CwAGHg6eVvzgqodFuHclLxafM57XGHmXNzn1/fMSI7GCPU+3vjv7G5rHBBtW?=
 =?us-ascii?Q?YUlr9D/ygrRVaDbxDSM7U7hl1WA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139ff00f-2942-4f8b-ef90-08d99f894345
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 11:50:14.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsIZZzWbR0NBn7TMJfjuDIvq+kntGFMCcdhYLSREW3VPaBnqE0Js+Vgl+/WLr8sLh1Jjd5zstUEAicFo3d08zUgCAh92AjUF0Wz5D4UGAHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=996 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040049
X-Proofpoint-ORIG-GUID: 8QkTU-C3ChY1VYhn6cV6MHQmJcNV0HFV
X-Proofpoint-GUID: 8QkTU-C3ChY1VYhn6cV6MHQmJcNV0HFV
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 02:48:30PM +0300, Dan Carpenter wrote:
> Hello Ming Lei,
> 
> The patch 5a4b653655d5: "zram: avoid race between zram_remove and
> disksize_store" from Oct 25, 2021, leads to the following Smatch
> static checker warning:
> 
> 	drivers/block/zram/zram_drv.c:2044 zram_remove()
> 	warn: 'zram->mem_pool' double freed
> 
> drivers/block/zram/zram_drv.c
>     2002 static int zram_remove(struct zram *zram)
>     2003 {
>     2004         struct block_device *bdev = zram->disk->part0;
>     2005         bool claimed;
>     2006 
>     2007         mutex_lock(&bdev->bd_disk->open_mutex);
>     2008         if (bdev->bd_openers) {
>     2009                 mutex_unlock(&bdev->bd_disk->open_mutex);
>     2010                 return -EBUSY;
>     2011         }
>     2012 
>     2013         claimed = zram->claim;
>     2014         if (!claimed)
>     2015                 zram->claim = true;
>     2016         mutex_unlock(&bdev->bd_disk->open_mutex);
>     2017 
>     2018         zram_debugfs_unregister(zram);
>     2019 
>     2020         if (claimed) {
>     2021                 /*
>     2022                  * If we were claimed by reset_store(), del_gendisk() will
>     2023                  * wait until reset_store() is done, so nothing need to do.
>     2024                  */
>     2025                 ;
>     2026         } else {
>     2027                 /* Make sure all the pending I/O are finished */
>     2028                 sync_blockdev(bdev);
>     2029                 zram_reset_device(zram);
>                          ^^^^^^^^^^^^^^^^^^^^^^^^
> This frees zram->mem_pool in zram_meta_free().
> 
>     2030         }
>     2031 
>     2032         pr_info("Removed device: %s\n", zram->disk->disk_name);
>     2033 
>     2034         del_gendisk(zram->disk);
>     2035 
>     2036         /* del_gendisk drains pending reset_store */
>     2037         WARN_ON_ONCE(claimed && zram->claim);
>     2038 
>     2039         /*
>     2040          * disksize_store() may be called in between zram_reset_device()
>     2041          * and del_gendisk(), so run the last reset to avoid leaking
>     2042          * anything allocated with disksize_store()
>     2043          */
> --> 2044         zram_reset_device(zram);
> 
> This double frees it.

I should have included all three warnings:

drivers/block/zram/zram_drv.c:2044 zram_remove() warn: 'zram->mem_pool' double freed
drivers/block/zram/zram_drv.c:2044 zram_remove() warn: 'zram->mem_pool->name' double freed
drivers/block/zram/zram_drv.c:2044 zram_remove() warn: 'zram->table' double freed

regards,
dan carpenter

