Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433621A5B88
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171054; cv=fail; b=MG4uchSGmoJy/eP8e3wNIfXHowETfaN+CqjqMoBoG3C19TGYN6d5gykuTSGqrCkY2H3Fuy+NOa6RtZ6EfdfCY28Xr1s3RlXZ7unyAMBrjIYmuY02TNBZLhCsdmCw1djnhdcznXOai8vNo0IqnaIIg3ivzAQsw3+uVlPIwcyNaOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171054; c=relaxed/simple;
	bh=yGTIbKGEJebTOamvE4794hSGNFPdxlD6sOGPL60AX7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fcS73oznmaSJjKZaQ8t/VZ+NhNXqc3HWQ0igZM+WZ2o8KTSkkvjjI7dX7IdEItrUR28w1S5b1XMeQ8sg1vv2KtHZ1O/mltU+q8WAsPdd83AvQyMQ3bOc43x5RNNQKWoeoXfDQjdDQSqyS27Pc0ZawQL9tm45Zy5kWRwD0uCHTFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Al03b+cl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XCJV/vg/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Al03b+cl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XCJV/vg/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WBU0030828;
	Fri, 2 May 2025 07:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yGTIbKGEJebTOamvE4794hSGNFPdxlD6sOGPL60AX7w=; b=
	Al03b+clhnLWKvC7NsJCgCWyclS6XRkM0zkLrW1ilVT9M/dZ2+/hSoENK0EqXqRs
	GvfNBTtlsKI4CapWfFtOcLBfA3vg4jIgDcTrsyBxrxhepcMkrUiZ5fm3bkT8JeP7
	RIxpGgHUUascS9rvGxlx+kOmEWU61p8xS72ILA5biSX11gYn0UgbZgCoVfspPGv7
	vcxve6ao8QHuDn89AvqIsij64HIAvRpCx+P4bWuoPLyWDtnMLb6hViA4YkAPfjFe
	+8V4c/HK4UWQHCEXDQcDTsQkWCn7OraEyue3FUk6WJYGnBB3LRai5VtWFeyIz2ms
	HERord12jZLrVinE2qXmdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqmrn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 07:30:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427Cpd7013794;
	Fri, 2 May 2025 07:30:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdgm81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 07:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKKAMd/3z92Y4wy0ZFpSvqu7dvejHWNCctFMUvbMyG7EYc7aM3ADX84Dns+2EyC8iIKb41xlI21AEph9YpSyu/vaIz2+wmeWjBTL/K+oJC6/11xHOg/m7YkAdQDWA4QUyr7uDqPEv9vvQhcNDFrl5TP0jWQ4Y34kgLmLGel0Cq4yBj29Plo/2sCSIuLSQWejWjBDkSpgm1n8mdgt6J2HTjVm33/dROwv+ZS3lq29DLiQ4afzQ7efzcMzzO65eI3wBekX9jyb7HdPTpqb1csaRz1m1GtiSG3j4aw79GwosQMMyJeKDCvNeBrrMf4LVCFT4k4Wj74a+KttSI5SkoaHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGTIbKGEJebTOamvE4794hSGNFPdxlD6sOGPL60AX7w=;
 b=xDqMuPR6zL/2jFvW5fJC1r6++PI9yUGPOjpY9aJy781YvUjFolf1Q2ZSLvR9IqTv7Eedrncz2f+is0WnRsQVvzZDS6aBnK0R2clHf/1Y1eyuz4nOjThgLq7NNvTN7n3uHyFdSE/huAZLov66y9KEaTztE1G1KfgFmKn2UTYQch/RZC7JOcTweyWETWMDJeA1enrHWW4dWEpTR482FcfNhfRo2cVL7XR7PHMw8Z4OgJmJJZAbEeut1VsJ9/J32u4QG2kaa8HP+IX/227C4wgiNfNcXWvQQBYzqPYrEpeYwahyXlpUVrWwpU+jhxZn+lUJFyB7gJ3WKDc7uOZkrx8c0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGTIbKGEJebTOamvE4794hSGNFPdxlD6sOGPL60AX7w=;
 b=XCJV/vg/j18p+7Oi4x9U1K4y08hl/SB9rSFYAxynmfTVod9FkZLT9jID66DU42RAiY6VxisN6FsZ4TjmgZNWa1PrhH8vipufDlLZFNNaSjz1KDfYjQKVaM4+p5Qr5yCtrUfXRmP+PjbpGu6kzYWPjbKTHRz7sX4xkRMx9cyzPEo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4597.namprd10.prod.outlook.com (2603:10b6:510:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 07:30:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 07:30:43 +0000
Message-ID: <72be594c-5c22-445c-983d-bb778c000b18@oracle.com>
Date: Fri, 2 May 2025 08:30:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use writeback_iter
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250424082752.1967679-1-hch@lst.de>
 <20250502064839.GA8185@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250502064839.GA8185@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: f228e24d-ee44-45fe-0754-08dd894b3f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anhEaVFBY1FHb1FucUhpdmErQXJCYWc4NUZLTlNsYWNsMFp0M2F1ZWN0VHlF?=
 =?utf-8?B?UTYrV2liZWVYb255RXN6VW1sN01mZStjSVRoclJRdkNNWmx4UVdpcUt2a0NN?=
 =?utf-8?B?a2Y2MnpoNFJra0NhSWFIVkpXdWpmUHVobENaSU9DRnlzR1dsVy9nTFVvdE1J?=
 =?utf-8?B?UmViQ3lZdDRxaXBJR29TSFV5M2ZQTHJmK0ljZ0YwaVZ3WFh6MWVFMVhZaThk?=
 =?utf-8?B?NlJVSUtYZlNuSEVLRGM2UXhmK1JmOXlDUGVWZ3JaV012K1l4cFB1ZEhSS01K?=
 =?utf-8?B?bi8vWWNiR3pBU2dqNGtFandVaUU4TTBRUUYwUmM1em4rcGduaml5RnNzdHF0?=
 =?utf-8?B?T3ZsWFNCM1hVQ0xxUmdITGxlNW52UVdZR1ArWlI2YUVQWmFFMHVrZmpvTmVZ?=
 =?utf-8?B?R3RZcTFVZEI4blNDNWdQSForT3JoRVdlTG5FTXhtWWJSQk53MUJaSjNIZjBT?=
 =?utf-8?B?ekZzcnByNW5aVjlmVEJhZjlxZE1mWjV1YVdsNDJDRUhDdEM2Mm90SlZaN2pQ?=
 =?utf-8?B?WG1nWWdXNE11MjFnWTNickM0anNuWHFyaUJNclowZERsdUZoV1ZZUUQzTXBn?=
 =?utf-8?B?TWtPYi9IdmdQUDQydVBiM3NFMXp5dDlxNHFPWU9hUGZZdDFPdTJkbkJ0OVI3?=
 =?utf-8?B?WXhpOTR1N1ZZWlpEd0MxRjY1RXM1akJNN0JONEkySlFOeFV2VkJ5OUZjcGpw?=
 =?utf-8?B?UlkvV1J3Y2IvWGxRcUpHcHlpeklIejB6cmdYbVVNQnRaYnVsRmJtTjZrTjd2?=
 =?utf-8?B?TUlCeVYzRG9wVGlEK21kOUxVTXZ0N3RLWENkckNsZ05zaUpIY2twQ015d1o2?=
 =?utf-8?B?M21oNHhTVy9RUGRTWjVXOXJPKzlXcDJaTXpmczdQdlh3Z1JYLzBESURXYWRB?=
 =?utf-8?B?cERHdmVGaG1wc1pJM2pvUG1lQjEwcTVUbVp1UFMySzJOZ1EwS3RUYnNZRVFr?=
 =?utf-8?B?WXFLUDVFWW1ubDJvUFpaQXNSY3VWMCszUVMrc1NtUDNYaTdQelhLVGF0VnJ5?=
 =?utf-8?B?T3FRS3ZiZlBJMk5Mc29qUnJ4eUJCUlNjb3dKN052M1hJbHRxbkhOeW1wQ1Nj?=
 =?utf-8?B?eHY0OFRyTDNicU9DVVRoWU1sN1JwWERNdjA2WFBYRGFZZm1GOE5aOG9RYklV?=
 =?utf-8?B?OTlxUmYrczZWVnREdm5uQzVVU1dzb2hEcGlaMGF3ZjYrUnJ0UE9nTDVYTEZ3?=
 =?utf-8?B?cjZJQ0VXU0RJQ0tFcU5ZNE8rbG5rRDJ1d1BvbFNDdnhLNzk5R2V1d2JCUEdn?=
 =?utf-8?B?L0hFTU9SbnlkSEJldkxBcVlySU9Ma1YzN0Q3NzlYcUR1SjBkMU51c0pYZjVL?=
 =?utf-8?B?NFhGazNMVUZmU0VuT0dtTDJ0bmtFclRRaUhKV0ZpMnNqU1dCUElEbGs3dVpy?=
 =?utf-8?B?VzIvNjNlWkNyMktzL2Z1eVZiUHZPNGcwckljR0tZQWsxTDc2cm9YQlVYZ2dm?=
 =?utf-8?B?OG1HdVg4SHhOYWFUQm0wNTdCRmFpWGlrbVB5MHIxNTBLazF3VkVzZWNJMWNU?=
 =?utf-8?B?Wm1DcWpKTW1aN2pWa3N4QWpTNXFsaDI1WCtkNXRZdE1tM3JlU3NwMUFaMVdX?=
 =?utf-8?B?b0wyZ3ViZmVrNWY0Y25hbUY0eVJnbkF3dWVzOGxWMzZKRHQvbTBBSXh0Q1FS?=
 =?utf-8?B?QTBlajJiWEpJMExDY1F3eFJCYUdLNEkrOUdsUEhKeW9zbVlwbkt5T3hUZ0hr?=
 =?utf-8?B?NHpVKzJEbTkzbUxjUHhXQjBDeVRkaXpvc1ZtcS9mR3lSOTIyUCt0Vmt1VWVL?=
 =?utf-8?B?dGljZXQyYnFPbm5oSjl5TWdvcGpYSjM5by9laXFjSkZiaTErVVhRaVFjRlVr?=
 =?utf-8?B?Q0t0RDdtV2Y4K0dRSXB1T2FKdWM2cE5raGFxQVI1RFVtVmx5ekE1MWNCWXE1?=
 =?utf-8?B?cWdCRDBka3ZZVW1xa2dGd3NsNmNqM0Y0aGRpYVFGaUZRMGpMSDVnaGFBYXdo?=
 =?utf-8?Q?tEAfd8DiVUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRzZG41QjhZejNwVHltdUxyaW5ITURYRFRpZjJaWWN3d3BncCtIbnl1dGJp?=
 =?utf-8?B?NWZZRDNjV0NCZGkxcHZzUWtDYkY4bFhkclZybCs5RHVJMnBNbDQzU3djckNZ?=
 =?utf-8?B?SHVLVnZ3dEVhanBhcjhqRVNhYytDcW5oQ0ZTNHBzNE5sMTdSWWd0UDZUa3Uy?=
 =?utf-8?B?WHdYVGZRRXAvYmpDbXdpL2JLM0FZSjM1RGViUmlud1UrUUttMmVXQ0VwRGRs?=
 =?utf-8?B?QURlYzYvb21lYlUrTFZwM0dneXl0ckR0ekQ4b1NiaEtiOW5meksrUTJ2cUZQ?=
 =?utf-8?B?aXMrRFdycDlVb2tLNysrNW9vdG5nMXdmaEFWNjluM2xoaTlaMklaNkFrNjEw?=
 =?utf-8?B?ZEE3QzRaYVZvQkdFeENJTEwreHhRTXZGUC9rVHhOeGU2eVNCdWdkMUs3Qlc4?=
 =?utf-8?B?V3F5aUVUcTMzdEZPVWpLdS9EUGRiTXZyWmpkeXdDVzlaMEp1WG1MVXNLTGQ5?=
 =?utf-8?B?OFlCZnVZeUhQTUV4UWVOU3o0ZTVsV2pYVW5kK08wcHQ3VkRzVmVhV0hiVWNL?=
 =?utf-8?B?aERobHpvZ0NpTGRGTXRQcGVzNzhnVHQyVkViekFHcnVJVVhFNTFvVDArYmJx?=
 =?utf-8?B?RXkvVEF0V2Y3N2I5emhGQThDUURhOUp3SnV4S3VQWHhnUmgzNU84QnhRN3NS?=
 =?utf-8?B?KzZMV0FHdUFxZitVWkg3Y29TNnR4T1VmT2ZMYW0xVy9oV0h4NmVVMU04LzZV?=
 =?utf-8?B?VUxPL1kydjltZHBQRzBETm5PN0l4Rjl5TFlaSEREa0ppbWgyWElKY3NLL2kr?=
 =?utf-8?B?T3NUZjEzZmV0dkpWTTFRSUxNL0N1L00xVnRDaFAvMEcydmdrbEwwMUtCOGNz?=
 =?utf-8?B?OVkyRUNWV0RxQTY0R1NGUU4yanBud0lNbmticklkTURTblY4QVFLeGEyVWVY?=
 =?utf-8?B?WkM2d282ZDJUUDU1ZW5TMEdJVGNkUGNXUndPQ25tTmt6b3h0eTNwYm05RmhD?=
 =?utf-8?B?czZFOUlSck1HdGJPdW9pWDFYTzR2dlJIN1AzUXkvWW4rQVFWKzBSQjNucjRR?=
 =?utf-8?B?a2ttQUxqVzdvZTAvdzJqOGNSOG1pQTZ6YklZQjc3NWlFV1g3MVhjMzVrODlr?=
 =?utf-8?B?dTY0cFNCampmenI2ejJRcEhxYkovenhrZTFHY1pleXVPM1NjTEVVeURUTXA4?=
 =?utf-8?B?QW9yci9KNzdiVFhzT25NdzUyamhQTEo3VjB4RzJGak5MWUcvcExEbUhNRjVj?=
 =?utf-8?B?VzV0Sy96MldxVFgvNkh2dGZkdVdoK0RsYjFnb1VzaXVwc3N1Y0tKRFYyUER5?=
 =?utf-8?B?czE3Vks3SGFrVVdDQ3BjTUhnS1B2RUlvWmVac0JmMW5hcGdyYmptUFNzNGpW?=
 =?utf-8?B?WTFkcXlIc1RmZlY0dTdwMmFNSDRUL0hrK25MWVhTaGluUzc1bW1VWm9QUnZn?=
 =?utf-8?B?WmhIOU91a2lvd3RaWjZsSFUyVjhPVkdxVGtBcUZFZGd4M0lYYzZBUWt4aWZP?=
 =?utf-8?B?QkZ3aWRHTXZTdjJXOUZ4TVRvb3FRaFhrTHhndE9GMlVQTmQ4dFpwVnBwaFJR?=
 =?utf-8?B?alM2SkNOVkFWa0dMa1NyOGVGZDk4cmNLQkI4U3BsOUgvYXlkNFN1T3JGcDQ3?=
 =?utf-8?B?SC8wU1g2eGRJb2xjUkNOblVGaGM4aU9aZ0RyNWQwa1A0dTVSNWltdnJMelYx?=
 =?utf-8?B?bDJDNXFZeDlNeUIyNHpoVDBnZURwRGVHK1V2Mk1BdTJjNGpubU9vZEl6OEw3?=
 =?utf-8?B?N25GZXYvZlp5NkhWNGlMNUhKZ1hoTGRUNnM3YjVZU3lDS2FBaklzOE9nWldY?=
 =?utf-8?B?NDZYMWpKelhTRENDdlpXcmNtVXkyNWpsWHpTQjhGTFQ4VjFLTkRkY1h2QTl0?=
 =?utf-8?B?OW9CWEZaaTRldXI5ZzFUYmVvajhkcUx4bzJnUTI5ZzVGYTdsNzZPTlJNZmhh?=
 =?utf-8?B?TXR1NkIxZHlzbWc2S0RoTHZCdHNsUXlxUFpxdm1hd25JMVFQR1ZNSlNRTFFR?=
 =?utf-8?B?WGtGMi9CV0VJV0hVUm1BM3A0SXplNzVkQ0l5cUtSazd5NjlvS1gxWldLMThn?=
 =?utf-8?B?b1dYbzhieDdEbmc4WUJiZkdOL1U4d3R5UFJIVEpmWTVJZkE0RXNLWThaL2Vi?=
 =?utf-8?B?UFM0NU9HUVhXT25lcFVKZCtDTGRFa0FDNmZBUmhsdFhHMExTbmNZUEduTmUx?=
 =?utf-8?B?U0VjU20zZEtjQVJHcldsTmsxNjYrMzdUbkZpOTdKbC8wek0wZ1FWN3owRVoz?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CGwxsXpN2bkwQQSDkJY+oG9Ov3cizXLDKwOPfwIIEbhjh3GMARpZHgj+TGox0U2lKCMyRMqcon0DoH1aCCfh0YFLA1jny+Vuqxh+cxb7q3l8wdj6xSTXxo0RGMCbMVB4AQXx+OQMYWI4fU/rE4QhyJwtQFREpgUY+l+Oc2o2zD+4ayHlmS84bPUkQKM3XlTb+7Jji9PbEVL04IqutLag40vyrxRG1cfEi6qwlQwk0IzPaA1J4ZyzjWcrj8Q/kT+cu3y1NxFNZgCMzpNMExrPBT+UIjbEHRfYOyfeDQxVv2I76qYcwH+Wj6njcskUCD9JyT4sokg7WIRq4FQCDvQLxBh4ev8atPUbQuydIjHnFsePIqv6ghJg6FK+B7g8h8oNpaWdwBqYYBf5YhJZrDkMZGWdLXoYFVEnQzUK6KcW35bVf4x0LZof+cFdxWabY/DHyr5ygRt1udQnSXM9eyNaUWxeHrTSaq1wM2XAK/4lebddeixDv9gZgd1ecaFqlzi4EfPnjrTQKRXbR2zyZeN1J4gpviwHFc4Ea706HzjQ6PVMbw2tXMOOtxLQyOmAL6RcFVs66E4qTNEOVcCsfdk9V3gXlwmJ1X9AUsGefe5AX2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f228e24d-ee44-45fe-0754-08dd894b3f2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:30:43.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUtwuAZgZleOgFPMdOS+7AvJ2OcGs8rprmykajyFOZ4e52geg4Lzvrrm+O0jDL4TWzWnnPXEBf+3opoiGZwuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020057
X-Proofpoint-ORIG-GUID: h1zPdg3DaPyke5cgltvwAWQlZhOYQWNC
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=681474a7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WdBv57gmpz2XbpZSHCEA:9 a=QEXdDO2ut3YA:10 a=6pWzAbgKvXYA:10
X-Proofpoint-GUID: h1zPdg3DaPyke5cgltvwAWQlZhOYQWNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA1NyBTYWx0ZWRfXz4YbXT8WMBjl WIposBCPCmwXWNHnlyFm/421gg6d+NK2sRpJsr0TM1TjLkjijrc/kfoGTQrtkSocTz+XPY1/NjU AGO7AlTX4tZMTT526uzzuhHyIno8zGHphwe3+no3q+6nXlNefRH1WgLJHR5+VMxOd9AE/49nbq9
 SXJQHsgJ7+XSk/9I3LUbv9NPolUMr6FzGLKwhBrXwgqc2oFkbAIWJINVnJ1t/3gh+54qaawKLut riTpBsxxwbH3ae3ro7Ecd19wvAtCD3YyOJqGkRLATXSqJvvvCuzcwogcOHCzZrK1rUuW7/o2wQR TjZwFAsmc8yl8OH1pGP8koFF5UZxmQfyZ0pCIYoDo8o06RSMzHx2YR+9hWdJXQ5NAOPx3k0offd
 9WhbtebtvMQA6fOcmOViodWtfp41iPHSE72/UHrRchKaIFDlLwPE6KQlolLnB5svcq11iMAZ

FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>
