Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AC0CDB47E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjJLPGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjJLPGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 11:06:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A0AC4
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 08:06:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEO2I3027503;
        Thu, 12 Oct 2023 15:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=dTFwYf3e0E+A2UsQgHLyzd3loFWo8PRQrm3mXsc8cJE=;
 b=2OBI26F20pMJA1w2Yo5irpkOv6vHzYiP6hLC2FuIACtjS7EVG5I3tddOdvO5jS1WmYvm
 Dlgrwd90oSXe3GDzdFRCwmK95XjqmnUC0jNHLR7xv8pIUp8diBDf1Egw4Xn9pkFiC+Gi
 +JA6C5CyEmFWd9wRVr987WXVrd5q47P7KqqCmim0oitf0X1J2oFhKXLVHwEIKd1WOCgz
 +H1dw1rGLPmB7z/5EHH2IIrxT9kZIK4pH7s1kZ+K38QFZqgypkhrZmutKwwgrYA+zBC4
 jzuru7pdj1ISBbdqR2o040DjMeESLqV1TbSAs19d7ziBwfJqDjh4PmTSRNahrklGZYQg 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxub26g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXxrc006204;
        Thu, 12 Oct 2023 15:06:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsft6ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWB41dSZ95Tc56eBf3gGHAFEmfAHGlMMvOr+VPAuSqfB7iWeLCrdNQaSPKf8ufycNU9J3iNlf/NiTMxwER1k6qhb7jkL1Cd6AOJP43Ubsz5bFSe3Ub1D1iVrLljr/ewozgEy5h8tyhd/R9xj4TNz+B0Cz3HiVtMnw1LeGRCZRGJjCeRaPFwrfKB8MlOGpPD3zsz4wOrVLEuedveGNgym7qbxHlnjLCDXpaSuM8Sye6B2owwBWlvjDItaFlJH0GULEX1YrsFxUG+ETLeHfaAG2UhzwAbQsjutZNJDtdnvqS0m5ZVZivQZ2EZczJvIdzL212wR4+D1YdbGMklG4gDVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTFwYf3e0E+A2UsQgHLyzd3loFWo8PRQrm3mXsc8cJE=;
 b=GKUbsJDpQHWRe3znI3hD3Jj1wtuddVm5kTQEcIYRmX9o/YjAKGtIC0ROUqs+GIPUzi7SvVF0VjlML7Y63KXw+5yQP3w4aahx/V0gM7vKX3FsX3XvBt3SfIXG07UwjkQK66VAu09/ErOc01DGgTP2bW2Q4OyeBMBVzFsWJj5kCJuhyYjkkAOuHkXsR+sYOlfB87Jm20apVvYT3lrvwmj3dJ9FS8X/qVCRul8wEoa+21793yAjwHcVWmH0/NL6qkPaKRDT6swjpO2a5V1CLYTLT6J2LRk+Zu3cVLylm6wGiuqzAc05B5zjA7s4KzUnJvFQRQsGb+P2wnOPF2PO7BNn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTFwYf3e0E+A2UsQgHLyzd3loFWo8PRQrm3mXsc8cJE=;
 b=Q8Dc3RYbwOvRXknzYgJpa/LZnzTcLGGZvS+2Vd0jRs1n64peEiJmMoi4WNd5HtfSFiVQbeyM4LemrDb/GWtCT/+Ko9CbJTYK9s13Zb92UQH8K7yC6nvvS94GTV1nxIwfEgK7+bTg7mwir8mgomF8uGUXXApynKpNODZL9ONuM7c=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 15:06:03 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:06:03 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: [PATCH v2 0/2] ublk: Allow more than 64 ublk devices
