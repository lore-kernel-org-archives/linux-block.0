Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6DDC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 03:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E6E613B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 03:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbhDFDte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 23:49:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbhDFDte (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 23:49:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1363U30X141284;
        Tue, 6 Apr 2021 03:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=k3WCEIRdv92v+6PoXZ7EaN8S8cMO9UDv2SuQe6a4UO8=;
 b=av5N/ydh0gri+YbNcy+gvCuSkSYqhnC2qY32wgNvj0q0vvV3gHsXfUl54B0sAAF8vsZI
 n/q5fK55nHRrkJEdp6MKe+QExj2fFw/W4fRKdN0jSSddwCuLoiyLkJhmvPqjLb6RlY/t
 ZWesNxsD2SKfenRx06yt0vrKAi0dW3Cdf0QySVG+4X4lpEGSkZOwUu86WS72y/kPCquy
 qfMRZ+z0Mo9wON+/7T96udZMfRbOZbHfE6GIIWXfm7gQZra16Fje5+hZh3n7+CfXR9KG
 6xW4+CFSjrgsaTmzoiFddOKF5LCfHVVw/RbjBAuPKmfCCqH3j7p77gbVNR+v5OoWiXIJ vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37q3f2by0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 03:49:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1363VFkE167372;
        Tue, 6 Apr 2021 03:49:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 37q2px031r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 03:49:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+U9CUBdYB8IC3umqAP+aF9qZXxUqe9EzpUO5uNS/O+SWbtuHQ9kZiZBXavVMVKdQegomfK7YvendR1WwZwBnfRvYY+vrhOJx5HBKtZxEKiFsV55xE50dhUOfruTBV4f71HreqsqY/thJusapxPjGEPucZemgeuSDVOdCgLCHfidS9ESnGcpKAy5WZceEtk1uLSpKoemlqhBn8JZeVoNYD5gb56Q1aIT01OaXaCtgCnrE7YdAAemjsxgybDqfZkSvwzSEmvO8SqOo0aH3youPwFvPcWUWbNz2lY6WWgIlRUkrrq9K1S5J2aAei3qvyU+ZJlIstFGhf1dP3431Tg9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3WCEIRdv92v+6PoXZ7EaN8S8cMO9UDv2SuQe6a4UO8=;
 b=l09X3vA+aFd33msPGRWQXADam+tj06X2eZa6zsX2JhxFfhgekB4oD3gViVvKkhWjlgPCMzrIs3Vv33oGaKWDay/ODBN0yoipK6X09VhnWpHzJFnNgmwhsnNa6oFckDjdKWz5YD5onF0IoJrUABFR5BE/W4Gc9YIIMbl1gWnffVMFfwYJBbGYX3ujria2ucMlPACw6QVhX+KQntotUQrtrXXTFZ1t3oDe3b34qCdSlJ1KBWdJ/i/3W8ESbl1yXlDyU0X3+UcPNTT10j2iLEVZh/y9BoC3fqWt99i4ob3pzUK5ijr4cF+baNi/eOM3ar0AactXiHRSfAR8XC1c0HPl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3WCEIRdv92v+6PoXZ7EaN8S8cMO9UDv2SuQe6a4UO8=;
 b=nF7gk9DopPQiJV7ljP770FqkV3zMwWk/XgigF7nNNsbcs3Lau3HfgFsphAL2BcZrCOwkeGMLDN4I1vIqI1HWbXXf5QM/685LSkwAe8mbJRR6fvT5GrT1EiXF3zPw0w0WNT7PPEuBG+f+7b90u6APOlCZawgRPOiAXK8j6nBNyME=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4790.namprd10.prod.outlook.com (2603:10b6:510:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 03:49:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 03:49:05 +0000
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of
 hctx shared tagset
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k0pgcbvk.fsf@ca-mkp.ca.oracle.com>
References: <20210406031933.767228-1-ming.lei@redhat.com>
Date:   Mon, 05 Apr 2021 23:49:02 -0400
In-Reply-To: <20210406031933.767228-1-ming.lei@redhat.com> (Ming Lei's message
        of "Tue, 6 Apr 2021 11:19:33 +0800")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 03:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf49b582-2bf7-4f33-43b2-08d8f8aeecde
X-MS-TrafficTypeDiagnostic: PH0PR10MB4790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4790C939FC5A6873A73F65DC8E769@PH0PR10MB4790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7iDAaRtsUGjbDDK846yxXRt9wNIycVdjCNnvjDSkaP7m+bfcIU+tG0ZNsSMGvh//tAyA9P0e9X2k5wvjrkbq9liA5fnRMHKr51eW7vYHS9MjnX1vCx+0ye+jT38VHsiHPdiXJ8D6077iHfWl44t0O6HfInOQExrOnkpsEznFVGL6laP9t7M5+87RhoJBFiBHRLR9qa4REeMLzZA2EHywEU3bX1rXjpNl1kvtWbRq9ta3ujMPSzXtQhFPdsjzniZrr4bxpiwngP2L91G4wxCnVkdBnjIi4rPvlsHzYkzFv5xu4IqpQb3DcH7FTh83h6M1FV8HALP3+gniHp3QHAvDewT5pFtEvQFYriqNOsuBLJrSa78YFHClFu/yhnzNQYqRyQ2FhLa+Hbf4VfmH96aIfekFBYSla3xn75S+5ROeGIpwu5SGEE4Sod1DZBlbXB6RY3xo8nQLUvCy++7Iw1cV2eQLORWa36YlU+s8sUCXOoOWR5BixnCALTX82gTof4sxfhEfug24oPudsp2lpYUWsepwh84bf4sauormAEDbCQtdumfxU9yhI94qk6P8GK5HDtW8/pqjLQ572/fAN98I97CoAmSgURRP894E9Mg4rF5cFs0K+atSPSDAOLOclkyRaEJwbr/3NfX/k1WJsGdyFAVL/YkTuwi7zNDcXuv/KOl5WS2Nik4gWOS81lIJEVP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(4326008)(4744005)(5660300002)(8676002)(8936002)(6666004)(38100700001)(26005)(86362001)(186003)(16526019)(66476007)(66946007)(66556008)(316002)(478600001)(38350700001)(6916009)(2906002)(36916002)(7696005)(52116002)(956004)(54906003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TZG/3gWsyO2Otnmp2BzwdtP1JdWQvdDsZJicK0aRUXns3jzF+x20KSF0OyDm?=
 =?us-ascii?Q?U+ARdYjK+iw1148HZbtTJwKxSa+NiLUtMlMh2pasaJJmtPiUSnAJl5HScZb+?=
 =?us-ascii?Q?JoaeQekBpOLhlozCzaggqu1ht9PlVxMjszUSAhjSpLoYzPcmM7TWz9p0TxRY?=
 =?us-ascii?Q?ESlJ+KL9QJ0soegYTaQ9ZE0xQOCrqFeRxJnw2kw3KxZqA2S2LhBb0J22Be7I?=
 =?us-ascii?Q?Jukp/LHYEm0/bbqmMBMVj7LNo+58Q2+0WcP+Jj9Y5p9w0y4LhJHAu833qoK3?=
 =?us-ascii?Q?cCmhvFMbo9b7bvLI8/Hwns4mWszSiw0lhvP2K4XOZllp1UOFrIMuij6vt5qI?=
 =?us-ascii?Q?cpT5dy5bOewWZe1O/96qUTKwXIE+kqLT9G5qsAfISaFoFSn4MJn7yNbhuiYF?=
 =?us-ascii?Q?J4Ctc99+lo7931vrOQEfwuwwkqLWLV4UVuEGQY29pjfLOEGFh5ZDM/Ab26Ku?=
 =?us-ascii?Q?yFLAgwYvqUOiwad5kR5L1bQpCI/auhYg/S84190JlB6F9uCJUkkt4iEcxnum?=
 =?us-ascii?Q?0m+IiVyjPmJfG6PbbmRRluFtuClQQxQm4JZ5y7DJelsUfzuWBNKC/D5QbMNu?=
 =?us-ascii?Q?yezfmgmAzqj3eWj4mclafGW9zHKivs8LC1ofZAcyOFQysVf613d1CCkY98Ue?=
 =?us-ascii?Q?V2ItWwI6avZ4yAm4FeEWYiS5mC77/vDQz3Ct6wECFEAlH5zig2Kh7rGVsKpA?=
 =?us-ascii?Q?iHW5w57RmxjB5w9cavIYSaXfOGyIjpuJIBpzHaPxfXDqv5MW0R5Xr6mRK9G/?=
 =?us-ascii?Q?PZ9XnU/r3YJhTtWHS1KZtyU/UfVlg9T00WTqZsCTPI9C0PZCJ0FOgBlFAtcK?=
 =?us-ascii?Q?7aaWkrmqGeQ6rmdyjEVgbDl28xvp16RVEBqHUWrpCn1JUXiZSoc/eZvSKdb9?=
 =?us-ascii?Q?cqTy0G0faiQL/dGwTb/P3Rjf06XVE3E5mDdJDuEhEdHg9FOGwsUfSZPoptvQ?=
 =?us-ascii?Q?mUHfg+OE8/+WSOrsZArgwcACFL9OJinI45ieDSYyEbkaf2ZH2RX1Lilr91mJ?=
 =?us-ascii?Q?TCxsAYRkeaRYAjipTyGj3Ca5gOfavmYp1Q9CBwvr4t3Kk0IZkz8UNo/KhRxW?=
 =?us-ascii?Q?+OR7QIV/f4G/GHCkjfo6rud55Au8TtrzJE4o+Gt+Dcyga8ZGKLgi8+ATiJfb?=
 =?us-ascii?Q?6tzrWbUnb8LGhfq4ZB0WAjQ2a/TzmGKrwTq/u4vYMK0R4eVgLJIPzuptX+tq?=
 =?us-ascii?Q?Z0f03B6OfKbVQ/8xKbBFRgSl8unVCLRvITkeBfuZH9vWw2Th4lxIWNvrcmhb?=
 =?us-ascii?Q?SfhvsFMQWASVmLdsDd1x0b3Lr36lpC0z0umFat2QO4vLp9/Cg5apW+4oC0O7?=
 =?us-ascii?Q?krVK5OwbU4Fn92gRQg4upwUM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf49b582-2bf7-4f33-43b2-08d8f8aeecde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 03:49:05.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVe7nsl83Db3DhrCBfUXw8Ak3miRxta/gYhf2HwWzU1BqMA+xN6t6+1jySa2qeLhYpK45Vy72PECGCTENJUKzS0EujvcXh7Ak/VgZue6lLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4790
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060021
X-Proofpoint-GUID: _APQ5mllZ_xfm1plrXfhdJGsIiC-cFBJ
X-Proofpoint-ORIG-GUID: _APQ5mllZ_xfm1plrXfhdJGsIiC-cFBJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060021
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> Given more scsi HBAs will apply hctx shared tagset, and the similar
> performance exists for them too.
>
> So keep previous behavior by still using default mq-deadline for
> queues which apply hctx shared tagset, just like before.

Seems sensible to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
