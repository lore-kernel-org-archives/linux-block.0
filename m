Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EB54758
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536704; cv=fail; b=NYCUATwTCUOY5YSqt8Wc6Sxk47PFokS3/1Vs92QpJmFUej1sX3em2FYReThmPRe3oMc5EyNYYu6s5zbeAyixZqAVR/12IPn8R8+Q4nlUliGrR9LfDhmaoHMZ1aUKX6CZOGPuTnHMjNL4fU6/tjlMzaHNJdjcwQc973xwCa5o6pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536704; c=relaxed/simple;
	bh=Zc4wVWpThLNITNYO8vc2tx/OySxdilVY5n2sziEgsEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0uliSMQnpIpjj1POjvQ82UWcOzXXbNxtF4V73NVQOogqljU2FN5nGgGD+fsFTIkz8Oid8KDgxKtlwjqrLTO1CNuKcN5s8hFQ8ln33MLtT5MboImdpXREv7MzFE9snrCcUIjpLfx/6yaTQwockuuiPOG1jd9165PmaQ9pIVh0Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JR7i6k7e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RM37VcII; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JR7i6k7e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RM37VcII"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NL1t024114;
	Mon, 22 Sep 2025 10:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ixX6WdOBH6n1sMjzRa/oRbYG7Q3UQrzH2G4wS3lQDHg=; b=
	JR7i6k7eAgEZ7S8RSUJVwvvPGUqHvjE0orv2+2FPShhWk9p7j/h0XtuxX+6kys9S
	JujaXe7tulmg3vVka+pVX+Fn3LERaU8rrxJUBrYs1Zb+7oXJnGNSrBXN6wT5E7LY
	jLtgR9vIVA+PdqDTQDpiPxTJ+i4uFKHAayMR4e15mc2K5VEm77p7jV4FUoOXD6WR
	Bm1oFcRkN8nfl//pKULDJPtx6G6A0ywVyuni0i3YcfynB2Xddz8n9C48aVYDf7/M
	XOFEMWt2wvvhsCVOjgsJKVPEIjE1bO1SzWkD7JqQLlCtLm86lUsNjKFbkHxFEq2R
	zolnPdV+O5Dn6ImCltkz2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdj4mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:25:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M81Fl4025290;
	Mon, 22 Sep 2025 10:25:00 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO1+hhHb2vfU16vowAzBvGRszZ44+PkACHF6tW1eOZUeGtFvjD7mKtVbMF9XNPdpBapvlMRvDBxHg3NgKQOw7wHzW/rpckrKPK79pXpmhKni2UNedSyQy6ODhQhCnliZUIKTS+dPny2DOjZwIEQ5IVAVx0QQ++w4YTurenM25v7Ok90wISQAQ9FT7ST3L0HVMmnJd3VbvdzstXA3v6L4+/B1kkIiOF1fppsaJiCBILm345xrAx/mx1BmZkr+jZd1UCLe9JXWP8eLzicPa3GLN8mMYE0axJh/h1LLETq/EfcvJS5HPvAxtmY6UW4bo+hUFWhegr/wF4FJC+QCcVkRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixX6WdOBH6n1sMjzRa/oRbYG7Q3UQrzH2G4wS3lQDHg=;
 b=fYZlEoUh94UPVwH0U/zEcprCbDcv7qTyzgh+cdYSvDi3i8+GyNlDGWkDquRaeV3coB8JDwbTA/BTOJTPIfDqTVyi0OD8KCOArVF2n1WkdmGuKhb1ruAuO6qaOcJSVMES4A+r61pzfaUGvF8AlmS2HjD3ebi+CFK+3Ie+gMPWL64R0Ai6fHYXqunwdOU8WTdFaqlJ3rlHcRxouc9aK5xkkjBQqvCXj+jN0dU/hiBOtefrkKVp5MKe3ZvuMA8lUVItKWdZdKz8g82ZnSQnLYt9ku/XrmFrZ+nl2DBrvZOYCFkTwE11xUl5y7FtabzdLwp00uRaSvm96ucy2uT7GHTK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixX6WdOBH6n1sMjzRa/oRbYG7Q3UQrzH2G4wS3lQDHg=;
 b=RM37VcIIkUHOLKLl9k0Q+w1PyHz9AKUL/QVpZhSCyDc8wDCAi2MjSHCPo/iD2xgqFQdR9kz84JWaXzPJlUjrYJs1on3n2ohThe4Ny0pQU0Wbdkr9BYNnBjpTlfO6KK8OG6xstOXQMTbVZTkMqTY0jODn92c0SUI7qS4TUX4WIP4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 8/9] md/rc: test atomic writes for dm-stripe
