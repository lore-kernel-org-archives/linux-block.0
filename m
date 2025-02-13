Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD970809
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436337; cv=fail; b=bf+JHXjfiyvp0jzdgjwz8G2/fME/DO1Bwj5n7v2TVI5wygv+7CiNsvbyPrFjsaokLxjkSW6qrI/aYS3b3ziPpRaUxNmF1jlBh8EF7b0CQ1FdjQJ2pvUpAktBnpPNue9gAOeDJZIauUsgu0srsu7mpxnBdLH/Nm22kNx8dQhqaMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436337; c=relaxed/simple;
	bh=ZoUMeaGCNQvJTEE3Xk0IRxSnRQz80CWfr6exGAivC4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq/FOYcHlHIT1qf4IDjy1GRYWD8w4bEjGPxxBHLegoOYdCm/R+UQdPX7bsOiFtjKNRlD2aFgfPdslQPESq6oG7F5/9T6YiF5MLKBBDTL3CqjVbYGUVgcmcTvbAWQSUwd1q0sIFU8F3I2jSkx/3g6xb1fsp5nRxwom0LRzGPlkhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M/XOGCJU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EuK7S1sC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M/XOGCJU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EuK7S1sC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fV9I022161;
	Thu, 13 Feb 2025 08:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VlrqK1lhXIEOMsoo5zIrdIXZ7K3Msbm76cDMRreD+0Y=; b=
	M/XOGCJUEhhpgFPbJVnsLCULSB4tXQWybmTfaslatd2TOQNZ/cBdmJ2CHb1SX03R
	bGilqvinXh0y+YnZslEsDCf2s70HXoq6Pn9etVqDWKplNTB9s0mMxnH0oy21b0hE
	j79g5BBrJdXlgV+BC8Bmef6/SnSeyZwZEPB5itBHaib1g6N26ifxXN0HBMzOZWMf
	Gm+0lGzijKDMMD0KpH/k3g3Yl1V6u1IvdmlKt0JPjhD79zW36VtZyMcQ8lj0vm0U
	qw6/u4KzsvV3r+L4TE5BsWrK7G4plY56VfhLoFlXOyZ7osa5lpDR6H91b6Hkd6NV
	Ba5CGGj7h73ho7ALuYMl0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq99tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 08:45:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51D6noQX002714;
	Thu, 13 Feb 2025 08:45:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbeyk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 08:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWLyWGtlL3Gf8cAs9CWE/uInCqBw4ZhcO+HT+FaSw/b0wa0xfWYCHIsd+t+1BeRVueUA+HAB/ZHfsG6PoJX/jFttnhlZFukbWhoKeIAs1smedAgA8IKuNHBTvVSog+CzfQ/6VWXhsr3rMYvq2nPZz7J8A80X7Pvn4RS7EBMNj1+qCveVArqz25gAGa2NkLdc6dCIEP8paa8C2ZyhIk/0u5+OzyFoAiN4wJJzd8vWMDCgiYKLaAq+6b4wngt5Rq9m+8/t59za0U44FgqZ95m65D2MGN8/DDi82kSgj8Y5lNxCq+GqBpzWiOshvCJYdBqvhpQju7MT3lliwIHQqQI8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlrqK1lhXIEOMsoo5zIrdIXZ7K3Msbm76cDMRreD+0Y=;
 b=vyqC/oS3ope41yCHRqphZFIBDztFbIu+jsEcnT4InIaZExc7tOrV44YgVFWlrPyEoFh3qJ6dTgR4tpIcq4byGdF8RkAbUwdlHjVWvEpXsBtWYjqOv+wi3kivKxA3ly+Fy+Y6cKxy/s7wRDeY2BfVHfnNbjl06x96fX5UXtYsD/rfxmTAgHoOjGNfhCpeP3QtO7AkNuP6UvZqrzatZtCoSO37DBopVSqbXOz0AkwcA/3I0h471cJsMxy7SDXV5oghA25TsZsNUK1TaNWjhUEXP6wB3s9XRdQZOVkCn1kkvFRZAirv3MElr7NVQiVVjMCanX2T6MiXA2h+Z5WekYU8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlrqK1lhXIEOMsoo5zIrdIXZ7K3Msbm76cDMRreD+0Y=;
 b=EuK7S1sCNOSrAe9glu9QUKWxNqJ6CePzomQSdA8POns8o074bPkOwM9LCI+qPLkibab8J40y8mzra3C6PyECNBUlUadDI5DUh84mrnl+N8bzJMK0P89pGgh5H4JyUb1z9Q2wOwvlRPWDjC0iPV1ZQ9I6RvZWC4NYsPSzaqTD5gs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 08:45:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 08:45:22 +0000
