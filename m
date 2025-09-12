Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A16289358
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671096; cv=fail; b=tFp/pZbgMVxNrCuqQ/ShAbSbxQ4dvXb4CdFxYjzXVMEpudC5anKpa9IdTu5RMJH66VyPcx88xMLOPLFnwDCaJQJpRJ6PwzeVNz9LNMOcH8nAJD7AfbGxQcDaABUIi7iogAeoZQNKRjSpQlCnJZ+mcX79k+d5D3V/7cbNDRgmHjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671096; c=relaxed/simple;
	bh=hhApVg08GabDM+xqnKhKNX7ppHfPOl9Icsx26P4Pf98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Omxgn5Itr+tWvxe65EPrJ/NZIGn06UhSWbWO7caeWvh6ttnVmQqPPezyLuvwqWBuAsy00Sy4nFl2zKzKSDIbFrS3f1/CApvgSVyPrz/aLX4EzIX/mY9rDR+yJsGG6/6uRSe5OYRLbwGtqf2P5UQHEcwE4EMDHsqqsyOPDeQJjrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lSPI3VS6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MuEkGJtU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSPI3VS6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MuEkGJtU"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tl1v017203;
	Fri, 12 Sep 2025 09:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GEqf6nSIUbl8z9THgI1YxumYCy4bjZq4RGYWEe1ZXR0=; b=
	lSPI3VS6bxHAkO2pOaVT7Z9AXElYILIUpjsBWeDf5HJdN6oWQsdjoZmUf/Ggd31D
	Pm4gdDRZEUI81Ted2BfuzSypJp//TKn6Sn3gSdTy3uD8dKMbWis6hihnkIBNtnJF
	n5grZ0ply1dYPISOnILSFnNlbxpIR8u0+PEAWkVdo425uBGSpkeevb+jL2tosjw/
	86kFnKJASQmLyhDmm1stSxcKEuMY0OOZD33FX1Cff3DB25cR4RjqnFMK8UCUI/GZ
	p7aGxYwFM0r4QTyv61rNdRNtsrqito1NEyjok7nMMS9I6f2gFCPJfBomQbki9Fdi
	wPpE4hoOcsru8B2b6JXBEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226syxku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9uwj0002944;
	Fri, 12 Sep 2025 09:58:12 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdm6hm5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLWnvjc/wbvVyMvRjkn2ZMO2zWWzUa/R9OhpMpo8Z7uH5wozYuiTEnwfIHT62rM06Cjo3gJTaMLggYPBbELS0NJ4rX2BWho/RS0WynEf9L9M4YlBErZnconCrkmnZpHYhxDm4Nj9cY40fk7mVDElBnzNn5lHVGpf62sRNQwQ3WYd0wPnwhsNpnrqVsXN3z08s46REHvb8NGJI3n4nzxakQjMsFWzi+UW/ihvM9Y+CL6UI9eUM6i+bxO+tbQ68nUJloub7FH9blHpWagkAhzzciTgCkQleMIe2LmBPRpDdOEVDmMfNgq8ObEptv6j0LxB/efHIPC/i0sjuIbkKzrNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEqf6nSIUbl8z9THgI1YxumYCy4bjZq4RGYWEe1ZXR0=;
 b=ssmxteaUVhDELIlxEVwyK1ytr8l7oBP0xqUvRg6+IMEq5iICbUXCDS6hw0Y5BH7+Z7Sk365jvH8JClELrRS2eNrJbIjCpJ7ChNR9eGOagKjIcCJvU2Bmo/R5nu42Tsx0bRyn+BPIih8RPsR5M0qb0TZO1SJI+INQAZUXJM3W1uPE+1HDOTMGb1J8cjgIp64tjzKPgxmu5ezSVLuSRyb+5DjFvFKPt0fCbYoDuTKb9WNv/RWhFwqmeNHTwgLkLiSBeW/7gT7eG6Fsudn7cI7PVkMWgKOj3oE1ncdMM/ffhcxlKUqcujqlysTWDErMcCyB5dIt2wL8yJF5+zDbuC0C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEqf6nSIUbl8z9THgI1YxumYCy4bjZq4RGYWEe1ZXR0=;
 b=MuEkGJtUeU/4KZ0POH8JiKT2CGKMuN85RZ8okD4V3qRV4c4nc0heSDuanLXQDzhPwL1QBu5MUjRAjYIZA/K78wEIADwcV86/Uie+R6eVc5/nwS6ePYZY3PtyJThLBfT407bEMKJfFrf9yuQvan5WsVGZ7oL3M3Kjuv8OQUfMl04=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:53 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 6/7] md/rc: test atomic writes for dm-stripe
