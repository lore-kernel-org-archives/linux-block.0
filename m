Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70AC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCTXnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCTXnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:43:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBA38EB0
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:42:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KM4aGE031278;
        Mon, 20 Mar 2023 23:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=t/0tmd53D6VWWLVIFk842eLb6vzw6vfAFWHuAHexQCQ=;
 b=U0X8eRweerqev52WIhKtNwWHMPldBkcFv1G6i8JTetxYAnkoIkWvhVL5mMce+hv7/Y5n
 +HtHdrX43j1PbyZx59XSjOPCwe1Jo3s/1TP1opi+UN+iEGTkqRmwJwodx4dfbFv34ICG
 w0eVuv2ktlBN3mS3iJ6p1/hsx4/7+2SfKBhX4fmNrErbrKhYjL2eO8fJEa/o41yWBbyD
 OxoFx0huYNacYOZv+5QV5mQZVxmSkH/gCzpIdxpp4dykx7iXusOjFH/2xIT3rw+ar0Tj
 QclmEhAzGYFVvDXeqHmMi1Q5RB7UWK1BLrdh5dD936GSuFRfArW68uj5WdkDUT4+aZvp gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56avpub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 23:40:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KN56Yk015418;
        Mon, 20 Mar 2023 23:40:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5fyaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 23:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRZfIn9lBHO46MXEnnAxsez2yoNOWtIJ1VRBmY90kY3BM8nciOlIjkGaE5TW5GdfJyi23GVX0mMOqU0sRjy47rakuboUz2SBAlvV1MgyIMnuwe4e6fUjPMBQQOoobFZrj1srJtbbBrSAh4+tDIYNnkKtceEtDtdIeNc5qLLPEKIK7WoUMklR0fm1rR+vzRKGdZT1TyQoc2s0oQPnExgJx40XrIyR6tb/pe1i/ULUBocNYJ2fTL/CoxjyJYiTLuFA57qpdpgf6cSltwYtDZMACvlKAAjNttVCOInE52aOemaE8gqYIPw8GNTrnq7jA2rZd9QOMXftpsPH/W5NEv6pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/0tmd53D6VWWLVIFk842eLb6vzw6vfAFWHuAHexQCQ=;
 b=BgOnfQLYtJ4cwQY9k5PVe/Y3z0iaHg8G5F45PEHOjhq7EyIvXy71Zfc9qmJIOAIijpRSVhtbzSqqroaXiXJw+K8VIiACZol19ToqgIlGwYJLhY9uphlEWv3AyDr+uUBT89RZywH7XlhT4ZCjmeWRhDz8WxnE8aFpDZG8J762trf4IN4s4AqmijMxR41HlgWt0U3pxXQkhsf/WnFzRcwxo/Sahjy3tf4L8BiZ7JnUkrtfY3ybb43AFsoXPL8X6lpKvPFRTPupOC3ixQ1XjYyJmGMdxouULadvIfkxHWtWov7e/LmnZIXCBoOCi/Bu6YTDTcBurtImx3KKQs4i25sH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/0tmd53D6VWWLVIFk842eLb6vzw6vfAFWHuAHexQCQ=;
 b=jwHNbyNl/QMahdzCIj5NIC752g1VRhmU+w0n+An9M3cTD9guSRyVhOQ8c85AallUTko2lvI7XGL2Fz8L1epB0GpW1RH0ms6VH+U7P0OIwLMfrVlXGZSYzWqjIyl6qu2In979vuqfOArZy1hgKzAzNIDofq5B9fMkyvHVsiD8fzE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 23:40:49 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 23:40:49 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH 3/5] brd: make sector size configurable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rfrt3gp.fsf@ca-mkp.ca.oracle.com>
References: <20230306120127.21375-1-hare@suse.de>
        <20230306120127.21375-4-hare@suse.de>
        <ZAlOqMMKWhyIzmlN@bombadil.infradead.org>
        <ZBjjlLTxWIp9rY7J@bombadil.infradead.org>
