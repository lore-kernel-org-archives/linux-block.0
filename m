Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFB42B31C
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559777; cv=fail; b=IroB91lFA/C2LOaLuwLrxVZm3sXUk0Ix4HFLedvhJIgFujKz3ePrLOcpRsbVJkamrgRJMZllVTqDRlk3cTLm1SdRA8zwMXEB4pggnNmWKo7qXD+9sPpg6Ql2hp1AXjDrAvEA+xsO6e9ck3eVdQLoJFfd5U6ABjvIaGMfl9ogFKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559777; c=relaxed/simple;
	bh=RnomIDEwLbJVSFToNg4qVeVMxYfNd9Em4kWyfqxMKIg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ubRFdgHA5oz9GVqKDmtLiGUU3DgfscETSI0V4ku7ujomi+1L+FtKd3bQgADh8PH9xayX9+VTaM7UF1cUQhoXnDkdv7CZ8rSX3DI16w/t2Zm1L4mL9bOuQwtIajsqddROwmCdL/hw+aW1K2GwegnuVtC3Nr0aDHHrrTieujGZTYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jxEFIU2b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiiCuiIf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jxEFIU2b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YiiCuiIf"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KBkQSI1749572;
	Mon, 20 Jul 2026 15:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=67QkbGSedsdMXwiX
	GfADx+vjfvgcrnuTXch5Kk6Zu14=; b=jxEFIU2bsJIjxUwOlDy3Nbqqi+iCJlu5
	HYC4S5upiMhcRrgC3OP4cC+caNrvP4yr+NGB+C7jYJxiqMvL9L9oFlD4/f/uk0Hm
	F31XR5wKSVTGOdwmiZAUIxAHHU9yOsz+wF4lqJUOKTxg9rtlUKSAHAniu5YohCht
	zx69OATycf67f17Fw2Q2jp5eT340aahpt9J5rafBHSeRVO9Ui/4D+k6yjBDT+Spi
	ZxzCQnqphr+pGA8empx4FppJOioIM3VCbZwyicWZJgZh/vqUbU5hLQmlcafEktki
	rJ7gOcW/Vo4ED3K3pMKOoy/COkO82PRDex6zishXuUjeBWjdgGxTQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg21q1yuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 15:02:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66KEwAeb028629;
	Mon, 20 Jul 2026 15:02:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyx9xu50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 15:02:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjAG45pYhj4uOlsHYBiWJZCTsR0H3wqKf39WQx7KHilCutSXRxqVTKA4wpVovUbsL6LiKCYo0N8Ll999rBf7Nq6ZFA+nYfH+mSKWblt3huQba5+TkZZSeb2tfOgike0BcGegWyAgVRtMBlAAEMSEQzZOaNfMjcIsj64SFlOm6plBC7OWZ2dq0ySHHuJ05CHbNM5Wr0/er/advg/ILhj2rL+hIwlg0TaRSo5M1YgGi1uOEWuyecanfP28FxAnHQIe8eAToPSLlpEwAmzGH5WRN6oB7OpULb5Kqo/75cvfjInE7c6eCdFIQtfTTVQxuUViwmLuumtAFfJz44vYkO60XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67QkbGSedsdMXwiXGfADx+vjfvgcrnuTXch5Kk6Zu14=;
 b=VxfAnItLzJAtUr9iYnG9TfgScib+78uUlzW6pFlCsub+5iDEZbRJ0VFvFQYGNXB/C6eTReXGZrvRFQDe/1PkZ3yoBTGYnxfjpGQYqEg5LTPG/sN6LT1zRW59MlV3wM5P2xN0/GABslQAlfu9XQXM9cnb1faxePnM+vYjSEAjWsqDiOMIgpkFT+y29gsF2//W74YzXi+8+e2Ov6QObtY/3QHHff5PcimkWbTalM7ppOTgHnDo+aIGrHpqqb5OTfepdmklvGA2cd7bShrytrvNuYU8zlBiFSId2SMjQPgJ366S3EVBROHXwZK6rYSYHlVGGjAi+XuNDGX1tD0hBLFZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67QkbGSedsdMXwiXGfADx+vjfvgcrnuTXch5Kk6Zu14=;
 b=YiiCuiIfr3biXCgyCQztJfsB8rcAB1aACmQmNQ/9xoQjfFZa6n3NLocidrfpcfSgigaoah8mQobsMyqPDXHHWbfB47ZscwW5XUpQZ8BtDu3mXl148q1fQRmzQrXpdo3WTl5fWgKsHZrOg+bJnth2Z3/1zC57UnttbxC/YidDhlY=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:02:31 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:02:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: hch@lst.de, nilay@linux.ibm.com, linux-nvme@lists.infradead.org,
        dwagner@suse.de, John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5] nvme/069: add a test for multipath cdev lifetime
