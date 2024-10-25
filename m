Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F589218921
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889006; cv=fail; b=Tz3IAKyRdJfq1P4kT435ccYwOO0hzC3+PDf7iDyaZ8z0QBOtzPTYwOTGy6YTjzuWJtirUYUviiYESGksJTSiowwumWxKPxFc3mB5/EkwIwgnJAjizpFVEzVPnm1IPY8NKgW6XuU9pY0vGtpP7ueDb/IMsWz2oC8mNTbBTbyjrSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889006; c=relaxed/simple;
	bh=z0ZytdiI6Z3VB9aP4tnyF/uIFSIrWF8QXB4sUyeoC7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9mCuggphCx3Q+ow51dun+jorDYyJao5aLpDDuehMYRjEbs608hxU/aRkRqAFlhwsk11kj43jFl83HzDA8b/PiLd3IRQegfO88gLeUL8+816kOXxAnIG2fHc2mYvQmLiAblXAXK38Ye/TTrQX25N5gpXNEAW2JnaG98H5bYbW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NopXHRfN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDIyqCrh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NopXHRfN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDIyqCrh"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdVNA023228;
	Fri, 25 Oct 2024 20:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n8uCiEgpkksGylX0FOx+ar6sZPVsUoOwB/Buc7KKp+Q=; b=
	NopXHRfNYbIUUoKP0TrypLAZHu336/fny72cmrxUM94nZhQ61HZ9CD86e35BHhsB
	KehRWIpdOz4Y3Ya8ehuGnuhgQZ4++El2CP+ra8NxtPfX3XQ6fkKhI2CCc6Wg2YlL
	K/LtwRFUWm4S6FjN8BN59Nu2olTdMH5TOwDcqpHq7z/S5u53d3xzB1Oy+pGjv3eQ
	EEPmodInHHnVmAe2reaPzSRo/IiFfhxr6ae6tEYXXNuRmDXFD0EawkvJwwZt62q/
	1XOSvAJecg6f+J1YPhes7CA4sixTdTQoUwwIPEgnV8mFOkvDOBBBfE76xLFPu4c1
	q8Fnb8Qu5CFESvc8kbzz3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55enqcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 20:43:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJmfdx021433;
	Fri, 25 Oct 2024 20:43:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnukq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 20:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMmBxUwEszrk3Y7RxVSgygSW95wbGuNMviN9hI1fiXspH19H4fUgbwwOC1kCAmGJalGuUgTPHUgQ9hPzk6ndKpEHR1f0J40hNYGKW4wXB64DP3J/nr5Bhp77zWNLrzG6clUyi8fcBs6Hw88fdsp4a61i0kQ9857mFEBlf2dddZGTGO87oiiyCXEIOlFJevaGMKME0Wl9UCjY7k9hCeSGTAH45caJ4z6ZZ1bfZxo2LsFefPA0HZxU3ym9rkVC6MoqUbZ0bFG0sDiSoplHlzFZnuA0bT27IvVteaIw88szXW3Z8bA6CICI/5SMVPh9gqht5uzLNqFhsVVt8yzM+5sWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8uCiEgpkksGylX0FOx+ar6sZPVsUoOwB/Buc7KKp+Q=;
 b=BT8xNXJJaBE6fdsCeB/LmjnU4lAUYgj3bga4QE+esvYwPHmsH1/7F72ZO9lAwEYSD5QhvqPsaCHcX9Vi8xyl5AAIjkcpD/CkA1U+T4CLLZYsjY/YpBqVyjZI2KQ/H/rLg+RiK0GJZFCUIjwALN4P78g1AwQyTloBgBUD1usqJFCVSRkafG57RM3kccZIhyHGGk2nIaIzAhmweU6xIswX9fuuqBubApYgqTS6xFdFfPpadzO0tPE3BDNa7FoQHlLLu+sc7s5P3xFkTISnYOsDGrYlrh/Nr72SuNWNB0EjBYcXfjkJFYLtpwjzESZbMK9nOqcdzx4UhDmpLYHvnj1aGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8uCiEgpkksGylX0FOx+ar6sZPVsUoOwB/Buc7KKp+Q=;
 b=KDIyqCrhbD185e0XMduRynse0k+fcP1fVTHjpj16UWf/Idd/IFOPApffkteBdfJYzNiWM2ftU3FoLayMjsv3APXm+W5S6Ozg2Hhlis1LedSnusArqLfTW4yenBHSVzyjU3UuPJ6WfbZaWVQpX4OujFmN+w/TEqpZKjNntNzMIYI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB8219.namprd10.prod.outlook.com (2603:10b6:8:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 20:43:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 20:43:10 +0000
Message-ID: <3ba278c0-041e-4b07-91c5-c7bdf4bff8a8@oracle.com>
Date: Fri, 25 Oct 2024 21:43:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec
 for real
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: ushankar@purestorage.com, xizhang@purestorage.com, joshi.k@samsung.com,
        anuj20.g@samsung.com, linux-block@vger.kernel.org
References: <20241025115818.54976-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241025115818.54976-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d80b032-f490-469c-4053-08dcf535a346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGp1aTZpL3FGZ3JaQks5R05rWUFSRTRBYTBralRac3I2YW1SOGR4K296ZGdG?=
 =?utf-8?B?V01wQk5PSnp6dUNBNU43L2krY2l0OU12RWNzc3JtbSt5RlZDNEc0VmhxTlZu?=
 =?utf-8?B?cHBUWW5LR2RvRTBXYzJ1bFBNY0JuZWF1bFJhY3JINUJuTndBSzN3M1MvTDND?=
 =?utf-8?B?QmdHcXJ4TFJSMDcrL3ErY3FrVXB2dklabEowSjUvTG9ZclBmUms2UXh1YWpm?=
 =?utf-8?B?YjBIUm51b0JlYmErcEl3NExnc1JzOVJxRndVN0ZXUGNDMG9uU0hPdlcvc3gr?=
 =?utf-8?B?dzh3VTNNWmI3NU12dHhWaUxXU0x1MFJ3Wm94dUwwdHhzSjB2QnlQYThBTGt6?=
 =?utf-8?B?RDFwaWVHSjhLYnVRZElWODhHckxjWGo0aU5Gd3RTYUNzOU0xVUNFQ0ZqNkdV?=
 =?utf-8?B?YmlTK1BtNzE3WmdCZ3FtRzdIWExyckkrTkZuRGVXVUg1SERVRVl1UTJNWFFK?=
 =?utf-8?B?cXRwL3hUNjN3Zjhra3F5UjFjY1FoVElucEdjVE16bHZpVHpvSmQybE5zeDBZ?=
 =?utf-8?B?K0ZqWlpQZEFiVkEzQlZEaDNkTmIrT2FrTEVhZkQ2VXozN294ZzNTUlh0R1VZ?=
 =?utf-8?B?YTZPK2crMi9CMXh2UHRkRXA2T3MxQklQcmhsRlVyM1RMdlVxQmh6UmJRaGUx?=
 =?utf-8?B?azlKekRINE1HWWZ5dWlMOC95QTdTMW5hSlZLbngyUXlNVHBlVkY5d015T0Vz?=
 =?utf-8?B?S0F0KzJDOHhBOXBDREZHbjl6OWJQd0dYdDg1VlNWMHc0Ly9LU2YxNXFIay9W?=
 =?utf-8?B?eHlucUZ2RUY0MSt6SlorOHQ1RFZQajVxbWh5MWRRTlpIOERTdFR5bGRNbC8x?=
 =?utf-8?B?U2E4L3A3Rmk1M0ZPcXU3N3I5WkZtbS8wV3dObk1RSE4wYytwUnZWSFV1YWhJ?=
 =?utf-8?B?QUkweHY1MlRSd2l3eU9yMEtUOS84amo1c3E1bFlUZEFRVGxZTjdCcU5QTldm?=
 =?utf-8?B?RnRFMFNKRGY2OWl0VUs1WVFrYlhJYlM0VWFEZ0dRWnlBVGxlY3hxODdYV2Zn?=
 =?utf-8?B?Z1VWWFdNUnFtRU9HOU53RGF2QlErTk9ZZFhCdFl1aVZyTVhUeDZtcUYxKzE5?=
 =?utf-8?B?Ulp2U2ttb0djbWVVK1NCUFdvUHhCOEo3KzFLVHZNbWcwQ1lNUG9MYnIyWjY2?=
 =?utf-8?B?MHZDbDV2ZStlWnBKTWJTY3c5eFBIQXQ0Ukd2YTk0RExJRjNoTTVoNE5CT3RW?=
 =?utf-8?B?LzFxcGlid3FhaWtud1F0Vzd2Z1kvbUJyek5lMzdJTFNWcGtxQURPVWlPWVo0?=
 =?utf-8?B?RjBaQUNMRVAwR1BDaFMyclBIWktwc1Vid05mbWlsZDZIcmQ0UVFpaktxNXB4?=
 =?utf-8?B?bk85MzdPV2wvalpSV29IZkZXZ3VRNlRwYUF1RGViUXhKWFlTTjFhTUprNkpR?=
 =?utf-8?B?aExXbXBBclF1b1o2dGV2cUpoSlNzdnNZdE1aQ0F1eWdaVnZncER4OTJqZkVX?=
 =?utf-8?B?ZkhINGRqamZ4N2g1NXl2RFRpdFBla0ZqOUZBN2hoandTZFEvZmU2eFl1aVJv?=
 =?utf-8?B?OS9mczYwU3V4M21qWmlPTCtaLzgwMVAzYkxaeVE2ZDJQZzVCcFNxMTUxTFNG?=
 =?utf-8?B?K00vUm0ybjlXMHVNcjhPTG8yWFlBck5NS2RnckNid25JaHdXTDdCZEsrUGJK?=
 =?utf-8?B?MTg0THhLZCs4bUUvNzFkOFpFRXJGNUlPaDdyS2hDWFZxaFVXVEM5K2J6WnBX?=
 =?utf-8?B?OFFvOVFmVS9QUzZHMVA3bitia25OcWtZaXVYUC9mWllHMTlGNVlNK1BnaWhx?=
 =?utf-8?Q?Ph6NJVnIoSgym/23PvT1qDpG+5wnMkDqwxMa0Zu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alpRU3pqZWxKaWVqOUtqQlQvR3ZzdDcwbFpLR0JZOURoM1JxVE4rNXpzelFT?=
 =?utf-8?B?cTBmdFM0OWJqMTRYbElkb3NraTlSR1VlbEZPTmxrT3ZISmRITXQyTTY3cjdP?=
 =?utf-8?B?MFlqOXFlVkQ4S21Ia2RVVmRlMWFlaWlycUMwdHJYdGJBaFF1d213QldqTThy?=
 =?utf-8?B?OUFzd05SVFhObHlLNkpmaFlXUDBxSmZ6clJjTnRydlk3VDdHcmxBT1hZcWhD?=
 =?utf-8?B?WWlReHZRT3RySXY3TVFTUDBFVEtnM28wY3J0VkJRVFE4SDNDbEcrTG02RGlS?=
 =?utf-8?B?a0E0ZjNQVThhRENXK0kvYmgvWFYrVDgwNk05TytDNnpUQitSWHJONzBVMXB6?=
 =?utf-8?B?dExiN0J2RkxNeWRQZW1aSldPZVV6K3hKcTVEUnBjYXl1L2pPWmxHSndqVXdP?=
 =?utf-8?B?b3FDeGhZMHNKdEJuM0hKZVJRcEIwUUF6VUdSSjIwM3R1NGw3dmw4eWllNGxO?=
 =?utf-8?B?cGk2Qk1oV3I3akp5dFBZMWxHN3BjSzdIRmh2ZmxkWXk0S0dKVjAzRlh5OEVi?=
 =?utf-8?B?aTE1dUU4T2tNUzhsUzI2ZzNrejBwRm1Rbk9IMnk3ODEza2lTSS9vbXYyaytr?=
 =?utf-8?B?WjU1dm5ZdWcxdnV1S1JxWHV4ZkRQOHJUS0VXV3dFdmtEM3JKbzNiM25lSnIv?=
 =?utf-8?B?NDNoZ1JIaW02VEFIS3RRVmhHWUdjR3hlSDYxc0h5TFIwdGt3b1E2dEw3OHZ5?=
 =?utf-8?B?bXdFT1d0MkJGR243MzBCSXBGZjFReXhodmFvVTBXeEVUUVpud1hoVVJCbml0?=
 =?utf-8?B?bXRMdFJBWGVKWlY5RDF1Wmo5TFFyN3dlWUdYdStVVjJCaGRWT3p3SlFBM1V6?=
 =?utf-8?B?WGVpdVlhdFdJWlI3NEhaTlFHVnhRcW1LcVhGSDRHL2t6cnplcm5MYWJOL2Rm?=
 =?utf-8?B?eHRkMGxvZERpdVRRSEM5S3hlYkVieTZIUUNVckdjNE5UQjhXUU9RL0xGK2tn?=
 =?utf-8?B?NkNndkc1ZUVyc3VYK1hROCtUaEJMdUIzaEU1cXlmMUNab0tpaG40aHIwM21s?=
 =?utf-8?B?bEF1Mk5QZXY3NG9UQ09wczBSQmQ0NUhiWHRYS01TbXBBN250c2o4Wkh1Uk5j?=
 =?utf-8?B?VTRsVU95ejE5NjZBaUk0Qkx3czVqTUt6UTl6UU90aWpkWVJ4MVJyRS93VUJq?=
 =?utf-8?B?R2Z4VG5xVjZyeWlPdjFHNzhwV0pMaXJwS00vTWN5d2xMM09qMHJMdTAxNjB6?=
 =?utf-8?B?RkhwWWpBT25GWnB4YnpvYXhZTVNLMi8vMytOMjEzMmNveDRRNW5qYlFZTnk4?=
 =?utf-8?B?b0NqckhEd1VkaFpNVzhwZ1h2allHU1NrTCtNV1Y3RzhLQzYvMmM1YXdldVBC?=
 =?utf-8?B?Qkg4eitpQzVrWmVXcGxLQ0l0cFNpTnZUdGRrcDc0U3V6MGZXck93RlRHeFpa?=
 =?utf-8?B?OTlGZkRSbEdKS3RveDJNaDAyMVMwclNYZEJzblhkMGlrT2lKNFIyR0dsSU02?=
 =?utf-8?B?VFN0MzBuWXFWaU1WZXdNdFV4K0NxUFFKdzRmZnpSZnFFSDRLKzg5Z256azNR?=
 =?utf-8?B?VGt4Rmg3ZzVPbnRYM1BzQ0hoOFk4MU10OVF5NE45YkxjeDdsbWtESzhRR1R3?=
 =?utf-8?B?Mi8wbDlVYmU3ODFaWm1EV0xOcm5SVnY0TWNDVkk2NjJYZ3k2Ny9MUlZnZFF6?=
 =?utf-8?B?UGZwR1dIeE5lemp1N2ltME5vcUFwdXlEbjBGTHZyTTd0SmlOWkZRck51S2gr?=
 =?utf-8?B?anVBcmFiZGJIREsxWUdGR0F5azhFcklQd2gvSkl0RkpWNDY1RmY1Wi9sYjNo?=
 =?utf-8?B?SUVBZEdSazQ1anRKQ3R2bzNYbWRKK212bVBqazZwMm5XU2RWaVZKVThwSzFx?=
 =?utf-8?B?OFpXSCtMTHFWdTNoWUI3UU1BQWFiWWltQVUyODd3R051Y2hIUC8yNlpmUDlL?=
 =?utf-8?B?YlpRdXFKa3J3b2U2QXVoVy9qOFVSS2EvL2hmR2h1d0J1NEVlZFA5d09GOXBT?=
 =?utf-8?B?b28rWHhiOWJNQ2hYSXlEQlpCVzJOaC9Wck1ldkNXck9tWkQvRG0zRG5wZCtI?=
 =?utf-8?B?OXRwbVRleHY2M2FQQ1ZudVFhMitlaS8zZDNIci9UOXhSSVFVN21sTEYvRmRU?=
 =?utf-8?B?dHBvVFhwSzZLODNvSG9EOTQzdW05VkRKd1h6MVhYZFBKaUhJbStPd3lWSS8v?=
 =?utf-8?B?bzd2amdOeno2cEtCb1pCb3hWMlNhYWs5SWFpdWpOQVB5NVBRN0dCaTVmd201?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SL3lQIR5SyZ8zKvv14uwPxcNvLjCB9+BYJITaLHdyEFGMfpcft31Ry8xYJ0ZeeL8stoNI+/xuO0haMLh0ifGn2pTpkPOyCqQoWqyj7CVVkjaBtPHexasfgDq8zsxy/Qj28ncJWYmvts5/NUxv65k0MfSMJiaMZ3c6ds+I8wN5EQv3BJP80JdTS5lfpbK5orK2IrYPWujXPORR4CeCQtrB1BO0tdVOJDJLARGTTaMNcZ1Dk3ZutIJGT1qg/jE/GvG7T5hZ/kVa9vVIqBhqzkHZCD1AazBn4rDWDpOkfToJdNLOEzFVwsOQq4DAPfD36mJGBA7mvt2zHf1Qc62jGWAawdQGwu+LPPJlkxsA8hrev2Qz+K22TGbGngA2Ie7U+lQ2reYqNKnQJWNqvjutXt+vISXVacUj9XaDwxyaj+d4NXE4S23oQYjyXikvwq/z1oOlxwWKIDjFp4FwGaUQKrsjhn44Pu8B6Hxn5TzLDJbSjMbXOvsfJ+rE9YFeXZgKUGLtiZEKDyywseE9mp4Uo+xIvPR7wG9+zd35HPMOHSOegouPKTN2OraDtj7yJTixxXCHvRIH+og7TlmG9nSLIjP1pGFLB0MHCTb/kZXn2LGMLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d80b032-f490-469c-4053-08dcf535a346
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 20:43:10.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv34rYDVGfoWh0+tJTIpD38/+akkdo6+YVcklhM4wbYMi9owvFz7crzS89Wj0cbzfES1G+8XhR2l4HvuAF8pJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=707 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250159
X-Proofpoint-ORIG-GUID: 6y3vUy7w5da4d7eCPmkclLf6zSRkI2Zx
X-Proofpoint-GUID: 6y3vUy7w5da4d7eCPmkclLf6zSRkI2Zx

On 25/10/2024 12:58, Christoph Hellwig wrote:
>   
> +	/* check that the data layout matches the hardware restrictions */
> +	ret = bio_split_rw_at(bio, lim, &nsegs, lim->max_hw_sectors);

eh, but doesn't bio_split_rw_at() accept bytes (and not a value in 
sectors) for max size?
