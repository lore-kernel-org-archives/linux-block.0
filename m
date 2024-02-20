Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B576C74
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449541; cv=fail; b=XHykiuc6w0ebw320XLK6+h7gPeQA+5NclK8Tl9L5wnwRlGxaP3rg0qbXyBSQqwpAxOpYBBA3leKNTUgIQKC47YsAn0/wxmAZmfvOU0Ng0t5yg3XyWlnTteB4Z320WKjK4XasY02W/ST9//YeysioG0fIsCYByqDf6o3qOqE5+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449541; c=relaxed/simple;
	bh=4NUPCKgDA2FIpMUlZNL7BujRnAJBAYGl8AmGj8XhZv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeU6X4tXJMBEeswXnqOHJvAZ3lsWwNVHJLLnCIVly0KZtbzKfbPXw5SubgLJX25zuzTQ4px8h0QrNqq4NobFW89Z0ChjWqLBZhTmDwXciTzGm4w9SRmzfc8WxbDBayEOrdTr4Dv6SGuW3AW1vpSL27UVT5XEECYzUpxvRtXaFko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QJedYgrD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vkdzp0XP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJedYgrD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vkdzp0XP"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe7xv027698;
	Tue, 20 Feb 2024 17:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UvufMR5fcJdxhp9jDYQiQVYxsOxm8OcU1IqzTh7st9w=;
 b=QJedYgrDX1/qtp4DA3gGssWg1egvmDFz7w0tsUtfIwo+2lLKiOdOCJppTK74TgjHzHvn
 ullP+9LXU0OnKzGeJWE1Gv/wwIvZUAdoqggJqDhOZTQqxmSLBkqaMj6qAexKgxs9fOOA
 KuYK4UKzSaFm3Fh0TV3VOnoApigkThPNIq69RhHf5dOXMpJWSAUcAJrg5Xpf0olfs9+r
 KN8w3yBhe0bGVoBDBtuAvUY6cER3rZd40ancSFh4O5UMvj7/ZjtcEzvdZvf+a+1Q0WEh
 Z3DEVBuppM8spj67QuYdd5PxoNO8236uwaLDEJKacmpyy38i7rAHHMtx2PHymu0S+Q7I HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucyd3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 17:18:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KGvs8h039660;
	Tue, 20 Feb 2024 17:18:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87m06d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 17:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDBBnPpCcbdtbTxdkohcErO5JP7FV6ErkIRU/utNPlBQWDCBsGEfC2DKHpqfha8ytxcIHJ9DWxKDGsZQ427jqaZtptx9XCzczTZcMYvmeU+jREkqZUIVcjFl0fslkLUrR+gp9tGgNl0+Rk+OOLjk+bLnS0TR2dlbt31uxFmoaaHC+1ir/20U8H2Y0/0F1P9DiTW3a+DiuDRG4JLJNkc1L8DaPZTYLX/9vIPrjrGXJAnHBlREgL2ucFKTWsxmtUgc4PKIH4cnQA5gj7YiXxDUxrwnBaFqxUFIq9x8ycsYFVryNCZ4c2f6BUFIDyfRoljSV+Uyi2bgHkXwQhe1WwzKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvufMR5fcJdxhp9jDYQiQVYxsOxm8OcU1IqzTh7st9w=;
 b=n4gpFqdw3TPRa1XvoouLvyVO6qv+fxgMH/jQzM4jIicrnk7j4fZuXZuWP05MB9SxnQA/KIgBF4Eux8DbywfAV5V1RQcg6q+jaF8GW02V7E+dvZduv2FqIQzU3xBC40Im0XA/tqA8R73eUgaMhw4l1I8KzfZu+doCQ0mBDLmA22rVDsLJicGBzsy0xqxqKSAA4DsXMXf7LIZ+d1qkaJ21NDk+Ez41Ptb8HwIYjD45uC+9ZdF/HPFpx9gYA0RC5vEjrnXhqscXN/LTEdOT1wjYIZ1Pt21UbLDXdaM+FL1k/Npd+9snHXZZdhRY6Yc2xsg7w8f8CmbcfK1FEsnTvLhX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvufMR5fcJdxhp9jDYQiQVYxsOxm8OcU1IqzTh7st9w=;
 b=vkdzp0XPIr646k2UMhn0xv35uNz67AuLw+a95pfHjMJ97bujsUeuHNLaVz8Gl/GEuUYiscHKSyOLkuti+yxRddf4x5ktTw8yTSmTIMmQ5HwAp2TifmnMa7nqOAuaMPsMvqLLyYkJwgLYdCVb7K+4BDGV30dw6Dq6j/TODO9t03k=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH3PR10MB7958.namprd10.prod.outlook.com (2603:10b6:610:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 17:18:51 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 17:18:51 +0000
Message-ID: <43de3ba2-84d8-46f5-9997-692ae113c17a@oracle.com>
Date: Tue, 20 Feb 2024 09:18:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme: Add passthru error logging tests to
 nvme/039
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240216233053.2795930-1-alan.adamson@oracle.com>
 <ja3ocox727qncqiyf3z5xvbg4a7h5jjr5w7rwqekixqf53dutp@i4h4pllexdyi>
From: alan.adamson@oracle.com
In-Reply-To: <ja3ocox727qncqiyf3z5xvbg4a7h5jjr5w7rwqekixqf53dutp@i4h4pllexdyi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CH3PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b28f657-bb84-4880-d850-08dc323801b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	m84AxPB2+XGgUhIhQFCkbiuP+Ld1Ij9yRM+0gNJwfb1f4ZCeWnrNW9fWHwn7eckS+6ZPv83zuEfjHoHfav6bQMi3DJzvbOeytcl6T7+f6ZTmpv83cYcoWyQk756jvLRX8XHRPyChuqZJ3cOTNELS9pvsOiTzQJfWQ2baBMymlJMJptOV979NidOP1+O2pUn+MSMtP/lBz7My/kOa2k90Hfcm6VpTt/cWzCjG36cJlIOeibQdWINR4rb8x1bcGNTj9cAhFyA32TCW4SgCSKvLk6L7iJukhInanxPPS35jqyCQ8/Zm0YCI6JfiBUZXi7ASZjSftgkWAcBsZjgKWVoXkuPyw0olVVRIjYU9Ep/BmdWbHZF9FTJzulpufVoCPfrav8NCtDcTHXnSdqRODUwKAK73JxkR3IO1Mug3KJcyfQnmNnIjHkTzgpP/6dyE5EU3NXyChAxFQ1k4uMmtNrLelJVKCCwwHszUejC8WPW/ixmTFaSQ2wZbwzdbkU31dKtI/wT6D2IIiPc/k/WuOXkWPdUxRXm80LHi9Z78b5hocts=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkgrTWxTOXpkOTkwbUFYL1NJVUxuQmVRLzloaS81ZzVUeTkzTjF1RlFCWDZP?=
 =?utf-8?B?dlczUWJKVW0yMFAyTVJ1SHVkSWY3SkdhN1JQa3N5OGFRNUJaRFpYRVo1QzU1?=
 =?utf-8?B?K0xveEdGNmFDUzA3ZkhGbSt4ckE4YjV4WUhsTk1Ya3h3YVV0S1lVU0tNbmJQ?=
 =?utf-8?B?VEFPeWZYYkNVc2t3RmRZSTEzVDloYlNwWXhnWWp3c3EyNm5jTWRockZLMlE2?=
 =?utf-8?B?Z0FzWkRTcDM4SzN0MXE2ODFwbG9tcnNXRjQ0eTE4d3hTZjI0TVNwYWdjWDJz?=
 =?utf-8?B?V1ZNdWIwcmRWeW93S3BBZkRER05YVVM1ZEEyYnVuenM1MXcxUUx0amRzZTlT?=
 =?utf-8?B?cGpOOGtXZzBrMkc1STZzMUlWR1NMdFlZMkM4bGlKSEtlMEVpREJuZ21qdE5m?=
 =?utf-8?B?S0xoSlV0Y3pmY1kyU0pwWVoreGVidWtXaWQrTE1Bck54dE5qYkZVdXBzTERF?=
 =?utf-8?B?U3A0S09YdmtneWo5MXEyZnRvcDNiQk1SNy9rR0NJS0crTXQxQUlPeVR0bjZD?=
 =?utf-8?B?dHQ3Z2RCaEVuSDdBWHRmdEZwSEV4K0dNWnZsS0Jnb05vY0plbllrRXIrQTdI?=
 =?utf-8?B?VlZBWTdpSzl6TWtnTlkxWTRFNUxZOWtCdnZIUTVlTHErQ2JXajZMODhuUFBl?=
 =?utf-8?B?S2praEZFbjk2SUJMOGFPRnNsU1RuMlp1SzI5a2ZYQVpRMWt2aTV6YnpLN2pS?=
 =?utf-8?B?QlB2Y29iMUp2SVhMc1UyT0RLSEhKNngvUFRsSTA1VENsbWtacEdrbFlkWHZD?=
 =?utf-8?B?TUdVdnIyQUxLWXRCNFpXS0cwRmc0RnBkODUxZnVPdWF6YXBsWFBZdW8raGpF?=
 =?utf-8?B?eVVjZkloVzVJUEVVTGp0eGJhSzlLSEtoR21JNnFuOGZXSUpMMTJ2TFEzNytw?=
 =?utf-8?B?QWJtTHk0TjhGRjdlQmRnTVQyZFppRkp2blNqdXRtTUZFYlExci8zc3c1ays3?=
 =?utf-8?B?R0NZZTZ2Vms4UzdCeitxRU1CalFMQmtTL3ZacVM1amkvM1NmVkszTWwvdGdY?=
 =?utf-8?B?anRacmFUZjUrQ1MwY0NsNUl0OGRpQWtlalloQW9saFpXcWNHSlVwMzQ4TW1D?=
 =?utf-8?B?VE82QWcyOThWZHJMV1BHclpTS1lJcHpBY1JOTVZsZWpVQ2lvdFE4eGNGQ2I4?=
 =?utf-8?B?U0VQZEU0VUNZRUllOE9temV4Q3pqM2Y5U1d0K0FrU0tFSnhiQkZGOHN4aXo3?=
 =?utf-8?B?V3hydklqUkVsUUlJb2M1OU51Vmg5QnVVdDFMTU5IenptVHhFVndJZ096UGxY?=
 =?utf-8?B?Nkt6VGsvYzhWZ24xT1kvQ2U4ZDYwbEdpQUpUQ05wMEZVWGptZ2FCRXNPcmhi?=
 =?utf-8?B?bWJDK28xY21jUzF3aFhGeGo4dzkyT1RYRHQzWFY1dmYyNXdaUUc2Y3JkaDZo?=
 =?utf-8?B?cVFnSHZ2YVY0NTM5a0hCNjdVclRyTXRBSnNnZ2pLRDNJTFlwdFRjbzVBcit5?=
 =?utf-8?B?Q0JCa0tDeDVTNm5Ccis5TlcxMkNhdzh4Rk1GZDVkQ2dnRHBhbzBNWStuemVj?=
 =?utf-8?B?SWlFYWhzcTRleG5nRTRsQjNIa3VKZ1lFN3BKR29ZMG92cmg3OWZJMS9ZUTFM?=
 =?utf-8?B?NEo1NmZmdFpQTTYyb1Jzdi9NZ2JERWQyWU03NFFJRjFJZnk4cjIxazEwdkRl?=
 =?utf-8?B?WklSWThWejdlRlpjVWIyQ2J6NExvTW1nbjcwNlg5N1BEMTJpQk8wYVpxc0kx?=
 =?utf-8?B?WnR2akxUWHRtbGZpUmtDc3puMGpPNEVWbGd3SFEzU05xY2JDczJIYzB6bWZ4?=
 =?utf-8?B?cVByVll1ckJuc0preW4rLzFERndaamR5MWdOcjNLdEtNdkpqOEVmczdJanND?=
 =?utf-8?B?NkUwWU4vaHFWeXVGcTJXenEwOXM0VTk2REN5ZnF6cnlyWkZ2cjh6ODI1MkY3?=
 =?utf-8?B?c1pJY09la016Mml0aTcxNVZDa2NXYy9hUFVyYm9CVzZLVVZDNllDQVFMMmpl?=
 =?utf-8?B?d1Z3bkY1c2FZVmtsdkNETzJxSnJxbEMydWtFdjRnbXFzZXNwcEdLd1F2bVVy?=
 =?utf-8?B?WWgrNzhOUWRveDdqWTQ0VzFRa1RJNXpEQnk5NlROZy9ySHpJWmN3R05FWWFR?=
 =?utf-8?B?UE5YRE5WUTcrZmZ2Qm1RemZ3ZTFBd2U4WE1vSG0vZUx2LzZNT0VJOVE2ZCsw?=
 =?utf-8?Q?N4py6tu0szO02C7tCg+hHjIbX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1BQErJD0zdEe9vliDkgIaSNIkWD5uMQ1n3SgahU/nJGVJNJIv6AsLAZaXJgtNOToCnIuOYmLhYPilgbwrZLc5anPK/MvkJH/ogCUXbLU1wxfo0CalNYZCF74ltcsi+snQuRnsZyj784DcB+z9zMqeAVZoXVENCGLewqZfBpViRItoCFjlfGkICsC0rDuF1Q/o4UCP18eT6X9al73YRFRl0e3xAkShiBXWnEkn2y7BlYKOxkXyLYl4gcblWCSGLlX3fpD/saqgYGrmBE7p+s3BNSSsGvab3m04NraufovG/pxImYH3d5ibuUByhT781chl1d3AACoqutEO8KL6F3U63vxNQRTBlaVjvcGI/LbgZ77qP/HHbAhlRuh7YeSGqIeQBVCvL0iTh7e2/LYo+voKEtdlXxB9t5JJ4qFfmVfFiRWoeeuLs9oaLVAYnJpKaM3S+ptrJV7PWFA4KHkLtsjwbW6zlO3nlYsubLx2C1zMIu796s41x1kNqCuFnJveUMWAtXllNBLa7zTicJ+e3pG6czOGzvyT6SvY4GShUb5zeqD3XNVpZSK1MNFzLYhMVI+0RQ5lJc0rT7uCAX6PaWreU5rRYyysnXOjsxGm0c9n0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b28f657-bb84-4880-d850-08dc323801b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:18:50.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e2tVXdl8AQBs28LRoTcDemTEoXbquNHXoCvRoDc7C0kjSJnNF+jzsEyjfvMlGQBmsGXsRn/qkx3FNiFBrt2Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200124
X-Proofpoint-GUID: 2pxRvFkt1vmyv13oH2wGLkBAYZNIIVrk
X-Proofpoint-ORIG-GUID: 2pxRvFkt1vmyv13oH2wGLkBAYZNIIVrk


On 2/19/24 12:06 AM, Shinichiro Kawasaki wrote:
> On Feb 16, 2024 / 15:30, Alan Adamson wrote:
>> Tests the ability to enable and disable error logging for passthru admin commands issued to
>> the controller and passthru IO commands issued to a namespace.
> Alan, thanks for the patch. Good to get the test coverage back.
>
> I applied the patch and ran nvme/039 for a QEMU nvme device on the kernel
> v6.8-rc5. Then I observed the failure below:
>
> ---------------------------------------------------------------------
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  5.308s  ...  5.318s
>      --- tests/nvme/039.out      2024-02-19 15:59:12.143488379 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2024-02-19 16:33:06.135840798 +0900
>      @@ -3,5 +3,4 @@
>        Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>        Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>        Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
>      - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0
>       Test complete
> ---------------------------------------------------------------------
>
Has to do with the nvme device having multiple namespaces.  I'll fix the 
test.


Thanks,

Alan

