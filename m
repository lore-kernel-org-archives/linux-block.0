Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220CE24729A
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601816; cv=fail; b=sQ6HPwAe/W9mHOaXlxjUt9wQ+SUA7hcfI8/4nx24mXlC1teZWfQgFmU4LHp7+unr9X7/rHEiCcmppJJeK2JEttFbClkoAerBE/HmoyTwaHqtvO3W1CcW0Q7zsIHNA3xcLoCbuEYkngT9uPR+bgB4TCVXoekggVUR/3dX4MNfGM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601816; c=relaxed/simple;
	bh=U3xqF6DeckSk8e7DD3zspvdsjPbytS5rfC/ckCuwTJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=opRTb/+TaLgvaFQGIvWUqAcoZv6iTTLS80wdeCS9JHBFPzllKEQpSHpeMnvFKQn+HPeUI2HEQ7PK0HYixA+Ut5OgOGb9v3UhL/jlpqin9EkKPXVeZZYnvRsRWWiAvhdz2v13Vc7K6CjTNia9LS1qc3l5rUzLWSuurYfXlWC5ozA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xu/xhP/V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I/drsHtB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xu/xhP/V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/drsHtB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDuJ7x1575119;
	Fri, 20 Feb 2026 15:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zPfs5GGAyIzwhKnAYa40jXuX2mBBBqWysV4nvTIdm78=; b=
	Xu/xhP/VWmOcaJ4NX6yNA2TKy30XcN9c6CYVSF/05E7nHbRGin78Mhz+k8xt0Uzi
	6pkcvBfFt6/vmA76S0n/5XPRpMYUEoqunP/Rv56CbOsqptXLEIqatzNHM1C6E5BY
	f3V/hPIXx9LER6jSgqD2OA8EwlrDFUZryiIjLdD1lS3q0LAEnr4CRmJNePdVgT1T
	YFPaLOWBuNPWiLRCfVi8EAJCEiKkLYbYcy3WVExxrYEuj2xPsVFoul3jbCbbXaR+
	o/KWbahe7Q9AJ3eEXV172e3BZ2FRfp9B1vjvZ1kqahQxz5y/pHsKOIO7n+Z0oiI2
	vGGNPiA244NUqzeNpQHp4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rhgc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:36:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEcAar033219;
	Fri, 20 Feb 2026 15:36:49 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb23w3a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rngssXWr4mjKKzG1kEAYIpxcEQfPvwDJICtKXHzcvt8aaPU4USh39XxG4vxMNdZ+/u2QthmqMZwTM+opOhiazx/pdmOs7OYu2GJfDEDJVSG2cl0/rjpI6sfOMZNE1FBgB1C0uXfrSkH1eedqwoaq/K0EhnoWChciqoTzg99V0AQ7m/YDJ/2nfEnkYUW8K6szjeaf2DbnJzG/HufWH0RGUZp3DpmFMrOGM40MlMHC4ouFvCiPduc1cbBXd1xkx/8tPQHuHqzfaLzxhbHv60a0OL57KbSG4PvO5NelbE0xZ7lYV92BQLsrGAidgnetHlyWvSZWhR/Uk+WkcE01/1oLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPfs5GGAyIzwhKnAYa40jXuX2mBBBqWysV4nvTIdm78=;
 b=K19HnLWp2Ith3rBcN5H6Z9wAsIGxnIIQKqTLdhjW7y8P1q7jC8wK5U6Hq2OnBfD/NlHBFwTE5eIs52YcrlZYaJIxTlJet+OqJlBltz5N/jNYZoIImaJnMy9J4QS3tvu4IY2bvDjmu4tBoeS8vDtBrcY5anO9MCchUNh5sKUf9L9EyDsw9GdrFmRXKLAmSgA/KLflACR1I/0l4cvvlkKfGUEPgvN9VW5KYTbR0PUoZ4c7aWNh4FWVrWBi5Ogrtu2X2YIG7a9oX3U6GqxwINZAYsEeknh0o3jgvT2N7B+6HX9MOMTJB41rgOsz02i3gDQEgMIHZ1I3hEhrTgSYCyj9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPfs5GGAyIzwhKnAYa40jXuX2mBBBqWysV4nvTIdm78=;
 b=I/drsHtBMX66vtclhGQpU3Pl/0Wc/YyItw6ZZLvAIt1FF+hSa299hSiZcksmdHrsA+ggpwGJdvIACBzomw2yI++U+e/4pPOvSkKpwIe2tYHpj4X3hQp8fDE9EDUomwVHjlsOMyudPB9XemQkCJlKoHwjw3mp0J0fF8ZhVA2FHpY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB4981.namprd10.prod.outlook.com
 (2603:10b6:408:12d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 15:36:46 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9611.012; Fri, 20 Feb 2026
 15:36:46 +0000
Message-ID: <26f345ba-9cb6-49ad-89f4-1ce0153fd86c@oracle.com>
Date: Fri, 20 Feb 2026 15:36:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Correct comment on bio_alloc_clone()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20260220143233.3500551-1-john.g.garry@oracle.com>
 <20260220151019.GA14027@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260220151019.GA14027@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::31) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a358b1-058f-4fb1-5898-08de7095da3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWE2aWxOTzVKVWwwYVBMU0dpUFFoeENRQTc1UnhwQU1xUUhVSTZBZ01SSXRO?=
 =?utf-8?B?ei8wMk1mL0hUM3M5bG02OVRiV09SRWk4ZlgvUWNWRU9yQ1BNaW1EZGt2RVBY?=
 =?utf-8?B?SHpkTmpxWU1pc3QvNlE1TWJKejRmMzhBTE5tUXhGTno2SXVLeGpoaDhhL0dv?=
 =?utf-8?B?dUlHUEI0bXc0bkxRMHBZQlkzb3JtZHhRUVpKMTZ2STdaOXYwMzBTcW9ReXRz?=
 =?utf-8?B?QU9SYk9Pa3M0UVVDSVVDM1BWYWp4WFRmTmhGc3ZIKzNIdHlnNy94a2E1QXhJ?=
 =?utf-8?B?YUtLR0I3RnhUcDIvclVjMHVZZVFocGdzNHdramhkQjJhZTVXRmswdlBGSERL?=
 =?utf-8?B?NjlPNlV1Y1RvR2swSkhiQzBsR2R5dDI1QUIwcVFPdURacllMTThpVEhNOTEr?=
 =?utf-8?B?bnMxRHU5ekptTSs4bHRTYi9CdEZwZ0plR2MwUXVGeEkwZDVPSFBKNHhlSjhu?=
 =?utf-8?B?VzA0NDk5UG5mMlB6UjFFcWMzcVlXNXV2cUkvMGM1T1dLKzE0eVNEeHFPWjRN?=
 =?utf-8?B?QWFpNm1jdW9mN2NKU01KNmdwbmMxaWRpRTJWenNzclhjRmtSTmJsei8vaGJz?=
 =?utf-8?B?Y3NRYlkvZ2pqbDA2elRwWndwb1grNWJlMUZJdEFEVzJ1WC84MDhrZmRENlZG?=
 =?utf-8?B?WStsSllNREZtWS9oOXRTbG9WTEpQanRqTVMxMDRFQ3hNMWpURGQwNXcrbHRB?=
 =?utf-8?B?UXNJRnoyUkNOMlJqeGI3Z2lyTjJlQVBkU2Nxa3ExVEs4ZjIyQ2U2ZEc3Tng0?=
 =?utf-8?B?NnN1SmdVTHN2ZEtDeWszS0JubUxyV2VPWXlBOU4wZmIzZldLVUlScEdUcXkw?=
 =?utf-8?B?S2ozN0l5cDZwU2NxSEJZWlNTVGhYbXF3cUtTS3c4MkNBSzI0cFQzNHZOWkZz?=
 =?utf-8?B?RUpuWElhbEFxalNkZjFBbzdzazUwTnJudEhMODh0VWFHZWpNeVNxNk9qWk1W?=
 =?utf-8?B?M3QrZVlZMHRkLys0TGs1RlFlVzZUOEVENTFjeWlzWUJ1UkFvUUpMOGdUOEUx?=
 =?utf-8?B?a2diVVViN0s1M2FaaVl3d2REVnltVGorTGtLUlFCUXpVbG5qUkZ5TGk0amxB?=
 =?utf-8?B?M245TTN4dkc5MTZvelRJaUZkeEJxYVVuelZIM3VWdTVoN0NwalZCM0tpNklD?=
 =?utf-8?B?YnJtelhxTlV5TW8xaHpGVEJlbGwyZG1YcEowS1V6OW5JM00zUjE3RDhjcFEr?=
 =?utf-8?B?Z3ZZRCsyOEEzOGVjSW16TDFJZVZMdkYrZzJxZUhIOFFiOEpjUitHVTMrdUVi?=
 =?utf-8?B?UEdQSktwRU9SSmtlZEZPajBlQ290ZHh6dDdyRmwydnh4ZTNIVmcySDZ2Vzdr?=
 =?utf-8?B?VTlvOUJhOXg4VTY2djNLZEhSV0kxT3FIYklVaVFZaTl5NHFtOFIrdmp0ZTl4?=
 =?utf-8?B?dTRwblVyeko3c1crNWo3T3VCLzVQWTlLZVlIMWZvSllIUGp4VDNkTDNTNVVq?=
 =?utf-8?B?eTRGenpNaE0ydVhYcWVDeG9xZlE3RkxXaUxxWnc0ZVIzT0I1WHFsNG5uZjcw?=
 =?utf-8?B?dEJvTXFtM3BVU21WWTBCUjNtNEdMYlV0dzBHeHhoaHJtV1FEcXZzc3R0OGs0?=
 =?utf-8?B?aHA0WFp3YUFCQXdZVjc5Q3hwa3BYenNJSDVWUTMyWHQvNmM2NHkvbzJUMVpU?=
 =?utf-8?B?YUZyanNuUnBoUFBBKzJ5WjBGb0ZLZnVWa3ViTnZ1NEVLQko3YnFBZXFhT1pJ?=
 =?utf-8?B?bU1yUU5ibGpCOVQxSUpGWDZ2S1FJYjJLUlkvaUdtQW9iMDRhQUc2UzR3dkp6?=
 =?utf-8?B?UW9mOTRQeWxqZ0FxVFBQeDVZbnhXNVJldGxtNk82cFVFYjRZdFJoVGxtNUVy?=
 =?utf-8?B?VzRmR0hac3RhbE5hVENsVEpVOENiOXpDRXhvaUsxbFpMMXQyUHhTbk1EOC9B?=
 =?utf-8?B?UUY5MlFwSVNMOFpiS0xhMEdnOTVSL1k1anlKQ04zQXRCK0lLWDBBdmN1NERJ?=
 =?utf-8?B?K3FzQktwbXY2WC9YVU11cnVUUXVMbHpYRityQVRiQjNDekQ5bHllaExuK3h3?=
 =?utf-8?B?RjYycU0wa0t3a0Rmcm5DYmJTWnlJcXhsRkxLUENLU1Z2U200KzlndC9SZi9h?=
 =?utf-8?B?cjZoRkJoeDdMTW1oZUNjNkkwOFVyRFBQU094SklLODFUYWdJNU1WWTA2dlpP?=
 =?utf-8?Q?l3AE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amtaUHpzQ3JyUlJiQmhydkYydVdEV1NsYjJrd3NjK2w1YlloY213S1BjWjJR?=
 =?utf-8?B?Y3MyQmFqOURpOFAyTzFOdnViTE1SZHFGS3JneHIwNGxtay8yVENtRjJrRzd4?=
 =?utf-8?B?QWEySXpNSTJTTmVobm5PU0dlTzF1djdqR2RFOEczV1UrY3VoNUx0R3RvQVpN?=
 =?utf-8?B?N21JTHI3UHZkMENNOGZ3Q2xpcEJoanl2MStHeW5rOGNXT3Q3dHU2djFwUENC?=
 =?utf-8?B?NDdBNDRidW93c0VHWENYNFhqdnVwMmJCMStYeFA3T1hYRGZnZ0drY2dvbTVQ?=
 =?utf-8?B?Z3Z0WW15SFNicHpWMWZ5R1E0OTJ5WVVBT2tDaUkzRnJDYnVwcHRqVnB5MFFH?=
 =?utf-8?B?Nnc4T2V0VTNwbnI1UzBoQ0p3TFJSMGV0YzNtamFQTDZhMFkvYU56NjFzYlNw?=
 =?utf-8?B?U2pSNmNQT0lCT09IT212MmVVUWkvRFhoZGttdGJsVXZMZmp1SURDejA3K3RC?=
 =?utf-8?B?d0IrU0ZqZUFrVUt3YmtPUURaSGpzWitJRWZsakRNVHBzUFlrTG1BWEpxWS9t?=
 =?utf-8?B?eWJCN3N3aTBrMGRicklWZkJCWk5YaEliQTlKL2JpMXVSb3RTYjZzRDVwYnBj?=
 =?utf-8?B?aTk0TGdMUzhza2J1eWwxRjN1eUhkQUlkUHpaRnQvdHJkd0x0d3hKZTBPaWVz?=
 =?utf-8?B?MTNleGtpV215aFBQTEM5bHFrSmhLZkdEWEhWc0M3TWFXd1dmeU9UTkUxUXl5?=
 =?utf-8?B?NUdaRmdkVCtDWVlKR09vNVZ3ZmJPOXZSMjVydUc3TTYrcEdYaWpBMk9BY1dR?=
 =?utf-8?B?bFJML3h1bERFT05iTkRlWUpqZ1pIL3dBUU1OdzBOb3JkdlBtMGJVLy9VNHlI?=
 =?utf-8?B?bElkWUMxY3Z4M25oazVITW85dzBDYTE0cmM3MTFKUGhFL3F2Y1pJWElNYmxU?=
 =?utf-8?B?TFBoa09pQXd4UHYrYWwrR3hLMWtxQlpqeU9OWVN4b2ZraXJIMmhtSTVidXdm?=
 =?utf-8?B?eDRNK284dWV3SmdUc1pZZzgwT2FaZmJyQ1oxalRUUWZTQ2Zjd3Q1dXI0RTlK?=
 =?utf-8?B?a2NjazZrUzlyM2tHTGJ6ckxFMmpQbFlFNXNreUpsUkkxSmFkRkJ4Qm43emsz?=
 =?utf-8?B?TjkvUWNqaWh3Y3dIL2Zza3FsbGw4azJVaVVNa1NaYjEyOXZycjhwWHlYUm9U?=
 =?utf-8?B?QkJVWTFvQUh2MVR3M2FjVWZpWUtXSUdQN3JqMGZZVGdzQUI3eFdBVUNaYy9r?=
 =?utf-8?B?dmFsREpiQTB1NzQ0SlVjanN5WTBIbG16dDRsWmtWYjd4M3lVeVJoNmVWVzFj?=
 =?utf-8?B?ZWh0Z0NTV1p5SEwrSUQzSFc0c2JYNGw4emcxR2FkcHNvS0VHYnR3TTQ3WFZr?=
 =?utf-8?B?Y3ByNHR0SWdXc1FCMURZZnUrU1R2TmtDNThrdXR1dis2U3VwYWY1ZkIvN1lS?=
 =?utf-8?B?RkFyVWh2THBEZnpOUUI0bnBUNkxWLzMyd1hSR3lPM1h1YlcrYVVueFJ5Tm1E?=
 =?utf-8?B?bnRIc281ZTc5dmQrM3R4Q1hqNVorYzlBRndsTlRxbnVsMG16cEZmZGoxQnhs?=
 =?utf-8?B?Kzk4QWVuSXZNSDlzdlg5TjdZYXNKMW11RmM1aFNkb2JRVmRKQVhDNWhJQlMz?=
 =?utf-8?B?Vjd2N1BESHpOdTJIY3FvMTNhVlc3cU02MlR4RlRWNTErZWtTcXBQVWczUEdu?=
 =?utf-8?B?cHYrVk51UlN0amRudUhBUG9RalJGMjFhT1Z4NGc3RjBwNGNneld2OGgzVTNy?=
 =?utf-8?B?YnAyaTBzTTJ6ditMMXI4NzdMUlpjdmpLcmRCT3ZFOUltcXJxd3hYNXJiK0pF?=
 =?utf-8?B?SXpNRmh3b3owU0JRVGJwL3BURzNjNGlKSHI1MS9pVkIwd0lVQjcwQW1LYzFR?=
 =?utf-8?B?VmNCVzRBTzJXL3NjK3VXdjArbnBwRUNTeGc3d0VFb0xxNmJDekpqR0N2Z3c5?=
 =?utf-8?B?SitFRDJUVS9yNXFNVTRxdDNTdzZsZ2MrTmxnWjRydm51dDRFdklhWGRSb3da?=
 =?utf-8?B?NkV3aXF0VXh3Q0p3RDZwQkNmVEVqV05haUNLMlFYQk9mMDljTWRKZmIxMGJs?=
 =?utf-8?B?KzFpby9IaWJDSDJKSDQ4cEhVT2NxU1R1bWIrcmJLTU5tMDRhdlIvQnZTbmcw?=
 =?utf-8?B?bkdxaVNvNldZcHFOZnFZUitpNmhiM1ZCNlpEZHhOSWc4cFpTbjE3MVFFUzVa?=
 =?utf-8?B?dXZsd3QvNTExUWtUWGxCYWN5TCtQeHZtMUJJbUN4dUo3ZVdRUXlRakVPc1Ur?=
 =?utf-8?B?TTk0Znh0Y2hwSUdOVjZTWGM4T2RCWlJnOHlTbnc4ajhYK1FhOFZJbVppM3lC?=
 =?utf-8?B?SzluaHdnY3NYTGpmZEdKZ2hKeWNVN3hwMy95WnY2a3pUczBOZ2laeXp2WENV?=
 =?utf-8?B?RmNlcmdmeFNMYk1NdXlaOWZjVUM1YzJvWWFwTEorTXp4RlU3MEFnQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mHvtJtWenUBhcRoIXxaZAUwKk6M+bQoiyA/Wzck3WD7xpL6IwEuWjQJ6ywgo/ZmWBF5jQyAqtvRBGe0J80PrBmnpoywEYulRHd7o4uv8MjZXmJkfv2joCVc4LipY0J8u6UU/sOxJkIeQWr0LIvAAcLhB+dQjzqLdA85lcNA+nBzp2M009jQNGhXxguVNyYhujQUu1m2AJf45IEGpA0IVBQyf7j2pM1l2PvjOFTuMaNRUwhp7xlA4Ve6DQmMQTZZ3Yf7emo/rfVBQ0oH7FVB1WNh0LfaaY39e/TlsWizpCD6+7saLZqereYDovvbQz68Jp11v7IP4CuuIzVjccFm1OVTk7SOm95IivGxvK4D95VR9PWbnyeTFVjxONetPAXycaO0bWHRjt0P9i2356Ny7VTi+0sBbPT+1faZqbcTP5w2MEBmnI4Dh7t5fjpvl8Dj3adPKm392VvARVWuxeH6efUmXnY7zxKKfIzO5vnEWzqJ6xPBnD9ZHDCwOTQhUw1Uqqhsk9Y84CN9pTNY47MlMuCgyeKzesdJ8AHD83R1ZaHeslYOAUWkP43ADuTBCOTThsxptynbxuHs9WufAV9abqfa8e5xy0FFE6L3o1MX4erg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a358b1-058f-4fb1-5898-08de7095da3d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:36:46.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU+hRimzNcXyN2XIVU2r0x7Gi3PL8XoHXL/Kkem+r7BdGjAq3wxVYjVwk5hRXbPYt7BID3ZLhLpyw3g+vLMlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=913 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200134
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=69987f91 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=fXylcCiTJ0F4XDD9WV4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9KZg1HIdWMbhIAXMwWPOJeYdZn3TARZw
X-Proofpoint-GUID: 9KZg1HIdWMbhIAXMwWPOJeYdZn3TARZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEzNiBTYWx0ZWRfXym2zcTZi3wsL
 CkuV61BIRyj4bLligFsFGFgFrNrp9K/ddrAgHXe/OFLUoHy5bDewJRE2ol3qV1icXiejC4Uw7w3
 i9B8/iamCDqFdk+mI/zcjW8O3pw3n7FDZmlf5KoNT/R0EqaEV8ANGDct/8Pa03reMi4Vq5nbyji
 kBuVbpq43WNmdOIXyaI0AlEhFEDBKi4X5vAGhCE7Zxfaj1ZJDaB/3HOaw2QG3BAH+FuJBIlEmCa
 qEXOF1UpFs22QR9splSq6n4w6AjK7PQohK4hWI5uLNQZWrt1yrhAFg/ubLDAEcJmlaRUSbKcpue
 hHS7nYdjx5IB2CvTH6d1DYsEZzg4mIIyTsg0JcNJUHjn4dvb7alQmNrqDlhmt5qmfq2SSpH6w8z
 kWq1WC3O+lW0d1coKe1mfOzlTTxWm/4QCTlQxJoay9SDPsdCDlfEOZsxqEpqiGKTQYSUywRTC5H
 sZE1jRQw0RfnYl5Eqbw==

On 20/02/2026 15:10, Christoph Hellwig wrote:
> On Fri, Feb 20, 2026 at 02:32:33PM +0000, John Garry wrote:
>> Correct the comment that the source bio must not be freed before the clone.
> 
> Note that while this version is better, it's not actually true either.
> The bi_io_vec used by the clone must be freed after the clone, but it
> might might not be owned by the passed in bio_src.
> 

This is the complete function comment today:

  * Allocate a new bio that is a clone of @bio_src. The caller owns the 
returned
  * bio, but not the actual data it points to.
  *
  * The caller must ensure that the return bio is not freed before @bio_src.


So I can have this:

  * Allocate a new bio that is a clone of @bio_src. The caller owns the 
returned
  * bio, but not the actual data it points to, bi_io_vec.
  *
  * The caller must ensure that the returned bio is freed before bi_io_vec.

ok?
