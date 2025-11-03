Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D97304969
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185279; cv=fail; b=o22A2QpubUtYCpTVifuT2S4nI/l2EVe6uIgD9KmkTLwTXkicvhLUF9R76REdx1nXp2UhKbqha3xOsBx/YUh2lzHBWrLQILfugcWyaaxHF5bnEcv+DHr+GZwjGC2rWqckCwoG/4BM834KC8q9UFsdenO9zN2yE0ZLBC8QnNctKn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185279; c=relaxed/simple;
	bh=MX9QFryjvFLWJ42rka0ZmUus10MO4VipInUdQrFY5tk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBfBywkREOFdcaz1MkEoCrukwYrhcfImOqWajUW8CFOQ/j37yqbo1dIAzVT19X8C7C9pTt9cK+BZNWI32MrP3fCERtyBk+nd1asdGWTf724zJetAKZVDu2XKlRgW4wv6m77WN00juUD3zShRKGiIFz+4f4DL9G1a3TkGKvVoKvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TynYPGke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvNwBxtx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TynYPGke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvNwBxtx"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3FqEA2024917;
	Mon, 3 Nov 2025 15:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VP62W8nRrYFEeTQZIi74tOzCy+krne3YN+a/0Zx/zyQ=; b=
	TynYPGkeoc4uiWNZUDm5ha6MC2iAdYrxuN/akGmaUwl1Ig3R7yxI7Afttkz00cpl
	zNDf+JDpR/tdzcfhulvT99m1BLQUYsXzRi+AV6PSFycMd30++5yMswK/R3/311kS
	7Af/tgoePsi5gqAliKds1vnnSB8qnQoRPJuktqQTKydT76EG6QqUI+57F3FC7v3e
	JU5+b7hY+FJc6PI/j6TfdFH6Fckk6CzdhQmjUDBeNEKD4qIZCpZe01QDvb44Xba3
	t0ONzbR51UqhDFkp4UPCPpxwJ26f0uPzkSIX+SPkE4HP3rLN9liA3H+36VxqyI4i
	usVLm++mxOjaZ5ufLcADZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6yd2r04e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 15:54:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3EBEio017250;
	Mon, 3 Nov 2025 15:54:35 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n82kcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 15:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2qURvNlOnqAdp9Nap22d8YJUH8SZPUVUCzRHANt100pYQNpa9hqW/gL/A115vqAVtQxTVJVdrWK5FlUbT8XckC7Fe0N1R/HTh07fIU7lmsp0JJyGs3+URM67rFCbSeLsW1fAQAvodYrf+37bvsE3JV5AIJyJwd1O18uVxowI1vQNV6EJLMMoGoFZ8GZrCH5+gj3X7WvYhpOeHTeE5JBfortOSdTGj75uQfpipt4glHDa3Ag86/Ozo1BRq7VH9JZ9iWTNUY6N6L11j/kHKNxtPugFD/X2aU2g3e4MX8/JDRwY86adINzzHVr4PpJOF2dW9JebQoGMUkWCMyVxZ9/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP62W8nRrYFEeTQZIi74tOzCy+krne3YN+a/0Zx/zyQ=;
 b=TMtW15dFonDfDH2gfpiZeo8+Atty7bkw69H2qpKl6w7ioVfAGcImKfdJQQ6coE3ud+gQMNr+jsMo+K6azg1IZauRQ9bQlKaUQIyz6gD44JC8ImHONpy/JeTuovqJPXuahnfln+tzMeBYBRBZikRWE/9YgOZacevNe3KKRbhJB+J709r1dIbvAitxNQIJYl2pW2qymW5Lb8PMdvFR2PnSpYgXhktGGC1SxY6GD2mJxGk5LtFUIHPzhIb/3tPlbBzwVuX945/rcL21/wPm795Lg7nWsDNenWx+8jyTRqNJj5MPhkeMD4i6jEDmke8hSwKTeiGZngDklXp//PMz4N3i5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP62W8nRrYFEeTQZIi74tOzCy+krne3YN+a/0Zx/zyQ=;
 b=gvNwBxtxwKszlHNaSW4/XJwVdUD3mT+cBgwfVZNG05OxINLPAZDisPF9FBzybZ7BPnSunpKVSaP9E458QQXnHgh+gwxQioZXiNYSdPZ2Kz+E12Uw3bf6s9nTBMDj0LTFQvx/de6VK2gbjvnhh1eGEMUt4KqlXE0g56kiIoXP3Yc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS4PPF072D269AC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:54:26 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:54:26 +0000