Date: Fri, 12 Sep 2025 09:57:28 +0000
Message-ID: <20250912095729.2281934-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0159.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aad0bbd-2d33-4ae7-aca2-08ddf1e2d753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rH7nst8QkUXn2yN24NH5cxA2oN7ty9d5+gzmEj0v6467+/69iwSf6XIEHoML?=
 =?us-ascii?Q?pDPhYetxUcC+odx+rcpXi9NrNFPWyEt4XPC7Xp+llQN8RZupLrDvlQGZ3UUq?=
 =?us-ascii?Q?ic3LCH1n3nhgeybIY3lv7jefM4KRSlLGJuGNsJzTqZefcm5iFZr7EPieJsxJ?=
 =?us-ascii?Q?fSbDiKumc5CGbxKBJYulLvHIld7kg66iEokWtaNJgTUgELickC/WPkE9Obo5?=
 =?us-ascii?Q?AwtOGuy9zFdu5TGBFBsk+6rkCrgBu4NkumPxN6hfTVr1KF2YjN/qlk6vOtpq?=
 =?us-ascii?Q?pDUgZR+V0+yBeB7t952CwQiRq6iE6ZGmseSE+4GgPWOEQPFJk4nRgEc5xxXx?=
 =?us-ascii?Q?HwZRTsdpUjHkImzx0yiRd8abzoOFyx5iRNAZq32R6LWEksd7x2zzOfQUI4IY?=
 =?us-ascii?Q?Lv8vWa38vOuD+fvysMABxqGmTjk6/5GFuDpapwSPHiSV2N+sMKCCVY2YcoSu?=
 =?us-ascii?Q?ryZkaMh1edo2W62+oMRYyIVc8eClCGsbk6DnUG0cFK+0d0gVVtYWS6IFtnKj?=
 =?us-ascii?Q?W2jmWGHQ1km34l1BW7z337qK3M34EA42oDAFbrD+rTJ0AQqZTuErDUwfR0vR?=
 =?us-ascii?Q?ztNkwqj5Srh0QXXPp+16xxq34n4VoCKHRnjjxL6XRpyjAJuzPvyDLayCcRFz?=
 =?us-ascii?Q?66ds3rvid+BgMQKdoGbrqtR6aTVfNosXz9lIX8oh9ih5OBTWlSEHtvPWtYGI?=
 =?us-ascii?Q?xWDqrZqq650v6YKth/9tiFafUTZHBEwvyQkU9KvXaAbnbdDafuGPQthrfnWB?=
 =?us-ascii?Q?7xGLgx85i7k0i5AdER60U6ROVS9dOKPmOMdLTKupw5AJ7uRCV15FKiD3VI84?=
 =?us-ascii?Q?aSGBRJicaM6CbYFK2KALJX5fWKreaUAdsTxPJIqubjLn1cNtxBkpKcuDGkOI?=
 =?us-ascii?Q?O2aYOrdgNTIuFjzylPgYKRkNev2OUEnRFa5I/nxmGwnzMJnpqwmIBZVxEoq1?=
 =?us-ascii?Q?Z863XUA6PxpaFHiWxRi7mVrOdswB99wH2UjZYzFEJ4HFMjI8HoRSQq3l62RR?=
 =?us-ascii?Q?VfWleCJBHL4aAwMFgegrXlTttijoG+CCnRQFS76JMQCFBmw+4jQaEClv9GOs?=
 =?us-ascii?Q?Gaqm2/kolIYJWWwjZScHiL06sjSoC8nDtQvz66mgfa/z4XZ2yqCuBykkfBhU?=
 =?us-ascii?Q?k8iH5/jmzdZdhnfYKZIFVAbdM4QsbsL7fVKbTPKKQZvPvZuZwxgCeBlTfAvQ?=
 =?us-ascii?Q?u9Nz9nNjvTDrPPD7zJ2wPNEHiOEjGMybHKA+oGHwGRpsj1Em5yiO8aJfEV4M?=
 =?us-ascii?Q?AL9ZMfBCd58aHxNhsPQxNrYVRGXzK8clgNETreMS0SrlEjgKOFqgO3Q5+adS?=
 =?us-ascii?Q?oPH79cwcS7XDeBDxmBCIDuu9eTettrvXnk4N5gMVJ5GSDzO/QP6cwpA0/KdG?=
 =?us-ascii?Q?04iMoDgRyOcuCjDU634kdKzj2GkDIUJFSZJcyv8nQLxABPX96X7faEq+aCR1?=
 =?us-ascii?Q?EtUnjhDn4Rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SuhAlMFqiCN9Gdn1R6Xrt/4TCxEA5kktyluUimpdttvc67h5Wv4Lsp4SY03p?=
 =?us-ascii?Q?VEc7Jxs9Ob0EgtpYLO4fo47DYeoz6pALLtsnuSQZuV6lz8Eq2EtgfvVVz+6O?=
 =?us-ascii?Q?UVxnxXDHtPOCfNBbMMbtokhO6yZR0JAvCCzGAZSstY3SPSwUJyiUrtufdbvF?=
 =?us-ascii?Q?+O+fqk9fGpeYtDjFJDbtI2H53DJ5z0+WrlRuGDlg85fIe4n1ebPxnkgHtrLX?=
 =?us-ascii?Q?Z0zE0mxiM4fJBo0y84SfEq2mx8IxNz91oFO4JR7m+B3HqxF4ETp+ep8kKo+U?=
 =?us-ascii?Q?mVDrb7Sxn98r0WknKYL5+k9gfRJ2UiJ1Bn2BDQB/8Z+Ve0lWI8MsR4smCZ4X?=
 =?us-ascii?Q?xe0dBpPlb5dQsLUNQSS/UWePJyV5VPdP5eW1nQ+1A//+jC6i2eRwHd5XpmIz?=
 =?us-ascii?Q?6f4GkcI7R6ZnLIytrYHhVaR+zjDo6V3nfdWppTygbxJc6lMwrdngXZXgHDn6?=
 =?us-ascii?Q?iyrvwM3EfaCzl+GqHIkz/MFWwWGbBoEFQTRi/IrEayoneUj8Oe87GIwxCZA+?=
 =?us-ascii?Q?FYWqsfCcG5x5h8Fz8s32a75Fzf7KkmnJhCeYaNY9hUGnUs/C9ZoHue62Xf4L?=
 =?us-ascii?Q?K6YEQ6mbm5dSmmBVXLiZ7OsfHFzqdz5k/s+PSAM6KHWX/1f2qKtQLVGLnQDM?=
 =?us-ascii?Q?xOyCvPH4RpqWxEi5cW2Mkf6ZlzTDYbVnR3VP0TEzm7CU8m9D9aOysgub6HtU?=
 =?us-ascii?Q?F07rMg5lJOKN722G/0twvdWcEMQYRuzDjZfOWpBUj7U/9WTAM2Pm/9GMG0uV?=
 =?us-ascii?Q?tct+Kg1geuPttJrsLjy3mtZezyO0nFZoKAfJaTxLTkuVxDtZzq4H9DBBqQcG?=
 =?us-ascii?Q?LAr+P5bsRPz5k0QD4E88j+GoIABLdywQaIdKhsYwGitrhM4eHhKW85Y/33qo?=
 =?us-ascii?Q?+uM7jaUT+r20kC1SsUxVpuX6UAwxUxylCWtb+drVseGjKVYOTusKbTJP02Lk?=
 =?us-ascii?Q?JhGT8t/YkLpmeCqw4gydRQVhY9rGWntIat9A3HzzmOpzocRm/zIFLW61chR5?=
 =?us-ascii?Q?YOOys8kwc2sK7pTlIkx6BFual3qcTFmE3comJElz726CEAhj1n0h/Zh7+Gi/?=
 =?us-ascii?Q?sN9U7osuKHaS/zUGGjNM6oDu7tMdLbRuGD/WWHRLWHqxHwNgPsmMydCRUUVr?=
 =?us-ascii?Q?zhwCnR52Kr+xZragOa9MwRl0nFFz77CBIHIMjdgUOovtjtIXmhtZKnUfS7v7?=
 =?us-ascii?Q?l+zLt9ienq/YCwAJRY+7q3Yku3ldRvO8S55uKZbTHRKMJ3YR+tt622vxT1Uw?=
 =?us-ascii?Q?8MXMHsx9PCOL6Y7dGvgBH1Ce1arpPGUG0J4xBVjoN1dgFv63w5DuUHi2ett7?=
 =?us-ascii?Q?f+Og45HE4WKqNRd1XOoqShIGdzVk3vP8uzz+1TGoy9wPbB8AEqju+fULKOmb?=
 =?us-ascii?Q?M5+V6/fxIyxGwVysln6CnuE4S5vTFWnyFTbaNez9Sb845DOUFhgqy6PG1PmW?=
 =?us-ascii?Q?FFDX3QaYvmljMwwM8wS0Z3tKUJfeCcO9qUFGxux/KPtf7m2R/BXGXlJDqGeq?=
 =?us-ascii?Q?bAB0ltyo1/Pf/gjGDmHqpE0l0Sb43FDmXExpBKkkkbTrxIU82sP2bMWeOtqu?=
 =?us-ascii?Q?fO9uiYvNaUzqaF9MJJ+83HIcgTfih9i8B2CLohjZZO51JpEVTPab6xvDYcw2?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gOuAHUJtM/eXympHoBpwnNM/DwUbjfTGaG6WJBafiLCI3Rp1KHbjooHfYJYKw6HhHri7k0vTspCj3Fj8BzuK379OkP1yNyDdro3h5HqKEA1ncrhJ/ySx73lGL18du2UY8B2SAvW4CjZKSXhubozveCXGOOl6PlH/HNpUsXe91+ROJTVA86weFqtVw7gjllZ47JjmssiJG76qfea3Tq/Yz1+RgTraZpPU5BmpI3YqCntSGTY6hFxtRyHYef9LauF0Nfh0LQumqHjEGZnbxm7J5JvkODchgKajTWvQvWq1jmQiMWFW/jRQNFdDtqqKd7+Vcus2WIEyRhsnDlwI4SsqUzPsUKD2m750QdPDetwrXklm02Yihtrb6PpZv/Vq95OWRIomM2J4Bwxb/qFKmCZkmhqZSr2t5i+Syrrxn8t6x3k/i8j6eXIzDz49lXEi1fCc+PV3xiTacSyZf63fFBFcntrv3roKTR65IMEmOGORCmyOWY0kx/rbCFS6tGMFZVEUTAvuS6tOOZT8V/CEMFFdbkNn7WJN4gpr55iq4lhsGtGEibfb9bQ2+WTVkISVEo3l0U5LEn4rEdhIN9joi/Gu2UyUmZ8L5md5sD1dfHY4HFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aad0bbd-2d33-4ae7-aca2-08ddf1e2d753
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:53.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCkipjchUOAUK3wRA1dg5/lmj+Nv8ioazZqEbzGkUibRwBWlhOd9l03NSGrEafg1WeE7AHpNqmXsMp7SLQh9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120094
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c3eeb5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iEJuJAImVHsw5DF5crcA:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: RhwpaQ9LguXGHqS8-T2nGESdLjj-wN7B
X-Proofpoint-GUID: RhwpaQ9LguXGHqS8-T2nGESdLjj-wN7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX4QpAiiV2SFD/
 Bwedw8h5BCy1XR1hCPdd89t/X/iXXLOWTXj5ngYg60EtcnZF4dyLgYUWX8BNGnYesjmM52QOQle
 3EmwVYigxnrCR4JlEvpYvySI+1QSNXoP6RbMTqRLWiH3LS+301AqDABaitM7TbxapIjMWlQUATa
 AADP/UiOB+akfRsV/OOW4aiQzTDwXvBk7CWMhwKFtwzfiP3G5lc5zK55Fn5qG57uhhUiD4vBBGR
 J6mxL1L2dc/du1el/rW99A6ZLDli6+T1tPsZnAzzqzJdh57zA3nnO4KU+jsG7NqWy9wKhX4js4T
 h9Lx31EH0cqoWTbPPEQTKdgk2KRskGPp9aIXHwpQZ3aTx3T+M8R+GQ0CiHH5lLhtOOFuIv94Bop
 m2OxRlaUyjaNWi2S5CZS00u4Xow9gA==

