Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BB8615A
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388603; cv=fail; b=lGg0c9jjiGpUORqb02QDn+wQGUxJ/Bl2E5PK5iwn6NakFXdhuzkf1v6V3ZSTbZY8nboC19rXdcT5z1djHZ3armyr5bPlzC2d91lIijo6crfN7YR3cEktC1e5/ENnreez0P1K8H/fcHwBxWlmuHLjhzsemIAdAXl5IP8BAPjLpAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388603; c=relaxed/simple;
	bh=uy6EA1oVuftX7aVbxhQABPeFFLPApFrGe9YQJdQU9fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdxUmmAiMBU7eotZcBk5z6dLhLbZn6CFThXSf96Vu31+Jslk7xZjOzO+7He/EXjIvd49QLDNdRbncYNuJgkwciz91LZu+3dS0V1k1LRO1qiSgaHe6zP+L/s3V31jOpMcLGKH/VJk/xg/1uhGV7k4c7gQYv3/TNumcJxN7yF/T3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PSGrdjVO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QtTs6mS4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PSGrdjVO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QtTs6mS4"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBK6T5011789;
	Fri, 19 Jul 2024 11:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Nlqk02MxrP1qzjZzUdkLEcWI6bt864zGzJucVX9Ol8s=; b=
	PSGrdjVOTAyrzXow+RZxs8sUGcgwXt6gNoKKUegDWGzCS6QpWnhHdY8FiDkQlVux
	pHSLOHr3SEfDXj+FiAaSGuAlKT+jLAwWs/c6JJhMZ9AR65ry6N6LmWaaaYflcv2N
	SC5XN/KBcMuR1ATYcRrivXIaDa9s6yskQbu+vOHS5HjFMMUp91gTtrmHlqaKPHFX
	rySx00fdlkwEzCgNazVmo729da9+ZfI+5w+G2p346o+ZHvxEay3ArYjKwvIBwhXy
	p6ocGb+kIueIyAiZdpFV5b+pBx2FIYkxHcGH+OrXmihTnKxzU+EZKCJJC5wYN+PH
	4SvVEKF5Eoh48lmcShzCvw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9Cnl3019520;
	Fri, 19 Jul 2024 11:29:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf1m1et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEt1O7HE6vxKPb0FAGAKlPgiTIC+OyEmxuqaGR6nxuFQsHlRRDHCGwzlHlv8DldSapgbxSvkP/RzJ7pnc3WeEsBja0VmxzVdPMDTg2MDm8rtUwUV+jMICyDofnn6uQvOE/C8j/Ck0GqDJJ0k05SXR838/Ku88PHnx+Ja+Jzta6cFRhgGckpem5BOoZhrjBqLqnzOaleoQdeipE0T/FLp5ngEeikElKHaJOMLxZNIsmn6Ziir4JeSwhnoF8B15xBKu6o48OTsLjOkijcn2ybBWYSGbQMzqTPuxR768bWATrkIr8UeqqX2TZCDnSWv365aOloXXmsYuVx/NfDMFG/k2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlqk02MxrP1qzjZzUdkLEcWI6bt864zGzJucVX9Ol8s=;
 b=r7xcPxNy2rZlEf8kxsRkxWMbLPLJETJgyi+rKo3UTFgujZIHyJwqbR8SOcKVSI5G+U35OXMNg2KvyCEOY7+HeBJMO/KEICqlsuBSoKrUg78zYSoHedT3xGWhTMHTlpyZ0L+oja1PlpiA42ta2dcwv8olhDAsUTRbxea9DJfmEvBdpOsg6eqeMDdYDPa7gZq/6QnS1crwSdfQwWM/dmu4LD3X2Puk2k4rkin16xV1tYoVtRS7NgE5elJNFhLp1koDjLE39+w7rHBZWJhRV3lBvfWzZ9AYmCVIQSaAsirpwze3E5eP9sO/hiYuoTER4UI5BzFzTk4R1tzVVEhU/BZHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlqk02MxrP1qzjZzUdkLEcWI6bt864zGzJucVX9Ol8s=;
 b=QtTs6mS40YwN7XEjrw/oej10i82bKb5hqzpZ5BS9BlpMvkvvV82Q7gpPI0y5TTMsmkejuj9or2zw+95Mkn3OHvnTdl9Nc6rO4fcdF8Dj2riw9scXFgg2e8DkQbI8ogFNToYO5hYi7zsF1qm/7mrrpA1pDEK1tfrO5u9Qr+TgCDA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/15] block: Make QUEUE_FLAG_x as an enum
