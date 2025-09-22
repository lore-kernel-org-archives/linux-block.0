Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20DD203706
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532956; cv=fail; b=X6dBFz8dfi2Ro8MhyAh+FG9MkY1SyWo/RFREcV7WKOrfPCpjBTr16eezfLLhVz336JrscY7ItSQikkD73CHMMxA/aCY64jms3ryaWVZpZCCW6QxhSK6Af3lKvYYb+GC7CB7mBNV1OkR5Fu+QnDedmulwHzWrOupkcU2EAnCWs4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532956; c=relaxed/simple;
	bh=PQxlxOmHB6+BuiW2MluezNI2469BAlTUL2bpmGp+aD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cgjiQ1lvHd+kaMty2gDPy9lFKiCbmHmJHNXmyuh0DWg6utDNseGZ3fIH1UpyKZt9Mp4nW6jlPKPUJjVc3nIk0m55CttAmowttI3j2IfLMBNEVvBTF4dqbWE2EmXR2EeEn7FH9vMQ/osxRfE56Mh/9gKpMxbMbXXpFkuWMbge8tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r+Fhw6eA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uz0D4bmx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r+Fhw6eA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uz0D4bmx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7N1Wj030925;
	Mon, 22 Sep 2025 09:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IxOwJwi+9LOrGveFIaKJ7AP2VOzmi7F0KtmNoIkAxY0=; b=
	r+Fhw6eAVpbzwmrMwhdhPwN2pGplw1eUY9OTbdr/WCy7WO7kSXhBWtDcNhN2hGSn
	HkZHP/mDVvd21xaa46KVClaAxY7KtGRYC9mSGQDAnKkpkj3yxSp6yAf7cTvQHyTm
	DYLUSTKxzH142fujXLwKCJFoqWqD8t0TqEZnkaScDOunAuP9mSo2b6zZNYbubs5e
	VRDYvoIZr+sdoBdPi6MLpZW76CSJFPjEzr+a+Q7Ov7FZRP7S00jXdQUeNJgjo9Oz
	vpssTUw74MrB3EaUsKqI1XlbXrrkY3/Vz6k9X2g2hsHGTGM2W/YuEXacxopeuRKS
	5mYluRwlKB15UE2xhdEFoQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt1ygk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 09:22:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7jGWG034396;
	Mon, 22 Sep 2025 09:22:23 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nh240v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 09:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ1iH21kF8rGVyiXdtfGt6oEY37EgIaloxurl1a/sOiR9klryj4mOXYhoPQ1fCUfXOS+YO8cRDRlumW4EbH0+eev1ihmHfsGj7DzFH2S2/QCyz4aeI1Ql1tOWiFZ33/VQPuZTMlKCzsPMtXvnHGU6mM2mEIw8IBbXSfIEnOgp/q7xMn/fGuA97vSQf/wiMniTTCJXmZRIZRICjR0uSYr5CSyI+CjWQVPlaz8dtIRPqmI67VGb0kuEgr1PqKh8XcBw4MmscQBulVxP1n1+VJmd3/k27Ze5y21OZPCZ+US6b7doB3oJl2wI2GxFa2k4Jn0O7wjiPghiUc9MEzb4QPWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxOwJwi+9LOrGveFIaKJ7AP2VOzmi7F0KtmNoIkAxY0=;
 b=xNRxZfq+syMR0OI5ksWSkRGpnlcvXRPzClbKLmSfsSAOpEq8wT9xEurgDIHcZr55SJ7S1Rxfy60DUuRSjFmLOHzecixXR3LTik0H1BfW4vestw9neBm2/nC3EmDp8iRD6tDOXDMz/PCf3R2oceQlu72dFfL7NQUiJBFYraCgMNtWilJUEh4Ei/IucSmKeb31COB9EaguA7fByNr5sxFjjNSBLuZ5W9TFlaEtSruqFg2PMRC3klriQNYDaf9Bmegk9CE2VJ0JSWMjCKusqtGhXppb657hkCA8Jq/lMXN7HVGEqs66ZowosRdvTKycC3/WVBee9uFfPKgHVAql19VbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxOwJwi+9LOrGveFIaKJ7AP2VOzmi7F0KtmNoIkAxY0=;
 b=uz0D4bmxdBix40bfmQ+Vpe6fdYLBBhZp8jsxZ5+uDlhso6mp8e49kIWeYIJNYkACJB4MiTje6o8BCl58uHkxL8XQ8MoHgH4joOXIeyQ2WdlRwTXMji4m/v4IyQMdCGX5s93GsSUcRU6ZoGCwM5KabG8VwETDsYqd9ADMyTlSvr0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MW4PR10MB6536.namprd10.prod.outlook.com (2603:10b6:303:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 22 Sep
 2025 09:22:20 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 09:22:19 +0000
Message-ID: <20ea1cd0-b829-4893-98db-6e3773fec172@oracle.com>
Date: Mon, 22 Sep 2025 10:22:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/5] support testing with multiple devices
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MW4PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbd5cd7-d73f-41b1-e2b5-08ddf9b9878b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFtZ2krdzZoNHVxeTliT0hKZjRYVnRXR25MeFpPSVVjckFSUHJHUXZJcWdI?=
 =?utf-8?B?c0JlMmQ3QVpPcmptN3hyLyt1b2lpS1lsSk9sQ1cvTTdGc092bEFSYjAvM1px?=
 =?utf-8?B?SEJiMDBmUFpOU1ZnT2hZa1E0Nm9RaWFCZklhZWpVWi9QUjdrYmduSUg3d09j?=
 =?utf-8?B?eDI2bW1GcHhYb2x0ZlY2dEhWTHlVMlVrcHdZUmYwUHhYQkNMeDNBM1owemFX?=
 =?utf-8?B?aVF2NVp5M0Fua0FWaE9pRkY2RzJjUWVmc05kVVJUTDl1aHNZaGlsbWlKYzNo?=
 =?utf-8?B?eXgrZm5xSVp6MU5iQnJsbzlCc1MzRzMvWXNFZFdQY2t4Ylk2bjIrYk42Yk4z?=
 =?utf-8?B?SUdMSDBSSlhsUGhMcXlNeVkyNm1rT21JRDNmTmtBMjd4RjlseG1wakdKVGZK?=
 =?utf-8?B?N1lJMGdlZ0hxMDdLd21vL1dMQ0hpWEt1QXNERFI4NkVrK2xLeEhYYk5TSGQr?=
 =?utf-8?B?NGwyUkthSjhjcUJLYnIyRS8wY1NkYm0za2o0VHZIcCtzMkVjYTNNNDZPZHRJ?=
 =?utf-8?B?MlRiR3BheGdwb0pCcG5wZUZxbGFJZ1d6TzhWMjVYcWhsU2dvNDZPanVwOERz?=
 =?utf-8?B?b3RkNEFscXhoV0ZJS0N6eTdqUHFpbXBhNjEwS0JWb0pVbGhTbzZtVlBPMkMw?=
 =?utf-8?B?ZFQvZmlRcWtEMENmUFJhRUVxZ2wzZEZ2ek5McHhQTmRPVm1kTmIwRjNXZGc1?=
 =?utf-8?B?NlMrVFNsYUdFTEZGWDFHV3daWEgrd21Idk1QYk5EUXYzMFJuNmVNQUR0TXRZ?=
 =?utf-8?B?WEtZa3IxakNGKzNqRkJFeE5wblZVd2ttczVYWW9rSU92b0ZHeDBTYWtuSi90?=
 =?utf-8?B?eGptTlZVZGF5SU9GM1JTVC9ZWFVEUE5QYzduVnRwbXl1QzI1ZEh6ZXpnRENi?=
 =?utf-8?B?TE9yUzVJc0tUeGNTdGxxdExHYXJFL3lIeGgrZGFQOUhER2pEdDlvODdLd1h6?=
 =?utf-8?B?QW1saElMMFZYS2hjZWJpaDB4TU9UOGRBWlBCRUNESkdBNW5wNHFhN1BXN2gz?=
 =?utf-8?B?Y0hJUnN3djRiNngrSVVGbWJKMXo5OGZXWHIxNmxSaTFVMmY4dmRVMUZFdTEv?=
 =?utf-8?B?citUYjQzakk1dHlxSHpJcStwU1J4YzVCazNhZlRjTmV2M2ZCYko5TXRyZGU1?=
 =?utf-8?B?MjJSbWVFSFlwaURzZFdKN0xEUkFIb3hoUFlXOFZzd3ZwZ1VpRnBndFBqUE50?=
 =?utf-8?B?ZjBBdG1EbTd4U1J3T3dKbWhSd0tKZTVZbHZsQkRZdjRUeDV5RVdNVTRiU09E?=
 =?utf-8?B?N1JZeXgvZ2creTArRi9zNTFaN1NpV1ptL3dWRlFSNy80L3ZNVmNXaENnMldG?=
 =?utf-8?B?TjdWMGVhSFpLR0pUWktraVJuRXBhNWNCbkVvd1laZWtWcEhIR2JSSXc3dG9t?=
 =?utf-8?B?Qngycmdpb09aVkVmRmNtOXBiMExzN25QWkNvRHMreEpycUkrN09sSDJieVdB?=
 =?utf-8?B?T2N5QjdvYWF6OXRpdE5LL0RQMHJvZXhPOG1CNmlsMjdaRUhqTGhNZEdWam5G?=
 =?utf-8?B?a0dSMUN4ejc1MmpaU2t5eDE0d1Jsa08xeEI0NjhvSUUzbmhrV00wT1NyMTdD?=
 =?utf-8?B?V3h2aDVabDduVVFUUEZqN3pYQWNJYk9iZ3R6MWpMMUlhK3BHQmd2ZVBuYWFv?=
 =?utf-8?B?V3NFRjR5ZFh2eVVVWDdSRUFZUjRIaHlwb0Z6ZTQvQ3JROGZRUFRNN2oxNHFk?=
 =?utf-8?B?TlJNVFAwRW1ISlJjbmg2bldjNnlwQ1JtNm4zVU9TZmNncXo1dG5NbnZ6WVRB?=
 =?utf-8?B?a3lIRlpaeTZ2Ymd4MEZFQlpaMi9NK2hJazg4YmJCUjVTWEhlQ1ovWWVQRWNz?=
 =?utf-8?Q?srr79wLKZZqw1DqRtn9W0o9E2xbaKud5CPKhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU1oTkNDdmkrKythZkR4TEM0WmNjUm41L3ZBYVZLaTBaTGNHb0JUVElQekN3?=
 =?utf-8?B?a3B0OXBpc01KMWNUM3NMNWorM1czZjE4RUxtSjA1WE03VUVhMzhwRGpNUm1O?=
 =?utf-8?B?U2ZKYThkdThJZThIZkF4bDRPV3I5ZmFkVE9TMW4yeWtRWnJJUmk1RTdxYzRW?=
 =?utf-8?B?TFRrRmIrZlhwME5IQzdSaDA0aC9YMTUwczdLaU15WVBFcFRGQ0w0RE5QaXVQ?=
 =?utf-8?B?SURKUWNQNkN6QzZQbFIvTjRHVk5sU24xdEoreURqV3BPKzkvVnBDQ1BDcDRq?=
 =?utf-8?B?YXA5cDFGQ1BEQzFvMzUveDlvYmRNVHZocWNKeGk3cU5veXp6dmlVZkxkUEh3?=
 =?utf-8?B?ckpyQ2JzTkI2K1dQdXVPRFBxeDNlODR0TWJKVWhQTHE2ZTZFQ1ZjdndJQ3BF?=
 =?utf-8?B?VUREZzFaZW1rbTF4bUxiSjRCTE95UG1CT2NwWHFMUXhJd0RTMHBnaUxFMmVz?=
 =?utf-8?B?S0FlYUJQQzNVTm5DL2lVVUtJWFo5Q1hzdERiMjU5a3JSM0hHOWtkWnE1SkRu?=
 =?utf-8?B?dHpkSGowUnRHSFlxKzhqUzhYalQvOTEyQXRKTVRIYmd4RGZnZTdwOWNZc2gv?=
 =?utf-8?B?STVCTWlJaVY5YWVxM3N4bDlva3NMSnh6VzYySEhLMDU2bTlOUGdPYVdlN2VG?=
 =?utf-8?B?VTFHVXdVdVZtK1VydS9WN0dIbStUMkVhSXE5RWdZaXdIK05yM1RoTnZURS9P?=
 =?utf-8?B?SDN4WDdCUjl1Vm5GcHUrVXAxSEkyMDNVVnBxR0NvOS92ZEZBMDZ5WlVkT210?=
 =?utf-8?B?bXpUY1VjdEdsbHIvV0p4L2wvMTdDekE4c2tCSUI2YnBIaEdQWTh6WHF1NkM5?=
 =?utf-8?B?S3BkcW5TQXNLVkM3Q2JBMDRsUHBETi95VWJhUndpR1NnUXB3TW12ODFJcy9z?=
 =?utf-8?B?U1IzT1VGVG5PZVhzN0JQNjc4VEZlRTByWFF3Y3dha2hWR0kvYkxaSjdxTHdZ?=
 =?utf-8?B?NXNaUU9EY1ZzK2RvaUZMWU5FWkdDOFNOTWw4TTRtTzRKdXhFNitPb2dwSGE1?=
 =?utf-8?B?YnYyRXpGQmt1bERSTWFiVmJJT1VmbGpCQkJuSUxKVWlNRk5pRHVyZ1o1WVJw?=
 =?utf-8?B?UGY4SUN4K28vVllZUno2NSt3ODZSWCs5TTdVUFNSelpWK0lldmMvSGxFZDRC?=
 =?utf-8?B?VE5NS2tJZTF0clB5QjBnN2xWQ0tKd0ZEZkRmMFE3L1lLSU5sZWRha0lxdWl3?=
 =?utf-8?B?N3JZTHZ5UkkwRnFXWlJJaVIxUzl2L1Q5RG9jRnlNSk0ydktNRDdkUVByS1pk?=
 =?utf-8?B?eWdDQ1FEZHJVemZrNjdwRTJTbzV6NGs5MTRuNU51cnlsdzNJdU9iTERsWFdS?=
 =?utf-8?B?WUJ5Y3JtUjFWUzBMUEtlcXp2dG9FODIyYmJqMS9PVS95TmxpLzVDUmE4cDJq?=
 =?utf-8?B?aS8rRW80cEs2UHZqYzNER0hmL3ZlRzREem9QQ1J5SnlYeG03OXAxaUs2ak0v?=
 =?utf-8?B?OG1PbU4xS3lNb1llVmtRWXJ5M2xkVEpBZ3JRcU4vV0JkZnhDOURURUdhVFls?=
 =?utf-8?B?UEFPWU8rUGV2MTFROG5SZlFwaUsyME1FOUJmcnlpMHdNR2VHNVFLa2FVRWNP?=
 =?utf-8?B?VVlZT1VYMjltZFBxcGwwcVVwYmNLa3JOdW8wQUlHZ0RSZW9rUWExTXl0dXZy?=
 =?utf-8?B?WFg3SUJ1SW12eHZLYjVsWmZUUjN0b1BYd0hhSHFYOEhVcjEwaFlRNFU0VWtW?=
 =?utf-8?B?Y3VudnVSMXhpU2gzdjg3MnRobHRFb2l2UTZXR3ZmWm9xaG0vZWFPZXN5cDhV?=
 =?utf-8?B?aXkwdkxUMWRjOFRxWGNBVlBVRG1EakNaRzhMQmFFZkc1aGJuaGZLbDRsUkdk?=
 =?utf-8?B?ZjFUbDdWN2UxOU96RE45eCtCc0FxWUU3RnltZTBrcHRjMXdueHFpQVFxdGVS?=
 =?utf-8?B?MEU2eVdBZjV1c2cvYUx2S25wK2ZFN2dGenNxK1E5c2RuYlBzN3BtS3JOVzhs?=
 =?utf-8?B?Q3FQUjQvUGVLUDA0UUxxL2syZkN1SDh1WVBBQzBDa1NERVZmOFNZS3RsWEls?=
 =?utf-8?B?R3k4anEyYVRNL3E1eDltMkhnYUwrS0ROdnBCVUl4TTBkWE1ZUXg5NUZWbXNG?=
 =?utf-8?B?V0hzQmRucUJLOThpN3BCSDh6WVBSbHFBb0VmV3EzQ3RIWG5jNFcySkIraUJK?=
 =?utf-8?Q?Ts2clcV6SD3OfGv6pd6Em6jA0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dx8A9Bm6OiqWuU3x3Rt7pTSx57Mlrov/stAUkiBPe4z0Bjzz7JDvh9IHEpPasGK1atG853QMXT9WJCMyuqb288HqRkvcx3eQLPkw4Ae7QWKRm35M+g96/sRbOYGHPrsMlwK252EDKfvQEpPasdp+4hVhj9RmJNcM/yTXKSE9ptlw2DP7i84qQWfFJH0wgvREQMnxpstYo49F++EgpEKi5A5CtlSXyHhzF3IP/XqV27l93AJarVY5gWd22n85PYdx+Cob6adRx5eW5TBzRi+TSHozs8oOU0ER4l3zWFZa1WENTAEzPQGJZOOfpbfvG2hU20WTXjBC5NwGNT2tnfmR36VrE+QwnPIJA+6OYxStlmzoGUvrTTCgxpgBozzNQDAK2Qk5FQrxbuBV7i/sgIA8GH7cHnv8Q5SYQ1a6EZed3PFqnfRBmfo99kdv25oRSeIoDA5IweJyP8JMkrP3XAzba8L+aCUNKxBjK7fB8fN887YSwF8ceehcCmrWjpVv6U2BFsLL6d8aZ3G9OkS2E/XGY3GXe/GrkBrE2QSJ7OgEIITEqncw4peNoXCkxU0b+goNzgKUUxyum0zX5d3TMzY9XOPJT7oXTrB59JUR15envQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbd5cd7-d73f-41b1-e2b5-08ddf9b9878b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:22:19.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOE+PON8nC3Im5qDMLV/syE4+ZRBwIDW3PpnK7rvgCBJ9yex5y0ss7LcFEH2aPqJUGIIQXL73XDEo0wdAsO6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220090
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d11552 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=gVQD3Xurp0NWDxhEyRwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: wsHfWfDy8hYnh2iFXzw5ZNC3G9fhNQLa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX0HQLM7oGlwIC
 eaRJewc+qUgnrvxkXFWsRxyfY7+3WaOqgbUrJX2x5EhAkWuBJyxjW2LJMH9A47s11R9iZ9Z6tjE
 Q76u9WTCYsjsDGpHjm+qw5LsukqaiZalOLuhXBEGoEBa2G5wQ1v6Y7MYqPsJwsQUH/4BmGirD9n
 g59TeF/yPls4HDStblf5Xk8fnRFsMbw2nLQ6hqSut9fwNlSnbneMuei63q20YlcCIfB8VYkhUfJ
 Fng5Y/lJBqrmuao1xj4OXnGVYl5efP8YIOgIVaSfDzlgFcQ8EltkkpZBwjoDPg/ZtXKZrgT/IF1
 lY6iBVNYKvxQ3cLFWyECHoXBnUGX8jRW0zmsEZSOgfspeL2ovssfSkSb0syQQo2r3izIHeXxRnc
 DQ9MO9fbix8uY0sAwLpQWnosvHga7w==
