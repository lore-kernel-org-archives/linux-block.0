Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7223D28C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180009; cv=fail; b=rvap2TtVOkf7OdQa56m6eOmgV7otPAWgQNAEQNSni9YU8kxssS7uISW44IUKygxrjey0yphTQDKhVJC56NifjbV188wFwT/gmsd39914rzd4gu3B4LacituBx9kZiRDJIJmVBj962Zm4mGZb1DqnB86jPai7aYDnIsj3Q2Ri+S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180009; c=relaxed/simple;
	bh=yjLp8k76O7X1AD//qlxif4Xmqy/pQTFcq+X2HItIKzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0tzPJQsCNBmak/+V8GddHtXoLnJwfsEXq8lAynsMksFPri72N7MVrsB7tQvavZOufgMVsJ8AQyA/r3y5kCS4sEEU+RR5R4MMXXozQEOZNdkS7sCqFI3hb7c06k22J1dAe3wrX85+ewS6L464V32/8vJy5o8tLyZQQG18amla/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZIw8YVa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w3j91oLs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZIw8YVa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w3j91oLs"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCtZ006871;
	Tue, 22 Jul 2025 10:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NqZgC4dM2YfQVcp6VJfqCJdfle6K+aAjmI+sTiqAWaM=; b=
	GZIw8YVaHqffzd+g/eBBp6sSrYbaMhh43oWrSJj+mhBCVekaIWWOPQ9DuGJd45+X
	HWdMaBqv2XRSRsO+oAihgknyzvxtLFP1RfCmC881vQmn/oa2vr1KaWD+4ExUZLck
	5EpYTjAre0tiFMlxhd6btukyxgOmSEs4COt6h/8AiA+riuzFnvT3HZBvqKqKiDll
	hLZjyT/oTq9RScrjLlNZl0qZizH/0YYMVxzzfhesn6fh64Dm4+QqC5ijOgLkl7C/
	NDX4JXQQIIZCzD/hNyVmvHAv8Zf0sDxxEfs3rdUEs/c6UodT4taSy7LYanqzePJn
	GbR0hTLlrtVphuJcJMVQIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2cur6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9RDV5005819;
	Tue, 22 Jul 2025 10:26:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t957ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH2mtYe05srgPC2s4kEKNv3V2odpiWtzUJkeQnw5G/NbsDZULpm3JMhwOhufIbCgc+uBwVHcDuXO83D9fAHIk2PbrrzK1mx0Cvt6pCWpAtSUuL48yP0/IMmwwUbbBpNBGchCi5GWoI3RPUPitq7lT46rKSZ87RU8Ek4N5KFOj2bl/fHIl9sAVH4fcjuoimopMxlPXyWh2QYm5EnXx5AfwoFF1i/3c0uPaaAEHs2Djmd7jKzIDzUODKsaCQ6hFh1iWry/g0ADIvcs5cm5XLjX967zAouMuO8NUU/5faTXy3R6FS2ES44y7HqDv6kqLIpn+V+iCNV+k9q5xQren5MmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqZgC4dM2YfQVcp6VJfqCJdfle6K+aAjmI+sTiqAWaM=;
 b=i93kTSlvXWEYAhk98SuUrfPG7T1LsfvMo7ORGWzoZyB1qEs0k8q8ldzCdE+kqtC6m4Q9aRIXQpjgIIHAch2vzaXU0H9UOr8fW66YKH5XBLrhri3q9bt9uX3Jlw0uaCNYLozIl9/FLDNSrPrI0+cB8muMpKRbCPLWMzZpyyMDfz3jSUFZLy2vHOUlCo4kA8XAfo2DRhfSxUe/MsI1/ajcI1LPXE5rCJLjGWyvOCXjPbxijZNCwo89Xv0fokBL2eSdUDLvcjRL4UFJsfcmAbKa5kS/2tl8q5x6cNkqt+S4EpKx6X9IRBsTtVaVCGAIXEh0haC1Hpddt43TbKWaNeXElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqZgC4dM2YfQVcp6VJfqCJdfle6K+aAjmI+sTiqAWaM=;
 b=w3j91oLsX4X6DtogvHXSHPbxd3OJJl/W3iL1/34QV6X/DoOeAOu2sRsjikb0uQpwN5BPGEKkPoiyQy2SmM0s9hCfGh8CWjHbAShiQP54b0jA0YSU30TfR2uR041k1wa0E0PliW1/71OXqwyXqD3B7lU99hJVtHeCA8vBpd+HjGA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 10:26:39 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:26:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] block: avoid possible overflow for chunk_sectors check in blk_stack_limits()
