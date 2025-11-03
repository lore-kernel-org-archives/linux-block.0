Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C61D7E5C
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184616; cv=fail; b=Yo0r0UHDSNVjP59rXwjKcVQh1yI4NvS7MEdhMTUH9+A/yOj4Dd2U6pPbguBdv21veRR07FJJb9or6evW6VicFvYP1AiXw+JkyppBPVNPJMYklLCz+rh4AVECD56Wwc9jV75ckpFnOWql/mCnACtTM7QRi8kP6jDcC74cbFoGcuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184616; c=relaxed/simple;
	bh=C3GQ+U/ta1nbj/mNqXaenlfXNGHqx7YwE7tiLVhXFMs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=keYi197MaPFCTGEvs4rfCmtgAlCvcV88uHU3n2H0fYsIUjLUD6nnZPGqwDoGS2rxNqChp2tHW8tuHTPBghQt3fIab8IBTOBSvqfr0haTiuoo5pEWLhJK2v3peU8X0gWdnIhRe7kPEgQPJqLxhu3VlRRFGOsouHBlwmiuDCnqv5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBpiPl6a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cuXdc9Rv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBpiPl6a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cuXdc9Rv"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3FdoJl004521;
	Mon, 3 Nov 2025 15:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xD51Yhs6OpQfvmCzfNsHEibdXWNTLLtRegfO033OFrg=; b=
	FBpiPl6ai8hNgBZrdfs85d/jS48d7dBR6BxXRjyAcDBsm6Q+iA1ErnuI+oSlGZBQ
	jnyP172eV8KagvzPR3LdogXNiukqVWS5WH4oID//TNLScjGhpcdEFVVIM6XpZw0L
	GTedolDbRzg5H8Yyx/EBV4hG2efYJEOqnOJ4Dp7JM1nBGfKagTen7WWFT3SEMGCp
	oT+dnU7B29C10jYvjTjvjWpERg8zJeI4TAgTT3Ob/t3HjkwO5u0in/ejILxICAms
	/1gUOwPmXEibWO4CevI7NPqzNvFEQEDFFrUz7w2gb4Ps1DK/Vwp4B7TUvToH7eEH
	jb3KIRNmgkb+8vPOv37zjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6y7q808t-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 15:43:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3F4dvP009575;
	Mon, 3 Nov 2025 15:29:44 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbtaee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 15:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdt0hhBvUg9ent+aFXrx60qk988GUFfQe/7c56OELheg29I4FdI29gOM0QimnRi1ittCnYvTMCUSBm2N6/mi14ZQsPwmFL7DqOzq+BBctn0hk816RTBVNtDatE1giMNYe57jiMwfVOEcJ6AVs+jOImnVvRe1FV9HZN9Tu5Mr7cEPfIA4oIgf67LaUXipzqyutGhWI2mBoCI9T9JbfRpPE/E1iP05DXgh4O3o3I7Nd/P1CZS4gPBE8t4yjbD1nvobAASTmj42cIKza8URgSSPqQkQFvb2fBGOsx9eoGu2HKE3V2CXjxBG0VJ0R4jYORA4f3vZuVSaNzMxTbzd9fDmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD51Yhs6OpQfvmCzfNsHEibdXWNTLLtRegfO033OFrg=;
 b=sw2oY5Kga+q1j6MSC+YD53einyo5ILInTSrHBeVrqlqNp00J6yi1l4nN3k71DYs172DUsIzhvDyi2/lSmvU6IqnS/1scY3ZNXxkkemf+CUt8KCS5hzxpzZkmvVvM/bA3R+bHTDKRq/10FDpuuzGgb1qE6NQC/vU2wF6SqRfqd3jE0gKCQ752Ryt3O7sxDoLni70Hb6I/LPvbFQaBxflmSvnKLzDH68LgvI3+u0A2SkqmYwzBq7tymE9QEBiCS/fmZHLpIve3GnaJKEaGFVGoTA0DHl1UDh731X8ABs0Yzyk8vjovEIXSg8YM1s5OqBE9hsXKvKG0SzWEA7uv7Vtg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD51Yhs6OpQfvmCzfNsHEibdXWNTLLtRegfO033OFrg=;
 b=cuXdc9RvHAX2XIlLxUrDHqVvYqLcYMTSqhMDpGs584JYgXvcDyiALQrtuB/Jwa+nRWDf0Wdek6Vs8x9SsS1mOyXSkGcSJbQpkdG2tclV3SyCJp/r5qsCtAz3syu88lyT8CunIyd6Q+DNOZxU47sOX4nDfVmxV3XuvRzpzS+dz14=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ5PPF7F0BE85A1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:29:39 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:29:39 +0000
