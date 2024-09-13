Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166961D7998;
	Fri, 13 Sep 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221523; cv=fail; b=XcMYRy2BMBp1L0M0FF4ThSyhAyIn6ooq8/Hqgs2mNchHR1pFOyywQASMqExg2Xa/2752G2MiuUHMV9MxhKGMmRG2sS7xjIcMP4JC13xqNN+O9bt6o6+B3UuylVz+V3v3+90ftePp9IPrCM/MMXpWR3AWs1+/CwFv+KwY0GOKwGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221523; c=relaxed/simple;
	bh=MmI9S73cbM1580QGcARQYD5L7b4zfrvfn4yJIlyKTMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0xvQ7xCw3Mr5JJ+66CdzO5nY8ErobEfvU+f+yVIMsrydAi154n6e8lX0Py2O4r9bMTyI1mXW9WXIRxX31ygAIrTJSuDHGNmeb+FDRszd4VSGM0l54m7u/uYHLVk1da4wSYA6xwuLXsz3Lp+WAlkWG9CPOeKElmV9yC+ZF16+iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HXDbqDc0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ROe/HfU1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXDbqDc0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ROe/HfU1"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D7BUvE027354;
	Fri, 13 Sep 2024 08:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NeX59ki8261PfhytpWCrUXRXRvIaY1XEW3cmRRBrOT4=; b=
	HXDbqDc05FxwReqVSdtmIRYUPfmazDLczmQQTeunDBw1+M3OCd/CCSxLwQ7+GuYo
	52Iu0Vdxyv71MIlGuMIr9oUCbXkbQra4QXQs/XptQkKR3KzYZJhhp7rLB9nBx6BI
	VJvG2aTuklyRpe4SlepicO4D/jyK288iR1qZPvxgptc4PXOxG3LwesFnPSOFWfLb
	epCc+cPHbxFMubXHBGJdKUv63e5EcZVHA5yTiS5DFIjGejEFhzo2IC4zB4mPWtUL
	yCakpKJRNDrL787Smv7Kb7Glwz+tZMUm7Eub431BgGNB2jc8eR803LQYgc6gjtnF
	wMavbzsXVAM2RK1QaIvI0A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctn2t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 08:59:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48D6oI2Q004160;
	Fri, 13 Sep 2024 08:59:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cfjj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 08:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgRoSw6WnrI+xc2AGr0YNilFQo6Uxd3QMRjVaW/E814T5NdYzFCukY74yGb79Mej5vJrQed2p0z5Fod6yJAAhHVKWYaUxZUp9WB+d7njdWDqi69klPvcmqwu/8veQw2DoJYSLxptwr07lk7rW8bC2KKnYNAI8rtDPSGIVB3lh9+kK1QDCxgI9+pr61by4e3NVGsrHx8/G16ntBRsawPxlBmCp4PsrVsvd9DmohWBxAOeyMw0lETxqzEll+ddLknL0qp23ZB8lCTYqSFL6REPvq1yxOQtRx/G/dv8+elxZokThBIth1v3bfojCH8wEfY8NZGu3jmnsGKpStakl3Y6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeX59ki8261PfhytpWCrUXRXRvIaY1XEW3cmRRBrOT4=;
 b=oUILd+AiXYLYN8qkyOan2jGsEa6L9P5FMMrtsxhj991OboGnM17D4wxdFRG1adJRfjzdywLHiINvSg4jo/3XCdwGZRuFiwEcAWSnY9uDRVQs7aqnjRhHQi57l0D3Toi+MxJOUhXWqUMPTNY4YtaLhLB6aVDClTTtK/rATnXSFBEWnu+xCI/NtcGGZ+RE3uw3WeWzTFY1tn/gpXKc6xQ8fLcIgsEvSAYNNxk7O3D9Wu7bsTQ+Rf7Ps9gvUfGGXqx/2/S30TEGK/J10XvHVjpD4vpwjzbhFVKwh30/v8ISa3DahbFDQqSzNj9F6dWYOub0Fq2H6Upb0XIp/xcDt+upAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeX59ki8261PfhytpWCrUXRXRvIaY1XEW3cmRRBrOT4=;
 b=ROe/HfU12dvVXfDBic5dv3dJKDZwq4VG7HPhiTrsdikYWeL73iKPXDE7ePlWAO1x3QMSmG334ej0hmOtp2pRIkwZi2B9dZ6B/0PxPR9Zid2aNDjQyyAx7/uPlFIUYzdtTjvyaoMQrq+AHsbNTlVAfVUhB1J714jXqe77obwo2Gg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5587.namprd10.prod.outlook.com (2603:10b6:303:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Fri, 13 Sep
 2024 08:59:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 08:59:13 +0000
Message-ID: <a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>
Date: Fri, 13 Sep 2024 09:59:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: trace: add block alignment information
To: da.gomez@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, gost.dev@samsung.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Dave Chinner <dchinner@redhat.com>, Daniel Gomez <d@kruces.com>
References: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5587:EE_
X-MS-Office365-Filtering-Correlation-Id: cccecf4d-215c-4344-8ab7-08dcd3d256e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXRxZjdER0IrK25yblN1cllWUnNlcktCNXpzWXJnR0dkKzVwU1hlQW9VbDhj?=
 =?utf-8?B?SEFxNDRON2ZjSHQ2bXBEekNsczc5UHVEaXJLQnRLd3NmRlcxTjJHYXNaWmpq?=
 =?utf-8?B?dHgrUFA3KzlnWDF2YUJHUFFNekp3WElIcWhIMldSSUwxYTdWZTZzU1lhSmx0?=
 =?utf-8?B?TVhOWmJXT0tEclBCdHpFdHFEbnIyR2JWRlZOTHlsWGJaUWVMd0Y1YnErYjJ2?=
 =?utf-8?B?RHptR1lFeHZuQlVMcjFMU0RPK3grRVRMRElGNmFtc0lXRjl4UCtyaVJEank2?=
 =?utf-8?B?N0twWHFCMm15Q0FSdlRVS0tZZmYyclhJUzNabGpNMllTWHB4Q3NkN3pRNnVP?=
 =?utf-8?B?dnZwZlB0SU9EVnU4MzVwV3hhV05FOEZCcTd1SmQ3T1JXdVNHaHdrcFFPRVNF?=
 =?utf-8?B?SUdWNThZdGNFUm1IUDB0SEJ0aWJqYWtZOUVLb1R3c0c0dG5CZ0RLSzBoSytG?=
 =?utf-8?B?YXo0SkFhNVRMYWVTcC9PamZSWDM1Yk44cjhZN3l1dG1NSU9pYm1BNmJ5YjJv?=
 =?utf-8?B?aURiT2p1V2QzaGtvOFBGeHJBcWFJbmNuYkRrNGhHdStkekpZRE9KOVRoelpm?=
 =?utf-8?B?RnlmY2FNcFlmbnlGM0hsdGdmeHEvQ1NnV1dKS1NmeEVoWXRXaTJtWnMzQlRo?=
 =?utf-8?B?TFM5MENINkRyTWVucWxEem9WejBxaHk0RThJa3RmNzJUWWFWaXdGWUZSeGY4?=
 =?utf-8?B?bDg2MFozVVgyZzRXYXdsWHJaaWdGdnpRdnlmNHZtbmhLTnl1Wi82amQramZZ?=
 =?utf-8?B?U0VXcDhmcTRNem9EcTJXb2VMVmMxYXdlUVJnOFhtYVVSanZlQ24wQWVYbWVB?=
 =?utf-8?B?QytJR0N6TkZEdU9hZWtlYmZvT3RudGpoOFhVbGl1NWRtZEh6VGhIa0lwaGY0?=
 =?utf-8?B?TkMvcjZ3T1pLdVhJQ3g1ZXc1NWhFZzlCZE9OcjREZG1jdWdRcUpTSlhFZTdZ?=
 =?utf-8?B?L01mcHl2VjhaTjZhenUxUVRjSm10UGNCMWs3WElETGphbVRQaStzME51dnA2?=
 =?utf-8?B?aW1YQ1RJQ1pOU3RPdER5cWZtVlhHQjFPaURCV1JWN2g5VnNpdXhFTHJQN0Jk?=
 =?utf-8?B?VUpsaEp6NmJWZXFIUE9mWFNPRTBFK0ZCNTMwOFhiNmFkbGFlQUxkWGJwNHRt?=
 =?utf-8?B?QTRxY1NsK0hGc1ZadXY0R0VzZjNwZXZqL2gyc3BMN1U2cnJHNVVtenB4aHAv?=
 =?utf-8?B?bmZPRzVjbjlkTERicnpjSHl6bENPZEFwcmJVU2xJb3YxVnNpcjBiN21lODE2?=
 =?utf-8?B?MFdDSk1rRy9zQyt5bFE0Q3hyanYyMXZHVlNlbTNFRlUrN3ZZSWlPSGN3Z2FO?=
 =?utf-8?B?MTUvcVYvaTZCQVlEc0IyRHZST29BOWJXdFlxTWR3UE1weEVJOE8wUkNES3pl?=
 =?utf-8?B?dE5hQTdKekdaNTRNam1rUG15WkZGL3BUbG0rL2UyWHdKU0t2enZFSGxjbzc5?=
 =?utf-8?B?VFFoNDVKMnowTzE3R0hNVmQ0UlZocW83QWp0Y1JaaWY4cWg2a1BsRmtMTVhQ?=
 =?utf-8?B?OVpaRW1DZnJrcFF4eG9MNmJxMk9MWHMxdk93cjlYWEdwcm9xRGdOUzRkVU9I?=
 =?utf-8?B?bUVUK3lNaU5OWXgxOGMzUEpKMUFQRjBQUHlOeWRpODFyUC9PeXFnNkYyQTd4?=
 =?utf-8?B?YmhCeE0wd2tPWHVFbFJ0bUF6T1ljT3UyWDI2YndxTjY3TW4wZW56WHZaQkZI?=
 =?utf-8?B?TkVWWlFyQ3JPNjJPc2dIOFFkdWhDN213Nnlpdm56VWw4RkVOWStXMjRBTDV5?=
 =?utf-8?Q?Glbhdm24p1b8gFtMKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlSb3huV2RRRDAwOVZUNHlSUGdJekF1NVRqSk54Rlc1ZnhvQnNNNWFOWTdj?=
 =?utf-8?B?czVwRFpKYmNlYzR4SFdLNCsvME5OM3BPaHJqM09STUh4T1RQYlVrSEh2OEgr?=
 =?utf-8?B?bXdCUzJvUVM3VVZHb2NFSXp0RHNPQWNzTlZpeVI0OEV2RERZRjBncERnZnRy?=
 =?utf-8?B?elpZTmU2cGxkY1lhOG5vNmRrcmhHU3luL0M4K3RTK3NBNzF2WmhyeG9EN2F4?=
 =?utf-8?B?Ni8weEVrdFp3NFpFWkZiVHNPR1g3MVR6Syswblp1VExtVXZmZXg2QlAwK00r?=
 =?utf-8?B?WnpHRWtRZS9VUGorQWtHM0JrWkxzdm9kZjBCYTJhZ2N5Syt0dUFQRE9tRDZn?=
 =?utf-8?B?MDFXL1JYZWRQQTZSckRLT1NTZ0VIZXh4N2NGYVk0Qzdicm1KR2ZOYUlyL0lI?=
 =?utf-8?B?NlU3bFhZN2xBRWg1YVlpZVF0V1NDWVNLbERVSU9MV2JxSm5TTGdCZUFoUnNY?=
 =?utf-8?B?cGVmdTZITVhJdlhXYlpHNDNjUDh2enVONWhzTXlKc3NSMytGVmg2VUpnMnRi?=
 =?utf-8?B?TlJJQUtWbDFQckFJeEdEbjR0WXllSXBHZjVKOHIyM09ZTWo1V0pTcmlQc2Nn?=
 =?utf-8?B?azZmemUxNEFEODF3bVRteW03VkdabzdhQWRTVVNuK0ZNRVZ6dk5NRlNPL1py?=
 =?utf-8?B?OVJMdXhFdzRhVHRjbExEOVhiN1IyUDZWeVVmbGVaaDgrTk54RnU3N080cFcy?=
 =?utf-8?B?WEtacjkrUXFLaGxOVXhzTGg3aUFOcTE5L3QzUDJtS1ZxcmEwZ2lZejdUQkc1?=
 =?utf-8?B?eGk5aVROMHFJalB6ODk0TzErMFRjcklUbTBLdzV3dExyaHRUc0hBMnpTaW9a?=
 =?utf-8?B?SlU4K2FhREdBQVN3ZHVZUzd5K0NsV3hOUXhPRXRiL0FEeHBOb1RZaVdycW5W?=
 =?utf-8?B?S29FUC8wRUlleENQUTdJOGJNMlBvaU9kajZPWi8rNjRhTEdLeVhLQVBadFFX?=
 =?utf-8?B?RUdyZmpCa2RRcit5TVFMcVF0RkVPQ2xnL0d5dTY1eHhXUElibnY4ZEd6dkhm?=
 =?utf-8?B?RlNhc2JlU0dBaTNIZUQyZStsWHNSVURUdlJBWitaZ1dOZDZSNGJFaURnZC8x?=
 =?utf-8?B?N0VrY2JiWkNqaW00MTB3Vm52Z0I5S2pRUGd6VldCWlYzM2o2TCtITUcrTmdF?=
 =?utf-8?B?NVMxakxhMjdHUUpZdlBQbjlTeUQwT3A0L1E4eTlpazNqd3p2VE9YSHo2b25z?=
 =?utf-8?B?bmlBcmlyc0F5L2lOdzVreG9vck5MOWhISG5MNXEybFBsRmxjQnFyVmxlQVlN?=
 =?utf-8?B?emdxYjZ2Wm9WNTBwUTNydHdwQnVNYjlsYnJoVEZCZXNlUzZLZE5rNXo5RHdy?=
 =?utf-8?B?SXZZeU5ObGxhT3hMNFBNTXFndldrTDFOODdQRnF3OVdDZ2ZkZ0IzaVZrUzU1?=
 =?utf-8?B?a1RsamczYjlSb2hob25La281dXpPNDU2T0lFNzNzSE50OVhGMzF0NmNQZ0M2?=
 =?utf-8?B?R2ZNSVh0K3VmbkFMQnY1Y1hpeGVvME9wNEJSZXZXZ3NtbWp2S2V1MWtDQjNq?=
 =?utf-8?B?dklNSTBsaDBsaEcyNmZpWmUzVklTWGYvaWFUZ3hIUTRTQjUzNmxUVkNDUzJC?=
 =?utf-8?B?ZXpFSGR2VWNkWmFvQkdvcDBkb0QzUmF6VExOMW10M0tqZXY5QzQ3enJvditN?=
 =?utf-8?B?K2Y3bk5NQzB2QzFnRjVBdnMvYUJyVEQwMFpDMC95R1BDZUxJbVU5Z0xUMjRD?=
 =?utf-8?B?V3U1VEdCSEF3SlNuVi8ya2YvZld1cCtpMUlRcENEZVYzNVJrUkl5ZXZLWEd5?=
 =?utf-8?B?MjRoSUhsVjVKWjNKZWg5d0V4ZnVIUU5KbkxBclJ2dkZuTzFGK21xY2VqMXZV?=
 =?utf-8?B?NFB1NHFqdkY2WUxMLzdKck9Da1NHMS95TVpseXVPYjh1Y2hEWlpXeUxIRjhW?=
 =?utf-8?B?cGU4KzZMQXQrRHhwUllaYUNwa29RNTB6Ky9IQXRjeXBieFhGQUF6QVdoekto?=
 =?utf-8?B?elJSeWZiUXZkdEE1bFkrWGV3cWZWQjc1ald5SDYrVGRrVnF5S083Z2t3andX?=
 =?utf-8?B?MEJ4RmpzN0xaS3VxcnE0b053ZzJBZHZmMy9nK0lKUVhObXFPcmllMklVN25q?=
 =?utf-8?B?N05xSFVxYlRpMFQ2WVdTQmZGMXlkaFdkK0xNOEQ3b2pZTG1McUcvVFFiaUQz?=
 =?utf-8?Q?XLchWTCSkYIOCFdSN0wPWqyb6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	28lpTOKS+4kn3dYy89YuBs0Acb3xyGstKeTLQ6XpIznuVV6mDdoUzTklfdNdRBudOPA8mWKZZ5IvnFofprBDWr40zI54nseNjEyf09JFsxIA5AHAT07LvrAFYObwBWEx9xa+GlXI1N3F8T6N+i+clHnyNaCsl6BNqKtmW76beaAAZbgnxXL5cJU2NPvrDcepNnqbMbcbbCttgIp6GoXsMm4R8ei7XhAnBbBhC68txksAeOXr/cw33LUBcKdqwh3je8on/iLGnynVmjBbciv+DE2Vbuw0PBYVdNjSL17e+KqjBErV4plm8h9PbYcstrCppEBnCm/0uYHleOBMG78rRCHGtf8WGD5pKSV/EUeCmPjPK7BpHWLDbZvLJrbiNX74+0u5tkJrCzD20P736j1vwI6oTY8PhKC96bFQUK4HDkF3JHYsGcLvVtSJvmtgjNKqjdeJMsTPiDa6MazewhNBcUVYkXSv2iZ/Lp/JnHQNajmFnrTcQQzpzHXX0XHoUU6bLYk/XWE42UqT+yyx77St9YD58AzsVQdQ8JNx30qL+D8XAYwgzwslMmGb8p/HwSLMzA8QopK0eNgqUmXXygKE73c9OVWBi+0V5REzVnaIkGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccecf4d-215c-4344-8ab7-08dcd3d256e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:59:13.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znYdMyTK/mWjcobJKKHhJbv3UO5d1PS4vAqQZnUIlj6baDlGS+ui/Z57mpSvpgJmNUT1cHSSmHt0uYOxONjLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_04,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130061
X-Proofpoint-GUID: 4fbGrgyWSylWxhMNbO5CS_JMvpCASzyR
X-Proofpoint-ORIG-GUID: 4fbGrgyWSylWxhMNbO5CS_JMvpCASzyR

On 12/09/2024 21:48, Daniel Gomez via B4 Relay wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Report block alignment in terms of LBA and size during block tracing for
> block_rq. Calculate alignment only for read/writes where the length is
> greater than 0. Otherwise, report 0 to indicate no alignment calculated.
> 
> Suggested-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> This patch introduces LBA and size alignment information for
> the block_rq tracepoints (block_rq{insert, issue, merge} and
> block_{io_start, io_done}).

eh, shouldn't this belong in the description of the patch?

And I still don't know what we mean by alignment in this context.

 From looking at the code, it seems to be the max detected block size 
granularity. For example, for a 64KB write at a 32KB offset, that would 
give a 32KB "alignment". But a 64KB write at a 64KB offset would be 
"64KB" alignment. While a 8KB write at 64KB offset would be 8KB 
"alignment". And a 24KB write at offset 0 is a 8KB "alignment", as 8KB 
is the lowest power-of-2 which is divisible into 24KB. Is this a correct 
understanding?

> 
> The idea of reporting alignment in a tracepoint was first suggested in
> this thread [1] by Dave Chinner. Additionally, an eBPF-based equivalent
> tracing tool [2] was developed and used during LBS development, as
> mentioned in the patch series [3] and in [1].
> 
> With this addition, users can check block alignment directly through the
> block layer tracepoints without needing any additional tools.
> 
> In case we have a use case, this can be extended to other tracepoints,
> such as complete and error.
> 
> Another potential enhancement could be the integration of this
> information into blktrace. Would that be a feasible option to consider?
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/ZdvXAn1Q*2F*QX5sPQ@dread.disaster.area/__;JSs!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtYsRb3aY$
> [2] blkalgn tool written in eBPF/bcc:
> https://urldefense.com/v3/__https://github.com/dkruces/bcc/tree/lbs__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXthE7cfng$
> [3] https://urldefense.com/v3/__https://lore.kernel.org/all/20240822135018.1931258-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtqQ5uwAE$
> ---
>   block/blk-mq.c               | 29 +++++++++++++++++++++++++++++
>   include/linux/blk-mq.h       | 11 +++++++++++
>   include/linux/blkdev.h       |  6 ++++++
>   include/trace/events/block.h |  7 +++++--
>   4 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 831c5cf5d874..714452bc236b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4920,6 +4920,35 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>   }
>   EXPORT_SYMBOL_GPL(blk_rq_poll);
>   
> +u32 __blk_rq_lba_algn(struct request *req)

