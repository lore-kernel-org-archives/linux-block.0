Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790054D8D1
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910963; cv=fail; b=BodSQgXvTcwSeP5L0rf7FqSDNK/Pp+UNERFjUv4cphHj0pKK8FWaeENaoFGNM31Afa5ry/U15frnlqZN11rkYz7vD/aF8AZ41pPDJL5f/s58n42HTX3QuzZZ8FyL/WDvhbTSOqI3TAkQYUwhw1ckwITQAShhxQwCG6UbdpZbxRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910963; c=relaxed/simple;
	bh=0xkGI5AT3s5H0d1wRaKsVOLyGzP7CNrfxJavkZNgw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DIbRMPXxvpF//SIoBiQufw6XhjEdkj2VXjSVMbutFjb/zCvsEIhRcf/m11eg5y80ycEr364NON0pO5KnlzArLoqRAMmzeQ6gFw5z0wSWtR1QtuwTWBaX4REwKIY2OzFkBjCRLYSqxLCzbpnIrdMQ3+qMWv8wYY+/ZDuOT+5t/iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QcE0Aiud; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NavuZINZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QcE0Aiud";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NavuZINZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NFNF026849;
	Wed, 3 Sep 2025 14:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=peKTlE7nVmrrt+an
	xLODKWHoCJIxypHeeAEuJTPYXKk=; b=QcE0AiudqIR3J2U0Dh5Nb6JrtgHWa6wJ
	mMnysrGSl/Qk38kHbWxCi3uwViXNNk/+T9XaGGiL0229BRJWwgcTdtXm18VSs+j6
	ZFHh2vSEx68g9AiOR5/58eQQ7x4gW95HBmHK40bo1gmJNxNFbKz2dOwXclAFFB+M
	8HG0rOxUingmao/qS9hcStrPuDNpzmexBiRsph1uNcIXobmCjp21t4Xvplaj7anm
	wKEqqsDC06BXCqd91VOyuiPv6cgR4hXjx8gw/Oim2IYBNSxIJJOYNSILPLKFdWuL
	hgWopZURa3RkbW0fzVGGnmq2t2qpe8sT70+yE+aKu/DQoYPK5jv5WQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4nxex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:49:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583DmQwv036330;
	Wed, 3 Sep 2025 14:49:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrae1u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 14:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voQSdR4aEuyysEAkue1RIStMHrhn4GW0VgYdjPaCmQhEzcMtJ8TqfMXePHTcFDUfOnwE+3VK7msfF4KC+JDg7WOjDdmz3bBRunPHj7wCPRNY6E6FcEITQSJD0VSrfFf9XvkNyCNNRM/dVU630ewPQ2/wCktKtPQBdnz4fgISbZ1XL3LRXLU5nDQ60UbkeUIpKjIFTNS7L/kx5xiy/YLAJH++kh5MMkmgRd9jpdCX92kwfGAgUAai4PBa4MVxgx37/AZpQa1rD59k/iB8taF9X2ApXY4i84hzn7p+/tZUm25zc9VtUx38pbt2BpQTSo1dMh2TJT2tp9OAeNuFd6F0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peKTlE7nVmrrt+anxLODKWHoCJIxypHeeAEuJTPYXKk=;
 b=N+Z16agJeVxJwXO8SEY2GbC0kCyGLvWQ6wB0WJfIqdCoGkvxvJ9RQ7/22zuK6zHGykzOSYjk7nsbZ/miJJiPROROnuPR0jIjTx0xj7X2gBvVeATuZiE0xPUAXZhMJrjbbH/ru2Xchn568ftiqZwZ1Phbt/43prBT3JqFFwZ0sQy3o1xZswDXJGdhuWEMsTF+dy0euDc1Mbi/TJjGMzf6+6pc7a7E6ve3lku7qToAqBsVMMIZZZIkS6W9B8+RSAPCD5aIxacifcw1M+fK3hnxi8gA/4tm8SvEfrwCE/tjlfo2yA1QrT8l1WhPjAWMZOYOzPdGZhgITC6C52biVOG27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peKTlE7nVmrrt+anxLODKWHoCJIxypHeeAEuJTPYXKk=;
 b=NavuZINZhDDw6owebqkcwXkj9KOTAH3J3SRYpPuncqDoyDyrGrWxUVVVYRe9iV4kpWYapNorxnIAYAgOyx9cIIC0fxKTt86i5af/D5K6UBX9vyfUBIYFzmdBRgB+xiDqiBK1oEnFyv6+me8BeCMkNP6gV++sLJ/W06ceeut8Mqk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:49:17 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:49:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests] common/xfs: fix run_xfs_io_xstat for max atomics