Date:   Mon, 20 Mar 2023 19:40:44 -0400
In-Reply-To: <ZBjjlLTxWIp9rY7J@bombadil.infradead.org> (Luis Chamberlain's
        message of "Mon, 20 Mar 2023 15:52:04 -0700")
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f1cede-063c-41ce-3456-08db299c8919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAuV8RT0YcLG71+6wvV6YK0fanLBiEoW8qbhaziV/eZdx3nXv1t+5lycNdefEaJvKajtnKRngkxyEH47fyZcLQ05E++JAW9JvH+0OYmLgqpTaGfqakG3xAw7umBb1bZsQmaoc9ULubmumyeb/eXJXHpuAtb3aFuKFc3eS8ng1V8hzdakdpCEjVwKW316e6aClfFuEZTYz/tXrvu4oVUlEAOVv/gaTarK9Ou/NIxRLI7GoyJSGSmEZPcB2/u+uBKXB5hMlc0gcXBgvuQ3BDvznSt9gIde0dStHksL1jubZNqq86bWJ45fypZMmzVzqw0utkG39hvs5tmIej6Xlc339GGHsLolaBBVTC2a+TVYQRjCy8EIAQWCci9iIBgTadAVDOFjLh+Hk6re9EuAqW6H9fd4ycboJ14ePWaggv1ZTJf3CfdNBQ3J4L/qbnmc3RDF2lz75YplStn9yNYejpD6LH4QwfPXX1XJzxgqsA0mjymRjzeNrs5+bQmzv6G0upo0vt4uOwBEGwpCPO2fJZdpcKZat8zawpPJkDaEIgigUJVaA/wQIiRA6FTy+dK8L3E45t6XYh+WOBstDteB4+MU92Zd56msDuMK0c7w4FtzfBPCnhZtM8BJTDXrTXO9dkz4duX8FmOuT0Luyu++OZHTQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(6506007)(186003)(6512007)(26005)(36916002)(6486002)(54906003)(316002)(83380400001)(6666004)(478600001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(4744005)(5660300002)(7416002)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKCv7ATIQdLYS4H4BuSlus5A5b8KRt9mx8gJ/0GDrLosfYI/3jMwxSibcWBz?=
 =?us-ascii?Q?3x+NlXrKgnEgxPHgFBZC0I/pypumAf7eChPzfdJ5LayAuZMrM/5kReYs/iC9?=
 =?us-ascii?Q?GLTLenWsDvNzDUHNbLYfta9w3WJVGh5i+3vpmskT7qUlUDquV7fFMqK9Cr6X?=
 =?us-ascii?Q?sYqHgYodl+btLs4ZygnQKHH9PiSpKkCppxkHr5me4Lna1S+BbzKXKemLai+O?=
 =?us-ascii?Q?qTelTN+g/IlCXq1qq+0CYSGw9aDhLnyH5lXhqnr2WX+Mfk43cQ6YmBPqkmtH?=
 =?us-ascii?Q?uJk7ihYwt/kstAfBHCHyDAZCU2Y2EazwDtUnbz46m4pbbZPkUnVkJ/RFXT6J?=
 =?us-ascii?Q?/8MGD681Sq9PnirB9W+XBlA+hvPIv2eYMxYoOEXeeCTD+U3BGhI63Imoob4J?=
 =?us-ascii?Q?0eULD662/BZ9RQNnlpjRtIK/NJq22UDdgM/dNtTl301YHcqjgigEEsu47Nze?=
 =?us-ascii?Q?aapkKllpoZWqZOUb9akZF8+M7FYjwUHIq2vDDMG6jPOYzXQ+NwIl/V9AMffQ?=
 =?us-ascii?Q?BxUotQFh3WjYj7mOCL0EbuQf5pg91+1vNEw17hTapze/PPyyVaeg0aIdtrEF?=
 =?us-ascii?Q?HnI3b/mmrwBGFc/pu1DMN/LRuId2idwcFnA2X5L4itiarL9qqMgs2Eb5uvmQ?=
 =?us-ascii?Q?O0FVRRCTaQ0mND3xxmnRFGLTltSkdV5C4YR5p5V2J439r5HkW1I1haMHhbOC?=
 =?us-ascii?Q?48syjd+u9/Wvriu7szuN0F50pLhh9j1LLJCjrNvFR9OkSi5OmqPRZUxuAR1N?=
 =?us-ascii?Q?WhA5IiYKyH2de9Qw2J0xuhcr2yTj2j8+Glk3X2Fapa17cUlQKqVqHCbTiYJM?=
 =?us-ascii?Q?NN2g50FKTpFNR31xWHUyhztzV3FD7zDoYvuwM9xHQIYl53T2jAS/fA8cPpaw?=
 =?us-ascii?Q?wwJEJXR2u9CVIYizjCeL8a3e6Bo9OG2imqy+MLiC8hClgfTDCmEpMQset0so?=
 =?us-ascii?Q?QeVFdY8iiyJXSp1935VwENB1haAVcZGBu0/Jyb00ejJShYWUXDEgKMIsI6FZ?=
 =?us-ascii?Q?z2UzXl3oP16MbHfGuzCbQ7Io3fXU7KdcCRBYv/xA/C53P60NoiVqiDGZ+Uyb?=
 =?us-ascii?Q?5k6zXzbL3T5siPoS5WD5JplShQ81GActbSrwSjMWHXdMEohu0T63/aIa4zo/?=
 =?us-ascii?Q?7taJUV2UxxoDVAqstWonEA0btwT/MHbSAfFj/XugpmwnipjKfSrRlmvBXJZL?=
 =?us-ascii?Q?FHU4eun2NgpzVDeX9SbWx9hGFhq3+0qR8QB6MrSvdv0bwN1Kc9QP4BY1jJ7v?=
 =?us-ascii?Q?6vl3CVwu9hhzJVPynmCYDvhlln9It1gsfivUISwSiOYxAPmMs4l4nQ84LnR9?=
 =?us-ascii?Q?+mOvSLJx2Fb9ux5s43PSulI8lGvfMhp0XAmG7qoDUPOU+QMo3iziveH2CJw8?=
 =?us-ascii?Q?C5UnSB2v2xGNlgzlu+AuediGV6HguGTJgJF/OC53GOX0r2vytNxeq4Ycuuab?=
 =?us-ascii?Q?VFv0snShT8lNyqHf7+paBtJruik8I7sOOfjIgbLXWabjKpuytZK6Jd8MYgav?=
 =?us-ascii?Q?DDXbB1JdjWJSBIkPzC3xYTHEdBV2Lsa5x7AisKFaY71pNEXKsndfp2rkk7K8?=
 =?us-ascii?Q?YlKfL9e4Fgq8Tx05mla5udkhfNEuRHvAKQu+D8YNOKYO1DsJN9jagrVLv3OD?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?z8lw3xBA+RMsqcF014zjYCuCHPLOAw8s8L1hDAqUSZogEuDJxiKEu82592DN?=
 =?us-ascii?Q?m5zTNx50nlKfGLHiBAMLda+LHagRRXuFHx8mjb/cI4PqONXyNcvDkxRxMYNe?=
 =?us-ascii?Q?kdjUcMkyBYUjebZoH6TjJD0Xn2pjAtQhda5Llig4g5YPwZY7ZdfOO5r6J+kX?=
 =?us-ascii?Q?iJ4tnsTyIFhHwV/Z95l+WVHhQC44Vkc7ZgHrWALE9VxXaetzxMEQSTIqYJL3?=
 =?us-ascii?Q?vJ5qO+GWCu50Kf7ht682987iiJnj5pP4ojYyLhPaanL9yV3LZDjmb1pJGI22?=
 =?us-ascii?Q?6SG3sXlFF4I0uBo/MYIxHcfWpN+/xY5Q4GyJevpfnz5hKw4NoH+2zHLiIzCb?=
 =?us-ascii?Q?m1b3aeMed0WECaDHwhv9DbIsHtJFLLEqLfvvjxwduiOSN7sOQX2j+omp9Eme?=
 =?us-ascii?Q?cHO7tPXwxraILEZD5qpm51vn9oYxHRZClvwugIg+BrobEkCi3EA8FwurXmVy?=
 =?us-ascii?Q?Uo+wTfitSlscdqV+Hj19tiZtgcvtiBvLIdNARAD4ZLJxB+BqBg6XkA6Q/xLJ?=
 =?us-ascii?Q?bIXyGPd3Yj9vTBAeNe9cvhinQkzuF/KEyGAsHrOoyCII+Llcs8f1iK7iohYr?=
 =?us-ascii?Q?Vc1+G3lKzhDN4QoqCtkxK36yTCD3u7KOHT2QFo8x0RdagK5w1bM0MBcuOlYC?=
 =?us-ascii?Q?QdkMk7GxibXPymvVRh99sukuZH3pCRbWpV0eTeKDNpE1nQd9oWGrMSOKZGG9?=
 =?us-ascii?Q?xzjHiqFcx7Rt/OrpODLw17eOsjUKbG7N2pJfwm5sOFmyg8EIHhVZid8RfJcM?=
 =?us-ascii?Q?0gvGeLWcXsl7XBjl48DspiqZIJB9B3VqvVp6jgK7i8NHvJb+3fORMyWZNd+4?=
 =?us-ascii?Q?P5b/6cqJQZ1dkVnEbIEt9ovfY2VxLCt7le1J49nQ1DcDQdrTLglrfveytZG0?=
 =?us-ascii?Q?3hrfQVn5nnWdPTsgxxH/UlhnZcp6qDTE27tkvl4CNE44njlvgnGlj5whzBuG?=
 =?us-ascii?Q?TZyN7b/amL7HnggcqqHW3IAxigqex1sou6/zXo3NlEPktsgeTyiMEqTWdJe1?=
 =?us-ascii?Q?NqtJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f1cede-063c-41ce-3456-08db299c8919
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 23:40:49.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoC2tnKM329izHnhChS/rAohRM0QGkrwYI+hNEVUtercgw3xAPD0eI/6QPrADtwsRGRYJz/Nhb3hjmaYMhqEHfy+elgIselazG+WoEHEUss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200199
X-Proofpoint-ORIG-GUID: HUclDmTWMJbhzs-dBTzH2XY0WY7CH6O3
X-Proofpoint-GUID: HUclDmTWMJbhzs-dBTzH2XY0WY7CH6O3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Luis,

> /sys/block/<disk>/queue/minimum_io_size
>
> The documentation suggests " For disk drives this is often the
> physical block size."
>
> /sys/block/<disk>/queue/optimal_io_size
>
> The documentation suggests this is "This is rarely reported for disk
> drives."

min_io and opt_io are used to key mkfs.xfs' sunit/swidth. So if you're
using a hardware RAID, MD, or DM, we'll attempt to align allocations on
stripe boundaries.

Back when that "rarely reported" blurb was written (2009), we did not
have any individual disk drives which reported min_io/opt_io. Reporting
those parameters was mostly a storage array thing. These days it's
fairly common for both disk drives and SSDs to fill out these fields.

> From my review of xfs's mkfs is we essentially use the physical block
> size as a default sector size if set, otherwise we use the device's
> logical block size if set otherwise xfsprog's default and so 4096.

Yep.

-- 
Martin K. Petersen	Oracle Linux Engineering