why use "algn", and not "align"?

"algn" is not a natural abbreviation of "alignment".

And why can't userspace figure this out? All the info is available 
already, right?

> +{
> +	u32 lbs = queue_logical_block_size(req->q);
> +	u32 lba_shift = ilog2(lbs);
> +	u32 lba = req->__sector >> (lba_shift - SECTOR_SHIFT);

req->__sector is a u64 - is it safe to store the shifted value in a u32?

> +	u32 len = req->__data_len;
> +	u32 algn_len = len;
> +	u32 algn_lba = len / lbs;
> +	u32 alignment = lbs;
> +
> +	if (is_power_of_2(len) &&
> +	    blk_rq_lba_aligned(len, algn_len, lba, algn_lba))
> +		return len;
> +
> +	algn_len = lbs << 1U;
> +	algn_lba = algn_len / lbs;
> +
> +	while (algn_len < len) {
> +		if (!blk_rq_lba_aligned(len, algn_len, lba, algn_lba))
> +			break;
> +
> +		alignment = algn_len;
> +		algn_len = algn_len << 1U;
> +		algn_lba = algn_len / lbs;
> +	}
> +
> +	return alignment;
> +}
> +
>   unsigned int blk_mq_rq_cpu(struct request *rq)
>   {
>   	return rq->mq_ctx->cpu;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 8d304b1d16b1..02959fbd5e28 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -740,6 +740,17 @@ void blk_mq_free_request(struct request *rq);
>   int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>   		unsigned int poll_flags);
>   
> +/* The alignment of the block in terms of LBA and size */
> +u32 __blk_rq_lba_algn(struct request *req);
> +static inline u32 blk_rq_lba_algn(struct request *req)
> +{
> +	if ((req_op(req) != REQ_OP_WRITE) && (req_op(req) != REQ_OP_READ) &&
> +	    !(req->__data_len))
> +		return 0;
> +
> +	return __blk_rq_lba_algn(req);
> +}
> +
>   bool blk_mq_queue_inflight(struct request_queue *q);
>   
>   enum {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bf1aa951fda2..28557987daa8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1433,6 +1433,12 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
>   	return !(addr & alignment) && !(len & alignment);
>   }
>   
> +static inline bool blk_rq_lba_aligned(u32 len, u32 algn_len, u32 lba,
> +				      u32 algn_lba)
> +{
> +	return !(len % algn_len) && !(lba % algn_lba);
> +}

