Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC9DC38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ1KOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJ1KOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 06:14:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9C1B2B8F
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 03:13:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S9YuPB021116;
        Fri, 28 Oct 2022 10:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=uYgU8G5wwACLAo5denYtxurCLIWtybYNpx20zLUJq+w=;
 b=rCBIX+ZcgNx0tP8Trds36wPXD76K7jWXLV0qW//b8n1Pzae9RiNgsEuvlq8HxwuxiaaU
 /6NTvtgYWZP9lBIrKafKTzmnhPEryXOMEOJvubPR52YV6Gv4Ipchx7Od9wN3L49iYVmG
 OyviWo8QEc3/PBhA5FKORSeDKh5CNoh6RV8rkvkLzoUpR58PTduGN7HBaTtd1eG5G7zd
 PEVDUBL4VqCKnRShyDOetcxhqkHDCIKJ1l2ZsBPqFXNVliS8PktHRpGKGdNwmJa56fNu
 mw3aIr/YJ5JLMTOZJ5VSesCiJWZWiWvDxA4UaJx//iTCMxVwckZZ8O4BZJ2OL8fcoBCr yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv4r15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 10:13:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S6tPds009439;
        Fri, 28 Oct 2022 10:13:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfww71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 10:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxhTl96NUbSyXj75Vaz0Ux+LERFNuQUU/Zl4jFr/IgNYgXkH3GI2u9T9e0xyD/RVO7Yc1CYVUxpEuLYp8WvMOmf5JahXTLkMaRnFO27eIYl19+8vGR6tSyFSKtipOGFA0wo+lGw8ipgLlKpvHm++6YVp8dPadpUkJDlY74ETULOyUeJlGxNDfnP3osX0uEhKHojTaVri2QNj5JLlmSrKasFxUEPtWlQGifltc5OUVnxp6vOzJzi8zRHR4tOMFsdsDQaV5PoEiAA/2+5xMjqttnsBLXcZMs5n+X8dfUOc8HgW3OOtGoE+yubAf/TEvpcqUvnRxoZDw/txa+Ri5d5BWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYgU8G5wwACLAo5denYtxurCLIWtybYNpx20zLUJq+w=;
 b=feMNASFEk7Jj0gY98X0AyGo+P8BXtkexCEEl+llAbhHCd0A16bhmTMnyfxxxle5lcQ4Jsg+J3+zHDzxrjXJG82vwzhOEiLw9BqyAsSWQr9IVm+r60KSZHakjFDt7rg0O2aGOV3mEJsJKFdpXBn5UTe45FISqlEXkb7kkpMo2K5xD5GBZH9GF0aCee39bzUuSad0leNQIEdn8D1BZ45cBFVdoqFv3yqgmiiuWDnpsUsoxkVC9owVxphm7EmvqA4MJXKGIagRirMYx77ibVSYj0M6xb83Zn0y/Qhsa3fOtx86M7kur/hFMSrXYBpV9ly+sJSH5KMkLcD/GjrDcXop2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYgU8G5wwACLAo5denYtxurCLIWtybYNpx20zLUJq+w=;
 b=iC6cmfuNnqfNwnYbl5FYLdv08hnCSr11AvRXWSqaGRwKa/sOsOMfC5jMf8sL0jRyiVR2wwH1vGiQxgLp0dDzHLFHb7KypJ905zuoK34pE/VjNvnPjCMI02yXI0JmtZzXhps37vk56V6KYBDQAyk6sLj3D2oZlW6+jNCb5AObh1U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH8PR10MB6624.namprd10.prod.outlook.com
 (2603:10b6:510:220::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 10:13:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 10:13:54 +0000
Date:   Fri, 28 Oct 2022 13:13:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     asml.silence@gmail.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] block/bio: add pcpu caching for non-polling bio_put
Message-ID: <Y1urWKutpJW9tqFK@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH8PR10MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: d63da628-4082-4b6a-df18-08dab8cd1e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blp3QVC4vq9PIDKRsqasaIVtVbnZGSyF3clyIrxxA4MBDAKjCx6JSXGu5ZMb9Rq1ZwPVYHVKMsTLFG5y8epZ2rWiC+6n8aqE/bcPSDrd9qh810b9Cu59gTpj3bBKRy4PNjAMuKT/aKJ/TjWbWCBP+1IH9O9R4EQBcwsC3f1TbwLP7pHGdHEDHfP5R1JEEOffwHJvtwTODI89uEKas9MMgIrWGC6LQC8JEVF9bKECTAW5vaDmA+MVsmdlSjRx5jKduJZ5SkkK1eOmdsNKWJm4vYKJ+vJxbf8ULbPSiE4rWxZj/hfjG1RptL7fXOYnkTacgG7RCJGaoU8+9D7zbmfa+0iXbvHS8oMU+m7r84y3bwQ844iAGYpaDQHpSBVOpztwo4EISWoKD6+1TCk5pEkHQ63zB31AI+oTRKGpxg27hBWBmzoEarI6qriH840Z5lPF/lWVwrspC7o/L6yLkP7fZHA66GuYTwOz27KUY2oM9IvZcXNTw7AQgObVGssoVYdPIFjU/Tia/pRsuGP9J8AENgaiRr3Jk5iNwe4okTJuZNiuiBDw8PUiWA560Kxw1Widfep1pyDU1Znp/Ac8433DWkgPQMQoeSNhMR0clIibUX69fT3ciddQJgR0pvDPKe0fobRjr5ybdnmi75PspTD5FvSgcEmNAe+M7WNhT3+ucmsSCm/OHDS/cMBN2gJLulFi7cIwQTMOBnM4CS/FcgJR7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(2906002)(86362001)(33716001)(38100700002)(66476007)(8676002)(4326008)(83380400001)(186003)(9686003)(6512007)(6666004)(6506007)(44832011)(41300700001)(6486002)(66556008)(66946007)(8936002)(6916009)(478600001)(26005)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENCJVKr00GlNgt42X6KuWKh3w/UzY2eNm8vDtUWQaAymfz+EFMFujxldiwIk?=
 =?us-ascii?Q?nUgqr2WGa97d2l+UxIflRYbMbMPszVUF/0EmuteTjmpIGWAI0msbzK3DeykQ?=
 =?us-ascii?Q?GGVyQkjmZ6D/4T7taIp95bRjdaS5xKYgxuMMopMr7ZTpa9ochzLojed6lo3c?=
 =?us-ascii?Q?i3oB0RKJX/s5JlP00VgzEZUyZBv75xPCdpO0Qxy9V2xHVK9ZbIuWQKSv9eqK?=
 =?us-ascii?Q?eFRC/PaZV/4crq7/cfWUrk6geZeTrQKp0V0FVc3DIdHY9flIGhPi7/lbQzwB?=
 =?us-ascii?Q?6oyTo+gYjGJf4uv1A8GLQHWM8SmjYeCwxWhjOO//T1QnHBxGzlTvkkDOQEsW?=
 =?us-ascii?Q?0nhh5m7kxi1muU6QGqFn/YrYTrkKQSNcNby+jC/pSDjeVVP3nM7r8R88gfd0?=
 =?us-ascii?Q?QJmXDfHkQPoOnEjyaIscZ0nWBYFb2Tv7eHLxEEACNjDcC8t5whIUaeybbmPI?=
 =?us-ascii?Q?6J/BjvtzSWv4SzENAgqYNE9tElG8euUUQbVz6NtB6zQnswtavIsTz0Cct3g2?=
 =?us-ascii?Q?krUARiWojPSBtC+QmOIL1lvFv3mC7I6XTPGGyyF/Vzz5GFqQT2UevT2EWVSH?=
 =?us-ascii?Q?wvD2QKm5+05sLZixsd5uQHlvn21xKQRbPZMg3T4WvNLB5aYDMIaxKsTBQatT?=
 =?us-ascii?Q?3JoazSMJjterLIatcWcsSi+ZEPW+VGGN/Ao5iZkKw5D8VWYvZQcCOdxmUMR4?=
 =?us-ascii?Q?XIY0A5ZYgz+i4hcU7Q2EKt78ivFAUbQpSDLjN4mBf36W3scq8j01Deh9wr9r?=
 =?us-ascii?Q?C1a0znWsHYKu/nFx5YwntcMNKWUH8zJ4Gg7g1SJ3ZZQTvaxqYyIYW84D1h0g?=
 =?us-ascii?Q?1aEpTqeg6IqqC85mXusS02Rsx/DH0wflSxsdobLuaKpDJJxKJJ7LqxhsplRl?=
 =?us-ascii?Q?2pZm/Sk/DBWuYgUOJ38g4sHkBbg0SSP/O7BffI6mVgbVMHwH2jb7pf6rPQ3J?=
 =?us-ascii?Q?8kjb9HlfHuRU2+Nqo3nC+TLPSRlROCrJ8y2oHzOzjjJXadfsDy54/ihGjz7X?=
 =?us-ascii?Q?/T3mye753ZVLIEC7WBJmpaCZMuQYTXnJzr+9y5zBT/L5IPnwLwDA+TGNj2fQ?=
 =?us-ascii?Q?FS/pPB3OCp6BlTR3+JJwGTIfKjiebWUaZgRa4oZ/uJDd9+o4jOZOJEcLvZO/?=
 =?us-ascii?Q?B2VBTuWgZHVKr0S8ECGVyOoP6c4iDZrQ+4IzMXnkQqYCSWoGx/G1DNkeCIEW?=
 =?us-ascii?Q?b2Fr1SSk/wK40N6benKJvL2W750gBCjJX2hKmA33v3UAoTNqxUz518gfxLmT?=
 =?us-ascii?Q?0X+Ch7KajgarvL0so91fgGB7KewYdreS2W60HmBBL6Gdcv87mX4DGZ4rxmMU?=
 =?us-ascii?Q?wqavJItuKn5J6DpCvjDzBzAXrKlKNgY0BxYsBBh4DxnPN/ytQ++2OF3LNBw4?=
 =?us-ascii?Q?M4wPfSuGIWHVWD7tttVCFTOOLPHLkKkQvt/8/SL7bL1yp7Q7B3ovEpxBXlnf?=
 =?us-ascii?Q?oFKLiIns6DJzPf8Jg2i6+O6KEJF6rOlPndb3l5n3fVN6utSAnHOd9B5FCLi6?=
 =?us-ascii?Q?AJu4DDBflzQ18kWL6EJCXrytls7hnK5bBBrpCxh2zqzquEQCo87H6W99nK0A?=
 =?us-ascii?Q?E1pGd/KD64ZRl8goyZ+Bc9D1ELLEjJxthfeFEzr3G6nZwIHeYZ226i43KJTi?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63da628-4082-4b6a-df18-08dab8cd1e94
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 10:13:54.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByHxSFdCYwlTHHt8SnVZPvkzbPvd4aWGgTrffbcE/Py2rt/zDESC3wNfSUEICXvbquw+p2cQGs1vs5J4sJNRJNda9i5q+aPiQXP7zYnC2Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=728
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280064
X-Proofpoint-ORIG-GUID: WJmh9C4qkgAYj6_gJAc1P5xYup3k13RA
X-Proofpoint-GUID: WJmh9C4qkgAYj6_gJAc1P5xYup3k13RA
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Pavel Begunkov,

The patch 13a184e26965: "block/bio: add pcpu caching for non-polling
bio_put" from Oct 21, 2022, leads to the following Smatch static
checker warning:

	block/bio.c:450 bio_alloc_percpu_cache()
	error: we previously assumed 'bio' could be null (see line 449)

block/bio.c
    433 static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
    434                 unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp,
    435                 struct bio_set *bs)
    436 {
    437         struct bio_alloc_cache *cache;
    438         struct bio *bio;
    439 
    440         cache = per_cpu_ptr(bs->cache, get_cpu());
    441         if (!cache->free_list &&
    442             READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {

Imagine "cache->free_list" is NULL but cache->nr_irq is less than the
threshold.

    443                 bio_alloc_irq_cache_splice(cache);
    444                 if (!cache->free_list) {
    445                         put_cpu();
    446                         return NULL;
    447                 }
    448         }
    449         bio = cache->free_list;
--> 450         cache->free_list = bio->bi_next;
                                   ^^^^^^^^^^^^
It would lead to a NULL dereference here.

    451         cache->nr--;
    452         put_cpu();
    453 
    454         bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs, opf);
    455         bio->bi_pool = bs;
    456         return bio;
    457 }

regards,
dan carpenter