Message-ID: <6691aedc-de20-4bcc-badc-a0b6e155e0f2@oracle.com>
Date: Mon, 3 Nov 2025 15:54:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct git location for block layer tree
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d2752a68-929c-46e5-b2b4-e85ac3e6d138@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d2752a68-929c-46e5-b2b4-e85ac3e6d138@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS4PPF072D269AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3b64d8-fdf3-42a4-326d-08de1af143e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXdlMkxZa004M3JBTVB2YTBDUHpiS3ArUTZnaGg4QUFZdHcwSVNNZnI2VDFz?=
 =?utf-8?B?bmYxa2lXQnZiR3ZFNjE2S2s0dWJ1TlNZY3RCcWR5c0NKM2VHcDdxUm5GMmFI?=
 =?utf-8?B?cmpzNS8rRFBYQ3BNQXVyR2M4dDRNTHZyZ09mM1UzYW9FeUx2Y3FkSHdZYTIz?=
 =?utf-8?B?ZEJZeTFlQjgxVUUxOGVYY2ZOM3RXR3BteVFjTEZua1V5VyswTVFaaHYwWkk4?=
 =?utf-8?B?YUozZThWYldKa2tBNXI1TEFrcHhnaUVTVy9MU2VDNVFJMHhNbFhZNjhmT3I5?=
 =?utf-8?B?bHBLODQ1M21KWFdyZi83LzZlT2piU1RnajJqdVdCSXdESDhVTkJSMCthMmJa?=
 =?utf-8?B?dVh6eW9rOHh3T1R5NURJRVV1bjN0SEN6QVFRWXhBZ2NPdHpYRkUvQXpBT0J5?=
 =?utf-8?B?QmVmZVBaaEZ6YXAxSDNDZENkS0lUclpSc0NsVzdKYUdHazZRcGRQUmRldTAz?=
 =?utf-8?B?dnFvb2t1UU9rYjVpSzNxQlU2SUszSGUzT2xVaDdleW4yLzRiZGY4Nk50OGFJ?=
 =?utf-8?B?R2hNNndGZ2VYTzQ4cXExS2o0SGZlZ2pjenZWQnZnU1lVcDMzVzVwMUZHMlVr?=
 =?utf-8?B?NE9TMXU2b3BFQTJjQlRpUTdTS0JhYzZ4NUw1L2hrd3h5ZVcrOTBpT2llMzhr?=
 =?utf-8?B?d3pVRGhRMk9ZOXQ2cDlWV0h5S3Y2N2VZbVNtNEZ2cmQzM3lNNXhaRjlnN3FC?=
 =?utf-8?B?Qy9DdEFzaGVacHc0andYSFhVdVZVTm55QzcyU0FwMmlFQlliMDBNVlNSK205?=
 =?utf-8?B?clBsaTJiZTRQOHY3cUFnWTJLTXN1cjd4TUFQTHZrQkdKOXBTZkM5R3FjdHBw?=
 =?utf-8?B?WDduV1haNjBxSHA0a1BqRHo5RW13WTA5TlByZVR0NnJ5TmREeFMwaWx0TXZp?=
 =?utf-8?B?VkY2WnpuYjN1OU93am16M0pyUVdEL0NkdGF0b0ZQMUc3U3grZ2hFeCs0RC9P?=
 =?utf-8?B?Q3NQY3pxL2JDVXhodzRyaE51Ym40ZUM3Zm1VaHhMbWxQOEMrN24rZ2FVenBa?=
 =?utf-8?B?KzdKM0UycGc4WEN2RDlRaHUwMndCOFRra3VxMFk2SXc2VkVWaklEOTNCVkU2?=
 =?utf-8?B?ZFVVWjFXeW1uUlN5TEtQbDVWNzZDZklLT2JNVmtvR2tCT1VpcVRDbVZrcTQ5?=
 =?utf-8?B?MDJKMEVuK1hjbmZ1eGZ4ZTArRlFSMDhYL21MNHFRa1hWSlhBQzNvalExNERa?=
 =?utf-8?B?K2V3d1lyTUtGVjVnUkYyNXl5T3JMOXJ6aXgrVWdNVGpsOFdid3F6V01OcFhr?=
 =?utf-8?B?bzRYbngzRk5OVUo0aVlQVzZobGJtT0l2cVpEY01zSjFWbCtHL01pelFESTJF?=
 =?utf-8?B?WnVxenQwdEJiVG9wejN5YzFFdVZVUUx1RjU2TnJycnZOQk1XMUtIZ1poYlJX?=
 =?utf-8?B?bzlNdUh3UDBwUE1ua244QkhhMHIweTBqZElEb3RLZElvdUFLQWNTM3Jpb01m?=
 =?utf-8?B?ejA2WE9sVDNqQjZsaWtqRzdMam1vd0NJT0hQcDdldXZNUEdvSHhyQlIrTTR1?=
 =?utf-8?B?ZjZrYi9uZFk4UjZZNWpkZVhYY0lZdU5tZ2d3T081LzlUQzhUNjQ3Q0dJQmJL?=
 =?utf-8?B?WnVnbHNSQzBGWTVQaXJBZnpmNDd1VEcvY0Z5Mm1ObCthaUFweEZDOStSQnJ0?=
 =?utf-8?B?OTQzSFM0eXdXOG42RnEwd0RCMWFDU0FhNHR2TjlkS2hyUUFNd1ZYYUFiaGpm?=
 =?utf-8?B?aUd3anV1NTZQeDlCUFd6Y3U0a2dCTzRvNVBkdEdDNndFSGNvWVlTWFhiN2JE?=
 =?utf-8?B?d3o4d0paaFNxcGVqZHpmY2xYK2UxQ2pTS21vajVQZ0Q5OHpQUzR1VEcrdjhI?=
 =?utf-8?B?OHJRcTJsd3JkYzhZYzBrenVqbEhTYStZYWllNFZyN1V3WWdBMFNWMHlROGxw?=
 =?utf-8?B?ZkNCODJkT0xxeVBOTXBLSW02NjAzVjlrajVXTW9waldNTmlXejhMK3dYY1Fv?=
 =?utf-8?Q?BijNoZ3eW6qozQME4V+WJYiaV3Jolc4k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnAyN1FJQUZ0aHpiYjhXMGR0TC96d0Radm5KU3R2dlRETkNydWZTeng3aEc4?=
 =?utf-8?B?UVU2d0hXU1JEQ0FPbEpwTWRrWUEvbGlYc01VK2VBaG44N0Mzbk9kWS9sQktQ?=
 =?utf-8?B?SGh6Q0Fjak5mTiszUkZ5VCtZZC8vY0xQWTFTM0xKSmFzaWExdGhJQjNWYXp4?=
 =?utf-8?B?RGkyMVpGWitRd1IwQ0RZeEQ4d2gvbnM3NlhYRExacVlpNUc4cm95SmVOOTFn?=
 =?utf-8?B?UWxJM0UwNnpQd1g2dE9LMEtaWGhHbjFVcTVidFN5ellVKzhDS28xcHJsd0xN?=
 =?utf-8?B?Qm5qUE5xZGRCL0pnQ0dwaXBzUjc1V3dqZW1TUU1neFZUOU5KWVBReVppc2cz?=
 =?utf-8?B?bmEzaWZJQWFQRkVQMGdRQmxnWlFlT0RTa085MWxvWXJ6Y0tvdVlraVRicWdG?=
 =?utf-8?B?NGRKKzQvS1lrMkxvcDlMR0NEMDZ4c3duNHdFSFpPcmxpRXlsVHpnQ1g4cWtL?=
 =?utf-8?B?TDArTmlIcXgydytVdC9OSnNsZ0lWYUM5R3ErZkxxaGd4K3o3cmtwQ2NLRFF1?=
 =?utf-8?B?KzZ0UW1vQ1J4Z1pwMU1KMmh6VE1NUWJGRGtEaUowUHAvdS9hNXp4Q0VHOTFs?=
 =?utf-8?B?U1I4Z2tlT2RDencwcm5CQmtPM2lzdHFHamtrSnJQMHlONVpYazA1ekg2YUJl?=
 =?utf-8?B?UUN1Z3pRaEVmQ2lEaUl3cEMxWEVDWVFNYnU5a0lsbEJHWHJoT0RnZVZLNFox?=
 =?utf-8?B?UGpQbmNrZkErOGdCYkNxQzVyODZ4QS9yZ3hLQ2ZjTGpOM0FIU1hyK2J0blE1?=
 =?utf-8?B?MXdCYzNlUTFRRTVIUzQvZFVPOEFLWm14OHZqVWFqVHhhQTdRSnJLdlRFL3JC?=
 =?utf-8?B?aU1vNjMxZ0RQaVMwU3ZpU1hPSTRiY09rTVMrM2pqa2N4Z1R2ZWZhcVRIMm03?=
 =?utf-8?B?ckJTMTdIZjU1cGFwZTBNcWJtTnRXdFBIWUpIRmJQL2tJMS9EbHZVaVlrcDYr?=
 =?utf-8?B?MTZvN09TVGs5eDd1YlF5UDBNbEpUR0VVVDYzNUx0UFpyRmVlbUJDTnZ3WXhE?=
 =?utf-8?B?UEhWaXdBYTFLUzlYOTllTWdpSjFhaEZlWi9hdXUvQ1U1eUZMZVN5TkpSNks4?=
 =?utf-8?B?Uyt6ZkhXSERSeE9rUzFzd29HOGFzMEJaOVZQWFpzM3VHZWVNTHpJdTBNMkRY?=
 =?utf-8?B?dkl3dmgvZE95bFg3YUIyNWV2Zjk0WTNCT09nZlV1bmRZNUY1UzBQeXVRd29B?=
 =?utf-8?B?bnBVKy9TMEpLN2xqcEh2cERoYUYyN0pEajlYM3o3QnVTNk1yelJqTHVXZi9P?=
 =?utf-8?B?R0lOMkRVNGoyb3JPbnlVeUF4ekxqaEdleUxHbWorNWNycEtEQTczaUZ4K0xw?=
 =?utf-8?B?MkJNdVZ2TisvU29HOUNnOU4wNGxhZ0d4aXNLNGc5d3kxUjdReTN6UTdGUnJ6?=
 =?utf-8?B?ODN1dno4ZHRtK3g0VjFaL0VOOSt4WUhXNWwvcmRXdTFXS3dIR0RuVjdtMC94?=
 =?utf-8?B?OERlWUxkVnBwYnBrb21scnhFQXJkUWhsQ3BBY3hVQjU5TUU4Nkp0S25PNVVs?=
 =?utf-8?B?cFFHa2Ziam9vTUhGeW1mams0WE5wbURvNmtQb29jMmxpT3Z3S21hbXkySXRq?=
 =?utf-8?B?UFNXdm8xRjhQWExIS3FUVDhLTDJ0QlVNeDUrQ0Nwa25kb3Z3VG54RE1KY3Bi?=
 =?utf-8?B?aEk4UStnRTVBanpJVmtCQVNOVkk5VmZJVWJ2MDBiaTd5WUZhbzgxSkp4YWc3?=
 =?utf-8?B?VEpJaXF1WkZDaXVReDE1VVB6WmNvUEJXK3dtNWtHOG85YnB5OEVZZERYMmxk?=
 =?utf-8?B?TTNyelplL3FEbEU3VEUyTUVoU0lkVDBlY0pqKzBydlV5ZzJLcm9USFFleUVE?=
 =?utf-8?B?NUR1WURpUHNiY1U1WXdlYzRYYzYyT0syNEZBWThwUHV3NWMvQmNoZDZWYlNt?=
 =?utf-8?B?K1hiSUp5Qk9mVzR1akprOVBSdWtOQkJjZytlbHV2UW9iRHkzQzhrS1kwMjA4?=
 =?utf-8?B?SmYyWDRmODh3ZW9acno3STF5S0YzRmRpaEJzbnVIMWQ2eUllMjdvTTdTcUQ2?=
 =?utf-8?B?Q0VHNEwwWWlqSjZSOENvL29GeEtRSnlnMzUrSG8zS2tXaVkvT1dqK2NheGsz?=
 =?utf-8?B?UjlpMWppaGNiNHErQ1MydnpHQkRPV0RUc0w4UUdEdGZsa0pyVnF5NXVNT0Jn?=
 =?utf-8?B?MTB4VGt2MDJrZURiTE5pcmdsUERPYU9TZUk2am9QUXNTQVNqbGJwZEwvRzl1?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+SPohgCq5kqyCWNDIhsBNlcslcdBFlddBaQ+RS+tRJF3o6Qi05XH5SvYwj8KLBL0x7nxTJatIBUyj2ISkoKmWK8DpUvSvBgblc7EepcTm4XrEXZ5WHnXIGf9zdvewWKV1a93vPrSUf4d+uCfpDY6CO7ov+SVe3wKEBO6QecS/XMYDIPNfKdm8Q/YbVUGvVdFfHeUUi7DVH0a/G0tAPAgGnOqey3ThWheZAOXlPFfsLqL7YVBeoB60Ez93+pQJ0hlAIpyWNJLjf//egYYwsHabhWAKEdTX3S+2fW30UssMEHfuPAeh9KY/A1Kd1KmGC1bow3RZvC0XZ6GVphpB5F9QNbGLSf7yWSYtehwxL9DKHmV2U9uFIjLlnczkGk2w24wxqdLvbAT+dZqs1Wwr2u6Q2vjTpy3S/DHtH2VWduYVlsQZspbAvZAEmYXcsH0bLThJpFKq1FDhNjNo9tawoz1T0lszUPhvbBwtZ4S7FDp21o/KL+vDQb2Gd82yJbHrghXI0znHaT240ka+lT+iJCsy7ri1J+3j3a6cK0d7iykSOAigzWWHVUpIFTmCyw8Qitaolgs5twhYgcDFsPzLTa9GuaoLt1/st17T5wwfQNa9tU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3b64d8-fdf3-42a4-326d-08de1af143e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:54:26.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJOjD4x82VwLDsPMrnhx7iEXdcQnm7/9MatArhy9HyC067R4RQm7jKyPmNviWxe7p/0OC/APgiyJrWjPJBiwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF072D269AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030143
