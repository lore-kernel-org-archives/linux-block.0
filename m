Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70592C433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5602B611C0
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 12:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbhJAM2g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:28:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28698 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351976AbhJAM2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 08:28:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BUrLk012052;
        Fri, 1 Oct 2021 12:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=6wviHJSAZ7+SbkaKdFvm7edDoFSt4tfW03g58EjK11A=;
 b=iLB5LXvwShL+WZ6Ra8UWbBbMGJzxeBxEPTSQXyTif0K+nw397gSpk0sSkpRSzKhGZcJN
 SIeSRzrPaCCdMo+aBNk7gQ16II9mVipCN3sUFACVDGHEGyvOSYUsh73sJ0v4epmgroRb
 /uuMeY6k8cwHLc7yxgQ/M6kT2y5eQUWbbS3GNdS3aGYzkjeRvCs2bcwY3K4AWvD/Grze
 kzLecVyixqHLIArifYvxftFj/BMtEhl+roKuRMAkOE7N5wufZ8AJ7r5bMpDaG1hALYJX
 RmkFRY9+6Y50/ac0n/EkeH3YOBk0qayC6BhvUiWhrNZpHUBi6NnXtgPYjt1UyEh9LMTQ mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdds86u90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:26:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191CKKg5035591;
        Fri, 1 Oct 2021 12:26:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 3bc3che7p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d95C1HSnZv5MPq/9w2mhQIisdhCALLrHIi5OPU+1XwS4+gmUyqenwyUecWqYHs/0XfnRGsiQnxYGf1NuTsMCwd+47IKWsd3ypNYMSNg2hcC151DDE+U6q1AGoLDaFsD2GPl3mWPJdIA/s9mHTnyrt61XUp8vCFf+EL95J+OYJkddReylVbB5YwTUz3v+CF5OcDvJAi8zNf9333ulm9J9ujyiPma9tRgbkC1rO3nbaPGQFg8Kk0pOH9nzVlpE81qVbJ30l/cRBXTa0lrbQp9kyyqi/EWKUizs/QgiqFqWRtRKMSuyPMwDAyXywgd3pxjhivjYwzEYQabWm2eZWsAnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wviHJSAZ7+SbkaKdFvm7edDoFSt4tfW03g58EjK11A=;
 b=YORF4QGYLYiOwfSjHTqapXSAWwxqSSWCJSRhn4fGa8J4myeByK6m0BDKqHgdQOt1CtcJbgxZlzu2ciA6aBGO8m8AA66GvF9ZbZrTO55C5gpRXfde0PcKLSt6hLNA8kRjf29d1kBDYRoA8QSoAiiubJxE+raK4Vq4BB1OKHl/KcK3GGT46NUyBcETpeRA41CwyI9gGW35L3MSk86zbWCsaybOm+pjE5j8F7Fm0gYzbBqy1YaCGkciCrrb6p9L4p6vUvGtKHR4neLiYdd2shSp2jeNGavEPDl/ZP17uBQuCpyXN7gsuR99LUmUyQp1JFdrTIa7A97Sz66itGfuTxrfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wviHJSAZ7+SbkaKdFvm7edDoFSt4tfW03g58EjK11A=;
 b=sE1jspJPF/DPeZe7zqRR6R5LkWccT6vNJCH8eqDSGr769WfRtnBpIkbHQ5RiAZaTeznwi0pole2nAIxe2wf76o5nzSydzIbTV5IoXiI9Xcwl7Uyx/MFheTQt5synnX3l+lvWOiiQy2x767IEAjy6IVoqjpuuNHQy7ektwUIr3ks=
Authentication-Results: cyberelk.net; dkim=none (message not signed)
 header.d=none;cyberelk.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 12:26:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 12:26:34 +0000