Message-ID: <2b53f0c9-3151-4f00-821e-ddae5c2c2135@oracle.com>
Date: Mon, 3 Nov 2025 15:29:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update io_uring and block tree git trees
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
 <ed992ce6-5224-4bf3-8bb3-91fb112c9287@oracle.com>
 <b083caaa-5dec-41dc-8885-8ebb34cd1781@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b083caaa-5dec-41dc-8885-8ebb34cd1781@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ5PPF7F0BE85A1:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3f1d46-d8d0-454a-2019-08de1aedcdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVZabkdTcG1zOUxIUFQ0YTltWFU2TXRQdVRaOHRIbW15eUw2UjZURDBUYkJo?=
 =?utf-8?B?VmZOQ25uRDY2eHIzVmY5dzhLakF4NHdCZDQxaytOQ1Z0RnVlMURrZ3l3RkhW?=
 =?utf-8?B?WjhZVyt5QlRHYzQ4TGlwenpEdi9Gcks0Smt5bmRHV1hCTFNmRTA1V2ljVmRU?=
 =?utf-8?B?MG9UckxxQ1hCUVphTzVNaVVYMW80Mm1rdkkrbTJSa1U1TkdmVFY0YXJwQmFE?=
 =?utf-8?B?Und5NVdkWkYraEhUT3gvTlB5YS9TVGNHNU1LN2RjM0l0aGk1LzFKSWtWejRp?=
 =?utf-8?B?OXFtQnBjZDVSUHE3bWUvQnNZb1c0WjJZakVVVGx1NHZTTmRzdDJENG43R3NS?=
 =?utf-8?B?Z3cyMm1YU2htTmtNVVRtVXNoZWt4NWRxbW92R0hNUEtodlRScU5IeXhFNVFu?=
 =?utf-8?B?UmU2RmxXSjJXeStkOG5qQ1E5T1k2aGE5WVF3V1RhUWZzODdHMXBDU2wvcjkw?=
 =?utf-8?B?MERVTEtXbDVQa1FySWRQbDFXckNVMmtSVjhYRmlkL3dYQnFEKytuR1Y3Q2R0?=
 =?utf-8?B?QmJRcUcxT3NmVnFraTkvUlpEOUxoRlZzMkhnc1MvMVZyUjFPSy94K3NXNi9l?=
 =?utf-8?B?SlB5VTc5YXFWL2VXcDZjc0VON0NpbkthVGh5N3hnY3JzNXZNYnBNUUxMV0ZP?=
 =?utf-8?B?L0NoTWtURkpydit0TXpFa0laWWZBR0U5aWNaaHc2UnFxN05UZ0pHQnFHQWcy?=
 =?utf-8?B?bGRpOHlKOFg4WUpUc0s5eVhDMGdCRHFVenVWS3VaOXY5WXhNOVVNV3NzMFR2?=
 =?utf-8?B?RnlTMGRMTWlLRGRjUjlPTU5BR3BGZk9RM2NHaW5WQTRYTHMwemdibis1MTd2?=
 =?utf-8?B?dWlMcDVSdDB6VkNQYk5MbjdxNE9kTTZnZHJwTk5MckZraTB2M1EwNkJoK0Qr?=
 =?utf-8?B?UjhoQS9FNGx5b3NhRFVVazBWRExyZitrWFRVWERHVkhuMkt2c2ZrOVNDWXRP?=
 =?utf-8?B?STMwMWtPUWlOdUZmNFNwVkNFc0tOUlE0MmRWS0V6OXExbUJ5c3htMW5CVG5m?=
 =?utf-8?B?ZGYwYk5STmxLWks3SVQrTVNhRDFBcmhTeVNVRjJncjlSS3NGWkJKb2pWTEZC?=
 =?utf-8?B?ek85ajRJMVpzSXpSK2lnZzM1N0QreGFEMXhiSVE1UDhJVG8vKzRVYzI5QXN5?=
 =?utf-8?B?MEN3TmJnaTdPSWRjbW15QVM1bnNtR04yVStjYWdMa2NJZGFRNWlxa3htdGpj?=
 =?utf-8?B?TVY0V1BKVHBpdUdRNldoQzg0dmRsZTlobnlwdHRMYkFtWGEveHM2Zk81UnZ6?=
 =?utf-8?B?YXlXcFdXN3JhQjl3M2tnRGRoTXFFcGU4UWFPbmxrRTJWVDhrWUtaaFR0TVRN?=
 =?utf-8?B?aE9TTnRQQ2JEd1VORWV2YUhYeHVkQ3hDZDRBSVpGUk1kend5VUpDZlZ5c1R1?=
 =?utf-8?B?THpFZ252ZU43Uk5oOU5iUUJkdWNiN2hHQVJScW8xZVBRRVA1Ym5NcnZiL1Zj?=
 =?utf-8?B?My9UUmFwMTQ2ZklDdmgxelJ2L085bi93QU1YOElkZEZSSTBmV1U1aldTVE5z?=
 =?utf-8?B?VWpRY3BXd1VOZkJnMExIWG5qQnVhZ2xHY2I1d2NNTjVVTFptTmNtRmNUS283?=
 =?utf-8?B?QkxMVG1IN2NTZm9pY29iL29FUEFiVG10NHZ0ZlhZTzhHWlJFb2EvZlZwRmgz?=
 =?utf-8?B?TkdpNnpKZnFKQlhaakxxdkRQajlCc2o5VEpaMEUrWVlWVDBSZXF6Z2F6Qmkz?=
 =?utf-8?B?YkxGYXhqNGFDdlRkREpVM1ZPTHVUbUJpRUhiRFhXVmlnbWhIUGRYa0RDNVBK?=
 =?utf-8?B?TjR6SlREMWVUbkVuNHRkaEJsUDU3dUNkM1pHRVU5RmQ2b3YvOWRnTG1tRU9w?=
 =?utf-8?B?UDhvalVOR1JvZUdrQkFaZWIrNzFTS2Rjc2Z1Qk5VQktKeldGZ0hsTW5kWUZW?=
 =?utf-8?B?bDYwUEpkeUFEb1ZvRU1nRWNvM2FoNDRUeS9ldWhJU09aR0JDOEt0cVpRVXQw?=
 =?utf-8?Q?m670j4NPrV89ozeeC/8pl3hIx/2LVXfO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzMrZTBLUGNTdy9UUFg2VjdqelBTMThlaDFGQ0hpeDdLRzZ1U3BOM0t0aXZt?=
 =?utf-8?B?MjgwQVNQR3NYYWhUSHFlWXBXYmdBWi8wYzNEeTVjVVA1S0ZwMTlCYzJPN1hq?=
 =?utf-8?B?Y3I4TjFGTHNtcHowM1cyQTVyRmx1WldjTjdpWWw0Z3RJUDJYa05iMktPUkpq?=
 =?utf-8?B?VzBXQ3U2SmdXNnBQTjk1aGhZT0lCdHVDZFJqYjBmVnE3YU9EZ3hmdlB0MGgy?=
 =?utf-8?B?Uy90RjRFMjB2ZFNLdjMxZHJzVGs2Q1RaL09RQnBObWhUNXZwMkIvQXNtUGpG?=
 =?utf-8?B?Tlh2UlozQ1I0TDRTOTZKbEdqM3RvNGxHblZtSXFFL2MwTFZwaG5nSHlSanlM?=
 =?utf-8?B?M1hyT1FNSHBocUJtL0M4bTNudnFDRVhJc0dnM3BYeS9TWE9WajFxa21COEJD?=
 =?utf-8?B?QkFKMmp1ZDlhNWpkT2k5alV2MnZlQS9LdjdJMWkyRVVudFZNeE5YNERWZVdj?=
 =?utf-8?B?Uko3WHQ1UVlKNDBubVdHcVpEaEI3a3R4R2pBZUI0MHZuK0FPdHc1ZXp4cyto?=
 =?utf-8?B?ZWdaYXhZcG8vZVVGVmdiakZQNlVTcmtUN2xxNmY0a1VoM2pOa05uV1QvN0I1?=
 =?utf-8?B?NGl6a1ppZUpIU2RpeXNNaGZsdXZ1dDE5ZElyU1NRaGovNXdFQTFvWnpGODBm?=
 =?utf-8?B?NDBsdUt1RFJPUi9DNXVFemNGTWxaSjhQejZIZXllTFdza3EvQWtGYlg3dUVB?=
 =?utf-8?B?d3BnbXBxTXhDTTZjVmFPSXUrM3laMXZtN3FyOVQ5b3FUTEZKVEVtVEJQOUl4?=
 =?utf-8?B?TW4zV0hOUHVkZ3o2OW54YU4ycHdrak16MHhZS1ZvSTUyR0xsSFdTNXM4ckNr?=
 =?utf-8?B?b2kyT3BtTDQ5ak5jM3B1TlU3UThYN1VnQzRydXdiSUVQbk92RXNRM2lYT2Na?=
 =?utf-8?B?YjlQUVhJTVg4aEVLYzRpNWdqeFR1ejFYTk4zck5FT0hRK2FjSEd6K3c3VjhQ?=
 =?utf-8?B?VndoMVk3a0dtcmFXbnpnRHlMNmRvVHRya3dJaUpuaVNlUW11WHZEWURoZTBD?=
 =?utf-8?B?dFBSZDA5YUxqRkpwa2c4UjVLclkxZ2dZUzdmSWZOcVllNHJrNEU0dnIzdk5h?=
 =?utf-8?B?UlFIYzNzV2phQmpHcFNRN0lPM1VyUVRJci81UmVMR2Q1R0kzZzVROENSWXAx?=
 =?utf-8?B?dmt3dzFkcnAwZ1pTdVBrTnNRckVXbWpITmY2bVJaaWlPSFRUQXFwOTAyQWk5?=
 =?utf-8?B?UzdwZldCOG1Jd2xSaWlWWlNXMmVpVy9hNk1FMWR6ZG05TktzLzIyME9SOVE5?=
 =?utf-8?B?WHcrei9WNktSLzMyOHJ5aGZZMUpYUUVnVlQ3UzlTYW5jTzRlLytSUm5JRGhW?=
 =?utf-8?B?akIwNHZwQVEyaS84SkM1QTF1ZWN1OEx6dTNnU3pnSFBWa0wydXRGdnJ5blds?=
 =?utf-8?B?UU5ldkRzL0N6ZDBkbHZjSDVlM05OTHhhRkZ0cTl6dy85NXJieFl1Mm1FOExN?=
 =?utf-8?B?aWVYWmp3WlhGV0Nnb0M1MlNYeEVMT0k1ajUzVi83K0JCUWtJUmMyYy9xa3k5?=
 =?utf-8?B?N0lkNm1VOVprTDZDVWxzV2ZQalhlOVluSjF1aG44bjRXb2k3RzZ2OXhLaWtV?=
 =?utf-8?B?NTBsWW56OUl1VlYvc25lTDVVWW5xUlR0OW9tdVYzZUdPZURWb2FWL3V1QzJr?=
 =?utf-8?B?WW5pVDlsUFMvbS9DK0RiMVpjMVU1dTJ2alpNc0IrOHBZSWU2WFd2ckU5SDZr?=
 =?utf-8?B?NkxBNXJGb3FubTh6cmZ5OTdJOXI0L3JzSThDMzBLcWVMcWFKQzJZcWEzYUdE?=
 =?utf-8?B?a1pKK1RROTdBU3N5ci9JQUNQdkVGU1hVeWNmRG5HYldrTTk0Qys2OU9URytU?=
 =?utf-8?B?ZEtmZ042am5FdXRwTjFWejB3ME5haTBTRnVzVUhZMDZvTEVvd1VaNmxFbWV3?=
 =?utf-8?B?ZVovSmswT0o0bFhRQXRLN3BsNS9RNnh4YSs3WVRIRFZiT2ZqemNmNlA5cGYz?=
 =?utf-8?B?OVlVaVczZDkyZys1R3AyVzNrUlZpcloxRTdkcjExZlBVcjk3eTVVN3N2cWlh?=
 =?utf-8?B?V3lCa2FwVmV1QXlqNXRHb3BiTmFZTUh4bUxyK0xOUko5WkZWK3BDb3M2cysz?=
 =?utf-8?B?cTZ1cTV3M1J3N29Eci9VdFZFQzE3MkxJcEVRL0dnUW5ZcXYzTUQ4R1Z1b0wv?=
 =?utf-8?B?aDB6TXZwVkY4SU85dTQ2ejhwck5uNlp5eXVQeXZOeEVKME9vVzM3MDFBcEdo?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7IDF4ShyruAserWtUnkvXKF7LU2FZIRWVBVVhO2XATHaKV5g8PFnQRmugZLWy5b4TkDeKuzAe8G2AYuop3F3GR8XfkKFEbS4EIv65TB6ptHxC+zaaaJdRUeV3EBjpqinuQlFg2rrPpQhRxgbNI+P0/PDDvWdzHeefWV+7Qu/RE2IdezLOPaEsZ78I3YUreFk+WBbcZpHv4FjnHPpJTAchz4F7TlK4e62xvUkd6CmQr/WW+g17S1mZhkS2qpcIlVVxGlxBrp6Wb9grDZveo1Q86uKwXkFhexsfSRfY5yhMtuSrMYXW36osUtbfGtuezi2INAmS2+ESTPK8GdAgitiGlAgNnqFHa79R9lfQk1JAnxRXziiQ8awB6gMPILgyip3XBo588y014syjLpOjnmXdmwkZva9usp23i9tSA+qjMuuixpkqFDjkChgLFaXTwJXmbPdoM4cT+YAykvxKDjqgU78XmMP24rVLTlXisxrmw83JxqdEttzBMYC+fnlpQDR+FmsdnMCOoTt1k2OeWtwjDwZNwVnva9AQ6xTEN4dUmKn+W9ulussG4qlqBc8jZJfatntyCvp597e2lKC/wmw4lfT9Rp8ienI1SPRIy93eCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3f1d46-d8d0-454a-2019-08de1aedcdbf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:29:39.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XURHTXrkzoCr+nYtTDotD+JedgsCzVcJX8h7K/aUTnjlKx2dmK204r/yoJJm5rOc+1mAq4n7d8BP64/viXOriA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7F0BE85A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=897 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE0MCBTYWx0ZWRfX2BoWlqg15vEM
 XgsqVxVuemV6uzArSZUoZlyfpfXdZ2ctneaVMcNp0xLK97+F1/AnYXDVebBP0OT0XTFKYfUwyjn
 x8rHZppGxC5jpJ6y5gYHglrFOUxfQGVjz91dwH9lcOm3BGA4TU1yQgReR3hpB6UlwnvpIu11DvA
 fuuZVziOTvdxzSXrGtmUE3fddUaXmvR28v1HFGdnytGlM6vF5GyqlzhNg+tE0FIF+PP23PeTDIa
 dHy7EU3H6SYrCAkbjo24BSfcW7RdyP+5ZF/w/b9ntCWAeqopwYtKeXYaah+E99HbGgLWl8mxtLK
 QnmqzF26RggRZg/IKs0VFxelBDJRXY8RAx6ha30xtfD3vILngY7khj+MXYLcKHFezUoVJKfeuWq
 Yfefx7lpkP9f70whoSlViGqcDCumaXpnb2g+y52SX4wIQT6dgjE=
X-Proofpoint-GUID: OAHhCdmb7P-WTrwqvdqE1YluGcVxf0qh
X-Authority-Analysis: v=2.4 cv=H8vWAuYi c=1 sm=1 tr=0 ts=6908cda2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HvnMZ9rwtD1hxA9Z0UIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: OAHhCdmb7P-WTrwqvdqE1YluGcVxf0qh

On 03/11/2025 15:11, Jens Axboe wrote:
>> Were you also supposed to update the tree for "BLOCK LAYER"? I think
> Yep, as per subject, "update io_uring and block git trees"
> 
>> that previously it was
>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>> (as that it what my .git/configs entries have), and now it seems to be
>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
> linux-block is somewhat of a relic, since io_uring was managed in the
> same tree. That's why the block part was dropped, as both block and
> io_uring have development and fixes branches in that same tree.

ok, so then I would expect that this further change is required:

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..0f7c7388bd62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4393,7 +4393,7 @@ BLOCK LAYER
M:     Jens Axboe <axboe@kernel.dk>
L:     linux-block@vger.kernel.org
S:     Maintained
-T:     git 
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
F:     Documentation/ABI/stable/sysfs-block
F:     Documentation/block/
F:     block/

Thanks,
John
