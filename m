Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB92FC866
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932527; cv=fail; b=c2KMGG1/34Oqt2GP0GE+T4eiPc/DdLX8U3u+zjaFp8CGl3rx017BseAinRKVXCq+NFBfEegDlrTfHjQyFoh75Und4j085ZF2ZydtOCuBjv4M09Pv+K5lVM5FmGZ/4+qU2GAyry1aJjnjs5gkM0zZWkE8PZCyZEAf+XW/l6p4QlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932527; c=relaxed/simple;
	bh=x4AlbjWIYySpLzuMUU3xoflJeG39drMq16ZnGsEwmak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JjhY1/V9/NRMJdw2bDZ+4slh/cH1d/yxfCNwXHMQkBee3mMrIQFb5FvykT+3RtW6duZaY80syC7i8xd1KlHjE4+R+OF1xr8FZu/coOD83VwUr9541A/5/977dKq/nKHLFwYQBy9RqJnWCAh1mVyggHpV/nqphUu/uwU1zRfpbDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i6SpHi/j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zMSo4aGG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i6SpHi/j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zMSo4aGG"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6gMPE029828;
	Mon, 15 Sep 2025 10:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FuYEKpF8gXphSSKj91GsvkwSQ2X2YJ3SUv+NOEn2YnY=; b=
	i6SpHi/jf3yTFxdYMPNeLIjNLn+fsKrcQiY0BMxetfHnlwKc5O1HU4BnYXusTrjF
	vY00g1jrhhr/6nlLaJQtitd9Bbee7vQxKorhHaXYHLlrEORAlmjbuBPA3c1gvpoV
	HHXk3ia4AYcxAq0xxUemKgpuBQtJcjxmMVlNZuVrRa+5Zg0d3ka+LDBuQNlxYRvy
	vbB39Y81jetVGNuY3urR146fgcBo+YsipZZBXxBishnrzeGhXEU0V+Bdc9MU7G0t
	KS1rXojEHCr7XAT0HFmpxeeKrvPVPVPK2o1eu/0+7arQ3jnVLLQTQUT6XVCx2LXV
	nj+qVanz8Yp1nMZUtvckxw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbj29m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FATFvv015287;
	Mon, 15 Sep 2025 10:35:21 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2aun6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izq187ea1jKA8fMhk1qa4hDBJcFKtEDiN8CNI5f8rGVn5FXDAS8iJYpHMELPvKjPpyJeF2FZkoFlFiQwJXPcvIvpx48aBQBM1tic4/juqsTYGofW06B1rWNFfgcjpTVzu4fcpat6GXkXeywP579Dg6PUBIUQWHf65Gj05QQdK/Jnm7VAmHw5LCjCsjv5woXamG51SjkLDfLfN2dfVB58xMbSrNBBoO+OCqKFdu1bABTa1cMohAjom2azD14yy5PE/HQKEx+opjKHQo/8YFdK+sl8/m2tB92OLSFTAPpv4dpUiIwkdumTQcUiUA9Ffp5Sx6Q5eUyAplIBL8qrGofAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuYEKpF8gXphSSKj91GsvkwSQ2X2YJ3SUv+NOEn2YnY=;
 b=oloa6vbjKGwELmYYHxLXkeSDDD/3scK0K9RNirADVj9z/35eBW9wjnM35wR1n9PPAEEfeQcjnMRJAGVMcwZIczCzuDndFWKcO5BnXSniaGfsEIIrUkSdXUzdZZqpmGiekgGPJMRq7P41NserP16RvomKW5tIYtc9Ifooyt4DjG38xR5MZfpGOKdsoRDnzj2uGrb/YoWQBljPfpqWC+m3jPiIhJ1E8lhVcqLUaxxMTlf3OiyJ5Cf/BTqeu8B1Hrl8D31NEquvTuWAOxuL12c5irFDn+W8NUnMTgo6a71Nd+P2E7ZXwrvyod35tycfX3m174gwYpKQAnDbi3fYu7f/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuYEKpF8gXphSSKj91GsvkwSQ2X2YJ3SUv+NOEn2YnY=;
 b=zMSo4aGGWCXrq9c/eVfxDrQE5vcOjALI+3i8rjkkyfTxUhKe8dx0pKBasS77GBt3pV27MzDUGHlwxLaQSQZbACt+suSUuxBRzI2vz/nH4LeacL8pPxyHX2FkeWomaVgmtx4jJeX3K0UYKWYWVCyodiWzA9T0i+6HoebvCJvynto=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:35:17 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:35:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/3] block: relax atomic write boundary vs chunk size check