Date:   Fri, 1 Oct 2021 15:26:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pcd: fix error codes in pcd_init_unit()
Message-ID: <20211001122623.GA2283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Fri, 1 Oct 2021 12:26:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd882df-3c1b-4f12-be0d-08d984d6b4f7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2319A2A1D14ABF85896CFDB28EAB9@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yz3z7FLlP30PJ8uEJTKeLPvjntdMNKTpKafsNtPFnxnU8fShmmLn3vlBJsVyO65LVB/d3+w1R9KwTM3JOfx6xgHXj10MaGmGM8h3l+TBlFVLue8PfsaMLfHpAV6KZbzi9QB0nI1UCi/7VGa7Nzq11Jg4T/GGNNT1f+wCpkFSrKsDFG5t8ZlQuwfshE6vo6YaTfIlpNJ808HhxzG7IOPSxvsVE2FX66AxH/itS18ODdE7Mg91op68sNDs34L1LfE/qOKRRNO7K0xJQd/+FTuWluPY6wMbrMOo6g1rbelta0Ubz+SSoTpfpDRy0pdNzOJr0FzxPaxvlpKtDt2+z90kZoss0VGeObbFBUWsTBvmwHPiFsazvwjedkdQByL91ciTBD/K/omN0fcv4omSGYVkMjjng537H0BpbLh34u6BMKRCdGRjBjMVQpABw0T2LrA5lE72Ij3gLchvAASkZnqkf82TFuwN6KdG1BPMpRsGS2VRInaBMGL3PGM8fqGpQWZCsWQema2dW0vIW4hDiwGuwL8GZPxD0nmTaUnO8Te1+8QH+rqmg+MVcdcyczzFEFqMSs+sl3cvGHXWDQ6p8SNBM6i/qfVpbJh78IbgVFuUmFb3OijsmPEUqF/jJo5GnToMQ3vhWqdjXeubi9drMR5DsWBiLnR3ry6Ho0VuHtt/9mMJLTXBHwbvGBZaQ/G7+aek5rwbb5siLXB0oWkM2ZsCsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(110136005)(9576002)(86362001)(26005)(44832011)(1076003)(508600001)(83380400001)(956004)(2906002)(186003)(33656002)(55016002)(6496006)(316002)(9686003)(5660300002)(33716001)(8936002)(52116002)(66476007)(8676002)(38350700002)(38100700002)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29sEg0YcTmkbFOoovSO3D2G3Df2zgG6mObZjtdaDEsd7BJWkBM5Bs74TWE2l?=
 =?us-ascii?Q?Nx7u05LshlXecBi8O+P8K40c5NLjy0wTgxvNSoMLpguRLkBaE8jbkNGdWmRE?=
 =?us-ascii?Q?FkMuq0wm8ZrD+IcTLrN6Ep/Dfj6ornzrnZnIBxBnkJkJPYnyg2TDRnmVkzOb?=
 =?us-ascii?Q?PQdZMZJzVij1V6EWqyC4qPdU/FVBv0Epvtur8cpzkaay0ISboAsuYU98dTQH?=
 =?us-ascii?Q?bCWZxEi4AupjwYX7d14QWwVZzpmF9PuoONfduqgdxumMlDnw6NZMr6xArJ9C?=
 =?us-ascii?Q?Dg7EZ6N/YU3iJiNAWbkyIcfeL/HhARWud4S3G3uYMrW1ZTTE/LOaxJsRLRgW?=
 =?us-ascii?Q?2p93dBhx4FAi4662YMXl/75PGeD4S41QfIpRw8q5x4IuCPR9SuyPzXIkeh6N?=
 =?us-ascii?Q?+wmu7AlmNGyUcZbWRNwwjimfNFMPtFBFIKfOnrlPM2kFV2kSt5uwydhc6Cfx?=
 =?us-ascii?Q?iJVftqgIa/0foZHNvHLAYxdhfvdzoJcgdZrtjYHRcZYON+YbEcpUI3y0hd5L?=
 =?us-ascii?Q?Bt1G1auTiYUMs25L3MIOL23NSl3+/emjWikEfqZMWjb7gRpUe+xtK8f3Gf3/?=
 =?us-ascii?Q?mlxc+BAmLbXlJvjcrjeI3jkkfbapkbdJ1voYbfOQSfOyMAqZMOeh7hOpsH41?=
 =?us-ascii?Q?8gkBIo5s1zFKdAHszPeFpY6VVgkUpX++6SFolY9D64WZsWqdCinSe9yqVcTE?=
 =?us-ascii?Q?zJvxF9zs4bR2xkx5rI+u5FNbDhl3OR9pvPKemjMg2/XEnp8+FGFxabjWky6l?=
 =?us-ascii?Q?rrMzuxrA13o1G8lQbck7YH9xi9ev2R6BnCVRrgUxKTQj1x7XWijjI6r69UHC?=
 =?us-ascii?Q?Tdo9zCq3aTisapbZA5/ti8YBr5Kgx3WuTozeDCITAet4NNadxAViqkiNF4zl?=
 =?us-ascii?Q?XpjsFiUbofDJRwpNNX7DcWoMrveYYr4PSGh7KwaKj9j3yqUZK3a+JfdltdsH?=
 =?us-ascii?Q?h/BXPaADc4/BDxHi4oisfemz1XMvNL3pLLiGNYVtcDDBqLcIs6jZVdiG6Uz4?=
 =?us-ascii?Q?+qJE5rWMvs8QFDMSYyX9PRgap+Em1BprZunJ6dRW0Dv2bLKL7Z3oK8S+wMaI?=
 =?us-ascii?Q?9oO6Mh9NyYsa1pCsInB7fpajH1KdfBh6qerDiq5AgOBsVcc6AfEzTK6bSsfz?=
 =?us-ascii?Q?mSUdMclxbnQ5I90/0j7qtI8URjHqnHjSPSF3mm8blGcY47ZtQeQCJHagv/yJ?=
 =?us-ascii?Q?6MikzTWIB6DaepISewcBRn0h8Vvzc+VW30XSnhP2wqlJ+6I3o1jbBvEIOF9W?=
 =?us-ascii?Q?9bbAcRQ6uTNk2KNaZl8CO3B6GtOX9Cx54hmSHGIdBwhLZ+jOyCPGDJCJFr28?=
 =?us-ascii?Q?G1C97Oln/B3MsGXzQ7W+6L0q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd882df-3c1b-4f12-be0d-08d984d6b4f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:26:34.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/TOuQQCdbP1IMsZSlJDWKFfYEEb+EvIqQMhMAT1c17DHn4IQLkB/yhq5d784I49AjQXZOc4k0j5tNl/ajLbZIHrJGM4s3284jozz95yT1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010081
