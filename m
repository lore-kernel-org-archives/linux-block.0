Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A60C433FE
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DCB61A50
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhJAM3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:29:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60338 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhJAM3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 08:29:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BSrZ7012040;
        Fri, 1 Oct 2021 12:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VMby6WxqXRj1xaImZ4LRLDPmznu01mVR3EY4/AV5+U8=;
 b=avgbbzdqXdKps2U6IqObE21rhEBFEutQQcTOSNtde8wQCEfB3xnAlE1atyQiJq3aY3o/
 DK+aMP+GXrdPTKX1Je5qHxinxXu5maW7rsvA9lWPQ6lmwSCTLYqOnZ8bRkHj3Vu1J6Jp
 igtmnBhKH3HvQJ/Zi4au2G0xH7HhcMdY5QzR6Z1qort1KHjiXMx849jQNMm/SBQjrXYy
 eIV3KivT5oTFVoz6FVyAPlPV0iverriqNhkS0pePcp0J172Xkxtpx1UsUx0RDCLdUL+2
 zCkD6+HhIBsAJBdxbiK+7Gc5xu5rlZcNGtD7AxyIktfwHz/UCtnotfEk5pODKrMxbVmH Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdds86uc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:27:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191CKXHr153911;
        Fri, 1 Oct 2021 12:27:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3bc3bp4beh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dchTRAKLYcgtaDn+HggS5OMjR1SBYNNJj94ilZDoQ66gx2TJK/7I8JenrrxmJ2Megr5ZLME1IV4p+cNaB+NQ5LOkbiIPzMeohqcfshZmUOqwJwctMauEJ7fJSABcwdDf5BQwP5v4IeMdy2kkfGqNluxICv9SrQi1FXSGwsD4JW+PZqwbz8UmpvC9ReMsJEZS92n7sR4k+0xnF3RPZMOzZKnODpIlOqtiDRi3dqicn+8ceIEGUc+Y1sEEBfPhcHnMNEb64PuPxh7gMdwhNkyqpxNGBPUyhzXZxWCyJPvsPlckFqHSjYyf/+NnSO4a+q1g/UerSV8mAAlU9j4pKTY+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMby6WxqXRj1xaImZ4LRLDPmznu01mVR3EY4/AV5+U8=;
 b=Ui4zhT2kEvDo2QwdQrk7fiI8t5uk1tjodL7pgiWXu/BZmLObh5P5+LCao8/iA1U2rHLYYRdV3UB6jZOF59fPOXPWo3R+GCQawHZzlWJfd73QZTy16E2DoPbdywWmeoUsVqjxM+U66t3lPtgCUGIF0ZN+z2jQgKCr2DrlQdGtx770+SK4pi1mWXLwPtjcr3uDMFZDsUEGit7Qd2K+gd7JDXqkmB4GlB9P1l1R8XNsxLmNUyaYuWDDjhIyeH6TaaAMdAJotKgmOWKagcgr9ZOJB2z6jSVT1aDEOtt/s5Nn2fsSo6yOjVokOHQvwLRb9IPAnfl8mEz1Hg43I2HeAoWaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMby6WxqXRj1xaImZ4LRLDPmznu01mVR3EY4/AV5+U8=;
 b=nqa30TKXmbP04i4MT8Nl3kWr7UKkw3cDaWyWYtcdDHB/sGVO7umsupET+hXpY/fYblW85LP8e8I9iz7GBQoqIAQ3cH3qhEX5bII8uK0u6X9fV37Q7+mxwZ/3ispZGImH4jJUX2w5g5MEWJM/DUletswjSv/irHkHkziHoW6CvpI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5425.namprd10.prod.outlook.com
 (2603:10b6:5:35f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 12:27:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 12:27:32 +0000
Date:   Fri, 1 Oct 2021 15:27:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] sx8: fix an error code in carm_init_one()
Message-ID: <20211001122722.GC2283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Fri, 1 Oct 2021 12:27:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35322cf5-8eac-47e9-1e19-08d984d6d787
X-MS-TrafficTypeDiagnostic: CO6PR10MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5425777C39BEF3EA3C92520B8EAB9@CO6PR10MB5425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCUIqmTMS9rnK+j8IoYf2ETfKVuEGQ7+/vknGCknccLI95/ODXvLkpqRoCtWztagm85roB7KS4fOdvZ498FNPHBz2Tfkk0beZ7PktUXBMzVMV1WBrLr7vha/XfGV610Bz8aA5qfMdbhZgElgTHqVebophzeqymAEE9irx891lsHVi7hjbPzU14Qc8BQOd7Fzui0h2syEruelsfUTtJ2OwItFZ/HUMlSDF2gKXRRaK20ggUmL/2TaLBTmN0aDKtvAh+o8KKU0hAolwu4+ulw3444UsKDR6bXSP+V4Euh/0wWCgNRhqdLAW9SESA89KJIUlIBBC+p3OAmyCaEJzMSjnFpDHPlYHppSuKA50iDbmO+HSSJopuounHc6YSD0xOFtZ/32iNds7V+/qclePe3fhuyKBj8BPM79tehIbI4d2FCsAkE5v+T2Mu9FpdRHn8QzJ0sEshZkvJpaAPPH1P7nfN1KFndaqaFG7UTej1u+ipetSLstv3LB2D2huOFMJyBZeBcvTattcP/rngdWRhYBT+9AwVPmpqOqEQoY7ga3U9C1bcEklvj3wM2VEVYliUbvaMrpkojrpN8wvs7USAcgn5UAOS8WW+hw7sWTtP1vCS6J8VabObpheTlhKDqwTJ72wBXLFBZRC155U5p9K6pWI3ahFmjjbD/ActrGhCPvhFeGqmgaNEmDwCtyQ3gRdWTk+bjWNZQgSaEhBcdUVR3ZoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(9576002)(508600001)(9686003)(110136005)(66556008)(66476007)(55016002)(6496006)(316002)(52116002)(956004)(26005)(33656002)(4744005)(44832011)(5660300002)(2906002)(186003)(66946007)(33716001)(8936002)(83380400001)(1076003)(8676002)(4326008)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8VCapv4e3e+GquQKQOPG6MzGG3ulAXV9qjftg+vJi2DwOlHVKTzpgX4w0ga?=
 =?us-ascii?Q?2kTcS4lTNhQMx4jHE10yVifwBJllN1gS3LJg9gMLOZ70KYD3Gs8mAmLqGJ65?=
 =?us-ascii?Q?E3pNIRaw+j47XvT9ThWgg5/+L/s7XvnMGRJn1xY9qak5/Rs3lgmrZXDSbCrj?=
 =?us-ascii?Q?cQylBHr3az29Gf+6m2wRY7ypnyxXJQslXxaxDsHDX0NAeBI/nrjg6mcwH8fI?=
 =?us-ascii?Q?g89kbl5qxdnMt8jnyJQuU3lm1CsJBibIga1JZIq1koS1Fo7W0e+uaA9aqLk1?=
 =?us-ascii?Q?tC6Da5akmv78BABpfevbitYLgxOSfB94ovFmmCfeOzuJAMSTxLqcOaKSnIcY?=
 =?us-ascii?Q?rX2nnsOTe1ZGpRbGk0E1Ne+syxWGof4KWGYzF4SBjfljXUbMD9a3dHAzKLw+?=
 =?us-ascii?Q?WJXJXYGNGq5243O0Ryzsq21hWCGj2Qj5V87LPkOAxp42kfgIM7+eoEXvh4jR?=
 =?us-ascii?Q?hC+0cLIlVFyKgSjCCwiNdPDseDfXtsnolHOzeiboWijfaimOX3e+3bBeF2MF?=
 =?us-ascii?Q?5S70opwN/NIlB8JAZTviwM0krTf4QspCz4BmmUNS5pCJ/4W7EiJ0D2fdL3PL?=
 =?us-ascii?Q?n6QT3oygsX1t/L1cJgaaShVBLb2QiQlxYb8GjCV6Xb5aN5f7DaTyXN2id8Kw?=
 =?us-ascii?Q?u6ckvXBBW3Y9orVJQ39TPyWc+JNZBLqmf3ny8nOIMCTZGO8N3yKFvgDeMuPy?=
 =?us-ascii?Q?05QcHiRHE9c5KmEv62A1VgXbiq6UdtXBv3czLBin7CHK1WawEGTgsZapVJsW?=
 =?us-ascii?Q?CqUHQrwcffqIy9ohPYvDcxCSWVJPIAsz6pvdUCV32p0HW3H9tM7teqS6lchF?=
 =?us-ascii?Q?VJVyu/nLJg55kRcxODXBL3HODOJNI9uVTcka6m/vY63eJ4kqJWU7KJ2INMvz?=
 =?us-ascii?Q?BPHem9H+EXTinuwq6HTMQm7s1UZzTmKXbA4j+6KeAdNdHOofTETvrp2wM4Rh?=
 =?us-ascii?Q?AP/6fwZgxIKYnACSYfNDmItioXKFELoBjop3lSoBN2FL8JWlugc3n5KohSQ7?=
 =?us-ascii?Q?mfnxjAvu8OcFfOOIKH+/guFkosoOU7JslxgllXM3ng/WAdFovEVixeyuxnRF?=
 =?us-ascii?Q?bsOev4/cnTTKGdkDa1o9l0OgEeuBz8vOY83pDyvOHJEUtaugaGP8qEBc/5u1?=
 =?us-ascii?Q?RE4e47azik35Fr0+9qKFY9e6SufawKNNTuV8snMNzOYt7idx1hjFgSRfq5Ej?=
 =?us-ascii?Q?xOoBRwAZ6KIKNhrV/Uk9eaxTAMYoxltj5H3SCvlpf64Oj0TtD27R5CfPFabX?=
 =?us-ascii?Q?Wbrgu1SLt5mXWGgpeuHDdwx12g4Cq2b3FkWrqdi3X5UhkM1WraRsZKdngPjT?=
 =?us-ascii?Q?Dm5HdqgjnRz+oGJsF3UKLF56?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35322cf5-8eac-47e9-1e19-08d984d6d787
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:27:32.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E0f2ybr74ghB0eP6iRhy6RqFB7Tddo2brNafC+YMTFQLYxH+xoLo/HshE6NPqSF0Gi5Zw5jtYgppN3/midJrGJO+XA5Do/DV1/DALW7ZZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010081
X-Proofpoint-GUID: dIDCkbp07xFDli9zNHTJTtKEJ4CgiK-S
X-Proofpoint-ORIG-GUID: dIDCkbp07xFDli9zNHTJTtKEJ4CgiK-S
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return a negative error code here on this error path instead of
returning success.

Fixes: 1683818a4f1a ("block/sx8: add error handling support for add_disk()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/sx8.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 1c79248c4826..d1676fe0da1a 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1511,8 +1511,10 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	DPRINTK("waiting for probe_comp\n");
 	host->probe_err = -ENODEV;
 	wait_for_completion(&host->probe_comp);
-	if (host->probe_err)
+	if (host->probe_err) {
+		rc = host->probe_err;
 		goto err_out_free_irq;
+	}
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %llx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
-- 
2.20.1