Date: Mon, 22 Sep 2025 10:24:32 +0000
Message-ID: <20250922102433.1586402-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0065.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::22) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad00d6b-738b-40e5-93f4-08ddf9c2480e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03hLar0TamKalIWT+DOX3NhH473HLxY4yXB2GdixF+aNRIbLyXGQ++nd8Ebt?=
 =?us-ascii?Q?BgqLyB49N/RK+RP0mMnZKLpXt2LhfNHokVf9kUMVrwfLZ+ZnAjFsdqsJ+QdY?=
 =?us-ascii?Q?c97XQ0Iro+ULQGC81nj7kV1XEhsUyDIU1uuKjvvle+QQt3nMuypNpbNZuN2/?=
 =?us-ascii?Q?DCB9VhmIl4lWpekgUb2gZRGJudhoUu702VMUIPu3jykgaaJ7bLgh+lUYOAe6?=
 =?us-ascii?Q?18OJAYUGpexJy93AHCJZ0M8wa1WBODq2arV43dvNeKCQHnznqrdRjx8NKqDn?=
 =?us-ascii?Q?DiRzZGjNemmmLcBXGxKS6Rnf21hfAJ0RE+Y/Q9Z4bJZo5vHzQv/ANLVDSEIG?=
 =?us-ascii?Q?Ry+wyCqB/qIdWWT/U0W71DSBa7tlYVQ7K26dfZ+X9oNGrlkAdoesnjdHCkt1?=
 =?us-ascii?Q?1jlddqDbZuqOkwgKSA1OREg98Vf3XJDE/EtXiySoajCuVlFHT/jq3CUD67WQ?=
 =?us-ascii?Q?WFCl5xrG2yU5HWSpFz4VKMiU4D1904MtCRFW/LcDSPuOVZr+Of9+nrJJQ0xB?=
 =?us-ascii?Q?T0u169PnTTQGIX/qO1SCjXR38nUx/5CTsipTnYZ2EecaUXbIUEP5sCsZxGD1?=
 =?us-ascii?Q?Vb+4HuAOhwtKnI/xW06kZTZpzeSGdRRCzknef0KHRteGUfnTMC7bVp2w6kXZ?=
 =?us-ascii?Q?jKXrlWgYAOYwouTq9MDnS4DWqR0ZrYToQb2U3d1laWltbffdsqfHNs7R62v8?=
 =?us-ascii?Q?8W/g2qa+oHUgl8vQbQafeE/DqI4/1uAEUAYpF7s7fVF2IotFS88LCiwO9oPp?=
 =?us-ascii?Q?D3UJjVLyVRibQKCOBU5GP+dv2DGY4IosCYSh9/RXicWv6+7xxeIijLMMpV/2?=
 =?us-ascii?Q?Kr28jZMbCw8sk7TffdaBGgoPCSCsusqunh3NMx2hscDO3dS5T32y10F8loYF?=
 =?us-ascii?Q?TMqSugZMun8tNszhS5EP+YbC6YBPBN0Esq/TtBuav5Bc6LPAGepwwJXviTO/?=
 =?us-ascii?Q?mGK694p+yjKJ6LOrHNT4zf0qi+/LTfHgeueM1CDVuOuY/zVVxd/EGnJbQ1b8?=
 =?us-ascii?Q?gUwPEpz3+rFS50vroXl/RRzGy1gUkKnQCFbEIRfR2n8tBwLAqE0x6Q6AOFmJ?=
 =?us-ascii?Q?x6g3aHgqfmD0yoYQ3HV4cgiqFOodgCun+Rwlp+9f9fz+FoqhwPeON9jDW9oG?=
 =?us-ascii?Q?NT81VMj4MPj4rDZSRP+bWskBXJlpqA0SlsB8vsbLYLTyGtG2/qdKQdxRRYrF?=
 =?us-ascii?Q?jve7lD6CkLCIqDPDLvAgzxLCwapr7rVOZbarEGUAQH2z+krOpw8BI1qN/w4l?=
 =?us-ascii?Q?SD6ervQcByRXB61RYPIsr7iLVQ/+/1xnnLZWvGn6+aJMu7x7lcdqQjDDSVmO?=
 =?us-ascii?Q?awiWws47OzCWc4yaBs1MLmU/3vZCRYuMH5xUlJH9TeycQuWKQCCHXFr750Dv?=
 =?us-ascii?Q?Gte/T1ZX4VW7ojETf+HmyB/H4LFwYBP2M2HGVyXnLqAzaE7SYUI5KFRSRbpq?=
 =?us-ascii?Q?iAS2P28rBBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yI12QFsOG+Gx2176SwMB6uRdof3w6bHgIPCx9L6i9Qqk5X8Fxn/On2mveJh?=
 =?us-ascii?Q?F9ImeA+BGFnytRFftI/576uI06wWmdu+SYO7sDsoFsV47DFkjHDVtjHe6BFS?=
 =?us-ascii?Q?mGTbm/cb9Jv5wkfbgPmH8pcP8kAcPRvCKv3qDpaF8g7P16cuuOujYMhj26K8?=
 =?us-ascii?Q?tl3uVKQMppXUiVdCpwR63Hh8blkWZUpAkSEMBqhyEKhd9/TloXTk77B18l+K?=
 =?us-ascii?Q?ZF0zVasnFiX7YJy61dYnjdm2NN8jdU6PaCXVqqEAVYSsnrD1qUXx/fvp8GOv?=
 =?us-ascii?Q?9Jx4EzqkjKRCtsRKCNLo2HGUjoRSya3Ubss6tlSxHDBpJBMe2OmBwiHHRGyh?=
 =?us-ascii?Q?12MzDc8/B9Xg20tcTXpIdi9v5NwVNvzoHSn8hMcBDatuHeeNFCi4hVtWHA6e?=
 =?us-ascii?Q?4UHSLufwWwfc0veT1EHgoOAz3tDsCfHPNfBnAWuOgbJo1EjqEJBB1VEvjPCy?=
 =?us-ascii?Q?Yu/kNSWJnLd88VxhMZbOaLYlSxEiuhdF+tTmjSyl3b6TJOBu9bhhzjfI16WN?=
 =?us-ascii?Q?IWE7bQ6G2HheRImRynlT8FMHKpEP5OQA/vXwc2EVN5QhXq9fQcSLjHHAq7ka?=
 =?us-ascii?Q?AK1uOU3UL5hkg4IAj545hhTE/ENI16TCIfGzRuWKAPmQulITSi6TCavVC219?=
 =?us-ascii?Q?0dwiiprXaeqsAfGD0nOVGsgtGUGPD+dorQCaVjBBvzjO87t1kmM6DM5SRQEP?=
 =?us-ascii?Q?+XKtUWrg4ObbDqHIDW6H38OnRUM5hvDF2md+1YoodQOyB9IXq2D48WozL9Iz?=
 =?us-ascii?Q?GaevPJxyZFF7fPFIvH8qiCL9It73CTbCxH0ayJFdAup/Qml3dpweh3Q7YDTv?=
 =?us-ascii?Q?oLZJ2gWVOgtlVwIwgFWn4Ah+hoIQBWf0QsUo5+w5VfKqIYtvHeKEZqPGilr3?=
 =?us-ascii?Q?JFxJJ3xsKTh+WXV5LRzr4AbDqItQyiWIC2LC5oH9AMeZB0fXQkhjh3YAwIew?=
 =?us-ascii?Q?qJGK3guCAk/H1qlzfXt2wFHq1OKIEmjz8OJoxWFbaRk8xICAuBCH0Ahcs3ey?=
 =?us-ascii?Q?52gbo5WWgKIqEFKiCyEsmrK0XxDbXgGgN+r3D4oUi2XvmW20sY+wIVxDS8aj?=
 =?us-ascii?Q?a0N0k7uwNJdOyEnsIsfvO58k5KuzwCBSGZsoegBqSkEr6CEwcQ76fW0+9iku?=
 =?us-ascii?Q?kjCi9SUpHSD+EPoRmpZMXnvOqsagBLH98HobB8/zxIMJdHSuTTKrDrEHsN5t?=
 =?us-ascii?Q?7v3IlnGZEWFeCl4+TsXFnBgJFZiz9D1GS/xWVLsRUOZHy1adyvKl8rpFj5G7?=
 =?us-ascii?Q?/8qqWXMElxB9OM0dU7pV4md/q8ljsURqTkr0amgB2GSxl//MLW1YqtBum//v?=
 =?us-ascii?Q?wk3rQRw1k/wUbN2mly1ONKhnWybf5yNMaSPlwa3bkd1og2dycJCYKmvXw/LJ?=
 =?us-ascii?Q?iC2BK9Fyv9NuofrA6BdsiUNfUG8+8BFsUiootLOu9MgX5nYreXwwxwc3Zekz?=
 =?us-ascii?Q?g/ZVFde5HiynDqxQTs2kott17HJsVJqM5RYnot8vC7hLiWsLUiYkf98UReTk?=
 =?us-ascii?Q?S6oMgFGSZ83vGXYTwoMi3pVfreak1Pj8zAxr0R0jOjmMiXbahUQsl1xUGHf/?=
 =?us-ascii?Q?l5d+mLQZ538mqU3uF4zDJZ3FvScYBz3CsCneawTtI1ima9Hi1ISvx4wSuwV2?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7D5He9xZW6y0JVM1cyxS0IA3+IOAnbCoExAzjD8lRgFDUgsfFR2PvwBOucJMp2SGnwUhg8pxB/2x8cGzOZvtX32F6SS4+RKLOoSa1KUYrwsLRulLLiqddz6qrsqnKveIANUtFX9tbtv7WcM2nMe7OrDxSB0u+lQFeYubIABmHLZDejTBMTSHzm0KxAzvEUQz8irAONDlS0/FclkNXQq2De/M+iWhm4dPL8qURqVSKhpDM2xJWAIuQsFiS/DSZ1G3VraUd9qU6y35bFR2fMIafWNKfZNaC5WxfDI22XsqYJfoOjpfGmuGaiJozdiKY5r0qTjj1csreU5PxakPnfedFQXNPwdZlOE1j6W34gCYWa9x7Uk9kyJJX0kWu1g/NfkKKLDuDm6pt/xAn+fF7fPQdfUlxiu+Y+qDJV+t2CFXI2It8hrjL7f26m4o2OQy5k8Vl8ALI9YeCrr1nULH3/QWO6LX7d2GaqXIZ3pYrqzioYXKsJTA6pxUciquHlXZqwD9zn0rivGvoM8TNRxFkjVOR+stpRVo8n00qhxXJ4Ik8PZ6nz20nKdgjEkWbXc9GYpTyG1Imt+jEFU8kJPLl/4wWxFu+kErLiH1rglzf+oKSUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad00d6b-738b-40e5-93f4-08ddf9c2480e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:58.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SC4kgHzo6O1DdNeGDesvawcvdMStd3VF9MBreXOKePtDcmZZxEAFOPU2IRkiDr00VTaVEaT9GMoyP+PXRdRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-GUID: e_gMw_yRXkt0FHHA_H5UxPUxrBLRZZ0_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX1YgyD9wmHLe5
 oVXGihGbjZAB4vIPg+0VPo88D0L7HqGSPNIIimOMbW4Z/enOEPoNXv0wEBCK6hk+X6hiBcG/M5p
 elu1kcvrxPIp7UO0rkUqkatokGBQX6ZEeqt9vFUq0dXpDFEWkqjnpKKdMJq3xFcS20LDEriptFH
 7xG8DXBpb+Kgz5/Rg4gWtwMnKFZkglWU+9/d52phc5/xTmvMwo2bdrEF97oL8ytlLSjKx0L/8BY
 9xgSTX4+KkMAwMqa1iuTGhdV+uI3khTr+lRU436RbpwiUzq+Lk2YI78khQzF8b4E2s9a6Cqr9Ng
 /HZDuAaHW6x8tYtyJiySxpTmE2yofXKoZNbQ4H5ct6aaKAYMuc9/wsQTKMvJ5flcAOEmUKyoZjB
 7DY5ByzS
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d123fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9HuwkSwJdvHQPwxusnoA:9
X-Proofpoint-ORIG-GUID: e_gMw_yRXkt0FHHA_H5UxPUxrBLRZZ0_

