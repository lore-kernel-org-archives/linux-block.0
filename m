Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D3C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6297560F91
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 17:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhG0Rgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:36:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44602 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0Rgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 13:36:55 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RHQCU5019648;
        Tue, 27 Jul 2021 17:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mJH31yOyVJGx1dG08Wo6x0kFNJOXVLYRbB1OmuKwz5I=;
 b=0jl2i8M190UK6001+26sDmQmutX8dNIaS/bxvdwQPqubjc6ehmgLbLgj+dzEjzOR0k1V
 1eZ2GGdHZ9Y98c9JNFgpWJJnfqU+UVIfg+Yyy4PbP6AgXcOG9cU0UbL5jZ9IiydNLtGn
 ZlOVvUdQ2L8ki8F2zIEMgszJq0AdU9ZmoKqQfzvnhm81yXjBPebUYdnFJ+aKoalq8VFJ
 b3C/xpdIigZdjfZrAKFRRhHHqX3sE8Ro3+k5RCLOYiXqoxN4Vs6yHRjbIwYC78ne+rHX
 KNoULM9d7Y6x1Q2bgQxgb1BPiwVx2BiFaZ4dhFnuob9cu+sQZYk8REFFyMT/OeDM5/qv Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mJH31yOyVJGx1dG08Wo6x0kFNJOXVLYRbB1OmuKwz5I=;
 b=jchclfVf3GmnhW1fru9n/8Fz6RJPbP7PU1+PKiAamCaxddDIfO8/8JnSeAuXXubuf0a6
 GwimDeDC2DxzGyyFggTARGa4mL+8LsLr3OyXglIkhYjKSHNN2ZLFmzdN2pedV0bBLm8P
 zwm9wPAdNIBy14+8t01Zfv5d6JlZ4dE+yjBcOskTOcSuS35w093bsOU4aCBaTCtkkv2J
 POBKsWZdc97Qv1fvZIcUsbzb+LRyLNq6vjNHkDhfRjLw3/7yzxWj3pMbkOTEm6cJslgs
 ieQec4g3vU7MNGlybIE//bp89/SLja0G9z8B8uauebkulRMSA3p3h5N6C7MT5870tlih fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2358af2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:36:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RHVg4N080847;
        Tue, 27 Jul 2021 17:36:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3a234atkeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5nhETcAUoFkatLQ8nGM8smlrMwstRjN0ccRGMoK+zQ3gRe2/tuwEYbsTvcL1e28Jr8tC8+9PgKLUKhdCvX1a65vSTLKz8G2jCYr3o7J9puiHyuYyITvJ6qIqHCjlJ3Yw/AhtPx56Pc18o+YT+he3vFfsieOXbNC12lFvYimW2DFfDDhl1aGCfFEFM/004C/C1Ou+1xpepUzuZVMGhumEYKPvyaSX4fjy4yTl1jAdwGQyLlcL1j7FxJILHCP+Yw25IVzSTa4cwPJvxzdKjPeRcivmIdMnPQWOaRMOvNTOy3Hk23KI2GQRDL2JiQfD73+hIV62hff83VVE4pCOorafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJH31yOyVJGx1dG08Wo6x0kFNJOXVLYRbB1OmuKwz5I=;
 b=iFE0ek/xWkGbAnFQjkiGbCxkSw9ibZc5kj16bOuJI6M7bm9pX2gLvNxLQeOdvC9ucmDr9O6+qi6QtLD1X4LVwp8muZdeDrlt0FtwUndAZh17w6HL+9jDojPc5WF38iw4+aTRqvh3g56shJg4y+em5v61koBLyn52rIj/4t0nJE72F6BgAsxCNjOGZXmwLOwt8fkF19ToIZccxl1iIeQ9ToET+fA5MYtk8FCFuP34Zlml+8Q0U7axmPTVbI3ChOKcCEE08kgRixnE6//KVwGIDjxuuBg+yJ4cTKdjepmeJtGRhur1tyqDuk8PBa0mUatHxPx67Hbtxj7oCYFgSv/Qpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJH31yOyVJGx1dG08Wo6x0kFNJOXVLYRbB1OmuKwz5I=;
 b=0Ky6sOmV9T3T0OzSc61S/50gyFegtYtQvy6RsJFZlWqKvIXIKkQhjdF7Fjeg4EZ+GpGxMT6iU8CLMy+3AhpKWyzbcjBxXUVy5tvsxolH1wddDGisx8ueEm38XLuJtZgJ2btY8/gen/QzoGltPrjnUYzcIvkzwNS9fqiWd/WD9Cw=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5529.namprd10.prod.outlook.com (2603:10b6:510:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 17:36:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 17:36:48 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: remove disk_name()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1im0vpsnp.fsf@ca-mkp.ca.oracle.com>
References: <20210727062518.122108-1-hch@lst.de>
Date:   Tue, 27 Jul 2021 13:36:44 -0400
In-Reply-To: <20210727062518.122108-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 27 Jul 2021 08:25:12 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 17:36:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f5707b-5633-43b8-5cef-08d951251c29
X-MS-TrafficTypeDiagnostic: PH0PR10MB5529:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB55295229D688AC3A365EEA7C8EE99@PH0PR10MB5529.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/sXkNVUfpFAretgbPf/mhd6kUYpBMognAMRgMI+NC5kbD1N5BuN5aniJSiljwOxCUxD4kGGr91URP+CxTuLKRq7TMJHGxoMXp/HXK1RI+pEsyUffRjCk8AdS1UsJm/SVxvUrDeuI9OwSnME+KazLRWil2vE/ExQ/TQgslyXvL5VXog4oGwen/3l/Vhg8zFpkODXzDNLyv5nV1/mBSNWYqhUCtMgC90uYWtC8vRID/ouacAD8kx4d1WyBe+RqjSvVW3Ga4nxQnBy3H4GIsW9Oalr7tFdrUO61aRRuPPMW/XWGqxDzlDe1xbOar6971Q5Lkn1OkwaG3xHkAoS2mTdhUm8idGBV8pd+A5a8kB2Kifs6ZwHpAG7SLNljUAMGYKaA7pBlQyRw0l/A6IHa0Q3NPeCoefGS6/YODXEY/zCO2g6TxqCr+G+grVT5hytTQ+KPyP6/O0PW4+xb103k6IWTzS+ROfv590+xB7hFNWEr4ePoI5oB/v53+0ig9IXfYHS4ojpL2ESNTefFAOpARDIZZvkrqNoo18laQv9gfkRANayRYYArsHutSgGml0PLpQd6ZE10TEPc2Jzs44b2jY5OneR2W6piNVYRwi8Ru6zDEcwZ3neSjK4kAvVahYUchulrPAa9IATEodm+0tLbX3cnDZxytOxomJdk2qwL7Qm1NCAJFRsCZeoHerfLZnpGVpLBIcHD4zjhnLZbF8oFYLcvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(346002)(39860400002)(26005)(38100700002)(38350700002)(2906002)(316002)(558084003)(55016002)(6916009)(5660300002)(52116002)(7116003)(478600001)(86362001)(4326008)(66946007)(66556008)(66476007)(956004)(54906003)(8676002)(36916002)(186003)(7696005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfIBNJAUEtfhk+nm+jN8nyID+8kD84xcGeVXdlYlr0/DyAZqh6aFmZBy/yFo?=
 =?us-ascii?Q?eN3zN5my8wxjX7AqnJ3uiB8Or3OfjgJ2Kukl4AxMzF7bT7qahskga5/l4Oox?=
 =?us-ascii?Q?BVe2554ukd8reuqiZnYwVAQnMqSd7hcuOjYeUu1tQyfo9gn8IEq3fyNplv0F?=
 =?us-ascii?Q?G9hDut3KFotCKWKtgQLLd/j1M5WbkkH/MzILxUjSBhxzZ9fRWYdGA2OizYfv?=
 =?us-ascii?Q?cQkPT+0TW6AjiuwyWK5kdDcGG9JkLGkMzEQYJIuDSz+xokJeyrcX7Q5jgcgu?=
 =?us-ascii?Q?T5St0zbf98Eaml7plaK38xmKmZjrkZ5QOVrYwH9+sZGM5EAaiOqLPupy7Z2T?=
 =?us-ascii?Q?DkIzKINvM1tTpTVEiowG/KR0JiCuYouJ6PfpWjYPUEaf77zZrb4QZaMudGNo?=
 =?us-ascii?Q?Vgk84/1+U4tokM2hhiVSALaKOqLrhUrGxseRJ/sVIjvr699CGSSa5nu98DPz?=
 =?us-ascii?Q?sTMnBG8lIQCuDBuWixw7Rue/hK9odHB38sGs6oGxpdofztsqAsfzKtERzQe4?=
 =?us-ascii?Q?D3yz+fC2MUqFYBiQfEhAGAVMptSQgTU2xZcFUo0g82vdD04gieBLZbh0iHuw?=
 =?us-ascii?Q?eHjdhWL37bZjp1uwabnIml0yf2OoqLqbEOdf8otBNmXU+KOcsUT1Et3uZUrB?=
 =?us-ascii?Q?d3INM2pqmKhGDTqgLPs47VKeDw8nq3fnBCdKBU889wog3BjGqEs6LlCJbruu?=
 =?us-ascii?Q?8KqW82yjkQ2wlvkXDmx+T3IRTMe+BrjEcpEQINuZHe+zfcBpsr4UgTcFiY4z?=
 =?us-ascii?Q?tCUCVX3AV9vq2xicAY1vd+dVgA2tNdwspImkEPOEUEmWQbs8vPbjdHLPUvlh?=
 =?us-ascii?Q?fA4JmeWfYXYRZsZOUFk3ZOtdQAWlJ1uuJFpLrnGwed3uh4c1UGaVlwXGCmVU?=
 =?us-ascii?Q?lZ6cYmwI7EdcEUK7LkyntBjUN9++xwkSYXNDGluTuDpz6xVlCnCqJHX/VUUa?=
 =?us-ascii?Q?+voRr737PXFCfBNstOIjMNPjI5NR5r4x4CBd1fLorqbK6LiY2gXxflvU72Wu?=
 =?us-ascii?Q?UUXEXpO3nuOqQVkGH/Yyz1P8TkGWOQf3oTUDZf8MtfRbRTllG1PiTXplMBXF?=
 =?us-ascii?Q?cTQHZOOjvFlf+3lOSWgHUlu2N2wXqoHOw/cxr2B8n2GEoGe9Rt6Mh/ghkTlF?=
 =?us-ascii?Q?WEIbJkimq2mZTZ3byntz5kzIeZuq6sG09D6LH9akf7x6LWzxOHDQgb48Tk/S?=
 =?us-ascii?Q?S8NANWQEoQIopZkGKjolumTQMNduqn1r3+O1FJV5+V/UHUkvdSpCMeTvXIgj?=
 =?us-ascii?Q?DOef5IshCIhs792heeaZxqwm9LTnNpglcs5dEsi8HLOGxRD+2m4wdTnVfDwG?=
 =?us-ascii?Q?8hGB2ulCZDYeHOx8tJD2V/lL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f5707b-5633-43b8-5cef-08d951251c29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 17:36:47.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwV4wMtxnu8ZduTp70YUAI8qU6eFCV5l8wfuO198wqH/oPC9NSdSe4mbEO98sdGRa+fQxp1j4WNFHzegNEmaADJyjueIRocvAXif3RsL6ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5529
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270105
X-Proofpoint-GUID: Yq18xFhUP2f_rqeOj1zLQ5DVv5WbOlRt
X-Proofpoint-ORIG-GUID: Yq18xFhUP2f_rqeOj1zLQ5DVv5WbOlRt
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph,

> this series removes the obsolete disk_name helper in favor of using
> the %pg format specifier.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
