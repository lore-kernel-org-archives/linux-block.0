Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6134BA30
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126167; cv=fail; b=KESKHJEeEthLbwHxqYV3Zi43nsDSDzlIvvYqfccCucTlUUn0fV6LLiJ5PgzU3MMiARfB9OpdNwqVS4ArkXgzyThBR3vLdW6N1//T5TSGXDY6HjmlZMClQFWDFMj7ISbgNEh6vhPhpt6+pyLX7d3/avDNY7erz0BANKigKuF8vO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126167; c=relaxed/simple;
	bh=KeXFCWDqDM5xjv4oF/HYSykNm1qgsMQzSj0/3vpY0aw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wr0OnGadbGE6ceiZ80bwuQe5so86hwLi/4N+INKzZkZmEuMv0RLNBP0BBv7WXOOC/1bM/1Mix2PdnpQmtyfsfciFFuCEYEuDcbmAxeeLCUUPeJpkW2dLav/94IMb/jYcGvp5qgv/MrB0bvY0yZoQrhBUJcuuZ0d0p7/sr+odzm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fazIPhLZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XvkF4EGU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fazIPhLZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XvkF4EGU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIT07007388;
	Wed, 17 Sep 2025 16:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1sVsgoP0p+8PehWDigD85KTALdA+rhMTCaoEofrS4yo=; b=
	fazIPhLZYCKAZpQApPAWJJI6GzGK96In5CLTKfIY9wV0OPROvWYXR4Udaxg46Oe9
	tFk3L/VVAL42gO+J3GAKtuRz1eKtoQyOh+Zhq/K9lxYBjJxCvRM31uITztRNRTNr
	G97Q1GVahcmrN5oAdKL9CM8hxapLZhj7gW881Rq775Oah6s/BYPhOm1ZBvbR6uC9
	8D+Hi+utwFYUIXo7TLq43Cl84ACkneIpV+6zi8tHj1u4smrnvnFEumS6WvkUsm0J
	QDU9XvbP8sy3v+dpRvxVkrZW54y0I2YmxkEzLRPUlCtgHbgqqeQOxtqKGQMsTmvx
	rcDVapybOlImAv9p0kejCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91n8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 16:22:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HF554X001511;
	Wed, 17 Sep 2025 16:22:43 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e7s35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 16:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF0RZOt9DSH54DrGQR+49o0p6vvZumE3zEdCv2uPvSObo9A9PPUdka4jW7K8Wwfr4gOKHB5Iqp/o5aFYTqvM1TxdfHgojii90mpZ2VXYKnS89VsOcHbo06uvSXS1g3PUx73+sDtatpgFgTxHE5BKpA+jHRTQTCSQscvoorX9kAs8u1qT/myqHsc4ZwRGHcwL6ktEBmIMtTLsaamKdJ51TI3g6lU78K1NIXekhDLIqtz2Zc1SCL5uWvWSHbTT/50UDk9MUIwj8Mj929rLppsq2lzQmZSH7dKkXeHN1MEw8ozjcYvwOT1akD3zSIkW2TSuICKrPQfVahnKbT8SfFRryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sVsgoP0p+8PehWDigD85KTALdA+rhMTCaoEofrS4yo=;
 b=j61TMCr4BCNHuujML4/6srYYav+o2gSoVbsz91aS2Wmr2TNoO9bLslNLxNQ2kkxzZYoWkM+DYRZ/Y/AASq1H6LiB8XwiXcaQzJVLhxPyqhAbC0xCGMiElt1ooL62slxuanII2uJwPQaI0mb11TDTdriFssant1+qqweHj6gz04RbfYn03Ty8FCcKZyFaiTE8zxlaO7hDQq7Jqufa2RB3Ts7LNd8+NR4bsVfIjitWD0yiPmRVYOfxa6ZMKHkcO3eQoeZj3kTIyXzaLMDfgylvOrWTb+a82pTGIpf6UA+C7NQc/heElwdmLE0tveS5RimssAVE8HLA43u3IqGeLsjZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sVsgoP0p+8PehWDigD85KTALdA+rhMTCaoEofrS4yo=;
 b=XvkF4EGUZb5cP73QL28VgKl8A6rJCpWpdJxGruuzWIY2UReA6SNMJGAqOoEkbqMYUXgCq/5Xz/doHVM4bxZSaxhM4aVI0sCDAKfqtnrow5WmG3F0gJyOruYZPD5Rtj3RZyOXwHQmQw3QdksMx0Uim7uUAf4xCWyH4MFlnP2yzlQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ5PPFA634C6E92.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 16:22:39 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:22:39 +0000