Date: Tue, 22 Jul 2025 10:26:19 +0000
Message-ID: <20250722102620.3208878-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722102620.3208878-1-john.g.garry@oracle.com>
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:510:324::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: b448cbc2-2b73-4d59-ab2c-08ddc90a3e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HLTW28MxQUty1/ILmBCjX5paVs1ynSIaqYOJMNFzu0u2Gy2W5xOgPhC6lhx?=
 =?us-ascii?Q?Dh3VcuOXRT6xR3L/D+O+/U61MDnGnBwg0A4GGydFZPbL4h6AWKT5Wnmr4V9w?=
 =?us-ascii?Q?QfFlaJ8NV3VOEYiAGZFUEASTx+r1My2yrHhojOwuPRaIqXSFQIAbNBQ9Y8TM?=
 =?us-ascii?Q?wCOZUU7wUf0a5qu/ME58xqjSj54j2Qln9gSgYKvoZCBCp1P62uQBe48/vbeq?=
 =?us-ascii?Q?8z5whpg3xk2L1Hp+oga9uvOt6sR4Rw2Aa/6E9rY3t2rqdOSPetM/Ko71AtNK?=
 =?us-ascii?Q?XR8tRSNL6JhDNhS9fKNgYGDAIC++u4gcARH/3r82/AQ01GGwj0SmdZXtauAY?=
 =?us-ascii?Q?1kJPeBTJQLwc4587w4z1YKGCclN9Ig3IcC4es5sLti83h4JfZkLMwQxLSXqf?=
 =?us-ascii?Q?8fO0EWty7308wqs2EH8FEp2eiuvFYk6asO+NV07j4RgmHKUpLOWmCfv0RkDH?=
 =?us-ascii?Q?N1CJs+jz/7kr+J8llmYSvO37qt4dLIkTGAVxo7S7T4ODFbmVvd1XVbszFUX7?=
 =?us-ascii?Q?o7BATZa0v443Mq/ZYcNZNmnfwak1R5zUCXsq/FwhI+fEeptjy8d+2amVBoL/?=
 =?us-ascii?Q?Zog1pa4B7Xq/5zotqQtQNX/3WU5dlZSArlc8an5st+JtGd71oMFelHCgRjJ+?=
 =?us-ascii?Q?cjgTQTxWNpJhUweNoTIFpYQZ4KCrUjk0111rBXHYIJokye9WVJDu1ePbbG9t?=
 =?us-ascii?Q?XEEU6PTdUiC/YwtqJb09PKsHbAnYuqRWQCHXXtp2KzEz3x6Q5UFiU+s0ep1h?=
 =?us-ascii?Q?OnNBIbkDQsbauUoXj7s4myXGesBdgH7Cv+/BtKR2V+Ns+4j8gvehpEKLRGYy?=
 =?us-ascii?Q?EeMpl+cqkYbis8BaJ1utjsfdmeAw26fEH9vt9IgONKcTYKxOuaR/ouN9mG00?=
 =?us-ascii?Q?SwBoh+KHb/L4/h/x0LIoW42tR5gv6pZC88t2hI1JXFyunWjF704XebdXrc8h?=
 =?us-ascii?Q?QNqc93XL5uPTEu8xzwOiCic5SfKh74td+GJZn3KPdR7yMDAV34N8BmZsXCnQ?=
 =?us-ascii?Q?1ry8VsZdcVOwaYb4Sw1rztwX/uaT1TnKO9pF2v0SAiVxAXyUbZZB4WS3kI2h?=
 =?us-ascii?Q?0r3ypd3TVp43ZhDNSyDc9vI//Rxw1eGVD98hRn57PLdkdaYxhfstfrcOorpv?=
 =?us-ascii?Q?QEqc83Xrzihf0w92Ls8PJXJeDAq7N8sW4517prOfQVZ4T91d3IjIp1KAqVrm?=
 =?us-ascii?Q?ts70PGMj3Am4YKVMgMvYM6T6Ke3aozJ0a9GOY1EHyVLBz1Lk/hPUppWHMr3A?=
 =?us-ascii?Q?hsI7p2RP8y4M86V+Eg4TC6MDOl1gDWVM0nMcFC2k3KlLgtuuVEg+4vsDajpT?=
 =?us-ascii?Q?tZ9CzLIGEES2OOloFapCPqhhwAHlE850c0tGQd4dJSTT1n3rGaR4sZpQRLp+?=
 =?us-ascii?Q?YVBJTRr1gZFPuFppUTfn5JjxVNovS1zfSFBy6ob1gi4LEW0Ce6ZMxKlVTlF+?=
 =?us-ascii?Q?CCAC7LrUNAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cwsEV4/ODo01esdxwLM0kamR8miFFSYEJV0lzhpjXLHbVqXMH8btyisY5bll?=
 =?us-ascii?Q?PSx59i/8ktDcpvIuQmn5DpZFTX4OS9nfRP1TsY6iH0j/uF4ei639jpw+feAQ?=
 =?us-ascii?Q?N4LRm/CCj20bAQdlAL3pFXFGb2IAJO8ndDeJVqFAB7NcH2fzn2NETJ1v9ewG?=
 =?us-ascii?Q?qaBDdYnBm8BaHg8jOPdA6FiYERA9U8Wo1IAx6AxEGmLWHnukHqSd2CVy9sP3?=
 =?us-ascii?Q?itNnue7Q/jAHHk/TWGn0CjGfSEHN9rdBtj5cVagzrIb20KX+H6eeXDU1jUEe?=
 =?us-ascii?Q?7r2zynVAZ+Tm4tHwHCByzXU8qbX3k7JTpKfGBOAsOM1ZJczN2/CQ+OA+eQdB?=
 =?us-ascii?Q?WTL2JuS3qRDUPsloI8rXiYrJbv0f3ham9I9sao1PxD4NQz1duKpuO3/QYIM9?=
 =?us-ascii?Q?7QuSqoRV+HGVoTSSDE2Aw+okVxHQlE+r7GkYFyEmv+EuGsrj8Gbax9yDSN9O?=
 =?us-ascii?Q?NL+Wj5aQjCmEjHlmfgfFNum01PXNkDDaYGbrPoQbLgQ5Tlcs0FJnVh5s3a7/?=
 =?us-ascii?Q?aUwOQVB9WbxBjGhg+9SX/EH6y8aNZsTFkbrFo9ksU79TElff9iJf1nFvRdA7?=
 =?us-ascii?Q?OvNaJ7ngiWqql+Fv0pmJP7Eb3d4XNXe7S8kd2Kp7IwemABm9uQrF0/OeAWMb?=
 =?us-ascii?Q?PeWmcDB2lM62MOsIrCmDkMYlmfk1NaWtAvhlgrcJphPPS5GegE5tFd9nExNU?=
 =?us-ascii?Q?1+x4cyp0+DseBJI6GFBVXdEwmccxcOZ6rAiHgkmLUYXuyn12HCZbxWW8zZAw?=
 =?us-ascii?Q?+L4elNY39kz1kK/GiiQEk+E+2d2KlfCbwH0ewvsPSFGdfkKSIJQAXn1ffYty?=
 =?us-ascii?Q?hj84CUggCX24pSUrw5DuFVm8PKlxfVdgyyXuLoWPZmRr2qvt0cr4aixbVcjv?=
 =?us-ascii?Q?FHW1i/3yCmRqYGfhYMGMfrRj9j/0Yk4Lv1sgaw+eLlaT5ZUdds4nEAE3K55v?=
 =?us-ascii?Q?ACYFHZ7zaIlmXtIvDMFRN/QPiNMFieGTj4iwJaR34x/+ogev+fgLP23AnvOS?=
 =?us-ascii?Q?uF5Q5tLbEFKdizBkCTKs74OfRwWSHWg43ejowVnzj7j5mfpWL5JrgKJfGcfg?=
 =?us-ascii?Q?aCBiYOhgVCJgz4OMP8ZkCjsYIQDYb6yLYdwuJv9JI9nqJzZ3ar3Rrjyo5tDY?=
 =?us-ascii?Q?ZIdQszkGftcI/RuRvQKPSEhvDiKb0y8TOMIKl1LTLTMeea5xsXwxc5VzVPDY?=
 =?us-ascii?Q?8Cr7ErnS2GSQwQNcUXTCACoCv3HNVNfZcn+DU3i1beckshEcLF5RbypSSPlm?=
 =?us-ascii?Q?Cw1ZQmbEQAWGk/GNrmW9ndTJSeCNY+R9wXkt1JUENpMXJK4uuJE1xldA+cJs?=
 =?us-ascii?Q?NAf8803adA9dxq3fD9yQ9P3EXOKsM/H1oB10XUBuUJDE5o/AzWkHqoEPML0f?=
 =?us-ascii?Q?uBQWxbbU8+jCTv9ITSmMpYMioLu5+IyGQI7HPI0QRwGvNO21ScdzJEiHWIVy?=
 =?us-ascii?Q?ICYu+ekroO0Z5mx3gzKAnkKdO8QGzpSzIU3yWCbGtUPvImRfQ0/MhmNhtSXq?=
 =?us-ascii?Q?IiG+gu7Qo6NH5KEu2TvM5PKLt9lbhUFYZ9uBVA02VxM7X7e5UCO1stgWGYal?=
 =?us-ascii?Q?OWh2D8821h1SAiAohHeylYMn+tAKPDQ8TWIqGxC+JwluYxTjVCjDc0OsL9p4?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/oow2Kp2Vu/jDrfYyPFzzQ9uXdY0IqTbuW3AZbms/WvNQDSbml9HipB/YIYlQmbtP6mgAvfQr5QJDWZ2DCoj3G46RoX4xwCqXNWotJJrH7hpN7JrpzVsozWIopG8mZcyjsOVX/DREYXtJyBN9XXZoUfHqlzGkI/7BTRiEi1iYqG69KZn/tkeR6N9VgL7OpozdpmJ97+UuekiqWL59u6lL4S6ZdFmFRhzFQl2n0JR/FN6W9Uo/Zyn6LoVp9CXUdbboAB6+2ArFp64qHUU5YmuIhQEa1SbQCT9IBiwrkuklhgZ8ESe9DUgP7Qh9+wwPGM9tarZ0Z/mc2kh2VOrfzSQ9mD7htC0xvYpzgANZ5UbuW43RsvaELLTI9flG9uZGw2vwq8LXvoympAtfIE5S1Iydz7Bp1Qge60gpF2vSJfp9tTnA03nmWx/M4YmfaUfg368tNURwlbKgXHDABSjW4dP0tlAxhLbi6Ydsh2PTnDk/lP/LEuAY3JwOX6zHN6I/0osig36/yvPf0ebaQ/ZJPJc5VPwLn5C40R9m4OYeGp7UTM4JIAulshKAtKEa6sXQoYF1QewiAZhqCLa5XS7iebJMMVZt72TUjMr+KjfGwfZnhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b448cbc2-2b73-4d59-ab2c-08ddc90a3e4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:26:38.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETsWqME/tiNXRPDbYUvm9ZeLw/4h4YcyIbR16eecGPOfjmv274sZovEEtD3nonv0Guw21IqSiXZlCgRphrMiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220086
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687f6762 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=-X_oIC8DE-LHgrNfZwEA:9
X-Proofpoint-GUID: cIi-ITU7i9vKdt0ToLp3pPDF3VCrtnT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4NyBTYWx0ZWRfX7xphrCAA4i/o
 hbaV2YkHz1FPZGw4YAWmd1523Ag2wTWeOpQOnW9LYZoJRHFC/vBXm15J5Hm0l0s3k9PnEa61AOX
 KMvhNUrOpqk8zu3UJgkIgy1g18fazCsEVZC4O9AlThRe2QOZ/rUxJMvogU5VECi/euqLY54e97v
 gqXdVkoCccMINAUjYYRAuBGN4Lyfz1RR24Obwxyc9kvS96iSZMuQaf1YrEMgBxVElxw6rAtcLR4
 pCzR2CzTxWU+UWN9A7FfVFut+zXGW1MUcgvAPlfT/Q3SiaatSOAJrzxANcodBo1OGZ/Qk6pUy/d
 qAwNDJVePPRZtm+SqCpCFta119Ms17+LdO8LBV+wylAbG2VDB2HK+B2Rk9JtXtNkbl8jkHa3gAG
 extDGBed1zNh1yZsLXBfAvWhk/zOlPU8f4at2ojx7fuZRLntkDfWg9iUZCD4Iv+/K/qiXFNs
X-Proofpoint-ORIG-GUID: cIi-ITU7i9vKdt0ToLp3pPDF3VCrtnT_

In blk_stack_limits(), we check that the t->chunk_sectors value is a
multiple of the t->physical_block_size value.

However, by finding the chunk_sectors value in bytes, we may overflow
the unsigned int which holds chunk_sectors, so change the check to be
based on sectors.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a6ac293f47e3..fa53a330f9b9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -795,7 +795,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	}
 
 	/* chunk_sectors a multiple of the physical block size? */
-	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
+	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
 		t->chunk_sectors = 0;
 		t->flags |= BLK_FLAG_MISALIGNED;
 		ret = -1;
-- 
2.43.5

