Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D41E502
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388599; cv=fail; b=ggHt84HB5u+Z1wwh5PaQ5827GyPVJu4gq8PVc2yCoLSAcYl5OYS/XIB5C53N6FuSyFDAjI0B9RxYWmaYMVo6ATxsKOIwO9HEjljHwKnoMU6wBC1f9txjxdEf8hGsLNNxC5FMqv+ZsOcr0kU64hPttyNhcgHf56UlWBBd8/RdZ1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388599; c=relaxed/simple;
	bh=WmsA/DGvnnISX7r8xJcZQKd4LN53JSRVzVTPN5+Mx+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VNratBA+HiVkaL7PCeqwEeFdDE0xrS01K4tqwDC7RCTFS367cASMeFiWaPi2jBonBMR0irwncYN+iJiqhgv4uwpZkGj3wad1mROgOy+q7dZC9UfT2YzevVylbSpRdEUTZOIKYN94Pu0vfj/r++8+XITaZQhi2laApm+kg7lHgiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mTmPHZUJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WEQ6asNg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mTmPHZUJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WEQ6asNg"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBK6Fg011788;
	Fri, 19 Jul 2024 11:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=aym74ubHp5pCJ5v0xlTqN38JVFm1jlE/lLcycpDpLxY=; b=
	mTmPHZUJbFaKdyuD/MrFsWF5VbknDSwZ/edLbVFp4wAaGFBcwHTmluYC729HO4qD
	ZgnFebkz+rOVvp+FGvS+0XRi8AAUXpebBz/X/EH6o0mbpAsZL8tEyts+yvnFHhd7
	kXa+NO2qrZPXSo5lXPf8mNPCYJMTPL4x7Ts92nnlcOf4X9CmH8HMqSJGvOUWQ8JW
	/h5X/ZGTxWG0hhg3zSnKJZQxW94Pta/c7prx2YysjQDGGVTUDaeOc2r+0vP07cET
	zahm+d3fye3acKnMBGoX90I6HqIXcrYysVu5qLjEWZ+9Cbi2nrdjHbw5oZEcwhmE
	qOxEhU9D5ul0WBzXxmcn1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g0pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46J9Z6EI039675;
	Fri, 19 Jul 2024 11:29:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexj2hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxfJY35uQdiNstOPL7epdg3OFvfNrDPSDG9ZxLmuxDrzpZnpYOAiWSzR5blF8/djwfVWnYF4/XchQBl37zttBgLQcAwwqh0CTJdMj4j0PRiuB9paYlP618lnrCCOi7zfAFqboHp0bsgN75g824I/9m/fa/ra2BJr0UQocVsI/km2aQNtJQ5R9HRpQBhIe7fmzeUGTARjBuUmuCW59uiIzhGa+n2xPZXhJrmMBVBlevRS2QLjI51enrwKfMF8WNDaIQLFB332LjWggjzD14jjVqDO2AvVk3lKvoCJC4TgJ2JQ7+H73yFrDOlzJjwmHHhRg7f0Cw3jPhknlxwqhjNmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aym74ubHp5pCJ5v0xlTqN38JVFm1jlE/lLcycpDpLxY=;
 b=n2dVqytsTRVeD+syPTgQsGBK3+QPu5zL8jDNf95Hh016RkOqoYCS2CcNKWUhgdnPpwDMxReQSiluMq4zJlHm8WruwaUjcYH5Rrtu3YrfkhtI7tgPbqyZDvtcexpAcyRcQemgoFHYjp6WZMISiMvrLG5ja5Pi6jOiLmrONJhsBt3TYWiSc9/EI/UNcmc6gkkhN3ig9MPigOplk+QpZ6aY5XxDLQg4iC8/eiz01ZEodHeMLZHWIcqjDz2yVJivu307wxyYVgZBPgnCTouiQU0aaJMdUEUIyRe07TeDtxUL7Elljd08UTgQi8Zp5VNG2D1s0UufacrJr3EWSHXlHVnZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aym74ubHp5pCJ5v0xlTqN38JVFm1jlE/lLcycpDpLxY=;
 b=WEQ6asNg/AfSGm40wGP1hPzLEI4bLz22wLpBNYQYKUzK+xG4qZo2jE7k8lJJ9PA2SJG53wufndQLFv1LS4fAQtkI4Iz4bV9mnz+6Sv6VOknFy0UMKlF+zvmV+V9ELGZyTNyLSdI1jpZbLK3pwp71Yt/N+1tni/DgjKXsdu/3y98=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/15] block: Relocate BLK_MQ_CPU_WORK_BATCH
