Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF6C0015E
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 01:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGTB6k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 21:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTB6j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 21:58:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEA1FE9
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 18:58:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOZRd027286;
        Thu, 20 Jul 2023 01:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8eeqlHZSxdOsWD4UjCAsViMAhwUKBJi2wyf6Lw1Crng=;
 b=Et8Hx15t02aZsPzB/4UKNwsfBPQ9EoaZRZ1xBYJD1bZ3cBtVTGc0AOepnMkvNffS6mTG
 iJwkdSCS/2b6NiTvzu3BznP3SfX+ui8ly88ouj5AP/N9jtt+xRKR1oMuKCryOy3V4oR8
 62mmQYg8Bgb4eW6VXFN25tO8cIzLWlr16js+G9uW+bL7Lo4UakDCU+Kj12N/loocWu7H
 3l+XT/18Y4vD1wKz/g/VSGTycNH+lywChkSS5G+oBCkN/9p9mnoGACbpTqWnY/SN3Dzu
 GflBJ9/X0c459wl9b1G+wHaTByoLe4W9LhpGvT+Uxj7tB5E73upxBCAwccPGTnwxIVfm 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run788kx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 01:58:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K0mNbb017349;
        Thu, 20 Jul 2023 01:58:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7takp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 01:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBtLo2dtqKmK+CYvsctp6GVELwDCqHYeov5gut/SbFxmYH0OcJlMcASRxCvmiz6mNZ55DJ3var+JX8XABa3Dst7f4A/Srig9l0q9PcZ9XxD6K+KO5nwU4mPxHQkc5dMNYxQBj6v5CbmpBBA2FgW4DTsjzRt2ivm/laZCTMc2su1JRh79zwzmk9sbnZxr3o29HUgXOmPigM7RC8qtHJeLCBbPUPIggMY3A2IWvf0LJDT6rOsZhMUJ2pMH7Skz04tFk+jO9uEGPENjYOcnWtVKqLSXlosNYWCGq6Pdqu3QxKqCe5NV9Y2K4FdXIo2yTNzNGf9Sm7J1x+MJ4qpHi/U3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eeqlHZSxdOsWD4UjCAsViMAhwUKBJi2wyf6Lw1Crng=;
 b=Vo+oaSx+tMCqroo7ON8NRIbm/5s+o1TPYGfJFya0H0zmhXherb/HxcYtnBcUKpfCzn4sorOTtrXxI19XzX9H3J6J+44tabyXBKNWFDNI1gICIMaukm4tp/iaJBaG/gkhqOVE39En4uuSOp2yStABZErKKbhGl44BqDDOm7/7VtIdgFJCa0Lq60T+4+KEy7bimUlRIYtAPfoVSX8aVX9zTQydyCXsKjZt/35/5eS0rph6bSpjEYe+jzj4VKhHcwBHK0jbL72Xvein2mqBvFn3irMT3qcZ12+fZ3ZVwCZMqECn2C16eCT2JqD4C7MqoyhiIzkRbTheBR02EQnVJ2dUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eeqlHZSxdOsWD4UjCAsViMAhwUKBJi2wyf6Lw1Crng=;
 b=XNQd8mqmrkkC3kg+PTDA1AhzWduEb5JJY18XIFHbyQX1wWB75JKYd03Ar1Je+DmeCGXO6d+kVskCZy+hPbkC+a4UIn1PoiHiCElxIyRtg3or/q/xnCVJqb+Lr9/tR4tXAYvw4gtrhbEwGJQT84Vy5ZNQOtJrHG6bCaMkoH/TyG0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN0PR10MB6007.namprd10.prod.outlook.com (2603:10b6:208:3c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 01:58:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 01:58:30 +0000
To:     John Pittman <jpittman@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk,
        djeffery@redhat.com, loberman@redhat.com, emilne@redhat.com,
        minlei@redhat.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com, Mike Snitzer <msnitzer@redhat.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lefb8iev.fsf@ca-mkp.ca.oracle.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
        <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
        <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com>
        <yq1edm6rxgy.fsf@ca-mkp.ca.oracle.com>
        <CA+RJvhwaEnj0Yk3MW75+nQsOjVFEQQxCj2DcO2EQ-jpCL_ec-g@mail.gmail.com>
Date:   Wed, 19 Jul 2023 21:58:28 -0400
In-Reply-To: <CA+RJvhwaEnj0Yk3MW75+nQsOjVFEQQxCj2DcO2EQ-jpCL_ec-g@mail.gmail.com>
        (John Pittman's message of "Fri, 14 Jul 2023 13:15:19 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0016.prod.exchangelabs.com (2603:10b6:805:b6::29)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN0PR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 09467bbe-0391-43d0-ec8b-08db88c4d110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKQB1ywEIbMUICKTgPZ7IcRLawHIRajJFlU3WH1tojyBLdC+UetmmKWR4geiy+AmE5JIxrL/Fh/qkUjb2oi8pdQ34F/p5kDuw591OXBr/cZqPqYzlM8aV0OvnNq8b/S/zWCQx08ZEGOTmDNAylaqtrGoY1qR2vB1gwYZDPliZyWPqxKAlMbp7os1W/GF8ElkK23gsyM4Rk+OJ2PJZXvPL20xeV7YcK2To/JEv49auy90I7M3iGWYzTXnqL0cEohMuVf2B/75G2Go2sSjI6KdEinYo0b/QlEayQ7UWxJTDBrxLost1XxFmz6WDocN5LDqNZjGiGNaLT98m1x7fT+Mman9TiOFvU7wOMMtAghkP61ahPaEePJs6iOfOiovBexeG6HnG21n/7A6Ot6iZYYHuoqm5FqrXqJgSObgaNM1l2ngskWid9rxlUFwJX467O7eTvJFDocADGLuI9LPalRSy+rdvBcU6bRh66G+79e6QDHBXxGQgXvbYichcu+2uQbbb3RyNj5Fau8sfYSQ+0ztdMBgmaVNkrsA8h+OOOSZRLchmKnYL0OgWNkJ/quZF2Gy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(41300700001)(6506007)(26005)(186003)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(6916009)(8936002)(5660300002)(8676002)(6512007)(6486002)(36916002)(54906003)(2906002)(4744005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DH/b0p4hCLGXM+nINjeA5P4LgGMOW4NVhFlJF1X7fNXyNivVp3XkRBwMsCGv?=
 =?us-ascii?Q?PE1QrRZpqeXKjPp55qw9xjxw6TwjNzgCEdoljqh9RLMxeN07bs+dLhdFjk09?=
 =?us-ascii?Q?qHYTGgGBTC0E8dyFI8wPxdUqX5C64kJJ0LV3h44YQdB10g5FF2MJeeNMPg9w?=
 =?us-ascii?Q?+/V3QLATLeXMb9qZiyWqX5vTOSQR923Q5lrhQcuKxBPeAy9b8sv7UEjqv5E2?=
 =?us-ascii?Q?MtECvHx//Osz3E196Vn4/lG6D2bAuqiNGd1t9PIHfKwp1dALOCOJn01R15uf?=
 =?us-ascii?Q?vEkZ5NWKFDNCCKZc1KKlObFAlOZ2lWQrDdsex2clO/RpydDTNSTfNnr5pjBi?=
 =?us-ascii?Q?xRLxLjfSgIw1Fi2toCc9U7eGkWqFyDZtIregb9D1pE+2zF/Q2YKrftnc72My?=
 =?us-ascii?Q?PN5DFb2dTS3ExRLKYbfVk95UGyrH9w9/zkGJDzOiIVU3pa9a6ROSoh22c/6Z?=
 =?us-ascii?Q?lwGvdKjAVKUjgxW3IQD42h7kbgqdxsWJ8qyYfXP20r28gPKVMOOiCiZ+5yEe?=
 =?us-ascii?Q?rc+YyLE86IWekWcO0pzI6TJavBYKoMqo+7wpMzqi2srhxiMaQAcKYSGdGGUo?=
 =?us-ascii?Q?rivVATHLU1TNcQjy5Q/QuKHQzkKyMeiokTwJQSoX9i2B/Q/Pc7wE9OSI3OFc?=
 =?us-ascii?Q?GI+Mku1dVPw0YLwy8enonDkuI1E585sbj25nvvL5oDsQwFXgOwz1s22xa9xm?=
 =?us-ascii?Q?ldIy2VtGRwFFBn4U/K/YAXQvkxYwlsWSjiTtCaqvOMdCp5I9K3PdekqNYCiI?=
 =?us-ascii?Q?uSFrUPe6PtZd/MVpzYcub6z3jZgwHgQ+Uf5ricwRYxnkk9J3GkkmwMySEc0B?=
 =?us-ascii?Q?KfFFR633gJhihvidqV+pIQeEjuYIr+3MJvvSLoemuXTpkK+53fevGXP0Wg3L?=
 =?us-ascii?Q?vqLqoNjaWCDNCMfQv8of8ZjBPKxr9tcvtr5FGL8KDD94w0cpxxTACFnTMFpL?=
 =?us-ascii?Q?8o7lCLstTJPmtU1QhC+DmQygaQoIK2YBUdlL8YEjt6iiMhLlZLECwkKQT1tG?=
 =?us-ascii?Q?3sM1OAGA81RFcEvkuf7koRWZDGwkrm4qs8H59zgt5J1zm15855GUJoY0+s3P?=
 =?us-ascii?Q?lNmrr2a8p3oSX624Shj/cEENQDxureR2J0YKFxARnezppjQzQxZVJEfn/XDm?=
 =?us-ascii?Q?TNo1j5Ob5ImqCuqHMRTXulPpWY6UdEGCt+Kdreqghzd8rVu7ENvMoHreJJ24?=
 =?us-ascii?Q?T/QU6KT+RAsYiCvn6y1YcKZtWzsPvVJqtqDCeA2v4dGMjQYuk9vaRWZ3MFqQ?=
 =?us-ascii?Q?+fG8O6GERv0yTkooRTTUp5egl/HSmv8AqpRVSZN1XTJy71jU0/0YW2EyGs/Q?=
 =?us-ascii?Q?XGP1S6mE6rCFiSvJtNEvcBHzojZWkFBdfWMNMIcYXccUPu70zP8ZaIHG/7V3?=
 =?us-ascii?Q?lmyIcf5XvsWW6PIKmdyANTcW9VAldO02v7I1xpRW5Gc96ZGZhDqBvT8T0XBT?=
 =?us-ascii?Q?OywALZgutqkBf2GZ/wkNHoDH9FznTjAEuLKy3goRinpjhMC5kEv+ZV8QM2Y5?=
 =?us-ascii?Q?BLyxhne+P/ChKREX07dXZxplJLiGXoEkJNqla1Hu2svXa+1EPKpPxS+6VQM1?=
 =?us-ascii?Q?HKCUJCTO7yKeRtjGV7FDV9HaZ28KdnIkoRKKCADYwE3/UaErhzko/nqOmERG?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 07j4q5wMTAiYIcvwB61m29nckLqw3KlFHdEUMtAfMu02Rl3hkQ4vZ1R+N2UwZ5ryE/DvyV7hivFzoDFN63i4UvUVh243MfTe3Fkw0H2wIq6+BDsMyCaps8omywBliJ5YRfFLJy2ysDh+X2Fft2xmKx7GK/C44EOF9kIBtoScKIh9fgPFJRhAkJadHJHmczNsGtYzKJSssvmFEdAWrIamn7Fo5ZlTYL3/Zp8o+u0RAIRLs3qMtIHBcpGvWYy7lMZw0q6+ym5lSI4FjEAFrzgCT/h5tcC/euHyWBLZp5y6Upy1S2SpQtjkFf+a32ViVHKRsg7Xi32djZG3PyvbqJLDMmdjwAPcQuPI//xwWAxq6Ea2jzOpSVLHYClbrLQ+8xxY1CI7nCw1d8rBpw5LjTBPSZBY39YQLr4IOXK8pE+qZHHyzuLpdwSoXVo6SFZBQS+USE2MmpV4cvXdOWNFJBFlWV4sMmMWYBlAqOYxpoqK8nbQjaGc1VbMcs4IQ0imMf7r997IULGOZ/wV4UglTyZVhGYKy7/JDgCTI4iGKvnXs7WEVWBKaSiGvI2svUmiml06QIUOmF6GREY7dH2xY3nWAL8KgsxRIBACXB146mfF2FaYE6A5xtvE+sbpgBaSpK3fnxRwb+R6SSAAOmCdA5iqlb4A/MSIkWYlwxpohV672Oh5/wdkF+uNF72GXJ06Db/NTEzx0kBnlY4iMClORWT+yQcGE8s7r7KueCiNhrznrsA3hb4ix8UQ/abKglPdE2KMbN7kWyHz2+xwSHcXLzlj9PERe1Dh7Ia7ponT0+FDAhpnRt93FsgYxamsYH4N7R/Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09467bbe-0391-43d0-ec8b-08db88c4d110
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 01:58:30.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyS8L8+UgaRIu51T4p1z2KuCMui5sjU0DhlCKcE14C+Lgr1fFnikiEVraC/OeOjW3FCn11i6Nef1IoKbeyY/r/a+Memz87WVaViFoM1aoGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=937
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200014
X-Proofpoint-ORIG-GUID: SWcVQnsgJQcROjOalkPbk0wXKNiThwOU
X-Proofpoint-GUID: SWcVQnsgJQcROjOalkPbk0wXKNiThwOU
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> Sorry for the wait; it took a while for the user to respond. They
> don't have scsi devs but rather nvme devs. The sg_vpd command failed
> b/c there was no bl page available. I asked them to provide the
> supported vpd pages that are there. I do have some nvme data though
> from a sosreport. I'll send you that in a separate email.

The device vendor should be fixing their firmware to report a suitable
set of DMRL/DMRSL/DMSL values which align with the expected performance
of the device.

-- 
Martin K. Petersen	Oracle Linux Engineering
