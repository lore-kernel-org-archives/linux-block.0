Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96428E0F
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304037; cv=fail; b=UkNX0TuHoNzqJLUQTxs2zq/9aLCbEJ8SY609x+isksh8WxSkhI1G9S5vYSl6IO9pEbCCdGB7HDi0BBrBOckUeW0820JZIw3T0+LBZRqmfVQ3XtIHpimURtq14mgksTb9JLqmIOWSGvptGvSUZ42frYgcUkjWzfnQESBTsOj4wdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304037; c=relaxed/simple;
	bh=BmyiQi91MOrZVEfyjHKJJbra7jNl135xZfekfwGyGNU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=YgWzmlPeC8EZWD/GT6Io1vb4iusUrD1s5lW7NK15exvD2s0uMF03b0AcfJTbVuruowmCgYuK8+kI4DZNAwE4+F+wVxhKRmebw7WV4gNRs8CNCUiB9VQUT+LLJOjbUG5YBdtRTBzNJqcjvM2ETXNF66YVhgi/vrSDn/iZeGHT5fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxqAlT6d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gc/VZoUI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxqAlT6d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gc/VZoUI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O1x9qT196246;
	Wed, 24 Jun 2026 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/+/wlIdjwRh64cH/XE
	Z7fW90MPkN2rMG2POe3+ih6sQ=; b=lxqAlT6dVKdPvluZT6wko+q0DtU4ERDuwq
	ejWVJe6n6pJeHajnRkMCMu8dHqHoZ0P92ZEQjzhkrxVg0oyW3tj+c4Pb/PDgG3d8
	6etIjDbZ8Y07Lg/vs01V5uUEPMNKtzsZNQxQfetHhb1OIHb7Jl1fkvf+GILAwLA3
	qqVd+Aiv1xAjYSWb6Op4xCOkhlmqUFUmXU6rn5njTkUW+WYD8p7+6kcK4/ja+DFf
	LNB+SVnf1nF1m1UVbRJsXlXfmLGfAjJbSMIylL3sL89C6ePEXSZLX6acmJiSc1xM
	RuGf5mrucmQnRRd8kW5R59dEtxaX1aOjniOf4j2dS+g15yHv9NAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjwcdcgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 12:27:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65OCNgM0003398;
	Wed, 24 Jun 2026 12:27:09 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewharc7yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 12:27:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7WtMaYSAPcDHbjib7E2vvyaVN4we5G7XLgR0OCGaDO6ZddhIE07nUYk4L1sLjtWQrGbk15WPtE4lg3I4wNbhIgxCJgiI3/4RiwVprNAJpQ7BFtJtu9ps6feTyd7nXkDl+hf/KwR2UmfRKn1ug8O28nWQEtyii3od+35BJDb0QjPCwKjPbvkU8W42gRgQlYeFfmI3YDUXNoOeDMHr7U6YEu2H28xg/WhyxlstRBWsXnSE30lBOkoMkmIln9Ld3dD8jV/gMJbtrLtzxgPY6XFK7sN5rR267UDWRhL58hZUKvoR6wVD4Y2hpCW789pgWfHagO5iut8u8ErZXtpyBXKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+/wlIdjwRh64cH/XEZ7fW90MPkN2rMG2POe3+ih6sQ=;
 b=G+Xhjq8LO7AFeJjmNq3T+xEDddtHSb0jUzbeTJk3ih/JpbiKjioihv+0k5P+dsfpvOIV0mfkI6AG03PIgW6WbCVaCix8A3uoVpu7zVFQX5lsvN+84/kZwfYrBcZmexzq7ixUc846KoA7SmwU0rO7P32NgE8BuPbzCxl1Ulh6UjyUsqbUSghIsu7j3sHOhLhKs0y7AFwX5zFt7xgwVr3ev+xiKoDVATKkzA+4S4j+5BGUcaCh2zKJ8jIz/9bYlDaKwmSLKT6KqVFyLQyAQloeTdOwbvMDIDKVJ+PHv2RPHppOAgseIShCPIlff2D/xU9FZaoMfer3WPAO9J8IRC97Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+/wlIdjwRh64cH/XEZ7fW90MPkN2rMG2POe3+ih6sQ=;
 b=gc/VZoUI5cbJzh3ANG4qv2BH7R1f+SS9g/iQyf7D++siJ+PrGKPoWp2xwefPi7bd1HMxQ/+HyLKfbU+ALlH1G65WJ3l4GQo2zkKHiQtEVGVC2ecnY/+b/0Tpx3cJYSbS7oZQ9AFANIugKPFam6xZL1d4mpSwhW89Qx2Tc8C+FJk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Wed, 24 Jun
 2026 12:27:00 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 12:27:00 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Caleb Sander Mateos
 <csander@purestorage.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: PI fixes v2
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260624080014.1998650-1-hch@lst.de> (Christoph Hellwig's
	message of "Wed, 24 Jun 2026 10:00:01 +0200")
