Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5B3D6CA7;
	Mon, 18 May 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092134; cv=fail; b=KMUSis825BYPDJknTvpXB6xNcWoHEBujIR+jh98ZXhYF9jCnYT5DG1us0NDELu2H1NXwzRoAz7imcrXaLaPbJYs26LP80oSv7owK3OtBzs3bj7Ayw9E3E8XzputHk6wqsnkzRS0AuHvQaCC98F+J2G1zfMTnosn+ew7xU1JitTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092134; c=relaxed/simple;
	bh=9d2XSZxnorGefM/EwKCxMDsDv6rxaBLAi9LNxr1oPhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hF09fIuR9FlufcUxkjnzfq6k7Z3rQ1iV/uVhWbVM7tLAWKhZnNk8mvnuCiRFEBj57Iom7kIfGpHZgr4HU6rtysSUJp8YrLQdzKDFknoDfpZI496vGUDx55wGXWgE/SjjkieBOHXh1Vn3ptYq0DRoxtwmIZa6wnkF+i0vEeLKPTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rx5wjx6D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g5BQeUYr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rx5wjx6D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g5BQeUYr"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I0nDWj540876;
	Mon, 18 May 2026 08:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KaydIROz+AOE4MiFduGfp0Sz+1eRAwMhiSOasN3+oIc=; b=
	Rx5wjx6Du/W0qiZZQf+Fa6a/cG9H7DSoED3To4jhKvteJKsNQnHVzA7xE2VWx06i
	n8tUQHAN7Hvucf4H4BNlk7jdFJhOa0u9hb25TD+gwJ3knQ42/KncbYF7XTq82C5e
	hdHwgtP4B8W7yYYx44V3hajQQXLJubMzNnkdZJ0+9kCi1VyTGjXahBT5+/i+SLRQ
	bbJmj6ntE1vUWwmDGMHu/NI0Jg3LcPNS+SpfQT3dCQpMTm3HpZKYzA3VkBv/o5uy
	WnagTqVuzA1sj/r25qFYp3o+0yg+WokwEyz4q2+dnu1GX5wxLD9yEQm/nSSVcZbj
	zc64tJMzifYoO0kB0cE59w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyx1ss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 08:15:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64I8Ehsw015095;
	Mon, 18 May 2026 08:15:01 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f193wg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 08:15:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPgwpAG/bCfFcHZbqTsfDavLZhdmk5DoPaUHBibYZj85V4A8+WhNWjjWqL3/0vPTletX4TclIqw96z5xKtjv6AwXcECTGRC00eJsH8uFfJcg23Y/qeg3cSECmPiUfiWP0c+OPAEiV1MmraElLFKOkyMy6WcDRsqhpA+rrCUag+D8QgUsmF153sNLbqkdXoGCpT2TzlIBXFpRETnfXL41wJz3NIjX0Hnssvy8P2Z4RuWfjdITPH5rYLsasLbeafu9J/LxAN8qDY1FPfd/GIgiVgZRtVRo5Uqmwi39gUCzv1Td2fj56NC1d+TaSN2oN8hWfeWbmvfwjBp9wCps6CjLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaydIROz+AOE4MiFduGfp0Sz+1eRAwMhiSOasN3+oIc=;
 b=HJ6tpMYTKNjtVnUceOVo5cHhFv2IFvAzs+oXRwwfr6trbRoT4syJOplgCmpD2QXs9lMsJonQmQbShHoS+S2ujCgNw3zg59frgGeBvXuQsoJpx1Hc3P7+TqhhQ0gG9CksYhwNHVgGZpbAq5viGp2pWoY6epA7KR1sWjeHBSfPErHe4aDf4LnBkz/rBxExpmejQxAaRo8XvA8VMXqUY5tcBKUWNfuPIGKxhWpyTVHoUB0DmdLiovXF0J5yNMvgKglgI78EyC9EDIXx7AJoGdy8uiZbJHslF/khpewhffdVE2Mh2z1iY36aBGkdUUS3npefRS4AeN9s3iVsVXdTJ/XqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaydIROz+AOE4MiFduGfp0Sz+1eRAwMhiSOasN3+oIc=;
 b=g5BQeUYrefK2Xe1c0lS2OmKTbeKch9pyKEKc0S86Co9fNQ3N07aYsJJUSBEDWS0m2GjhzUo/S8lw4b8DwKjGiFitGbcrxmIw8AUn8Do2YEscmBeQaWTDA0t9KyqmsDUuOts4PK9IbIcHnop5F60QZimLum6Se+2vC57mC6OqCZ4=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA1PR10MB6218.namprd10.prod.outlook.com
 (2603:10b6:208:3a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:14:52 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:14:52 +0000
Message-ID: <fc307bd1-2c41-4bb1-8a10-b9ffde685d30@oracle.com>
Date: Mon, 18 May 2026 09:14:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] blk-mq: expose tag starvation counts via debugfs
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com,
        dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com,
        neelx@suse.com, sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <20260517213614.350367-1-atomlin@atomlin.com>
 <20260517213614.350367-3-atomlin@atomlin.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260517213614.350367-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: c189884a-5374-4767-ff1a-08deb4b58967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c5FxBwuhKSNDSiO04wnh6tb8hvf3UFy+T0y3gpDNXqp1jCxJaQugCOuiTtVYDM5oDjhpHgH614Ficf5Bb9ICqNWd+cx665gV1842uU9kinsUuz5aQytx7+3qnSl9Qzt8XyM5SqxCCea1Vrbfp5tzWGVuPZ8TtYaS13H2OfMpYAgg3fe6oVryPu+TsvBOhx+uqfjG80llFpAFSIbg/rw6iRFKDKR0JkMgLgnc0kVs/IbCEOQupE9KzQpunyDm8f7qpfEO7cw2BSqI6qXJuPzOrMskkSLfFAT7q7t6uM7hEEQuN3C2lOfYA+bpExuENxf39odBriZ61nQWkfGFyt64GxwX3Kz0ClWx1ZKpIPbz89P7bjlqoAnzzJbaF4rA13PlpGP4m2MFvXryH3pF3CJmMYCgexS4r+w3b7xLej7ktPY8rek4O0stHiUcAWbYXHG9PM2RjGYZDwUIky431vDlPq4srfnFLlZPzlehvR1kDFGXCUxePsodO4Sgv0zFm5etVGPeYVJoxycTSCp+8O8OHV+4PKYu79ZXYQvx5pKnpAgK72aKNN4pAy8v5kG5E4PN5qanlSrDPr0QPl0o5y7QfGw1Iww62WaigEWq/xmAr7IYagfUd0jtRlIfqFVIWIs7iPNXDyLSYqCUijkn/S97AiDFU7wpa7jYOMdGCcKOY6TK5vgvrFRBfIXYRL/zTozz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNLS1RvQnhMNmR5MDdSeGpZa002K3ZKbzdaMkljZVhYWUJEQXIwNDhjWm5a?=
 =?utf-8?B?WENFU0ZNd0pwY0JvYWFlSDdUWkpDZm03ZGs3dEdTNGFEOC9mMCtQT2tvemcw?=
 =?utf-8?B?YzErUGswK2hZcnB0Z1JXUnd3MzVlK0l2QXRLdWUxR2R5RWJOVXdRUUZHM1d6?=
 =?utf-8?B?SGxLNi9VZHhkKzhuT095b2E1dUpDSmxOTXVpTzF0d05QcmhmTGtIeGkzc3Vm?=
 =?utf-8?B?cysxSG42TEtGd1JaNnk2NWkrd3Z6d09FYkJ2Q2RyYWc2Z0xHZHlySjV1V2JV?=
 =?utf-8?B?aytrSFJBVmtyZ1RPOGlTT1NzMUJqa29HRzFnQ2trU20rdy9yTlFQTWQ4aEJO?=
 =?utf-8?B?a05XWEJJWTNxV25HM2VvNWorK1RYblJjY3ZadGRKL3RGUW9TTUNaU1grNUNI?=
 =?utf-8?B?UHhFMUlTMkxKZHkrN0tYNUhlejVtYjBGSEdPYkhSNldKbmxpQXRvYklEakNT?=
 =?utf-8?B?MzhPNDVQR3o5VWtneGtSSnFOcHFkdmxETUZKalM3VXhzbXhlWmRCc005bk9X?=
 =?utf-8?B?NGk3QnhwRzByTU82ekY1VGlUeG9mQW53VWpFY2FtbkRXczFzbEZZUHlFOVB0?=
 =?utf-8?B?VmNLdzRudTAzNVl5Y0FRM3ExREIyNENzNUtGN2pFdjRwck15NlIwL04zWGVP?=
 =?utf-8?B?S3Mwa0NLUUF1Q0dIN0hORURhUjRpeWNXK01DMVZSaGpGenN6R2NiNk1lOTBI?=
 =?utf-8?B?RjBIOEpKMWdGSTdEZ3pTM09vQldwdEFLcVQ2MG5vVWJpNG54T3hWQzhoSE14?=
 =?utf-8?B?T2NENzhPMHQ5Vk9IRXhteFZweWg3c05Kc09PYU10NENjZWpsUUdmanRQUmZ3?=
 =?utf-8?B?dnB5RWFGVVhJODJ3UHNCbWozZFkrdWtMbk96YlN4OU1iQUJOS2NEUlF1Wlky?=
 =?utf-8?B?NXhKQXVaaGhOL3J5UVlQSVVybXNUSnBwYUlPMzNYQjNVcFVkN0szN0FaL1p2?=
 =?utf-8?B?cWZkMEFwd29tYnZ3b1dpZmlvQkwrY3E3VlZoUkVBM1VNUktSQ2FhRVFuVVVM?=
 =?utf-8?B?ZHFWK3NNZGRjQ1l3MWFuYkdIWFBpTU9BdnFnQ1FJNzNJd3FDZjlWVmEwZGV4?=
 =?utf-8?B?YXR4cVdqRUVrcDEyT21yR1VzREpudXlTUVFaV2hGaDMveGRKR0h2TWZPbUNN?=
 =?utf-8?B?clN1L3Z0ek9lMWVPcVpaeFA1UVJ1dGV5UWE3dkpocHB5V255SDZFTXhGSUpR?=
 =?utf-8?B?Z21HemhaMnlwNENaZ3RZd0M4VS9KZUFtS0hFQU1yTm9YZjYzbXRFTnJqRXhF?=
 =?utf-8?B?SWRQTHNVSml3Si9heHBkcWQ2Rjl1OUx3Ym0vSERoNGt4dUlIeWVUTWd6enEz?=
 =?utf-8?B?ZUk2RWpiM01NSldPVFpWenVMYk9ZbElIZ0lmb0FPTEZKcWJyR0RuUXYvZXUy?=
 =?utf-8?B?MUw4aVVsN1dIRnVUNjB2TFRiWW9tSDhMeTNLeDE1Y2dZYWpES0JrQmFoNjNq?=
 =?utf-8?B?ZE5kcy9zMC83UU9Fa2psVHZNWnFhRmlnOUpOU0graVhpZHNQVzduWTZnZGVP?=
 =?utf-8?B?Wk5YUUp0REF2R0pPRC8wc2pjdGhRWlVRVTgrOXFsQU41eDVKcWVaSjRHUU4z?=
 =?utf-8?B?S1d2M3k0SnRSUG8wanRiTFo1am9RQUNaazVma2h6L0YvQ3lBdXRML3luaWRC?=
 =?utf-8?B?NUNOWVZPc0Z5VUtnNktuVjFEV1RhUS9HODgzNVhjSGxYMHpCMVhpSmxnRmc2?=
 =?utf-8?B?TTA0QmFmTUVzdXgvdStDUGpXYXlSUHZWd2xIZ055dVJ1cllNM25DVHhkMzJs?=
 =?utf-8?B?ZE5MdmNlelJnOFhmZnpweEJVSVBEVW5LeFUwMERTMmEwSCt3VkpYbTc3Titu?=
 =?utf-8?B?SFVoUWVWckQza2YramU0ZFZJTTBqcmV6RFl0aURCZi9nYVZVQy9sVGt3N1NB?=
 =?utf-8?B?WCtRWnM4L2x4dzhsVTFtZW5FT1BVMi9yLytjdzVtbVd1M3dDVDd6dmVuUXQx?=
 =?utf-8?B?SXhBaGpqaGVTbUlDMXdpNmcxTE0xdGxEZDJpWTF2ZTNuaXkvS0hmNTI4Y2s5?=
 =?utf-8?B?aVlRRUo3R1BsY2l2OFpYMHRuSGtHQzFRYktuMDRoK2Y5MHJxWHZMcVRMVm8v?=
 =?utf-8?B?UWtxc3V1VDFQYWpWNUYyY1hOTklmUFJDRStvSmNpWE5xOXN4bE5NMTJ1aW1F?=
 =?utf-8?B?WmgzVnducG10ZjIzd0V5VGxneHo3Nnk0L2l5cElIeU1xN01Xa09sQXdQUFFH?=
 =?utf-8?B?SHV4R0MzNmZ2dTV0NERsUjdreVp4NzAxVmlHaWpWeGhrTTI0SE9HYi9LL3BY?=
 =?utf-8?B?ZG1kUWVlZ1dLa0RvRkRTVkJnbVQ1aVlZMW9rQlJVR0xEM0pEOEVwZFNzME5h?=
 =?utf-8?B?bUh2YkUrU0N4ZWJZK2R4emR0V2lvSXhoR3ZwV3ZLZHJBN0ozSjd6dz09?=