X-Proofpoint-GUID: wsHfWfDy8hYnh2iFXzw5ZNC3G9fhNQLa

On 17/09/2025 12:49, Shin'ichiro Kawasaki wrote:
> As of today, each of blktests test cases implement test() or
> test_device(). When test() is implemented, the test case prepares test
> target device by itself. When test_device() is implemented, the test
> case is run for one of the device in TEST_DEVS that users prepare and
> define in the config file. In other words, blktests test cases can be
> run for single test device prepare by users.
> 
> However, it is being requested to support testing with multiple devices
> prepared by users [1]. This request was made for atomic write tests for
> md raid with four nvme devices. To run the test, users need to prepare
> four suitable nvme devices and specify them in the blktests config file.
> But blktests does not support such test with multiple devices.
> 
> [1]https://urldefense.com/v3/__https://lore.kernel.org/linux- 
> block/39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com/__;!! 
> ACWV5N9M2RV99hQ! 
> O4lNHvPitDYTOvRaxHr03riTQ61P7uIwJtikwxnyMpSratty2qpugydf6IBdlg4sDIJTADlI2qq-Egssy7yXrkzqlWVN$ 
> 
> To support testing with multiple devices, I propose to extend blktests
> framework. Currently, each test case is expected to implement test()
> if the test case prepares devices, or test_device() to run the test for
> the given single device. This series introduces another function
> test_device_array(). It also introduces an associative array
> TEST_CASE_DEV_ARRAY that users define in the config file. With this
> ,users can specify the multiple block devices that the test case with
> test_device_array() uses.
> 
> The first patch is a preparation patch. The second patch introduces the
> test_device_array() and the TEST_CASE_DEV_ARRAY. The third and the
> fourth patches update the documents accordingly. The fifth patch adds
> meta tests to confirm the functionality of the new feature.
> 
> As always, review comments will be appreciated. Thanks in advance.

Tested-by: John Garry <john.g.garry@oracle.com>