X-Authority-Analysis: v=2.4 cv=NOrYOk6g c=1 sm=1 tr=0 ts=6908d03c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=8RY2cs3gc-CWFxt8O6kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 54TIgtQeo8lH2o1lXuIpUJ7BENyCfZEg
X-Proofpoint-GUID: 54TIgtQeo8lH2o1lXuIpUJ7BENyCfZEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE0MyBTYWx0ZWRfX/gbI5TWd1UB2
 SGlpOHCMXEpQMGgYiGoPPuJJ6beGSSnP9c1gvVLIoL8otpYsmkCSFfxZBJMM1RpBqNUrMEatSqF
 CEr6esP7pjZL8YBQep4p+K1jUeVqU4/PFmQDoRyWmZecz6FkjUy/gKEo99qdX4uC6r+aqbk6O7a
 ELf+kxAr+cgshheKEkLwWsOlwIPxr5CZu+gLLpQx19uUmDNviTKbYCvJ4qWORXGJA9V+Ssys0+w
 l1T8lVwrcB6aX25uRkjWuYJ292QvPAdqYdNTTKNCAik+S0SJewsUjCCw2Yipjsgng00gzmmlrgl
 HAESZugOz6UFbpk5M5RgKAAyzAzc8k48ML9MFXXHUlCRcb2Drm+B5Isu/VlAIAM7eT2ntjZt0Sd
 SZ8T2/LMVRIodb7TelNOLk0GcJbY1A==

On 03/11/2025 15:52, Jens Axboe wrote:
> As part of a recent move go exclusively listing git.kernel.org trees
> for the block and io_uring development, the "BLOCK LAYER" entry wasn't
> updated as it already used git.kernel.org. However, outside of just
> moving from git.kernel.dk to git.kernel.org, the "block" part of the
> trees was also dropped, as the tree serves both block and io_uring
> development trees.
> 
> Fix up the "BLOCK LAYER" entry so they all use the same tree.
> 
> Reported-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---

thanks

Reviewed-by: John Garry <john.g.garry@oracle.com>


> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0554bf05b426..b986f4635b7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4362,7 +4362,7 @@ BLOCK LAYER
>   M:	Jens Axboe <axboe@kernel.dk>
>   L:	linux-block@vger.kernel.org
>   S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
>   F:	Documentation/ABI/stable/sysfs-block
>   F:	Documentation/block/
>   F:	block/
> 