X-Exchange-RoutingPolicyChecked:
	glnb38NVMHo5K2QrHE/4vCCKJz8+BVk4rhIJzNj50o9AYMvy+9POlAsllY3ikakEn9ckBjIAZpRb4sbY3YzMQ9dh7rFaHRLJbZU51LNt13kB5oW6TF5pUXIxVv5/LH2d3FEYm3mfha3+iZQQePHuCVGPrTdWzIsPCAigUIDhr2EyPxd2Myw40GYYZutciOQiPxn1UK9yczbXWU+x0h9u6AhuyzT+fvlsL6x6+z9cO/cxh2JBqSQ7TgqtFftHEXHSUTzHWrZZl9HcqQ3wDCcAKBHsXnLyUWI9MI6/ySm8X4rmZ5t0COnKg1z06Rzw1QaOXywwDHOQ9qtqfRaXy3Q34A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WAB8mxHs/uqRn/q5Ki5tEQnVoIpKHmEhcYG+ILRD99RzvNbsFsk7iQBsECB6KzSd6LYFHp5Z0FMYrnZK1I3BnFFaaRKTXKOvoVWXaH1vzTfqNL+30HfiuYd9Yn3choWQX+reKw2x1b3rlek8ykTE4FS99aUtM/dkpM4gVOINRDA8ANHBYhPYyz5OjmsRQojPZ/jQsVA3NhLPCM00HkMOQrLulnMb4cxAPnLbmRC8SZA3aWNOR3NXL8C2CenKRIzAoYNAlF41biuO6Po4FVebe43aMsK6HoDs+suoC7YtMScQBTdpYrYCKhBu5K5U2t9xS+Ts8jL8LpDUcBkZzfj6UVM6seJBFZPDdDTCmFu4891HkVnOT7Kx9ztMdiNJxSjDuDo1949GLqZDWEE+lTEH3zknUkI01m3/XtCzdcKD1CI5H2cgOQ/hGXDy1fWFFwKPn2Vf0cuSSKunQPCk9ypfnuUiGdG2/YXnE6ptCuCBhAyN+ARe+D28evlnmjGW7ZrN3Nrw7otdGQMxZtmwj+AnXUZ7rvy5Hm5VxRp1zd/ZNYdClh9KEDVsy8Ztio6ChxfTMrmp+nqzFGK5WZ2y38v5uKbfdto71IGyo6VimRsYTaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c189884a-5374-4767-ff1a-08deb4b58967
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:14:52.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl6erb/sZ1L0VqwsyGgmCGtQk/thaedf2vqVdCpE1eulClOPJbIuKteuH5I2KocJWpAsB6LjgVGKmBDNGPQypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605180078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OCBTYWx0ZWRfX1k1Q7hRZPzAy
 xpgjEO3ckM1Vnj6LGichn3lcpAUZU/tvZdGxfTTKQQSo6fFwWKmxg+sii7rRDJNH0kd3HVP4iWr
 cvHBJvY2wKbYgB3eLEXCNBw1TW5j4n7bi/Lv14fhhtWT39kfJBo4XIg1bNJeg3lRT/DK8FD+Lrs
 M1FsiNmIdHGUVO5jIpzc0E4PueY5PF3DdH6al/etlveJjUyQswPAQqGkshX7VJvOvwVr9T0l605
 yu7PipJRrsJcILVRDMxf1FisJN2oVP3C3FHSD4zUv9N0YhlFQiZAwIcxcuVdcGCkeiW6HNc/gFl
 4bj1VIvTfQul1aaZMmvbegGKsv9kw815ZXIIowVmitSrFGhvryWdt0oB2OLrN054KIoMpD+P8aq
 UXdpHyt5F9oujJjE5qtr1QkmxUK8XmhR3K7TYyCyaYpoFnUrQ3VHsuiwTLa2oO0fSRoGZ6DwBVT
 t0loIFQ2Eyzed3cA5SA==
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0aca85 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=j-LfP5YGAAAA:8
 a=k-43Xf1uipzZ5OjYwnYA:9 a=QEXdDO2ut3YA:10 a=pci6KG57UX3UzFLC8IW4:22