Date: Wed,  3 Sep 2025 14:49:08 +0000
Message-ID: <20250903144908.3303325-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0162.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::31) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: dec302b6-0c7f-4445-b227-08ddeaf90ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnC1pw4noWD2wp6hZu3MFn73HtfpRkdDvuMOcXmcXViHN53F5IjFIKQF0pik?=
 =?us-ascii?Q?SBgceaK3M7bBR8UwgwRFO5iAfL8ZYueXBG9LisdxfoeX7xk0ylzsAkmW8pkT?=
 =?us-ascii?Q?M6EdqB9j4on0DJd/gRjCZs4epzzX+Tx+9q8HzW4rndP8ZLBfzMs6OE8JXfZu?=
 =?us-ascii?Q?9nX/JXTwLoqv1/wdYd60uhW3Cf+YGLBpSbmk89Xi04DRwutoXTuf9Ksk8HHq?=
 =?us-ascii?Q?jakUDwCPioSAxBdm8RWGhlHrkczoGtkBVGlntqA61AixvYJM9F9RTnYxxnib?=
 =?us-ascii?Q?NeyLX7JTVbgN1PJTgcKW3ab+j6DZD+YX0mCpuk99aYVpt6TfvN6xbLQ8L81j?=
 =?us-ascii?Q?OP4KR4eqj/m4htg/etvfsVoiE41jvylz5my0zVsaQcV4t7AwLarQn61TjKPg?=
 =?us-ascii?Q?3bocJDMQz48ymL/57/CK8pAteZ+KZIjLYZlFwnpKQGP6ll1rDC53l95Er96H?=
 =?us-ascii?Q?o2O++BgDlSc5CK2+rLMnP+jIX0hunNCLz9PWMN7TyraxGqt0NX+8tAPP25bt?=
 =?us-ascii?Q?coxFM9EMeKtQkNdKIxDtakxYUGj4STLKawJX3517WzoUpFvZ07f97jNwhxFU?=
 =?us-ascii?Q?P2FXtOXpgVLhO7D1xNHYsqv7qB+Q5rkYOIc9kbu3ARvyaEcu7aV0tVPnCM3K?=
 =?us-ascii?Q?SIgLICV0IrJILR6OS4WwmTZ5YlKPB79kTC8divizpOsFlnYrcOPl49IuvI7h?=
 =?us-ascii?Q?NcHW9pQX8RcEvODlUjaShfm5etT9qFgDZGbjJFQFQseCRWENpJu+/2bWGVCP?=
 =?us-ascii?Q?nPpYJiTMTN5HzNqqo7ny/zKMu2aJrtsQryqo4YOJABRL63WN57wACvQYWV/W?=
 =?us-ascii?Q?YgebbTAWlYI1f5Nym//xnACbkmuVSzZpW9xwZe72vIxndVvdS5ffZcZFzB0D?=
 =?us-ascii?Q?SyLcr4si7XCnUrF48UqIKiyj2mXsSGTUYiwOGQFdf/ujEGzHoumptX+7E6dF?=
 =?us-ascii?Q?yJ76qB+pmxybgV0gnL9ANMZif0tfxLCArJn3WypiMU99UTPr8lBFnDr+TI9H?=
 =?us-ascii?Q?v41mpLB7P2ojcP+GeOFF3qA/2T1W5jzrqp6C1oMqXtkx01DPGJHQ7ISuien5?=
 =?us-ascii?Q?SGNPmn8XjcndzDxMOBDJrATY8MqLs3O3FVlTZDvXM25+tpXgo0hcEQY5FZpu?=
 =?us-ascii?Q?+FfjSO5ert2IxrrTdUT5sIuJKPQDutg72cA1GYnlsP/cA65avSoL7lCK5TiE?=
 =?us-ascii?Q?/fOV8Oqot/FPcJByr+pvhv6TtqPC76cAklGCDwzdIfRo449OZs+wE6bH/Qd/?=
 =?us-ascii?Q?pMBj5dqz7rbPQaF0Pv8tu5qNcR/xXuzfO5/DXX5CuJjsFbVSr8PAsTbjsXJe?=
 =?us-ascii?Q?eRm98OKSErPERH8TgRE1GDo5UmTl8p/hEisE3m9rAHxx9/qIYfPAp10LKHSi?=
 =?us-ascii?Q?a+rNIis9ipDm/I8wowr//q7hu8d/45/o2nFMbZVkd7ZrT6bjx5MY9/loHv4b?=
 =?us-ascii?Q?fcBfcnyqtTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ms3iSrlSXbI4SP/sT65hPGKieo8MHF/yueT1uD7Ygf/VJy6HcZ15UrOKfHJ7?=
 =?us-ascii?Q?xLaAM+Q1Z7FdxSzXuXrtSSImCS46ZvCBrryR9JD2gV42Lok5n3A8aujaNcq8?=
 =?us-ascii?Q?MkVY5KjpAOyMKbU9JGgj+w1c7eGcjBUCZ9Yqe+S64OZLFxmrfsNN3TJD9irr?=
 =?us-ascii?Q?5bgRljJGtKeU/D3SjFEihfge5BX81TfVEvn/1yAeNCA/Y+xv8/SwQnBYl7Yy?=
 =?us-ascii?Q?I6BXLyICUi9togeq5VnC6Nkb/w8gTc00fatE4Fc/cgb8dXZLIb4R6VZUqb5l?=
 =?us-ascii?Q?+GoxrFF9rOEKAGV4NimDqzv+Y106CtFrsL6eTiNL6sFqAHRwRDuM/aSjS4Kh?=
 =?us-ascii?Q?cHYShjJHpv3eqXy3nT8B+wy4Fx4130+AU++lDKFMFVXWgvwypLpa4A2Dqisp?=
 =?us-ascii?Q?MQwiKrVzB8mVtv316y8gNEeUh50btQMQDzlXESdWPzbxGSvMtd/T4BxxmjAP?=
 =?us-ascii?Q?DPSoroK7wGmczOJEYjz6FgtIIV0lVuSHAtCKYafBpEZtKdo1y5DQ+pnmKQ0q?=
 =?us-ascii?Q?GSFXUupNUyEShyadLfxUHeOM40Nk8nnwzOQfdpfeItD4LQd/iPKN9jGouqsY?=
 =?us-ascii?Q?b/MGNs09WoDzX8a5qWC4sjw91upTtf3empEQz/IlOETbRkEYUls/keuiGsmQ?=
 =?us-ascii?Q?k5tqXhH0AtU45ps7lq3dzHMvNl5WuMzX+uIWo/2E91cvqZokL1E3O7LHTyKo?=
 =?us-ascii?Q?mr0zyIFmkylxzs7U7rmjBL2FsbQK4LEiZhIg04XGLl7GepSh5By6tbeQylWL?=
 =?us-ascii?Q?z8AWjFWEVV+ZlSFOaTZ8s6Bi3lOZGdzpXeEElbYCZ9V8o2I0XWCEOYbBbehq?=
 =?us-ascii?Q?1AwovxbYAUVqWfyNJKvpbTWukvVS4xQhUEPZ3Ja7Aay4ENDgWE6dpbniudMG?=
 =?us-ascii?Q?WNoC9H25Qmkj8TnUC5zhBMdBopw9tFF0fsP0vfbdq+yqQ7gdzPUSP35SqrZ8?=
 =?us-ascii?Q?kutcylMoRvBX0CCrki1xUqqa+WcsVfximlYMTt/VLGLeeP+QQOzzhyd07mIj?=
 =?us-ascii?Q?8tnW4lBG8Z7ph+iKJ0APCetTa8gWkORXnrHrWtIRetcdT/s8BjZ3ZxWvM4NQ?=
 =?us-ascii?Q?JM8woxEybZxj3Llm5MuQzprS5orkKWccOxhTC9UpyFCPgizAzaSYdn3R2uPl?=
 =?us-ascii?Q?Fh3nDH5t7NFDbn2FoP2eQBBn+MhVU4SnIFhtdtDNtOtOc8u/QAKeC5hYyZLe?=
 =?us-ascii?Q?qneRmu8/YYY+lvtNK1Eqv7YAdnp7P+Ebg2svL5nqx9pxVQWovCrlnbuiuqQG?=
 =?us-ascii?Q?4knW1V8iox6dvOjX8CmJdfFn+byJLC3tmK912Y0Vs0OwdZde+a0KqAg7Bxuz?=
 =?us-ascii?Q?xFJ98mhxoWSohGNnyHZSVD4r1PJk40dGcAJ+y2Wefu75yybFP/M5CGIYwhF6?=
 =?us-ascii?Q?8sDWrkXScXmA/NGPSXnjxCj8tjdHYp/6lDTz0E62m2aeB+vzWLWTVqGrQeJC?=
 =?us-ascii?Q?IuLVok5IWId5iS8VIzjU21T0GKhJefZbw+1JvpEuV8rxOt7VcnGylgqUYKKd?=
 =?us-ascii?Q?/bZmEfS0bVVrirx/WrzbsEUhBF+8pLABmBeoFXVctT7gHye/er5CL85aFXjp?=
 =?us-ascii?Q?gHudV8nVD7lIwV3kz39KU85gPx5OnMi2AZaKUfCKZiqRzvb3fxHVWKRA8BCF?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlyFRoNrGJ+f75lpDYkC8EZEmrv16l4tJ4K0MrafxzIBT5lQAe8l+GFqmWrSngw/u1V/i4fLOax9PkcsX+YuwBMbBT0ptWpfGuLDWTKmXy8ohNGlMXxzPxYxjHsoDN6JDQrFA+pGJS+K6GKCJoxGENuMJFQhqMSvHE58xvl8rPh4bX4xBnm9Mh3z4GNSn4SxaGpYP8IHFjfEgxQycbh8Yov6sggemsAPsbFlyqUQSz6/ktMdzjAoKWb2Qw//I594VchxE9Yx/aTe0PSufnLQBZm2gjql9zsGPbaMdtlI3AJORmCjPJsrB+LCbYW6K2qDlPkdCoaoHiGSHi9vKFWUk42WDIuCniq7SBlEuNdeu1tFZSUTQ/XHnvZpCkKebm4wgJLIejYonEtW5EPUMu9Qz+MLQve73zsRP+iEaDtYG5ZJnwjG3KciMidd7jsOX8ysEMdo9yluOeuyOemDsvQXdT99ng8HN+sdV+gc2Ts+MlSKkKf2uo/hWMUWK4rQRv0c8WBSUecetvMbG6xEgxgvjsna2VGClLxpyQaCsEBvHHw1E4FPtp8YLWOdPDIl0dgK0kDJUpRU8XHQIbr44tKwCokG0j/8lTjpXA1wlLH9CzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec302b6-0c7f-4445-b227-08ddeaf90ed5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:49:17.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSRIEdyzvLnebCp3Ucmhzg1c5jVBTyVrvyNlb6TNIggz0mUQ7IWap+Hy1myf40F7XbDxexfvrR9u0KwkLh2MBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030149
