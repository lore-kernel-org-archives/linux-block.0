Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4481990CD
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287157; cv=fail; b=t3JVKccNOb+jGr1Mzlt9cwBJM4bO9cOvJhOz0Zd0AYvZezFoxA0C5uQDZsFsRcZIejzA6d+g1WwkZbbaWedMzDpfJ99sqh++eJXWpxfsptKqMe668D5DIkz3MHsXDOwGr7ZP9piKwa0tp1WlzlkKJQ1SsBwdV5EVfO2rHuChcWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287157; c=relaxed/simple;
	bh=IjZ0e14H9VTZ8CcXdmRKclcBP/MrvGtnEWXSucugl9I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b11yx27NRkRVt/ZcVO6hGvctfoIVRSJqdWbwLV0/faYlbDEEzhakoCAWWTfiYFiivVvG/gAAZVTNp+NiAhnKak0LYtFRN01WLOrgXO6zSgG1cak7Db+1h+FpR/ExjmIary1WXFCju/heZE3n96b2H/O6SwIXMjjfNdveusMGHYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E7pypDR1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JuAKatEC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E7pypDR1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JuAKatEC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1fmaZ002394;
	Wed, 30 Oct 2024 11:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=KsQycY+lCRrTBSa7
	pJ5A6SBaNu71TWTrqsRed1coVL8=; b=E7pypDR1CPZ2/nLkV8wZbwfSehRPQ7nw
	bRl6BeUJXUThsRI3IQ3znRc4U0vWohJyRLdl7OI9BQtrAMFJ+h2m4yOvi5EbT+wK
	sGYmGppP8Fc0CshA6yuFAegk+sqX6eycQcIQNESCB+EcsIzIu5S/2j1McizR6l0K
	tt5T0UOqyjABR+U0sQDqMXUhMYtRAkJdUqaIxMhRJpR76amAemCZ4jlsOIg8gFdx
	tBjV+ebKSOEEQ4FbgBsUTe1f7HgUv5rpfjnb6cjiEbTwJofi68uaeQNkB/1esY0q
	7q+woEECvQeJ+54iNTQR4B0v3IujMJ8u8K3jUT11+dIBta1H9fTItA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmftfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 11:19:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49U96I5u010152;
	Wed, 30 Oct 2024 11:19:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8y5jw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 11:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+tpoct5k5g8Kg5NfSept1AlrCK7Bsz9edT29k1ckO/1mp7n+R131gcQbWZ8niAmD5GqanYrSE8PDnXd55eQI6sNHP5H3jq7e0YuZMoT7eM7AfVn+2ieRW4UPDnij9FEe02FmpXTqEJslMWFlgp/hN6LEfRH2J9nKNt79YRW1AdUcY4DbEnTucIQQeHnXU7sF9iElr1GDxvdIe8De6XsygSe6OYUUOuQj4et8qxusfGYA5A8uw6fWhjh5G5bE8RTiLsjus0zqQ0GulHObCRnJiuJB7sBKtrJ6TQfKGltN5xpJs1yczZicozuOf+Jpzjzs6yotljYgCwXz1lR4aUsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsQycY+lCRrTBSa7pJ5A6SBaNu71TWTrqsRed1coVL8=;
 b=rJvi+RAQYJOb4vC2zJeZqsYSAyLlGd35pBjmqG69407PHyGD5VsQ/HAgvgS++9HmOLm+IpJPbTkr3KMYLwTIJi3ke4Y62cjUW5tTz3vnV4dFAhLLyAFl0skuXsPAsNo1SYPYBEQItcs/jmKq/M0bm1Lc1kRxWXGMCvq7P+YV3VHxVl1IHQJADMB4Rlf+nuvs82pPCY885ncpnC9GdY79sRuAWwan5gH0ClYynHLtFxovootqMXQXe8DRrdoM4Ns2D3QkzpPYbn3sGr9PROSzsLBcbBQrCD/7GtkHle+nkUnJyp/UCmeUWjFnZ5Td3KR6H/v+0x0cLIT47sx5wJCaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsQycY+lCRrTBSa7pJ5A6SBaNu71TWTrqsRed1coVL8=;
 b=JuAKatECBFMG/yG0guFUH7pZyhz9Ta/w1FpBHpXBnExEMhU1OzME+1KWvdxsa24saJSRxDJliUlL9xiYnW04kqmBlNTF5dJqzazmaB24e72ZIBTtQj6uSxSot/FkLuyPa9QOJB1KexszEcno3A0J+OUYvQSH+hFbX11kIAjbBvg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 11:19:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 11:19:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] loop: Use bdev limit helpers for configuring discard
