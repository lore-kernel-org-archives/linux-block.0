Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7E17998
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590881; cv=fail; b=bAXqMEUefWZfZzbfmt22eIZgwD0w+9+OJ/MJkCQu+SW18g0omLFzR9/ucnxNWpOqYjJFoD9ZggJqaFxYjc2n4FVYXcXOtnDtudqF6yldtOOkj0jNZmTApmMZT52RLOr0HkwSBbit0nctiGxEadvRtnI3rtmCoovUNYgFiX1VO9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590881; c=relaxed/simple;
	bh=pVtS+UdgNrUpmzSD4ZqeDnOuxdrbkcqQLd5UH1eohOU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SzthpTs0Ych++157zitevSjh0b9/nHNWxK+harDZrqfkDKyvHSsPozTAJvPcF1OardejSPLgDkC7Kc1gY9wwXJ8VP/Osy8c96iiz5SpkQUksFrITPbeMRLXxWRj9SHAyWN18iGlby20zqgRae/YS61fbEXxqUNxhFp5vjm/XoWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FybYWYmn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AlS8zV5P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FybYWYmn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AlS8zV5P"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3T4g1019813;
	Thu, 22 Feb 2024 08:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xJnayjpmMrx2a+xymULcavw4V5/e8NUo7CEB8szQ1ww=;
 b=FybYWYmnr9KDWiNecrjw7NAJdt0HsQCD/rjm78tvxaH7T61Qzz+BwyAVw5O7sGaLnIpa
 gyhnw/Qc7+aXzrVBK0vk6QCrPeSW61h5ExDql+g1cFdIsRR7jMrgRjE19uZWb3vecX78
 rWWUglwjsGiA/YN/eefWPhn13riRB+kN2ChJWUotA1HX1gNIPor5Fk/RPjfN4+z5sp+O
 oz7NMDysfsFRh+c9g5yGOcTdO53oYaT9GUtoPDwvJzjoX8zzWmFIaQ5WwzMIuIIDQgGK
 TAJ/duPAEjKbgSiVDMadcRK+zcwjOUujCz1KPzrCaqncnuPdFeUOvp8kdgbWG0inCJvc XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud41u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 08:34:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M7A5Wk039761;
	Thu, 22 Feb 2024 08:34:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8aae56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 08:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/e14PpAJRmDIs7u/uq/VR6Rp+4oo5bYkQbKtHOxbxrfj6r2WWsK2D30+WKdPRNGZydl+aOvn9HfIHN00Zc/WVvMI/bWKHMqHLUzIwF6TvqE0nmTQjuWL7kLebAvXE/WnW8XgYk3XeosctAFRf4/9O7OK/ZibCO7PzE6gmg5zOUE5Vl4NGbbo/BvB5AQ1+RhRmQl1PTQsTe4LvIXxGQ4rFtmSpNU1ebLbvF2UoPm9mmqCAWf8LhD2EeeCz9g09VYz28Rcw5LSR2mE8IwFMV3mnV4OR3HiSxRipbGhmgCg7O62sa3yFjPqvH4FnbZopG0H1h4GOelEUw/iQ2FeSt+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJnayjpmMrx2a+xymULcavw4V5/e8NUo7CEB8szQ1ww=;
 b=BmJtEzUxWVE7OMAzuwZymqn6TPBoxIsdbSUVvb1CbHYfs9A2mFtDtR9JP4nMIbESnqovWzcMNX/dwhfP/nwDd/8OgtcQIyFZxHKYwyoxAVvqqxF5OvWlGZUzOi7+5TFsreQZXCeVEK4Q3j44ns1v0HJzvWqTmeMa71W22F7pMxIV+lqYgGRVrFoDrVAVxVQuJgE/0a7a91yaBLh5ps6WjnSdF7H++cRhIfqK+R5GWRYp64IagtQzcBG1UXDzdW9QUCBfa/ZZ2kUxIX+OsYHoxn7bJRNUPTqg1ryn26sBjaT5Ugxfzfw5ltD5v64O4V2eU3ojUK2sPNvhZEDoz8txow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJnayjpmMrx2a+xymULcavw4V5/e8NUo7CEB8szQ1ww=;
 b=AlS8zV5PqiUW+FZysEBNXR5CUFo2tOQy31BQd1kUrfKoXLq5clnF8BEp9zTOIb+AcDdqRRldEqIBWVz1Lr7koELU00DokLG+ulc7hjvKbuJWy1mYKBa1164iWiSLCp93jtj+HhOO0R9DQly+jpkOQCR/VZK71EyUxgqTqSkzHbM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7643.namprd10.prod.outlook.com (2603:10b6:208:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 08:34:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 08:34:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] null_blk: Delete nullb.{queue_depth, nr_queues}