X-Proofpoint-ORIG-GUID: hRrHTd1wi17pBWDT21f4z6G_PkvTjRiQ
X-Proofpoint-GUID: hRrHTd1wi17pBWDT21f4z6G_PkvTjRiQ

On 17/05/2026 22:36, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising
> RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
> latency spikes can occur when fast devices are starved of available
> tags.
> 
> This patch introduces two new debugfs attributes for each block
> hardware queue:
>    - /sys/kernel/debug/block/[device]/hctxN/wait_on_hw_tag
>    - /sys/kernel/debug/block/[device]/hctxN/wait_on_sched_tag

How would these counters be used? You are just saying that we may have 
performance latency spikes and so here are two new counters.

> 
> These files expose atomic counters that increment each time a submitting
> context is forced into an uninterruptible sleep via io_schedule() due to
> the complete exhaustion of physical driver tags or software scheduler
> tags, respectively.
> 
> To ensure negligible performance overhead even in production
> environments where CONFIG_BLK_DEBUG_FS is actively enabled, this
> tracking logic utilises dynamically allocated per-CPU counters. When
> this configuration is disabled, the tracking logic compiles down to a
> safe no-op.

How does one normalise the values which are measured? I mean, during a 
period of high contention, we may get a bunch of threads waiting for a 
driver tag and the value in wait_on_hw_tag may jump considerably - how 
do you normalize this value in wait_on_hw_tag for meaningful analysis?

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>   block/blk-mq-debugfs.c | 109 +++++++++++++++++++++++++++++++++++++++++
>   block/blk-mq-debugfs.h |  19 +++++++
>   block/blk-mq-tag.c     |   4 ++
>   block/blk-mq.c         |   5 ++
>   include/linux/blk-mq.h |  12 +++++
>   5 files changed, 149 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 047ec887456b..a94ffc2eacdf 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -7,6 +7,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/build_bug.h>
>   #include <linux/debugfs.h>
> +#include <linux/percpu.h>
>   
>   #include "blk.h"
>   #include "blk-mq.h"
> @@ -484,6 +485,54 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> +/**
> + * hctx_wait_on_hw_tag_show - display hardware tag starvation count
> + * @data: generic pointer to the associated hardware context (hctx)
> + * @m: seq_file pointer for debugfs output formatting
> + *
> + * Prints the cumulative number of times a submitting context was forced
> + * to block due to the exhaustion of physical hardware driver tags.
> + *
> + * Return: 0 on success.
> + */
> +static int hctx_wait_on_hw_tag_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	unsigned long count = 0;
> +	int cpu;
> +
> +	if (hctx->wait_on_hw_tag) {
> +		for_each_possible_cpu(cpu)
> +			count += *per_cpu_ptr(hctx->wait_on_hw_tag, cpu);
> +	}
> +	seq_printf(m, "%lu\n", count);
> +	return 0;
> +}
> +
> +/**
> + * hctx_wait_on_sched_tag_show - display scheduler tag starvation count
> + * @data: generic pointer to the associated hardware context (hctx)
> + * @m: seq_file pointer for debugfs output formatting
> + *
> + * Prints the cumulative number of times a submitting context was forced
> + * to block due to the exhaustion of software scheduler tags.
> + *
> + * Return: 0 on success.
> + */
> +static int hctx_wait_on_sched_tag_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	unsigned long count = 0;
> +	int cpu;
> +
> +	if (hctx->wait_on_sched_tag) {
> +		for_each_possible_cpu(cpu)
> +			count += *per_cpu_ptr(hctx->wait_on_sched_tag, cpu);
> +	}
> +	seq_printf(m, "%lu\n", count);
> +	return 0;
> +}
> +
>   #define CTX_RQ_SEQ_OPS(name, type)					\
>   static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
>   	__acquires(&ctx->lock)						\
> @@ -599,6 +648,8 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
>   	{"active", 0400, hctx_active_show},
>   	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
>   	{"type", 0400, hctx_type_show},
> +	{"wait_on_hw_tag", 0400, hctx_wait_on_hw_tag_show},
> +	{"wait_on_sched_tag", 0400, hctx_wait_on_sched_tag_show},
>   	{},
>   };
>   
> @@ -815,3 +866,61 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
>   	debugfs_remove_recursive(hctx->sched_debugfs_dir);
>   	hctx->sched_debugfs_dir = NULL;
>   }
> +
> +/**
> + * blk_mq_debugfs_alloc_hctx_stats - Allocate per-cpu starvation statistics
> + * @hctx: hardware context associated with the tag allocation
> + * @gfp: memory allocation flags
> + *
> + * Allocates the per-cpu memory for tracking hardware and scheduler tag
> + * starvation.
> + */
> +void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx, gfp_t gfp)
> +{
> +	if (!hctx->wait_on_hw_tag)
> +		hctx->wait_on_hw_tag = alloc_percpu_gfp(unsigned long,
> +							gfp);
> +	if (!hctx->wait_on_sched_tag)
> +		hctx->wait_on_sched_tag = alloc_percpu_gfp(unsigned long,
> +							   gfp);
> +}
> +
> +/**
> + * blk_mq_debugfs_free_hctx_stats - Free per-cpu starvation statistics
> + * @hctx: hardware context associated with the tag allocation
> + *
> + * Frees the per-cpu memory used for tracking hardware and scheduler tag
> + * starvation. This must only be called during hardware queue teardown when
> + * the queue is safely frozen and no active I/O submissions can race to
> + * increment the statistics.
> + */
> +void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
> +{
> +	free_percpu(hctx->wait_on_hw_tag);
> +	hctx->wait_on_hw_tag = NULL;
> +	free_percpu(hctx->wait_on_sched_tag);
> +	hctx->wait_on_sched_tag = NULL;
> +}
> +
> +/**
> + * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
> + * @hctx: hardware context associated with the tag allocation
> + * @is_sched: true if the starved pool is the software scheduler
> + *
> + * Evaluates the exhausted tag pool and safely increments the appropriate
> + * per-cpu debugfs starvation counter.
> + *
> + * Note: The per-cpu pointers are explicitly checked to prevent a NULL
> + * pointer dereference in the event that the system was under heavy memory
> + * pressure and the initial per-cpu allocation failed.
> + */
> +void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +				  bool is_sched)
> +{
> +	unsigned long __percpu *tags = is_sched ?
> +			READ_ONCE(hctx->wait_on_sched_tag) :
> +			READ_ONCE(hctx->wait_on_hw_tag);
> +
> +	if (likely(tags))
> +		raw_cpu_inc(*tags);
> +}
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 49bb1aaa83dc..7a7c0f376a2b 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -17,6 +17,8 @@ struct blk_mq_debugfs_attr {
>   	const struct seq_operations *seq_ops;
>   };
>   
> +void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +				  bool is_sched);
>   int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
>   int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
>   
> @@ -26,6 +28,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
>   void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
>   void blk_mq_debugfs_register_hctxs(struct request_queue *q);
>   void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
> +void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
> +				     gfp_t gfp);
> +void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx);
>   
>   void blk_mq_debugfs_register_sched(struct request_queue *q);
>   void blk_mq_debugfs_unregister_sched(struct request_queue *q);
> @@ -35,6 +40,11 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>   
>   void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
>   #else
> +static inline void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +						bool is_sched)
> +{
> +}
> +
>   static inline void blk_mq_debugfs_register(struct request_queue *q)
>   {
>   }
> @@ -56,6 +66,15 @@ static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
>   {
>   }
>   
> +static inline void blk_mq_debugfs_alloc_hctx_stats(struct blk_mq_hw_ctx *hctx,
> +						   gfp_t gfp)
> +{
> +}
> +
> +static inline void blk_mq_debugfs_free_hctx_stats(struct blk_mq_hw_ctx *hctx)
> +{
> +}
> +
>   static inline void blk_mq_debugfs_register_sched(struct request_queue *q)
>   {
>   }
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 66138dd043d4..3cc6a97a87a0 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -17,6 +17,7 @@
>   #include "blk.h"
>   #include "blk-mq.h"
>   #include "blk-mq-sched.h"
> +#include "blk-mq-debugfs.h"
>   
>   /*
>    * Recalculate wakeup batch when tag is shared by hctx.
> @@ -191,6 +192,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   		trace_block_rq_tag_wait(data->q, data->hctx,
>   					data->rq_flags & RQF_SCHED_TAGS);
>   
> +		blk_mq_debugfs_inc_wait_tags(data->hctx,
> +					     data->rq_flags & RQF_SCHED_TAGS);
> +
>   		bt_prev = bt;
>   		io_schedule();
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8..cd52bf6f82ce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3991,6 +3991,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>   			blk_free_flush_queue_callback);
>   	hctx->fq = NULL;
>   
> +	blk_mq_debugfs_free_hctx_stats(hctx);
> +
>   	spin_lock(&q->unused_hctx_lock);
>   	list_add(&hctx->hctx_list, &q->unused_hctx_list);
>   	spin_unlock(&q->unused_hctx_lock);
> @@ -4016,6 +4018,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
>   {
>   	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>   
> +	blk_mq_debugfs_alloc_hctx_stats(hctx, gfp);
> +
>   	hctx->fq = blk_alloc_flush_queue(hctx->numa_node, set->cmd_size, gfp);
>   	if (!hctx->fq)
>   		goto fail;
> @@ -4041,6 +4045,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>   	blk_free_flush_queue(hctx->fq);
>   	hctx->fq = NULL;
>    fail:
> +	blk_mq_debugfs_free_hctx_stats(hctx);
>   	return -1;
>   }
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..41d61488d683 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -453,6 +453,18 @@ struct blk_mq_hw_ctx {
>   	struct dentry		*debugfs_dir;
>   	/** @sched_debugfs_dir:	debugfs directory for the scheduler. */
>   	struct dentry		*sched_debugfs_dir;
> +	/**
> +	 * @wait_on_hw_tag: Cumulative per-cpu counter incremented each
> +	 * time a submitting context is forced to block due to physical
> +	 * hardware tag exhaustion.
> +	 */
> +	unsigned long __percpu	*wait_on_hw_tag;
> +	/**
> +	 * @wait_on_sched_tag: Cumulative per-cpu counter incremented each
> +	 * time a submitting context is forced to block due to software
> +	 * scheduler tag exhaustion.
> +	 */
> +	unsigned long __percpu	*wait_on_sched_tag;
>   #endif
>   
>   	/**

