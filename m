Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986E29D279
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809662; cv=fail; b=d6gUZb3uaWx8+mM2BFvlJE4tZQ96uN3ByuT/lV36qCkj//utBc3G7ngw6qLgMg8Dfpu7QkBuPFPYm02AjE1XqGuuMOVGbGXtxy4bhOrFOC7TdpUqslShM+i5oPyrsDEgKoMW2D+zn4i50PGAS4a0Y/sxyBvbsmNEaRxRp1lieQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809662; c=relaxed/simple;
	bh=6yVo9L3HksymUWcU5njK8hSqguH0KUTBrVriTViDQ7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jy3mC/u5rQcuc03V1kbs3ypES7+DdBq9M0nll+Ko+bnnhcwpbbxeXvQmaf9RCQLOF2kRUiVceoy06P000VkPUgN61SxvrIgEu5GFOOsP+MlEEB1qE+g8gyUeGIpiJjlzmZFG43g9DaW/Gt6TzPT+MGQvxwGvds8Qwhbs0pAsI50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F2yGF4j2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GIY/N053; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F2yGF4j2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GIY/N053"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtmH3032522;
	Thu, 25 Sep 2025 14:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6yVo9L3HksymUWcU5njK8hSqguH0KUTBrVriTViDQ7k=; b=
	F2yGF4j2BluSYojTWZeMGV+HfUYc2hxMuu88IZ+HtISXGmtCDzG1RYZYAkFf3Q+W
	fAsTPqJJAAd4oBXbXrrC4XRhbi/tUKSDxM9kmOPxapcW2NHXl6Ums91pJHl1M9WD
	A1X6hAGmOPqAnHG5+YABBZewBpHSf8FmqsGL4XNmGmiMpxfRWS9X2tpkqRwe+rny
	OA4yPMarV5eURLwbQSgF6DVC2cDYiV+VaYUzxsw6G+/vUrFAN8g1wfbn6wuClfWB
	itoez+QImMUsqJZkyGH0KuB+C7aW4/zQvrdi/zQJkuGZQyNdvp7THLYVPrNLYpMU
	gvhm0LKsC1E0xrNTWawOQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdsydc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 14:14:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCrSFw030402;
	Thu, 25 Sep 2025 14:14:17 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqbach8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 14:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi68qQEYfXa+N+xzAel7aFqwsWS0YXvG4jxue76aiSouFikrlEulVXMF88DjYKXH/rDgf1gOL4yTXJm9/MGRJxKvuX9iltBS1wk2v93co6F1bWpGEADWCAfN77iDmPO6y63gU3/YIvQQH3m2uTDwBcVlelY5AKC2VyyJPg1h3o5aXVI1ihA5gentY7IU0RWlu0Uobv0tcc85LxmSD/FCWBC23IVVNXdF4nF9sS9N/+0ZFWS7A7uO1NKXelPxQ1h5Y6hXu5JRD+o3GlZPkM01Ftwj7iCoPn4srQct4p84APVX58hsg65u59BAO5N+8jERsMzU+sRmBnLvexGfhojOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yVo9L3HksymUWcU5njK8hSqguH0KUTBrVriTViDQ7k=;
 b=A/8Y4P8cIQC7n7HmuEN6WrF/GTajkTANgJYo0w5WWpj/yP2jxkkpJ8fSHam5k4d2KSnfNYeCC/hhB5S1Z1UmQMfHlrv1jUSKxUCD+lTkkc3PpRBL7zmqkXTqOu8WtoqgP308QHOFJ0lAG0fCVUvQPSYuJcZxpt5nePRfaUPRNhMLi1aqrrc9YymCvbnZdu9LOy6IXdHArvLvqbYEzQg9fn2wMJqUEU0O0bZlE9+VGiMTXgSHY+um+8YqdbmBNyn63Z9trsUWhhTZ0bnuf9TVcYenvN/kyv41nDrTqBmThcIpIPeKNeO6WyVwPCpgHE/XijwmCsTW8lH5PmeyogN02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yVo9L3HksymUWcU5njK8hSqguH0KUTBrVriTViDQ7k=;
 b=GIY/N053EEDuNZqwBPDQgFluQot4s4kEnefklb0BX22sNFltmzoFtalnKtd3O9BLnyMUZrwuBkzPt0VvUrUHy+w9SPGR+/liwmJlhYTnxXR3AGrM+LJ67A86OcVbr2a46G/smETAtOlfLC0ck6Ci62C/zbVbHM33oh9fH47JUo0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5997.namprd10.prod.outlook.com (2603:10b6:8:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 14:14:14 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 25 Sep 2025
 14:14:13 +0000
Message-ID: <1a108930-59b8-4055-a065-25ce8ede25be@oracle.com>
Date: Thu, 25 Sep 2025 15:14:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 6/9] md/003: add NVMe atomic write tests for
 stacked devices
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <20250922102433.1586402-7-john.g.garry@oracle.com>
 <zz4lnyno7yejb33tqqi3vpjbvlvj6nceqciclicrkbqaqwt6oq@nyu7dz7xpwaq>
 <5d9a2005-93cb-47b3-a708-e0db50328142@oracle.com>
 <mlkg5dr4ipq5722ye5owxppp7t7drkvcnijcinsryc2fe4t3y6@n7e4l5hc5zo7>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <mlkg5dr4ipq5722ye5owxppp7t7drkvcnijcinsryc2fe4t3y6@n7e4l5hc5zo7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: f93c1b89-45b8-4d3c-b8b9-08ddfc3dcdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9OaHFveVJZWlA3YjhVSDB6MCs1UDY5OUNjdnI3T0tyeGtUSWNJVmpuNURK?=
 =?utf-8?B?cGJOaWYyektzL2dmVUQyTTllZXpnVW1PalVOOUkrcmJ3aWlzdC9zcmhDdjRT?=
 =?utf-8?B?Q0FVQUE4Um9EZjZEKzMzNnNwUVUreFVjZE9ndit3YU1pa0JSWW1ScVI4NTZH?=
 =?utf-8?B?eVBkbk84Wk81VjJsKzF5a29zL21nazljMkVyOWJ0REFSa2VIR2l3OVd0WThu?=
 =?utf-8?B?cHByZzhyeHhpSUVVcWRIV3Jyd1hISkdTNEN1ZlZzNndnaFR3NVZlVjY4em5P?=
 =?utf-8?B?VkxRYVlIZ3h6MjgyMFEveTc1MWRZeURIamxMTWxBQy9KOFlVTis5WkdVUXo1?=
 =?utf-8?B?cUdWOXBOSStFODhDTVEvbEhNR0lMSE1VUjlkVjdJemgxOFhvWlQ0SXUxN2JV?=
 =?utf-8?B?VDFjbmdpSEZ0QjZPUEhLbU5DSWMwM09lWWlYSkwxTlNwcW4zTjVlZDdKVklW?=
 =?utf-8?B?Um4xVGtUSUxFU3dZM2dDajZnV3lldmNoeTJmN2RKaDZ5MnRpMUFtYWdqcXVs?=
 =?utf-8?B?elpGSXh6L1lOYjl4bXFsMzQ2ZVlEdDQyd3hRWHg5c1NVK24yYnM5LzlDMFlR?=
 =?utf-8?B?YzhjeHcwc0VBdzVHS1NaV0RpNW1HUXBGVVJtZ2hld3VzeVdSQ0wvNTdCQndl?=
 =?utf-8?B?K0lLdWJUL0JiMmFrWVFIVDBva2lOL3NuR28xdzVEQTBsdE93RDNvMVduTGFi?=
 =?utf-8?B?L0tucGJZb1lUMTdaT05nSDYzMGNFaWNjOEFuOC95VExaUlFoM0V3VWhCWDFk?=
 =?utf-8?B?dDcrZmR0VmRXYzRFL05NeTVmdFE2MWFrWFVFNERRV2J2YjRDVEMzY3MvTG5C?=
 =?utf-8?B?bE9zdXpMZkJNNDZBMVJRK1VQOUsyQXdvVlNEMWFGV0Y5bnVJQUdSei9jdFNM?=
 =?utf-8?B?MnhxZlJWdXRiS3VGeVV2R21OanVla2RZam1najJjMmhscTN0Ti83WGhXdEM4?=
 =?utf-8?B?cFplWnpWWEF6ODlYWXp1NWxDZHdQSFNmdHNTNVloaVFINVJDckI4dEVxSkR1?=
 =?utf-8?B?SHVHTWhEKzUvSkdXZHl6cDdtRGh5QnJrN1hiQVBXVThZcTZqWkROdmNQRGJU?=
 =?utf-8?B?YkJySXhpY0tlanQ1M0R3Sm5FTlhIMXAvSmtKRG9pczFkb1ZmRnhwSXgrNFUr?=
 =?utf-8?B?aDhtZkI3bkE1MEVrbzJ6dHNJOHFqRHFJU2ttVWpuaFh5dDIzK0diYVpzdHVB?=
 =?utf-8?B?Rkt3OEZvYVVSUnRHNWJqSm1mMStLQTF1TDQvUEZacVRvNGFZb3JvaVNkVFJM?=
 =?utf-8?B?aU9sUmY2SGx1NWpNN2dkcm1TMlB0NWZHcmZqV1laUHJTSEJtWWZqV293Z3BY?=
 =?utf-8?B?N05SZk1QMFhycVYzQUJ4NW5LUjQ2eGFVd2wzRTg3T2FQN2RlV002TTRYWjhw?=
 =?utf-8?B?NEM0KzA5YXZZNUU5MnlWVUdUQnhpeGg1VFFiMUw4RjY2RXI0UHVBRFlISFFB?=
 =?utf-8?B?UFgvV1hiWkZqcUJHMGNYOVFZTEdKNTJNMjNRMEN0SHcrQ3lMQnRjcnUrU2sx?=
 =?utf-8?B?K3hwTkFjRnVzUUp4VWxDZHRFQnZiK0dNR0YxdzRhRWRycjlRWVZPa2JHdlNN?=
 =?utf-8?B?cWtFL3JUKzhjeVJvcklXcjJMTTk4ZGlBUmt0Z04xUVVOaVNZUnpiRzRtZ2VF?=
 =?utf-8?B?K2lPRzFFOXZnbmMvaUdQd3VVbkRPYzlCUktuQ20yUkNMZnhKd1BmanBVN1hE?=
 =?utf-8?B?enFZUkFDdEJNb0JlWklET3YzUVcxZFZtVzBZS3hlN0ZPRWE3QkpyUkV2M2Np?=
 =?utf-8?B?VnBacnBwNXpZZ3NHaDRuYXR3cDZXaEpuVkFXY3AzZ040QmZHVm9jUGdYV2FY?=
 =?utf-8?B?T3NwVldMK01EdDlUQkwwYWpzSCt2V05oOUF0Zzdka2ptRlRBODFWT3VYYUxK?=
 =?utf-8?B?VWlhZXc2WTVOdGFuYUZNclFXSWpQS25sTUpFa2ZPaTZBZXpIbDdIUzdCTDAz?=
 =?utf-8?Q?6K5gtf/G/7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBJN0pncjE2T1ZRZnh6OWMwcnc2aitldDBpNkQveEM2NzFGNStyV20zMUpq?=
 =?utf-8?B?bTI3bGJ2eHlMRzBIaDJCUW52WjBrTDZRb00xc2RwZ0E0S1psY0FTWFNMNHRz?=
 =?utf-8?B?bU9rU3BDZVV1dFdPVVNuTXh5cEV0OGFXU2VTSTNLeWxDeXRpYWRCbE1RZGx3?=
 =?utf-8?B?Z1psVk5iMnYrM0phWkFDajNsL3hiVmRnL0ptbnd1YkRFelZZUWl3MHBBU1py?=
 =?utf-8?B?OHQ4Zm9hUk5ZTGVxMHFDNDFDNHdydGlBMW5kVC9UMjNSdWJiR2VDQ1R3V0ZT?=
 =?utf-8?B?NVJha0NSZytRbGREQ3M3a0s4ekRydWpvNTc5ckVSWlFDK1FxdC9qOUVKSWpt?=
 =?utf-8?B?MldMVWxndzRsZTBrZERVcEJPM0ptWlNoOHppR2lxdndCY1RIUVVsWHBpYnNE?=
 =?utf-8?B?MzFqNHYrYVlkeU5Yb0NMcEFoK240OWEzUTFOSzFqN0s2Q2NaUjhPaHZicjJq?=
 =?utf-8?B?Nnl1cE9LU2hScm1LSUpGcXRMaVI4R0kzY0Zpa1ZUemY3eGltZmJqajZ4RnYy?=
 =?utf-8?B?NXVDU0Y2NWxJVHhacDY0eVBWSU1Ta3RJQnJQTW5xRlBOdmhCbnQ2VlBIWHRK?=
 =?utf-8?B?K0NXZEdrd2JlaHZKNlIvdTkzSjFneEFsNnN0cVdTaVNFcEovZnZuV2d4R2lS?=
 =?utf-8?B?aU0xak9XenRHRDBjR1owSW5wWWhSSUozajA5RjJsS1c2WVJjbzF3V1lFdnEr?=
 =?utf-8?B?a3Bqc2lYNGlNT2lET0hPakRiYWFCQ2xyYnlvTG4xUnRFTnNvczZlUkFseDRW?=
 =?utf-8?B?d0M3ZzFaaVRlNnc5T0s1emg0MU44VEttL0MxMkx0T3o4bFpuUGl4Wkt4NXNv?=
 =?utf-8?B?T1hZeUNuNXQ0ZXVvcS9CMkJDOXUzbjdaYVl3NWlIQjBudk8vcFpFTWpQNita?=
 =?utf-8?B?cmtBWGh1c2o1cTZpb09zQVN3YjhKUXQ1WTI4dDMwYkhXcnJoUGpBck9vYjZM?=
 =?utf-8?B?NkJlZUxsWXprUHpOeGV4c2JlYTVpTmVVSGk1VVpraktPTy8zVTdjTlRQajd2?=
 =?utf-8?B?eEoxMnV4b3ltQ0xRQ25jNVZKakxhVVJUOUd2elVTYjJaOWFEbDFua0I0T1ht?=
 =?utf-8?B?ZHh1aHlPUjhoTFNmZCtvU2dIN3B1Z1o0aVhzRENEZC9Eb0JUcEtKZWVLT253?=
 =?utf-8?B?ckJaSUxxZ3pacVVwbXFmbWw2SjZ5bWNGd0hDNUxUS2pqYnd5V2xTRFRMeVR3?=
 =?utf-8?B?WjZHb2dmUmJQRS9HNHd5aEE2ZWxmWEFoNlNoMFMxblFZQjQzU0x0a0liWTFL?=
 =?utf-8?B?SjBSRlFMUEVMWkp4Zzg5bzZEaDBDNlc3YnpkTi9PVU1MOUdpZHZCRzM0WHg5?=
 =?utf-8?B?b0lObVF5R3pLeXo4SWVvcGZIRmoxVVU5UEtudkFUSnU5RTZxSGV3REJSMjEr?=
 =?utf-8?B?UngrZnZuWkhiVWxCcEEyTTZNVjJWNmdpb2MwVFVyY3R3UUlKSXE5ejdKS2VQ?=
 =?utf-8?B?YWRSa1BqenphNkNuR0QvK1k3YVcvcXRKbkRtdU11YnFLdC96VmdUcTFwT3JC?=
 =?utf-8?B?SHdVU2prTzJEN1BZdVI4emU0bVNXdVBBSjFGc1kvNmlZM1JMaEdaeEkvYnh2?=
 =?utf-8?B?WUFPOWZXMktLWFppSnkreW52QXVOdVF1N0dKUFlHTko1bGFTRnUxOVZJcWxL?=
 =?utf-8?B?QXpvSWRMUnFsYlpTSVU3MkoyTFB2VzVHdnRnams3MXREWWxXb2hiRE03SzU2?=
 =?utf-8?B?MnpPNDRNNGxKWkZ1NkowWm1KR09iRXNIM0lhWVY2dExIdHEva1BkWVBWUHZT?=
 =?utf-8?B?SlhKQVNBK3Njc204TWNLUU8xSjQ4ZHBSNlByQ3NRNXYxM1djbFY5U29HQkR1?=
 =?utf-8?B?cjRuUEpNY0RaWTVoMytTbzlhbVRoeHZtM0llU2dFZVpsS3E4OFZzcm82ZUJj?=
 =?utf-8?B?ODlSTDl1YlB0SHVQMFd6YXE4NUhNQ1R4UElPQXRZWlp1cndjTXIvWkFFZEZ4?=
 =?utf-8?B?aEQySE42d3g3NXdDejJCd3NjVUNOYWlNQkRONDFqNkhmSGlUcTRqcWhNUm0w?=
 =?utf-8?B?eVF6MER0T2F3Q01KNE42eGFJKzA5WElMVG51ZkNHRTl6V2RVUkJwZUYzV2ZO?=
 =?utf-8?B?dnJtb3VvZDJqM0ZBOTVoKzRYbzRNdDJQem4wTWUrSGxpT2FRaGNIWUJNR1Za?=
 =?utf-8?Q?ncpN0MqNa60tur+QjkQxgnSod?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sbgWfIJ83jXLAqJhFvx0+kwGp1T315Ubf1ci0yodtxUGP0feN12sIsNA2sorqbsnQtWK3ILjLS/GKmRu4ft/B/qE92Gqnl3IfyNgWucDg31hEkFNyf8mJGs4d6ONNSJ0xpZWljQF6PcX6erQXTOIBewJGGvb8rKVKyHQqqKYsh6eu7v9IrB/V7IqqGjY697NxndaOaclACGQuPueZTUZnmhye3BF10TH+CAMMfqloduoQoNszLS4G4lhkROOIFgSniTxxJBqzJFgswyD8xfWUvP7MG8yWbgQTnmlCjAJrLS87sShC8vsPtTeknjv4z7dXEd27FvodIuDeMIB93R1b6HiyxngUNb7IQIT4arblhk3Ct64WYLVxdfuGdjd1/tO1NaDo8IAcFHS5cm8xmsqHayq6F4mfJS4tBdOCpuCmQJhe6eKmKAjAwHMMJeke9aPglyY9gruYJXNUx9wKnbNBUAnR1v22MbBZ3rB40acjErhfjTJR5fpwXMBdIm24b69iBBL+KD0aPVd3MMREvSP+pxQZ4UYXuL8DPXO1kL4HAR5RutdJUC39SL3MVzrBuPhe0TL6hOffIgRrWvfZxZBu6GODezx9I3JT8YxAVTYQW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93c1b89-45b8-4d3c-b8b9-08ddfc3dcdf6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 14:14:13.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opvn+8FfZcQ8hrgjka2+IUy51P3E/K81Qb6qzkJDo29tEnKNkK1tRKlYnUoEzB+2qdqcQpeEr68KvVq14dusOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250133
