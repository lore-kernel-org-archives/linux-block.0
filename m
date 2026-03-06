Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E1D7995;
	Fri,  6 Mar 2026 04:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772992; cv=fail; b=dQ8PHbTkL3l8k/1Y3I1SsSkGJDmp/pr6mIXjFMb+YFdJDROSeaexDJLJNX9HBlsbz9Dh0NKLA0Tw1euZBQSy4mJAThAcp4rNgu2462p27OcajQQGS7npU93l9Xx4++WsFG7j1EkQw7yDCtGgeMAtTHKEcfgLeWwtHSjj8M6MF9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772992; c=relaxed/simple;
	bh=Yo3UbIP3SajMxQrPa3jwIqmhwCEPYhJkFHOKu5tuqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hHU/JpFA3g9urN7FtTVHvnWG2qfvzwHe1UAL6sM2ObTsVx0t6iFhRlhfApn87ocmokSFCXWCdRCBl8i5kXERymnqPejhNauSW1++wBk5rPKCbGho/qvkSARfUf6Vbn7qQHWBlIINccLBtqz/zcHW9rQyzlylFsFJMlpTK2j954U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FEnTlc4/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QlGUvDx4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEnTlc4/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QlGUvDx4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62645D001826149;
	Fri, 6 Mar 2026 04:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DIaeDuGLwtw8phueK/
	628BTJtiZ38J7+ca0R7Qj5zrM=; b=FEnTlc4/w/20aoUFF9etI6sC9zyDt3jDfm
	gs2i7NuZToNH5+Dov1MGQpOhIHTzOHUzNbOmsirZs1bnWJaS9vUy7/QSq6SpBRgQ
	tLTv6fWGo+KqHmWULQuyfuVn+c1BmicnoYKRq3CnCMhPP5I4aWhD1CaE6gw9LK21
	QvJ9z3OdH9tefrC2rxFgI8zhZ4nPdLj489+ZSa3dmFS7f6fYgzd3EJbIHObHtSSj
	j7NTlXAwSfoiv9OhPIJweYs3fzLkMX5QRvYIkZ7K86/Ih3RKHdrQRPXoXf+FWLKI
	EckKSsYJydMdlt75wBC7PpwZOLGnq4CPkekADmo0YUUqQ8KVQGKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqqjyr1sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 04:56:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6263B6Tr027327;
	Fri, 6 Mar 2026 04:56:00 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdx6h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 04:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGeRGEvBKv3VGfzNgWhqLd4JzzYwP6XJ8g/r2ayCRM7wuFznO6wnBS1zRYE6otvz4/sHotw0yjhE/d2U9nXyzqFCWj+NLe6UTjx6+/wbm1zIwHQfBeLNDwFKE8UIQSE/wqMXVW5SqdpoX3s53vYopNvMLVNrsvqswG66s6VZIyFcR+D9bBPVgYNpH53cdF7M5m40lKTmxH1TMBM0EdhbRG5L+hS6OT4xnXe97krsMsPZhpa6gNVHSDVwCe8Sfdp5XkS8W1jgu0oSQEG9Y7ROk0a7SZy8NGAHyaj1Z9d4gRqbA/pWF3llPUZWIlZMvLjGJugPtX/aBjWvSZEzNO39cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIaeDuGLwtw8phueK/628BTJtiZ38J7+ca0R7Qj5zrM=;
 b=jPJkfyHkfo6ts5HgHNuIBHQBSojyw8CKemHWAfGViVeoiVLVis5j9bSqbAjt5Ur2On3YYb6ksnTaQodLUQjcfvCz/wU7gfnfYLn9qCJgudaZxn0DyeI12oFEzgLMagGZXwAKUiUc/RTzwtuzCVgSLSEgXqVrVayYZQts91WG8Y268ctPPLT1XtYrKu4G9OrZrdG5EP7wcM7etfgw//8dhuFCfPW6JUt4scgaJxLj9BKsppC5fM/MoaV02gCT2bwb0qr3USBCHz5Q5ZblxjYkI4iDSGESJkS1cvtZIaa6X/8kdxEcuq2/KZawYZsEX0UgrKMXKHbXfrkDr2499M5W7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIaeDuGLwtw8phueK/628BTJtiZ38J7+ca0R7Qj5zrM=;
 b=QlGUvDx42wQlHeVO/nUqZ1LKW0Pd6PwX58KUpzTtKgtm0GneU2is67WgfJCk74kBgM6Tepor1hDyVtPjwT8MHO64GPgkNNtXnq9VVxjGKXn4zTun6A+wKK7wfwKcZwpauasaXFpq/DC6bRh0Bey9S0YzuUYf9zP3Rj6Dp6CxOik=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7558.namprd10.prod.outlook.com (2603:10b6:a03:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 04:55:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 04:55:57 +0000
Date: Fri, 6 Mar 2026 13:55:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aapeVb_L5zohWRRe@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
X-ClientProxiedBy: SL2P216CA0177.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffd4630-da58-43c5-9b8e-08de7b3ca7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	lQwprUKOLag486jjNelVr61yxSNPrsONfA288MuypnqHm/a6AlrA48k5xYUPz4eg76tPOhj4BMcofj0r1/+vsPb1Wx+hx6C/1rorWXqLlqYJeA2tSlRuaQGNKyxUCu80m4/ghctzhciOGQJ8kI7ru3Ff7EBVmF6ns8SOslFYBec5NnMfyAjDNQt6PTCNqxfs/QQKXuPXPfSRmsSIiFcT1hMbliYl6zYGjJ5GJH4RwUCTn2BBXDMQGeT48pmVFlI5JGEOrL2M2hJjt6SAbeMGglcvXKJ2dWo01Ed3o5/pPY+K5JRXjW2S+hzaIRB57ltTMU9LH+3T/TOeHZtQHuOv5U1bJCtsf3mt579+F4nzjrwtist0BchQdR8+ikVEva5NKu2k1pxHxnjtmycmh9CkDy7iWGUBQ3LFI5DhX80h27pNWeBnot3MPqAXsB1gYkHoJXUEQyOhGEXBI7Zrl+LcFpJ0whfnfugPdMud985pyNPrIp/rEUI+0qfPK4OIcG7LykNU1JZ/uSj552WZWNkh5+noosfNSGJPqCbggQkXuyJ8TnvmbxM3OsIMAWxDMHjyto7+UWgY7RVROK/FpUCsRDHX8q2SqegfNMyRBUDQpgsyoS8/pRCJ26NE9tcSeIQ93usEKw96nxvsB1hx6n+IdgPqZqIKDtbALRROqHrNONAZjQQRoCK6THHEJSslCZ5LkgN28oRCM7Tu96jo0MTZ1EWrrnu3IgUhAQCW7qNsomU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OISxgDDT9LvnvdxtxvoO+z9nnSwKZN82AS+51FVO33OCP/kdqoQavYeilb7u?=
 =?us-ascii?Q?A99qUAiEOa8llK6FzfwOD5i+i5kvxf/4LfcMh0HMsBT7Xjg1CTGT79peJcfz?=
 =?us-ascii?Q?WbRJQG93XKW970/xhDpGfSlRFw9r8gaE9hNY3X3mj8DHzNJV722yJLqKdKp/?=
 =?us-ascii?Q?lF6N9fgqVpkGU2eG85pPcPI/25G0ync9gI7yLFJ+mkn83M+KPSTLb5dSmqKL?=
 =?us-ascii?Q?TPnKYLpdQ1VeOc4UInLwqFIebSxCOVvIkK5ZQZNoRVN9mPRMCWO8IMbjc2eC?=
 =?us-ascii?Q?No7RQd/VFeU6SMDdLRGHMN+C0lO6amqWWRl2xxuxTEFFlsoSfzHvzfznkcNI?=
 =?us-ascii?Q?1fsUV8W+BctI3VfRXjW0go5nk8bvGl2zEbBqqYaBrXGK4YDFoaB/wI/b6EBD?=
 =?us-ascii?Q?GFeqtAmVHxJ6X1Dw6U/ew5L5J2JVeXs1un2K1m9Ys+rRMs7F6zgOzWDBoZcY?=
 =?us-ascii?Q?krcCJlWb5G+8mHUQdy11Pr1vA2JPLg8ENSQwdllxUCQIALU+9GAc3KbYjVAh?=
 =?us-ascii?Q?WID2g1+0vYmmyMocImGAQVDqLvAKdRziRla7d8GaqLAwtniD4/pPaIG2J9Ij?=
 =?us-ascii?Q?kBVe1b3M2llBzx7dCoYpuQHWB3/fqI6QVOdyg20YLWR45LT2VuUIZDkAzCOs?=
 =?us-ascii?Q?4D5DISh+jvuyg6UL7T7vTCDN5Uhav7u2mPP4JKaWcoGGs+HLSiyvQpthtyLs?=
 =?us-ascii?Q?79L7Yrgr/jaAdltj17Jicb9c6lPDhyP6Zt0PFboaF0PsO11hJRsTDR7Hmzem?=
 =?us-ascii?Q?qoRXCDVy61kKWX73ONaTIJCJ8CTpp0YSJ6ZdpkxgBO+dpv8QBQxQHt3nTC3i?=
 =?us-ascii?Q?AZHZ1S4kFY0KKN6wIS18a/bcTpad8waaJoOTWrIghzk1ksM9MDBUkf/3+bTO?=
 =?us-ascii?Q?NiPKR/VLE5GjNXjFnFibTS3hdM7qn+6ri1VGTaENgCA938+Tbi6AOpqy5VZf?=
 =?us-ascii?Q?vHpmBgQZiIjJV02xckrwCxOT6LLiM709qxIeFV1vcX9JlPQ6Ev06lsLJqtHl?=
 =?us-ascii?Q?n9yOTPT8Edyl3fv3T06pY2qM42NgcbplsTXzBau/VrMF3dMM5GBI93Wd5DMy?=
 =?us-ascii?Q?P7DJlVIi8Z2GKSwK40Zu1JU5r08RfaGYcLOtIY4gguXz8OwcVoUMbLX1oYjK?=
 =?us-ascii?Q?X1qEmNUH2UW3s0vMSQxc3HTmAlfD4zFlmirg9wAo2ZkIcv35rQkjFjuXP/Rv?=
 =?us-ascii?Q?lLBdmiHorChTE7CWKhrZsbOJb2y0AwCh5IlUev3GWpykdb2kDuBP9cNuVn1g?=
 =?us-ascii?Q?C/q6b/80EzWFnGv9ZKcTJhQYUI0zf+BUd0Fcs/DhvZZTpgytkedkLgIzSBG9?=
 =?us-ascii?Q?N7m0eg2mfFsPe9XIdm66nve62bUJC0PdCvJwzfNe9S8VVQPENBT3ayCecSln?=
 =?us-ascii?Q?bqh+rpdAkolr1U4naVS9hx0UhskksxI1lgavKqpKsnX4afYXgqy7uI8IC45S?=
 =?us-ascii?Q?xZRRRZ0xVsvuCOdvjL0NGz2g6OU8TFIvQPivJBh7MxvLV1fvb9sw+OQw0t0M?=
 =?us-ascii?Q?twuPgr5ofCXYLuFk49blRvRwOffQVZxAOS9SXcErw1q+9o4OTndBgKJ2tmUG?=
 =?us-ascii?Q?aI7KWULER9VN4/dObEF3xf1wR4j/J9QYJV449Jrhw25hRZTi1862HTE1gYxE?=
 =?us-ascii?Q?x54v8gHzCMx+3OJfKCPgiFiOHcc6L5bhJv9ZkCScO/O09MgiXQwKukipI2xp?=
 =?us-ascii?Q?xTZfXHD5xI8LkfnSif5q8+rRmcWAxRZjARLnm9qyzuomKNeBQlsrDB74towf?=
 =?us-ascii?Q?kpz8m/SneA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	r5gq0obmG3lfo0hVfik+HLywDCp6IvYsvnD2AFqoXByBMTYNlvan445u25fC1Yb1OMMEQSlYVfYtI79o6FzwmLWpYQBQCoxuw8MKVZumI+9zB+cR1vyb2Wp7G6POaiCH/CgZ42opgGpLQaYK6hAP+mbRuvODWiLtvKr/1HwlS37ZPgaeuSLeMoIwLkOpFxpWZDC6/KMH5OE6aigfHu9KBUDpJGi2oLNq0fPq9tyCBtT17nvotIyzP8gIsQA3BPSQuD26m1c1JYFOaC30L5vcasw8JxytiX2wvLEJpFuPuf+lgCPQd7JBxabhxv2lrLkQHwxL0xyUwkGhZnghKh8NDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hoi/y7ak1N9E/YuvYpu7zxBd0lcYY7Y6JgIrgw/s1XAonW0ZhuxAaHvW7GuqWC7BwKoesVrFlw78lhL21mX3XUdmEImvbmNjfFAEgB0DmY7EIr4PzmtEelhRtYQrhhLUZha0GICm7yQCaMg9gkHJ1Ge5pZtY2X1b7FD8TPx1VLG34j3ygel0l34a/MLLCR678BxnHSkUxTrcXJIClvSCESNWVdTH3ZLb5afoDxMU3zDUPnq1cvL50SZEd/Zyejg5D04wkB4m2rL5R0wmwXNoTUaUgmDWXjclTgaEIH4M4G2tL9+v5WLOgyKTjgr5n59LGR45WuGTzrhDxrz3M2NCmqqQex5n8ONCvQPpwxKEoMYizW/vji6UtNTn+vVh2WA1D25EtxDLfSOf/TQZEUKLWt1nV2om6wDVjyY7ikwLnWSHeAjOYPaiXl+tIeoZeRq7EnyF0doWbrtP2LvYGbpzXGAmKh2cJw474oxZxVcIcDgDw45WuKFXNPuI/GxYGtOmCWLxVF6paIMyM7H477fbmOLeKVnOxa/LKtuWXmgmaiUIT69SGdPiOFT9WXfmJ6OwQnvjQcjKHbtzZ4gY4mJhjLscHeojjGbWz0WdZ33hUSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd4630-da58-43c5-9b8e-08de7b3ca7cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 04:55:57.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ98MHH/tUh3xZpk23Qb6Bg/OnpW7Lr+vidbJPOYH2KlbX/a40pWNMc01k8X+ZHd8kRXGBPP6xaeEk6Mk6YhSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060044
X-Authority-Analysis: v=2.4 cv=O7w0fR9W c=1 sm=1 tr=0 ts=69aa5e60 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=errNbg_PrlJTq5nbWgkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NZfk_ch4Whm9WFXQOKuceHUlm2nNOjFf
X-Proofpoint-ORIG-GUID: NZfk_ch4Whm9WFXQOKuceHUlm2nNOjFf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA0NSBTYWx0ZWRfX3jtYoB+74QfX
 SCmRMkphqX4eGYe5e06c3snLZunL3kPg5vNaH2ZVlFg1xS4y4rAyU9SGL8Lqxbyh+qTSe5zK+Ml
 lKCiV4VNS8H1L6JWgaKfZcPddprDA7i/RmD7pNiWpuwGybORa49ocqY3ak/0HWN+sLLOSSIGmWi
 Z0vohC/Ql7vtnG1TiavgCp5mn/sznaxmVbLy8i4P8ruE43hODLTkecM+zQNhRwsipIcAtbBcsrv
 VQ47Z7y7y2CPF74KyraqDkzk4iO0JOfA4Ov0sJGrjIXRtKoTghNP9bGaFxJm5pj+z0DSoUMyUMq
 MffclN2FTAxFNpzzye1tmKr7M5L/uam7thLs9kq4v8NV2kPeSTTMcd9uFwCdWkDKqcdCnhynG16
 /VwdgD35Rq5ZRYWvKHcsg8B1x8Ug7CYJYptno0AgoCkowweUyXfKWLmg/6mD1/2FDybdhvDK0ei
 LHuOFlrXY+sIyzcRagQ==

On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/25/26 10:31, Ming Lei wrote:
> > Hi Vlastimil,
> > 
> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> >> > 
> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> >> > didn't anticipate this interaction with mempools. We could change them
> >> > but there might be others using a similar pattern. Maybe it would be for
> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> >> > (but carefully as some deadlock avoidance depends on it, we might need
> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> >> Could you try this then, please? Thanks!
> > 
> > Thanks for working on this issue!
> > 
> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> 
> what about this patch in addition to the previous one? Thanks.
> 
> ----8<----
> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> Date: Thu, 26 Feb 2026 18:59:56 +0100
> Subject: [PATCH] mm/slab: put barn on every online node
> 
> Including memoryless nodes.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Just taking a quick grasp...

> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>  		return;
>  
> -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> +			|| !node_isset(slab_nid(slab), slab_nodes))

I think you intended !node_isset(numa_mem_id(), slab_nodes)?

"Skip freeing to pcs if it's remote free, but memoryless nodes is
 an exception".

>  	    && likely(!slab_test_pfmemalloc(slab))) {
>  		if (likely(free_to_pcs(s, object, true)))
>  			return;

-- 
Cheers,
Harry / Hyeonggon
