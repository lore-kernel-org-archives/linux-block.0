Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70258C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 08:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AB2604D2
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 08:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhJLIra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:47:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58878 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230043AbhJLIra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 04:47:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C8H07a028913;
        Tue, 12 Oct 2021 08:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DNHAajdD/laYl26pvqOmGzk5clrYarwwxGCajagJvpU=;
 b=ul7WEEVpMNW26Bh/n4j/K31sCOD7OSx3ntdGWCfQ7DruSounLiNuS8Lsaw7YMVJPltB1
 41AEn2Jyvdz7WXcCu6AN4StEdcvGrFxJwVx6oyoqng1fEm9eZ16QItvIxCJVaborx86x
 Z8v4Lgr9VJfFa/g3ICmwanosgZFangZg5LRaBCQBDoyZCmHPrJVCHI0MoAoI5slh34iC
 LRSz+sWSm/KzVQAn1PeommrXG1FfyHRqLNqugEUtinx765lNOLj9AnOO1I33MYXNIKLo
 TpRc1zE83+dCsNcb1A0vCbw3Un3m4qMK/J/emNlVArNS+qh3gHq8OwqQOnGCMoTbjiM2 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmpwn605w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 08:45:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C8f64m019789;
        Tue, 12 Oct 2021 08:45:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3bkyv9rre2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 08:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIQvukH7VZThFfwI33gvCV/gzXyREVhcqIjzIVySFnMT1T1Wte2SeLpucOoyPSDnDWtjmnLTyolr8TgrAIiGmQU8zwx6Ku31GWH6yzitFIjF/AlGg1+7LlvJxw18SFlG7Qf3B48H05IBWy0box5t9xR4Of8RTsdXWy4bww4qg7+rwnErGYFmobC+U18666YBgBvYm031xJClTloZQrRa4PvBQdM+TvAJgybwJCrEw+Y5geEwmW7lxbS6ne489AWyAqwxy7dUaNfwG6gVlH0ImuRCpPDAjz8UcDuteA4nUZpH1nbWbzPYg0E/VkHt911Cvs04/gXth35i1E3CBy4O0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNHAajdD/laYl26pvqOmGzk5clrYarwwxGCajagJvpU=;
 b=jMjvC6dPOchHIZwamVYSSzUogineJUjAWQ18M9MYUH4OLnGqkP2Sl9RiFESfpxJCPb1CNwgWC67WxIjwhMpbctTDHtsMeZF0ajB6jLJUhLFSkgKJUugbPFELQVaekhQt34/JBtZjw3b6NaUBTv+sBqaNeMfhvQlAO0/V8Vu9PwHyGR47ycpgYcq2pgwZVzCsl1BNOX6J2VB57RUTKfL17QrZaVusR4GvVg6nFP+94fwlUzLQROtizE2b6qNjzTDi+2tqKuJQ4cWBNvldcnSrM6V3F/o+w+v+lQRe5O0B18Uu7lf3thQhyawr/1+czy1o+Hcg2ATwqiuvasgMDeY7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNHAajdD/laYl26pvqOmGzk5clrYarwwxGCajagJvpU=;
 b=nvqxfTnu/oKzxpEVyYgR16OZNzhwkg2LNKo0pMODGNielbwYsRaH90jwa1ZoaZEOje5LZNItfiflpffpAWN63lbvjsR7hNWioIs3XPQQLWFROmYpMRMYLRs4CtyaNTqrCX+eQDWZDoBy9hotbolza/SeLBV1ftEejZC/LEB5m+0=
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Tue, 12 Oct
 2021 08:45:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:45:00 +0000
Date:   Tue, 12 Oct 2021 11:44:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] block/rnbd-clt-sysfs: fix a couple uninitialized variable
 bugs
