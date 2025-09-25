Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432D2868A9
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809613; cv=fail; b=nOkeBxWrLjNCeshBDpFEPkKJ4uOXSfKWdmFB0lc28znrn+6wr+ourGBuOoTrJUOzR5r3N5VTxFi+Ih+RrzDbKDxjncOItitTizImfIBxiBqKENcTAtVdlggX7QYUSKYyzgz2JUA0FvfN1fsnmpIj5ZmVZroo9muG3idBLKG/poY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809613; c=relaxed/simple;
	bh=L0A8PylnxGWEcPDcZJx4cZfea5evoTezk8Mr8vL3/uo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1JePzgqKdY1VV9zqcBZDuOUjNNklQEZzGP1YWGD2jMTD0bc0R8gKnZdEs0tyI+RsJuA3lhDOev8W1AK7BstQFRleQK1gNYAfhryiHLQrPW8T8gRhv/iu7cpNiRYCW8l0HHJMBNWtBZMzKL639DRuQfe6SmoUAHs3Htn0UFjHU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bpJ2EyUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ho5mszra; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpJ2EyUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ho5mszra"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtoUN024648;
	Thu, 25 Sep 2025 14:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oCW709ymV6O4Pz/qYATm0TmuJUeOHu+LTZGXPQtekSI=; b=
	bpJ2EyUxsyKfKIS+eVwPaUPJspEbFSux9WTadLFCGHZYLF0qeKCCyMqb7vNB1X5f
	vzQklGg4cPWU2Ww6ckL2YphkzjNuMl3/qtu7bhpZCY1g0mEkfy1zII9NNCpqaeBs
	mE+/IaSALMVQyddnp01jrMEA7jLeWUtXFQjVC/Jfwe/MwN2J9jsPLN2+J8KkckkN
	MDBjMdO5cN6N7RoByJnIwekdCzmCOymszFHyCLHLDJS/n3sgQ/0dxUZgd7PRBln2
	eNt0XWWjihcfSpc1KMke1oV12R3kM37/LcN7bYA+7Rgu7M17UUNV75LqQlcP6yJM
	1g8dSZc7GswjbtN/6sxozQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6b231e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 14:13:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCS8BV030415;
	Thu, 25 Sep 2025 14:13:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqbabfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 14:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVHy+8VRgKCmP5PfEw/XV333jQOYUNshmuu7eA2b2urJ+WBu04HEWUY6DYtfNGIRBLm8tyn+gBEoh0odAcmtCbTMyA+fTOvT+kXPpaIQuupfdICXI36t3KAVdw8lDuA3a1PfNfJaaf+N1ZiHa/zFYzc4tMMsqtnZM8ZhM+6oJxmcRXFt+IyniT0JiA8QzluCRzvBispN6ewMeKbol2MGp3C+Mfk52fM2TJOkByFCfOOk5e4VZiQPjCIDCdzkRews9iE866tZXgrzhDdpf/QY1V5rkwrnN80mJ1PReCo7G1uVwKqhdqpfF0EgbxIHMRdk0NpwWnMvQndYSkleBWC73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCW709ymV6O4Pz/qYATm0TmuJUeOHu+LTZGXPQtekSI=;
 b=knaWFS/hzFQwoKW2P4H6SOauDjWKNm9hb0hoP2NtxbGMnEPRdNSIdCOEOhdZoO+XSZtGl/8AqG8TWPeZA+DZSFecG1JIXJ1Z7NEu4K6JkqmjJ1kgmlznLYvlikYRJxx6C8kLdksZSyRNia5Zy+/kYGYMRdXH3pjaqie0dRdf4yrWxTzdWqC6k1kGh+By3tfcBlG7yZYaQwrxKxt8eiJ3QqGwwdjRDOE9pi3bW5g8/UpPbgL7p76n+WB30/sebaRymJSq4IGGPAHUIq8rGfy4MS/z05DWQJZdXs9bTL2zRuCqTmXvDCMVRkB2t2VqiOh5SS0wsghWMT5AksXfHjOmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCW709ymV6O4Pz/qYATm0TmuJUeOHu+LTZGXPQtekSI=;
 b=Ho5mszratJu+NLsOwYJIA7ygk37pQiuFyUHsNxOI7eQbDUR+oN040wjecownKW8guHVSecQqQeyE3v8jYsHpGMV1AfSGU4c/92QHZlCmpkm2lE17oWwc3dLWBtF9ZaaKhaGaiENm6mafXnSuaJHZN6pd/sDeDwSN2jg/55NuIjA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5997.namprd10.prod.outlook.com (2603:10b6:8:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 14:13:10 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 25 Sep 2025
 14:13:10 +0000
Message-ID: <e26d61dd-8048-4596-b33f-d7e048ba1cd7@oracle.com>
Date: Thu, 25 Sep 2025 15:13:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 0/9] Further stacked device atomic writes
 testing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
 <x5yy4lurvv3gc7hzxdj7psnfor77aq2u3aqrk3swq2jsgjjwrl@6siwo33qhpyz>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <x5yy4lurvv3gc7hzxdj7psnfor77aq2u3aqrk3swq2jsgjjwrl@6siwo33qhpyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 3061a961-1d4e-4543-f224-08ddfc3da816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pWYkdLY3J5ZTA1YmFpNFFuWXR4QVptdVRJbnA5ZFIyOFhqZS92VVlFU2pX?=
 =?utf-8?B?cFB0VU85VGVwUURzVTc1TEw1Z2tJb0xQejg4Q3p4OHptc2xqc1NHVkk3U3Ry?=
 =?utf-8?B?TDNyRTEyck1zcXp4NjlDSVZiKzhsbm5MbG9YaCtDYlJLa1ROR0F5ZHFSUDNX?=
 =?utf-8?B?U3ZwR0VIZTN0UWJBVlBUREI0QUYwM0Q2WnBWdHdOemhJY1hZL3hvbG5OSGZ2?=
 =?utf-8?B?aEJLVFZ5UVRmSis3WjBhWjZhL2VEbXVKYnF3ZCt6YXAzSmp3ZkxTV3Vqdnl4?=
 =?utf-8?B?aDZpQWxxVjF4c1RUYkFueTVBSSsrUjZNKy9KaUoxKzVXbjRaTCtGbEFoejUx?=
 =?utf-8?B?TEx4YkNPdENhbjh6MjBjUXJZYmxkbFhkR0l2MlN2QURWMks4K2JPTUdMbzR4?=
 =?utf-8?B?MVR0Vm84RTM2c245ZGRCeUdzRkN3dGUvWVprb3NOQmVCZEtGTnVCbUIrbDlm?=
 =?utf-8?B?bUtjRGdTZE91MjNvM1M2V3pNeEZvamxyZ0I4Z09wdjRodldLM2ZkZVN0aVpE?=
 =?utf-8?B?SHNrQnFqbkU3bzVrUFUrb3lJbDlYYysyUzVCUXZ3b3c1NGtLL3pxUHU4SU9s?=
 =?utf-8?B?UUdYODE1SWluMzArM29QRHlLdkdQK3JkWWZxS0ZmMHhyOTJGS3NMaEg1Qko0?=
 =?utf-8?B?ZGFKUklKOU8xaEN3Y3NHSG9ka3R4dFF5c2Z6WFlJQlFsSHcyc2xZMGpPbGJE?=
 =?utf-8?B?cERIM1JPM0RxeFlHZ1lxZkZVL1o5czhPWiswZ1pkZTg4QUpjV0FVNU5ZOS9u?=
 =?utf-8?B?ak5Zcmx2TWJ1SnBHNmN2VTcrc2dEaWEySVBvQU9WQzBrNTdVeWhqOWFwdFho?=
 =?utf-8?B?Qlg1djlQQUdITm1mbWk4OE03UnNHSDdseUxlbkFRVGprUjArWTFrMEFLanBJ?=
 =?utf-8?B?NUVUV1dFY09raGp1T0tLck1sMEhsN0p3WkVEbG5yc1E0NURqbTdsOEY1Rm5T?=
 =?utf-8?B?QlUrcVFSRE5DWGRxYTc3bFhMaUcwaWZjcjRQbVp5akJ5TEJoYkdzT2lZTGY3?=
 =?utf-8?B?aktVcEpFaHpvSXlKUlk1eTFETEVSOFQxbjVnN2swQVNlb0tEeFhzNTBoS1J4?=
 =?utf-8?B?QVdwaXZwcUowRUNlOVpjRDR6dXVQTzJMbnFvdUdaZHB2c3psYmgvRmhCNVcy?=
 =?utf-8?B?MVRBSldyWGNTMElZT0RaY3F6MzVSTkpERFMzZ2YzYXNqMXZZM01rSUhxTHh1?=
 =?utf-8?B?ZDdYcUdmL2dCWkFkQjloUWlHZTdmTkNoYnJUeHRjbngxNXE4M2VaZnY5MDlh?=
 =?utf-8?B?d0tXcWtjRDlQOFlzUjdmZTdtaHVBUlhtMElZdmx1U2tkYXVtRmhTZ3Vtd2Ev?=
 =?utf-8?B?UlNDb2lhN0tBYzRtRUgrN3pVb0ZmRUVXeUpaTTVlYjFaK1pNV1JQZmJXYllO?=
 =?utf-8?B?cVRGRWtZM1A2QWlGSjN4WUlYZ3JMeGkvN2FmaCtDNkNvbXlPU2FSdkZhbHR1?=
 =?utf-8?B?a1RiZU1IdjlPSEtKOFM2eExFMzdaRU5NbFBMbHNPL1ZSQ0NRYld6UDd3MThL?=
 =?utf-8?B?R1k1NlY2YjNTRDNZbCtwdlN3VkJLNVJCRXc3NHB6WW5CdjhOekRvYy8vcHZw?=
 =?utf-8?B?VE5wRXVlQ3ZoeDkyZ1RuSDB3ZDJtQ1ZDNFlZckM2eDluR21oWmMxdTUwUFVC?=
 =?utf-8?B?UXZCVWhZOWZYL3BuYzFGTmtxM1N2K0hWYzdRRDNQRThIMjJQT2FmcU9jVTF5?=
 =?utf-8?B?UTJsNXNLajJPcG5qaGx6QlVLSElheUE2bzQyKys3YTRzR1ZON2JrT1VxbWl0?=
 =?utf-8?B?dzlCYjZVbjlhYVkyUktPR05Gb2RWcERVOG1LMExiakVac3k2T0pmNWhFa0NV?=
 =?utf-8?B?R3ZUZEZEZXNBSzMzZmV6VThIMGlOd1Roa0l2TXJZc2hXUmFhaEZjN3gvYTMv?=
 =?utf-8?Q?6mXx7Lj6xonSO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3RZR2phclVueTlCS052Rys1ZWVzUFQ0cmZ4STlaOEcwbVVwWnBudjIxNDZh?=
 =?utf-8?B?SG1zazMycU1OZzNOR29qTFkzcG9ZM09WNUpJblVqTktlUUpDcVJLOG0wTjFO?=
 =?utf-8?B?TFg4azNhZHB1N0JURzJhU2ZZamE0RlAyVXZxVUtPcHoxb1FzeEJUYzFwbi94?=
 =?utf-8?B?b0tEcmFZNDQvVUJuNkJ4NEhEMXk1ZVB2UkE1ejIzcENXK09sK2VkZW53OVZk?=
 =?utf-8?B?ZWR3aTR4akxLOC9HaXN3Um0rRS9PTXR0YWt5N3puUWRPZ0x3aE53VmdpTmZZ?=
 =?utf-8?B?TFFpZFVUV1NRSVVmMHd6bTlMaVQzNE1zeVI1RmwzQVNVbkZuZ2pmOWQrNFVp?=
 =?utf-8?B?YnhTSmdKa3JHTmRhcVlpYWtIU2xrRWJ4NWhocTZKcFlrL3A3b3oxWFhQZkMr?=
 =?utf-8?B?TDhwTk95b2VZZm90YnBHT0RjS2JPWDJjRDBDZTNZd1RoMms1d0dxcFhCUG9Z?=
 =?utf-8?B?ekhYM0hRNWtZSEVMbGtQY1dSTVRoRTF0NmhTTXlNdW5WTWo1Z0wrSlZNTnZa?=
 =?utf-8?B?dnV3S3pZNFA0QUFlRDQ0blJXVDIydkE1Zk1sSG1wMWI4TWRUSVQvcHJqU1ZF?=
 =?utf-8?B?bnJRWmZpYm1EZFRsUzAvTFZiVzFjc0pqbXg0TjJyOFNiN25iOHU3L2RiOEEw?=
 =?utf-8?B?Y2tvYXNIeVFMcUhxbGl4MUdMRkh5b1k0empwc0Q3MS9XNnpxd3BENnA3c3do?=
 =?utf-8?B?SGhVdndnWFlNQ1I0NWc3RWV3VGVPYXNvSVdhZHBHSVF4bDZvejJJbGlwa01M?=
 =?utf-8?B?NzJNZGNrQk5ROEdNbDNhVE1FNE1vQ1B6NUNWTlRMaDBlL1VIVmlGRWo5WjlB?=
 =?utf-8?B?Y1RMTHQvd1BxMGJna3ZYaldEelhBTnlpVm5rODgyTVl2c0Q0NFZ6eGRPMTY3?=
 =?utf-8?B?bytjaFpnZFNkbXhuTFZQOWl1NGtvMS9Lb044Q210alVMZlEzV2ZLWlp6UWIr?=
 =?utf-8?B?MjlGK2trMDNoK2ZwQm0wL1BEYWhFWmp4dGRYRXo5eERNRVJVSFVTclJTQVhm?=
 =?utf-8?B?OFNjTnJZVzgvTzZFY1RkTDdWTkNaZmgvaU5DdjFhdk5rdVdEeFB2ZnhjS0dI?=
 =?utf-8?B?ZW9NR3BFOHVWSWJFZWhDUWRLeFRtRGswZDZOM1ZVS3FTSjlHVjFCNVlWcTZO?=
 =?utf-8?B?UjMwV3MydlI0TzVYbC91eU5raEJFeGV2Y3FjZEIrTkpaOFR2a2xCQ01JSVpZ?=
 =?utf-8?B?eWZLTTNZUkw1TXNVbzVqOFVrQUF3THM1VDV6VEY3d1lCMkg0UExwd1pWZHNl?=
 =?utf-8?B?NGc3R09UOGZSaFNMSmhYMjl5dVk0Nk1wRXpHQkxmWk9mMWZtT3gyT0hQT2VV?=
 =?utf-8?B?ZHpydW9pcURRSk1wZjl6VGFaUFNUL1F1STRrZXl2WTN1bU9KbW9JQ0M2WWdL?=
 =?utf-8?B?TXZQQjdTWXF0czYreXBJZGpVQjZPRjdjOE13dUJ6bEVjSjhYSDZFSnZYSHJ2?=
 =?utf-8?B?U0pUMkRpS1paeit4N05HV2NpR1dtMFdXREw4RVFHL1NLVnd1dXIxUmJmOWJ1?=
 =?utf-8?B?V0FxWUluTVZtZ21SM3VvYnVqRXBGQ1R0SE1vdjJXRWFuYkhpWjluS3pUa1lW?=
 =?utf-8?B?R2hCZkJFaFl2N3l5N0dBSTNQR0RYUXNZcHhaejZZSnBkSDhCbnllMkQ1OWQ5?=
 =?utf-8?B?SWRyU0xrSHl6UGRwYWtCajlCWGl4RGIyODE0MHhFMTVULy9oQ2x1c3BQdjVT?=
 =?utf-8?B?ZUhramV6SzhKeExKWGhNamlvUVd5V2lWT2pjVWRzNHdSZ2t1T2t4SjlEaUg5?=
 =?utf-8?B?OGhJYjI4VTlIY3NTOUdjRnJUMExpRFFKdjJZMDNnNTZIK0F6cDNGT3B0dG8z?=
 =?utf-8?B?MFhxRXJTQXVKL2Nma3JPeXRsbEJEeElHN05hcWVSc2dJUHNoNVRydnJaMmRS?=
 =?utf-8?B?YzdYNjNTVEM5Y2draVlsNlhyZStRekhoejA3Smg5eTF5VmtFenZnK3ZLTU5Z?=
 =?utf-8?B?VUJKVUdoMmZlZkdyOVZzbzhhbWlaL2loNFFPQXNic0M4OUc3elhMSDFVUE5h?=
 =?utf-8?B?TGtER1NkS0QrSDN2TTFvK09HN3IrVU05VzNrbGxiMDhlN1c1UmRTb25lMUNP?=
 =?utf-8?B?UHJKVDZrSDlLdEthdjl2dGQ1Zkt3ZGR5N0ZXVjN0RmV1SGpxa3lXRHNGNXB0?=
 =?utf-8?Q?/aP+Qz6RZ2/kdWZl+EZzD64Oe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I77pUEbIA/s41rbjVNQy7E2FbJfXFofEaTLZCyvozuI8rIuG5Vmz1Q3PgdSb9THFu7FymInLbZuQ1VYclTdAn7xCmfVYEjBrwyF60S9z7nPvKHQRsVFcJ4dvnR9aZPLPQU7xmAbLyhPaba6GcuCTjsGy34+UwUgDcMUJLO/YSQTfTGLrLYMAL1/hN40B2iprrU9lf9bzPPWaitO4UhJF/eoTxOdRo7wBBk+6REyArf0ymYKDF1KYX1IOyYqV8wcDZb+g7IkTK+85r5ST/dE+6vb8zoyMf3oI1iUdrKd9fz9pChHFV6yaIy34tyySpZHefbcFfqJ0cPtFwE0pynDP4BHq2VKOifJTr++HZS1ThtJ1+HYIOSsvV0kHnUV1hNnXwrFkc14oc+F+t4njp6KTcigWFS9xMblGVbJy8t4iFHyUmB+tnLFjvFTi+nW8JfApL3uPMOKjtUefiZ7yRGX6gPsnPZXug2JGGjA/svftOVW1SJ7O6zI+bqHVyd+W+Oqsj89JPpkFPLteoyRfFPf5HyaAKilRbbSqte2Mu4EE2F9G742ih/woDdz9aHjuDMso28sDImXTfehUs7zhl6oWaO5NaWiOfYtoPLjoOii/7Vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3061a961-1d4e-4543-f224-08ddfc3da816
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 14:13:10.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A47dO5oWy0UEg2V0z9OoOGxokS5yP0mYWbHWvBK/HSozT/EaIpeVGwNAraD1bHetUgr6l3MQemcYvy/D8RQIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX10aEgbdY+dBp
 njkY38pHxguoP2cfOosL6Sh0gBkgp/2J6KBcA+L+qv09OVQeS1eJlFouaQu/N92eAZMwf8heXDv
 Qr7AsjDyqLTUQs27fbFs5+xqHNeY7eTrzDSpslc1XSqdOO+ZbRI+Q8XTac9uulsB8J9t2cNDms5
 +TQlRusEs8MoIULKnRfJcD2MAhwg6jrWLjt8Qei7mdN6+wKEehFlsHPR4+z/Drx7bJSEhDn18Fh
 /XxstApo1Iqi3ehm2Igo3QZ8gN2jNo1iH9ps0rZtOnJGC32bOk5wWTryc4P4WaPoNaO1GNpLG3F
 8rfXXIHVmWVxBoiZNbLI/qacZN8FWf5OvLSy3eRQhIhR7A/eY+Vxb57NAJbhtXuCoyR4Ajh9B2P
 r4UuVgFJ
