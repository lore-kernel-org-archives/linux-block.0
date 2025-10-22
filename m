Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AF169AD2
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148459; cv=fail; b=Cn7EPJ5z+f7+TClPDhFGDrYfIUWfzVHNlTNNMsdQcFnX0R8VjfONgbIVPHzrQuVwoQjxdqSixIvjwfU4HyRI0MJxzUoYagq7TPsXB2J0jqgKEACYGheAEMX8vTWXjm0WlKICZ9nKPlMNJEg1V1LK7voL/1CgTexdUjZ1v/7lsyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148459; c=relaxed/simple;
	bh=lcetQSRvwcSwct8XVPZhjM9PM1EJPg7f9Y5ezGTs3NI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Rfkh4SJ0ZEhlGj9Y+elJLzg6B2V4tI0sdPum3CRaKY+vfMJZFpZEoCR8ZlXhIr8Uq9nxirPFEmzYmeIS2Mpw3zFTDMtWLJjk2J/nekPCj/aBoFbj/AWG6ld9MSrgl00mvt70N0k3tKZUOdWXtTL0ME+NS9kFG9U7Vfc4XqqqWF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxDMUfP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jl1MAv1u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxDMUfP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jl1MAv1u"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ME0tb9020060;
	Wed, 22 Oct 2025 15:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TOg8XahF+3hCRCSNIz
	YpLpOJR4Cfs/zUHH2BYrzTZ1Y=; b=LxDMUfP4MPtRUpcfatL006lZWoKXX9MpSP
	HrLNXseYKVy5+YktgCz/lc/S/541FtwFwBoIpPEth1yre0V3ImKeN3V3TZgK1AYh
	/0P6HQWxGNHackC5TqfZLRGcdy4VUjjeeRyj1rv2SwbpaKOb9QL2LqriBDi1kD5P
	18GYOb3NbE4ZlA1plic9E6wgKZNIVSnbI7vJ2R2RSzKcdN0J//RmF2/UYOJnT337
	+6Fv74/AHQMrruwWLzNOnRd3Qy6qsA8lDCh8Et25BPss0MKqG3vw2Qu87Pdw1uh+
	8q8jHZx0lV0I1ttOCE3zSlQz8OgP074SvfMHIG+Vyi2zrxuFx70g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstyh30f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:54:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59MFqmDH022270;
	Wed, 22 Oct 2025 15:54:08 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bedmkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 15:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDx+q8kg8Wt9CfpPQomfybI5IpEC7DfvAHOuOxDhHaRrAiC7UmwJNf0yem9bu7zCOnlm8dGYjfp5qdvftsPMH+jkmrB+Xw0guYOHMaBwmXebTVNBw0JCwSzZz8r3W35SAnMin8qhuWfJ1PUxEJ4eIjM1ENVPMnQb4n4f+cJKVUEhTp2vBO6HJtq/958kA+5EluFVOpfJoyDJoY9Z8wK42JzRwAZVB4XZRERD/qt2wefiW75CFw7ObJskqn77/Dx5WHAq+MHTqR/hh8D/J6aR4sGHcXJpJBq8dlRQpChudY3M9nEHKoD8Y74j5WV+uApMFiU6vkWIXWP8BEAtm5xpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOg8XahF+3hCRCSNIzYpLpOJR4Cfs/zUHH2BYrzTZ1Y=;
 b=U2NieHUjCvbEewlAo8z8c2V2tFCjSnuXIPr/2eq8b+cZiiMLKUiVm5/D1+x9RddJBd9jWnR97PDLW7yYk93yU+cnAc82aKA3bp7LXSJB7PH/z5l0fhtYgYRHKU4SPUT+r/ZkJJ5CtMckrSti1dFYIYr8KgOXKQoM0z5YzOERChNCFdx1ayTvDHqGxY1Ic3lLtthiEvJc6eD5qMuLJzitcIiZRx3jV8ZhFbiRPCxsXj/Lc57oeHE4KUp0w2jMdIbGe9WJoJAcs5b58jP5BV5BAbsxXFI3DVlV6eh7JYNvMf/UaxPmE2ZMk9VnghQXVJ0e+fCijxySc6e5zrHBHGe2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOg8XahF+3hCRCSNIzYpLpOJR4Cfs/zUHH2BYrzTZ1Y=;
 b=jl1MAv1uAf5vWx09SOjUqM4FPIMKHyWKiQn7+4bGyAXnd0XdDHbjSN7Iidyg5AWigSwOSrFjpXUXhmY2Kmd/HEW+5XNXvwMLST9qfWpQY7NsAK9xQT5UN3/n11LcqLWLgizCiYIauWaKO3MVsVjUolK948amWQIWi4wQ8+RF6HM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:53:20 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 15:53:18 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH] block: require LBA dma_alignment when using PI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251022083335.2147105-1-hch@lst.de> (Christoph Hellwig's
	message of "Wed, 22 Oct 2025 10:33:31 +0200")