X-Proofpoint-GUID: HGhR3gqjMiZ8wcjpkTYB7WTs7kmYXuVg
X-Proofpoint-ORIG-GUID: HGhR3gqjMiZ8wcjpkTYB7WTs7kmYXuVg
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return -ENODEV on these error paths instead of returning success.

Fixes: ea3d5fcb746a ("pcd: cleanup initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/paride/pcd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 4cc0d141db78..0214f123d018 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -613,8 +613,7 @@ static int pcd_identify(struct pcd_unit *cd)
 }
 
 /*
- * returns  0, with id set if drive is detected
- *	    -1, if drive detection failed
+ * returns 0, with id set if drive is detected, otherwise an error code.
  */
 static int pcd_probe(struct pcd_unit *cd, int ms)
 {
@@ -627,7 +626,7 @@ static int pcd_probe(struct pcd_unit *cd, int ms)
 		if (!pcd_reset(cd) && !pcd_identify(cd))
 			return 0;
 	}
-	return -1;
+	return -ENODEV;
 }
 
 static int pcd_probe_capabilities(struct pcd_unit *cd)
@@ -933,9 +932,12 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 
 	if (!pi_init(cd->pi, autoprobe, port, mode, unit, protocol, delay,
-			pcd_buffer, PI_PCD, verbose, cd->name))
+			pcd_buffer, PI_PCD, verbose, cd->name)) {
+		ret = -ENODEV;
 		goto out_free_disk;
-	if (pcd_probe(cd, ms))
+	}
+	ret = pcd_probe(cd, ms);
+	if (ret)
 		goto out_pi_release;
 
 	cd->present = 1;
-- 
2.20.1