X-Proofpoint-GUID: RuW76oRUHKAH1nxiOrAizYDNhgErSXua
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d54e0a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=NEAV23lmAAAA:8 a=yMRtmO20ij7w46HyYtwA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: RuW76oRUHKAH1nxiOrAizYDNhgErSXua

On 25/09/2025 15:09, Shinichiro Kawasaki wrote:
> On Sep 22, 2025 / 10:24, John Garry wrote:
>> The testing of atomic writes support for stacked devices is limited.
>>
>> We only test scsi_debug and for a limited sets of personalities.
>>
>> Extend to test NVMe and also extend to the following stacked device
>> personalities:
>> - dm-linear
>> - dm-stripe
>> - dm-mirror
>>
>> Also add more strict atomic writes limits testing.
>>
>> Based on https://lore.kernel.org/linux-block/20250917114920.142996-1-shinichiro.kawasaki@wdc.com/#t
>>
>> Differences to v1:
>> (all based on comments from Shin'ichiro)
>> - Rebase on "support testing with multiple devices" series
>> - clean up "make check" issues and other coding style issues
>> - Relocate some NVMe helpers
>> - Add _stacked_atomic_test_requires helper
> 
> Thanks for this v2 series. I applied it.

Great, thanks

> 
>>
>> John Garry (9):
>>    common/rc: add _min()
>>    nvme: relocate _nvme_requires and _require_nvme_test_img_size
>>    nvme: relocate _require_test_dev_is_nvme
> 
> I dropped this patch since it is no longer required by virtue of the other
> recent commit [*].
> 

Yeah, I noticed that on the list :)

> [*] https://github.com/linux-blktests/blktests/commit/ca6de24a9b67d4a7387871cb71307d1f6cc9c0e9