Date: Thu, 22 Feb 2024 08:34:20 +0000
Message-Id: <20240222083420.6026-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bbd9d8-eeaf-4feb-27e4-08dc338117c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qLZCUUI0j7uwIz5fcQZZEhmKllrrecV3p5ZeqctmuKDwlu/g6SlDk90mqIA1YCV2LqQAdNEgv00++Un9K69kotSazqKEkn6gAe49ZENa8wfWrVuY7GTVkNH7q8Y3cxtvFSC8I5ydxgBA2EocuugpcHElXITK9zdNzcDfgbQbJ28+Lp+61TOAiXcvwX5KXW2oBVAUDXNc+D7a5ypJnJ8DhB8t67/QblnkelRNfDwPFuu+4io7r1jay52J6CRmEbzlOFryRHka9un+Me46I2QrdWKBacxb81dyenNKYbMcRgSSHS8lDeFNlP9It2RFcDub98i3A8hPFi9sPrM91PO5rPmaVJ+6mbsmt7vUIk5bIyJEQ1Z4WRKQzSfWYI1y+LHvvjxd2obgjdHD2SgAg9L15NMbbKqcQUR0KEMjeybHzgAhWrRE1W+SbanEoSmhQJhif1UaWxWpDE2+JHb51719zolBgyzx23hZUx4r//dBXjf0ETK2Gi2UeASYOq2ikh2QeCdkv7bT0QhN0Lw3ESEZv8/NFvoctlcCHGgsexiFKV0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zOuE8QgET6iUSLyKjoyfcagZAp3ySVhhzgsDvU55SsPEHNTkwM2/lTNq+QE6?=
 =?us-ascii?Q?Akkv9YI9btmRhDKdqVv3PHG13Jp/tI0/0H5mmOdfUCVXxOCf1ZcTjtgOQKv1?=
 =?us-ascii?Q?DeOIQWjMND/YAFQ9LJ3kK+HowNJQONFLRw1yNa/o7zXp3+1+QgncRkCeiwOS?=
 =?us-ascii?Q?AsEhDYiIvZCeraYOgb9NROxpl/d1Z9OR1wTl1oUJkdHXZxHdlMvwkSURUwP/?=
 =?us-ascii?Q?h5MoTr++EZRz2noQYgomIqGwf2DsyOlmu4fBXe2oL1UM4iv0Rx5Jy6KhRubB?=
 =?us-ascii?Q?a0LoxhQikkSot+BbxWhmVF9a8unFyZ7iDS7uxzorncUwPtDYw+oBChnpIRuU?=
 =?us-ascii?Q?VVWRvVuljtupDizI3sHB5QE+RIdtPp6GjxEMEQ8DOghv2uSzxnfhPVBZ6d0E?=
 =?us-ascii?Q?H8hF7DqSkBFSWhwM2OuaLEhgOQYTuGHpgXu28YtDCX/UsEUDwWdg8atS8sLE?=
 =?us-ascii?Q?NVlvPetv0MMZ+i6Ri0bFmtIftaChG/sZnJ/vFWIVywdqXPFDZ5q0QTRpyrFA?=
 =?us-ascii?Q?3vBHfd47QIDyy8i1yow4yE/J+aQiRwWzFtbQBhlmIZ0fzowHeWGONvQd8fQZ?=
 =?us-ascii?Q?3SBCYUTjoQM8rrlgRNp5gnEhKgg2Cd4DEvmLCh5i8S3sM97MJuHX0oXInWiS?=
 =?us-ascii?Q?ARQVn3B6huoKN/iQ783D/iwMaeEYq1B+BFbZ+cubGRUCM9LRRBGNSmfaPHE6?=
 =?us-ascii?Q?v5y9GYOyu0+1XCD3CSQZ1XFuGXqpm1XtTzXKeeEuTj47oJbGQ+k+FbsQY9Iv?=
 =?us-ascii?Q?PcBQCOgCI5S5sLykSvV6r5R2tPxD4IrelY/lhFh+JiWSJNsIxfovtA7mAUCZ?=
 =?us-ascii?Q?wBhw7UJea/VAtYaMItYhbe85BMmwbM+ynocvhxmBTapEuaoA6bYyCoQCNMkO?=
 =?us-ascii?Q?nf+DMkjWYEwDCuUn2+LdA7LTom1ZYxZDT8XSBDy0nRo7K9EY5gPWdbYEW6UG?=
 =?us-ascii?Q?1fpCVXd1pASYxppEbXilOmEKDrVvsBm+iCwq3TC6LCitLA9hHy9cViVX3ZlX?=
 =?us-ascii?Q?TJmoRha4IxDbC8XaXwEotTkidgxgcsgRCYKskpM9f5p6Xb5MnmTAE1fxDKXj?=
 =?us-ascii?Q?mJuB6TRt7EF+XeOet+9TUkP4LLIkmed3CsDV1AhVVIjoHyV+6B7hzp5MYqhf?=
 =?us-ascii?Q?1vch/LmF5HS2BaoyTFQiJXsUwtEhyZhFuAk+dPCdxl70LZOtUPcy+LQjKzjc?=
 =?us-ascii?Q?SVWh2vtmTitTez8JXjNJIn/xh+QiwC9n28sRfvMCSAIbexXVOxxPbPt/Qr8C?=
 =?us-ascii?Q?TbrAukZZSwPc+pUtefekZh4aj2jOrA41Gyqgf+Ywv4b/YiTqBtVbotGJgV5C?=
 =?us-ascii?Q?xlyrw9t7sYRAcFpMPdT1Eo9pTVPnQgGaCN2L6AG5ReC2+XF4zoCHDp5Tbzdh?=
 =?us-ascii?Q?AxCXbbkXz2M4tlWL05h5o8mBD3bB4r7Fd265AzP1zPeBmXRbL4vLw9oXHnL9?=
 =?us-ascii?Q?x6GxWPm6FwxlZ4DR5E9Mot58+DraOqG677W5VGow7tF2priK7Yu5C6nLP2OS?=
 =?us-ascii?Q?IcBSWfRAfU/Hv13QltufNks5q6WpodThdKum+hLAm8qoGVJwYeGK68PEbEpl?=
 =?us-ascii?Q?2EA8dSElbnkdPwhV88tJMjJJaldVn+CvzHcWDuQx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eShP+B34yjx88+moDMDxvDpNthe2HtXOALtVbhLiBIYtpH6ASPe3+O4urToeWfNVts5X/+DpJg8YPb8tq+KHy7K0O/lVTM3BHVrgkAa1umFNPNB614xNrN+vEYLvJ1YX3j/u3Hf9ektwqsgmhnduFlZBC8iN8R+wK/YWJuhqn8aDtuIMO0ZS6B44ltoaeXCZKw52NWC7WWtLijvodYjhiyNMJQUj82Cvj2O72mBMYaPak4+GN+IXLo+gPLEGFYnYBkb0eKBnYNEGnMDMNwEyU/a5/BAwwFQIxgEY4pLtbrxhrAxoVAKreHE3/OipFevHEOiS7B9KiB0lfHrTMnl1dHSZ8Vdt4+l6ohiz9Oqw81js5LU5h5Wkd1bo/bYCKWSod9u8lMV0NqARKdh7XePaTIsVbPzO8LwUGwuI+IqM6yIytIN2DIA5eLirHCF3Qem8oxC9Arq31AOyQmnHezcuKpqoYhJNVyYB3vIjpsaT+Ri6EtUgKHLyBa9mX0/U3IK5CtpEuChMmFND8ebVM8ynOdkEo0SAH2umiMg10FcjM1m5doOc4HEx2QTf7RObIjk1Q2G+PsjIOQX7SctlsaS3MSyr86ngrbipeAO+kVO3Abw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bbd9d8-eeaf-4feb-27e4-08dc338117c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:34:32.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T48WzlYm9JjqDWY6oO6v5FdI4RkPFycU/inR0tpqZdoijNkpWAWqaJ7jl3sqPojov1idcNjNoC1bM4IxCX+v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220067
