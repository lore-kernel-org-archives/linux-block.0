Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D47157A4F
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523168; cv=fail; b=llxoIvVrfoh8UVbH1wEiXQ6l6+i3ESlAHxMjHN8Rm+x1MnSK7y0qkOrcVl1eWgh5lB+qvXn9JZZc1tLQD9OQq0OxroY4iGlJxyuhsvTq/zDoslQzgNIL3oDQuG2eh7svQ4XEd5ojjjLHU+r3XgCRrUo/4/UmBlGjKSeWhdX2mag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523168; c=relaxed/simple;
	bh=9sqXZLekNtaGSOC6zW/egS5HjKkoYFWlyZ684Hze1Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/X4T9+xxxSJ7otIlM8yR1+ggF/+GbZyuSVt2OXzcaGj9QWf0z4whkNpK2fn7ikd8faKXMcRGYtGj9Ua7zRl70OIbvcexyNqTpyU1AzpU3q2vJpCp7BNf7ZBfPUfaO/0TZzWIazPEOVQu38yguegKfQsVAIlWjeRRSc7dtavmCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U+RXbKh9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X6PZWELU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U+RXbKh9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X6PZWELU"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYEa024726;
	Tue, 9 Jul 2024 11:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=; b=
	U+RXbKh9bFkiVq6sC1PcTABZPkRqKH7NBRZ+Kxb63TaEmFobqdO8ElBIlLbfUhzh
	VuyZJakpDdNDNXzwQX6zjzGYzlZIdT47MO1upg89P8q1OiFzksWZka039TJhjPHa
	hIhO1xumfptbCV1fsqp9DG/seDC0sDLnqgs6gyvSIM40p+CpjZSdjjnVr3S7SPEZ
	YBxJH2YhEONQ6EE8TZxWKZ2aybx8tCE/whWtYT6MZOmpp2lF0Ui52FYOBUn0XKms
	rQKiDkmmnDPMGnP89I/7t+5uiV9SMJkd23HBqIOKY8Yjl7+aXomU39XUguxSw6ax
	5eUkSfhzPGSsNAvb3yQx4A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4prs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469AJfbt007496;
	Tue, 9 Jul 2024 11:05:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu31m0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwinIjfkjyKSwN4jMLNBJPSqQSVjTrrdyPFanTnm7h9aAN8oeFML1+3IT1EA41MZyiJ4l9Xy9tHTXLnbbn6qqJ6vjMuW6hjTgr5EQqcXdGHxyX00o3t0nrvowIPCEWS4GI1tHq8FktxA+SbNRh1/mRZWG793w3HjZWf9Jy/ZfviAd1G1z5C3VTw6OdzQGODYpF0SZeLgMYy0XOOM0V6WszVO3i8jOERm97gOQ4GdfHcA/OZ92qYst017l3edJ1+i3FxsK0NXK/dZrjHw8mCs1dYqxX7gde7VAMSsZfTMIBwnXKPirVJXZAV9uaoG1hTUEBVC3nQLtWZhhBeJm6Td0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=;
 b=MQ3Y3LtKzNNChF8YAptVA+FVmCR4uekJ2E8j7s2KPie4dpaif0/7LEMvopUoMIBI5gLocoewS8jqm+yajimsD8PjIG/aTWODlUn7VyE0IBtK0wiSp7RgDusxUcJ/KWAlhBWUWhG1daYa/ThOeRpKb/dyQHpjDRWHL+8NsAPPv6fYdF1WKEoFtdlc31UBdKxR4eMa2uzX3/xls4yMQw6nJpg5sni7+TAwGdtxYVkFb4j5fkxNVVoJOaWqqXeKYh/K23kn5b6juI5aSi1WJrG0BnA9z9oQsP5JoOAxJK2C+q/uVtqHO8/YIHTwsPvkii8KlrF7GqKyhNAUjdTh17HDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwdOqKpvTVnfd1A8EYWwsx43OdRgcMdRLKimplroUXk=;
 b=X6PZWELUq9vz2zQrlj9P142S3c7T8qx79kCHGxER9ZnwusL9YxHLwk1ADVyxivelijiAbNiasKH3ZjJYVoaY8gewQmDw48u74urMIglmnfLez0A/3ktvQjujzx+cX+eftcv2KY1wi1kE/JHiRDT0PTYPikg1kRJI24Z7NK3sSos=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:51 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 02/11] block: Make QUEUE_FLAG_x as an enum
