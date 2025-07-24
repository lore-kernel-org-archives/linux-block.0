Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4325E47D
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351592; cv=fail; b=I3T4pKgqGEs+w3p+Eoe/sSwGsDrnKg1e/dD9vqhrTTA/h61m8y+vFoNl7KPsdIGzyNYUCpZUeuYPYvjzVxnyNuBiu8DzogUz63cM+tUO91LYRG/qCRDSoHaGgjIHi1HKULlsfMX5twOyL1Td1yViwOqYgq1kaK/0bahcBI+IXAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351592; c=relaxed/simple;
	bh=RzCEC6kxscq3Cz0cKGahxovRMZLfdTjXpUYgLObwpnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNQdKjCuVwbrLnx2oc8nSiZPs7v2r2UT+hY30doVVDGvCC10o/tpCFI3WYJgnUscWLNTgh+AL+87cb2QxtnGXPSWiI7TYP7F3Q0z6STNsstVooNJjsj6WDa4Pig4ndzwD6L8nT5YfYZ3eOjtXojhVGQUx8K385ggOlFORjDVPBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z4ik8ijj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a1p7P6L7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4ik8ijj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a1p7P6L7"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6tuYQ009402;
	Thu, 24 Jul 2025 10:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m2rrp9Tpiu0H16m1NoNn9rRfRvt1mKXKWGgeMwrS5mY=; b=
	Z4ik8ijj7ehFB+qL0EiuH228ZGca36XBKIxHop8jSpnm2HCuF2Jpocuy56GoTi55
	XuNjVTc2savjkgT2CDtExZzWCBJnB6xkRqdpzTz0eiUuZd9opz4UMwlBlkMfqtyh
	zXlUZQl0/PYiDqQ2QcGRPE/YBp69ki0CEsYd5rkD0ApAPPnJxXzUu+X5UstTnohp
	7qUe8RYf2ctr6By0Ui7XPkUvrILDr91BUtXjuvFgOGLJdXyjVEkOIHC73rsmir3/
	MHqKDgkE2ZNyOYLwk2C/AD4P07i7cYB741VR2rjwXwwO3zneLAWFGOBloMJl059z
	M4hujNNn0Y4DqFODY4Li1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2h7wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:06:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O8oUaK014546;
	Thu, 24 Jul 2025 10:06:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tj06y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj3L3pAszWjmqJ2KeKRxTvUiuUn4TwrA5Od2LRZ78sar5/Xtn9gu7fuzarVy6sGBygCh7ULni9JhI1Fotlu5zU/wW1mJfC1JfbGC2wJh5hf5iKp2vZ+vm+D7YkUSV2Mp3h8KVnUrHRZUeE/j4nIVZMUfvkNEi8Gt/i7ZydriBu6LiLYEUFyeFpFXuRCII2mIkCnzO1/4EJAI0nM1QBgFbrh7GGaCNqfTYl4HcSJjJBrSIHDNm8XRcldGjP07lgppyXHSHNV985fqFq6Sxgr2mq24kU7jtIOMHZA0frORPWX2kv2Th7ZL0JlQ8fopyLwnf+X6dud+J0YxklgSmEQ4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2rrp9Tpiu0H16m1NoNn9rRfRvt1mKXKWGgeMwrS5mY=;
 b=rVJUOA4l1oFfK9fS7YmkrexxzwxfvSePc+A7aCdTY8OesPM9Py6VPjO+z5u3Wma5aexQaVmM9nA6ZKeK+SIRr+4yhtcWEANAN18ztmPI6ZplLcbh3WmaKAzJdmLfxe2NCFoHhjw7ZninpdU8EpO88r6VEDMYFj2AT6t/ZtqhaNO2LxNZH/JeZ1UxwdeGNIzLqqsuDEqMJrndJ4FYZaNz4Z3k966od4gkWWbjE6MVrGkRcZVLZHhPIsFOWY65I0JZyJapZ59sjeKBK2NIzFovDwjdlLpDLEObgJzDWE4TWA2kyYAjCCl7SsQ4m5UNoD/PU410XVHvQX9Gofpxj7WN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2rrp9Tpiu0H16m1NoNn9rRfRvt1mKXKWGgeMwrS5mY=;
 b=a1p7P6L7X6PSejy0hrx8GVNrM1hmTY69iUlyNpRkP100CVROBnKJ/ZSv8ie/XeTvru2ELIcvMBCHKdFNPTGiCVxb+79JYj4vLjzaJ/bphn94DHVBc2olPZT9NjhwdFK9eD9F4xKIaX3Qwr1j+Lcg1Mt0QcEVwSkcIDkF9+du2fE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA6PR10MB8014.namprd10.prod.outlook.com (2603:10b6:806:445::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 10:06:18 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 10:06:18 +0000
Message-ID: <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
Date: Thu, 24 Jul 2025 11:06:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        hare@suse.com, dlemoal@kernel.org
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250722102620.3208878-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA6PR10MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f2936f-e9fa-4e48-38b2-08ddca99bb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RS9Hamx6cllOSWFTZkZoR0N5MzZLdnlaRmtPWFpJejVSNlBiTHdYaHVsL2lV?=
 =?utf-8?B?MFZ0LzFLRVlNSStCc1FWVTQ4YlZUTXJCdW1vZzFVaTNpb2tlak40YXJDbXNJ?=
 =?utf-8?B?YmFtcWFrMWZhTUZuTWdDM2Fjc1I0MTJaV1o4YSs2S2ZGNis1V05aYjRjcHl5?=
 =?utf-8?B?ZzdoNENXcW5IQkVOelFadWh2eWJIMnNRTXhjWTlNaHRCY0dqeGQzdkxUZ0JQ?=
 =?utf-8?B?YjhNMUhzMURSYmlWa1JNSE13MytTVjV3N25MTzZZQnVKOE10TDZ6N2xURU1O?=
 =?utf-8?B?NUZCeEl3VVZ2RkRwejRGR09VTWxUT3dycSs0S1I0WE1NdXMzL0RQbGpvR3NJ?=
 =?utf-8?B?SURkMkdmYzk0SmlnOGNCMTc2eUcyN1Z5QWNKanN1SkxtaW9IekZZZEtpNjVi?=
 =?utf-8?B?aXN2c3FVRVBsZUZ5RFlJK2hLMkIzeUg4eXYyTEU4UHdkK0l6b1dFeERXTW0z?=
 =?utf-8?B?cWlUajV5L01ZN29ZZFhhaloxU25mZURZTVZBWlNTc2ppT0NCRngyRTZVVXE2?=
 =?utf-8?B?YzJpc0JyNUgzVk5ibm1xYlNZSUNHSFhkRnUzREZaZ3FJWUdkbFdkOTFDTU1j?=
 =?utf-8?B?VWtrbDdhSmdGcE9DK3ZaR2QvM3dWWkhNa1N0ckdIa2pKa21xRGQyaU05MmQz?=
 =?utf-8?B?NFVINy9OdkhQNm1uOWlESnNUY0QvYkNmQ2JTL0dsWnpnaHpmWWdXc2lSRkg2?=
 =?utf-8?B?REZ6RkQyTndOMldqL1Q5VU5iSnY4ZUhSTkp5dE1zMWhaRXA0dW54cFJ1ZTJE?=
 =?utf-8?B?Y3JBcGFKNy91Mi9oMjZmQWJHMHlwMU1Nd2pDQm93bnhlM2hMeHNpV0tNV0pa?=
 =?utf-8?B?L2pRQVBaZlZoTWxTYVllRHVjc0RUNmtRazI5eHN2UFlYVXN1RW92ZnBlYW0x?=
 =?utf-8?B?cTZ1Q081ZCtqbnZ2dEhkVHY5cU1jYStDRjhHVWJLb3p1N01KSGg3VlhvRUZa?=
 =?utf-8?B?WjdRS0gyY2lnUklWMGhBQkpCYzBLKzFLcS90QzJwUnpTclRuYXRQNzBNTVlr?=
 =?utf-8?B?ZTlpSi9VVVFmYVliWVYwdDdMUTlibmQyMThIV2xBZTdDWGtMdUp5S01GYjFo?=
 =?utf-8?B?QVFnV2IyMHp5Y2R4dlFZbXJrRHY4T3ZqTEhQYlczUEtGYXNDdVpuSGQra3Yz?=
 =?utf-8?B?MzlMOUtwMVh0TStySXJmcUR0NytPTGkxcjd5WHAvNjFQVzlLNjMwUFZDc2RG?=
 =?utf-8?B?Zmw1NEZMaXNMTUFLTzZ1MW91OXNvQU9aL0ZpcldaU3VDM1hQKzB2WVVzV1p1?=
 =?utf-8?B?bTBIeTZaWGp0OFRoY2RROXMyaEM4TkUyQUFzbG5xRjJRak16L0IvYXVWalpS?=
 =?utf-8?B?QUpGcEw1eUJveDFSTVU2cUNrUmZGeGJSZDRpQ044WUg0bU44Z3RsQTd1THVw?=
 =?utf-8?B?L0t6QTVwY2VBQTJ4R05GWlN4a1VMQXJNaUk2aGNIaEVkVjNFc1ZhcjFZZTB3?=
 =?utf-8?B?dTFCV0YrMkZyM25qdGxmZVIvZm0yUTdPaS95bmZhOGhxUTR6WEtKRXZjVSsv?=
 =?utf-8?B?ekkwTER3L3lqSmtHSTZhaEFxZ3ZLOGFMdjNRZ2J4eDVTK3U3bkc5U3VoUHRG?=
 =?utf-8?B?WUczcTdRY2VaYUZ6ZlJ3cndwRFA4VHBrbTh6RmJqWGdKSHN4UEU3eFlZdURn?=
 =?utf-8?B?RW53Z3NnWms1bkxZT1ZzNzhSbzZ2UlMxSTJ6dlVWditQRkJmWVlVRGxrZW1m?=
 =?utf-8?B?NUlaUncyS0pSUEhHNFBqZnZaKytwN1dYYUFXaFFwUk1PNEVlVEZZVnZZOGhy?=
 =?utf-8?B?S25lQ3h0QUhjcFViQ00wUjExOFlqU2Jxa0VCREhvWCttODFtRDc4elRERXJa?=
 =?utf-8?B?UTJ5a1poTWdBMWFoeTM1cnRZV0JROXVmOWZkdFFYR3BtT1NWTFpLN0Fjbmx5?=
 =?utf-8?B?d2tqQUwwcjl3KzhhaEs2YVdXS2Q3YTJoMFpHbXIzdnFtb3g0cGtudHdJTitP?=
 =?utf-8?Q?Eojh2CDU2sM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVmcHY4OVpuMjhLMGU0WlM5NTA3aThId0tNN0N1Znk3bVVjY3BlWm1WcjBV?=
 =?utf-8?B?M0tNM0hwNWJNZTlTYndRYjRyTjFQaW54bEZSMDBTYmc5NlFpVkRyMGZpcWtk?=
 =?utf-8?B?Sm82Z1JueTR3NW84TEh2L0NYSDM2T1pORVFvR2d0bGJFbzRLWVY1MHRXb2JX?=
 =?utf-8?B?ZFFRWDZKUnRiQmlFYmdNZXdWKzNFNGRmZjJSWGRtQjhxUjQvbGI4R3lpazI5?=
 =?utf-8?B?M1lNOTlmVjUvNmx1c1Bhc2IzZVdCempCRi9oWldGaWRUemZrbkJrNDZzVlhv?=
 =?utf-8?B?T1BlV2ZvZ05MR1lobENhQ1lBbGg0aDNhKzhiYkZLUDJGMnBYV2NTYTgycmNz?=
 =?utf-8?B?czBzR2VZc1ZvUklEK3o3Q1h1OCtGa2cxSU4rZ0pHcmNNaUdBTkxDRHFhTVhv?=
 =?utf-8?B?R3BLNXRiemw3MkU3dWxmUExiaUNVQlBKZUttUGRTU1ZnTUhndU5uMGRiQVZs?=
 =?utf-8?B?YnhINnR6ak5IWkkwUWh1NGlYK2tKSW00ejliT2JqaGYveXdEa3VuZEhyNkYr?=
 =?utf-8?B?ZU9McmNpVnhQYWZId2Z1Znptelo4bHZiK2t2UVZuN2FubGEvRHdRNVlOa1h1?=
 =?utf-8?B?SVVQNmkvbTFrMXdPM3p4NDRncDRxL3oxVHNJSk5DWk91WVhtcG5PSXhLZkd2?=
 =?utf-8?B?c0RPZTFoNzR6bUliQWZYeXJTVkR1a0MvbFc3SGpwL2NBZlZIbzI0eEV1aXRj?=
 =?utf-8?B?eTBsa2ZZbjZnY1ptTWtkSUIxSkg2Sk9qN3prQzVTM2JkQTlLZ2h6VDJMajFG?=
 =?utf-8?B?UVRiclNyQjJtTk1ndTIrQ0w2MXBuaEJaWHhxTDFmRkZPREZCYjJUS0lBU0pm?=
 =?utf-8?B?RGlPcmRKLytXK3cyMk9DM0thNHdhWFpESDlHcFBTRVRYZi9tR1JLU3NvSVlR?=
 =?utf-8?B?RHlaOXJ3Q2tObTJzQXN1U1V5V1NhbGhVSytvb0J0WFhIQ1o0ZHV3dnRVdjdO?=
 =?utf-8?B?UXRtSnErRGt2Z3IwK0dzdzVYb2pWSTZTbVI0N1Naait1WTRYZ1E0MGVnVWxO?=
 =?utf-8?B?cmFDMTEwUm9LRUNIS1I2OWUwSEdheUdSNlR2Zzh1N0NGbWJYN01WU2JINGtX?=
 =?utf-8?B?aTgwbVNJd2tFdVNGaEp4VTBoV0RQL1RpV2JQSkd0SCtid3cwVHhROVpIaXNX?=
 =?utf-8?B?RDN5VzIvNHJIQlpXcGJZMnpHanJWNVhiU1BjWjQxcHhiZTJzZ2hNSXE3WE1n?=
 =?utf-8?B?MGRPUlJiZng1YUlKTGUvcFk5VnQvOXVmUk1KMGY2WDVaZlJGUDJUazRuR3Iv?=
 =?utf-8?B?ZHBoczJoTDlyZ2k4ZGkyUnYzcWdFQk1hcFJWZmgyU3BwSTI0R3BWWi8vRlNy?=
 =?utf-8?B?SG8rVHlSbkI3WGsxVTIvbHZEOGxOanM2Rlk1TUFNNEVEOVY4RFRrQUZwdmdp?=
 =?utf-8?B?VVR0OG5pTEgyTUt4eUozMDA1OEw1ZDQ1Q2JONnFBQ21lbGduQTBzaHV0VE9F?=
 =?utf-8?B?dHdNTHRwaWtBd3BaSXd0cjFWU2hYU3NVWlVDNnJQaWtRVG0wcEYrZUpVaUxp?=
 =?utf-8?B?VmFBeWlJVHhzbk1WQnA4NWp0UmdDSVU5VjkrRXBHVkdPNGxYNGgzb0w1K2x4?=
 =?utf-8?B?amVSdW1Yck91YmxoTTVpQ2FqbkxVRTBQR3A3VVU4YnVJT0JzUzRkSmNZVVl4?=
 =?utf-8?B?aS9qd3RSTTlQVktHd2lRcjBhdG9mOTVFZmRRK2FUQ2x5WWlZWndDZ2JNcktN?=
 =?utf-8?B?NDJBOURscFZsVXRqQnNUZ3lnN0Rrb0d5Z2pWL3NpVnZzQjNoVCtUU1J5MDRv?=
 =?utf-8?B?ZUJZQXJqTWJLVU9mQkpXQjJkc2ZSV3lxSVlEZitwRmVFRk90S05hYjZ5a2Ri?=
 =?utf-8?B?Q3V1eGQxY01adnBieVFjOUhvbmpzUnJ3ZzEvckdkUUtFYXF0dHhiRjZlcUd1?=
 =?utf-8?B?SURSZ0dKSGYvQWFpekdwR2ZIeG1UVWQ1cGgvUGdjai95cHkrM1ZNSEphczFW?=
 =?utf-8?B?TURadXBCREoxU0cvY0NjbnBYRTFxZ1o1RVpqZklsdnhzOUJWK0VMdnVtWEFh?=
 =?utf-8?B?QnZXYUt2bDZkdDgvcElGK0FRendtWnc5NHRBdkNURkRqbktwY2tSVFdpWEF2?=
 =?utf-8?B?ZlhqQSt2MzBFaXk0RTZrK2I2WWhqNDlvY3hrY1hFWG5IYjYyWVdiUGJ5aHp1?=
 =?utf-8?B?Q2k4ODZzSi8vbXAwaWw5MnlPSXN3ZmxSTGtqbWZLS1FrdVczaWlNT0ZaajVp?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rej9oBTBe9T1rr+MItl7KPstVwrOkme9uQpWcZpLyyRDHcgGX69Bxpc+jxTE0n/AAg6OUIom/DbuRMTaUTuNCx0ObtSEpyrH6DDer/n0E52swW492otrOQeeK/oMLCE6PJnQipos8Pj2azt1cKj3sluFnmiJFWnbgkX6VIfcYew4/Em8r4EKjFwQrTzmxOJvdsmqfwQICTtN/H4THi3HFdT/q5s2+OhQE2ZtDxVlmvrbNP5ijUTtkFjShJAol+2U1Frx3UgR1N0dwM0mMEuBuJjjZM1Ku1ZhlOda/8wkOkW5TPfbTqwWTFnC6UK9tYSX4H6PY8Q503QvKK5PlDir7j+Pa7DqZN3SXeP67XiMDnEWN+m7JZfxy6QsHI6KCHNpM+XsMeZowYhuZwTdjL0hTqD5SFIcahfXU61SRF1m/opzo/kkZ/z3/DS5tBv97wwwki5Dlj8hnpFtinol0L9sKUkK1HuUIF+I9pRgk1ps03s3xjB8vPgTgt6S5tVBwblTOmHh8/SWN/HT2szHDqg8Jj+FFCsEWmHtyoNYDbqz+7kK8FDwCzY3rgvujltePgao7JpPSchJTGpmWKPCHV8XxkQJkMiMHlRJyLWpJFXmcX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f2936f-e9fa-4e48-38b2-08ddca99bb12
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:06:17.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruj3peHxa31uyns0fn4oPeS4L/oWImsHhNjZmqWlnJLeXsZD2iDg1cUirfaFeJCuqG75FR/mz6otrtTZC4CFgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240075
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6882059d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=fO_fDZIbc9CCpDXkTfwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: prmLuM2sTCPdJvtbwECjZnBpo--xtIWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NSBTYWx0ZWRfX2JXE0i6FoYtS
 S4nfbBlnRsJxJvlMGt8eCJAyr9yMvK9BgpoHJI7xtK1N/Qn7cIaOO1XcLOsVgASn3PxP9SKOM+u
 zi06qcnczuQuETwLLyK+FwiRA9NnOuUnS+0H+90rw+97guZztbfdepb3mF6GdacE/hpo6/9zEW2
 K78TaZ2DVMhz2S5/rUgLvVRniOrL+uen7zymx0EMH7r6eIwhyUHi1JfzbJ7le0KNzoI+IGUOKHk
 bLdkpZdWMNM3Fh3SBCCZTHiqVQcxS4f6JGGT7F8uRk9oxcT8rXGlR9fTlAHkr6MnDwcbtuEMbxN
 VzlS5a8Ngm9ZrQr1L+fupMaeqaPq3Itb83u22ISQFoA5bkV3FwPlviAdKW87pCGmMsO1Yqzhp2c
 2cHa7wGFTgce5lzi9QFZREEENL1suNpiHyNmFik1+OzPPryyiOUOUSH+vaj/fxldBMRkmG6k
X-Proofpoint-ORIG-GUID: prmLuM2sTCPdJvtbwECjZnBpo--xtIWX

On 22/07/2025 11:26, John Garry wrote:
> The merging/splitting code and other queue limits checking depends on the
> physical block size being a power-of-2, so enforce it.

JFYI, I have done an audit of all drivers setting physical_block_size 
queue limit. I have doubts on a couple, but it seems that NVMe may be 
the only driver which does not guarantee a power-of-2 physical block 
size - maybe I even am wrong about that.

drivers/block/brd.c - uses PAGE_SIZE, so ok

drivers/block/drbd/drbd_main.c - uses bdev_physical_block_size(), so ok

drivers/block/loop.c - uses same size as LBS (which must be a 
power-of-2), so ok

drivers/block/mtip32xx/mtip32xx.c - uses 4096, so ok

drivers/block/n64cart.c - uses 4096, so ok

drivers/block/nbd.c - uses same size as LBS (which must be a 
power-of-2), so ok

drivers/block/null_blk/main.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/block/rnbd/rnbd-clt.c - drivers/block/rnbd/rnbd-srv.c - uses
bdev_physical_block_size() to fill in
rnbd_msg_open_rsp.physical_block_size, and rnbd-clt.c fills in
queue_limits.physical_block_size from
rnbd_msg_open_rsp.physical_block_size, so looks ok

drivers/block/sunvdc.c not sure on this one. For v1.2 spec we have 
vio_disk_attr_info.phys_block_size, but I cannot
find a spec detailing it.
https://oss.oracle.com/sparcdocs/hypervisor-api-3.0draft7.pdf has
earlier specs. FWIW, no rules on power-of-2 not mentioned for
vdisk_block_size in that spec, so unlikely to have rules for physical
block size. Default pbs is VDC_DEFAULT_BLK_SIZE = 512, and other sizes
in driver are all power-of-2, so likely phys_block_size
will be a power-of-2 always

drivers/block/ublk_drv.c - uses 1 << p->physical_bs_shift, so ok

drivers/block/virtio_blk.c - not sure, as we use
zone_write_granularity and I don't know if that must be a power-of-2,
but from sd_zbc_read_zones() we use physical_block_size, so prob ok

drivers/block/zloop.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/block/zram/zram_drv.c - uses PAGE_SIZE, so ok

drivers/md/bcache/super.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-crypt.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-ebs-target.c - ebs_ctr() -> __ebs_check_bs() ensures a
power-of-2, so ok

drivers/md/dm-integrity.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/md/dm-log-writes.c - uses bdev_physical_block_size(), so ok

drivers/md/dm-vdo/dm-vdo-target.c - VDO_BLOCK_SIZE = 4096, so ok

drivers/md/dm-verity-target.c - uses 1 << v->data_dev_block_bits, so ok

drivers/md/dm-writecache.c - writecache_ctr() line 2376 ensure
blocksize is a power-of-2, so ok

drivers/md/dm-zoned-target.c - uses same size as LBS (which must be a
power-of-2), so ok

drivers/nvdimm/pmem.c - uses PAGE_SIZE, so ok

drivers/nvme/host/core.c - may not be ok, so pbs comes from npwg and
spec does not mandate this is a power-of-2

drivers/scsi/sd.c - uses (1 << (buffer[13] & 0xf)) * sector_size in
sdkp->physical_block_size, so ok

drivers/scsi/sd_zbc.c - uses sdkp->physical_block_size, so ok

drivers/target/target_core_iblock.c - uses bdev_physical_block_size(), so ok


> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   block/blk-settings.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index fa53a330f9b9..5ae0a253e43f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
>   	}
>   	if (lim->physical_block_size < lim->logical_block_size)
>   		lim->physical_block_size = lim->logical_block_size;
> +	else if (!is_power_of_2(lim->physical_block_size)) {
> +		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);
> +		return -EINVAL;
> +	}
>   
>   	/*
>   	 * The minimum I/O size defaults to the physical block size unless

