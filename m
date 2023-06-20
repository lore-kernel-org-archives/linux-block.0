Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D2EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjFTPIw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjFTPIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 11:08:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49A4A2
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 08:08:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBQ15D013046;
        Tue, 20 Jun 2023 15:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XuvAQopX87fK9NwtjtQZW+Wp4aAaHO7JzwpwPJ6eD2Q=;
 b=3GG3twp6steHl1qDkkbYOog0/1e0fWjebjGZvyPDoqYGMrBSdcW661Ypd/sFpUiha2t7
 qlYqD3UQt0AseDO0/RxPIZCc3k4/rF+V6ZHcJLtq8qp2OUNKQuIvlNHACIU8KgZJv4ci
 KqBk6heD8DTMbgfdZXhd2Csc3+rEF1WMARJURLWxmm2/uxHnN20RgzrOM99wB4R76YDw
 PDj+6Y3SJdxMKCKYxF0QjILbwujCKCIC5d/phpiXAtkRUhDa+4U/eQGIqyIqAObsTeur
 ADbDGPZsk1IEwFnJiwyfAi6MQHzvs95bnbI8UnlWIL4psIknx2UZkjP9LFFbe8nmYnd9 Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbn208-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 15:06:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KE7foY007913;
        Tue, 20 Jun 2023 15:06:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w153204-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 15:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaPBFfIWfbZwN48wuKmfZqBuSrihgZGCDytqRlRfrpyAopCHl+5CBsHiIMfHreJYAG+rPFjirMjyjrNZi/OIYGUUOos0dmXBJ7xr631DAF+QpMsE3TmzDz7oI2QRc0fqbkPOtccaPHmJ3LyyBaN000qUg18A/0loPGVkFwdacVlyIltY69KeGbV+wqWoZ62PqeYJkWlhJRPOt0pUZ6wC7kY1UD6/Hndv2t2bXyt6Ile/lZt96kFD0rA1djH53bUG2h891kkqNqI/lhRLufDV426DCXP6pDc50Wrr7HRic3rnw+uLfYMIM2xJ5RrF9wuk7icggHoQfIVJJMRvtj/jbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuvAQopX87fK9NwtjtQZW+Wp4aAaHO7JzwpwPJ6eD2Q=;
 b=Z9P+2CO1s/LnJmjoxBO7rh8rNgxt0YSPuY6dnzTcrMHKlYvJXo66NF7MnIvVXGjC8ohJSV/UDpSgHRsEaelt4yzAtASNJmGuyB0caW4dIiDOAjMrPOMmfHSgze1ep/l9/M1J+ZIyAS+k/c3Rj55GPlLmksqDgY1S+gzqE/6L5PlWquW+/U8JneLSvbp6xFfwQ14VZ8zKfilZK0W5zCirbss1xc0d9KP3mRh8rlKuAviZSuPeT3OKzGzu23ahrW77vcvs5nlWNFV0YqWRd+B5+8NR2Gn/3Ajk2/mBqEqATozHel9zwlUnT6coux8UWhtDhN6MqF3IdB0VqIpmShmQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuvAQopX87fK9NwtjtQZW+Wp4aAaHO7JzwpwPJ6eD2Q=;
 b=dV7dq6ZHUOV4Qe7YO74ZEzPQ+2LY8ylRx/y8FFz8jwvnQhtHK75+Inzc698HH+31GJ9IlBcU87iQZYYBcpf7UJq3TBoA45yM2SWTQfjKEyPGxCNG4GSqgkykI6PeDFf51fwCJh+Z4iCZLOmpMIoGocjld16HIp5m0OekZNdRIFo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7115.namprd10.prod.outlook.com (2603:10b6:208:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:06:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 15:06:28 +0000
To:     John Pittman <jpittman@redhat.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, loberman@redhat.com,
        emilne@redhat.com, minlei@redhat.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com, Mike Snitzer <msnitzer@redhat.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edm6rxgy.fsf@ca-mkp.ca.oracle.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
        <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
        <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com>
Date:   Tue, 20 Jun 2023 11:06:21 -0400
In-Reply-To: <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com>
        (John Pittman's message of "Mon, 19 Jun 2023 12:02:36 -0400")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be843ba-b7b3-4bf8-ecca-08db719fec23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zG/eY7o7Hvwroe5riDwj4YG8a2nB8XQXJoA9fgE1faZZHRiFSFGDjt9zAJtvjZi4LiGzj+lIzQj5D37CIEkchOl7UI18eH8dQFbNp8zrZQoAx77LhRgu6uMyOhZBaxWAGIJcUKKKXWB1bEfNLcTXF80+moXK/pIHh71kA2YUdZ5btbYAhAs8Xa7VeuwFLZSQIe57GHpDYXhcdXtVo28I2ZuhxOla0xn12k+Fih7m3g6CpHJu/h9aa8TZfu31nJHuVqzypEvRe4DRrzZr0o2rX6JvYIdyqCBOBgvx3w8utLfEj74Z7wcCqZt1eWGxWmFihhvVrZBo0rBDEzuVm22J2+zgUd3yNbeUUsaUrhtA4XG+Z6JZEM9Qn7B06tuVxOkiqFadVNaPkeenKMcKerZHJUfO7N+VY1LplNn2hYgtUZiV7s0b4PkbnT4y5vTriHPnIwSN/yD8m9YwoJ5ygPP1oqkFwV/ide4WTOLB32VGxxVGPag3TTgX3aESTDUdmeT/MNDTVj8fhguRJDp2S0DqfIe/sofxAr/dCFMl4KPq4zVO86CKNoBrJGOIIg/EF/sO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(6512007)(6506007)(26005)(2906002)(4744005)(36916002)(86362001)(8676002)(8936002)(66556008)(66476007)(66946007)(4326008)(6916009)(41300700001)(316002)(6486002)(186003)(38100700002)(6666004)(478600001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+IU7aiUuYc4hJQW/etFB1gy5GCuIiYUGQENj/ucs32Yztryt17acN1OByVS6?=
 =?us-ascii?Q?nbxezuqelQssmgpm0b2QWZoWsii46lid/USVjvnJyDmCczKn0qmaLOLBhE35?=
 =?us-ascii?Q?ABYzJCiGIsYHFRTOrOX7RRjjuH96i2MR5/rmU9sOOV8XP0WCAvctBTb7z3os?=
 =?us-ascii?Q?DcA5lD13z2hDk/puxzL5OYJ/WxilcdoKRw7VNV+PHx0YgmW06frqcBMEVQyB?=
 =?us-ascii?Q?jGbAiuq2m/RUFFMASGBLjn8X30G/fMvZgJlx6NmQlYrITLDSMB5SRoEyLoK9?=
 =?us-ascii?Q?KJmc3Itif5tLBodV/j1rg0X6PY/7PmUccu3HXCYOZEeTLaQa5wYcpAjKBeGS?=
 =?us-ascii?Q?wMMYa8hG3cmJ4hOLd0KP8fBtnVF2okPe5y1v7nhhp4/YOwYfXcpunr1NRxSD?=
 =?us-ascii?Q?xqvBBJ8T6lYAkfjue3RVAi2hM2theTqjl/RUX4Tj3fwlk4duOPuQ7agw4Mxw?=
 =?us-ascii?Q?ln4RwtvJKREZL5QyJYYXt/wodLpS651XFkRwbJZzKAksEOpvJIAl6FpMz1NF?=
 =?us-ascii?Q?/54mjAlI25T+Q+GvrChobPPHQwseJn/zUuyOf2FvLYJy36emdh2AYRAkfHkh?=
 =?us-ascii?Q?jic+uyYYMIJdJDIhr7jbBA/6W54+RdyehJ8RGSJVWVlbgQtTXc3BDm2EC40Y?=
 =?us-ascii?Q?NKPIULdY25WnLDBMYHHdk5yzxtTzRQniW+NF7Qt67o8G9cB/vvlOli5rH2j0?=
 =?us-ascii?Q?QS+DvW2gipyJ9u2HC8VyXBOCZ8oau1RFAZ2xdRTbZd0IfgtCXVhMZtaZ7aEY?=
 =?us-ascii?Q?UEOLZS/AONPwEsh0ttyNtblp59nYFL8R1kOOPuUDVOvVhJ6fwVBAb88EWxXc?=
 =?us-ascii?Q?b3nqms19Cr9+4np/Br3ZCIveg9rzz9HtWJa6KLohXqP9cgc8taifstc9Na/z?=
 =?us-ascii?Q?162t96jcO+fYnUXiHbiH1iChvsuYZ02jVnrMETtOibDzTKK56LXQU30BHOT9?=
 =?us-ascii?Q?SScC65b2oylEcGHfQdiGiKd5DYmcHAVFw3ZufrjFFhSp+pn9s0EH6+qBcOXl?=
 =?us-ascii?Q?P1M4+QLKGCz/wiRomx6LPaFxqCorleu1DpgmA74cnvxb/7r0BGkERTI2cAv6?=
 =?us-ascii?Q?zXBRjEijk+V/N8EgUe0GQfX0djGEafIC/jB2WBLrGH1XISqu72IZFtbPUuNA?=
 =?us-ascii?Q?otF8fXTUyOXSzvzg0MqwZgaOBr2Yf1cy7ZFBonoTrzEGQSgBtE/l4mJ55mFQ?=
 =?us-ascii?Q?dfGL2oC/UgI63M7Q+1VbgGst45n5XBph5VTDpastYXH6Kb3GK4c1mIuXHb9a?=
 =?us-ascii?Q?TNOyet71sAUyEzBvjDmIvbCWe5r68y+B4zORaO+KstuiBpeHFbrF/yATGm2A?=
 =?us-ascii?Q?gPHGgumQTWu9pUmyDq1cf8U/vLup1tnjwxjPzcTyPEyONGzOMcKERzlVFwdR?=
 =?us-ascii?Q?daNWo/FO0NkzbzToiHP6R444QsZLREnROF+/tW+ylE+qFAOrNIWBbE1Dr1Df?=
 =?us-ascii?Q?HAI2Ofgl/75+0kTD/f3kI8bdztLDU8az+CWWoJYrYE3aVYLSqImWGk5iMxQG?=
 =?us-ascii?Q?FahK8OU5wQW3qt8dzqmCzgp9BKvQ1f4lFxwWKDSqLGP7BEcO+GnL4RDV5FZK?=
 =?us-ascii?Q?I1W+c05SkKsVrpVTZPskIA54dqsTpDXvDaI1iqPFyRJhkph+5fQXWeJiK2Mj?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8VoibCwb5Hhy5c/gzwl/zLXlMPlXglLRl1No93OsUl8/ENcekDg0QSE9Z4aXAJzcLlJobLDJbgXyC9j5JV3V+wfunIGjyFRVkl+zmp4pSA14QjAHcuf0P8Dpr8GaUsNo17Web3n7AEtC5jk2kLN1IrtePCnD5w4aOyBEY3Vh8nNqpZEOTCfRhwBrh8SGpGCYX2/uMZdkWOr+7l5Bef8Yo/kPKIKtbe5gCAblsf+nLfJzc9NnRUdek6qcXu/KcaITE52tFYOkRE24z+v9QSAU+nyofhLq/lGs79jcJggQywVsZqCGZoeOXwvcICGrCo919ix0lcm7QvLhGvZYUfLRh6L4i//lvH9KzjpFNWdQPRVWNAiDeDx2raGrPwN1fTXziU4nLyHQDqX2p7YlDmkT2XIbCWnpdmRuzvyaykPRsk24uwx59IdjeCMpgy60VUtojk0Kj5L82ybtlnq0EWbm7Qb6p6EKI9NWqvs5AbUDhyem4ugQKBxc7f0QYcm/A4bQj1T+L1O46WlXOx5mtiZDMTbdw0Uaf6JP/dM/8vBhD0evgCf5trbTj2hFTK/pV8Ru/DMlU4txg6Zv0mogI8C+kgF83yv45RX5gXGapo4qTvEoyshluxJbuv1+MIiUTfk7OvLLEV2tWeOX60h8isodCX94YacZlEdairsc/1GYAdOrApjYwSWeQKi5Bvy8d+GEtCVh0rT2pmKCNCVH/eyJe3IkqRrtDmgN/0fpUlrJAemDSBIYxu2KxaO6Kw0+UNrQ9olFVSz9aD0Byhte8WwwiizLLbbaaJSe/9wE1rEi+9XRRr5oGdqISBN3IdRSiMjq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be843ba-b7b3-4bf8-ecca-08db719fec23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:06:28.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu3q+R9p8eJmb9BOD0Ni9amG5EF9CfQFaVNinlyb3fDoD+YpSIOAk5KOF8vCFl3fVKs5y8uaPyDKPkew/VqRX1fn8/EKVFh9tn5HmwzbNqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=765 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200136
X-Proofpoint-ORIG-GUID: IZzWNsQvylRnuVVO93JzNCvLMBcWPXkx
X-Proofpoint-GUID: IZzWNsQvylRnuVVO93JzNCvLMBcWPXkx
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> 1) Set a 64M limit as you've suggested in the past.  It seems more
> prudent to tune the value upward for the few devices that can actually
> handle a 2TiB discard rather than tune downward for the large
> majority.

This makes the assumption that smaller always equals faster. However,
some devices track allocations in very large units. And as a result,
sending smaller discards will result in *slower* performance for those
devices. In addition, for doings things like the full block device sweep
we do during mkfs, it is often imperative that we issue large sequential
ranges.

Please provide the VPD pages from the device in question.

-- 
Martin K. Petersen	Oracle Linux Engineering