Date: Tue,  9 Jul 2024 11:05:29 +0000
Message-Id: <20240709110538.532896-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::21) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: aea3a16b-beed-4a78-28a0-08dca0071877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0fTSfdXuMc4DgF8ms8846UjWjsoC2JRaZ4NccdzWzs/w1nNqydz4mPpz2JBb?=
 =?us-ascii?Q?u0Z5gmpUuhiNIxy3yr09AxuRQ7ut7UZGjdRDVNBp5Vh7WhAeKuJZTb7D1gNR?=
 =?us-ascii?Q?vnQ4VzE74bIhOcJOn6yO0+hNgv9S66AZC5oDtDBAc97lEIRQmIUR0mSnREtY?=
 =?us-ascii?Q?ia3beXmUP4WgBTKTmrfx8KBC2gvr5gteCkME46lWuP0YLpvvcOMaMa8xqNoW?=
 =?us-ascii?Q?VFwFKTN6yJRm9E/vgyN4sMEScbg0UsgdegxsXT6wByR6cekMZYKRhRQJzFqk?=
 =?us-ascii?Q?xqByZrboUz9MpJ2etGkQYSrxQ2KIqNRsY5iOJ0rQdmxW9H0SxKMKkzRxSOQ3?=
 =?us-ascii?Q?gfwXu6149E7dKVbt5/D+Ep5KWKxfTRLT9VH/HFJ954yOgSviV9ONwvJLJlKy?=
 =?us-ascii?Q?FcmiW/x4LlrDfiCwhgyUKtbvNo4sprgFBZQsAlXl5aO98L94siS78o5r1Yoy?=
 =?us-ascii?Q?tUqDoFKvTI+2iNEMrRFZHpbl69EjJ4+9SrwkyAwbe/RK4Z9clpkq/oaybejw?=
 =?us-ascii?Q?gb8i0qaW6VKU28wcfK5tJpm21fN3mP1mj7G5n11GSTHBczFfDMzLnhB2S4ar?=
 =?us-ascii?Q?0j9g0IHIIsKknwwq+r78cq46Z12u9ywLL4FwgYuBBv4KsUkSuSM0EruUC6h7?=
 =?us-ascii?Q?/xVZkmEggBCfTj9JAJor7nSkx9NKh6PnP1x+Do+91RFRZX0FRbWd/KlNw+rN?=
 =?us-ascii?Q?JH+dlFRdXYlmtTLKJOVeli2d/qT588IuOjpkbpC/3Vfn2D0G1IpfDe6Cwqk6?=
 =?us-ascii?Q?o2+3RtOExe0DzyGYRjFH6pEXfyvnJdvumRqGQfayrL/R0Ac81zM/j9T234mf?=
 =?us-ascii?Q?79f5LBbd8Bh567wuaSVJjeJ1lBXBphvz5GiBeiTX9zlbeAHTtg7iY3LE4xj6?=
 =?us-ascii?Q?cuVPqY3y2gJgk3tg6/LhUBsUvR8ruvwbcSdziI1Bo9QJd9E0LnlZVvpN4/G0?=
 =?us-ascii?Q?GBYHoKCaZdgdf1zCejzRlAAA1Ru9ZOheouyVk0xhkH7EYP9sYPd1ABTisrFI?=
 =?us-ascii?Q?OhR4+sR1WodhaIKhUxKoKOZzptCemRxszgSmYtHtNDYqggq08a7EP4qGOlwT?=
 =?us-ascii?Q?P+V4R55iS3rXs9L3c4Qlt/HbxPjMsS3Sx+Ko7ZbyR2mBXd0SzkRB836NAa86?=
 =?us-ascii?Q?QRAjeLqH28gRFemoSs9IYFqycaFdCEWEeeyb6cJk2ihyxMb1/3c2wiWpT8/b?=
 =?us-ascii?Q?82nztDvciSu+Km8svLi33hAFhTIwpIlN+7YHpmi6SqIcoRoN74xP1k55trhj?=
 =?us-ascii?Q?So1cXre8W+1kPewN5ncK+QNmopgYkVoscPKfba6Xmi0eyUcp7/EYWZJj63Df?=
 =?us-ascii?Q?yC0q+hiQ95ZUTS+v3vKKjxlYMolWzYT4fGVS0MyTEzq+nw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wmaVcmAJDbquEhauJ51i93hm/yyAdlpHSMqI7bRpcVwRoMJl4Q3nV3mTefrI?=
 =?us-ascii?Q?73BrGz7CBLNhoy4fs30O1JL3X7rb/6loBTUtKle9fJyLGo2A/whNYOV0nMdo?=
 =?us-ascii?Q?R8pRYG0TP11at7ZYE1L0rA0n/d/ybS3OCMn0GF81hcfrimhOd1HqR35N8+Ba?=
 =?us-ascii?Q?mX+VR6JLb8PTm0k/FRdBAlscnwDgfOD602fEZl6xBB30jVL68ELXoFBo2WCU?=
 =?us-ascii?Q?iKr8wpJJzXd2pD/3Pgk4ehOohP2kjwCSbJTYux6NxF/MaFbDoAnrEfag0lS3?=
 =?us-ascii?Q?tXSGeJ0T9hCfeWCnMveGsWHHCJbn+SdcvlYjyyaE0zotNXZYtHBtclw9RVwT?=
 =?us-ascii?Q?t7v3zkp0KSj1cO+NRifa4pGnseX2l/6caMfPNi5InONQQMMU6sV/IJlAeX06?=
 =?us-ascii?Q?F2qx9jyQhrv3hHsME2tAwqbxZBMHTvERf3259zg8DDXZj5KSbOA6QPknQTAm?=
 =?us-ascii?Q?P8GD293Yp+bCZurJolbSx+IvmNRYccME0dKpN2hBcfUhVPkkMm7FVMEAGvwL?=
 =?us-ascii?Q?mANFbelK6cETOvJeHG8d+KHYAasA4/LkxsfZr7eWhyRxo7+Oql1G0Ddn94V/?=
 =?us-ascii?Q?e++JONFWNy4l4tGH45RLQ/oEr4BSzg2mV5OOIF4aIJA8Cyu25+CWCQZKpN2W?=
 =?us-ascii?Q?fgMCi6bzBPXKeNYTAZtBCKjIjZFTt2VAI+Z3Fwscrytch15MifGsJEeUOqc+?=
 =?us-ascii?Q?GYExAV/Cw6HpAltSZchh8QiVFUbYqBQ2fAK0JlTsiyhtkBR3zqJhyeJN1KlQ?=
 =?us-ascii?Q?J7xjdWq7VWPdhnGbQn+uhsEyakyHzVbKFfVoSGHTLb+GP0mvnCfKEUSeJrtP?=
 =?us-ascii?Q?3Y3ygceEpXhOTiwewSrYf2vLbND36+/+FpPiYENNVQLi/G24ExEs+0XBB7On?=
 =?us-ascii?Q?PDPScAjoFtrwMkoFgzXonax55t+wlCfbR7OwZJFiM9YEUwnzHpx3/bxVFT9x?=
 =?us-ascii?Q?qc64qO7PrGboglbYpwOBa7ZQ+Xc88OEJ2rgfANdY2rujknadqz5XxmeVoI5O?=
 =?us-ascii?Q?pVJ+VKzt/zofrqL8ekVZIifzwsRrK6wZY3+ItFSXIjYza40y8q3KLqELfhBJ?=
 =?us-ascii?Q?wSy7noyMGoQ9TnbQDsXxZ2DLjLk9hX0oKrhYHIrWiI1q3wlz46aaeOM2KDD9?=
 =?us-ascii?Q?oa5J6wJ1dhxZWqp7+MSr/J/i8hqkyc5M5O/P+Ksl3W5d76PrN85IFSCxPWiT?=
 =?us-ascii?Q?oidmmwJNBYri8AfIxIsVXmkpacLBt1z6mV0dwvbIdZKmKRzdDU5o3jySluFX?=
 =?us-ascii?Q?65rMAM6dsR2Y4Jnv2YEs1CCkxgQY7eEBfeTfDVhuMLhO/LPiJ9EEdX+EZ0Gd?=
 =?us-ascii?Q?vxboQBC2El1aTQCgewnzYCXFgov5LdWlkrw1nRScFOmJfYGA19TjsMZxM40V?=
 =?us-ascii?Q?YK2mvWUXOwuX+7DLUV0PPkk1jKd8LD1MJZG+GM28/YqgAhBB/x3FhV4FjWyo?=
 =?us-ascii?Q?ba6dcA38AroOBy1r/MoNQDWcQFE2XOh5yHyMzfM04LfVtBp7KEHyEIALtm8s?=
 =?us-ascii?Q?V+OyNjWy29Hzf8lK8TBT02GpJgZrU/P0Hk+wbDkxd6JDwFj4hV+6BDYU2rmH?=
 =?us-ascii?Q?Y1JwX+Kh9SAiKwrQo4Ik1yiDB4jy7uzNz2NN2gu+nP/vGsT0mp+q1Dn/E5xz?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MLH7YRNfs7F1QWkqov7NDU0Mw35v354GOenz6kvvzBQDF9lemjrmzGpxFqZRFaNnO9ld+URDvXBCF3RpyClqWMdtrj5rmP7JEMluQauzajmY4oaGnvwzKJU1mSNsjpk9pGLZ8MaSbqNIBHTYZQYj9sWDq7xcEWqwRFUXiLW2l6jQ1isM+q2GbQoS5QT5jnhDnB2aaKLWiM02/O3uLEzrCgjbOGpvtz1cia1x/DRvUgFdbnTnR1cyGmWRvR1/MMDzYgibhiBh+iN1bzP0auUtXtZpUUI42nyCHCy3E68xsm+bx8WhVnKculo6lxObRfhMF160A6s0I5QTc9gdCSx3pGCZ6GFtModEUaUcYv/3QhS0RG+riRoUPAefP9zxcjXFRHrccGWH8BIm3WAnYRGSI6kpTwm32QXSqyPOCAtKcjilcGab0nCqLTBxv7iDtNjprQfslJoxLEQ2yDZM9FrLaNVpF4oWfW09D0kfZYdcP9bHJV0FGLOsxt4PJX75/WQe52OiccXpTfv7W7+ObTbZ2tAHR7H2nbvHOU6aifXzmhpjKFW8tTonbtqyC4I/AOOCY6A5y8qvP68BX3DmqKao9IUKALEyfW2JzBwjqGDSTYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea3a16b-beed-4a78-28a0-08dca0071877
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:51.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsMHpf1AhGiXTt6PsxZkdy08jenG4+MlqVMtJQcrrbk7anrPuaBaJBI/qFsBzSGM0ws19Pfkcvy0vvUrPw9v2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: FHMSg8ZeoNvX0Ukutk-2-440POThsXIG
X-Proofpoint-GUID: FHMSg8ZeoNvX0Ukutk-2-440POThsXIG

