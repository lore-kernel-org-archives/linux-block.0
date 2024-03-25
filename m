Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23238154C16
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355747; cv=fail; b=g/lmMswcvU8E5OZX/JGCCOBI+ICykwNHLQI/4UZFbIjD6DRRcKJp2O9QdqifHyBxraw9W5u+gRNcdBdXYqmWHKLNrudKsDcrRv8tDmpQobTueE3AXXQcHYzG8UScnC7/kxoMVL8ZtCkIQDuzWIhm5aMn6oUwSFargoOdWHVfb1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355747; c=relaxed/simple;
	bh=8ScQx5AN8y7IpxNWpydctgFk16sqhQtkPb0BKwoHXo8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fas0bFHy51SkxBO9VobdxAbYrWPxhcBOX7B+YsMWxMtEeOjn6q8k8RuwiTlWEOetdxz4mBi9u7VCYS9iSHNBLija0MDGCfsA/eCSAWwmWQVv18FusQgq29zs/JNxfGMRkvND9uEWCHQrSEEfCW6F4X7FFnkZPcoU6Qr8I8/U1aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QTBJzn4z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ri/3UStc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTBJzn4z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ri/3UStc"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P6Lfgx018323;
	Mon, 25 Mar 2024 08:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XP/+0WmeigazJtqTqzHFHgMZongCH8D3I6Q7ywpgXWU=;
 b=QTBJzn4zFiqmq7b0uHXPSM2o4sFG7FGHesrFjCCYppEAFsbJBMNrxiCpV31n01Hv9OmQ
 yQeo8FEsNh0jmzm6focSuTCejJWI8ej/Iyrw3b9+j99UUgvwwf9ddZ1/RcxuIzV6rnsS
 jD/R4R+edW7FnV9hsXW8tVNq3XOnQ+ca09AOwbryne+MYHAcmZM8f9JIGCTcTfAugk8C
 ujQOuDeJZGUOa7VVTYXBIxVEGvEkzmNk5RkeC/AHPyb4qgtSuXKg5ynwrrYZkJ2GjnO6
 8AX3qY4pAP5UfXYDwnvdARH3cL/7VFmXA8KD2A6d3pTSC1AsdRqLFfU2OBYBB8qz+7Yx uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dt6jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 08:35:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42P8Fvip039762;
	Mon, 25 Mar 2024 08:35:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh59v9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 08:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krLa4eR+nQg4lZ4xIuPdibuBtx9n2V+naC1lyM/4YObM46axwOph7zZ6R76SAnP8prt8etFFqyNcxAwPxX4GjYCmjiNpJBkOeBy2ufFM94CMbT3smqO8t0K1uaSjjnX/WQD06S51XsxZE4/UWGSYdTfViVZbK3gCrQKXVM1sHzlJGhBWKLU09E1pRuy6ZAksgunwsauAKZAAQVIuc9JwxNhF4Dz8RC7iYOrKc8mMjKw+g/9R5BWyHSBKpauu3bxV1/Dn6MeufQqmQjhfWqJAYBfUGkWRv8vUYgU7Ki0hTRx97ivznbm4jAXbFokWZSFJ8MdjLL3j0zrZvAb7JzM5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP/+0WmeigazJtqTqzHFHgMZongCH8D3I6Q7ywpgXWU=;
 b=ew/faezkMqjMI3AAOl+LKl8TNpqP9IWrlzZs8Gf5E2u98aw9bbgvOPHS/mgr9BRqpHtEP0g1yAHYcJW86sDypogBDpBMxY+dpL/V8Z1ZLez6oVAeJN1MDc4uE3NUjRY4ap+0OiSoEKwCMLvP1OauzzFDatxMTlYms9IWKgoRB/FrnxJp9UwzcmvcbV3jOVgL4kMwiM522DnqRspZOhLjrKKr9jygFOAbHkZNMOAczyvMQ1nBmeIHQauSNbVEJ91mgHCFiJI2JIVJuBuKXjmySbSPNFSPZqqTQmm+mpnzra6DQRXIm4/ASfxVmZCkfFSPRGBxVtR8DWFaY6BydpylRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP/+0WmeigazJtqTqzHFHgMZongCH8D3I6Q7ywpgXWU=;
 b=Ri/3UStcB7CmaFUjEHpdu4QxbM7H927efXo/1uDQ9zDDdplH2gPGEuyKNrrvPxs/DFmPuk9iKgXSqSCcT4P9nbISXbfIdZthjU5P+aSmfE5GY7uv31utHcsSVF48mTeYWVMfECiwIgw4bNrMQQd3vpe1TDyfPsbjhEpiwCc3jDg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5811.namprd10.prod.outlook.com (2603:10b6:303:18d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:35:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:35:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Make blk_rq_set_mixed_merge() static
Date: Mon, 25 Mar 2024 08:35:01 +0000
Message-Id: <20240325083501.2816408-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b41e634-8244-4438-eec1-08dc4ca6898f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U/yhEymVVdYDF8vENMLfiiQM0IG6PIx2grAWUSRAP0Mah9ZHGNp+L9NF86Wflr9YjllKS55R3PVlCP0wOcqYIO1uV5v6I3G5t3hDtUiWt8bmu40kL1xf+M3j7U5G1O8rMIJXFo96/JiTYiEuHSeAlYwjWvQwPMtibHoUK8jqlg78Gu1dq0z7cffM/EVs1AOopOjqBp7oc+Y4z9Z5jInEf1JbjS4ej01YT2U5Lt4VkH4SKzjClr7h4utoKo9ePYgitNzeKYTh8gkuVk3D/bGox+tp5Tc+w68V8NPynBE2ihTuibyi2yVl1tfa21hI9Hekq1Pur3IX6NeueM3DcsN/GsZOp23Jur2z8ZSIRLbZvUr+d8ZcdRMmEGptwbYdpPKCQQJrCq2m9a1aD+NQOj8sp6/S30j3Ra6ewteBteDzr9SxlE8fSkNhL3CWW3sSV1pW5l4tnVJkCwOlM7KRBC+fs/mHl9eSMSw3+V/YojIVB8bMRsC4EW+3Bqj6o8Pa6q+GwamJOFrvS7w2yh9Guvy345c9r2dE/Is3kOeQiwdP4T0tqGJBYGeEYt/B+u9R/18MxkUiELV47gdjOyhYsyqoq6ibHXFF+q/4NsjaVwwwbAqOnGnmR22j/xHNSWl3azjLK8TmLun9Xh2i/QDvvuNPNZaTTnjnTj1U5iUa2Fx2h88=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3E7Fb8x3kpmqfkq1N9i7E2vMxsYQsOZiucT1SHU4JLNgE8C+FSOPGd0FlxA4?=
 =?us-ascii?Q?sx8HSXDwNqvjIVdXvvEd+pJ+5lvyRjmEFF2qaxQGOtohl1WkWwC6teYZMgdu?=
 =?us-ascii?Q?5WP3LkoDMfTuMNhBnxRfa28rl0A4mg+t7HLDLyPsHTPooJlmMEoHfJj9ZhkI?=
 =?us-ascii?Q?Xk7wfrvUbhpPbMjrD0fTE3Na3zjLvxdnQ2rpCF4YRT7G/TuC0qBQjcdfSU0u?=
 =?us-ascii?Q?5JkDpuOXbMiyf1JP+YiOlCVpAKQsk3jf8I9dEoegr2jZfe8zBZhz0EfPCSLP?=
 =?us-ascii?Q?EGxhgsAGYDCmZli+gfqxh4SIV39IDPg3w9dCPpvfXugJtJK29XnoKaY4WuhM?=
 =?us-ascii?Q?gPvS44DhFyjpfpnw4eI8mvCMSK5wiBuMopic4o0oQi5mBbEjIwyeI3mKfnts?=
 =?us-ascii?Q?CJJq3P3XOmrFjDcMFnN9ieZnbISyl/GC3zwbxtZiAioW2TXpVQA3+FWhndjm?=
 =?us-ascii?Q?QQkI1Apfl54e85d88UVGcnvLE7BobN1e6CdgJMxI/o5VOssop4geN3QUILUb?=
 =?us-ascii?Q?6ZIF/zT3uCk9eVK2Q0tJhGe5U+iNYIpjhlzH1x50rW2EoOIPZg03/CcUdjiW?=
 =?us-ascii?Q?VU9uR6eklu1WvOpPnp/t1ZEGFVtj32HjIqo9W5EXCyRcZq0VY1exmWqzir6s?=
 =?us-ascii?Q?YfsYw4eahcVjHELJCOIDeBqJeqTB1T2oYMlGoewfWTev8Oza/0k7zYq0Kmvn?=
 =?us-ascii?Q?6FJYTWsx1ET4X1VLwwRON1XmKu9SpFu1TfHxN9A7uhHg2JQdH+HorIEwdxvs?=
 =?us-ascii?Q?YUqUtqM1SpD3WAS6xJbNdyL0jdZpBvEXJQs3LuCK2gj9g2ABVmlYiFwXdomL?=
 =?us-ascii?Q?bSfet/dimyHgW9Yf9wEDNhoKJb9NNqLP+rCzi4Rbp3P2fj06D9IOvSGGUbfb?=
 =?us-ascii?Q?pOs5+2DKRvmFXWN8T0qn4pbFoTtUhQrFse3Clagi1jb30xDT9ULR3OMvQW8p?=
 =?us-ascii?Q?z0tXadiTHYfdsnBb5dfqHVN64FhFK8BxANSAo0GWljHNg6E8hLj+yiyHelSa?=
 =?us-ascii?Q?EA6/wL1Wlhf15yUAT0/ejzyNkqJp19e5gzqNqP2e3BTyJ6q/mgm3FQFlLUhh?=
 =?us-ascii?Q?ketHQ5b0RG9mIzh7o6plVQEqaWNBGdBj5erPKC+VmU9kDnYt9K/UdeC2IJjC?=
 =?us-ascii?Q?fx9Rb4fBEOPXP5JvbFuQLFypvoYiPY2z9OQksCg0B6icvQ57mkO11+ziN3Q/?=
 =?us-ascii?Q?gL6V3i4zcb883QqW92lck5/R46YH3pBF6pzK/gXhmS2iP52bIGULEBo1ZYfD?=
 =?us-ascii?Q?1e91agq23SqFri9+hsOMd2Orz7mc14OygUDjm6GhXOgrHYcsujDQzfzUkTu0?=
 =?us-ascii?Q?03R5xWLXxrxubxHTNv+p00F8+migQula+viUpjw7TSEbH+5a6U87c6s1xgWH?=
 =?us-ascii?Q?Tzkc8Id8SXSOEWFxupqq9lJQ0tQVkyJiCf3VCHHr1U68czsqM7z4EXYTKVbG?=
 =?us-ascii?Q?3EGvsc0QrOpix5vH0nFh4kx/XjZGtOkM6P8IPZP+rcjMCEi1qpL2POe32Xe4?=
 =?us-ascii?Q?n0lghAMTd48M+Bf4U8uoKyFf1v4cz0A4P50Uo/vzZndahkqGt4808DeRxH1n?=
 =?us-ascii?Q?CWvkVFFW0s9cgw37EmN3SD7PM9KBe1Zj47eyDziL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TTmcHladfkCXO2oAHLnwzhX5pw7E4K6O2R1nFDZ1Hi19Jj3fMnF75LVfsw8WLv4Mf3ImAdAqcVUFG5hdvPoOs455c47ejoeAR9rOHdBJEMCBISDyEEOz6wdY+UOZfBfVE+SJZNv49tql/v36Bpu5tzBuEVa1ASDdf4rnqSK07VFyMneNqvng4vFhfSmdrMHTC5Zztn1DiUBP8uFD7CGUPVph+/mVqDHe6pF5bo3OYWKDyl9ux6+696mOejU9Zbn8kOuk6533PgyXqSbHyTcI7KT4aTMliIlDNXjCsaVWWmCoHi2WVvsQ3X71TyF1kiCCJNVNTmQWLgtSxlAQUkff3xoh1Z7pKnrgjMJvrwfyue+NL5ol1hmNYKmhFXC/o+4rRSAbtOu4EYRFtH+SFlhflo7MRUK8hv5z9Iw7WeVdF3p6vjcWe6NpJGohOCJDMHgHgN21C1DGWmsvK/pOHrvSJ/IBl9gEtZgK/J/IT1laZZun9E7gENE8rDNqFvwaF0gOtLqt2Ho2RkrQPjg0R5tRHk2/tapaVeFql2HpDnwJ6yXAjvKzE7NidmaUIcSmfmw5ahcSz9UFhg8MAkQoKbxaTYnkd8NMddooN/bNmcCk6pM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b41e634-8244-4438-eec1-08dc4ca6898f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:35:33.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPoh0Hvt2HPebA7pSHjZDuXyWJBTZVY3/veooSpz3QBau8d2S8h2YxsPmjp+L27jIDU+FjyNUEKViVz8PWujPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250046
X-Proofpoint-ORIG-GUID: MDC3GTltrAm8C4iaV_u1DXOfAj74yqOq
X-Proofpoint-GUID: MDC3GTltrAm8C4iaV_u1DXOfAj74yqOq

Since commit 8e756373d7c8 ("block: Move bio merge related functions into
blk-merge.c"), blk_rq_set_mixed_merge() has only been referenced in
blk-merge.c, so make it static.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2a06fd33039d..4e3483a16b75 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -726,7 +726,7 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
  *     which can be mixed are set in each bio and mark @rq as mixed
  *     merged.
  */
-void blk_rq_set_mixed_merge(struct request *rq)
+static void blk_rq_set_mixed_merge(struct request *rq)
 {
 	blk_opf_t ff = rq->cmd_flags & REQ_FAILFAST_MASK;
 	struct bio *bio;
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..d9f584984bc4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -339,7 +339,6 @@ int ll_back_merge_fn(struct request *req, struct bio *bio,
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
-void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
 
-- 
2.31.1