Ensure that the drives are at least 5MB. This is because we need to know
the size of the volume to create. For dm-linear, we could use vgsize.
However that doesn't work for dm-stripe, as we want the volume to cover
all disks; for that, we need to know the minimum size of each disk.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  1 +
 tests/md/002.out | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/003     |  1 +
 tests/md/rc      | 29 +++++++++++++++++++++++----
 4 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index 65a5fa5..b0cbeb9 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -23,6 +23,7 @@ test() {
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
index 5a68480..b9b2075 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -18,6 +18,7 @@ requires() {
 
 device_requires() {
 	_require_test_dev_is_nvme
+	_require_test_dev_size 5m
 }
 
 test_device_array() {
diff --git a/tests/md/rc b/tests/md/rc
index 3209402..9f0472e 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -157,9 +157,11 @@ _md_atomics_test() {
 		raw_atomic_write_boundary=0;
 	fi
 
-	for personality in raid0 raid1 raid10 dm-linear; do
+
+	for personality in raid0 raid1 raid10 dm-linear dm-stripe; do
 		local step_limit
-		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ] || \
+		    [ "$personality" = dm-stripe ]
 		then
 			step_limit=4
 		else
@@ -225,7 +227,7 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
-			if [ "$personality" = dm-linear ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
 			then
 				for i in "${MD_DEVICES[@]}"; do
 					pvremove --force /dev/"$i" 2> /dev/null 1>&2
@@ -236,6 +238,25 @@ _md_atomics_test() {
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
+				expected_atomic_write_unit_min=$(_min "$expected_atomic_write_unit_min" "$atomics_boundaries_unit_max")
+				expected_atomic_write_unit_max=$(_min "$expected_atomic_write_unit_max" "$atomics_boundaries_unit_max")
+				expected_atomic_write_max=$(_min "$expected_atomic_write_max" "$atomics_boundaries_max")
+				if [ "$atomics_boundaries_max" -eq 0 ]
+				then
+					expected_atomic_write_boundary=0
+				fi
+			fi
+
 			if [ "$personality" = dm-linear ]
 			then
 				local vgsize
@@ -416,7 +437,7 @@ _md_atomics_test() {
 				done
 			fi
 
-			if [ "$personality" = dm-linear ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
 			then
 				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
 				vgremove --force blktests_vg00 2> /dev/null 1>&2
-- 
2.43.5

