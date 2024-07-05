Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117A14A0BD;
	Fri,  5 Jul 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180332; cv=fail; b=e1pUWTShjYYxu6dwrG90wnuz8c+uCxRUIak0Q6Gz0E67Iff3uJsWq2FL0GM5I29GoYzNS618Ur8y+edXfdgfPIFe6n7p2mYEnXmW5aDuC+4uQZw2VvV1R68nv/5MtUysk27rOeGsqRSJ9kWPEv0BHALhtY1bhWVTzimioT1bb60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180332; c=relaxed/simple;
	bh=XiGZJ/ARXh2OsxVvRtifzncH6qo6W7FaSnOCW6CKrfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZSnOGxhhGHXHG3qBTKULt+afYBwmE3MAolaXduIUvDgyEpIi9i6u8wPf9SvgRb10wChBs7Fx9Ef5H3HtamxRjwtBg2DogE51S4FXza4xVDgkClW8ePeLc9JzfeKfW3ZE4GPCqhgOBFVcDn6yJNbLxC1mshKKRh2qWAk4C7nlrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MeBANGmU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xuqWoocN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MeBANGmU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xuqWoocN"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfZLl017730;
	Fri, 5 Jul 2024 11:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=hwzFC/evgEJDWdIgKyhLxHnoKfGhRavP9Oubxj0XMqI=; b=
	MeBANGmUQhGSN02J/VCEeuYCYRO4iKuzaAomS7euGYxmKNDE4xb0j+M/GKoaHx4i
	3AmNjj1OzvBqawWq+iU7S9i2BaKuTlxYVOs08E4b/JUbmECbrPerdzjmiy5kX5Bl
	OWAe3anyqxTpCgf8RuJRJRlOuVALOamoKLECDNJKK2iWdVNtCc1yrgvH9w4wJ1Ms
	FhMaWKZn2E2v8urM2wCmhLXfbTQJNGhISQt36f6XzIfF0k0pbn/jITFNHtphGy7j
	gAB73Eg20Zmj7TW5FQswJOkeuN/foWemDNurqD2stfaYxCZIZEc6rzxpU6TtoDeB
	5PeRqxcj0KvSjV/mczeXig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgnaue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BgaHD023596;
	Fri, 5 Jul 2024 11:51:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n129227-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5FCshBKa+E0ciGGljks/LoLvV1cB++445Zmy7GgldqWiOhiMQ1vlx3XJ/c8HZVR7c3ms8K+qHDUw153LyLmaZadDOTn1yI0S0VMHe9pwZZ1PxGIwsGIRLlsVCHsiJIDot2JvgY9RFXaEgqSvg2RGmnO3nN07KdJufDLzBgo614qE7iXlORRalR4ZXbf3XUQFNpt6FY9HBtjVWl4J2OyICEwPyxqOQsOh5ptWxzU0KCa8uFXhg1iCCF//5kox6If6I0j5fA2M9muOtEICkbs7OGVVsma8JbMCuaMybo+82w74y1NT8laD2MULhfO4irP5Cgdn/ex6UTGF1S+0rtJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwzFC/evgEJDWdIgKyhLxHnoKfGhRavP9Oubxj0XMqI=;
 b=BXq8TZsHdtecaBtOYAK234Vafde0Gaj0Ngb4rED+LEcWSzXwfjRGNgLGu04X6XiXr8X5OajMZZOsoDGjrAw/M2wPlVAXc6/F+oF7Wjf3Ww859IeeYSmJSx9OdkQvDFwiFqM0VbrNQMYHl0W0d4Wid6wHXrRSfegu9KPFDFp0I6x46gGcusOqK6bNIapsIBKv1K4FjN4RRP3JxrbZNXejSyA826dIf9wf/UGNKJl6MwaeN2qsSU6raNjWjhra4ipMwMqc2BgVyR9P1AC+iZrFESKe5W2FXMl1Orr/nNH0ZIxsp/6hoH6OHJfbISGr57QvMjqUgZ9OuWngBKC9mq7EQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwzFC/evgEJDWdIgKyhLxHnoKfGhRavP9Oubxj0XMqI=;
 b=xuqWoocNe3qK8fy7xugbECxmxnT+fdC2Y1+6itRCoO39gE9QHIcl3LimX7LV103DPFLCGKnk+IZ2tRuKmAHIQPJZRmIhweC0DlBNFgRQnkuora1FdKqIPgdC864ZBrH42LRzocfVoHd2a+pDJkyBByVpcfDilpViMsDMZVKg7DI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/5] null_blk: Don't bother validating blocksize