X-Proofpoint-ORIG-GUID: YFd0U2gYfkVzuyApXGZ7vo9bnHCJ6DBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX9lfXyHwUSerA
 mWxzyiEF4QfNFxaRAbPi7Ax8YZB8ELrZlGUbBHmboOa6an95+EWPQa1LlJ42BhVCTLJKQ8do3fo
 sNHZD8aBgy/qfWslHpWkY+yIbmdaIYLcgV8VWSyzuZ54qzdK2woje1qufsKJyGSTnZUaGm9TYma
 S4TaK0YRyy+P0sOmXLOCBc5oQYWvlOlbE4fIOBXTOVeTbOdVJI8jfWYh7oLvmiUA16taiNpds/2
 LHJXskBD06/wUKv7EUuIBU62tLvtzT+D9zfahpJv5e9WdvMJUawko10PiHaAqXD44gKM/jOUU24
 y4wtuCn7DYAgQioGZHahbQ2nqlW2m7M7Ei8x7b+vz2mH7Glr1r7EJIbIeyuglaKcCBRJDdnQ6a0
 /tTq5sU1
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b85570 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=X5yzZGR2Iqc5n20Tc78A:9
X-Proofpoint-GUID: YFd0U2gYfkVzuyApXGZ7vo9bnHCJ6DBS

When trying to find the value for max atomic write size, a user of
run_xfs_io_xstat calls something like the following:

statx_atomic_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")

And run_xfs_io_xstat will grep for "stat.atomic_write_unit_max" in the raw
statx output. However, since new field "stat.atomic_write_unit_max_opt" was
added for statx, the grep returns 2x values (which is wrong).

Fix by changing the grep to cover the full field name.

This fixes md/002, nvme/059, and scsi/009.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/common/xfs b/common/xfs
index 79e79e7..9c02414 100644
--- a/common/xfs
+++ b/common/xfs
@@ -134,6 +134,6 @@ run_xfs_io_xstat() {
 	local statx_output
 
 	statx_output=$(xfs_io -c "statx -r -m 0x00010000" "$dev" | \
-		grep "$field" | awk '{ print $3 }')
+		grep "$field =" | awk '{ print $3 }')
 	echo "$statx_output"
 }
-- 
2.43.5

