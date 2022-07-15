Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50728C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 08:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiGOIMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOIMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 04:12:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4E7E82D;
        Fri, 15 Jul 2022 01:12:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F4jjfi024279;
        Fri, 15 Jul 2022 08:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=wq21jjlBWwtYE+mbo6pC0IeATVHTT4C3j0alAq5blcw=;
 b=aOwPZ8jOHg1Qd5e3EI6jMmO+1N2huDQguCH0Keql0c4XoZRVzcbT9omwRMeLgumNoHOW
 WK8IQm/YNPa26lTkhL5yGKV7rL9arUN3p/5Icl6JzrKceWOMivTlCx4FJc90h6OgTiz5
 DpneYMw17HzO2R/ZwsQdELiBYh6FmvfWZQ1PSSMOGfDle/jsHUyrSdd4IC/97nwot/1Z
 iDL+WCNgSsFG9hVwwxLUQ4YCLg4I8KOKOAIRFbCm4KtEUJ/81xNPCE3eAOj1h1QHwTko
 P8mJRCa6MCM3MiGyruMeNehN0nNafbUnK5/st/+GA5pTHoJ2dEm7Dr0BsC3YjzgbKDXo +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scfbut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:12:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26F8AKmD032299;
        Fri, 15 Jul 2022 08:12:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70477r80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 08:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaVyBHaPfaaqxP8Kl0LAAz4MYTB35RJJtzmSBLTWuDMVMf2N6pQYQdz51vGd/rbZXSAtvkAAZULirVcQPg4HQMqiVJSNjjplBeIUVCagzgooUz6oZygD7TfRTmQ5Tw67Rk7C4TwxINeewrGGI1Ui8R5K3+1AfpmTrcMe4vDcyLGbHgciRytlHC+4neGF61gYPRXNrWNJ4PW8/PVGZ51G+wuE6aN10fr8C3MqCPqNzaN+WEd6hQHYH0/HM00YioVbtYRKTIKF6geLMPzuPgLaWcKWOdGGvciDLbsbdNp2vWSmjjFD59Nna7Y4Jk44HeFLDhTt+14prjQWtobf7FUt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq21jjlBWwtYE+mbo6pC0IeATVHTT4C3j0alAq5blcw=;
 b=ayeHbHydYa04tHzeazo5BpMJQ7hBKP0YERwWTa2KHc15LhBM4ytDZEODj1x6zZ8+2fBUrC4owUXWbB3TZtwoZHZexvJOcYK1vlHBmiXhmbXnEL5mb8lURhw80dt653dCoAGU5ABmYbjwcOlc6HLZpJUsp9PMtyC9jIU+AnzKIJiyOvEOnKJW12Cu01k79M5FtAQiK6/wlFLpufKkb48GZHIGXsxcPApm2XFPRaiiI5uEfPz4ZPR66cFlAZkRpx0awGt01PAc+GrNIvU5E3XcQKd8Ogag/H3CWsGT9e2GfDCKKRP0K92Zb4jmEj62kzYrTOe8Ivyyewp4KQlWhCi2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq21jjlBWwtYE+mbo6pC0IeATVHTT4C3j0alAq5blcw=;
 b=H0oblXha1aoYA0HnP8EKdbLX9l84qz5snjVkBDJQRSzH6vpQ5MO1/RlCfRJhiyy7AVh/VsG5iT0OhSZoqsexzz2YyWD3/fbk8RKjPlRXwxrDlHdKWme8zXFGycgbnPdhjdMiOkm4+QzABDNYSjznQlAM8btVAnJNmI4C1PQ4+eY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1985.namprd10.prod.outlook.com
 (2603:10b6:404:105::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 08:12:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:12:26 +0000
Date:   Fri, 15 Jul 2022 11:12:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] null_blk: fix ida error handling in null_add_dev()
Message-ID: <YtEhXsr6vJeoiYhd@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEhCjDq2oe2SIkS@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f23e8c00-ad07-44c2-fadb-08da6639c09b
X-MS-TrafficTypeDiagnostic: BN6PR10MB1985:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py5chP4GWVLNF+IxBFxGOfneEIkzbpCWhBApFphN750URf2plzW6Bl/Y1EkbD4a4vh7j/nJtO4myK08GCp8Iyw8zECraGA0z7VfFxzbrtvNfXscf2ENFAzrhj0g9Gg7ryUS+fDX+JW2DD7vT9xw50egq5Jbd7kFnu7c/QNxhq50J3mie54Xd0InngPfeUtE6DPslYEHsZP8dfKHSKwa4Jpb8r7vPpEq2kKuiAuEGKA3LXFszDODGGGTCECFG1J154fwrNm2oUOjXQhn2HIvSafcyHt3CmIek2NYABe+t4BvoMsYAPVHATtdQUgnNJGYF2jOPxWV38i/bAWnOKZtnAfbXeiAbI7aSB8wu0pCmqIvMLqYrh1polQGxU90lrIKoowheEP4uVsHOwkMevYYe635MbkDQbJuipDV9hBJrEuT+91wQW0GcWOVkmmvKqoI1UF5c+SklTN+tdzAAUd/jc5jw2A4c9zBLedryYIMZj1ry953k2a1Bt9isbA4+ffXRETiPBDD474JuwhFHUVLyedDN1T1z2C5cmAuIAK7byt3ddm1OO3YZkUmG+OnjKNIsKTjHCABzkwSehO9gn//kMZLo4OA/A8dt0DnO2MEMw5AdamBt3awl7ucRUf+c61rrFyKyJStxOPv0+qUfxvggWs70fJ785rSzenrvw07oV0sRU7+ag+IjxciCFMM9CMsG/XL7pIZx5wSYYlvSBIrAUq42VL0pTY1L4apxh8ctpSfOADc8uv4lnRUUUOFQhBCOnQSXg7PovfGJNdE+o5qnS8NFl9DbnUgXLimCR8lUy0KiqCydxVLooIB8oOzgmmQx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(478600001)(6512007)(52116002)(6666004)(41300700001)(38100700002)(8936002)(6506007)(186003)(26005)(83380400001)(9686003)(38350700002)(44832011)(8676002)(66476007)(110136005)(33716001)(7416002)(316002)(2906002)(6486002)(66556008)(54906003)(86362001)(5660300002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txdygmhTQ71eh4q2J5ygvbL0RTUrKA5utrTXjCVDHjQvUoL8ZyPcD34c6ibt?=
 =?us-ascii?Q?XloIKMJPxjjl3QWT2C0S6hDV+QWgHE6IHKzNforf1vJBopAS6VYzIS8AL/mo?=
 =?us-ascii?Q?N0rJZjHzl1x29QxKL+oEM7idH3BkKdAg6VoKgtHo1QOpB6qxD2lIw3AW+QbC?=
 =?us-ascii?Q?N92kTcW/fdX+qHDtzDNHofEfI6kCwcN97Qtgn/b0YQ32NzROxp2aZ2uzaCKn?=
 =?us-ascii?Q?81Emc4ecU9o6bosQIRQ7QidX7JnbYCS3RGmMu15WHTW879mNEoec3pkiLj1C?=
 =?us-ascii?Q?d4uRCcdh4m58ZwDbZniPzljOtrYrJmKftVzCE5KfcOjTFXMK83tudXNA0kQ2?=
 =?us-ascii?Q?Qf8XC3ImMpu8kJkKDQ6epjVffzitY7kRs0tLgRpHjeAHllv6JanWhb5kW1wF?=
 =?us-ascii?Q?cDVhVgcLc6EDGQOxmC/GiTpsCtU9DfiGBlDQENJGrZferPTg253+N+dLqZUU?=
 =?us-ascii?Q?PoqG2E8QsYMVJgr6mwXE3j7a5yYdz4GXKxHCQznrNrI9xbsB7bKFoQFNUiYQ?=
 =?us-ascii?Q?jQukbhseWX/qwmrUYwwSaZYVfCTY39yZFkd2F0JKJz5UIeT/tiby1tua7O1o?=
 =?us-ascii?Q?z8GCmZRS7QQMKP8aSY9gftysShGAIwDJ9TbVjqlohhgWPgZR6ki4eFVsjyL4?=
 =?us-ascii?Q?i8jNUIA/6No4qig7XHo2zzKbM6s4rOqhNthMNiVAEZ1oDpEZR0RobKHTwVdh?=
 =?us-ascii?Q?G9jw+36uQVMd1Od72IpInmjiEAitR4Mgc+Ublp41gttxQciRFjgPUC7IRqhR?=
 =?us-ascii?Q?1xdCwFU2jgqunI/gjgqJy2bq2AidU3OX5lJksZTHkL/6CxcHghclvwq+Fn1C?=
 =?us-ascii?Q?81DTQknz/WV/gcyws7LBsmyaWTcDNDwOr5qeZPACKrqlRrRx3KC4Qo+b7zks?=
 =?us-ascii?Q?r4rQCHFvcvogy4Qh/6nkFjm6i7oRiZlsVQFyImJY+gYTgaHKf4DgA/1ZXOMV?=
 =?us-ascii?Q?kgRcCS22KidOFKCL6YyOjAKospnOZCCnQIu1JKsG7zie7Qtnyc1zJ6ja+VdR?=
 =?us-ascii?Q?idcYrzXGGcaj6pl3b407QQulKgvYXQQkgFUL7cybn2mOjgXIrGkYTmdTjzqG?=
 =?us-ascii?Q?lUQJ3Dy4U8GfKyr+/8IDrIjlerF/bT3QzLB5wN5OWAC7AML5jUJhITGJRzVB?=
 =?us-ascii?Q?h64dCvoTrD8lrXV5GMzhYJjc37KfxTddmQeQ3yvTti4O/JatnlSd7Aakd8Gu?=
 =?us-ascii?Q?VWBxojVIDYSfFStwnPQPS/ah16Zvy0mKEDtWsN5z3o7S4oXwjFidABW6RqgC?=
 =?us-ascii?Q?KQ9o2LT0pMmIS6dhMBf3O59FMQkoqGLsuaNqD3ydQclrTyCh0slrpB5v7GUJ?=
 =?us-ascii?Q?cqk4qNBl5Wkh/e+nRd6I1P94WXOL9ursaTbwcn6wctZ6qKh6RErt2Q+VeghA?=
 =?us-ascii?Q?vBxvanVXK1TtDp7gHRJ8wLyleBTh2Ci86ydDE8rFnJSpVCYWVrEsT6WsSDp0?=
 =?us-ascii?Q?Kudnx3QgNpTWl8wnWTfST6X/REUGjK04cy30DRYtmEtVQMOXK5EG+pKF4fn1?=
 =?us-ascii?Q?sSaETsM6fa1tmjlqZ+2HY9j+9/CF6B4N4phzEmxH7SHDLOKjb1l331FhHvH7?=
 =?us-ascii?Q?ZvxTau6w6wDLdT3XZ6DXkcB5XPbFtfoSHdtyJGK/2WuPC6K4BfWp4ar8O8Rn?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23e8c00-ad07-44c2-fadb-08da6639c09b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:12:26.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qqH1sWtyqskkXefOftlJRgfZiNTMW0utjz7Qi261HSwQNU7YBTNlN/H9pZKhIw55pLlVhoDuCQYFsW0P3M52APDFXRxLy9OP61b9e52DG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1985
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_03:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150035
X-Proofpoint-GUID: bqYKOGXeVGyv81Vuy4S8pGtdlssCnopN
X-Proofpoint-ORIG-GUID: bqYKOGXeVGyv81Vuy4S8pGtdlssCnopN
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There needs to be some error checking if ida_simple_get() fails.
Also call ida_free() if there are errors later.

Fixes: 94bc02e30fb8 ("nullb: use ida to manage index")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/null_blk/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 016ec3a2f98f..3d334d46d5f6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2074,8 +2074,13 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
-	dev->index = nullb->index;
+	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	if (rv < 0) {
+		mutex_unlock(&lock);
+		goto out_cleanup_zone;
+	}
+	nullb->index = rv;
+	dev->index = rv;
 	mutex_unlock(&lock);
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
@@ -2101,7 +2106,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	rv = null_gendisk_register(nullb);
 	if (rv)
-		goto out_cleanup_zone;
+		goto out_ida_free;
 
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
@@ -2110,6 +2115,9 @@ static int null_add_dev(struct nullb_device *dev)
 	pr_info("disk %s created\n", nullb->disk_name);
 
 	return 0;
+
+out_ida_free:
+	ida_free(&nullb_indexes, nullb->index);
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
 out_cleanup_disk:
-- 
2.35.1