Message-ID: <267b6d38-061d-4798-8af4-13ef5f0ac6ba@oracle.com>
Date: Wed, 17 Sep 2025 17:22:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
From: John Garry <john.g.garry@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
 <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
 <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
 <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ5PPFA634C6E92:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff42d2d-f292-404e-424f-08ddf6066bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXBEeFJXREdqYUFobDNJVHJOd2tGSk1jK2FzejZHdkhJcXJDNkJ0WGI1dEJH?=
 =?utf-8?B?UzBSbHZIbzBRNk5zVHBuRFZLNDF0NkJYZmVkNm5OWUFzdFJieGFBTjRlTkNl?=
 =?utf-8?B?dmxzODVBWHduMzAyVG51RktEWWp3a0M0MThLVU1lQlJVa0JWakcxQy91QWV0?=
 =?utf-8?B?YmFQLzd1d093a2hGZmp5anVaQWduWURxQ0dQcC9BMHpjWkJHdWZSaVhGM3Vs?=
 =?utf-8?B?cU04UmNLdWN0YVZvUHlKRndxSUlVaFo0eEFmb1BSalh6TnRmWkMvQW1XTW5w?=
 =?utf-8?B?aVhlaGRjL21tOVo4UEQyOXZsWFhqVmlOc3EzT0g4c2ttdDZsSWJsQkJsblNC?=
 =?utf-8?B?dmJMNHpCbG1jNkZySWpncDBzZ3BRWm96K1VPSmk0cFlYZ3FIdzZQYUFGN1pD?=
 =?utf-8?B?WklSd1gvenhMZlo4Z2QvNm1iclNzajBuYW9iL1N2VEs5MnlTL2cxWjlJeEY2?=
 =?utf-8?B?M1ZFUkp4N0Z5dmlGNytFMWJ3S1d0SzdKOWIvTUFQT2ljNEFROWpNczE1MFdG?=
 =?utf-8?B?R3U2Yk9GV2VNQzRoQzE3VWgwdGlGeXhWaTNJRTRPVHRKZC9MTHJHU2lRVVJa?=
 =?utf-8?B?VEIrZVNWcWp2dit4KzhTR3k3dSt3WmY1TVlUMk5naVVobWROcVh0NWFDbmI3?=
 =?utf-8?B?V2RGZ3YwNEt4ZGN4b2lJSVdDL3hnbUIzb3puczhLd0hoWk5Rd0NCNU1MZHFw?=
 =?utf-8?B?dld2SDRRem9TUWZNNlZCNFd3WDBHZE9iQXVCblB4YmpiSHl5N3V0bW9NV2Iz?=
 =?utf-8?B?cGNaTnNjOFdFWWFyaXZYd2lXcXQrMER0Yis0aWZTTGx3QUowcHlwTks3NGFs?=
 =?utf-8?B?dS9RNXIvQVdyYjlxMFcreVl3QzcrSmRXL1dpY3FXTVdFVmlyazdLdWxjLy9l?=
 =?utf-8?B?VHliWTdPRnZvRXBNdU12M2hrNjJwK1c2NzhQR1o2czJuNjhIR3QvdXBSSjJU?=
 =?utf-8?B?RDZYOUhhZHJvUHZoTm05ZklVYlc5MXN2QmJvaktSOEtOOHpzV05VVUxnTHBJ?=
 =?utf-8?B?OE1odUVOQTRqZWtwSng1cHNIL2RGV3cyWmpqYmFxeDN6Q2cyK0VvUDFIWTFk?=
 =?utf-8?B?NHFwRUp1a29PRFQycnVPRFlHdGFHMG4yS29WaW1jUWhEWVAwcmUxWlN4RTA4?=
 =?utf-8?B?QzVKZVBFSXhpZFhVeWlZbHhBS0NTeEYvdEl0bjlJMXZkMXFKakNPM3kxK2Q5?=
 =?utf-8?B?WStrelkxU2Q3eHdGNE5TM1lxTkNXWGNXNExxcTdLcmdvdUJiaTJNc0d6Wm54?=
 =?utf-8?B?aFNqaDJoUkRyY1pSaTdockQxUlA4YmUvcHFGNi9hTVY4WHlINVJKcStVbDZ6?=
 =?utf-8?B?OFdjblZBb0loQ2JIaitvTktXYzRydzJ5YVp1bkpCcGtpVlVFNTZyb0FDTmg5?=
 =?utf-8?B?cnozZm0xNGtOR0lmcnZQcUtpNVJodVRaMmg4NHVqWExDQVVRUHZhRHZwaEZD?=
 =?utf-8?B?UU5pWS83ZWZkaFppZGJ2dVJTNGVaeUVzUTNOYkF5L21IQTJDOUlDem1hcm9P?=
 =?utf-8?B?WndqY2lFa1JRa1M4WjFMdFIwSzM0OGRXb0lUV2U1NCs2Qjl1VWNHL2lUTWhw?=
 =?utf-8?B?QmlJMW1GenhrcFF5dnQzQU5CSC9aaHlTcVFkUWhaRHljd2VmZUdSWDlDWVpY?=
 =?utf-8?B?Nlo5Qko4OS9tdU9MaWhIbktwWnhvcnFSWmUyRUZWRWZ1TWpnRU9HQXFUaGN2?=
 =?utf-8?B?RXRUMS9wbjNHSTV0R0w4YU9qNW1kWWtUWmFqbXRySWNVajdBbE5LRkxldzBS?=
 =?utf-8?B?SUVrYmF2RldPZDVEV1duMXdDWGRKMXludWhscVk1VEQ1dWNsUUZtUW5LVXBK?=
 =?utf-8?Q?HqDd4xHwBTLcX6TfhqtAK4RPCrCAOFXejQwds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWwxL0o2Y3ZZOE1LMm95bTVFNnpSQ05OTlBubm9vTThIakp0anExYVhFN0or?=
 =?utf-8?B?YkdqTTB3VlQzb1lHSS8yaVdsbmR5MTJjU2JEZFl2NkdzQjN5S0lvLzlyUTBS?=
 =?utf-8?B?UXk4YXRrTyszanFKOVdDbEYrdFp3V1FlM01lVkltN1BybWZlSWZybnFuZjJJ?=
 =?utf-8?B?R1hDZTdvRFhHKzdqL25BSEZZVlprd0RWdHMzSGwvU2NIRGNWTU1nTVd3Tm9m?=
 =?utf-8?B?bENwR2lka1ZNaXQxMFRhMEcxOGRXMzZLT2tFcWlQRnJNRFBrZW1UaE94WHVr?=
 =?utf-8?B?VGt1Tk1RNmF5eWNxM2xHNXJLcVRHemtnVVcvRWpwdG94c3FMNGxKSm1hcFpu?=
 =?utf-8?B?K2RPd210bWxEVWJNcXQ2VjZzbmt2cjVoQmQrdzdtM1pSaHRmSEdLQzFJTHN0?=
 =?utf-8?B?dzlsY0dLeW4zU0RhRzhUcisrWXo2QkQ0R2FQRHR5bUdYNEJta0ljblRLUWY0?=
 =?utf-8?B?Ri9tQk9xSktVZU9BNW56NnB4NzVzKzU1OTl4NmtsdkRqeTI2QnBXZTVWaWht?=
 =?utf-8?B?NUgxOXBCbkFIOHRFYW91R2s5T21JSjZsODh6WkdUNEhhT1lKVVBLR3U5UU93?=
 =?utf-8?B?TmhqK1ZVci9ISlE3cm9XbjR6RUczUE9JVVBnalVuRTJ5aC90MmlZdEpXK200?=
 =?utf-8?B?dTBxczNWR254MmJEckRmbTdBVGhNSVA4eUF0NFF6c0YvMmdZOFpJWXpQcXEz?=
 =?utf-8?B?MURFUGNJUGtZRWhPSmJEOEQxS1JOOVNyTnRTMjR6VGxINW1Ec2tGYmQ3eGgz?=
 =?utf-8?B?dzZKTk5kZUZWRWFTR2tpNVZ4L2ZVNi9vKzNmbGFSREd2ZWo1OVdiODRNUHBo?=
 =?utf-8?B?MnNiK1hXb2pBNllkS2pBdDQxZmc4anBJS0hmWUlJbnc0MnhtdEpYUGk4UHpK?=
 =?utf-8?B?aGR2QjkxN2l6UFQvT2dRajVXNE5mR2pNQ2wwd2JGdkJqR3FBR1ZRaFZhRjlQ?=
 =?utf-8?B?Z2hGZS9Ua25NRjN4V1F5b04xR3BaVUIrdVNxc05uc1FoR1RESjlMN0ZLajZx?=
 =?utf-8?B?MzRFbk9VTjBoYWVjSVI3Y0JlYjF4cm8yR0Zud1ZoQlUzWGo4NzB2aTMxUyta?=
 =?utf-8?B?ZVhOMlQ1Um92cFBZeGVVeGE4dzRUbmcyUGdPdE4vQlBFSk05dVFFeXJtZ3ZB?=
 =?utf-8?B?SGEvanQzb25SR3pMcmpROGRJZGhMZkRqalFYSURvSkY0RStJK3lyOEVKVTJJ?=
 =?utf-8?B?dS80eEVmSEoxbHF2ajQ4QmlpU3ArT1RGbzF0N0Z6Y3ZhcExFTENEemg1SG9a?=
 =?utf-8?B?a1VrZUhpaXBNYW9ncHNBa0NCL1R4OFhOYkVUd3A3QkpzaGE4aEtZd2V2cDV0?=
 =?utf-8?B?R1pzbGR2OU1nSmQ0QXRxRWlkVUh0dHlSSjdnSGJwZ05VZUVjKzdNeC80R0NU?=
 =?utf-8?B?aWV4MDl1SmdIek91MWMrNW84eVhnOWc3SXg2NDJWSDBRYUFDNUxxR0JpYnJG?=
 =?utf-8?B?RUJTVnM4U0JPY2gwdDd3M0pKSllRMDh3bHNYL1o4QUFrN1NmUzliK0p0ZytC?=
 =?utf-8?B?UkVISWx0bEpZaS94L05MWVdTb2NkelpiRlVXVTQ5L1E1eTNxVzFRZ2NLMEps?=
 =?utf-8?B?RUpkUFIzNkZGWU9WK1l5ZklWRVIzMzVNSWtFZFV5TFFKTXZYSVVzQ1JXRUkr?=
 =?utf-8?B?Wk9OQWsvd0lYTGFWcXgrSjY5ZW9tN1pkZFJVSjdEcUdVcFNFS29KNStDeUNi?=
 =?utf-8?B?WldtRW0yclpEcVlaR2FGakJoMDhlelF6N01VNUdaU3l3alNGaFJTYkxTbDVj?=
 =?utf-8?B?aVlQckRuc20rVUVpV2R4Y2JPa1lCc3YwV2c5L0FvQlhCK2l5aVIyQkxzOVJH?=
 =?utf-8?B?dEYwY1o3c0g2bWZoOWF6b2RTMG40NHdZTVZlelZVM1ZoWEwyQ3RXSnBQMUpJ?=
 =?utf-8?B?T29FOHB5dUgvVm8ybU1PdDhlZ2lqQm5wei9tdmVWSy8vWldqdHUwNHYycHIv?=
 =?utf-8?B?WWFBVDFiL2VjYVZYbjJJSVVOaC9VVUFZbU5IaE1GL09IRjhVcXBjWit3R1p1?=
 =?utf-8?B?RFpBZlJFY2ZEWnJVRzdsNFhzUTEreE5hSHdudko4S1NZcDhVNUpkTmZ6WGFo?=
 =?utf-8?B?MmNET0RJaXYwN0VRdWVROXdkdkV4OVdpNWpOMlFIVmlSaHV4QjcxS0VoRnJI?=
 =?utf-8?B?RXlBQy95ZmRNWTZWRDdtMHhxaXRXekttSGtUTm1ROVpJdkZBeTdSN3ppZksv?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H2k7AX89HrHdRgGgI5ZcbxTKmKERfruTd3qomgCX2SFmXkbjHMu0EjjycI0OB2Ln4hlHccnno1Nq8PmPyBSGK69zXjrsUndFlSMNCf4jjWKtbR+KHXUbljFrTa3MaOF1yqcV8xp3ksXmEQ4qSw8QjRZ1E6CqBhdaRzpu6R/Dsd/pelWTM4m1x3WTY+x9iVK7V916nrAhnYdMJVgKjVy5u5XdCFgleWng/e1V9nGAs7uQEcNZoPlOZcFWQ0NWYKYpSf/bxjJ0URbgM36r7tbL0qo//FtE/KAD5W2VPKb/qS/SOix9HxgIAZqLL/x1Ge9WS9nSXs9Ad0B8rJKcCFq/Io0JXy9ZcOw6IF1XRd5Hno0VzOhtwX85vx6VAr5iT3Lb4PVPbzbkJDz5Ps86xflE7WZU6HkYTY1wOB7LY5CdkkZEAOoVsLflPwAaur7BOA/CmZpw6S1lwbDB9zrswOymEsIKHtft+iKPE1/XZQqBH7XozOaq0QqN45xLgR4vzfRkuAWfLNBbpKoYOXiumDGGPZNJsdCFcUhpKe9YgIr6OsNJWameMHwRIXmkubFMpFYW+5nBEyrNDML/n1K44SxAkZy2gz1xpyfrgNw4/spDFC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff42d2d-f292-404e-424f-08ddf6066bc7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:22:39.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1TSAbeKIehDFCxiLASIq71+G4ySE1v1BSDnfJBQQuW28q8ben/xB3vwB1qGZtlTh8aG5wtrmcpN9WItRRqC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA634C6E92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170159