Date: Fri, 19 Jul 2024 11:29:04 +0000
Message-Id: <20240719112912.3830443-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5f97dd-712c-42f3-dd97-08dca7e61b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XOLhZCRynsv04EKYLeCzosP+h2Nn72v3HB31AevcirvYcls2KWGlre0A16ul?=
 =?us-ascii?Q?a1WbX2x+bqcUTqQNIgzefoEoNwTWxaOsh6OrRBX/zCZ7H1Dkg4lf9Wyh0Ynp?=
 =?us-ascii?Q?pGCWkHfuWguTxNXcB8U5TULKLgJc6BNLQC8K4fnO/gUkl+syPdwKFTl3nQKO?=
 =?us-ascii?Q?5Gd7cxWxePgZOtq6GnDYecpZWALHWPTDmPtdgpaNq5xGT2cs+Ap0cV+0tI2O?=
 =?us-ascii?Q?Vi1M4bbqmf7PBTdlDMfQK/j4aNhLK16D0i/j0C1sUUAR/5aNs4te6/TxPUNU?=
 =?us-ascii?Q?QghxGDmhTfKSnmMVPgsd0zFCNjH5GeEOjUVwRrnV+ukkytQeP7ogb4RKqaJy?=
 =?us-ascii?Q?X1QgyIgbgTtNUHkCvAVV0uCG6Ay+mzdfo0mWtXIBQ+6v531Z1Ee0UlIhUUsS?=
 =?us-ascii?Q?nVgY5rdLHGY9uLr+mcRrRqiYw1L2nf++nt5pDqi1qmHl/50PJBVnqeI/8wPx?=
 =?us-ascii?Q?6gTQmTlY0OUXgZkxHlLPWrnI7CfAeBeI/wZlCBvcKpDAPtOcUuWpbHKxN/5A?=
 =?us-ascii?Q?e8H4c6w2jDKgL/vQk7yG48T5cOukzGT1emfxwy7PpxINxM1Wb0dw2n8IDzSh?=
 =?us-ascii?Q?Cn/LQDbeh7JGlyuyGIMhBIao0smKz3S1XprGDnE55/2G9bLFq6T1T8O4uycx?=
 =?us-ascii?Q?4fld3BIaGpkGTrVL1On2az7MuRe+muJHXnNCYuf6Zlwxt5T350qBF7eB30do?=
 =?us-ascii?Q?ISCt2WOWvi+tZDCC70gC52COMxyLPdASa0I/e3FL02xz6WeddthsL8FrEn20?=
 =?us-ascii?Q?l+zIgZgiSjv5SClm1syuyizH8fvil+dgpbij1/NOXTYH95pSCK+HxLAg9hmZ?=
 =?us-ascii?Q?4Xa522zMxqv24E/bgrXN3T9n9kL6HTYg6QJCW6C0zdjlXwulWqpAnhS92phb?=
 =?us-ascii?Q?FaChOepjBUw1GY/sVtT8hx7B3lCLDp2/UEGXuDERZ6duHsJ+cyABCa4KXq6V?=
 =?us-ascii?Q?+mAe+XGosFEY6wlYjpYw9hV99sHgQCS7PEJ2YsxOFu3YaYw9XfJIOuOkyGk6?=
 =?us-ascii?Q?5Rx9Zl2voIDGuZhz/abuZE7IA+VFeEybbXu3ggOxwNGxdRskz+3VjezvV+PK?=
 =?us-ascii?Q?v26z9vA8PLRTzTbdKjrc0Zb0l2VFqAJyaFJyvgI97bmDsXYmDtVC40Oo88O3?=
 =?us-ascii?Q?AFfzjzW6prHDAGJq3b6jk91xG83ENt987r6fvIfjkrEFZIMcUMQfcqPb7Jf/?=
 =?us-ascii?Q?V23C2VR84wobWGKREBSrrgu6lCK2GlVRYEbe52rZoICPA+2J9c9cUDuMyLlL?=
 =?us-ascii?Q?aK7zV6Gj7qMjUOnpsbE8WImHFmGefjmv9LcY6SCYTkanyF5Mn37hAYH6oiKX?=
 =?us-ascii?Q?cn0B7rWv+5ILeAyg8WHNPEQ0LVTPgxnKTz6BPiw7IubnsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e6DJSK2hsmN3CNsVer9EaKZGFEWv63eZndIKwcZPNAfLYYWjnexqro9o9gjz?=
 =?us-ascii?Q?MPnwoFZO08LNirxgpQVXqmz2zA14Q0a6aUSXIiSPFRwQQsBeByEoFgv9Uet9?=
 =?us-ascii?Q?XuYoLpUo4EhwjpgekDJCd4T0Ig9HWelfHGqlXaVowEEy4rlvlxAH3fPwKpQY?=
 =?us-ascii?Q?CIUOeXoCG027nIZElaRYf0/st9ODY+Hk6TUUZQ2FNzJDZYBvzEWkqtzuu3re?=
 =?us-ascii?Q?qeSqAKA0WjAKxQLx3rH68nXZxtIO3adWkXi6JBNJ2bY5XXnkr/xuxipkyntV?=
 =?us-ascii?Q?HRu02rB/UsB40F0PxjF+qaB8LnzNZzDJYMzO2zlQyNj1KgwX4z80kxrCMa+P?=
 =?us-ascii?Q?uxU7sxEjZELh/HV61YxjPlBPTgBbt9R8kWe7CiX0Rb0KhtsaPOEvVJak8Zam?=
 =?us-ascii?Q?b66eep43L9IXti6xNp4VkV2eYtWY2SJdqPpZm18eWZAKDXXVNau2Pj2WJNM1?=
 =?us-ascii?Q?BFZYkRVfqU9wBREG+u6qxdABY6ye4GW9vqlY9lkH8D5DRQmriwM1KG67mOho?=
 =?us-ascii?Q?F0KkG1DXeN8NcTLt04ia+86uJ30p/RzfOakp8EPZsUa66W/10vnzqvF68bx8?=
 =?us-ascii?Q?huMYULJj4mhXEBIzNEJZTBk5WgJTuIIHiYrz7b/hPcb7Ho4/z9vXBrflP7/x?=
 =?us-ascii?Q?EVTGMUI8H9cW3GoajigfE/nvObppQO5E8nS2iYMkwMx7GegDbHbmEGyKm3qO?=
 =?us-ascii?Q?cHVRc6I6DaJlDpKSSk3WfjPFFv/D+BzB5fd+MQg5RyhwfkM8XjIEpfE2zrzf?=
 =?us-ascii?Q?9ou9G0wCAJm9WitFh7Aq91KOq4nsp4kDyz1FP+BGoiObmKb5TG1eTCRRLryh?=
 =?us-ascii?Q?SnaCMg+pvCEByFJ5hPHBDaDVBMpobPDAr5/7pHvjGk46wb2UbfUbPKZPx1/9?=
 =?us-ascii?Q?xt7z2cTvPdp9o0pEmIALzY/HFVbTQR2X/pUkKPKvb8TdvJ8EzXUQszIGB6GP?=
 =?us-ascii?Q?YRTo+r4uAjAd5fBFFG50fGhEFtlOn8DRmctsgUraj8BMRHWJvqip5YLDx0LG?=
 =?us-ascii?Q?G+sVkR9Vys080TBEZJz3Ws0Vp/Dk60mrhetLFVe+Vr2uUFLPQzhovE/mRAbs?=
 =?us-ascii?Q?/1f00PArM80mkGiB6ma6HW1XOfs3P2aVyeqDOk34W8zn4u0iqQEyJ9Y1J+2q?=
 =?us-ascii?Q?kPm+/t9dPfiLe6NdqGIs9OWBpt45anTdVIRVlZ7mUxnchyVpQ5QdOGXVbxN9?=
 =?us-ascii?Q?/2FgYd8+136Bt1MGIOofrZYEOPwkqVBznNGdbzEyyFUlfFmKW8PCaunmuLbn?=
 =?us-ascii?Q?pciZ3Cn5C11zN46WTEVr25aIZ+n+J1LMwiDMNXcUzte6lFNXoTtNi+4VNb12?=
 =?us-ascii?Q?8TpLrVF2jgT3AuWymDcZeeHWKgIPwpsEf1wkogOyG8RuGH3f+jkvWIR6DrnY?=
 =?us-ascii?Q?uzLRZobgLcyqx/Fp+BqzsqnRC74YMmpyoNTzqlB0W1k+w918JHk+xto7Ze1k?=
 =?us-ascii?Q?IUtwm4xkWOVVW2evFApLqbDulAhUJersIDLXSCpmP2+CQCSRfdCfdCmYOU5G?=
 =?us-ascii?Q?M/+R8SSzljMAC9rPgZWTP7pqGphLxU6wpk9pHySRZ9uClBVtnBTedgulayTT?=
 =?us-ascii?Q?t6UgdCq9RDSC+dq8U+gd2J3G4pRuUtFMyuG2TkpbpQ/9Fqz9Z7wcVSyssk7o?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IKE4sab9+jgaP7NdDdzZiGfHsIaJENhG9E4Hv9a6Qzh7eYjiyZzKMv/UFyMElX/IT0/WBIchSBnH/WwrqT3coFZW/b2Dmx6pqdZay7BU0kCZwM2I75oSnQEkTt4vbcOxnqGS4kuR3bWv926gQjy1BM902iNFny07DSLAaBiZkfdUm9eKJm6Uw63utnGVhs8wWyhI6VxLBaww385ZT3DlaSU5rVUBWz3UvPfTyQ290l/eBxL4tSBktGSTB9i1St/VouNc6xK9RqJrjLJ2n+jlmqgVWocAyuOeFCQspFWtrVuWscbJ+XbqPERvhUM7fi3p5ZsX+DBrJYWsj50NWv7B/dJpT0vYKEtg+DN0bhbiE2XsjG/hgjHiy1tu0bS0Ire8FaOAxIfzLAdaPT0G8eDu1jYPKWuSERgPIJZx1D84auwkKyT2nlomeZezBYBzvOiagE6K8STdIXijIg3cOPJJNABX6z1D+ocF/ErAWb4bX9kLwF2ljYClf5buX0gSMVax/wZbYW+BtMmKRDxdvr8FMvIAh+OOSv6bipBgqrFtLcclb7o4BqZfGNbdakcI6LbjiZgWjiYyokRzsh4FoiDinManEKAIqe0BkYbIwXmdk/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5f97dd-712c-42f3-dd97-08dca7e61b8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:52.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMT+yXyysayGvBWM0Zz0dExhQtBHueDSKBU0YU2fK1VH9Ut1jsknheBus27cXWzaVdt8UmOB5TUHa59XNs6dRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-ORIG-GUID: xzMPjIwgHD5StJzuxWHWpTossGnp1IGQ
X-Proofpoint-GUID: xzMPjIwgHD5StJzuxWHWpTossGnp1IGQ

This will allow us better keep in sync with blk_queue_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 942ad4e0f231..ded46fad67a0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,19 +588,22 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_DYING	1	/* queue being torn down */
-#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
-#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
-#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
-#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
-#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
-#define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
-#define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
-#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+enum {
+	QUEUE_FLAG_DYING,		/* queue being torn down */
+	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
+	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
+	QUEUE_FLAG_FAIL_IO,		/* fake timeout */
+	QUEUE_FLAG_NOXMERGES,		/* No extended merges */
+	QUEUE_FLAG_SAME_FORCE,		/* force complete on same CPU */
+	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
+	QUEUE_FLAG_STATS,		/* track IO start and completion times */
+	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
+	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
+	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
+	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
+	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
+	QUEUE_FLAG_MAX
+};
 
 #define QUEUE_FLAG_MQ_DEFAULT	(1UL << QUEUE_FLAG_SAME_COMP)
 
-- 
2.31.1