Message-ID: <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com>
Date: Thu, 13 Feb 2025 08:45:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250210090319.1519778-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d2515d-ba49-4afc-6fa7-08dd4c0ac0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFza2t1bk1ZdkpjRlpZRXdSdDIyejQxajQySXpZVFdpTVBKRHBtcEdBWU1L?=
 =?utf-8?B?MDVvMk00UHFnTlEwQmJDUzkyMEd0WExHZkhBV0xSMGtnSlBnU2lCbXRCVklu?=
 =?utf-8?B?WEhmbWtvRS96NnFrOHliMDhMSnJkNkdkQ0hKVXRwVkFMbkFMUGwzMWpVMTE5?=
 =?utf-8?B?aE8wakUxVEtCbDFhK1FyYzVwZndrcThEeHN2aDkyallhZEI0dHBlemwxRXFB?=
 =?utf-8?B?dkJGWDZTRUxsMjFiZnNraUxqSFhwWGtJQVdyM3ZmeG1rVWN5UHJGbnRyNStQ?=
 =?utf-8?B?Q2k1ekNyd3hudnZiY2VXRGgrNVNLcnIwYm41c2luRU85ZEVNeDR1UUpXdUJY?=
 =?utf-8?B?UG1IWnBZRTBvRXN6cFJSQTlNNGhlZjhFajJDQ1ZUMDBpdWxtR0x6VFk4WlJn?=
 =?utf-8?B?M3ZWLzVkT05XZmhLczRRZjRNTjJ0UFZQbnRBRXAvWGVFVnFyYmtVT1RveGNi?=
 =?utf-8?B?M1Z4KzM3RGxvY0NJWkZFTTBNbHVrVmhMbkdYL1NOaFl0QVRyUFFRV2xXKzVI?=
 =?utf-8?B?QUtLOFg3cWlQMEhMZ21XUTg2Sy9VeFBLQXMwV0s1R29pK3hDcXNmSlh2cTBI?=
 =?utf-8?B?dExFL003VU0rdVVJZ1pVdHc0WDA5bk5kVng2U2FYZVVRNEk5NUNHeElyUUVC?=
 =?utf-8?B?dVlxUGRUaHFncjJYTkdRaHN0Q2pPdWsxOFFBTXlaNExkVU1vUk1xbHZHblVv?=
 =?utf-8?B?ODVhUzZCU1dGS0JoaGl1bHNvamNqb01tUmRQQ0hyTTk3MFJvL3NURzRtUzVU?=
 =?utf-8?B?YjlyZXdkOG45c2lnN2RZVHJwSFlFOVI4ZWJvendCa1ROeXNXeTVJTVZmSTZ3?=
 =?utf-8?B?YVBRbVVJREljOUw0bmt6SkwxWHF2U2NhQnNRZkNJTDdmTE9sb2FxV2JZTGpt?=
 =?utf-8?B?WnhjUkJKRW5BMVJ6UmhXT0lkWGpUREg3aGFkeSs4c24wc0VuT3pFNVhHeU5i?=
 =?utf-8?B?WTJ5NVhYcHZXRVhiZ0t6QUpXb3Q5VWFISFk5KzczU0R0dWlIcWZXb0tDK0pC?=
 =?utf-8?B?cUZBSWR4a1BzazZmQUFDTkVrc1hsNDQ1Yjc2TmFLRzNyMnBxZVl3dW53S2ls?=
 =?utf-8?B?UThLUnUxS09tK3A0ZjY1SUxOaEtJa3RMeGIzMzZ2cTVnNTM1ZEpBZTl5N203?=
 =?utf-8?B?VVV6WVZYOStqWVZXdFJiZlUvR2xBMmhCZXQ4bmp1YXArV2dORmVNZ3BMSFRW?=
 =?utf-8?B?SDBxckRjaEI0L29RaHdZS005SlIzZjBNRmFRbldvbnlMZTRBK2o1WlY0eDVJ?=
 =?utf-8?B?Y3R4SGdlOHFVR21oYm1IZUJ4Y3BINmdGQlF2bUV5MDVpTEN0SlZ5b1UyY2Ra?=
 =?utf-8?B?ckJDa3F1dVQ4dGpFUnhNcHViZFlybnZNN2VOT09IcUFJVmczczRYY2V4NXY0?=
 =?utf-8?B?YjBqUi9aNFBwM2d2TlZOaUJlaFh2NE9PdEZYcWYrbU9Ca0hQVGFKaFQ3d1lm?=
 =?utf-8?B?dVA2dlV3NkpsTEVyQzlCanR3ZzczSkphQXVmVUpNbm1PN1ovcXNaVnNNa3Bi?=
 =?utf-8?B?ektpcHRDNTEreXJqTWNoclNRYmNGeEtLQlNWY2UwK09mOTQzT3JPbWxsR0VI?=
 =?utf-8?B?KzVQY1pOb1RQVWxNcGpldmtVellqRzU0WC9MOFVjT1AyVkpqQS9HcEo4dDFr?=
 =?utf-8?B?UDluM09RNEdkc20yS2hlYVAvU1pYOXVyZDFKUVdMTHlDT3Z1YVdESml6TEgz?=
 =?utf-8?B?d3dWTGZpVDY5dlErejNiSDdkNmpJMWg1a2Qwb2JDYkI2NkxKdXZoejBwLysz?=
 =?utf-8?B?SU0zRFM2VTExUk9PTVJqUENZSVVMWGFScjBWZHpjWnR1L1V3bUE0UXY5QTZq?=
 =?utf-8?B?THlOWnBCT3ZYWUNleWErQjZQRWhudG5ySEtuektsdXpBekFpdk1aeXJtK2tx?=
 =?utf-8?Q?8VTuYNRRMhQJJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXJEWURDNHVESnlaNWxKRWVUdDVnYUtzY21OL1BxSktWUm5xNkE0c0RsdCtI?=
 =?utf-8?B?QkptVlFBOEFGeUxIVjgwZDErS1B6MjF4TFBBVVVqa3IyU3pWcW92VXZDOGtM?=
 =?utf-8?B?YWUwWGYxL3ZOMjV0NDJvWVpMRjVkSzhISSt5ZUZ0SjlKUUpRNlZXVVdubWR0?=
 =?utf-8?B?K1pmREtLRkFjWDBQZUFCNmorU1BWUTFIZkJMWTdiaDZFM25YS0dZSFhaVU1h?=
 =?utf-8?B?OWFmK2QwZlRNU3NoSDllZjRUZmxleC94SW1qK1lIeU1WQTZKdVJ5N3ZkMnhm?=
 =?utf-8?B?ZE1UWERZdlczejBmK0hoK1lVVHp6cTBSLy8rcitmTnZTeHVJcjhJYUhQR3Zs?=
 =?utf-8?B?eGVRM2JQNXRwdExZTzNYS1NvSUViaGUwcGkwTkNKaW9sN2Z0OTlXQ1BERDZ3?=
 =?utf-8?B?d3M5L09IV2NIT00rWHZhem1KTlBPUWZsMURmcnJKRnBtL2loaHFITFoyU0xi?=
 =?utf-8?B?a0JVZ1Z5S0Q4VnlNUGRRcjExVUdhNG9hbWpmNGZyb2ZNV3lyTzcyQzN3dTAz?=
 =?utf-8?B?SmlMbUhsV1FjODdyY2U0T3hBR09vOGhlMzljUW8yb3B2TXlRN09UdHBzTmVz?=
 =?utf-8?B?WmgyNEhLNzFwbTVoR05IRHBhUERKam5jSGIvaW1ySUxEMmtTRThYSmcyWjhU?=
 =?utf-8?B?U1Awc0I5MGc3Ti85S3h2bkkzSTdVWFB6SEZ1N3FhR1VpYVlIQ2xlWWlPcW9L?=
 =?utf-8?B?VEtUa1ROd3dpaEVJd1Q5L280aU13NlY1SnZ4RHRTMUExeDVRL2tsem5RcTY3?=
 =?utf-8?B?VWlFK3AvRzhMMW5rSzB3cHp5d1NMR0Z5a2g2eE0yY0VMMUtUaStGNGxJaElp?=
 =?utf-8?B?VlN1bmZ5cUxYb3B1T1d0cWphalJjSzR2UVhxb1Rxc1pITk50THYvcXhJb043?=
 =?utf-8?B?bFBRcGJ2Skx3WW1qTm9mUnlOK2o1MVhoWENZU3UvNE1Vc2M3aDRMQUw0R0FM?=
 =?utf-8?B?TVkyQzZERkVCMUFJditIY3R2QlpmVEZUSXJVUTlKemw1MFF4RjN4MTlXaGR5?=
 =?utf-8?B?ZnNzYnZLblFkR3ZJWUJpc0phM2JjLzdhM0lSd1ZzVWlhdzlnZ0FsWDN2YUo0?=
 =?utf-8?B?NUp1bGg5WmlHMmxKcmhVTEFJQWNpT2JCV3I1aElYejQ5djEyWWJoL3dJTENx?=
 =?utf-8?B?QmRYWFo2Q2RSeHZIRHB1czdoZ3ZZcGdqS2NyTjdiOXhkYk13SjFRVUpFV3Ra?=
 =?utf-8?B?Umt6YTYrSU53eXBmWFdkbVBobVZ0RGJDUFRkOFduQVY4S3QxdDM2dEthZXVx?=
 =?utf-8?B?NXkxT3ZrWit6YWE4ei90ZElCYWlPaE1pOVl2aDlUaDFHZzVaNGdFZkg1RkJr?=
 =?utf-8?B?S20yTFJ3UzNJcTZzdGtFWWt3Qmh5Q0N6M3pZa3M2bytPUEgyTkdDTmFLdy85?=
 =?utf-8?B?VHh3bXhGNlJ5eDhaZzkrSU1BOEZmWm1ubms4VG5qL2gyOWRtcTRmSDRxVFBr?=
 =?utf-8?B?N01EZWVrdjVKRkVzV0tqckJWSVQ0bUVGZElaZjNmR0V0STkzM2xabGNFRVVq?=
 =?utf-8?B?M3ZpdnplVWh6UmhraTQ5TFoxbUI5SDQ1Qk9UYUQrMzB1c1IybjNEYnVJOFQ2?=
 =?utf-8?B?NHNrOFZoRVJNL1AyNDkrREttRkpvcldsZnpkY1Z2azdqSW9OYzlEWXUvRnYv?=
 =?utf-8?B?ZzdzSEk1TGFRRmcwc1drWUVpWk5rWXNvS2s3YzVUOHVrS1dGZWs1SFJkQlN1?=
 =?utf-8?B?UURlS09PQURYcGFhWUZjZnFsN1cxUzN2TnlRZVA4K0NzZExsdjYvQlN2MlNJ?=
 =?utf-8?B?T3dRbFVzK1pVdkVQWXVOK0svM3ZPWHcwTkNjZ0hOdVdMRVBvZVNTdEt1bmpu?=
 =?utf-8?B?T3JmaEdNNG91blJHaTVVMmhQQW1iZ09wdkNUanlBcnVDRUFqaTJxbmVhbEZl?=
 =?utf-8?B?QTV3R09hVVplUVVCd1FPbldXd1plaHU1cXhZRlVOWFNtNTE4N0FOWnMvQWx0?=
 =?utf-8?B?alVHazM0TmtCam5FYThuM0M4NmU5Z1JVUUJFQ3E1dFJDcW9nNjdaUXVyTUJr?=
 =?utf-8?B?a3RuMzg0UzA1c2RRaDViTnZsRFF6MkNtNkl5czArTTEzeDN4RlowdWxaaFZh?=
 =?utf-8?B?b1hEbTRuSk5rRGZyK3dGeU1vRVkvMFNrRTB0ZVlvYTgrQTdqS3BneE1RU1Q0?=
 =?utf-8?Q?GbkY27ENqjONRlrjX/rlx1ujX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oOtQnnlQm/1SF8YkGLwyccFf/FlxXuL1IyQVkFQf4zkzzgci+RjYcgdzsPerbnvtXuEVgIaXrmRBYTKrKfr366+FBUgiFHjw8xAV1eAbVPpzfpfWdvyN10BfsVAXAZI/WVBECBlAPMzuGrTd5Yk2RcrdJQcrJD4drF7TTLPN4/5BiKrnUR6bvKwYPCeT4cJm9JH0ZCbj8MTwRwTc6k/fyHUyganQFRxrY9jep5kFK0DjD/8VE3g25/1oFGEXumwta2UCF2wY+KnVjfVC58tb6INSsUZhKgfsAb1hGjYkALfy2OlkYqkdr4qVoMGeext6kErMv47FL7JdeuhZzelteQJjloYMQNR6OhUMsEpv5i2rvSaY3F3E3gENOt5xksFKX/XD64tR0ij3MFz2VDaJGuhKY/cI8jtyBsI0EKdeCcMC0G47wLq/B0Iitjd6JquhQ/y1l7u0Qgf7kMnLZb1ukF0r8sBx+TVumLcUiDNnRKb4Pmen/b8+8Y+hWE/gvgFFtBST+/xoZfoyoLFDsLPL0yyTi1qfw770TeRh/3K0neZqgQWjtHx+4LeTI5pN6ZhtjvCVdAZWh2vBXxSxrF/mTUJ8NVXSaKgrzR1p3Zns0G0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d2515d-ba49-4afc-6fa7-08dd4c0ac0d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:45:22.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKOpqy5STspqT/4yrEzOZdkN7zrjU6yW43LzRuo+LiltYKc7UZeGkKBGXR+llTh0zBx17vBZbXeBl/E1obdzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130066