why in blkdev.h? It is only used in block/blk-mq.c

> +
>   /* assumes size > 256 */
>   static inline unsigned int blksize_bits(unsigned int size)
>   {
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 1527d5d45e01..ba3764214dc7 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -202,6 +202,7 @@ DECLARE_EVENT_CLASS(block_rq,
>   		__array(  char,		rwbs,	RWBS_LEN	)
>   		__array(  char,         comm,   TASK_COMM_LEN   )
>   		__dynamic_array( char,	cmd,	1		)
> +		__field(  unsigned int,	algn			)
>   	),
>   
>   	TP_fast_assign(
> @@ -210,20 +211,22 @@ DECLARE_EVENT_CLASS(block_rq,
>   		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
>   		__entry->bytes     = blk_rq_bytes(rq);
>   		__entry->ioprio	   = rq->ioprio;
> +		__entry->algn      = blk_rq_lba_algn(rq);
>   
>   		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>   		__get_str(cmd)[0] = '\0';
>   		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>   	),
>   
> -	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
> +	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u |%u| [%s]",
>   		  MAJOR(__entry->dev), MINOR(__entry->dev),
>   		  __entry->rwbs, __entry->bytes, __get_str(cmd),
>   		  (unsigned long long)__entry->sector, __entry->nr_sector,
>   		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
>   				   IOPRIO_CLASS_STRINGS),
>   		  IOPRIO_PRIO_HINT(__entry->ioprio),
> -		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
> +		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->algn,
> +		  __entry->comm)
>   );
>   
>   /**
> 
> ---
> base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
> change-id: 20240912-add-blkalgn-block-trace-71e8ab6708f1
> 
> Best regards,