Date: Mon, 20 Jul 2026 15:02:17 +0000
Message-ID: <20260720150217.1355223-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:610:77::11) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8319b45f-8cee-4e52-bcf5-08dee66fec42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S4LysRP66+WJ0lAVDyGbryJfdEY7w/eVYzaz1PIsjFvccKBodB2Y2hCKdQ4Fkyw8L1NLxcbVs81WAmiubzoHngUXneHeiXCCYUAcBTt67PKs3vDv9nNnxHZ8LfybGmyQ5W7+hCEkojY3WRSlTokOc3MGVw0Q1erX2Ohb1CSO/6Fl9x9Ch4Ykx8R+aJ+UIwja0F8NXNWBOtlNJh6nnhnX1TvSp8dqMwmf75yHWB3ZV9gJa7dMO/sKXCz3zsOqDfjpskxDF+wKO16+Kq/ZmaXwMm7hYTJFSljoXyq4u+rLNtuQxzP/yqaEDtMq7oPqBthmgaJUhBUkhcex+qzvb4MaaIWVUXvjbfkg6oEZx8rEo34MKLOHfw8Tk59Hen03iYLk1nVmVH7owTzzN7UgWjtkZZceHs4pyaC/E19dRCypSreB3f3Lp9Tf7KYYJyDNgIWGoRn1nKub6nihVbLBZUaRJAikyMi+Amc25xXFAae/+kp8SRnxxxetE+Rad8rPMGKuUMLJJ7hEzIKXsNiFs+etTa78A8iXJfbMH0FW11oAy//xz3+OWWHa6CzmJUpuNiPITERnhUgaM1TDB24WB21btX7WKOFMpUGvDsuxjAB4u2Q+btcaeKyLZ8YmkRF+7DmcVIGOHH8B6TK0nMX6BHyOGmnKjDyjsYeMhlnTmRFnTRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hcbuxmy9TwF5FwlKwmfTUGaqlh5gzTxlZ0Bp2qN7+u519hjlRba6fyyzLRM6?=
 =?us-ascii?Q?spkAOemCIvedrzUvBEaoqIjIBbqSA3nIcaFOX/oqtF9788a1Kc1pzzqAMgHz?=
 =?us-ascii?Q?4y9aE2+ksBpr6n5nalUQDS52PTz/OtLspsmicO6v6xPJyZWraso4ebp27mla?=
 =?us-ascii?Q?AXq6poL2S9XqBeAI7QCaJ3fPHyJN+olOFDb9Ie8NZNljxp+Qd/Td3IPqT+Di?=
 =?us-ascii?Q?xZeexg25d7K2XzCKKx+eJ0E6rbk1w0I+Q3QCCcKHxr3GLx4RBLsmqe2RnoyU?=
 =?us-ascii?Q?Wb98YE6xy8KZBtJbn7nseu4FIeCLsR0HqNlvfc2a26KPJV9cBSz39rzw3XuJ?=
 =?us-ascii?Q?l8gBn8St6RO7Cmxh621wzVRlqaKKY/2BApjz7+YJ7jamFc5lyvyiMzzDtuy4?=
 =?us-ascii?Q?kdcheBU2rGMQFPEI/RsSCAjlI9GgjzXsO3lItoE8VyyqYtyzV0Xdg5BOjM+C?=
 =?us-ascii?Q?vNUUXYMVTDwXtGQ0gUVhiDhm9ziHK0ShymKCdRuimZjLpi2QietKYwt0lpfT?=
 =?us-ascii?Q?RJUlgpiD2IzmqG0psrRfiMfqlfKDRmLzYbp9dg4JriPFh/c8LzBuPKV13Bzl?=
 =?us-ascii?Q?fdV0uJUrLro2SBxAohedIZ6aWfLYfI4o22MVQ+0yayZE2CeRbJN5Fo0IhzaM?=
 =?us-ascii?Q?+zQ3RhsFmiFUFjSFmrFRF/UT+wGAJpJ/NcISOSLSaIezdLCaQ9/7oBNY7YYu?=
 =?us-ascii?Q?gF+RzGpXSMgq4z4NvmtRAzNFEJJrSIYsx3ZwmB/7SseN1PELYeBJD8E8COz9?=
 =?us-ascii?Q?gN2lCdnTSSnhhIytnS0fdvF29GhkaQwVXSom12N4CNFWUXCiU7DdpP/axlso?=
 =?us-ascii?Q?ivym4MQFGgptTaiJdg79lFTg+j8GzrQD9Z6ZTFw06VAXuqtMfW6HEIa26bEk?=
 =?us-ascii?Q?+RiI+lZdHqY9P9BbzxI7n8QBiLYQc87N9ntuLLaa1Lllp3RjiZjGN1l6UnfK?=
 =?us-ascii?Q?yVmcO61H9lokMhPBWr3+kxID+6q/VzpCESOVXmZqaQ6twdHqy8We3K3QHmN/?=
 =?us-ascii?Q?cZwRVKexgKpKNYHpvFFlUb6KZIfMQYZGI7NZXfzWcp27aXoBRKRNTuiCvw3P?=
 =?us-ascii?Q?PY6UJna4uxMvOnBIBc13NDgzlvVHhUpyL/58+fECA5RhKN9RQP/Da655fV6i?=
 =?us-ascii?Q?hpoNsr2hldKoQDTvkZ6xuqnunOdAq8sEA03JECIHCZjryONOzMQtJuMgXFnl?=
 =?us-ascii?Q?e3U+eh5obZxn+VzAMPJ63c/61hkp1WPT4ZbEkULBX/smB6z0+IX0abbUBaNn?=
 =?us-ascii?Q?7sheXQR+PgEsWVz8akEp2Vol8vbCF/Bf1QlJ2upxdwvhe88PfnLfneb689is?=
 =?us-ascii?Q?isF52OZcckTFOFs03d6sN3SGKDtOYH2SPDy9L/nVp/BbGzkafFr2Ynm7PiBd?=
 =?us-ascii?Q?anr1OEM31aQPXSptRfWKjcBdu+fzIceNwzNlealEQkEjfpFUkFI2qURpqC4O?=
 =?us-ascii?Q?SCId1z+TKSHmkV1AIewLXrLL05HegbSXmdoHV1BiQldDczOVOng93rcEZ5Fe?=
 =?us-ascii?Q?g03eulZ9owJiaqXhZH6fVc4DyEjswr/iFUNQU2mBxk/Kx5gsq0zk9qi7EFvF?=
 =?us-ascii?Q?MwNAuXyzTthsurzkKveAOicO8awFaBTr7DEsNq5gw7eji5XXKo8cq7UfqplF?=
 =?us-ascii?Q?QpoP0OZtgNtW4Bwf1NfrAk7KIcaB77xQzQG81zOQ5LZ6dZVyGHTM0MCNBF6R?=
 =?us-ascii?Q?73I8yAn0w8KjJ9uFECHAP1T3EIJaNKJZySHJ+qM0jJ8Rf1d9rzM9DrcjOl6P?=
 =?us-ascii?Q?9DVxlbCGAw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	RfWBwBrLynVSAtItKmKB92IFbod4TySp/aZJ6Pd2eazi7JA7grgZ+QnxrgTL69QdEv7HYcajqqz8NDL/lQXFcLhXkWs7nCWGi4sxUQdIgBYgcl8QOv6qaNKq7FnVT2DVX04jcShxsiM4Las0it5Sq3URG8ucbUt5to0IdPlKgcqKEATZ1XmYwSxY5ZImDqHGLNbIHqLZ+eMJox8aq4I8haZRXhD73ZmwuB82Z9Ij27ly5nwqdTWuzH8Ty76Xtk3A3BYUTSJTBF7XVfTo1CixdgLDItvBXHOyFUJx/lOsr4TYYNvAO/umveZBdBcYyemWGgGg7wMWaNeCK3Lrl2zxug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mZ5DCTnuzoDud8dFBOtQrpBO+HqlCaVaK+ISOiUzGWQQLKIBGSs2JrYqZ2tdwjUmqIaL+EfN6ifvjoinv5YLnW1/qOaQpWoQiSBq1Io6n3v20+ktwi3iToeLhjxfJ6qk1JVQq+baEVQz8S16PYCVu9XFzxNY+DhTEyYa0wrDQzKS2sKrPUurtjj4h4lgZbJYfYkHtJY8ejbzqbaSpD95dMRp3weLUb4LS78sei3Wuv4Tk/xGsO+s1O8as5VsipgvChSPxbvkzBLhx8Yg85wvclFlfx29rDj4oAYQtyrl6Td6Qk6cjS0R47rEp5OXZopF3+8F/ePMuAIMQzv1+/sSxK3BvQiTydqqujs1MHhC0dHstaGxhxb2IWa+KvxChd5Ma6HLYCr+Fx8JU2k0j2a6xIyoj21Y2NgmHuY+byzDf1g14nvs1L3GGUovl3dUIIt3EZQ5fi/BxeUu0AWcsYlWYwIcpNJzfUwg5Sk6EoD4GGe2ES6vZcmwpPtDvres4iqvIJxBxPAMf20fS/0S3QbWsWOlYuGFvK1acm5ruucMTiOu8fQAW1amRBI8r063ZcKnhZSq3nCQitiUqyL+g8u1QsK2gin2zsRlWJyMIyHk6/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8319b45f-8cee-4e52-bcf5-08dee66fec42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:02:31.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpVcouGXexOOnJwkPx/MIp3Dw/caQzu9bRiFnztQ54/2qJRTcXhpWrx5/QHF9nX5MKW07l42kon4cwIo+e/yCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607200167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX4qPpMUizOwIb
 SybrQkuBlA8M7k4ZP56FODaL8EpIqgw+YKY3KguIv2k0dFpncwVi3bmy+/nunxr2OLlT0H9zwS2
 Jhk13Tu4OL2mzG3YRZewW/AQCBdhieVe9CTpvN/KC9Vr8iNGpIRHFQqqrLGKsxteULfZ9c0LFCb
 N9ZeeFrtxfXG1k+0KnwqSoIIPVRQQwjPkX7HbZc0Xmuw2sssqHZZBskwe13XA53oer9L9u5pygx
 hVFZEvoJrVtFzTAg9AwX+ZUmOaUI0pk+IPuOOOilL5gnYRX7S8rkeIriOo4ylPJA8N8b0bhskxw
 1rWJcGg1H1rOHzEyXtkkIVH5LEkYp0pe5k+ijYoaWMuYd2ySezeM5sWEGnHV5ce7NtImB5V+ZPd
 ZJfEELuADV+6nYygydC3JtgHZC+liS5oCm1pz3WfTyYJLsNJzHYlBRjX3KJdlSPQYZG/4o3DbmA
 PrLntE/IgqdRIhOZKwA==
