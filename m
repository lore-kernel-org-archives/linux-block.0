Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059DFC4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 16:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiLVQIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiLVQIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 11:08:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C9924946
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 08:08:01 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMFfXiA032462;
        Thu, 22 Dec 2022 16:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kFbIi6B7aNz2/viEeFabomEhOFg86Nl4UiDgAMIOIm8=;
 b=2FYAMW8iykXHJBcbZC7iFy85OP+kFunjYAlRAXkaLLocXkQsAX3U/DoEwzKSuB9pBj4y
 bXKtxpui53tGmBHEZPnehv9bRFhZB0vEd+mFFY0534vJiLnxEQI0FPTRX/iOCj4apvdh
 lpJDbtdgUOK/wdEnAJIG5005164dMYi7pw8rKw+iGOsZexZpZ43UTZEInmcp9LE7NdQv
 6R6IzazR40SGwlKiHbEapUdr1eGRx3RZLpqxsJbzAYKcM0vnLPBJmN4tzt/3IYRFPZB8
 maFC+6ZQ+hGF9+CiTUlWvHpNzBF1HzlLCfrHY9HC0oF9okQ8nRvmOGGrwvvHmHyI5VC1 Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpbyak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 16:07:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMFhhnC030361;
        Thu, 22 Dec 2022 16:07:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh478cqb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 16:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgXkpvNaT6woFC2vKaD10IYOlHgtKb1+5LXMbNvPS5ibJ6/5f50D+h9ACDxyaAUB31uuLadK6sQPj9HFspLGSwlbGHMLQvQpi8ahxTE6wCa55majumX6lzSyD4n7OAELFUIb2R2RM3ivdRPKt28t3qkDMVWiqDJVr40Wbd90NZ9keTCno8Wj8e4LNVpB3ZA6pO3bhzjVkum+HOOWCdHSeu++EWFQ6zdNts55gDMK+IjCJDs7+xpWsokHN9/CuPLHvN4R1uYzy+29VJP+bBfMuhVGZwqRUmKq6uyfi/8RCyysCBzexNhKwgFj8kfyJjYuPRrt+vwxPHLUecz4dZr0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFbIi6B7aNz2/viEeFabomEhOFg86Nl4UiDgAMIOIm8=;
 b=Tu3HCZTMFeyQV6gjY873MuIWyX3v0DRMr3ns5ZqUCOm7r8EA1+8yyhTlsVNQUMfmsd9sqoeZmLP2n5/DaEbG7c+fAzePuqzDqk1Y5e2BKKW6mK/1pbgYA3BvZ8wkngsQmQH1k1s/haAHgc5uQscwgHjJ1xyyaqSURfxTSeeweKhaO5O99dAQJQFECwP8DqGRpbK8nkdomQ1LJ9dLend42maKqWd7T46Z9qwELHTdYeDKNzvXZwWPlZ0xkRpc3+TLbX1Wh1lqy8bmp+D43I/wuv/I62LggHbsjfBjYk08BWM9yfSVQ1ICIiKmvvuKCTDeUFy1KjMC/qHpNNLTq5DbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFbIi6B7aNz2/viEeFabomEhOFg86Nl4UiDgAMIOIm8=;
 b=EDVPuLv6kKXKsWq5Eq8SYHStUvPCrCAbMOI2RO9P1KggsOz7aBiG1d9Mpn90J9oimBC8w7eTJ0PxWNUmlfnikaFoTuwSv2kiTgN+y1bX+CS7Dx0KlaoWsxdXOkugLmm3t+0ieiFcZOWGkJGW6+YHHqom3TqRw8Fyvxu3CkjPOtk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 16:07:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 16:07:27 +0000
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
        Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com
Subject: Re: [PATCH] block: save user max_sectors limit
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ili3bf5n.fsf@ca-mkp.ca.oracle.com>
References: <20221221162758.407742-1-kbusch@meta.com>
        <202212221657.yQawgPsu-lkp@intel.com> <20221222084011.GA12920@lst.de>
        <Y6R6geqKfvV5/jBU@kbusch-mbp.dhcp.thefacebook.com>