X-Proofpoint-GUID: XfL2XfjLe153QMGI61lcP-4RHCckazMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfXwrI2z4dR8/7U
 SwdtE6NiI2345wIFkeLf5VVf+Zq0bZmEQpqKcJwkdIns1kgQxmpzd41IF5R/8jHijKd7hT7jJkY
 JT5XmU0+cGa/w3UJzxF3Wnh9VQKnCXoj1ebAYVRX123Dme6DacMwJGv2aQiRpYVlhWA75HXwOM0
 dLMWEQtusM2EYHdVj66JyCAA83K9MNE0HmMDodxb0TL/gjIg9OhYe0QcWHXJyNGHyO4cjkL47Mk
 BS9BfKyDMPSoyP9gFIFl4XK9TvNI97nEnsoRvcUyXicM963j/gJxSQTMVFsLXuR52JAJbeXAlPJ
 FcFhd2vcDeVQYFBg5Yzu6q44KF9dMM40d7HLNvhv3Nx2L/ARYRzpwCnfzL3SKsEoGDlxDcRiHPC
 VlxrFMOD
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d54e3a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=wLnMm4Wx_arEPKHHdKcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XfL2XfjLe153QMGI61lcP-4RHCckazMd

On 25/09/2025 15:12, Shinichiro Kawasaki wrote:
>> Let me know if you have a branch you want to test with all your changes.
> I did test runs using regular QEMU NVME devices, so I have some confidence that
> my changes are good. Your confirmation test on the current blktests master
> branch tip will be appreciated.

Will do today/tomorrow

thanks
