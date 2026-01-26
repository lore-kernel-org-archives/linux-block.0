Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436930EF63
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432342; cv=fail; b=O5JfF2hS7Ivd6lMPhgyHRnaXegbtny+Wg7nuz49o9XKOYgPL8UZKECEh57Ejp5j8QTAiOPOvIHrjzTFE6eICaw2URLYn2QfB6DY1ndKZ/jUXkoF3su7uQYm8ycEVBqeiBsHOckA+DAUWvv5QsEJs1MHkDAnSi1RVGdLr4TZPFmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432342; c=relaxed/simple;
	bh=CIJc2Cl6894tKEY3Aobmt1RDCC4IXp2nEPpT2UmSJpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwzoUbgh9NyWVFZngviImbTDNPCq0kLuCprSlog3ib6dzeASy4dr/IOsHGfoXEzFqpvkPokwA7aIWbGt/QCCztPDqtsoIcIaD4ZtbSJ2m5+LbAhOzDboRzXVS4nHJYGw+sS+inRr2/6z7nfGetLvPghZoA7zvqkOetNSUymSonU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rcuAU0y9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QzM9O3jS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rcuAU0y9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QzM9O3jS"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q0HO4v463820;
	Mon, 26 Jan 2026 12:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PRbstHTmP7yxFDldgwXz2SJhtF9F4v0jcFhgT/tXgNQ=; b=
	rcuAU0y9+sgbkINPLQ//+6z9OONNoyXVXAR1oc6l7Ddzx4HG7wCEeHTW+/o5ufIR
	AJNq9NtpmQ9LLsAA9xW+1kqv4lDpRVDG1pHLwpd9ZKjHrone4Aie8wksIeieNGmb
	QRonvNtBEj4NNsXW5SKPyh8vACUi17oSGwaJ2OsZZwkI42PliWNTyocmgvpftqxO
	IkO2OofWMBA4KU9LPUyNkgE5tQmjpoP9ljg5rhDY4kRlEZUrSkZlDm2vyUg8dtw7
	xx4ISGKp9R25VPF9YDLOKwfOQ0u1wAeWQZYXQ1QisnXGu6UkyS5gDgsMHLEubFAF
	qLPpRw1AC3sCs9YFMgeIHg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbst0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 12:58:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QBgkxn010283;
	Mon, 26 Jan 2026 12:58:47 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7x4ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 12:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcVaXQUUrZ3l/qcl0SFcIl7WQIsqTE7umeRXy467OzUhx+fPi468E1BnVqN33wjnS27UxOLDdy0yULKv7ztV/AnEM0bEdWLQwDN1UDnhrP8lTE9hynxRZanLFASVR7K9u+wsfXziORh+nL7GtGVvzaIdrCrNlagmsdXEUFTJoJSFDda1GtM8V0ZVYUkF7F9wqpgHU6A7s97YJH4BVVSjqQNF+OrfL7IZt167UvHn9t+YJTch3Z2VCZkCxFYUj5aee+fONCWBwC0tBDsw7+v+1WYnKeNduNMKzzU6q/r9udAhEO9WBzIwAi1VjmSTK1yHEMt5X94xO8Qjd3MlBBpHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRbstHTmP7yxFDldgwXz2SJhtF9F4v0jcFhgT/tXgNQ=;
 b=o5B6uu9ez65aw0K+PTANBsWwIhFAV1tWzsuLouflWN1/+5U+EX90XKGHSCiDb+VR2Prl8DWCEi5sA0a0FaUcWTshMvHB8sGAXKX9BmxvxM6UCbBJWoyD8zINv+h5ziBXJc4WeELD1VdQ0rg9exjdz3gwuPJ+xAgEKLFsv4V75EUhWamqKB0Nn+iJk72Gpe8NEiSxx7r/ygtRtBlb9cW5iTiAhRTwrtEH4i+lYQLB8/T/SNwknqPWSw97jmpr1K7yFoQ5vav0Hrx7NXxEtn7jHVjUGssTf0C1iOEGjUGOg55kHZNHwuxAs7IZBnTjRRdRNTtFy4ve0bZlfKiHSxqOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRbstHTmP7yxFDldgwXz2SJhtF9F4v0jcFhgT/tXgNQ=;
 b=QzM9O3jSbgq8ne+oqmn9+CipC1h1BwQiyEioX/0IKkpZPsHpqe8fNnw12dmHc5mqZ4v344Fnk5TSsOSSC4IPX8a87T4R4BvEzquoQv4I1GIN9resrAHtRc8NX9HPl9ylQGYCDROg08sbD+0sSF2Rrc3DfuKPb683ZP4r5y/iWjU=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH0PR10MB4924.namprd10.prod.outlook.com
 (2603:10b6:610:ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 12:58:11 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 12:58:18 +0000
Message-ID: <4b946072-0071-49ad-a081-2a46b6cde48c@oracle.com>
Date: Mon, 26 Jan 2026 12:58:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
 <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
 <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
 <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
 <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
 <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com>
 <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
 <20260126125606.GC28035@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260126125606.GC28035@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH0PR10MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: ddee3916-82d5-4cd5-5eb5-08de5cda93b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTBNUFBka2V2MDhHejF3aFgzRjlyZWdacjR4RmxLTVJ3VVVGdGNGVC9RTlg3?=
 =?utf-8?B?MEhycXNxTVliaFNNcUR0Y1RUNEhwU2JZUEgxYkJ0RXZGVm5xellhV2lSaW5y?=
 =?utf-8?B?U3A5QWxPWDlmd3lNK2k2eU1UdVRtUlBYNnNva25GWmw0ZGRDYjY3V2ZuZ2Ri?=
 =?utf-8?B?UXFiM0NOV0ZxMWZ5cmJNTnNZd09ONnRxa2s1TUpOVGQxaGRTb1dqV0RhM2U1?=
 =?utf-8?B?QTFxdlh4eVExaEFKUEw0eHNpQjFscUJLdTQ2OEs4M29TMGhGNFVqYyttdVow?=
 =?utf-8?B?MTMwbE91SUNheUJKUHV2aG93UW1KUDVsa1hqSjNPQUhxNENEU0lIOGEwOXJM?=
 =?utf-8?B?SHUwekUrRmlHWk4yTWJocTJhYWRoQktYQ2IxQ2ZNYVd5ZHRSUXJzeHpRUXRU?=
 =?utf-8?B?eHpHdTJMeE1qZkZtQjI5UG5ZSG45S1RnajhPd2FWRmUwU0I4d3hUeTM0SnVS?=
 =?utf-8?B?dW1QaU4yNEU2b0Y1anF3NWs2K0pudU5ZbHcwcDZPeWpvVXQwLzJ0cm9YOE9s?=
 =?utf-8?B?RkJRRzZtN3ZsZ2VRT2NpR1JhTkVXR2VMTDlOZGFwNTZ6WW43YUtSczJxNjY5?=
 =?utf-8?B?OEVWVzQwb0pEZVJWOE1aajBhdHUydEpsOUpPWklGUm5LOG5XTXdkTkU4SlR3?=
 =?utf-8?B?SDdVT2xTQkVUUHBtMXZwdGwzQ2liSHdrQmJtUGttcWljUXlFRS80R3FTTWZK?=
 =?utf-8?B?eTRiYWFHMzh3aXE3Sy9HeXNQb1JSdzZEOE5iRzd6Q0F1dTVtQ3ZZaDlXTGZo?=
 =?utf-8?B?V2FySHVUSzE2NmdOdnozYnZMTitDRG1qNVQ3SXpIMmVCNDBPN0pQWXR3bTdt?=
 =?utf-8?B?Y2QxV2VvK3lXaTRWTmNpN2Vwc2VhcHpsNFJyakp4bHFoZzU2VlM4bWpnakx2?=
 =?utf-8?B?SFZtSm1aUUJNWHJKWndsMjF4bytJNEdZV3AzelA4MzNhODl2Nkh6cy9zc0c2?=
 =?utf-8?B?d0NjbU9tWFhzSU9NYnVpbCtKUUd5L0NzQUVYT0JZZTNOOEtSY3BhYllKN2Ja?=
 =?utf-8?B?OFhuOUoweWE3VGdZVVhvNFcwdDJBbWhDRnR1YnBJT3RQNkVWWFN0Yjc3aDAr?=
 =?utf-8?B?a2xtQzdUdVA2bW1wclFBNkNmYmxMMjRGUTV4VTRvV1Ntb2Nab2k2MjZyYmZG?=
 =?utf-8?B?dG44UmRWMXBVM1RDbUJEQnRYV3NGeUh6bEtIQTVpSXg2RlJ5ZXRYeC9yRjlk?=
 =?utf-8?B?clBPYjFSUDdtQkRaN1JZbUlMeXRPcGdGQ25pd1FXa1FmZEJVcVd5MDkwSVFw?=
 =?utf-8?B?ck1KTWoxeG9oRFMwRWJxdnhBRE1qeVlNa1ZwNFhMNEFBSGpSWmtCZjN1N2hl?=
 =?utf-8?B?VDRLQUJSNGZEbjhFbnpKdGlZNHk2RUNwaEQ5MlpML1AvMXJlVlA4MUsvNWd4?=
 =?utf-8?B?SWlqWnA0cXNGRGVmRk05UlE3Y0w3NGR2NnFXRStaVTZHVTFuSVRMNkNpSVZp?=
 =?utf-8?B?UHp6OGNnVnlvdy9XM2xUMmpNSXR1RXo4SVg2aHFIazRsa0tSVExydlJsM1dD?=
 =?utf-8?B?czNJUDUyRGFRbm85c2Mzb0tGaitMQjQzVkFCV3poYnRGZER4THVkRVhYWC9F?=
 =?utf-8?B?OFhoYStqRVhTaHVlUmEyWVhhVUIzL3RnUEFaSndnZDZzL2xWa0hza3VQTFF5?=
 =?utf-8?B?WDNzckRKNW9zWk94UjdpT3ZrY2JhVis5bVB3NWp1eU1NeWdzK0pNVjVBQmU3?=
 =?utf-8?B?eEVleXp1MHJrTDUvTDRjQ25XTWpzakJPY1dDMWVQMHJjekFscS9EZXdKNWlP?=
 =?utf-8?B?SkRjVEFDRTN0ekVpdUNCNUpURVhXY2tySEhUNXR2OHBHcDY0RTBadGJjYVBn?=
 =?utf-8?B?SlFPRHFKWlR3SmlhbnhiRDNWNmxBeEY2UHppME9ZZzBqa1JzdVp6eDdza3U5?=
 =?utf-8?B?QUxvaFh5YkNCVUQ3byt1Slc2eDJJdW43YklsenB1b1g5VGdlemlGK1FOUWZ0?=
 =?utf-8?B?NFRFNVo5ZEVtdjM4bHVyelE3cUJublAzaFMyS0t1RzB1OUN5c0pWd1cvL2RN?=
 =?utf-8?B?TUtDeTV4cU5WSkczVjRpaExFYkZCRlhDaURUbXBpVjAxMUwrQTI0a2JCMFpy?=
 =?utf-8?B?WWhBQVdGQVJ1TTFFMzNpRFhzaUxqN0daT1ZyRytQdzRSS1pNdTM4SWUxdnpM?=
 =?utf-8?Q?W2k8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2dOS0l4MUdrNFh5VFhEV0xacml2c3Njc2xPQUQ4YjB3SExTUTBRUG1FTFpi?=
 =?utf-8?B?aFZDaGx0NndJVHgzKzdiSU9PQkRFN00wR2ovbmp1a3htWG5jWkJMY2lhOXZL?=
 =?utf-8?B?TVcya1pBWU1iVk5YTENXL1ZJa3FoYWdLS01WVTl3YnBnUlJuS2lhRktOekFt?=
 =?utf-8?B?d0ZacHJQN01HSFQ1b3YzTEJBaFAvdXZUb1o4M1crQlBjZXVhbHYycG1FdW1S?=
 =?utf-8?B?dm5vS3FCWEp1N09PRk9wbkkwblVQOEkrZ2t2QlVTQnpPelhXT1hPREFtY1Bm?=
 =?utf-8?B?UHFibGhtVHlWLzVYQVRjRjNBU1JYd0F0TGZ6R0hKT0hRSVBSRFkzaDBCdUt2?=
 =?utf-8?B?eDFOajkvSE95TE9CMmMwYXJXR0FtMWtDUGdHK1htRVh3YWxyR3FhWXIyQ2sr?=
 =?utf-8?B?aWdVclJuTk9PZnk4N29URzkwdXk3TXhuaFkrSHI1MitWTmU3dW5rRnlQeTRY?=
 =?utf-8?B?SXpKVjVQU255T2Z3UUE1dTNDNXpkelV1Vk04RCtIekcxcThOaTdKMDdtMFdE?=
 =?utf-8?B?dFJPcmRoUFRiQm4yL0VwZ2owRmtaZDZyQmZ6ZFlhUHhZYTREb1pHcFpFZFpK?=
 =?utf-8?B?YmVpSytlbmc2dmRjeHVDNGwvbS8wSTJQbE1QVTFJdkRQNkRaV2k1Nk1QSWpJ?=
 =?utf-8?B?TFR4TEd3LzVUZjRpRlFLdEpac2dZNW9OMldmU05WU1graWZOTXI4NUpzL0pz?=
 =?utf-8?B?dVhsRVkvYzU2bHQrL2VhR1ZHVVZGSGlNc1hUZHlueFJPTWZOTUFDSWRkd2Zt?=
 =?utf-8?B?K3ZyeW9WOFVNK2pPd2wrc3Z2SC9JRDBrNFd2YnFWMzQzeGlWUmc2MGRYaUNH?=
 =?utf-8?B?Q01BMi9TU2dLeFpma2JDeWFIYmZmT3lzdHJFOTV3RmRieFN3VDI0ZkFad2Mr?=
 =?utf-8?B?SUxUd214L3JaZitNUzVVOFh4NU9EWE51ZWN6SmMyc2RwaVB0aTg3R2h5UFFJ?=
 =?utf-8?B?VUN2M1lablY5MkNhWk40ZVlhY2RQMTZJMUJQUERJWDQzdnhxZFp5SlhON2NM?=
 =?utf-8?B?V0NjQ2pQTi9mTjhxalB5cWZEYmlpUElwbXhvYTl3Q1NBazlHbmk4Yzhhdndx?=
 =?utf-8?B?WHVrcjRBL2VGN0xDRGJkQ2NXaUtwai9kd1hHOFVUVHQyNTdTNExNZTN3QW9r?=
 =?utf-8?B?RzFOQThjeDlXNTRYRTl2bCtVWG96UytPSHZMMHdxT2hBOVkxQXU4OUJMMm9z?=
 =?utf-8?B?emo3cWZQdFE0Z0lKUytPTUd4TWRuajBrUGV6SVJsRjJCUTdTVE1FTUFNZ3By?=
 =?utf-8?B?RVc0MDJ0b1Q4REhvYTk4ZEUxa2YzTEZsSzQyMDZaWm5WZmRybWN3Z0hNcGhi?=
 =?utf-8?B?QU1lOEE1K0JHZDJzUkcxWGxIL0NpNitlRWZuNk8zTFhrSmwraEZYalNqUVRn?=
 =?utf-8?B?Z2Z5aDBtTUNGb0hHOEo2Zm1WZUhXcUZ5S2ZUaXVYVVB6SWwycllxS0pOYktL?=
 =?utf-8?B?OXV2N3ZNOGlEcHZ5Uzg1UC9scEp0VjBPSXk2eWhCNkQvM2c3WTF2WUVOS0dt?=
 =?utf-8?B?b3Mzd3pNL0t5K1RSaDQ2aEx2ekJPWlFDYkpWWXZQRXBLM3paWXRVTU11b0tR?=
 =?utf-8?B?OEs0UkQzUzVkWk5IbUI5d2FpU0dCV3V5d3M5ampUVGpxdHVlcUFKM2p0RHBk?=
 =?utf-8?B?TmhoVk51T3NOc2FIRjVVcVI2MlFzdHE2M0t6MWtxWnMxbm1uaXBlNVVBSEg4?=
 =?utf-8?B?cndLbjlmYkI1ZFh1TWpETEp4TEVWbU9JSWVydFZjWER0V1hUdjBJTVY0dmk4?=
 =?utf-8?B?WlFvSVhRMjZGMk5WaVVDakRsVkZhYTV2QmpGdkp2UE01MGtrS1I1cStnT0p6?=
 =?utf-8?B?YkRWQ0h2OEZkVHVicWExSlFCNFRiUFROWXBIV0paQ1YwTzdjVFI4eGoyeXAr?=
 =?utf-8?B?YjFlZTJyNzBIbWlVSTRJQVkwWVZzTWxzY0s3VXpnMFJ5aDB0aXZDZHRxU2Zr?=
 =?utf-8?B?dUhyajdoNHJHN3krckxTQkRCMFV2VnJPbUNrWmg3N25vU0pPRmZzRlQxc012?=
 =?utf-8?B?ejlPUlBOb0tVNWM5ekgyV09TQnhFNk9ROTNaZVBCaUFGMU4vVnhSUlJNak1j?=
 =?utf-8?B?UEdyWXVUR0trdXdWS2tVOExKOTJCZUx0YTBpQUlaRGttRVkzbFZLOU9Bd0M1?=
 =?utf-8?B?UjR0Zmp5MkxuYzBaL3pEZFR5bGNSQVJCVmZkSFd2NHRWb3AvV1hWUVFnZTBh?=
 =?utf-8?B?bzZ5aml4VTNsWUowT1hYQXJYU3NPVExQTWlyVFROSEkraS8rcDh2L1ZNaFk0?=
 =?utf-8?B?TmJIa2s1eXo3YjRCaTkxSC92blB1MDBiMDlpNitpSVB6N2NpSzhBNURTd3N3?=
 =?utf-8?B?TzJVVUhOSCtoQklTV2xxa01pN3hNSFd6VnhSMGpoTkhIR2x4NWhWQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rVOCDb2VgDbpvajKL6Qa64AG4zcBsD4+6EeA9YBz0aBdzrVIymwV9mpspk/JqYLlaKaCfMMUJfJrz0gtnKVMAQN37PwuYtT0zpbz17OR8Qq0zAThpJWcmDQVMiz2gfjjMXPjIvXEZ6UeKukZPaG3d/0xFL+kMEDNU382l5ml237ID6O+E3dvkKjjAgF+nSPrMewIgaNnm8Ikart/bhyAMUTgwGvxbsSb1mzcfn3aEJLxh0anwEGcm9yNgwZS9wbD22eCj4/Enfwn/5faKpsPVsFl8FT9B1jx3Q+bW89brYxqqwBqPMs/SbThEjLZX7XF1GkWTkZDU6x2Hy5AluAJAYnbdvcXlR3LQDGiocPeWqmMrefhkPQp5yIO+WoLaKgTZGCNd++k4kFepuX8kSzpkOVawO3Z55Mr2kKn8Viw2A8DlYwQSRl43VXjpsVTu+c89TCobaJhP43CB3Vh0rCZgNgWMnF7f5IFzgiozirBwj0aoEtfpZgUOKpeeca53VVxmikCPiTg3Bcsv4Xf9/Uua2EZE8GijGvc2KK21kECXb8FYRA5SzcyHtcNuRyJJciHw4CQVW85snNrgDlFwf97Et/rLx4rykhTkzhXKttyDpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddee3916-82d5-4cd5-5eb5-08de5cda93b2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:58:18.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8YezI2b5Z5xltnaWDkKoAaODpaNvs8LJIIdBXGtA7byhCC96RYsfKrGfz/hcTmgBKEEwebHqCwAI2J8YNOljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260111
X-Proofpoint-ORIG-GUID: n260Iio3UwF58i7bIdR39Ca6XHfI4pg8
X-Proofpoint-GUID: n260Iio3UwF58i7bIdR39Ca6XHfI4pg8
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=69776508 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=w86aUFzp_bmzqCHwxXEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExMCBTYWx0ZWRfX6MpheRElHQbu
 V3VzT0ZVt4IP7lO9K2QLSc9m6Rvoe139oQTbeBaGpZrWg2PAink/DZsUIp+p7VhBxaPeG75wcqt
 gNob/9NmKacO28sUj6z5OrzEYoS0+vRff5Nl8zA6Oy+5F73ATvqSauIr+OpNVbGfGwum5gn8dPs
 lNHiLGSHBdEpOdJkxzQbY8Ple0ySq8sElabgz7LeSnd8jcchL0IDabijAapcoA5bJXhHxMzoono
 ls9OV2WOXNDAMJ8wKVj8Yg+628I2FTEwJxM9iqauIZQgcsvlRzwHfFEaS+3pz22rgJLFuyz2QyE
 Y0wIu8KVSaFj7R5+0uzCQM5UvYXZH2+DIVCC2Cm3HiNwQI8XNK/pltNkv/uSnmlOT1e1koGJkZu
 BflRK39j+uFTX0tQeOPpMAdQLgntVaRXgxKdxoBuSFz8TJtSY2eDkPjINsG8AsO5MdPra+xBvvJ
 kT2PHsrO2UaIqvCxNJA==

On 26/01/2026 12:56, Christoph Hellwig wrote:
>>> o AWUPF at the controller level.
>> Yeah, we can just stop using AWUPF always. Or can further consider my
>> proposed change to allow AWUPF to be used based on an opt-in, below.
>>
>> Keith, Christoph, Any further thoughts on this?
>>
>> https://lore.kernel.org/linux-nvme/20250820150220.1923826-1- 
>> john.g.garry@oracle.com/
> I'd love to drop support for the controller-level AWUPF.

Yeah, I was just going to send a patch for that.

cheers