Date:   Thu, 22 Dec 2022 11:07:24 -0500
In-Reply-To: <Y6R6geqKfvV5/jBU@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
        message of "Thu, 22 Dec 2022 08:40:49 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:806:125::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: ca85744f-efe8-4825-279a-08dae4369f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULAqFM0wvL5cno+nOrn94PYFJoxiB98YBQWzY9LOy/Zrwds5sz3a+K0w08gouMcCTqynoA15BumioUXTkWLvdoC8p6c299suBoTqhvYmB/Rrhn0BW3oM2gMnmlvLzvEPFRlBcd6FeNyJNsiqGGUZUbas5yHCndAoLByIKoQO5v1Thc/XkH8HuFOJM7JMahITv0yVUj7DZEfs/J8NkDwQujC8q+Lwk5Jk/YD4sbonjaZiJrDYWGJ9iZDD8nTd8Sx5ZA1NPnAzbqGlBqqHf4mpvShlZCRiuxLHVjJ8IK6vjbhCdluGNGqsW+MXbwm04oYslz9XzBFzG+7m/p8XARHXTBE0sT192rhI4huGeWyPanRcQWTM/mRPW6oH5pRKx7d1gGU4yg3mWL/0IV4FeBqfosXDDaSiFjHKJPoMeirnZc80MhoGj2jPYjEhxNMBnL5lg9O9xpCmfeXoU10mU0cnG/WaQEmRxj/OHKpfInrQbI11vxIQeXDmIO9xZlyZipcSWWtVfpit/hgyhLvdzRWzPSw7XiO1Va6OpI+66oXNeSS6t8zq/L1NIKXt1qnQOj4loALKuJDJkcLT0bq7jyQbLhIKbo/Ade9PQv/k6MsaboLUakS78E6XlgQsUGnEKD9Y5LWBzJsRqdfzY3YHg1IqzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(478600001)(4326008)(66946007)(36916002)(6486002)(8676002)(66476007)(41300700001)(66556008)(316002)(54906003)(83380400001)(26005)(107886003)(186003)(6506007)(38100700002)(6666004)(6916009)(6512007)(86362001)(5660300002)(4744005)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QijE+ov7Im1G5Nhz2O+8JegVAx+RFRPN9jQBMos+xRW6HfJM2mqBhbwe+fbY?=
 =?us-ascii?Q?XPuu6yIlfNyfVwTOB4tGNwtFXc62wiTjgdkBado5KXNZtnVO42oHV837kPM7?=
 =?us-ascii?Q?4QpHa6thnYHcf6JK6k1JhrRt+95TM4joe1EbouuxgTfsv84Z7oqlTZc+0Lkg?=
 =?us-ascii?Q?zs1EPecbPnToIquuFj/ADQlsTnCXVuWauLKN+swgS92g8ZPpMDgY9VvM4Qby?=
 =?us-ascii?Q?KaY/TaLRHVI0o6Uh++wqgoF3VkFNq8T8VnuYX9lvBlbJJy3TlQnXDWfaBslR?=
 =?us-ascii?Q?YLX1UZVb+L+icA6CTxEutLueLM39APGDzvFSXBPZp/qCp+oM1MSSSbjPfowE?=
 =?us-ascii?Q?C50EML7ggmKllJjlco2tALZBoJoFyHfi5ht+YJvdbCvPDFjx+uSOumAWXoog?=
 =?us-ascii?Q?kcLRVMkelF0kzjtPeQDeG6R2g6P/4j3/4G0totWE71LOQWeGeesKLbHIufyL?=
 =?us-ascii?Q?MCkOAhoJi2iAEE0KAnimeAPjRIBpurWJoMzM3aeOsUjwdS9yeeGF3rqhEafH?=
 =?us-ascii?Q?flFVPn6DO4yvHxF36tWyoRIurSBJdhSE1+dzxFcvFaUK+fpE4bCgSzsnNJSM?=
 =?us-ascii?Q?qlNbb4jFke9JaFnOhzoLZFsPqqHZdG0uve3sMQAUFezBuiBsUmT7VfhPgNkX?=
 =?us-ascii?Q?J497AE+hewew+IXTcmTjhOD2v50bE9NTY9Cia1ivirwedTLHLm0zIwW/i4uC?=
 =?us-ascii?Q?/O2NSgnvyDugaLoTueS5ChCA4+sgcQg8MWfkRVC9zKIAgWeUpsEwH3jFehBg?=
 =?us-ascii?Q?DRnZ62W1ui/LRmCa+Rd//A1TlLAPZkADtA1of7ywSB84k2HwvXENuyOc4Hjj?=
 =?us-ascii?Q?9oQS44dS9Emv/kPU+zmZSqkHjIxmaGACWZmmaUNLHWRARMAylDx9KAJCfj70?=
 =?us-ascii?Q?A4D4eBf4GYSvo7UJaPLgGZTIpD/w16hsGBbfoYz2l/P+mRTJXFMOz9IyJ22h?=
 =?us-ascii?Q?O702u5ZdR4GBtPf8JUAjJnJBDdA+l1uCDM36mbUbcmjopAFqLQzxivWt+m03?=
 =?us-ascii?Q?qZQgTk6x0ltFJg4iekSoxTtC4LG/ZRV/Vj3veo7eu/1iSamkK7KCZShbh/RO?=
 =?us-ascii?Q?zblpYdEIzXHG+y6kFzf0VLPfLPQgEXc+MRdG7xHqy7Egpl+o7fc2Xhq7ePDW?=
 =?us-ascii?Q?JFRtjKhx08JFBq0E20Ef+VYkV2TNiSHfAg+oAEAdKtmlcYX7LCVvEbc2OD1i?=
 =?us-ascii?Q?4lRr/BHpJiW9mTl1jl8VHDMkkfu2vllWUCSl5JllTfJdcTGh65dvVxNqSBa+?=
 =?us-ascii?Q?GN2vRh8HjRkeQCybSXwfztyQKSHk1YL7pRPTYYe2St5cxamX3EDxZj6cg/rk?=
 =?us-ascii?Q?GvbW2fisi89EzP4ZdfR+LcX7kM2i3KpebxB1sQzITdttcCA5l8Pnf32tHkx4?=
 =?us-ascii?Q?98r2ewFj+Vhw+IlM3uYEYVortMAcf+lPOb8skyXA9dSykFxCyG2U3eYW0sxZ?=
 =?us-ascii?Q?DsJRWt3PZwh5WpMVdX0JW8u5O06UtGDQ7O6L7cZBWNNIjrsYKs/6aW/l/Uhl?=
 =?us-ascii?Q?PrjySCC15HBgKSERtjwt6ODNomxTaA8C9ASdR3kuZuXMGuSa2D6uo7NttBih?=
 =?us-ascii?Q?+iBrYzJWDEKFOS4WDpCp+j6IqxkuTh+uli38N8fKw6wBI96AcN1qfIa7b3pZ?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca85744f-efe8-4825-279a-08dae4369f1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 16:07:27.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du6rwx6SQ4vXb3XCLMejpgTvc+cdfqz2uydJ6hJg7cXEdJk1mMYJNSwsswITvU2M2nXaXMC4WoVm/t8nHTWs8Q7yjG+IpxPr/Wo7Jxd/pMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_09,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=911
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220137
X-Proofpoint-GUID: qWxlQ1jGmJZf0yA1QrGZ3sg0jiwJNMa9
X-Proofpoint-ORIG-GUID: qWxlQ1jGmJZf0yA1QrGZ3sg0jiwJNMa9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> But thinking on this again, we probably want to respect the user
> setting even if it's lower than the default too, not just if its
> larger. I believe that will require a new queue limit to save that
> value.

Yeah, I have struggled with the same problem for various user parameter
overrides in SCSI. Lowering defaults or detected values is fairly
common.

-- 
Martin K. Petersen	Oracle Linux Engineering