Organization: Oracle Corporation
Message-ID: <yq1wlvop1k0.fsf@ca-mkp.ca.oracle.com>
References: <20260624080014.1998650-1-hch@lst.de>
Date: Wed, 24 Jun 2026 08:26:58 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH7PR10MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dcd21b-5de6-474b-7ad1-08ded1ebe3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	k9jb8tuEZXVACapil6+f+Cr3eVYov9r4j0LSInyTK0ur2XrHEug4DUVHttoS0MI8TQjJsOBlCnyP/3nkwZ2F9eiRSKp+9kryqlaXGktXOA+LJBaT6NnRJP74Lp2irIhEcceaV2a0aPGbuAVSdehhtlnn/AmGXo9Wm+vxpQux7enSCcsBekMCXnVzuqiM4CWUijwITWTkq0OfEWz1C1+8JAYsSQgdWKfw11lF0mbvr63urmw4rcrzWTYYlN3j0n4B+089IkrRPatysUtR/wh/qrFM+r1Hq/Ag26claP8cyJewrr54R3umtkYaflv3FatG2jDCbJAgMKVOyv5MSLrOlU/oyWF8LhDct1mrjS96aIZ400Z0u0VYZRRadlJDwWfWmQUIK0PxW5NDE2ovXYrRE1gjf1AnYq/LZMpEQxpkj09y6JzqkMyJgfMXDq8fPkTVqWc9AA3VQRRQU3oqC6FsLdJzk/NUdpRhjBpkMyuQqVq7qAp+/UZQo9EYx7n82tO1g5+hVn/K10uLPI0nib1oFB6BFuF9HcHmGCPcqBNUUDsRxvK+cJc5o/94N+aB0Eq/hOZ4R5xOS4uT5iOOtJublSM2fTfgM9H5lhCgjMmbqHI9DYrKWJSuFHnp1RvjP6+aYXzE97TV5AdEspf+yF412GHsLAu+6p/tuoFCyDopidU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/6tmgOG/w2zqUhRZ04flb3ErMMjOZPj4krwr/DpGHjIIpGZU/zH+ArelVcd?=
 =?us-ascii?Q?+vwp1H3c35zPUAeG9mjdQm0cFCoQ+Zi+Sw86CmvE2MiDpLs/4LY5A8vTsmSZ?=
 =?us-ascii?Q?I2/9Rmb8/tDKEtumFo+dBC27mwflca/hbnfVTM2pqsx2/TIBPC/MtKn6cRRn?=
 =?us-ascii?Q?ULdfkxM78Yh7EjUkoz+1gtVBmVYBK1Dvc+lbScDuMBvF41Mn/nClt0YlSWXQ?=
 =?us-ascii?Q?IORqkBsk03i/1Fjv9cTgGeHrDnsu5BSePzjY62CRU+elRgr4ic+ivINVEy7A?=
 =?us-ascii?Q?Br+J6WgCqSlEsV/9nngjvt8DAMpcUrJV6Obn7RkxkP0RbF3i6ic+M8eyoOZ+?=
 =?us-ascii?Q?jHtzgp0M8JZHTXBhIjAxIWl3giRvZw3PGbgxv0cby5KU+f0jgf5fAfaayUIp?=
 =?us-ascii?Q?dk453pTF2rJ83r+Ga4vwnq2p3Cw3Tvzia+f56+wX2N8/c01a7IQGEMHDInTO?=
 =?us-ascii?Q?UDRDQ3YwbMXOrKQdphPmidVpBaPLtyrMlJ+0gqDX4OvB0q5DOiw+K14qYGDC?=
 =?us-ascii?Q?pKJq/3idyfmMC6G5EFEIHJ2aj2I2hH9RtvWvTJJ3ye/CXICqEKFPGrfevrVh?=
 =?us-ascii?Q?xMY7V3m9Tm2WkCQN/Ekw7/sEdCkHZB+rzSGVicYBOiv3PMA79KgUNSlMaoFz?=
 =?us-ascii?Q?tACOE6ZsazstcTMVHnb8ypCwsyOr616hJNJYi3K39uHaOMlRt5pxFwTR7g8v?=
 =?us-ascii?Q?l2i2YHSf1KZluKN7iL+l4DT1zT3Zm5mbJlw/x/uMpAJglQjpp8AcYBu0YE2s?=
 =?us-ascii?Q?vofXgZRmEvOxWrXPIa9J2BRzmYZLKU17bgouVHgfVLES+bzW+p3EeWhUPad3?=
 =?us-ascii?Q?gfBdd15V9hoOex0/yr++eEXr2XK/AgFeo6OVN/DUDF+f58FjTwBcYtXOd/57?=
 =?us-ascii?Q?iRDo0umaaGhPVMMfF7opJfLARpfYCt/Wc8ZN4+RfJeMCTG59o4GcKgYvkucZ?=
 =?us-ascii?Q?euCnA04MPtDhfTCNspzJLoZm0qeCRQMrNzsdky9pdnBE1UHu6Vu09+ARvNer?=
 =?us-ascii?Q?+rloiZX9UV7BY7d6bf07dukAiMxSnBGCr6N3TFcd2X00ecPC1YeIkz/f+1Ua?=
 =?us-ascii?Q?4EBgC3XwMC5anN/vk/A/Cvj7jM6OKXnhmDqCwnTdd7Zamx5pxr70SOeJcTUF?=
 =?us-ascii?Q?80POApnC47L3irhgCO2F/Y6d/QkvVAYDC/XxLg3HUk3k6G6p7LYvuiR0k7C4?=
 =?us-ascii?Q?3DrgJYI+hl2feddeKyKWKm/VMr1MtK2O9Af2zOxJs3qjY4U8KnjBKVOCf+rX?=
 =?us-ascii?Q?BCIL45vt33rSehbUZxKfMN3CGXdDzx9a1wrQOFZpm5jxDyRhFuNvwVE++bD5?=
 =?us-ascii?Q?XITXO9H3Tf1BKU8tcdkAMahw2EtI/HliLguJ2DoXWIwJaRBnN7dczvZe5iHN?=
 =?us-ascii?Q?Fgx7rOzev6fIWUpd5hJSXYGXSUifhQm8IJC/vll+yIYAZ7Ny/SxDw0uIHU2Z?=
 =?us-ascii?Q?1XnzFowZsJX2v85S4GTFeRxpDGLu1V0MfERBC+FZclVfsTluzwG9X66vFlAz?=
 =?us-ascii?Q?mJxyDcqZQD9JPwCvpjspdICJpWK+dFIP4/7jcli5AzkbxYshktyYcsut9uvc?=
 =?us-ascii?Q?fjYl45UOW/PIL9WSUUjqEhnnDzV76vR0SNPGGtQxkNEKepp8Uw+EnA1t7bTF?=
 =?us-ascii?Q?1yCLMu+5A50kWUVIjSJwgJXCwUgXPmAj4NtA32gUq2aCSGdE0uPbyJJwgEI8?=
 =?us-ascii?Q?9MIJSiXyezcLx1Jfkd1qeXnOO13h8nDUFIsHxRye0CIyqas4OzD8x7Wdq9tO?=
 =?us-ascii?Q?ur525RVwoLvUL5EDCsaN3E+kTObYCUY=3D?=