X-Proofpoint-GUID: qkbLsbzIzSd1XthZ0RGLeTWBOgsDIUox
X-Proofpoint-ORIG-GUID: qkbLsbzIzSd1XthZ0RGLeTWBOgsDIUox

Since commit 8b631f9cf0b8 ("null_blk: remove the bio based I/O path"),
struct nullb members queue_depth and nr_queues are only ever written, so
delete them.

With that, null_exit_hctx() can also be deleted.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index a0b726c8366c..71c39bcd872c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1620,14 +1620,6 @@ static void null_queue_rqs(struct request **rqlist)
 	*rqlist = requeue_list;
 }
 
-static void null_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
-{
-	struct nullb_queue *nq = hctx->driver_data;
-	struct nullb *nullb = nq->dev->nullb;
-
-	nullb->nr_queues--;
-}
-
 static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
 {
 	nq->dev = nullb->dev;
@@ -1647,7 +1639,6 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	nq = &nullb->queues[hctx_idx];
 	hctx->driver_data = nq;
 	null_init_queue(nullb, nq);
-	nullb->nr_queues++;
 
 	return 0;
 }
@@ -1660,7 +1651,6 @@ static const struct blk_mq_ops null_mq_ops = {
 	.poll		= null_poll,
 	.map_queues	= null_map_queues,
 	.init_hctx	= null_init_hctx,
-	.exit_hctx	= null_exit_hctx,
 };
 
 static void null_del_dev(struct nullb *nullb)
@@ -1731,7 +1721,6 @@ static int setup_queues(struct nullb *nullb)
 	if (!nullb->queues)
 		return -ENOMEM;
 
-	nullb->queue_depth = nullb->dev->hw_queue_depth;
 	return 0;
 }
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 25320fe34bfe..477b97746823 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -114,14 +114,12 @@ struct nullb {
 	struct gendisk *disk;
 	struct blk_mq_tag_set *tag_set;
 	struct blk_mq_tag_set __tag_set;
-	unsigned int queue_depth;
 	atomic_long_t cur_bytes;
 	struct hrtimer bw_timer;
 	unsigned long cache_flush_pos;
 	spinlock_t lock;
 
 	struct nullb_queue *queues;
-	unsigned int nr_queues;
 	char disk_name[DISK_NAME_LEN];
 };
 
-- 
2.31.1

