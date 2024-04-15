Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952770CB2
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183661; cv=fail; b=kcUE2kegZ1kHfjBMvLRL8IDC2o0GWJMndfNYyWESmm5cSxf94qp9WizbsnvWsXqs7zth33+0zjjK3L533ASYQyBGJ2wi6WKTOryx0qvbjjumCu9jOsUjpMIoi+TQmPyZndVRPwHgoh2+HLU/8A+iJeohYIEXNHX8ZfiH2XJ+4Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183661; c=relaxed/simple;
	bh=YFHK3gle/bxehtu0rzoUiM1ubIvMMg2ICw28ZV65NOU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UmREQV8RbPjMJk9z8uhUiPVo65bojiAhkQj9qIV9oUYjbnEslNZBdmYRCcJ9tVQ4ku3rYmX2fmuTHvBMXp8+wV7EHpwZllhtnfPjbvp1vGkn42C/rzpKtVce8WYP53yFsrhwMaBMfWJ01Q+4YR+gjyUal46QRoIYSUbyTL4+yhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHGlzUNM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kR/2E/LC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHGlzUNM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kR/2E/LC"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F1xGVh024944;
	Mon, 15 Apr 2024 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=HUHKF0czTLYajdhNlgZVHmcL6kmX3U9QvHI+21Rkxds=;
 b=RHGlzUNMKleE3NstSFTsFheH7eP5wwltPIZloLBFjCHE988z3szJbO0ufARIodfTQ8gc
 DYZtOonuk3nBllkAn2InnPH6dQlGyneTJxo4ISDZgPW+XqOscUkHsntV4MKCcxDG2Daj
 dQGC2aptwt7ycbxvb4Vk5gWuM61hMnzHtviYzoD/btgq01uGjVUv2dtoSiU4nuPizhcU
 ynFJnfaaAHhgclllWpXzSM6JQN7dYlgOR1Ct7icYnplMjWDoBFWHZp1wufoJwrk3AaSN
 S92ubvhiI6q6JNgBDOEgQEt39F2BOwZLN8WqSAynF+W3kM5J0qe9aQHzSWQB7cOrohJ3 WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffanu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 12:20:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FBgF3J012534;
	Mon, 15 Apr 2024 12:20:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwdj8r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 12:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCtI+tqBau65UJX1gX1K7ScGpgpBiTBUsjEcMlZnt9hjQmR0yRQ7i/mHreoQ2HTBe0ESKpupSao6GkAbOPS5Vm+SG4TuE9bSJUar5rNC8c35fueZ2VS/9xHXD0WPtDsWrg7HZZ8FGUdexkoO9SAO/RLP3uv2EC40f7Lo/5PYRqbeoOcaSNHk4uP+PY0JfSeevV9DchZEw/+YyZL2lr3m2t2zOQ6qbwHLEu+EgkmRnH3FZzvwE6qB9NpjeTWJEl5wU3EoL825MlYfkeIYRNj9Fr2UbKgnJP2jOw7M+OLMDFg/QIPYOvodC7KIVW4nxFXJl86Pj5dUyu5H+Lcaj7hjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUHKF0czTLYajdhNlgZVHmcL6kmX3U9QvHI+21Rkxds=;
 b=CSQzX+DCpG101W/fDYxDUj6Jz8dqgkKwM2SS2SfIjngM/lG9Q8MCPLNU5ajLOhM2zESb4/7jikcGIURIglxcu2Fn/SlfaVlyR8whBC1W1rpyrJZWeAh8/Uxpc0fvVZLaJmtb27zzXYUcZmi4k0dj9jVyzz7XeYJk85+/DtTI8benWFQp0QbFgNe0XHwl1QHFbmqf8bE+7GcU9qtiszMDkRoI9QN7obXwbM2uQ/rynn0mxDggARymafSV1e36mtXeDIPSlclnUBh2T5NaZIco3UAIHUGSL/uOE0Xnadz5xio+NI7feRFaU8f8HOOn/MGOvP0Gs62Au44SyPaqCZfUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUHKF0czTLYajdhNlgZVHmcL6kmX3U9QvHI+21Rkxds=;
 b=kR/2E/LC8q+UjJz4mlfMJlPC4fyamfC7CC6tlpP/G3BQ2rrAHdvYCbMhB8vFsIcomvTVYY+QwjLJoYM1co98wqa638XLpuo9llx7L1mgcb94Z621p2tLsGCTr7U7VFFjD8POT8puCoi0AP148HmWdnubcw05sOO3FM34pD3Ojfk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4927.namprd10.prod.outlook.com (2603:10b6:5:3a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:20:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 12:20:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: Call blkdev_dio_unaligned() from blkdev_direct_IO()
Date: Mon, 15 Apr 2024 12:20:20 +0000
Message-Id: <20240415122020.1541594-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e2bd73-b5e1-4087-0637-08dc5d46795d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8cScdvVO0Nx5VAnTuSQ0uzog3InnAOV349YvKEqjlH7Sp3/szVfp07oMM3UA5nWw5rDeO5so03OU8pxvGSbsrxEsP/nkPxt0rnjRt+K47X7dY7bTFUtdDdNQ/Oyj1dSj+6cQmK2+SHmJcMzL1Gcdyn5cGJaMUd2N5HzarG4gIqXuK++v0WqcRUAc69YLhkL5OL05o9leZvLw3/kXyG+hFap0mWH35Lrv5dMEOmmu4NR5LeRjStQVn9JSqd6QAI+uV66JtKex77Y2Uq7PmyCOn7twNSChv5oXX+aVfKfagmRev+CIfW9OS1y+dyc1lTY6YTjE/WyCryELj/2IvoiVF+VDXcT8rIca+XdX3zq/rNNC+vHxP0kv9Qjf2aVlzaw0r9d252d0f8RMQYVCNGmFfHJDg2pW/x1ZZhMCW8H0h0T4/x6bu7qZTRcW6SUOVTSM6SXJOKfum4HIlqGalj78Q6L+sHmzAR1x1Zu3baRKrCrQrv5buzj4CJU+N/fPnNpeuuLT0zrEaGlDsfK+fJYSL8oqDgwkxM206UWZqcBQH7xNzntbnTxf9OlXzg53jrQEbAmXoG+lg90JaZcuotnt/VwjQpHuFLjJ/i/u0Tiw9Omkif0f0dO5FDISLxE9K/8WYIIkW2GN+P4B9qfOMObHRbI3wRxlg0FG9hMBv/jBAI0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ds+3HmI9GzcqBcQFmLStpy+XZyHztBaZM5zErTOmBb+bCJmvNbWhA31c1QDR?=
 =?us-ascii?Q?BlzIb5PcWfYUvLi6zJPES61qgEASW2Es3VEzthZ6YVkCBv6NXaBt2xdGE+0W?=
 =?us-ascii?Q?RPL+TAiRsVImjPHso2qoaxYSLfYHaH9Qkgi/y9Q8iXZuZcIkYwziO6TVcM1E?=
 =?us-ascii?Q?17Q8vrtuAcEOwFkO16fyTGV0s9pDwSg4jOWF2tD+69P8mCIUH0YtGydKev4h?=
 =?us-ascii?Q?5UiQsm8DCF47BZfdPxqL70gE6Y9VhWgnzNrWd3lU98SUhuUBdvSP4Lp1CkI6?=
 =?us-ascii?Q?QmB++cG3tIGiDUKR8TNGmBJ1kuvtLQRbZ+/p/Mrsm2U4A+ctoDvVsuqaXoXa?=
 =?us-ascii?Q?Hv5e2AdbQUyP4AMdyvVNDtjS9AH1ZVx0UBe4YMyVDcW1EMtXbQh78iGmmeGl?=
 =?us-ascii?Q?83GWqKN2dkh3mGHjZdT7BiXRkkVmKBWnQBFZYhFxcYC1ktj3vVCloxYvpUpZ?=
 =?us-ascii?Q?JKNXDFS1hEqPWnUn8+lDQUQA2tZiP3U0GbhZmsMUkN3H+bfXRDQsjcXStfeb?=
 =?us-ascii?Q?eSL9Ox9OGs+7HbFPAKfW6XfveFc+R4q1hLEFWvesnbD+zoPwF2flzrwlQ9si?=
 =?us-ascii?Q?1fMt1YS89pgItGKZnc/IqXgfkhd/l/UNND1+IO9nZsU3WZaOX5jAkEeMenUi?=
 =?us-ascii?Q?YaBF5w7g/xMPxLJPNvbYXB/2NCatTlGPQfNHPrZIqICeKKHxKMs+ocXEZEJA?=
 =?us-ascii?Q?S57o7BRq4boeyyWYutpi3O3S+4TeR+SEL08qGeMn38f9IWnF5tskE/V7TJRh?=
 =?us-ascii?Q?3bjZJJCC9mwBsESCcVdlROkN8bjKCn56yTGKCNYgbNL8K495KcC4s4IRHck6?=
 =?us-ascii?Q?2bX3/lFOeeU8SXEMoRyKXZE4i5L/Rq1/1gD2oWQMtxoulyMgHKdU4y8/S5Mi?=
 =?us-ascii?Q?zwzb3SkMeYj0+c2tbCtsswWM3Yp9tDgzWFfp9LJzywmykaF6OkcVzLlYinRx?=
 =?us-ascii?Q?wunZN0MgWlPqvnzzNPDcAr0i++v/yuKWClrWh4dll8/FeOdJ8xlS8WhT7YZk?=
 =?us-ascii?Q?WMI1zb7ds2hnOTKDDZ3Cgx3fYQ34bsRWXJRnnhufFpOTZXy5klFIuj4VA0yf?=
 =?us-ascii?Q?ODN4NLHIc0Fz1aX43hyT6oLFV7NqqxP7g2mkRIWZnuNd3y9R2bTD351OGUni?=
 =?us-ascii?Q?WH0J1SkMtcXbUmJUYWIA38VCkFJT5bnCgYnD+DVglrFe/MfjMPdtyKmb0KSy?=
 =?us-ascii?Q?H78x78E/02zQRcY8CZEW8wH47xLJ8Ex3JqD0vCyNgBEZJUl2+5QGBC94EcCS?=
 =?us-ascii?Q?e2fY4YIujAnv+ocwSjlIdk4+rWZlFROvvgPJ7flTct1U3lOk1nmFZHvYcze/?=
 =?us-ascii?Q?AdLBLSBr6Y76l01qNcaYu9yJ/Ju0yosUUhHYRDeTFmRa03S43W/6zlCb79Dr?=
 =?us-ascii?Q?Ttnn5D9QL7I9YQh/BJb9TR4A9qjRjNT8b3vX+ikcJSUouir31wIhNxUrHpbu?=
 =?us-ascii?Q?5o/xBBeDwQSU9aaKu8ECEqr5nTyPRKhxfuZNkyPcNT+Rpw9l+7tRdkENIAo5?=
 =?us-ascii?Q?PMncT4nUTKKEa1+4zzGesrYxTHSyMUsqXxLfLhlF6JXzcRYDN5XYNz6YVXuw?=
 =?us-ascii?Q?7QE5lluTQFEYbG8cm6EuFSwT23QDgc+A/WGP3jYH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XKR64aqqqVfpPClnTIyonCo7gsZsnIeUBLoKgSPBh5xf9EQ61IfxeIzFkSfsncujlKoJynvzDkIXCdTjul6BRoHACHwTulZ/TFALh9lLrDO2+Ruxc8SMbMP8//qkfjcwPljrbWCZXHYinfP0lk/ERfNDPdr9EhcMZ4qLwEVzz4cxMjIR3lDy28zLA0vh5s9VlwN87j5pqwlByLbU5wl5VRGOXnss8wGMUWBDYC0uyb1IxHSuACgWnSuCEOFMOE2TR6euBKNQsN9G+syPjbYQlSlqgsUSVf0XidMzhC+anNfdQzG3/0xocamyca9JLGtdv9GehPLHpqEE2YeiraleytG91VZDZRq+6GnkLr27h0FTGyo/ajgNgCag8nEYuGB5koczu8FjjxKHZOINCJ/bfZ+FyTS6Of6V2PDZkOr+pmiKU4jmOHgn1oWGqzN2NQFgHd+W8FR7LK/sNE69J6EVqOTGiPQPkQlLkNRF4XPE2pMJc4XL7mklIy1zqLMaMh5vsYdhzyf3fx14uYg6yisJg9XxqD7QaDCPG/1Ezm2AsyXTKean1jtQQVCsMcjTH95/N3t3sZvGpOCQ/Hw4cIGjIuSonbEIbLK0pw2dT9zA3Cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e2bd73-b5e1-4087-0637-08dc5d46795d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:20:44.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrKsLYeEZM4qZV0US4uOjkyZ6IajhgKXXbh3vfHoJGhjWSiDEXkcZKz1QvLyVlQ1pAA6WzPDe/OzJrpTyCOBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_10,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150080
X-Proofpoint-ORIG-GUID: tMJ5KzdmE7glRxIWZ6wVSdTU2DgBfN_G
X-Proofpoint-GUID: tMJ5KzdmE7glRxIWZ6wVSdTU2DgBfN_G

blkdev_dio_unaligned() is called from __blkdev_direct_IO(),
__blkdev_direct_IO_simple(), and __blkdev_direct_IO_async(), and all these
are only called from blkdev_direct_IO().

Move the blkdev_dio_unaligned() call to the common callsite,
blkdev_direct_IO().

Pass those functions the bdev pointer from blkdev_direct_IO(), as it is
non-trivial to look up.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I am spinning this out of the "block atomic writes" series to clear the
backlog there a bit.

diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe8..c091ea43bca3 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -44,18 +44,15 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 #define DIO_INLINE_BIO_VECS 4
 
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
-		struct iov_iter *iter, unsigned int nr_pages)
+		struct iov_iter *iter, struct block_device *bdev,
+		unsigned int nr_pages)
 {
-	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -161,9 +158,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
 
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
-		unsigned int nr_pages)
+		struct block_device *bdev, unsigned int nr_pages)
 {
-	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
@@ -172,9 +168,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -302,9 +295,9 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 
 static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					struct iov_iter *iter,
+					struct block_device *bdev,
 					unsigned int nr_pages)
 {
-	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
@@ -312,9 +305,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
-	if (blkdev_dio_unaligned(bdev, pos, iter))
-		return -EINVAL;
-
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -368,18 +358,23 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
+	if (blkdev_dio_unaligned(bdev, iocb->ki_pos, iter))
+		return -EINVAL;
+
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
 	if (likely(nr_pages <= BIO_MAX_VECS)) {
 		if (is_sync_kiocb(iocb))
-			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
+			return __blkdev_direct_IO_simple(iocb, iter, bdev,
+							nr_pages);
+		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
 	}
-	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
+	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
 }
 
 static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-- 
2.31.1