X-Proofpoint-GUID: A3QHz9A1kZpWjlcKLporUznSecdC-Hj8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX2cvwWuYFOZon
 nsI/e46NnivzWzfl3GwWZz3F9wFq7XgI7HETeWYiT/qqHsTpH76lSevvw+25RvhsVmKMueSYMaH
 VqzP97X785TxU/J70Ae8+Kos8xJLlJkkjqzOjhWuzmHGx1tWwe+j
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a5e388b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QOYSxItt2YxLaTtbhTcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: A3QHz9A1kZpWjlcKLporUznSecdC-Hj8

From: John Garry <john.garry@linux.dev>

In [0], a fix was proposed for the NS and NS head (multipath) cdev
lifetime.

The issue was that fds for the nvme-generic cdev may exist after we tear
down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
use-after-free.

This test recreates the method described in [0] to expose this issue
for NS head cdev.

First a fd is created by opening the nvme-generic cdev. Next we tear down
the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
the kernel fix in [0], this should trigger a KASAN warn.

[0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Difference to v4:
- add specific error checking in nvme-delay-ioctl.c (Nilay)

Differences to v3:
- Add RB tag from Daniel (thanks!)
- Address comments from Shin'ichiro
 - script syntax
 - add copyright
 - wait command tweak

Difference to v2:
- remove sleep and use signal to sync

diff --git a/common/nvme b/common/nvme
index 15e9c3f..42301dc 100644
--- a/common/nvme
+++ b/common/nvme
@@ -300,6 +300,27 @@ _nvme_wait_subsys_removed() {
 	done
 }
 
+_nvme_find_subsys_nvme_generic() {
+	local subsyspath _subsysnqn subsyspathbase nvmegenericbase devicelink
+	local subsysnqn="$def_subsysnqn"
+
+	for subsyspath in /sys/class/nvme-subsystem/*; do
+		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
+		if [ "$subsysnqn" == "$_subsysnqn" ]; then
+			subsyspathbase="$(basename "$subsyspath")"
+			for nvmegeneric in /sys/class/nvme-generic/*; do
+				nvmegenericbase="$(basename "$nvmegeneric")"
+				devicelink="$(readlink "$nvmegeneric/device")"
+				if [[ "$devicelink" =~ $subsyspathbase ]]; then
+					echo "$nvmegenericbase"
+					break
+				fi
+			done
+			break
+		fi
+	done
+}
+
 _nvme_connect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
diff --git a/src/.gitignore b/src/.gitignore
index 988d785..af9ebf6 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -14,3 +14,4 @@
 /nvme-passthrough-meta
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
+/nvme-delay-ioctl
diff --git a/src/Makefile b/src/Makefile
index d75daf1..4779ffd 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,6 +18,7 @@ C_TARGETS := \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	ioctl-lbmd-query \
 	nbdsetsize \
diff --git a/src/nvme-delay-ioctl.c b/src/nvme-delay-ioctl.c
new file mode 100644
index 0000000..28c4956
--- /dev/null
+++ b/src/nvme-delay-ioctl.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 John Garry
+
+/*
+ * Simple test to issue an ioctl some time after opening a cdev.
+ * This is to test lifetime of cdev, and whether we can handle
+ * removing the cdev while we have active fds.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+int main(int argc, char **argv)
+{
+	int fd, fd1;
+	int count;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/ngXnX", argv[0]);
+		return EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	/*
+	 * Steps:
+	 * a. Signal to parent that we have opened the file so that it may
+	 *    start the teardown.
+	 * b. Try to open device until disallowed/gone.
+	 * c. Sleep to allow nvme-subsystem be torn down.
+	 * d. Issue the ioctl on original fd.
+	 */
+	kill(getppid(), SIGUSR2);
+	count = 0;
+	for (;;) {
+		fd1 = open(argv[1], O_RDONLY);
+		if (fd1 < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (errno == ENOENT || errno == ENODEV)
+				break;
+
+			perror("open");
+			close(fd);
+			return EINVAL;
+		}
+		close(fd1);
+		count++;
+		if (count > 10) {
+			fprintf(stderr, "%s still present", argv[0]);
+			close(fd);
+			return EINVAL;
+		}
+		usleep(500000);
+	}
+
+	ioctl(fd, NVME_IOCTL_ID);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/nvme/069 b/tests/nvme/069
new file mode 100755
index 0000000..61f796d
--- /dev/null
+++ b/tests/nvme/069
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath nvme-generic cdev lifetime behaves as expected.
+
+. tests/nvme/rc
+
+DESCRIPTION="NVMe multipath cdev lifetime test"
+CHECK_DMESG=1
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+	_have_kernel_options KASAN
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local nvmedev
+	local loops=0
+	local quit=0
+	local nvmegeneric
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	nvmegeneric=$(_nvme_find_subsys_nvme_generic)
+
+	trap 'quit=1' USR2
+	# nvme-delay-ioctl will open the nvme-generic cdev, wait for teardown,
+	# and then issue an ioctl.
+	# We tear down the nvme-subsystem in the foreground so we can catch
+	# if the ioctl triggers a use-after-free KASAN warn.
+	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
+
+	while [ "$quit" -ne 1 ]; do
+		sleep 0.1
+		((loops++))
+		if [[ "$loops" == "100" ]]; then
+			echo "no signal"
+			break
+		fi
+	done
+
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+	wait "$(jobs -p)"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/069.out b/tests/nvme/069.out
new file mode 100644
index 0000000..cd2e1fd
--- /dev/null
+++ b/tests/nvme/069.out
@@ -0,0 +1,2 @@
+Running nvme/069
+Test complete
-- 
2.43.7