Ensure that the drives are at least 5MB. This is because we need to know
the size of the volume to create. For dm-linear, we could use vgsize.
However that doesn't work for dm-stripe, as we want the volume to cover
all disks; for that, we need to know the minimum size of each disk.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  1 +
 tests/md/002.out | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/003     |  1 +
 tests/md/rc      | 28 ++++++++++++++++++++++----
 4 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index 87b13f2..0470a1b 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -22,6 +22,7 @@ test() {
 		num_tgts=1
 		add_host=4
 		per_host_store=true
+		dev_size_mb=5
 	)
 
 	echo "Running md_atomics_test"
diff --git a/tests/md/002.out b/tests/md/002.out
index 5426cf6..cce1b1c 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -129,4 +129,56 @@ TEST 9 dm-linear step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_
 TEST 10 dm-linear step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 pwrite: Invalid argument
 TEST 11 dm-linear step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-stripe step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-stripe step 1 - Verify sysfs atomic attributes - pass
+TEST 3 dm-stripe step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-stripe step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-stripe step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-stripe step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-stripe step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-stripe step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-stripe step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-stripe step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-stripe step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-stripe step 2 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-stripe step 2 - Verify sysfs atomic attributes - pass
+TEST 3 dm-stripe step 2 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-stripe step 2 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-stripe step 2 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-stripe step 2 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-stripe step 2 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-stripe step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-stripe step 2 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-stripe step 2 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-stripe step 2 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-stripe step 3 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-stripe step 3 - Verify sysfs atomic attributes - pass
+TEST 3 dm-stripe step 3 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-stripe step 3 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-stripe step 3 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-stripe step 3 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-stripe step 3 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-stripe step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-stripe step 3 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-stripe step 3 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-stripe step 3 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-stripe step 4 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-stripe step 4 - Verify sysfs atomic attributes - pass
+TEST 3 dm-stripe step 4 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-stripe step 4 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-stripe step 4 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-stripe step 4 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-stripe step 4 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-stripe step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
diff --git a/tests/md/003 b/tests/md/003
index 8128f8d..3e97657 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -37,6 +37,7 @@ test() {
 		TEST_DEV_SYSFS="${NVME_TEST_DEVS_SYSFS[$i]}"
 		TEST_DEV="${NVME_TEST_DEVS[$i]}"
 		_require_device_support_atomic_writes
+		_require_test_dev_size 5m
 	done
 
 	if [[ $testdev_count -lt 4 ]]; then
diff --git a/tests/md/rc b/tests/md/rc
index a839a66..da04b4a 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -152,8 +152,9 @@ _md_atomics_test() {
 		let raw_atomic_write_boundary=0;
 	fi
 
-	for personality in raid0 raid1 raid10 dm-linear; do
-		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+	for personality in raid0 raid1 raid10 dm-linear dm-stripe; do
+		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ] || \
+		    [ "$personality" = dm-stripe ]
 		then
 			step_limit=4
 		else
@@ -217,7 +218,7 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
-			if [ "$personality" = dm-linear ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
 			then
 				pvremove --force /dev/"${dev0}" 2> /dev/null 1>&2
 				pvremove --force /dev/"${dev1}" 2> /dev/null 1>&2
@@ -233,6 +234,25 @@ _md_atomics_test() {
 						/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
 			fi
 
+			if [ "$personality" = dm-stripe ]
+			then
+				atomics_boundaries_unit_max=$(_md_atomics_boundaries_max $raw_atomic_write_boundary $md_chunk_size "1")
+				atomics_boundaries_max=$(_md_atomics_boundaries_max $raw_atomic_write_boundary $md_chunk_size "0")
+
+				# The caller should ensure test device size, we ask for a total of 10M
+				# So each should be at least (10M + meta) / 4 in size, so 5 each should be enough
+				echo y | lvm lvcreate --stripes 4 --stripesize "${md_chunk_size_kb}" -L 10M \
+					-n blktests_lv blktests_vg00 2> /dev/null 1>&2
+				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
+				expected_atomic_write_unit_min=$(_min $expected_atomic_write_unit_min $atomics_boundaries_unit_max)
+				expected_atomic_write_unit_max=$(_min $expected_atomic_write_unit_max $atomics_boundaries_unit_max)
+				expected_atomic_write_max=$(_min $expected_atomic_write_max $atomics_boundaries_max)
+				if [ "$atomics_boundaries_max" -eq 0 ]
+				then
+					expected_atomic_write_boundary=0
+				fi
+			fi
+
 			if [ "$personality" = dm-linear ]
 			then
 				vgsize=$(_get_vgsize)
@@ -411,7 +431,7 @@ _md_atomics_test() {
 				mdadm --zero-superblock /dev/"${dev3}" 2> /dev/null 1>&2
 			fi
 
-			if [ "$personality" = dm-linear ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
 			then
 				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
 				vgremove --force blktests_vg00 2> /dev/null 1>&2
-- 
2.43.5