Message-ID: <20211012084443.GA31472@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM8P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by AM8P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Tue, 12 Oct 2021 08:44:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7fbea00-54df-421c-bda9-08d98d5c9394
X-MS-TrafficTypeDiagnostic: CO1PR10MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46584D36313A0C4DB02720788EB69@CO1PR10MB4658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZP4yahzofeJ2t6zxKe2sGtzhHU9hWdfWIdhdDqpR5yFz8a5yAlscRjHkWCcFRCOQR7CPss8F7lqc2MGoPPVqWXv1o7xvToEsFzdYYt17/86p0X1Az9KzyXNNlqiyD6SRZj0ovwBpSJko456xBSNn9clBGeKpL1+9EjUouEY2Yhos1ogoYv/pJA4VSUX9Ngine651z0YT97xBPhI3lwwIPd3j4637E18nJhgseGqBm9l78eeHaBJrglmMDL9rm39apmhJHjDCRn6+3Jltwb7lZ6KwGSJilccm/f5T7qHpRzYg83279fRLr6gW/p7wm89un9GzuGttUku+kpekc1I2ZMQKxzIds991p6u1aCDEqn6vTfx+Y8ePN03gaY3pdOuS6yYEr7YuL/kf82eL2iAB0oehgfDGy9iL4WV2wfjZklgH4bEdtpPBl5eF0mff+IeDG51ullQSnap4Owb17od3dOScp65+c7EWz3ayWMXnoW4Jrg+/4gWWcaCFEAbhLE7c4P74UBITnivqTOzQ+7POgKmQzSJ04B1AWhUHMAgxSPCaD0d3vW8rIc3DP3yACYyb+E7PZDChpnHA2Qu4q1iHsDozquyqoXGFN3WWbPUQiUIHPFd14FVQzZBwqcDlPyy4AjWQpFkezfDouE86hQZmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66946007)(66476007)(7416002)(33656002)(86362001)(1076003)(4744005)(9686003)(508600001)(33716001)(66556008)(38100700002)(54906003)(44832011)(4326008)(110136005)(6666004)(316002)(2906002)(186003)(8676002)(6496006)(83380400001)(55016002)(52116002)(9576002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MOWyKpyFT3UHBV0+LClME9Imn2ghDRK+HFIhagtfn9KLeIjCFgslJr40nUy?=
 =?us-ascii?Q?Xet+KX2mQpClgZvolnViErwZMP3IhSsA9WJlMkTA20XRbvIJqh9U10PFl65K?=
 =?us-ascii?Q?SBgMJ19xi2r1jbWdOzFwEQodIm4xSOwNPJOv/OFWk8E6m8sA73wVebYG86EU?=
 =?us-ascii?Q?DC4YtBfiG5+Q+Q4c6RPve5faw9y2dlXyyyujFfzCU0ilK4c1mi8dQBLXln4Y?=
 =?us-ascii?Q?wVTNlnrcn6bYA3diW1zNQvfeOPqd1PptjVgKNlFBbsYj5v38+ISFLIdErF3a?=
 =?us-ascii?Q?L7H6pHyO/yDh4f5/IF4lPuOnYM+253XDWx7pPnQupEmwvOkllsspHdXRGT5/?=
 =?us-ascii?Q?2m409PkZydDjm0jkVpjXT2d0UDDU11/+1s1X4DRVM/sVJvXJ89zHQRaSShzF?=
 =?us-ascii?Q?nyseizJrPy4sw6ybhg7mDXbRxbMgh6faqZDcjQ7J84OgbRcZXPFmhQEf2wL8?=
 =?us-ascii?Q?WAABao4+TgI1QSioQtrOoKiaXCwD2qGCPOkSWZ44zgd28kzVzgWhot/TIvDB?=
 =?us-ascii?Q?Pqa25gKHVx8qPEeE97N2BjkAaDlwnML2c3yiBTaQ4fn+cN6+BVEoifhgHwSN?=
 =?us-ascii?Q?glnX6QMoIndYuudp+5pMfTPvjNuAPyylKuCHaqE2DXKmAfJyTt+N6whdr0rK?=
 =?us-ascii?Q?ndDa3SJH/JT/ODuHaCROjXeKJ06VOJ2Et5rKr3QaMlLVYvtmsQ8qAUiaTHkX?=
 =?us-ascii?Q?EejK299ZvGNfSKSkCVDJ3NNPutNHLMwMi3eBJCngD0bXbEf1iWH8N9xpxoGt?=
 =?us-ascii?Q?gFSAoFxCdR6wy+8GAdf3CXQqwXIMq6vnmVjfYuYS8vRwVTD1KGMTugCK7dTg?=
 =?us-ascii?Q?Rcszh2QaVtNW2ZDjMygh0YHBtrvz1qL49oOWjAafBukT2p5KkgYhNmOGEPz0?=
 =?us-ascii?Q?Qq32Gx450YYFJBi1JGnIaLfKIAyk0Xy3zaUPGZJWms/tfovFbKePrNvYPnUa?=
 =?us-ascii?Q?lbX/wNJUBUP6MRNSTRlyle+hJTiAFuavGzFL32adkMqKOcyWRHJ9vcl8OF/I?=
 =?us-ascii?Q?HJeJJ83sW1mU96OjzAc/z8B6pxgCKZ59r1vBgxcjC34fZhJpqvMYUC6J76NJ?=
 =?us-ascii?Q?NRSkXMjKn7rv+D8XsX6htlyFPc799agzRyatWd99ZxasZnn5NEe0nzlggxQ8?=
 =?us-ascii?Q?Pqj5T5LHhPXTUbHu1MveQAaeo5/V/9Pmioh/xTG7ufgY2+0Db74OYlmZgQlZ?=
 =?us-ascii?Q?sA0IWDqFVmVBiC6KpNqxCI4wzKRcf9Z2hq2XCBZT4ZBhhdXIBbbKf9DW7Nyb?=
 =?us-ascii?Q?FfPjiMG/XF01s5San1vPOHKD0uQA0UxDYO9VaBsKKX5c2vUvVP2IVOI/QjVN?=
 =?us-ascii?Q?BmgKNyrjQBVbRVhziT48yxsdLAWXvd2624Fa6nrXtIr9XRtRmNgTCCgaebra?=
 =?us-ascii?Q?gK+LFb8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fbea00-54df-421c-bda9-08d98d5c9394
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 08:45:00.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edv+QMga13tex8xB1Y+TvxfcfgIX2QV7cRThY3PgpT6mZ4hklvNtyU8tjsMLl+sgzivJM/WaLvxsuPB2AR+ApXPI2sn3E4LXIMwClAAQIwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120048
X-Proofpoint-GUID: Dfjblc6p42f4_c8IsKCjUGTKdIb9KSgy
X-Proofpoint-ORIG-GUID: Dfjblc6p42f4_c8IsKCjUGTKdIb9KSgy
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These variables are printed on the error path if match_int() fails so
they have to be initialized.

Fixes: 2958a995edc9 ("block/rnbd-clt: Support polling mode for IO latency optimization")
Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 4b93fd83bf79..44e45af00e83 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -71,8 +71,10 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
 	int opt_mask = 0;
 	int token;
 	int ret = -EINVAL;
-	int i, dest_port, nr_poll_queues;
+	int nr_poll_queues = 0;
+	int dest_port = 0;
 	int p_cnt = 0;
+	int i;
 
 	options = kstrdup(buf, GFP_KERNEL);
 	if (!options)
-- 
2.20.1