Date: Mon, 15 Sep 2025 10:35:00 +0000
Message-ID: <20250915103500.3335748-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com>
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:510:23c::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e7c379-f169-4671-b58d-08ddf4439027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9BrrToGjGJJ60lCMNxM7MLxtPGHedPfqtUQMN/4WKHRh+PEqsrhQAmE4cDU?=
 =?us-ascii?Q?GN0DaTdbc6OdWxXpyCAU97l6kXoELR2KPDEKLM7mtOpNPuvu9ysG898iU1rx?=
 =?us-ascii?Q?0IltTQT2AVMlc8nBZgFp3uXLY+uMnWBc8FKCF5mUWYpVast65GPw/QJ1kljt?=
 =?us-ascii?Q?W2SHIj1L9hYMsXhoI63jW6gbEpyFJalmIlXNOkxjzfXn/d5+4c8nwu75vTkb?=
 =?us-ascii?Q?j5lZDbRQvIJwXLWxth3GtZ5If8uuRLpoZEGkHXWbK9jiwnsSQSYDBOa1k6kT?=
 =?us-ascii?Q?+mHr0pKnAok9ovMNkT0k2Masmsdgysk18EX3HhN7+/mSGipNDXBGkQZ9O0Sm?=
 =?us-ascii?Q?umwPUUkx9b9RIL/scWzB+K9hfPf8hDhMOnpJ0D6sR4mU5nU3O6AKXbcjjXvx?=
 =?us-ascii?Q?90+fX8oMtdA0qxWEvGgM7c9Gnn5sldTMM+0X9GK11AufkgWt9MTV4DwQ8qVf?=
 =?us-ascii?Q?GD+36Azyue+Z/JM38DP5EssNV+J0Uv1q+NqdaAqV3BQ0dPd7mTA7vS0AKPGq?=
 =?us-ascii?Q?9UC+TpViQXB0/1GQpFjOK2J2Zbc37vvZiZoHCJ9JML6jO4QARtwQbSD1W5sr?=
 =?us-ascii?Q?fQCSuUay/gCLmSoMlVWkbd+89fzOPqy6swTNBIp10PysGit48dK/gYE2UmsH?=
 =?us-ascii?Q?fJY9dsA5To8VEdKNeF0snnOcsiFkHoySuvG3O2LHnq+gMZP1jNE0hOH07m8U?=
 =?us-ascii?Q?t12h02E8NEoHFuXlLsCbB+XAALwWFip5qISqmIlv/WLN9C9os3/5WRf8P30z?=
 =?us-ascii?Q?644hcYMaGXBTH1wDVk1EeUlwox2phi6NA56n3aLVezgAVbtT1deLJT1le2lz?=
 =?us-ascii?Q?LQqI9FyZbwKU2UQpkQRHo7SJM2Rwu4yAqiXAirG0UJE77RW0SwK9fS0I4UKf?=
 =?us-ascii?Q?Xzx6FDIoxybYxKu0DUBHMwXbTUtjNQudqy14S00UNxAaHEPEj4Nfrz3BTjjY?=
 =?us-ascii?Q?akCN8ktyIiAscDsZjcyKLwwJLCiM1QsNNdmtW2HbNI2KfGAKhOZ3Nu/smC6l?=
 =?us-ascii?Q?4sb8TkoboeFmAefE0wkRUMQYonj26kYJ/O1PO+BVj6aBh4i6uLBUwdh+MCsi?=
 =?us-ascii?Q?vzBPcDEIb0EVGACcxfNtcqqtf9Ym+cJ05mGoE/eWMUp73k3RmqBgaIvJs9eL?=
 =?us-ascii?Q?eAjYTn1Ojll8a3ehpk0HRg2BYMYV29CqMZ7u46joCFq7aSkqd4JwgaL9HMdV?=
 =?us-ascii?Q?3B3atzxfZkRGw7r6DcrkxyrAj9RkkHYOh3pmuxSH2Swd/yqvJRtruQL059lb?=
 =?us-ascii?Q?Q8DbP74WKRKF0HgtRbV0X39T6iiFHFttRV5B7trdRHQA1/nSllo/5YduLgjH?=
 =?us-ascii?Q?6rGjHFMMVXVn/oG3GRc9tCMd2o/lc2vo8S27jf+Fu8H6vTOpx9zg83srVK66?=
 =?us-ascii?Q?CJvnhPHc1JauJIdDCj3FybtsZmjkPzh+hlvBE6loCYxvBeWD0IWAk7X6LlIz?=
 =?us-ascii?Q?O0rbFxm8jxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5yzXu/Cuu85N1xRqvnUiG3srTQn37b5g4fPftYAz4JII0QTjqNcRey3MTjD?=
 =?us-ascii?Q?vQueMAYH60TIJYKWsj/BEJtQ9qSX74qgPFc38jC81qCIvwqJgrX+7uvenu+1?=
 =?us-ascii?Q?NTiHLkTUbRx0tKUS7eMXAKzkG1xwLlwtug/qRRi/n0IIxAHEs0Y5KSLkko8x?=
 =?us-ascii?Q?FeXTyD2IPP6oBhu9RQElqhgyxVrw85PakKFkgvSiXrWhgjEMMKMsHObuIFq7?=
 =?us-ascii?Q?Yp2iW5/w2uMVbZNYgYgntyGrm9khnyUCO9rdy1bUXyFGpR+CuIm3aZDixkVh?=
 =?us-ascii?Q?Otgv/TNsWznjtSmpWSC1nClkEf3Iaxbdf35Aclo+lDrRb8zVJOz5zUXTGtQD?=
 =?us-ascii?Q?FxZr+31JLcLZxKj7IwK5l+X4kSehduLIGcOemfLcKi1YM+yJW6Uf6ez3GrXt?=
 =?us-ascii?Q?OTz2kWxiNNXs3oPVFJr6xPq/z1vR5A/LUHaz7rjL5on9I6S+Iz9fbFUZXYXp?=
 =?us-ascii?Q?abru+c7bQLXNmKA576sER6hqG5HbZGxGD4rAee0PSBguB9v3WRzLFmEeuB8z?=
 =?us-ascii?Q?JPsN2zk8tFgfZhA1XdY8rXlSw0KBpUIot6zkyYc274j0BMuNo9/JeZQ/Zerh?=
 =?us-ascii?Q?odKfKUI3y92TI+7WJUDmDjeFJyPqg3IScIXofYbFurf1JfWsOPoT0JCGhdDi?=
 =?us-ascii?Q?8+00BcFpRSUpQ2jmlaSJOnfwwnvfBewZqi1CqS0tB58dGZQh6Cv0VzC9gpJz?=
 =?us-ascii?Q?W++T5qis61pZS7Egz8ZfVS124Odfw+pzmjSj3VRXJr/gwXlSPkJfUQw7ILCE?=
 =?us-ascii?Q?tTcWeG6vgg2qnXjaoeDFj1f+eNcLaPcYGNGP/YW4Y3eCbNCQoefxtr2lw9tM?=
 =?us-ascii?Q?70BLePPRj7zOLZEgrTaMvN7sHUAZqpOoKM0MHiwTklPNptYfyYKX0k27g4AZ?=
 =?us-ascii?Q?3ZLyuTfwa5PUhOsUBKR+f0wiUfcXGRB69BovdpDoKybGjghHSTAkqpqexLfq?=
 =?us-ascii?Q?+2ZxaZmaDEv/y0aPcWud498eH6RlSqiSMI3/cNJYevGGG57a6VVa+tiPJxvC?=
 =?us-ascii?Q?NWI4yJ9I/JE9G3JHhr1/B6bDEQXiykntkuQB1wZFzc1mMHSo9CpoWqLZ8Kse?=
 =?us-ascii?Q?UgAfXn3ZypFGaC3Gough967GyekcNWzgjp2J7g6hrLaeEJmg8VwNikMtsZkR?=
 =?us-ascii?Q?p+pXJQMLK2K2ygJmuJ5szuqv+MAt4RBE8Z8HoSnU8YXnuJgq7QJds23HNv9j?=
 =?us-ascii?Q?8rj2LRKu1XpaXKPfEfvgixyBj3N0cUP45ewbuUmD1BxYpRE16kqa3OwBHTDj?=
 =?us-ascii?Q?u2SbkZWcqP0IAe3JrxyUQL9kEp0iIPsYQc7QVM4slBb9uHdl/8q+xqw9mpUT?=
 =?us-ascii?Q?bdELpMHqcx4p5ZivCZa3CG8cPcOAu+aB2i+AweUp5gzRLRUmGejAX7B9ILcP?=
 =?us-ascii?Q?eXflQk3SVenq+84vYYjB0XinOvGBJBrca2Ixb+l1xO7oMYgmq/PFOOh89ICA?=
 =?us-ascii?Q?ZAcFbLIuURTqiUuzUi5oajbnfc1PtVs5UIIC9TFng+3iqr1ZImtzTF26EL5V?=
 =?us-ascii?Q?yebAxdJuT5lH0e2SQ7/lJYikkZ6QQ/C2pfUk783iabga08GizBc5ZPKkVN3a?=
 =?us-ascii?Q?FY+uNr9vBB+jGLuNUekEAyRI7TZwMRKpOXIJb9QAit3gkbmlMHaT0BygTsJc?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1A58caNmhA1EkduShI2IqAdApLl2NvoSZ5b9qQkXKbthVt55umYUpbLK7XttVhAEU1A+aX2B8AqN28tlmUZeZQB3xu9bu6YpwHwvMROaP2zH1PbwIl19wLWYrFnp7tAYlwsV/A2t7MG/RI2NXTn3MnMcqY885newn1KafryIMvXkCpmbjo6RKc08LXdNZ+tRcw4x0SKXBiezkgjhVShhFYW9cWrMKoX0cS1r6ewbvqRojR6SlB8ZA8F7DJ6zjcqV3qlhCF4mfhuP176sj3MRo0IVHluw+AUV82jrsu0OEgyrHqi5f7sF2yY6jzTDEbaPewHieMm5lwlykBIp4oP4TVNCFP/R3iOJ58V1HN2/l182hcZkVLGRdEqTjj3JwkBJN/tVMHa4CVBMG+dTzHYP1G16DkaS+gb3qbThPCv01tzDG5/0FPGZCoMFQhEYLpCPsZNW1s2SPNsel4s+6+wMCQ+Hw9isQRc36rktWhJRI2fYJu2xG5OO4JpqzB2WeD/CXuboFT/4ZrPbt0oze8ZSkb0JyNusnV4jIOXAAGwBKo8p6jjKG+UT+i1tR2+SGjJuwdkdsDD19IbBNdTu/Oeju2dFzaCsIl+398XfPRh0XfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e7c379-f169-4671-b58d-08ddf4439027
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:35:17.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR+lqsmgZJGyupgQaH37XNDt1jVwOzdO5wrh06jGCyMIeFyfrE3QH3VxszSDsSs6CCz0fpcMiPzOLcv7CJQdeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150099
X-Proofpoint-GUID: 0G8LLex6TKGyH24He4QccT0BDJVaIT02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfXx4VXwVqCGgzv
 jYOQFnrYL+uNdauQKab/NhxCtPXcsDHq8cvCcM30wEc46o1c58coReAT9NlfkdPmu25GsuOWjIx
 VOd6ZlrNW+W0lcGq9Mkik2cJsZ7KKiHF2OnlchYZpKAy1nuRnDd72X6IOkLwJh9a64WNLrr36Vl
 RTn+CHwkDmHSPF1qc7F4d56Kpb9J+4L/TeoJ0aoJMllJ3NimIqVdxe1ILciNv1T3zDrfHAgtVh4
 RUw8yKXXsMH5p11Il0samnpII5ybG7TCzBlwtTJaqmvGYafgq8lXU+4iGX17EJca3bCdtLPEdSC
 cNW6Qh9byAOYnhyUaKtqUN2nj3pegsHVQhYvd9LjpnUKeOQnXRqFGsLZpevi70mZjvRjtf1DfRn
 XJIW8CmWXu142BVyITth0ZBUXkOoyQ==
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c7ebea b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YXevNtRIDQZ2ypiCuCIA:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: 0G8LLex6TKGyH24He4QccT0BDJVaIT02