X-Proofpoint-ORIG-GUID: P1ESpZTMWPg39za60bVM19gBJOJmFlS7
X-Proofpoint-GUID: P1ESpZTMWPg39za60bVM19gBJOJmFlS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+Sk9zGu7+unc
 xFJ97drNObhYj+sy1ki7dI7u/FghJ9gKqN/DrBNfB3UiegiQtAPesbA0bETBkTFTdn1fx0J5pK/
 TfGZNCRUWVVEDJci8RU8PP1NUh1Fi3m0F+JCm7OfRiVipNrHgib0WCbzUkSxiMmt6fChSXIhWrz
 hDRx/ro9P+CGePO5ZKPOp3f3e0qR+MrNsq2xJPDmLPWQHXgCsW1sC65l4WmKCEmKU6hsitoDt/D
 JbefyNQQGQbqgIA/5P4kfrFWATbbD/4+HkAdblVjNisMZCY3vOoIwWe3ZHHKlXlBn0yt3EODJ6P
 KMzi7+thAW6jtAOHSB3wGKY5nHMIiLlgHafHf74k/Pffboapy1y7mQi8luFJPLSvwCp7uXo+PUv
 npVUz7j9
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cae054 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8
 a=yAZzkXYHjWSqQnIAsTQA:9 a=QEXdDO2ut3YA:10

On 17/09/2025 14:12, John Garry wrote:
>> It also has slightly different variables for use in the 
>> test_device_array()
>> function: TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS. As an example, 
>> I made a
>> quick commit on top of your patches [4].
>>
>> [4]https://urldefense.com/v3/__https://github.com/kawasaki/blktests/ 
>> commit/ fae0b3b617a19dab60610f50361bb0da6e0543ea__;!!ACWV5N9M2RV99hQ! 
>> NNGuj9SVoLIwKksQudWC5ktgS6vIXTX1dGSmibli2-httSpUBfSHAIL1i2z- 
>> aCmYSXUZxmwGZswO2KJ6Ei8gwmoYAPTl$
>> I will review details of your patches tomorrow.
> 
> great, thanks.
> 
> I'll test md/002 and md/003 today with all these changes.

I gave it a quick spin and it looks to work ok.

About TEST_CASE_DEV_ARRAY, is it scalable to index this per test case?

Thanks,
John