Date: Fri, 19 Jul 2024 11:29:02 +0000
Message-Id: <20240719112912.3830443-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa2742c-5bbb-4703-8011-08dca7e618af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LZoULgRopUyk4311WoqDbgePW7NprM101ftH8a196CeyoFs792alHySiRsBI?=
 =?us-ascii?Q?duJZWSYRWk+4+uB2e6X1nReNF1sbIWWHXUND9KpdY10/QsTKa7HTJNL9EijP?=
 =?us-ascii?Q?U/0cvxvBreqi4HyPBNVgbtajMhNVRelpUbUtlg/8hTWWVLwzTbBY3GehX8Ve?=
 =?us-ascii?Q?F0MxsqFbgdRcQoNCUnswYNuG58/Rms/LLPELLlFJw5OUDHJ8F8ZPnx2yQQSH?=
 =?us-ascii?Q?fsBLP5RYFWS+j/QOSqTY0sFB7K3CT1Ox+MoT7uHtd+3O089DyvFUaKMrqOej?=
 =?us-ascii?Q?pQyEa8RXui1ZhBgIuv1ejH5Ap7z97jM4M/SQ3y7WCFBywXYw6P2dOqM9qvxK?=
 =?us-ascii?Q?7B0/k4RmLoForT43vL5LeLMIlJwJcJAg3Bx2j03min6kYrexADWIWbuwJzfk?=
 =?us-ascii?Q?yUHsEf3QYUBj+hyfqrERpYvWGFU8beLImdymBVSCp5GiLL43VD+egdn1tAY+?=
 =?us-ascii?Q?Lecf4v7x4qdxUk6f2Ptr8nENdh4dbayF4wp34+7tT3exwIk0PysuabJYBiuH?=
 =?us-ascii?Q?LEExEQOsRguYheLtNAXxUP6Ltd6UalSETqW8MDoeYIWuFEDAhm8TuhJshEEx?=
 =?us-ascii?Q?xApdPg7ulbtbTNSqGfj5egAc5ziehYZPYEq48GDUS2C5ZGh2eNYuAxxZ5F0U?=
 =?us-ascii?Q?1mjLoIymEGZUyB2nn2FJ2EYa8AFHnVtQEhF5ys4ZybY9mfO6dU+b7EYhMs3A?=
 =?us-ascii?Q?S8HvkSGETLYZlqECGbbb6/lmke4OKm9qMqUOghzMjZxSwA+rNN2Dj8CEnXk/?=
 =?us-ascii?Q?nzzyt5p8N2NlGWtGpbQCnCA+0QesT3YoRLqG/dd6x8T+Kit7PAMksu46StRf?=
 =?us-ascii?Q?2EE/naDbxPEqEWAwl2l1XF+mYHXarCYYG704Kw7KduKCQViEqYkGK6+23UV3?=
 =?us-ascii?Q?5KFC6+Ua6YMSnkm0RiN1AljMpLhFghqHJoPtFNJ0y+nsYgpccsmQJWWCIqQU?=
 =?us-ascii?Q?RAWUtwxnY9nKbY+YgCPAIGdOi1+iDykqPLcxyFFJTmHjzghvsUVjKc3ZswW2?=
 =?us-ascii?Q?kPzVkhwqEscUAq18nYwPtDokaOFdkSm2+iNfisbntdmRLL4xuG6RrBuW7L2n?=
 =?us-ascii?Q?LUEcK9xREgmetm9AqitsrRUuEGmEnh0HtBbat4n57WQ6JshsDKlKVv1k2eP7?=
 =?us-ascii?Q?CaUUeRZj3vhEheIXK6ome1KBOOPRKeeIN3zTBvSx+qgYhl61Phb/dbns9j4G?=
 =?us-ascii?Q?zQGsggMKmmAhrTOCHFNkn7e7aEJmqEIcyChyKGOivm6vQU9YAKZYGHAuLNtA?=
 =?us-ascii?Q?ghAIIzibPAMh67S8xpP95o7XU171N2sAPHRamUS3ZhyEmYq2gfOHH/4ItTn6?=
 =?us-ascii?Q?6m/G4ycOvs1OSuCPrwsXLs79DXg9jX7a6uVpr1zsNzFdIw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZNr3adZ5JaV97uoY1QWIOj+M5rfC/QdmsIzG1F/jJXm9Nl90B4GLBCQLazBr?=
 =?us-ascii?Q?icXm5Qidl5/g8E9qt/5iMMTnpEmKE7f7sXAsZZZVkN0QqcyIg9aa+SvHc9F3?=
 =?us-ascii?Q?XbWL3LSwTB7N46FCZ5ISUAhcEEzWMp0ZsIZDE9Tip8fqeqgYQ9ZlCPtPpNlG?=
 =?us-ascii?Q?G4zBloRVD5TE0ofx9WOyXQIbM0wK6ooOtsbmaXM31Gb9XNXacavcALD6Rg7D?=
 =?us-ascii?Q?xkjwil8NXUocLgF8y7eVrFpC7QZOnib4QzSUBWW9TZpvHjaXMZlRrl8X9pIn?=
 =?us-ascii?Q?Xlv6zxSyHEhmyy1z+iPD4ULbKk1Yp40ssZHE0+1dfGRqPpsdMp7K3F0yS95i?=
 =?us-ascii?Q?E4Is2wqTn7ZANZ4TjifzKI1Dx72iue2gccGS+Y3gG11o+dFa5kdwNA+Sd32f?=
 =?us-ascii?Q?MV0iPLV095hjWzbH2Ui9+CUXGEr8qK8sQF3/Qt/b5T6v0eZarWSYsTYp0qz8?=
 =?us-ascii?Q?uj7kJrRcGQqABk02DwFU1dD9m+k4M3HdVR7mVvJD0WQCzUgRvuaEcngomDBE?=
 =?us-ascii?Q?C51LcIqQ0plHwiUHYf7x19AwfTUu2qGMIQE2vspCHm4IhUnz4keHn5HUJITv?=
 =?us-ascii?Q?dN0dVUfPK6yCUc96PItp9PtwTU/PlWgeJTO51MDsOv+kdP5cm4zYPVkd5sQu?=
 =?us-ascii?Q?lDzvX4GWP+1xfMzL/rHiMQwtVJzpnbMBcsiw7AyJxzBrVr4j4TxTMgCCbuUn?=
 =?us-ascii?Q?4J6rEFmTjm5Azk3Az2/PRBFzMo0xIDOT8OmyQ3LvFvVMzQNMGmOkOqjkaBuG?=
 =?us-ascii?Q?tssJkyJUMvxndx/Jgya+s7xsfpNPn7e4ySaEDQL/LChpmOuQ6/a+mHdYq6pB?=
 =?us-ascii?Q?sKdEqBHX26/ueUkSwCQ4SQScNnuUotAq4bqCblQM6mndR4l1pnEHmGVQsozL?=
 =?us-ascii?Q?RPDTWMzLk0BSqY5lvEMjbCgr10aQo80Do3Pu8C9XJR+EUElbN/ZwQC8vTN4G?=
 =?us-ascii?Q?2pgBRe4hMOSOw7QBCwUp3GfxqNl9r/3nI/7x5s/BWV5xe19alON+6W+IEwNz?=
 =?us-ascii?Q?wwlV/3YiuYja9JEYpVkGnNbVn1vbBsZ6rQ+wHNv2zhiYQveatZcJmDMCIdKo?=
 =?us-ascii?Q?N7zYDYpermD9bEmp7Yow7ppuofT44Xp4cK30NphGwaIBhhePy4+u5yDWvoUP?=
 =?us-ascii?Q?aL1sezn8iRXeh1UpfvHgSzcIgv06PBNGLq4H+v+VotPryKKrkToLK+lH94PA?=
 =?us-ascii?Q?uTTT89pmQiTWqqYSHnHPkYQ5MoteZI1O++NJUvyHZnjSxvUARzHxu9DP3Aov?=
 =?us-ascii?Q?gNmYq3eAyQiBMKn5qhYhkoDRHq1iDkf4xloqfXU6zK94Gi57Z7GH1l0tAS5E?=
 =?us-ascii?Q?DVcvYE+Qr48AAEDk5CVzwH+nIEW0CvK3kbCLH+GHhTY2g+1B04CbTzUSspHD?=
 =?us-ascii?Q?L3zWluCHi673v1duFg2ybiHYvjuVfllyFgNy6AP7zc8llMX00seKMiYUqPv3?=
 =?us-ascii?Q?4jrr317rWWv9amd3/LpbM29GIxXDg4A8yv9jm68FSKvPwsYzj/tld8FZvxv9?=
 =?us-ascii?Q?kFJ0gYSGFT9eXVYxMs8PWHh0OLXuhysVqAVL4ef6v12lVUC2tspd6W0YNeAQ?=
 =?us-ascii?Q?rfbMQJfyRMmNCZcrx7s3krVIvMYZLHzyx6fxuDAIQZgO7l80rwGLj0nwmVJI?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LecW5jjDUari/7EpA3rYLkq7a7YYwbD9UNu9o6fKlf29Y/Zc/0u29fvk7YV1OcH0xyAL89O8IbuMqEkO4k0xAGbqXNkcq/TumH48jBwVv9krVySWETCyZUi7xfRF1W6q8lfXPDl2xYN+BZNSQeulQk+SIsOeZcKc8mqyNjaup0EKNxiC2JHQSwtx9491Umo3HOtE+mc5Q8BWvaDH9SMbmOxHpLMCVJ3ZXaFI9s3+j0pJ6uZqW+4PoNBkMlwwJ3SoqGU8uPTq8QrL7nZKvrRgYoytNHDwlBIMpjwVhW9tXWNF7T5c9Y3yFR0IweSOGZpYA2tv8vlyxK90UOn70HIKFmtIAgmuu/jN5RoudWeJWCHH+0GKSMzZtWpDZXSIq8++jK+ltWUCF4fch6SUhaNb5oDo3uttGxk0cfy4Klcof738p8MHfCuD177i+gHUVvzE9ZJhT8Fpsv8/Jq7/XEIKxsn5xEdxnfDIj9C320wXqcr4mnxLcWBYtBUM/j2Dywj7xFZOx16DEao9j22x3yw4x+ERfIK5wqCHlMf9fjQwQiFWrO0vYEjyIOBUGG1qklWOCbno83WzWV7Yg/HD4ejvU6Se558JY7fuuCr5GGnjfYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa2742c-5bbb-4703-8011-08dca7e618af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:47.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAqEcypFHsGdtN2qEvOy34wYdSHCo5bi2iw+9AvmTumImp/OcoQhHZyAHYXa6b77+Ehy1MhsEsersM0JowgAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-ORIG-GUID: lQ0ZBQeI5T_lxEKMPD4H6UNzCG9ZCpHp
X-Proofpoint-GUID: lQ0ZBQeI5T_lxEKMPD4H6UNzCG9ZCpHp

BLK_MQ_CPU_WORK_BATCH is defined in include/linux/blk-mq.h, but only used
in blk-mq.c, so relocate to block/blk-mq.h

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq.h         | 2 ++
 include/linux/blk-mq.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 260beea8e332..3bd43b10032f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -36,6 +36,8 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
+#define BLK_MQ_CPU_WORK_BATCH	(8)
+
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..df775a203a4d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -672,8 +672,6 @@ enum {
 	BLK_MQ_S_INACTIVE	= 3,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
-
-	BLK_MQ_CPU_WORK_BATCH	= 8,
 };
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
 	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
-- 
2.31.1