blk_validate_atomic_write_limits() ensures that any boundary fits into
and is aligned to any chunk size.

However, it should also be possible to fit the chunk size into any
boundary. That check is already made in
blk_stack_atomic_writes_boundary_head().

Relax the check in blk_validate_atomic_write_limits() by reusing (and
renaming) blk_stack_atomic_writes_boundary_head().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 66 +++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8fa52914e16b0..54cffaae4df49 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -224,6 +224,27 @@ static void blk_atomic_writes_update_limits(struct queue_limits *lim)
 		lim->atomic_write_hw_boundary >> SECTOR_SHIFT;
 }
 
+/*
+ * Test whether any boundary is aligned with any chunk size. Stacked
+ * devices store any stripe size in t->chunk_sectors.
+ */
+static bool blk_valid_atomic_writes_boundary(unsigned int chunk_sectors,
+					unsigned int boundary_sectors)
+{
+	if (!chunk_sectors || !boundary_sectors)
+		return true;
+
+	if (boundary_sectors > chunk_sectors &&
+	    boundary_sectors % chunk_sectors)
+		return false;
+
+	if (chunk_sectors > boundary_sectors &&
+	    chunk_sectors % boundary_sectors)
+		return false;
+
+	return true;
+}
+
 static void blk_validate_atomic_write_limits(struct queue_limits *lim)
 {
 	unsigned int boundary_sectors;
@@ -264,20 +285,9 @@ static void blk_validate_atomic_write_limits(struct queue_limits *lim)
 		if (WARN_ON_ONCE(lim->atomic_write_hw_max >
 				 lim->atomic_write_hw_boundary))
 			goto unsupported;
-		/*
-		 * A feature of boundary support is that it disallows bios to
-		 * be merged which would result in a merged request which
-		 * crosses either a chunk sector or atomic write HW boundary,
-		 * even though chunk sectors may be just set for performance.
-		 * For simplicity, disallow atomic writes for a chunk sector
-		 * which is non-zero and smaller than atomic write HW boundary.
-		 * Furthermore, chunk sectors must be a multiple of atomic
-		 * write HW boundary. Otherwise boundary support becomes
-		 * complicated.
-		 * Devices which do not conform to these rules can be dealt
-		 * with if and when they show up.
-		 */
-		if (WARN_ON_ONCE(lim->chunk_sectors % boundary_sectors))
+
+		if (WARN_ON_ONCE(!blk_valid_atomic_writes_boundary(
+			lim->chunk_sectors, boundary_sectors)))
 			goto unsupported;
 
 		/*
@@ -644,31 +654,6 @@ static bool blk_stack_atomic_writes_tail(struct queue_limits *t,
 	return true;
 }
 
-/* Check for valid boundary of first bottom device */
-static bool blk_stack_atomic_writes_boundary_head(struct queue_limits *t,
-				struct queue_limits *b)
-{
-	unsigned int boundary_sectors;
-
-	if (!b->atomic_write_hw_boundary || !t->chunk_sectors)
-		return true;
-
-	boundary_sectors = b->atomic_write_hw_boundary >> SECTOR_SHIFT;
-
-	/*
-	 * Ensure atomic write boundary is aligned with chunk sectors. Stacked
-	 * devices store any stripe size in t->chunk_sectors.
-	 */
-	if (boundary_sectors > t->chunk_sectors &&
-	    boundary_sectors % t->chunk_sectors)
-		return false;
-	if (t->chunk_sectors > boundary_sectors &&
-	    t->chunk_sectors % boundary_sectors)
-		return false;
-
-	return true;
-}
-
 static void blk_stack_atomic_writes_chunk_sectors(struct queue_limits *t)
 {
 	unsigned int chunk_bytes;
@@ -706,7 +691,8 @@ static void blk_stack_atomic_writes_chunk_sectors(struct queue_limits *t)
 static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 				struct queue_limits *b)
 {
-	if (!blk_stack_atomic_writes_boundary_head(t, b))
+	if (!blk_valid_atomic_writes_boundary(t->chunk_sectors,
+			b->atomic_write_hw_boundary >> SECTOR_SHIFT))
 		return false;
 
 	t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
-- 
2.43.5