Date: Fri,  5 Jul 2024 11:51:25 +0000
Message-Id: <20240705115127.3417539-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f72289-54f6-496d-029a-08dc9ce8d901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bUJ7vsYy+hpbBudVZb0Qu9+B1qnS1EJ/HJNOyWha77/JZ7iOitA7Uc0yT3n9?=
 =?us-ascii?Q?fMrfUT/07nD02SuOlWZy04YhNm2scf8NUiKsTM3WmHBynfYuR4Iyngu4TLqY?=
 =?us-ascii?Q?8zIqymzBhIW8uQ1LenH+ddZQZhj1kCE0yIijBSnXJs+uJPw4TydgspYZDB1L?=
 =?us-ascii?Q?/8KF9pTXIqXXFTrH+tRcBlVtfcMzIO6Et4Txy9cOLVTUeOQ3n+5YLu+1Btz5?=
 =?us-ascii?Q?8jGSmBVfqntyuBBwy4uv9kx3H4XC1ZGiGgVArm+Koxsgx5MZVXiy6FpMkPRc?=
 =?us-ascii?Q?hyvK65eWB/7Of3FFbPbDilxn6rddLk3XGttKkI8k/eGBknSj0YR/aQUctzbl?=
 =?us-ascii?Q?dk9NWikgJFO5LIJdAVtsNMSXPvuW6Svg2uwv+MxFHZaKFDFohsQrStgypgVJ?=
 =?us-ascii?Q?gmGW/XGgcwBwdX6DfgIhqaQdzHNsD8Gd0NNgmvIw4Jm4j12Tu5yuox1EQE1G?=
 =?us-ascii?Q?tbbnnH7RYlcW3Bmh4ro7oyyaOwmHikQa0vPQDwD68JNTfjOwEbbfROLcmSd1?=
 =?us-ascii?Q?QFiZDswh7NQKLKm1LHQHbAiKJUeCUEh0VhDi7ZMvKzjMcQutk/Wa3Ge25CsO?=
 =?us-ascii?Q?Wn/Zfl4WqbXCdQxcJLgTxZwA9GEnKQhqxf9iWuBh2M9lFVd0e+ukYdAPBI/p?=
 =?us-ascii?Q?E6hEbsrOxUro6C9dcDhIHCoWpOVWZbNWazjIM61ylsiYbZBQb3IwYLIoRXcZ?=
 =?us-ascii?Q?qoxeHVE0lX3K4s2vj16iASYcY1uJnHeGiS09zRwYMRqXqAoS5e+QF6xkYNwY?=
 =?us-ascii?Q?2dFuox5/fkbr1mKb0STMB80szVF7tFTqxs0wlN5kkwZf0hcksXlPfKYMC3Qs?=
 =?us-ascii?Q?MtTfzKimKs/PICH4sphOfkVzhBY9iaP9tmr2d2k2/5cOz5DTXAsG8Xioex1C?=
 =?us-ascii?Q?11AgwkubcF2N9fGLvDbdBK/Ysy3YEvdg6PvylG32UKptL8WvNKlvzoF60t98?=
 =?us-ascii?Q?QLRgxu6fLGIL8+/2mmPLAuBHCJAd4JBcTwj8eWnP854PiFVFB7f9enOee+Te?=
 =?us-ascii?Q?pTq8FdnjWcWHyWc1vTxkSHTWhfk+9GD0lMExHHsx0EFcdxqv936ktGr8Q4nx?=
 =?us-ascii?Q?q5renGs5diF+i8A845p36bAwq4g4SK1G6wSj8SyCiSnBZRV//0kQA4c2Gz5R?=
 =?us-ascii?Q?60qHZkRcHvJF83dhgooI6knLTJZTB/fkPm4T7Hbie7fuZoAQR+wkBeuqkXUY?=
 =?us-ascii?Q?OAcX493oxggCibzzgBoEiS0baCfTinRmCSlJ2/Sa8UKVhyjQUd+PK3pEsPkD?=
 =?us-ascii?Q?8Bw2ekiuPHpQUcdj/kz8v8h13JJyQ2PvvJBC8al4UYZkzUXvbRmmjqkCftNU?=
 =?us-ascii?Q?joC6D2iKPXa24VnUuapeqQCfI3sbOgFhlOhPhCVwGYhxtV10Hq2eAGgTf6Ng?=
 =?us-ascii?Q?o9iRTXK7lEw5pLV+EUuULD/vWNXK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HDZnkvV9pfXEluP+pTuuNt0Ri3A6emCSVY3+Lv8yqxGA2n0d7gbAVZxMc7gY?=
 =?us-ascii?Q?g3J83TiTcNneFkjJRr/XyJWIg7VFES09d7YjBCq4B1wIHbIAltstoG1BQcTJ?=
 =?us-ascii?Q?0pL+Evo/N0P8wKJjsYKyQYfwbaY7gaOyKOvvFqynTbSI2FUn1VndBnur9zvf?=
 =?us-ascii?Q?3I3F9RTuPOIdDCULKEWxa/ob725KngyzO0cV+GDGtGF0yAw8mZSlsBTk9gql?=
 =?us-ascii?Q?aVB+iIBeBdiT/p0cDdQ7Je17geTTLcVN/qW/LRohsy5lWJFvJY705qjtPUtk?=
 =?us-ascii?Q?w71WVp8pNIUEzRxituy/iuWLXcbgo7le0eHajhLI8kSxXQGBZckLVdgOhA9a?=
 =?us-ascii?Q?NjWIUYjw61sk4abBjzcw0op9brEARib+juQnY3n6XqXZ8/tE8HLvOTW4yJNH?=
 =?us-ascii?Q?ePT9w14y1ppIFfvPivpWd0gJcf78kgeI4+zY0nq7iI5fmjyVVPLCRPmTbmck?=
 =?us-ascii?Q?D27xx014A9DGXTgTbiu+0Hv25v0HO+rkE6Q+cVNKqVVaHAhMa3SZPRFK7c/K?=
 =?us-ascii?Q?v0QVGSoUwO/ng7mmC28mrXpITBxGO0RdEhLT27fDW/cn8Sm/ko6WXrmBUBJ2?=
 =?us-ascii?Q?9AHi+3SZy3tUDX3j2dgoyYN6STXXWr1XdCiE/senZmDKPszXXEUPSFrlfwVA?=
 =?us-ascii?Q?TyX+NQvvEtaxLY7y9SFGZ6753dj1+D0e/KQCze6PbNifnSX6pz5XJyIPOFeK?=
 =?us-ascii?Q?jmXyLV82sZcXIaKa6jMQfEDMd2SDYc27+tpCjIuK/t9rkeoqUDswZYFQZGzf?=
 =?us-ascii?Q?vHT2KaaMQePofVmwzSk0jxjOE+TYJ4LOf8MpUUX9bUNsXCLa1NL5JSwj4eGa?=
 =?us-ascii?Q?OuAeC9EaB4izwm7wWeE4z9jszZXjLMU+A372HIR5XeQG3vhQ0t3xsByEcoPX?=
 =?us-ascii?Q?GLg0D/NLBkbcis32PWqbdEyCTso8jvIKRPgDuZricU9Lf03vyIRZVymhWYr9?=
 =?us-ascii?Q?8w8u4ObEV1iksRjHaYF3xqEmF3f3e7sRgwvxF/OCAcZSh1HiT21zyy6oUE4U?=
 =?us-ascii?Q?Fl/0B+1FFoO9bOLJVQ9ftcsEueizB0o9Vb4e5z79Fz4bZfx8i7omIfKOGoHM?=
 =?us-ascii?Q?b6OQ8YnCv1zmlc6M1NHFnJgFcYg5dRutRB9osY+q1sNcWHDndsEbj8P1CzCm?=
 =?us-ascii?Q?n6BVCrMrF1s6jxZKPPI+CTidYkyrJajt4XnBIuH/DJu5e/Z+VQ+yOxtweBOn?=
 =?us-ascii?Q?hyBUfL2pEpwnewBa3TGWgI+c6KaOX2NlN+fjxGjWFHEzLmgTikI+ubpGHaeL?=
 =?us-ascii?Q?+euAnJQlwPsuDgBNbswQbFjuIVG0FHL3ZPZSled1hQ/nOpte5nAaPxYU7idq?=
 =?us-ascii?Q?Jjns9nYAEX3nOUKnGWe57ietOneTFjhUk3F+mUF1jbmgxS9i8Segnj4u6qDF?=
 =?us-ascii?Q?GzTVm17xoM63F1lqweG9yjdK7Wj7wvbuKuPtVycMZ6lU3B99Z/FRuLoDyaET?=
 =?us-ascii?Q?Dce3lisMCwqz9W2UvQ8hhRBQGdiNGB06GllLRt7F3A84xZB0ilXHPxio9NHt?=
 =?us-ascii?Q?EgG06eASKgUZgmND2fPc1r/xMLnHAU59YItHiP1hzELo4i6OHMhIdIbm5mu9?=
 =?us-ascii?Q?uGa8WQqDl1ycrZWDsfsLXCKstjecBojyKuZd70NmWuhPZ41I/yqn0CXKuDQZ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9ao/Nl0UIB8U4BTub5GRP7TH7GrM1EYDOHaXhg4VNcb5I+GKtYTP8sZn8zVneilHbwnMvTyIMtGXuIIQEf+B6ptRLO2z2nCOfz0upBdjEgqemhjk9XVCHEByj6ApjX5bCGgb288swheutGGKUywJIso0cXf8PG6Y6Olz025QHGfF4Prd3psVXFhGUlFHYJPmI8ZNCRQlf/T5JS62MBIocwesiov9bhYIf0MU/BpRHN/+2T4finj9ChFLlUGkH2IlZcvR/PoygE3MtpMHg21SakdegsVbw40tkkmhk7Y02mNe3rtRDlqbYZT1OpAzDnn2vSzYzYNMp2qMKiB2l9lyCEWx+8/GVVipkZcaoQM472QtpLMkw9jtJ5Jsio7Lqio67UjYUEaaQHSCOAwXpurbu7c0Pk5vB1lXvpz4izu0tap71DFxrc2mw3pLO1PwR2scvyaOfnhwGOFp3hSEN/TV3gyh5yKBcGvcwa7HsE/ENUzTls0zD91hd5m1NyTRS7PkMNcuJnpw6/bWIRKnlsV1V50fNP/f5PQSu/FV3vJv649RNeaHfnjhZInXkcFpao8BNc+edWsWxZ14CEfhw4dYSQLVNSWSVCnqHIJkBhrIXwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f72289-54f6-496d-029a-08dc9ce8d901
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:46.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqqROCdlmkkLCKDS9SmJL6Fc92XYamH0u4Gjh09wBzpK+ICO2k8lkms2qotgEMCE9sE99rsoyZHqDITXvBy/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-GUID: rNtiIMaHuXKtl5GnIBAPGU9WrP2NGzeA
X-Proofpoint-ORIG-GUID: rNtiIMaHuXKtl5GnIBAPGU9WrP2NGzeA

The block queue limits validation does this for us now.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/null_blk/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9d0f6da77601..2f0431e42c49 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1831,9 +1831,6 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	if (blk_validate_block_size(dev->blocksize))
-		return -EINVAL;
-
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
 			dev->submit_queues = nr_online_nodes;
-- 
2.31.1