X-Exchange-RoutingPolicyChecked:
	B2KyjQZRAN4hseU0Tx5r4/yJV4LWvBodcxB/z5JdtHsoIbRE22N8z0p8Wa2bzYugynrhy3tPs4VxP4xp2VOtg6ws0/d7AdQI5kc1t+/DJnMCI7+uCYC8Ehz/MWnWXOKZFi4XUkLT2LubF+7n9FTIbGzewcM8xSDWbW4R6BGFEkiHZcQON/adsFwQwXDm6Q7Few9MeCoeUVETLCm2iN4V7coxOs/pe4TlBPoW9vk/kqNMdJ9dPOddYIX3iv5UycMcXUMriyNZAsWI70mgrG3WtFGL+UxTqM2LyOtFm1v6rIbUsp28bqIUpyEmQ6JtG9mKI81m+oQnBfvQXr9h3lWXLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ov2ydJn7RGIDXIR8dECpqZi1AQmVJrSx5zja9ly3V1lzNUexY0v2K4OWQdVjgi+bq9HLMIB0exLVGIfE9uaJkP90hsWYFzefYgdpqtR7myoi8nlfgDkl6fwTqNVowRjqs9LzqHsJWAA88Rezlul+SiAxuSHE/R1IV0YT6K+krvjnZ3PHuJPUW0I7pila8PAdkiPdQlpe//mNxIQ0jMfk/O+/D7G1u6lrtq+/vet5niQ7uI0N8rLpzteFmVdcyK3147UEUYg3LnXTPEYTc210WdbYYHbyoy8dTJajJd5zHPnc3wSQdMTSpRJnnEZ5SJYIuyhlX6+wBQYwQvnnM9I4nfezefD/9+iSLiZQcWbK5yv6ycUGldWfUzYwEP1qw3sYMYLh7sdgtzZX2SchUTV+gJFGHZ7riHn9cyp+3WOn52E8ICy0Y4ZnlpKts2sqUNFCPVpIgDquY/VG7q5jaxQpvE64SJsICU61fdkFKhjAcLcV18dkh+1vnLiESvz2E6o3SGfv9z3LHlZa3wR2i6BnwoYh0InF80Pd0vkm2KqC+iW6cW54jNUSXX/b+SZByy5/VbArthGp4FaXZAVWhuIMzcvD84UPcijI+KO1k389QM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dcd21b-5de6-474b-7ad1-08ded1ebe3c0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:27:00.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ1PN5zz5IL46K8YXdSvv42Q+TP9nZ5fMjQSUWg37qTB9ImiEqhBi4difaYwpGkVeejKjqltRn3bXKPStBOs/zGA6eqUvaJbuXvw//COx7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=985 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwMyBTYWx0ZWRfX/WgQfps/f6Am
 tF2martMoBB8LZ9w3ivdyO/XbzuE/9ZinKiqYXvuTivCdzcGwOX2oyz0S6BarNmBWr12BGnNjKm
 PnofpVrUxZT/7o0HkHnuVcRkz4O1JcK7hj/AWY6UR6lo7LppReN7IFEwE0lGdoNE6FILD3kmlpn
 1x3Jcxmcnxko1QrUMDf/pgdaGZo/FYrDDGj5coF3C9sLumCX4HSG2ZGadv+kMYIRbMVR1W5yxLX
 HVz9YvpM6KPUZJVTQBxeo9ORQMWsAWJ3JzMdiUGU1Ttidv1BLj8Qg9KCaSGL2859wvvWA9RNFEb
 a3a6iyucl1U2wI3uWNH6QT3xI+RpavShtxYTdXmFJ9nwYutNPqjdZ55jwkKdSPyTzQhd+CwR/x2
 93U8OAA6k1wAbRMeKvHyY4d4m0dd/8IZqm2+xo2X3R78Hu2qtp4=
X-Proofpoint-GUID: rzB0CxJ_FzpgVEGWj8VT4q89VCoyFBsS
X-Proofpoint-ORIG-GUID: rzB0CxJ_FzpgVEGWj8VT4q89VCoyFBsS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwMyBTYWx0ZWRfX1hLxrPTJB9n6
 ZDVNA/uojJMCLjdtAsIQYE2y3KAxR+or4GAdX/+A41nmAl8WcQ/iFVicAdITM/lxWjhktWS/3m2
 U9WfSUHxCVQAADu9SZgvSYuMOUeouXdH6tZ8M/e9paQTdlf9TgRa
X-Authority-Analysis: v=2.4 cv=eJAjSnp1 c=1 sm=1 tr=0 ts=6a3bcd1d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=Xn6t7MbJNHJLC63oWt4A:9
 a=MTAcVbZMd_8A:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12313


Christoph,

> this series has two unrelated PI/metadata fixes that came up
> during a little testing surge.

These look good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