X-Proofpoint-ORIG-GUID: o1T_CTJLSoZiOOOaR4fBwnst8WxLfbZA
X-Proofpoint-GUID: o1T_CTJLSoZiOOOaR4fBwnst8WxLfbZA

On 10/02/2025 09:03, Ming Lei wrote:
> PAGE_SIZE is applied in some block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly
> hardware property
> 
> - PAGE_SIZE is one config option which can be changed during build time.
> 
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> 
> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> as 4K(minimized PAGE_SIZE).

Please note that blk_queue_max_quaranteed_bio() for atomic writes 
assumes that we can fit a PAGE_SIZE in a segment. I suppose that if the 
max_segment_size < PAGE_SIZE is supported, then the calculation there 
needs to change.

> 
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/__;!!ACWV5N9M2RV99hQ!OvnGwXMRIGpyaHe2nucoewQFL7ObGtM2kAjxf_He-BXr6P4Q1uN8peKArl4nO1Yo2yahJypfmK_Tdxt8W9PX$
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- cover bio_split_rw_at()
> 	- add BLK_MIN_SEGMENT_SIZE
> 
>   block/blk-merge.c      | 2 +-
>   block/blk-settings.c   | 6 +++---
>   block/blk.h            | 2 +-
>   include/linux/blkdev.h | 1 +
>   4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..b55c52a42303 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>   
>   		if (nsegs < lim->max_segments &&
>   		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
>   			nsegs++;
>   			bytes += bv.bv_len;
>   		} else {
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..539a64ad7989 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -303,7 +303,7 @@ int blk_validate_limits(struct queue_limits *lim)
>   	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>   				lim->max_dev_sectors);
>   	if (lim->max_user_sectors) {
> -		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
>   			return -EINVAL;
>   		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
>   	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
> @@ -341,7 +341,7 @@ int blk_validate_limits(struct queue_limits *lim)
>   	 */
>   	if (!lim->seg_boundary_mask)
>   		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>   		return -EINVAL;
>   
>   	/*
> @@ -362,7 +362,7 @@ int blk_validate_limits(struct queue_limits *lim)
>   		 */
>   		if (!lim->max_segment_size)
>   			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> -		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
>   			return -EINVAL;
>   	}
>   
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..cbfa8a3d4e42 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -359,7 +359,7 @@ static inline bool bio_may_need_split(struct bio *bio,
>   		const struct queue_limits *lim)
>   {
>   	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> +		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > BLK_MIN_SEGMENT_SIZE;
>   }
>   
>   /**
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 248416ecd01c..32188af4051e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>   enum blk_default_limits {
>   	BLK_MAX_SEGMENTS	= 128,
>   	BLK_SAFE_MAX_SECTORS	= 255,
> +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */
>   	BLK_MAX_SEGMENT_SIZE	= 65536,
>   	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>   };