This will allow us better keep in sync with blk_queue_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 942ad4e0f231..bb521745c702 100644
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
+	QUEUE_FLAG_DYING		= 0,	/* queue being torn down */
+	QUEUE_FLAG_NOMERGES,			/* disable merge attempts */
+	QUEUE_FLAG_SAME_COMP,			/* complete on same CPU-group */
+	QUEUE_FLAG_FAIL_IO,			/* fake timeout */
+	QUEUE_FLAG_NOXMERGES,			/* No extended merges */
+	QUEUE_FLAG_SAME_FORCE,			/* force complete on same CPU */
+	QUEUE_FLAG_INIT_DONE,			/* queue is initialized */
+	QUEUE_FLAG_STATS,			/* track IO start and completion times */
+	QUEUE_FLAG_REGISTERED,			/* queue has been registered to a disk */
+	QUEUE_FLAG_QUIESCED,			/* queue has been quiesced */
+	QUEUE_FLAG_RQ_ALLOC_TIME,		/* record rq->alloc_time_ns */
+	QUEUE_FLAG_HCTX_ACTIVE,			/* at least one blk-mq hctx is active */
+	QUEUE_FLAG_SQ_SCHED,			/* single queue style io dispatch */
+	QUEUE_FLAG_MAX
+};
 
 #define QUEUE_FLAG_MQ_DEFAULT	(1UL << QUEUE_FLAG_SAME_COMP)
 
-- 
2.31.1

