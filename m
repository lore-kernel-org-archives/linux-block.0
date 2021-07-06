Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC30CC07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AF261964
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhGFH5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 03:57:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230255AbhGFH5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 03:57:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1667pj6j026782;
        Tue, 6 Jul 2021 07:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=iEfFJc0YbJ1EunxbAoNHPhuU2VZJSz+x00E29bg4pS8=;
 b=wfMY2Gs5RTW1So9rGUDtQu5Xn7rGlP8RWTkc4ro3jFJhGwmDnmlwVr07o8ZZBadoa5vh
 zK9y4WqUGLyqlSmFt/zGt7/xep3CZjpV2XJyJYniqj75pESMGfyjE+UOqW4QLUKqBiFl
 b89+v7ivRWuhtdFG/sSmToMDsnIIrTM/173Lo2Q6n5A48NENXI5WrNssNpapXJAULGOm
 AodrFBJ06Ge9MVIF27OWo0eZmjGSMxkwyU2x7QNEcDqw1bAvnWQJiiniKd/u2vDrYYg6
 QaKqOIwz+ydt0z3UDI9ew42oiVyehOIgYumwpNCgWnAqamgODd09YMMl5s1J4I9LCzN8 yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kw5k1wrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:54:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1667oE9O124523;
        Tue, 6 Jul 2021 07:54:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 39jfq84up7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr6NlhFaV1t1tJYnIaQNQPHKT7p5YqlXpi8aZLsHcZ8pW/G2lirLnHHjZ+fQQ6193Ja8zXCmqKBUxChgmHq1D1xsBDCLxXbdC5hGtNZos+MbpU6AUei3qXuxtKL8O+1/qpoVqYs0EMZ8WvOB7e6sWuSwieQ4AAGp3w+aOiYUpV2aOmtwe7ixLAuA3jaQo2mGVCp6SlYpa0PKapfNmt0CSK3zN4bFp78PpuHZtkJFRsEDhekhJlX6Be7q12ICkmotlq/ibbz2oriVlcSuBY788Yru/9YCF6zcU1ZxppZ6rBNry9Rkwpz5FwzqK2Griv3lPVxlztD2Kl2WVfeyVjw6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEfFJc0YbJ1EunxbAoNHPhuU2VZJSz+x00E29bg4pS8=;
 b=Xng5I1RGS4iBULi6qx5ccuTA8S6loo81vY1bxHZ8bQQOwp3GourwKIOUa6tFOsvIwn+HqhTC6+JACWI//HRc1crHX4DhG3nKEkHcnsFepoKmSq5xwClYzoAirjK7D1XNSfiJiNleh06SIljZydHonbWFs1rj53hcYSHT6lzNyrPUfZfbI+MPlrOfMOao1SpPoz3W3Bxr9GdahLZE2hxgcUs7Zu6oPcOg8T2cYeRcfe9wacbfjTxFj5zoyO16yaJjmZiJrX21AxLTHQelXEx8PAN4x2nAAKoJ+F81W5+k9dL/2Gh6o2pxe2K32FXdmh1wYhi1NTMjaBTJj3+KQISU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEfFJc0YbJ1EunxbAoNHPhuU2VZJSz+x00E29bg4pS8=;
 b=u65eb7gFSUw+0pKdIiFivxfrMuEiZ5cdrrqWalAQ0jAZh9aW6i2PGsNdWFqGSRe7usX2kTmNfCqhMNErLaskPjPcxXO2623/7DOeIz1X53TctEa+uWfC50y7h33CmbT+dOA/kL+TazbHaiDIaUapCqUGKhLHdbDi7y5yGsVhrwk=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1725.namprd10.prod.outlook.com
 (2603:10b6:301:7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 07:54:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:54:27 +0000
Date:   Tue, 6 Jul 2021 10:54:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        axboe@kernel.dk
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: Re: [PATCH v2] block: Removed a warning while compiling with a cross
 compiler for parisc
Message-ID: <202107060648.767XjMRK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704124826.63468-1-abd.masalkhi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 07:54:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16976c8f-981e-4bd4-9770-08d940534776
X-MS-TrafficTypeDiagnostic: MWHPR10MB1725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB172510F29B5DF3DFA9D6D6A28E1B9@MWHPR10MB1725.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8g7+mk1mHOUF5YHUD2wSRUCpADxV1lUMq/vFAEgw/S1s8EESgqRCg4XESVpR8U/zehEY28uR6DNXCw2rOlwiaJZD6DE5zo51gmgf9WX28bLdfuuNrFKXp5mYp75wJg7df7AQT0VapPMdjd2CRaNjyL7lSSYFuTvhJ36Deothpl1mtBYJCciZWkN2N3EVmjKt5Xwzj7xPOu1sZVzzycoLnUOKoIL1z78bMtynEyQ7NBJtEEtRYbdZ+t20hYvuvP3TOiiQ3/CZ/TWKtmsOfaulGN9TUzey56yVEKdys70klTYKMumbs0dDcZaX+5rhm2Df5BGtrYFviq4Iga8wdmxcPScCGLqbPG5xgLmvg1mLnarUHGe6BWMbO/mmb1ZBKm4sFvrsNX8RFnV97+MzfVGsTTW1cDJWh8aXNDsZbqCUdLbk9nePe++tm8nHyeu4NEh1DiYYADjxanMDmwIjfeBwJMrywUOALuh9wvLQuhAgEsECN93Jt1pyEsNgOQ5zQ/lw86OmSJSwML7DJpeWhXUPV9OTzsZwNrJZFv47WtEqRf6I4kpVPtJf4GqITijs15CS875anoHcXMj0rbemYEps0XerGwg3NGlBH55oXU61QfBcv02vXI0g+GXfiJYrThHBmphJq5EZBngMrT+1Tdnj20fu+OSGtEaHQzAMNtP/o45dcd3bHvZ26jcVTf2AsE6XRpXOOF8XExSY79WCffMRwnjoUIcNGJv7te38Py00TKHLa8vkl6pOADZ154AOOTP6vafa47pOdISnH4bRA24YTyPi9ehbnSBcpSIZIdtvucUikA9zKlFQA4Urc/m1vVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(186003)(966005)(4001150100001)(38100700002)(16526019)(6486002)(66556008)(44832011)(36756003)(4326008)(38350700002)(66946007)(316002)(5660300002)(66476007)(26005)(478600001)(2906002)(956004)(8936002)(86362001)(1076003)(6496006)(83380400001)(52116002)(8676002)(6666004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTqC3Y+Ola6q75a1SSykGKjWHGu+eUMMws6UJ+aA0YWSJlazZYKsSvIAKFZY?=
 =?us-ascii?Q?lQyjl1Wmv6ykUdpXBVXa74pdDbNEWRtx/NmDDCpvB71YKpCnBrjQPq9VAVlR?=
 =?us-ascii?Q?EbSy/0jviGH6qU3j+Zp/ykdmED6lwks+34wkwK5C16M6IO0Q6atOTR4jxAPU?=
 =?us-ascii?Q?9g4L0Mls5Av4laMPcmXsepCMh2vXOhnEPMr8V4hZfYeBJc/t73d6C9SPwyqr?=
 =?us-ascii?Q?PghV5uc6Q6KHwG+GMx23XAmTgSEB5HYurzvYvXWofuQozNYt9NJbLElml/uP?=
 =?us-ascii?Q?Ky6z8eQA5/mWD6MwcNjjhkEUM98g+qyxjqx9vq8amgOwqzQnnYPViYk+0jxR?=
 =?us-ascii?Q?lcKv9gywq9Y6IG3CC9dd3Ws6GapGt2aC/TvWhYE1MooACAgHNI4iOcngQ5mE?=
 =?us-ascii?Q?uVkzfsZzeMncgHI1zsqyHUTIDTsp3Cv4Y1c9+MbuV6VDtaSAl+sU5xJmz35/?=
 =?us-ascii?Q?CfBVwfeebWEfbAqAg8kga66ItuBncwA4aoXSG3slVJGaWCw3IEmJ4NIzfn7F?=
 =?us-ascii?Q?pnvaKl2wTcg1SYbRXeQNIlTfb10Zl6EITzwOtXccAte718v/YkL5quinTz4T?=
 =?us-ascii?Q?LKTusZsZZIo/SnjYLgpTa7OFL1lhErAd4G/T9UacLtaFRANVU2b1uakJ+Y6I?=
 =?us-ascii?Q?gYA0s1Oe3sXTO2s9mZjp7fzBy7XKjYgpgbUHj0f4GIuLXnLS1reDwduN3rkZ?=
 =?us-ascii?Q?IP/xsoipsOjO4R9DyCvt7LJmHovrZD6C+em024uDnzK1hOX/f2YXJRmFUqgY?=
 =?us-ascii?Q?yk0Wa9TdIGY1OQs9pE5A8Qls8KmiJKrB6T6HDfVhkJh6HuDgu5sFvVlB/e1f?=
 =?us-ascii?Q?mEUP++s741uG0TO8c04qFof/UEpqod7qyOUNdVCfiYVK7H8lZR4e1eBaK8A+?=
 =?us-ascii?Q?0PT3SiwuuOUTtzOyQ5PxAsrrUvr5kyaPYSOaoJpeBIJS61FDonXrVQKFB0ap?=
 =?us-ascii?Q?N/tCvXc55iwHuWdEio65MwiWmefz2fprGWeANo5OtaApP6Eskd+8g8h1FTlM?=
 =?us-ascii?Q?H5atxGermncknstorGRXSMjpKSbqh3hamkj0Ym+JMR8F9QS8RbQQfL1jZ76Z?=
 =?us-ascii?Q?KxjQQXCScPX54s/U4gh9Zk03tWhI3/FoxtVOalOvx225IyZ1zFQ6gt7Anfre?=
 =?us-ascii?Q?eecZBQssCkiAnrZBeeTbsGWuxlutQre6CDMju9Bh3iVAm1SFUPp1OOzDygCS?=
 =?us-ascii?Q?Icjx2eVvVXWigRUEDHIvCR9dHyM0YJnRWvZrDrwuAXakAHgnVjMF2KiA4i2p?=
 =?us-ascii?Q?EcTOoWmSxEQN6nubU8LVvn3il3FOcQuA+4T6rh0VvonHqaTmC/Lx+ZFJdcBy?=
 =?us-ascii?Q?pLHMJN5OV7ORculO9rp4itF5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16976c8f-981e-4bd4-9770-08d940534776
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 07:54:27.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FFk+Uxc7fnw/DEQVjpOdoglmkmxXAzyhoV6tsImr18tJlEE4gjXyQ3NNUV1BYQH5sRYefmYFZ5lFLT4xvMzUYJNraHACHxpUnA+v+EsqXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1725
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060039
X-Proofpoint-GUID: xl25rz_cN5WDkjgK9iLA_zEc2i21Mlml
X-Proofpoint-ORIG-GUID: xl25rz_cN5WDkjgK9iLA_zEc2i21Mlml
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Abd-Alrhman,

url:    https://github.com/0day-ci/linux/commits/Abd-Alrhman-Masalkhi/block-Removed-a-warning-while-compiling-with-a-cross-compiler-for-parisc/20210704-205212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-m021-20210705 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
block/genhd.c:1147 diskstats_show() error: '%pg' expects argument of type struct 'block_device*', argument 5 has type 'struct gendisk*'

vim +1147 block/genhd.c

acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1113  
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1114  /*
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1115   * aggregate disk stat collector.  Uses the same stats that the sysfs
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1116   * entries do, above, but makes them available through one seq_file.
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1117   *
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1118   * The output looks suspiciously like /proc/partitions with a bunch of
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1119   * extra fields.
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1120   */
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1121  static int diskstats_show(struct seq_file *seqf, void *v)
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1122  {
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1123  	struct gendisk *gp = v;
ad1eaa5344b293 block/genhd.c         Christoph Hellwig     2020-11-24  1124  	struct block_device *hd;
e016b78201a2d9 block/genhd.c         Mikulas Patocka       2018-12-06  1125  	unsigned int inflight;
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1126  	struct disk_stats stat;
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1127  	unsigned long idx;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1128  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1129  	/*
ed9e1982347b36 block/genhd.c         Tejun Heo             2008-08-25  1130  	if (&disk_to_dev(gp)->kobj.entry == block_class.devices.next)
cf771cb5a7b716 block/genhd.c         Tejun Heo             2008-09-03  1131  		seq_puts(seqf,	"major minor name"
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1132  				"     rio rmerge rsect ruse wio wmerge "
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1133  				"wsect wuse running use aveq"
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1134  				"\n\n");
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1135  	*/
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1136  
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1137  	rcu_read_lock();
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1138  	xa_for_each(&gp->part_tbl, idx, hd) {
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1139  		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1140  			continue;
0d02129e76edf9 block/genhd.c         Christoph Hellwig     2020-11-27  1141  		part_stat_read_all(hd, &stat);
b2f609e191edc9 block/genhd.c         Christoph Hellwig     2020-05-13  1142  		if (queue_is_mq(gp->queue))
ad1eaa5344b293 block/genhd.c         Christoph Hellwig     2020-11-24  1143  			inflight = blk_mq_in_flight(gp->queue, hd);
b2f609e191edc9 block/genhd.c         Christoph Hellwig     2020-05-13  1144  		else
ad1eaa5344b293 block/genhd.c         Christoph Hellwig     2020-11-24  1145  			inflight = part_in_flight(hd);
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1146  
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04 @1147  		seq_printf(seqf, "%4d %7d %pg "
                                                                                                                  ^^^

bdca3c87fb7ad1 block/genhd.c         Michael Callahan      2018-07-18  1148  			   "%lu %lu %lu %u "
bdca3c87fb7ad1 block/genhd.c         Michael Callahan      2018-07-18  1149  			   "%lu %lu %lu %u "
bdca3c87fb7ad1 block/genhd.c         Michael Callahan      2018-07-18  1150  			   "%u %u %u "
b6866318657717 block/genhd.c         Konstantin Khlebnikov 2019-11-21  1151  			   "%lu %lu %lu %u "
b6866318657717 block/genhd.c         Konstantin Khlebnikov 2019-11-21  1152  			   "%lu %u"
b6866318657717 block/genhd.c         Konstantin Khlebnikov 2019-11-21  1153  			   "\n",
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1154  			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), gp,
                                                                                                                                         ^^

ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1155  			   stat.ios[STAT_READ],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1156  			   stat.merges[STAT_READ],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1157  			   stat.sectors[STAT_READ],
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1158  			   (unsigned int)call_div_u64(stat.nsecs[STAT_READ],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1159  						      NSEC_PER_MSEC),
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1160  			   stat.ios[STAT_WRITE],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1161  			   stat.merges[STAT_WRITE],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1162  			   stat.sectors[STAT_WRITE],
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1163  			   (unsigned int)call_div_u64(stat.nsecs[STAT_WRITE],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1164  						      NSEC_PER_MSEC),
e016b78201a2d9 block/genhd.c         Mikulas Patocka       2018-12-06  1165  			   inflight,
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1166  			   jiffies_to_msecs(stat.io_ticks),
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1167  			   (unsigned int)call_div_u64(stat.nsecs[STAT_READ] +
8cd5b8fc00716f block/genhd.c         Konstantin Khlebnikov 2020-03-25  1168  						      stat.nsecs[STAT_WRITE] +
8cd5b8fc00716f block/genhd.c         Konstantin Khlebnikov 2020-03-25  1169  						      stat.nsecs[STAT_DISCARD] +
8cd5b8fc00716f block/genhd.c         Konstantin Khlebnikov 2020-03-25  1170  						      stat.nsecs[STAT_FLUSH],
8cd5b8fc00716f block/genhd.c         Konstantin Khlebnikov 2020-03-25  1171  						      NSEC_PER_MSEC),
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1172  			   stat.ios[STAT_DISCARD],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1173  			   stat.merges[STAT_DISCARD],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1174  			   stat.sectors[STAT_DISCARD],
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1175  			   (unsigned int)call_div_u64(stat.nsecs[STAT_DISCARD],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1176  						      NSEC_PER_MSEC),
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1177  			   stat.ios[STAT_FLUSH],
acc384f7df09a5 block/genhd.c         Abd-Alrhman Masalkhi  2021-07-04  1178  			   (unsigned int)call_div_u64(stat.nsecs[STAT_FLUSH],
ea18e0f0a63af9 block/genhd.c         Konstantin Khlebnikov 2020-03-25  1179  						      NSEC_PER_MSEC)
28f39d553ee242 block/genhd.c         Jerome Marchand       2008-02-08  1180  			);
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1181  	}
7fae67cc9c0e06 block/genhd.c         Christoph Hellwig     2021-04-06  1182  	rcu_read_unlock();
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1183  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1184  	return 0;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds        2005-04-16  1185  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

