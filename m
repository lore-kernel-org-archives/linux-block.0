Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B220C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 02:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbiCPCeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbiCPCc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 22:32:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177536689
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:28:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FKiBDj018881;
        Wed, 16 Mar 2022 02:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6cmryh10PJUuzWv2iVRnvUmOjRijK7rxwPNRfwyp1iI=;
 b=lxJwK2zcDGW/J4cA7yWd6FoJbq+gqDjERCUYHQ/8mHH5z6ukQYI7bdpH/Qtxnu2y8zcf
 xB241Flythfffm0om7eRR1T1DwMemlO2F6dcEtg4GFViVQneIQoP/xaEo7DNMjH+y+78
 w1KC/efCeacGmk3DXuUk8TnrImnG7zbnRjXFdg4UF/XUOYAkkP+3Gs1dk0GxZX4JiGXO
 7krXgtsVm7l4djH9+XCzJ3vHnkfR7Dd6pnWglBEkUwD89JE6MHIskhkPUoI/UTMbShfX
 xR3spk0jp59ooLLArSSyhqTAvWIJyqPVUrvJh2rUTYeru8GzYdVBstJUSIqZMVL37lUP 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rmucy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 02:27:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G2QqNX136748;
        Wed, 16 Mar 2022 02:27:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3et65pspgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 02:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ7mhNnkWzukedWHCXnHAmrVYmegZJGlwGx7VeS+dvMXMNoPoZe+fAMCRv5A60cewTqeZDNmHiV7Jpd3LWB7x+kR2fem8m/pWaz3AtDrEtnhqVi48mKmjUAU5aSvOUEGTOPkSmemfaVrxdm88R/I79CoYGug1RIsJzs5HVEKLHcRNok/gN0k6nx2/zF2UehmotSFhE5QqFVrf0kCVxwE7BFgj+5w5z5OT/LLTKD83N7tbxDAmZCLLIh0rcRefzphLr/jPxnFEbraiTfglfMT6Vi23yow3Uadmm+GpqjxeKYCnad1t3GeRM9uqJPOuPXSBITRioJZnmT5Ax3amQXMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cmryh10PJUuzWv2iVRnvUmOjRijK7rxwPNRfwyp1iI=;
 b=UpXFua4nSy52YT7MRAlZZa5xKANVnP2v4f/uAUsrsmZxVJ0wgdnBGfpA0WGqCqrwNYtX5XnjrtoG+Z7u7g5QbIiMpRrs+kD2mQn/jIkzKj5PvSzoqW/knTtHl+VpqG98x1H2Ia+ghjUW4w/S67bm/XoF/nILO4W6XpQHIL3zeFyEds2lgNR2yZEttqfitArJh1EE0wp8Zj+HbHpXGztOfVmB2zbOc3/ISNoPe7EOoROoaxqvWps4cg9+wGIRuuDi2NmHIW7MFbM96QcfYXf3k/h5ItJgjHo4PyGJGQ9mEtPIHxrdVZJdfOGMjAfPB7GaszJFqAkE4auojuESag0N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cmryh10PJUuzWv2iVRnvUmOjRijK7rxwPNRfwyp1iI=;
 b=wA5fw2B4O3nszo1OU+MUCUi1s1DxMRWGHiZy7iECa1IUnJgNvM/omFxRZTOzrjaBzUOBqiCAkRy+oMpUNY31BJqXEVNOXQHMSFOGfFYqkmg73Qob11JNFtMh2/MiKAvGUrmvLhuLXYA4PUebs6McbewQYEMBFpRB9nGuLF6cD0g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1525.namprd10.prod.outlook.com (2603:10b6:903:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 02:27:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 02:27:35 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier@javigon.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
        <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
        <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
        <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
        <20220315132611.g5ert4tzuxgi7qd5@unifi>
        <20220315133052.GA12593@lst.de>
        <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
        <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
        <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
Date:   Tue, 15 Mar 2022 22:27:32 -0400
In-Reply-To: <YjEuAv/RNpF4GvsJ@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 15 Mar 2022 17:23:30 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5360ad36-db19-46f7-e262-08da06f4883c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1525:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1525473227BBF4A20E9C17E58E119@CY4PR10MB1525.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xelqJLwZCLwYfRNb9rT4nRA/5DjySmfl4te2QwddZw1xpxFCdXGvGP99H3URx8OIYq22uRP6f4i5pLcNYsiiFLieo5Ni2TchiHBc5P0bgucMmiHHT/Z3wPAquq3UGu580ezPZMhrW76rCQQPbCUZBV4ieol41gr5mbGuUh/zxGFTSx7EEUPeOM+gPumD4tX/WOtEigmnItkoW3Qa6TNBE6N+JU6qtWGsXWoUozd53n5JJier1da3ZfBoNnTJ36IMtn249wH/KiKQoEww3H2a4WpUd3+0Sbo8fl5bYMfnxaGJ+3BMIHez8P7hwIkI2jVdBomybBNdAgWfWAeRB/PrluYbvBcvlwOX+Fn/gMARSGJXnnXYmHLL4hxcsi/20cPN2uLFADDiyMOBpyjvN9Hdw2J48pysLkJOrIhSMQ7o4S2BH5m+gkw5/pazTNjcOc+Apd3jYF0ZhqjOL8ErdJACjh5AUE8NMAv9ZKLHBBUGKWpCH86WfEO7DFLjOSTiJOMtAli16TALa4MlFdERFjSnwTx290GojUQTUAivEYPt5CIK0a4vzKe7W063docug5q6YG8YOEDILWhVS77Ggm7q/0p9OucjFI2et/CRjN7ZoNefielLoRJaG6u+cFa9a/4JgzZPU7dKHOy6xnf6l8f/79f3CUEbS0euUl91RqLLkqCSHp6PIZDx49lF0PB7QpEeLjUWxvyDIvMqDnV5+q0ICg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(86362001)(52116002)(36916002)(83380400001)(26005)(186003)(508600001)(6486002)(38100700002)(38350700002)(6666004)(6512007)(6506007)(5660300002)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYlY/q+9DmFJTrqJgnuoT2ZtZ1yEhMdVxLeVmf26fKR54pQOtiCQ3wTSCq5A?=
 =?us-ascii?Q?QY2k5zjuOXn+rbfkShXJi17BBXqqvhE7mrWLTQPqr/iHRWG3F3x9r/G/CUcf?=
 =?us-ascii?Q?PkFk75gMmsC139CyvCehnWowLhnkQaOIHmtROFpRYUNrBQZs4HA59bMTgQzK?=
 =?us-ascii?Q?rtjmTRI5plNnibQQRGpcCjdESpIkNkyvNAgWSqJeBX336cISkl/udj33BO6A?=
 =?us-ascii?Q?0H1D/+kd6owE53oiJbk9Byt/vU26DbGuuQRbQVrbs/aXTrCvTkPU/a0iZkXS?=
 =?us-ascii?Q?WUzsxmGXN/JmVNoVO72KUrb3pMuOaSbyydBvreqT+Y/2KpdMjcxg9SLrahv8?=
 =?us-ascii?Q?1ctUpreiYSizBh2PeRcCU/Eh9Bt2y3tijLoM1DI6fqCaJLBKv7EzXnXxE+pJ?=
 =?us-ascii?Q?ZRhbS3yG5dEzXC5X/htHRHMkWc6C2e45CoHbBoZiFfT6LsVRzkNig6ZmDcMw?=
 =?us-ascii?Q?lNp5mU/gYtKF53lt+FC3m4vh+2GWIKbHjmg4EcSv8PFnwvMgxnOVzRbFEa6K?=
 =?us-ascii?Q?bO9pzEnXHqphmEykIOzYlmpsrKsq9m1RE0zdb4an2sq8egVAn2tRMg/aqX1T?=
 =?us-ascii?Q?gi6uITcshlSknWXx/ukJ4AFycb8qJYiEWTpO/uBvO1QLtAQWQG8flNnGRJ/B?=
 =?us-ascii?Q?jpvtjOM159YvgiUxraEg1/mNWo1LV6oqwc2qFCnC/cRw5xNgsKlxdDvEKjQJ?=
 =?us-ascii?Q?scb5nBzZUgr3VgDROqLPiFvZvw8bKNMPiLLIsRAufY/1dnFuvloPfaZjR4TY?=
 =?us-ascii?Q?ML0BEH/T3rFBt3tyi/48I6NIuB5j1m9D1FxzROQXcNnXBYW0LMK6B0Jh9ibJ?=
 =?us-ascii?Q?vFWmetYY3nHV0v/7GggKwx2ItBZ5BM7Bv4yz5YObTb5ONXIzeYp2jUsNxvGT?=
 =?us-ascii?Q?gU7XsM8GjmEAHV8KISMwjGwVYKCOev8FaiCgUXlJKCsthfgF3jg/hkq/R6lf?=
 =?us-ascii?Q?dMe/dc887ghab5UxZuvY7bPOHfCwBnwLxfMmfX+n9bpb/d0kqpzSr9ivD/A/?=
 =?us-ascii?Q?n9c9CVLLP4N7uhjJoz8fT4DHBUSUFYAccXsYIiFfrdgHyN1cOYfOrex3YD9C?=
 =?us-ascii?Q?2yUUZ108ZumQEx4nonLBcqMBn2KuQHpDFOIy8EAmLCtI7txpxSlqdfTcjP4/?=
 =?us-ascii?Q?cn2MgOjDk+t9kEK3DIuwjof1l4j1RrC6itLL5jr5XKR0PaMpBmwlc32rAhPg?=
 =?us-ascii?Q?poGd46ybCBFUlHgF5kP6vOESutrta8fRhOVkXRZuhjjavwi3HdAnXgl5ws6j?=
 =?us-ascii?Q?2WY8afSX7G8jXwsobHGb4S/YRvDRzn+VB6/O8N1KUfT839IcRGgwHKZj6lhP?=
 =?us-ascii?Q?g5b8KF2N+cPOVNxpgb5GFpBP2lOd/JzFNir7ysU6W8bkztd1F7Xbdjvx1Afy?=
 =?us-ascii?Q?rNpoyAq4G2hJyOujxnYOoUdqJpSeuhIggH92nopXgkE0QMXtqDA0k9mzDVJF?=
 =?us-ascii?Q?jLm5wU42mL6ol6Wf6j2u322M43MqTzfJJWE4khfMpG4Yk1v1QVyatw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5360ad36-db19-46f7-e262-08da06f4883c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 02:27:35.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GEilFpvg+8mguGPNNcmNF5/eSgywgd3gkWo+S0r7pWiAsQEiUpXbYouR1F4H1uqcMBtfAMx9+LVa5Uupqd45+yVMC5vVkxCOWzTjJzjgts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1525
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=862 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160013
X-Proofpoint-ORIG-GUID: HwnHk09J-hjbMg_hnf5seO8Lq_kCwSfC
X-Proofpoint-GUID: HwnHk09J-hjbMg_hnf5seO8Lq_kCwSfC
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Luis,

> Applications which want to support ZNS have to take into consideration
> that NPO2 is posisble and there existing users of that world today.

Every time a new technology comes along vendors inevitably introduce
first gen devices that are implemented with little consideration for the
OS stacks they need to work with. This has happened for pretty much
every technology I have been involved with over the years. So the fact
that NPO2 devices exist is no argument. There are tons of devices out
there that Linux does not support and never will.

In early engagements SSD drive vendors proposed all sorts of weird NPO2
block sizes and alignments that it was argued were *incontestable*
requirements for building NAND devices. And yet a generation or two
later every SSD transparently handled 512-byte or 4096-byte logical
blocks just fine. Imagine if we had re-engineered the entire I/O stack
to accommodate these awful designs?

Similarly, many proponents suggested oddball NPO2 sizes for SMR
zones. And yet the market very quickly settled on PO2 once things
started shipping in volume.

Simplicity and long term maintainability of the kernel should always
take precedence as far as I'm concerned.

-- 
Martin K. Petersen	Oracle Linux Engineering