Organization: Oracle Corporation
Message-ID: <yq1plaf2at1.fsf@ca-mkp.ca.oracle.com>
References: <20251022083335.2147105-1-hch@lst.de>
Date: Wed, 22 Oct 2025 11:53:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::37)
 To CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de00c14-4303-4e9e-39ca-08de11831e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0z8jJg7Xc3RHCzcWVqTWfDpdkYQpb1SO4HlmaLHV+tQ0eYMdAxi0nG7FDKnf?=
 =?us-ascii?Q?r75M8dJd3DoLT8TmlmK6hOJ0jtliiEVrW7TppKDo/ASo9Wfo4X0IU2uDwVKb?=
 =?us-ascii?Q?4nOE5vp/VurPnsmB3x6OXPUjQWgV9kw1wnlsSk9XQ0OoH/KeeV2oBxpcYMdA?=
 =?us-ascii?Q?2IzaMmmhsQr5tlMTi+RG7FiR7yqnQvEQ/uztu4iYM1ECAu3RFqD6AcdqXzIg?=
 =?us-ascii?Q?JxsI027RKyAz7oC4+VKFXr3SPBpW8x+ReUjXQHRFHqlt1ve/pMPedCxSCGQx?=
 =?us-ascii?Q?Qz7bxD1ROPIYNNZJWiK02urhosR4JJE8D+lv5IAV5RfoVPxg4euHkppPXlVH?=
 =?us-ascii?Q?9gft4/3ekSldy7Fkxz9sy+UzM64MQP+d1uludp2q1qi1cvHvHkUDBhGCa3jv?=
 =?us-ascii?Q?MdmXwN0ahVfYPJQiyHbErQ9qW0dg6soaci/qgVcq9myFD4J3H0HQmEAZSz2E?=
 =?us-ascii?Q?cCfxs4kTAMY5Z+njWzJA19DF86FKS4A3TSJET9aqaA8jHcNLZBd3OFUavTnx?=
 =?us-ascii?Q?51ZHxRDJYmHBhF1Nc/J0ggXPNzHuGM9tz5+XetnXfDc08l6ar7B5hBDhdrl2?=
 =?us-ascii?Q?gZ7Q02fj9KCxA2yiOBsDMBJQAuzxs9eUYp1UoDnbGwISQhhr65PvuYJtN6vm?=
 =?us-ascii?Q?fALoToefYePBl9OIdaiZ1xCjnA6POd25uy7ez0xn8n5XAXv30lweLhRZJa9B?=
 =?us-ascii?Q?faJx01epZ17j5xr/XsmmfSdub9NC4s7t3WUGfZIaB1dUWLmCs2nAMQWg0twU?=
 =?us-ascii?Q?ojAxjqI/q7cMyt4A3fW9EmP/iM+HvW8qie8UF/8kLO4R/1K1mdyA46I//5jh?=
 =?us-ascii?Q?jbm4lWHF7LBxtkqbSxifpS+DXPAmTnh/DvfzafmHIuld7IW53jKaBp2jHS+d?=
 =?us-ascii?Q?yjk7712vl3wXDluGzFzv/Oxw+RADjfMrQUiP9y+C8NJV4ZXKiPGY2bTCXNHK?=
 =?us-ascii?Q?2dkzs7L+w6jkZCWnhKS20Xji2FI1IjZXAXKy3v3ygiRmWyaEgbtlziCfGPxc?=
 =?us-ascii?Q?yDI4WsrT5mxYJU8udfl2H4z8Uzg7fWTINsh3HbXzEG1oNrQRFFeOjFRcgTsK?=
 =?us-ascii?Q?ByB2IVJgAtTjt47aP54RKlCVCV/XQ3JJPoB2oV3kewFyuxGxDDIRRxvfjBeF?=
 =?us-ascii?Q?H/nKeHsHZuGtgrrZOqJL5/YJK4Twf6B0ZmZPm7ad+bEzoXkHvIXg/R/Ml7dW?=
 =?us-ascii?Q?glS1zO4Qz/Du0ugcfIewdGvmHYlvzTxaG3ca5Z1zrqIVUPwYl4D40vo3gt6r?=
 =?us-ascii?Q?Xs7Biwi2VM6wTjYTWEhDemWuvc5z8EoDEqnQtglpWDiz2bXY1FqkwVeiKEMy?=
 =?us-ascii?Q?A3LDm3cG3wmHgYTg+WL+iwdQX1gI2nFys2/XTgPPNrBPrZiaeavsng2n8bPv?=
 =?us-ascii?Q?PWEytEmjMNTzwW+erCJTYhzdS2yTjknNSeEKmpt6GHdXjw544EgMX72SOdcz?=
 =?us-ascii?Q?ibOJfM5HQhL7d9ejz2TjqvuAt9qOKPHB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9iqYwboCxEuFUbQcGE1PdrrxBqtfp/1NH87mVkL8wSZo3v3iAWQprM7XHCX?=
 =?us-ascii?Q?kSwkl+mA0C1o6f6KUz7AzIMtuGmX2cE4gUKwFCV2OI13+3ElFct+yLn6JA+H?=
 =?us-ascii?Q?Gfc/B5yRw/LmvflauJPZT1e7kPqI+H1FHuUGPAjOaJxg8cL79dXByGWxdxmA?=
 =?us-ascii?Q?6cIV0O3zqnWqMZxCb5xelC5+avbpJgbzvrtnfXOFTP6k60WNNJG3n3i/oboF?=
 =?us-ascii?Q?Zs4jJXvtMgSbTFpv3LjMUFC+OXAOo2QPhXwS14x3WqNJSC4gS73e3i09BxMA?=
 =?us-ascii?Q?kNkZBZ9XAzB+uh9Izq12ddFuJViX66ZZmLCagoyLWoUi892I5lm/6I3in0cB?=
 =?us-ascii?Q?Mi1Z854c/TNk7v3EN1+XoShZKzHxHhpZAtpKjFe28pwe7X51D9KN/9UEUipV?=
 =?us-ascii?Q?K1OrVl247uHBQEsbLgYSm8WLkZ8y/ZOip3coCo6PS3XCdhTij5z7elcQH4e3?=
 =?us-ascii?Q?H18OjhZBRFqo0IzC59yHmG3BAvZjPbvKuGT/mzzafJzkwPWz18feIZQ8tuE3?=
 =?us-ascii?Q?cLzK8lJ+CfqZXaAZMK5JU3w0kIccMhKu9wmh1yn2JTJZlQfs9HzKMW0XDb5h?=
 =?us-ascii?Q?jwGynCLAskJuOOEg6gyOh6K8kPnqWJ9pLs4M2QC3hrz9VOe2StRII/5zNB71?=
 =?us-ascii?Q?odBhtbkWdrGR0rrwZAMuMS/a2rOUUqUZ5mK4w2nSw7SmCoeHsZ5BCe197PJp?=
 =?us-ascii?Q?8hPfNjPIGDI+XcKHAZ+t5g2CfYYIGi6joka5qQrP9bE32YXTbT6yD5vAgG8x?=
 =?us-ascii?Q?z1efi8Li74+xhjcrWTrky+cnJ5Vm2zDPIaHkFqoUe4mC7C0w254KM4Ubu22G?=
 =?us-ascii?Q?IJGrr0Pe7KJkXhiYoIfOyot5PrtclX5WDe4B71i7I55g4/4QtzGzv8Udbm2E?=
 =?us-ascii?Q?7VR7Jkas/YvHk0Q9BHTXtMB4zQ5L6XMa/vGhGRm/2gaY8KJAQMTKAz6Q5TVU?=
 =?us-ascii?Q?MACOXfF/KA4g1JVpK9jo+bGEx/xt2YoAv32CwenGGOqgyEFoYgpiVmCbZB99?=
 =?us-ascii?Q?XZApN/8MsrUQUnh1/4b4vlLyYD5sAdX189qbZfW/SE2QcKuJSxgUFknzMWkV?=
 =?us-ascii?Q?ZT0P16CHaSbH0n9kcRW2sXy9xR50WewFyiDE15OLUx4QShSW4inPh62co6/N?=
 =?us-ascii?Q?9Zd3OLeaC6gRZocRquWdccXKvymr4WsiX5AXW7HrQVqxVKnDfpl73ruXgdJc?=
 =?us-ascii?Q?vIuNFiimK6dghFFombcS6Dis0B0QZYFtl6itBkOiEX/Zx+Khu+xLh6nrAl5g?=
 =?us-ascii?Q?Ku6Q6c2F3Yia6yW154EP8I9kzM7wLinGl0yXx6WbWie5F5PIcsyYK4vZOatU?=
 =?us-ascii?Q?VKBXvkMHjMn+l0ZmOO9QyryoajPpwYWYc0ZFUYVKxXO8dT5I6Yar1LxUSBWJ?=
 =?us-ascii?Q?BlzkGGTxJgX55mVvUenXHsj4xNnM2KMpQCz57/jw/y9qiJrxd+YXZg0IqOA/?=
 =?us-ascii?Q?uOWug0y7O07tnNukKVfzljhrIUBS/No4vIQr9QBHqgO+44p7dtlOiD/H/k4q?=
 =?us-ascii?Q?pcaRW9BO4B5XDxYJVGcKjQIRrMtFn+e27ao83jDEb7cdeBBwGE1a23yGCbH5?=
 =?us-ascii?Q?JQs8g3E6k4GbXy5fhLfM0MmDsmzRrw5453KrKv2ScSWeE+c9YZe42ht42sKk?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PP1UTZtnnDBtkaOGSP+4SlovyUlnczOExrpgQddL1iUwJUTbSG1QLwU+X/8STR1fFJimJlVmqxDdjgNRfyX61nDL1tDkR2Ror6hp7JsmbHIWZxygNOMqgmX0gZKoSIfPj2hzJTG+8tABz/JBK6x0wNtHYI4cTOysvP7bF/91MVKKoIjimb9oFJxTvbvCuqL3s85uvreUiGh7L872dFbYih3AiKJ8iTEz2fgmaD4fT3N1LP25GwP8Uc9HDrZ9NlSCtClsmvnFgv4B7bT1zuzHIEJMcigxgudGiDudA7b93D/1qlqScqRgOIqGPdvuOR1QG1ydyqDAjnAe4xx+x5TDh9cAT4vxvaVFAaLsAxYe0XLEVOklYvObmKozrIswucuo401QQgF55jddV9J6q7lUqQz6thr3+CFmEVDgxI6PSX3JYZIxJIJTRnlboqdcoaeHUTvuXawBkSW/VG1IKAIFBQEI2r2+lBcmBzlXx7UnRaz1nnxs9mm0xAfKbEiqWiyiooKitVTH79J5p6g3hRqr7p/19ENRyBUu/c/P+vb9lk9DYLXxWrLNebVWrUiU32/knzaK9TI+Dm6w8VIgIDX/KM9Kf21U5d7Uqkv2jIFC/c8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de00c14-4303-4e9e-39ca-08de11831e92
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:53:18.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlfpE81EhUI2kMUVQAAcQgWhNPiavqk+c8SlabUJyR/YXSL593M/5YJwGCR6wxT8F2NsTCMdVUYWw32PKNx7cLSlcz6cYzu69MxsvKAOLpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510220130
X-Proofpoint-GUID: U3egxWgJ_6iU-HLbBZpoEA7Tpj7eGx1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX0zACNPt6KGIG
 42jzRt7Qm7b0DjL5cjvISVdKFAcOXDZmu+zJXbEnESjmfYux+4q9VGni//45ljAJZqCBIh5TDlS
 WXxgLpOoRt0lIxc3ApgSbAkSNVi1J1k8NqinfoBV0ZeOjrKehftAZgAEIRkuPEeohZlnUt39lBz
 KAgKg+EPlwnPd/Hjyr0AOXJQL1Poo7/aVadx4mPWOvBRpW057S5uOuxBbimV0YsB8nzW0Nve/z8
 ARNtx1o5PlhNAznflxJWyQIvA9zZCdY94hg53P8e42ZCGcadFUM8ztOFA1y8jFov65Dqq1nhRhQ
 B+qYNcRF0Y2c0x9ssisC1cOHmxruEBQw2cVjYq0mjXge5A71/MLsvVvWh4Nm7od3LoQ5CQU6N0W
 /jN7nqSAaXkdrkwidew2xOuvwLVSg+npVIKdIlAi4T/u9w7WDks=
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68f8fe22 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=yvCRMcChCQ6_FPvd8GkA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: U3egxWgJ_6iU-HLbBZpoEA7Tpj7eGx1c


Christoph,

> The block layer PI generation / verification code expects the bio_vecs
> to have at least LBA size (or more correctly integrity internal)
> granularity. With the direct I/O alignment relaxation in 2022, user
> space can now feed bios with less alignment than that, leading to
> scribbling outside the PI buffers. Apparently this wasn't noticed so
> far because none of the tests generate such buffers, but since
> 851c4c96db00 ("xfs: implement XFS_IOC_DIOINFO in terms of
> vfs_getattr"), xfstests generic/013 by default generates such I/O now
> that the relaxed alignment is advertised by the XFS_IOC_DIOINFO ioctl.
>
> Fix this by increasing the required alignment when using PI, although
> handling arbitrary alignment in the long run would be even nicer.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