Date:   Thu, 12 Oct 2023 10:05:58 -0500
Message-Id: <20231012150600.6198-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:8:54::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8324fcd8-1bc0-4e14-b320-08dbcb34c095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btWIi+iH467CxdOk4g2sAnlDwDW9JJSPLnGbgag7Ljr7P/G1+jvRn/9Nsv46OX3LaQAZ1ui6BVP6BINZHZ+Bf/F9FNkp76CL0tGXcUxUo7ZhgCUbd43/Ykqz6cGa5A7bqgpH3uFn/c+6XBmSe6jpRI3hsW1MXfC+CNVpooG4/NAwPu86Xl80vTQjs+Sf5tZEwD28jf9tWv3uUY9Oejawpo9uls2lWJDrncyc1phn0YSgoOoDxC+aBnXyUw0PqOyNkPJM1PSlxqyhC/cJjbMidyKCzMJPqE0/LyPkZsi+Vk5k6CvbWLp/3sHW/LoXBn0CuF4ivJIy5vqG1OCBXPb9A/Af5AQDeZ+UMBvXjSf0Q+UWptP41+zk6dqo75Bwi9ukPlB3X3A9L0l7UhnDVD/knbugFksRBuMt9BQB4u/7gXOCjhN4RIs09FThaXt5S9Y7/LfmcCeynJhi5SHzFoVE5OYZjX8ClX/lq0flpuGYvkYeIl/jwuaJyqffXsMdnQ1SrHdbrzM57P1qi5CTgWAymNHU/BL0XrneiL61KM4qBhy2FAP7cyWJ16VG3D12knwA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(2616005)(1076003)(6506007)(41300700001)(316002)(478600001)(4744005)(2906002)(5660300002)(8676002)(66556008)(6486002)(66946007)(8936002)(26005)(83380400001)(36756003)(66476007)(38100700002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvg+jQfPr6oiP9KpTT/d70vsK/kxO4dkhNveFNYpDDp6NXTv/04RWPL7r23J?=
 =?us-ascii?Q?t3j+hTXwIqGtRCxYYXDe9Icqjvn4DHVhebKGs92nOAdGTl9bSfJXSgY8IFOp?=
 =?us-ascii?Q?qNTBGq8AxuWVkAkiR6nfcFakBZabd+Miotd5XNCAIEdkbS7Dzw6aNcZySYR0?=
 =?us-ascii?Q?bzm9dhpVZs5L+LROBaUPhEh2t5DtzHLh4kt4DeImMEE7FrGXwvBL8uYnloki?=
 =?us-ascii?Q?xBQXjQCJi5nKBFdqs0zLusBYjs3gnBBSOj5hAcB81MtiTeDcdTDvAaFoPRtI?=
 =?us-ascii?Q?zYiohQpkCKeteDOiE6WMu2c6UD8pMOOVpf3KVacCqiODMS9qjmmSJf5cDuoM?=
 =?us-ascii?Q?xTtovhP4Pvb5rmOyLhdMGXGN7EFCTjbsVpBSHon1kK9Cb8uDN+eiXTIPu/YD?=
 =?us-ascii?Q?vpgZH1myx5mz/hX6E6VdeZePUmghDdGq17tLaFRJ5Ghjn5DNhx8TANP4wBPi?=
 =?us-ascii?Q?ARmC0zfQM1oJ000cx9O89Di5OS1zdO82EVqXNm2F9NPIszEcCoLnLsetfEID?=
 =?us-ascii?Q?cmW1OCUkyJwmSqJTEJn4tmdp6TRoeHE9Lsltor3Bv665fbgbvxKjsSIaMsxe?=
 =?us-ascii?Q?LSPCqXGqiQCGEA1N7t3OkUFEusA/jWymPWvA8uSwC9E59hqzGSkLAgZUsg+6?=
 =?us-ascii?Q?+ar8tVhYBN6wGj+n99J7KF0GxkApp1LAAA5eWuCiha08uzTub1Jc+DGNAItI?=
 =?us-ascii?Q?LSI2B22Sko23fCOGnzv+q7zkRGOQYNDmOCJcShItFud0GTl0Rg+5UmXBqF0O?=
 =?us-ascii?Q?X4tfOZh1N9yYTfSuKvHwdYF9NSrWlIX1OMRYPQHXPwQbOTgDk03FsmpK3e6G?=
 =?us-ascii?Q?Nzd/H7D0rFjm95jB+fmntDW9s+/UyNulzTNRZLZsA69vNbyBIL8M280XkrtL?=
 =?us-ascii?Q?kgjBsQZRE00yLnxz5VaxeZDKLVBj8Pf9J7vSby2tegJrvTkdUVkCxO3u++3Y?=
 =?us-ascii?Q?9RjqG5b/S9n8ZcG5MZ/WmaIn3hWXiSfbH7cwL835GyDeEK9T6ldniSHthV3Z?=
 =?us-ascii?Q?ZwPI56qxkxyXVTNS7NAoZcfLRvbDhBTk/sQdt96zW+LK0G1ZWSVXakoORYKa?=
 =?us-ascii?Q?g2TC0ughEYv6JUbvlUdAHMxV4QvIyfDlcmaE+zuBbCCptSGULnbmOMTELhhZ?=
 =?us-ascii?Q?xd1KhwRpMQWJJZtTzMbOE0uLhm8ncc6jARZ3PTr81EdgqYIYYgAuuCouFci/?=
 =?us-ascii?Q?FlyCXTaekCGMCnA/Ld74nq8H3IDz+XhuktGnqWecJ3svkAmiIyGset4k9zxv?=
 =?us-ascii?Q?Z7A//fnIOx8SE5wO6BGwrih4MnegDcuhtE91Qpyx0Oi7fX0uZ35zGJuuC6x7?=
 =?us-ascii?Q?aR+t+84K09yyCjnPJgIMj+4kLLKOAidhfNgawaFBwKQtPy7pG0sIsc0CGgaq?=
 =?us-ascii?Q?T8z926XgePIsX/H8YuzeX92lPt1NLCadrqTNh1imfC+8s/8LJtUtfSHUylH0?=
 =?us-ascii?Q?Jy23slnaIDsTUtO0hBtLbOxhxzn2e8RQRVtr10j9VlpZBKDU5E6Fbm441C4H?=
 =?us-ascii?Q?2tM0/78lOTZ2MAdrMQnq0GBr5N7GnuQW2pcFcem1j8Pb6dKMMj68uAuq7hZz?=
 =?us-ascii?Q?hA11kJZZEndKBmU6mX6G892rwzn4VrBT6KqmWt4XX2zZcNsm1mTCHDyB+Xu/?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h5Mp0IEHIoGDV91mONSYr6KgSgrgf2FOF9xTNOQj4DbVyRIRfAMlytlwOj2/dGt0zY2HaBz4B/2AuIsglvT6tgycTw6Di+PSirc5lo0Bba2MYJEDatSyMJUcWIAvq++FD04z3i2dmoNgsTWtRHzQeYipfu7HOfb48PRDe7clnM2ywBhqemoB404Mr2Jd/9UmtlKlfZnP5IO707jzsh4TPmvX0/amNDNidGUFAf1BnT7wXwZXbQKUkIazIYr6CFupDMXgDO8GrHWeTqELBYH+ae4Jsj1PvajDXGil+4MWeeS1xAKeXcge/Tjw5DQlF1oFSydMqRlraHUyscEsItzhE3+HNLrFKKjriEQNK6h1U2VuNjOekj+EDmgl7BhbUZMq+zeSX4Kzt+wE7Q725bqpxj3stl3SSB8Y9H1ezHBnnUWpdksnWi+pFJzljlGUV4vVfwUdauP0PuCvPRhG98MbObQIIGZ5OMIs+Y9cKrwRiPJMHMXPUtUDG0Zh1oLtoE9qBW9G/P+Znu/4Ml0ajyyk+kqqV774jCXMlgZ5KBtr8Nh7ZHVeev6jezsqQ5Fu1NakCxeTC60/f+nTFpFraNGDQlGwkpYp92YedAem8ojLBgPtdQjmsCX+9jBWJ3cF1U5DnzmrY7p5NQMOeOIHmEqKNAj0Zohxx9KDSwluj9I6h88+NKcTOqiOqO+7dsQccH++Ewp2eGMBq/LADxpIpJRb0S22Q/F3aIFXYJIMX7hV7i595Ux0/37tMdLCA3SfVMifckQTA8fu8kvyk1bII3qdI4/6nLRMScqIiLdE+LjmpUcmfK+RZ69UsAe3djh4cclz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8324fcd8-1bc0-4e14-b320-08dbcb34c095
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:06:03.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R84q7V1O4/OZgY6MBECI4nqH42+S7RkHCCnUuyUlir4/ZdOSrkC33JARo0ODc54ukckcPpbZl73MliQj2DnKDZwgycTsLUpGvB+F4nlrDhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=762 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120124
X-Proofpoint-GUID: 5lZTanzkbgp-A6ExWCeXJ9CAMyxvNHze
X-Proofpoint-ORIG-GUID: 5lZTanzkbgp-A6ExWCeXJ9CAMyxvNHze
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following patches were made over Linus's tree and also apply over
Jens's for-6.7/block and io_uring branches. They allow users to
configure the max number of ublk devices. We are currently converting
users from tcmu to ublk so the 64 device limit is too small, because we
have setups that have 512-1k devices.

V2:
- Set UBLK_MAX_UBLKS to UBLK_MINORS.
- Use param_set_uint_minmax.