Date: Wed, 30 Oct 2024 11:19:00 +0000
Message-Id: <20241030111900.3981223-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0615.namprd03.prod.outlook.com
 (2603:10b6:408:106::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e53e48c-87b5-49a9-bdca-08dcf8d4aa77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcL1iOYgRwYvRqmrxMo1yGBf83JaE3PiKt982MPvp17o1CpZgVdNH33Pt70s?=
 =?us-ascii?Q?IFofQGnfqgf+4n3AbI4ss8cWRwYfPzzutrrd3vo4w8x/LRqfgGRelDpJCP3c?=
 =?us-ascii?Q?TV40Aw0mqnYrl88rlHfi3ArjetnWmzIpuw/bEcLng3d/vZolwiV/ZqGhL9aN?=
 =?us-ascii?Q?0gJvzUdJ73sxb/SYME4NvukhxcsUE9Zqy9L+SlYkJvZeb+ly7zLRek1uWUzQ?=
 =?us-ascii?Q?0hCBiMTtAn3u0vj7aPwqmm+4QcSvTd/eUZhWUGwuGWsklaSdDBsRF4WkwQbT?=
 =?us-ascii?Q?BKcbMZvTrH2zs4p/l9gGitH0bF2KNwqxdyTMTYoaunsEcLGkFSB5o679MoPE?=
 =?us-ascii?Q?/vH2aXCi1FA2wRT47lvrLlIR4iy/TAS6R6Q9uq8R0NHaEhRiF5VKCwUu+y7G?=
 =?us-ascii?Q?ru92ukZCQEaH8hhG2BuQc/+iKEgQe8LH7P/MJ2i2inS4lyRI3Cy/HqUXqo+D?=
 =?us-ascii?Q?s6elF+OPPiIbadyCs+ATADX9RwsPkZWWECgIcoONB8h3FsMnzT+K3RH4AWTO?=
 =?us-ascii?Q?lajydEcaSXe1ojwFewnwSUX/SluGMvsdx6xAVNLsGQfWPqXEwjK0Ixelm6sf?=
 =?us-ascii?Q?924I+Mj4r3NM4bywqQ+yMSHhf+UhWQIdM4jMCBZ077wKgSS60gaA7R6wsSUE?=
 =?us-ascii?Q?wkWK9k77SmXX82e0Xzb2AlvPipWrplqCvNisOm4+c8tSvYEyKe/wijWHmLGd?=
 =?us-ascii?Q?3pY4kslASDZEOpOf6Pa1zWqhfsg1yArMvS16H3NhbSEOY4jE9J6jo2/WHAfb?=
 =?us-ascii?Q?vIC7qsIgJ3lay8Y7dh+Cl7VinRwoevWhq0OuP1kh9s7A38Z552epd8TCgvGT?=
 =?us-ascii?Q?Y2W77ujqzXzoULFDJuYqqfvm8A7q+ZBfGSn+bSZUCY2zdLH3OjWQXQD6vY85?=
 =?us-ascii?Q?GnXaJ3rX2Xq70+NMDmWrsK0oFtqXXzeUSYBc0uOeoLSA3ifiHj+bnL+WgzIL?=
 =?us-ascii?Q?zBxVsEOWKJGnYF8DEJDk4mNMWiKs11FmKE9/avxUhQkSQTIBGJNbHE1tCY0O?=
 =?us-ascii?Q?lE/gLDpV93I5WJB9TT0xQ/U2fcOFLhZkkpYHHoY9g2dtaavgyhjZhyqehaVn?=
 =?us-ascii?Q?CHSXWhdBcAzG2Kv6WsbNTgBoX2PPLZRk809E31StWpyWQePM5wZ2sC6mKszq?=
 =?us-ascii?Q?18cqf2A/uhYxATi1TIfNn4+UvXWZxuszNWGvXgtRu0TW3FxG1nNbhLr2HD10?=
 =?us-ascii?Q?el7xOOUcuNpGQjaNdMRNw1q3pRRnEiKxFOA62wcDYEHbam1iZkto0J6bbjLm?=
 =?us-ascii?Q?nfQs+A/rDM5GeiOZxnyeC0YHpSOYbFAjnnA1T1xKKZAH/XzWFotMHlbDue2O?=
 =?us-ascii?Q?osc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NC3EbALAYtyYp4sl1nMCtAKhY/yDDUYooKxZ+MPbt2FlzmwjgDJFqjmKqgY9?=
 =?us-ascii?Q?6vx0P6Bavlxah8U9mKL3IS+Kt/Mw+cddlc4UeNFWmIK6sWJj3S0hBPH+RZW9?=
 =?us-ascii?Q?Dy7M02cdHD9ESgSzh70gTm/PvyeSH4PfClW2HJfZEDgS5vq0TYnXpyjSrTK8?=
 =?us-ascii?Q?beSNG0FFdbyVNwJi4j9saT2gOeQIJ3EzyEeRznddlRtb+zJnpbHfATfTxvlk?=
 =?us-ascii?Q?gf5ts6umt9kcoQy4X42lAiXYGvpUtTKsdySWi9Iw6W3GrCEYRL35+Est2e5f?=
 =?us-ascii?Q?FMsT3UlC/7ICZ1FLDlM+x141mdJwkFCxUJbSu4CM/Ffm+W9oImBXIxe/VRtz?=
 =?us-ascii?Q?VUvbFBuGj1wpCaiw9t+ZIPctq/4dw/ub7/slsW59JbjXcNpmASxI6vNpwEzI?=
 =?us-ascii?Q?dVAjYzMZD831sic13//GUt6NTAxfzf0GNp/jjocMYcZatUsTOQyrxk+myxSY?=
 =?us-ascii?Q?fSIwjiZzdsYol7z60wzR8hILWbWYd9Y5eH+CTsTh3m5BEyMmXtXt7vUY/9c2?=
 =?us-ascii?Q?feAwAA7KkzLsNvMCm2eTT0IrGMuzw7qZLToMjOGoOx4Eh3wuBwpBqkNqVZK9?=
 =?us-ascii?Q?X+tKWDR77hLtpBblTI4Eo/JVqYPgRKCbFPOVjXqUsL88sBmYpjU/L2rvp4Tn?=
 =?us-ascii?Q?f8uqkW3zV797KZbhh1j1ZUTFlUsExFgTb4NsbopAEvNkbyb9X4i2s2Pr0SbV?=
 =?us-ascii?Q?RnoQit3wsDR2jm3bS9TdR0ETGml+DpuoQc9alao+f5PT147Wr9CSvwgkDErY?=
 =?us-ascii?Q?Zw4zHnm+Tu+wj1vSKh3MlIyhVkCQuZUuq9fh5XHMX14g5Dc5jMgrw/0wyPtG?=
 =?us-ascii?Q?Hjyl/Zs9Lp1L7t9AcA1Y9iBsAVrZQ60MFxrBGoSR+kvcBZtnWL60l64FrVX6?=
 =?us-ascii?Q?1Ct8YdhlQW2Z1xxO6GF59ylq2C7DvTReypvv1uKTJVSKXOVI3Xz4VOu9NZxV?=
 =?us-ascii?Q?v2/C1ZrBY9DAUPHfJFH3r+f+uYP7HZC7hBTraxa/zDGEcRmqxqruEBblSFae?=
 =?us-ascii?Q?AgKdgaVQFFiDJGu92p6mUZhT8vvVrXWWbz0wU5oLQvo8Ia18MLhHlhkH+iyo?=
 =?us-ascii?Q?qQyWfdL2h/EaGQFrxVBGYD1XrPTZdOFXavL31OI9wJGBlgGNv33w3HF/GC51?=
 =?us-ascii?Q?kYBiFqhXkxbAjz1XxyCNXGC6eGndA9t5jgLJKUlDCBwLTvVl8P6SN/b/Dava?=
 =?us-ascii?Q?Y6FhHw7fdPWce2f9IhDV2+jpD9s/K364O4ZXcObkYj5DdAsqCu4QecJjCmms?=
 =?us-ascii?Q?+hCCO99ZfhnZPvF9p8pN8SRwXj5mPrGFi4OnbkrEjx07ZztNStnAmsFsRd9p?=
 =?us-ascii?Q?iAm8I+OvyitcLfIlSdYgQPOeIWiiF4gLepeuGTemeYSWdyx8wdj2z+O7rAGC?=
 =?us-ascii?Q?rHDWb6xI08oLRcjZlUknwiWG1W94WiibpuO3K7pFJ5f2dZnHJedDxOlvv0We?=
 =?us-ascii?Q?IQ7cr+4Q1NeaB8NA8y2zAhW2v/x/f2JMjZB3OGN7aMGyQsXHbJYQ9F97dXHP?=
 =?us-ascii?Q?jaZ4SuU76W0hmd0fLYFLiF6eLWQpo9nt/Rj5FOJJ/xvIShFhKb3hQvDSnHLj?=
 =?us-ascii?Q?LagsycrTmbxie6d3V8/PygH/wAYrJW0YD6ctGjCrrcFQ7tS+mL3qGSRgdYpq?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eZ4d7wAcifyvb4ewviekAIxF2XaCXjVqYX5a1eCOAAgKmMBK7Dxzn5Aqi+IGaZYue4Z5HXLosjfcpKIbhq81sczgi/yN4VjZ7rpZWkPc1KgEz8xhP4tlb6nnYnm2xLIDnH3MWV2fIvFKHL0qFvZ5sKriiHV0CXA7lxKVwGQ/j5tHWNrNbdzFgJ+RcCjDOOEGH5cgVzDS/ELm4qKqsyVirE+ShmIRccnfw6AJrbPpdSyFLZFz0KsDQi0Ga+3hTp0dIgEszQ96yd3kH3JHx98lWL5q9d7gZi/epyd2Acq2cYaSBF/IKvnbFclfvcOTQjLvcGp6iMmDuE06HJxvxiRjzXf3Lr0Iz6oJWToldzYBTi5GIzZX0WGwfL4oY670EqOYu3PzHADmNxAi8nga2NpBs+zEEzq0SeeiZ3QJHls4mKFHR7RHY1xivFWULY0VoFFhQyz1kczXbACJ7swlDEKr057bNoqbTTLexiA0wA+PZZd5DdjckYNoZLJ5g4rIyeWYHCvqoR0Ub0qDWTmWXonXNio7D2gOiIQcPjxT46nNXtrhd52qpQnX2e3jYvFMKqrTRUSJcRyBgjGfqt0zOLC+veodtw9vwuX56cwBL+QCzy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e53e48c-87b5-49a9-bdca-08dcf8d4aa77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 11:19:05.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGCdBsPhTorilnKWdRm9glrbE8PMnnWD4NoYYGu72Ol4nWwaGSku3Gv1ZE7atMkbFTKcpVXQsFXS1cZjdKg+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_09,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300088
X-Proofpoint-GUID: DRR77gLAjVamr0AHQHp3vaSoVMhkT4Id
X-Proofpoint-ORIG-GUID: DRR77gLAjVamr0AHQHp3vaSoVMhkT4Id

Instead of directly looking at the request_queue limits, use the bdev
limits helpers, which is preferable.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 78a7bb28defe..7719858c49bb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -786,11 +786,11 @@ static void loop_config_discard(struct loop_device *lo,
 	 * file-backed loop devices: discarded regions read back as zero.
 	 */
 	if (S_ISBLK(inode->i_mode)) {
-		struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
+		struct block_device *bdev = I_BDEV(inode);
 
-		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
-		granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
-			queue_physical_block_size(backingq);
+		max_discard_sectors = bdev_write_zeroes_sectors(bdev);
+		granularity = bdev_discard_granularity(bdev) ?:
+			bdev_physical_block_size(bdev);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
-- 
2.31.1

