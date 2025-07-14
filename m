Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5623F424
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500925; cv=fail; b=VyZG12D/yr2ffQSnYCj/3ONIPummgsMpat9+XhrqrrUK8djHfJXHPEXfxhX6v6kY01HX3Q9LkuPUdc1an8jRLWvDlExJjBzegGkgwSRzmzl0KVvSsZtqJh9a55xwoAn+JEFgNaVHwWs+mAgyj6fl4IQwxMWLzZiStYFqeEwdRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500925; c=relaxed/simple;
	bh=heIIv9kMiuLRtCoYBB4MG2sBqRjYIlD65j8g/hstdzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MXvumE9adkQtzbLTvBb/uxlDQ2GXxC0WkH8LQzQRDGiBIiv6Qi7LL7u8NajpBCLu58Q51YLI9wBCEl4GqqrCzSUPEvWq7EzYNNNohI2q+CZ8NPJTUyM6cA7jgWS5p/M8wfM9xy921uotqTj/exbAiq5K9ofGLmS0LrP29SVua8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CeCpQSwt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GHMFWbQQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CeCpQSwt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GHMFWbQQ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5cb031167;
	Mon, 14 Jul 2025 13:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=T/qCDMFLdN1LxcGoXyhRLAyD45qoakBC1tC9XeuRBkw=; b=
	CeCpQSwtV/mTsLZckxxLxEIxZucZf5+Q6wqsP8Soc2Q1f8rrjZeh8WrM1F+z4T42
	E2cp0XaI1/xCB4CUsezhk3a4y0bKM1UweE82ajKNccO1poiIHtU48cEYPlWa0eoB
	Yi7gN0SgmbjcsbV09A7DM/Rrt71TD+FcoahqEy8nvU1Y/pOP2q214TnMff41rrum
	NL3ueHhsaOcfO+YWmcfS8BxGd0eBsww/b/qQ1j7vU9TaxlX3taVcmq/FwI+6i5nq
	FHrjw4zBgaxfhnGB5uk5x96ICrUkfStzwuXNqnBO4Wpf7Uz8f3b8R+ML1dGgBZK6
	jDn/P0W6F/oeg+dkfrviXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v523-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EC98cB023713;
	Mon, 14 Jul 2025 13:48:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58jk6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2G+B9tipdKr3piB+OUf4BKb1ilEmdSnFh3FzmQFZIisL8A7xRkFEPZ0uq2oY2yX9XkfVrETSZEVkpX3BzdDEv0ojY9PewnZm/e38Wag0upXTZ6xby+LOuXJ3kDvt+p/aaWA3dUQV9zTD60DJYnMAJj1lAhwZYfzlvO6wyLLpuU1oqT9gVkiZpZWm8zXJTKW1D2pB05VBmq36bYRbZ3VnkesADzC7au3HFUSl3R8giQ6q+3QPei69aJgo5HLbHfaVpMEZot3DFvxyukStzUjAwCSSfUvrN7S1itEbZHW6/KMS/+dCNl3tGT12vd/SnNtp04VwhnMBU69JqnFTOFjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/qCDMFLdN1LxcGoXyhRLAyD45qoakBC1tC9XeuRBkw=;
 b=DiAEiHGiT1SxP5Py4c1tJCjmuziJJhtWzC3YZLkm49ZoVoIq2ajAInFaCHTeUOELEQReNNcuyvBKF3VN/nctJ2irGck6ZWwzaangytDqdiTNJW2jVc5zlLT26FD6S/IOl7OI+D8el7/AmgcnCZr95Pu2CcgSe3eyQOCWR19vFZoYllx0ibMK9jYN6MpfI0n9uwIakCTnsjSmTc5KLzsf0+aY/LqRsxfjfgCcVce9d7FCYQzjrRs3QtFU3bxOvrwTHT2UmD1c1IowC9xm6AWD3WEDwyuZVCmB80EVw370CsDfQEb3eLSBACqrsI4i+PDWcRYSXDsx2I6zkd/bvDrcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/qCDMFLdN1LxcGoXyhRLAyD45qoakBC1tC9XeuRBkw=;
 b=GHMFWbQQeSX7HtgtsSAfnNAYYJjR1Kpbs/79GsREFXBMGlouVpjSQdHBgAF35CfauZx1hwDb2s5WcbLJcDDTnwlSFJ70/PNPtLgOiPfHAt5ZW0KzUGCzjyM7wRL/Rc1rzyhtCBfqwyiVnbyT5j46wRKOyvTXumQ3a28kjRJZ/50=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 14 Jul
 2025 13:48:25 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 13:48:25 +0000
Message-ID: <a276765d-665d-49af-9776-d06e88c766cd@oracle.com>
Date: Mon, 14 Jul 2025 14:48:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: Split
 blk_crypto_fallback_split_bio_if_needed()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250711171853.68596-2-bvanassche@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250711171853.68596-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: af468849-5224-474b-f652-08ddc2dd1b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJvS09WU21DMVFFb0RRbTgzakh0U0RLNFdOVjZ1bnBrenpoM1UxZDRWdkNz?=
 =?utf-8?B?a2E5RlNFY0ZCdUdNcVVXQ3ZWbnlxdW5NNEZxZkpIZnp2eUtXdVp0OExWaktu?=
 =?utf-8?B?eE9ueU1sWThhYXJzTHY5ODRBVHFDYUI3Qm5KaEZ0R2taaEt2YTZCVHkxbUxw?=
 =?utf-8?B?cmhUallsL2RWbGVpZy9sL2hNL0ErQ0ZTMUhHNWZ3RXM0S3FPdm1jeDdxUlRW?=
 =?utf-8?B?U01adGhjT2lsbU94NDM0ZmROL3FhSVh3dWVaNjNySkpiL3NRa1REU2Y5dG93?=
 =?utf-8?B?MTQ4S2Z5VnNlL1JDTmg0T0FSdlVyTS9UNGFuSjBGb0M4TWZkdlBOSlJsdCtB?=
 =?utf-8?B?S280WVlwRFZsa3BsSGFyYUxaNWhhOEk0WXEzUU5tZmVGemhzMW1ZeDhpVVgr?=
 =?utf-8?B?QmZHUlBPZ3VCRkJKaHJKdE9lK3Qxb29rTjlmcjN6RXJZRmlrNFA4bldlTW5M?=
 =?utf-8?B?WlZ3aEd5QWt0WWVCeU9XUElYZlkydHhVNWNmYU9lWFhKMTgwRnA2N3M2bXBu?=
 =?utf-8?B?YnNTaG5aTEpjRzZzYVp5QXg5Wnh0dmprTXNJUVViYUxzcXFlVXlBMlp1eVF3?=
 =?utf-8?B?dk1MTFpBb2p3UWpESWhRMzlWdGdGSTBJR0tGN1dFLzZJZVFJTjk0TDNnMk0z?=
 =?utf-8?B?QmwxSE9wY0VYUktXSmtuckZSYUJPMGdGai8xOGhLQnJLblJKSFRleU15K0Zq?=
 =?utf-8?B?aG0vbVFiMlVBdGZJMFVIWWs4cGN1MFFQNjkyekZOam9td1NrajFHL2NNaTFN?=
 =?utf-8?B?d2o1dG9uSzA0Zkd1LzNkMWMrMlVPbHo2WFlWV0hlMzh6clhJcVpLUEp1Vnlp?=
 =?utf-8?B?NHp5RDhIcVMrUHQ1MUhoYmI5ZG9TZlRrRXJLQlk1WE9ZcU5wV3VTbnJJaldI?=
 =?utf-8?B?ZjZka0NMb2tTSFBvMytRWnREM0l5L3dKMHB1ZCtHSXpsbExHQlFyRVpYS2hU?=
 =?utf-8?B?Wlc3OFpmVlcrRnMzem8wSEZMY2NxbUk2SnRVTlJyNk9LU1g4VitNMS9zTWhW?=
 =?utf-8?B?RDJ4WHY0VG1JUUZQZlg1YXVlWWdUZktDNzV3TGEyeWd6WlNydEVOcElaWlg3?=
 =?utf-8?B?N29BOGMwNGkwV1kvSGIyYVpseG4zWnFLUXpjeldJTm4rMlVWbEgxdG4vU0NN?=
 =?utf-8?B?ck9MV3RZQkdYMjFWL29rN3pjOHFTQldFKzRFSWF4aThoRE5IV3JORU5VcjFu?=
 =?utf-8?B?WkJoMk5zSmtJWjUrQlllUDVia0ZHK0piRE9KV1NDV0hvSGV5ZVBSSFB5K3lP?=
 =?utf-8?B?TFBmZ0Y2d28vSlBzUXpSdHFtQzJyQk9TL3IyZ2l0ZEVZSlpVSGFhcjRrS2Jl?=
 =?utf-8?B?UkFCazlKU0xFWDhJRHNXcWEyWElMbHZ5WGNMRnQwakVnL0xTcHhUaVpmMnI5?=
 =?utf-8?B?RmVRb0kxSWY2aFFsL2NDa0s1WlQxdW5XeDBWZ1JIUXNNTDdXMVJLTmRTMzZD?=
 =?utf-8?B?L3lpM2NZd2R6VXFkNjJGNXZYRnBmaGc4QmpZb1lZVlNLSzNldnZJOExoaENE?=
 =?utf-8?B?MHh0U3FMZldjRUxQV2xiVnRiMk90QWF0a1VZSEc1UTdYVmJFZlpyRWJXM3ZR?=
 =?utf-8?B?b3BKQzFYejVOTVVZZjRZeExHWHB5SVhhc1ZQK2E2M3Y1d3FJT3lEa0xEZUtJ?=
 =?utf-8?B?ZTBhOGcxVmVmWDdnUWYyOWVLQlJ3aFNEbWw3ZGI1NUkzWmxaTFlhNDNHcDdx?=
 =?utf-8?B?UnFwZGdiN3IvbFlGNTNDdDNvTENaZ2w0WGtuTitNb0ZaK3ZXd0swd09mVkwx?=
 =?utf-8?B?RitQanhjSmQzenpWdGZNN1pZWU1ocGhhTXQrY0FGOGVCUFBobXFwWHhoUmJN?=
 =?utf-8?B?VmtuaG9nbkVsUkhYTkRXSU0rZ2lqQVAwSGE3NUJTMzlRekwyc0gySi9kOURX?=
 =?utf-8?B?V1NVaFBXVUY4SWM0TlRxK3dqME1WSEFLSzlPSk5CNzhMWk00eE5uN3Y5bEpy?=
 =?utf-8?Q?wD72oig596k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alVUV1RiSDloTkl2enRXWHY5cU1sS2pqbEhsc09JUWJVMERVZmdnVk1MNm1m?=
 =?utf-8?B?N24yYkFJTHFBYnIxelM1UytlVDZvV1lUbHZHWlR2OXhlazFQMXdPSVdaNDc2?=
 =?utf-8?B?STNXS2VBVkh5U3haNU12Z3JxTEh5Z2ErR0FrUFZBN2dqUXBlWms4YzBrY25Z?=
 =?utf-8?B?SGhTbDdrdWxMaUk1L0JlQk9teDAzQmRWSDFtY0p6RXVKYUR1VlZtbG1tYjd2?=
 =?utf-8?B?czdGbU5zZ3pKT0tHSGwyNFJaR0VRb0tpODkwdUlSYjhKd2dKZGg1cmFJSS9X?=
 =?utf-8?B?angyditwWDVINFhQQjBReWQ0Yyt1SVRFbjJsZk9WYW9VQ1dRTkYvUUI5Tlhm?=
 =?utf-8?B?Qmh2cVc1S1UyOVhmaTIxRWt4OGRqbm53d1FqeGRYNE94YWkzYnJNSlEvc2hJ?=
 =?utf-8?B?Q3FqRFRjMGpqNkdFdGlGbEsxVlp3NlFlTHFMbEp4N0E1VGwyT1JqYWVKQ0lk?=
 =?utf-8?B?dWxOVFA4NTBld3dCZ3A4VGxlUTcvckNHSjBqNENDcGVEU25UZkRiZG9LMDQ4?=
 =?utf-8?B?QXZ0ZkdQaWVFUW83WDBLRm94aTVZSXJQT3JRQTBBUDBTV2Q3OEYwc0dmV3hu?=
 =?utf-8?B?V1lTVWtMY2UrL3ZWU0VnaXZHdVdxWEkxYko4OTFXU2ZabnhPOTNXcnV3L3l6?=
 =?utf-8?B?WExmSENVUGZLaWY0cFU2WnNpUXJIR09Sallhd1hmYlJZYjJHbkdlSEdvVlhu?=
 =?utf-8?B?dTJsTGV3dTZLMlNUc3IzNG1FeXFXMnlyRnQzUERnVVlVNXBJb28rM0NTSHcr?=
 =?utf-8?B?NXdpWEZZQlE5ZWZvN3c2b2wzd29wWi9YeGswSk9JZ2s4NDVVQ2p0bWtSVkpP?=
 =?utf-8?B?TG5wYldXRmYvWld4N1dDNjNkYkpoR3FiTXNsUDNJaGJzc2YvOGNoQ2t1ajlC?=
 =?utf-8?B?bjU3OGRNOXd5dWN1Qk8vSXVFT2RjZ21GU1hsZjgyMDljWTU3VzM0SjJpYzJk?=
 =?utf-8?B?NWpaVHVRRExFRG5xRGZHU2FLZTNUeXFZcmRMbXpCSlVDTWsxWk9VSzJERHdL?=
 =?utf-8?B?d3ljTEhhTHF6VTVJZ2N6UUtFa2diNkI1ejU5anFyeU4zanl3cTdvM05odFRT?=
 =?utf-8?B?SmxseGJySFdEMzkxWUdsdk8wQVJVbmRSZVdhbTVuaGY5blY2RExrd1NkaTF2?=
 =?utf-8?B?ci8zY2V2Q05sam5HQ3B3b3VVVDkwTGVOOWFZZTdKU3llYWI2a0xQaEI5bGJZ?=
 =?utf-8?B?S2prZXlHSWxTbk1ydFlaSGY5SjU0REpEakdFNW1tUGY5TnFkN1RjUEpoWHJD?=
 =?utf-8?B?WThzZ3JnNnl0QUduRUREeWhzdnBQRTBXOXdaMTdTY2lGdGEwQjlkSVF1bmc0?=
 =?utf-8?B?cE9BaXU1WWtHbmw2bHBlMytXN3U0MGpqU0NnblJNWDlaSHVtQzAyNm03YkhT?=
 =?utf-8?B?SXZlMnJRQ0lKdFBvSWszRVg4c3l3cDlTbFllTS95TTRqZnpWdUJUNEFBS1dV?=
 =?utf-8?B?d2RpYTAzZUhySlBsNUpkWGRtWUZtMWVxTVNIVGJnRW9iT0VJaXBRaGhnVWFT?=
 =?utf-8?B?a1ZlTEJTTFZyUlRTalJTakZydTA5UXltL1dNcWpXWDVHM3BNRDdQcklNcHQx?=
 =?utf-8?B?MVpRN0xWMi80SzdnMmpWVlJnc2ozcmxzWlpGNUJLenI2ODBDN1lyaTIxV3dS?=
 =?utf-8?B?OFd0M3ZUOEpieG83L2Z6ejIrYlFGcGFkSU90V2NzQm9wMVRaSlZjTWdMZC82?=
 =?utf-8?B?S29NZElROUxXWFd2WHg4ZWtwaGhhRDJiTUpCSGNuMkNHUXdrQ3RoaVo3K1dQ?=
 =?utf-8?B?UmJEd0x3MEVUZDZCelcrODBQbTI5alJOOE5GRWNkRzFqdVljUWJXUDA0MFlq?=
 =?utf-8?B?TGJNamJnaVY3aWJWeFhqa2VKWVJDaWtSSzJyMGVEc1EwcW42VnFTZThRWGR3?=
 =?utf-8?B?VkNUTUNXTmhnN2Z3RmFjdVpzRHE4ajQxbFNWTTNVcTQwM05USno0YUsrS0Ry?=
 =?utf-8?B?TU5GZkZsdzlRakhLMFBuY29ydlZySTR2RjRKT0MrK3RFTVoxMmwyUWt5SVU4?=
 =?utf-8?B?b3VWM05yYndKbXpjRXZPREYzOGg3dytOTVdOblY2YVhWL2U3ZzdaWWlQL0ZJ?=
 =?utf-8?B?VHFIRERNRHJWR1Y3R29PZVo2YTBFbS9wNFJqL1NtcXk4UGI1cWtVcFJkb3NG?=
 =?utf-8?Q?zZKCfKznx9NmWlGY/MebEA7mg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	42tnmyV0dLOguqz0gM5/K1IpqpaB5tq5FhtMA/qF+uBcE9LJo8NC++FfeB8LEeZXNu1hP7ItWjykLkTKO4QOUCKvZdU/hm4mJo7sBajKQSYygzE6AEpNf/wPhuGOD5Doi44nHvpH+hxynizcoM8xud46rOAf64rudJug5/OKt2CVkZ7ZUZ9PLKolLQSZthrzrpr9Z99daxutYqgTmMHt8V0SKZO4yFCYYuOAgBqlDbyPDSdFaviv7xgiNwFXV+SpPzdZ096iWoBEifhjvdCv8HT7OHqTE8cg+3GUZ0ozocNn26B4xAE1PftmXE5ITujExTJiRCGrdGYbIm7VYY5bg77DAba3jYDRLJ0d4lzmbniUKCTWLlTe7juX3NqZCT9kvUXSFaeBUcF9tgqVUcP5pytanU9++bpNkxmMZdw/PurZq6FvZGxG3Yc+FDXw3n2HbY+JSSD3cce1sAXaigycFsmNuY8qqcHBv/yyv7IFcZ98BXL91YvpIy3o56jTe1fDYXxOZKFzgVoyCc6EG9lWdEcDtIJOx3wBRwXNKg7NNxQ4zf1Sgvb/5GGx6r3gJ4HFfQLOIcjBmMS8Q3trGD5u92sQsE8fj8aBPNkMpy9oEpY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af468849-5224-474b-f652-08ddc2dd1b24
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:48:25.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GetLlEpWVtWX2xwEvykdbKloD4+E/cCgWMSUmMM5RAACbExTXZJCv1Tko3yXoSp/iyhhhy7CarwcOYw/cha5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140081
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68750aad b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=N54-gffFAAAA:8 a=lWKN8xh2ob1Qq7DOXWYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2qikttaFAzaAqPzq7Tr_OJHyeKik-_LU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MSBTYWx0ZWRfX7fOFUv5NmdC1 WrnVlI7FoQgp1UF5H8jFiW5EkhviTlc4rCAGdppyo9vzBBPfzpozYfwU6ronpWYjHUFlZl/Xo5c NvXpIJ7tRN7ttaRSt38Wsb66ThcxEm1W3wWlxK7Mgk5yJa8Gf0R7+0q9c/7AkJd9q+WKBVcC9pa
 JDqqJTqIbhqiqiKy05Ho2tJri7RaM0P4XLdrJCDsj5YVEXhVMS3WCwYP8Kc0gsjxbLL2A3bBXxT 4ouC3zA3LjqwROh5h/lbp0gQfbRXBdMYS6R/dx9qw3R1ZqbjPx/UMr4U1P4fLSd+U8LmixQlnfw a7PqKfGEatkmpbyaw9DjIYduQQMa3T7/Y19azVa9aA82iHQE2cOu+k/LlQkiV2/D4d6KqrcxFQ2
 2bsDHAtUVb3fcQv8DkBz4bKtHoBLdJOvWGAv4yFvA/KeHnu8d6lhEtCYR/U7IW4II+P32WOj
X-Proofpoint-GUID: 2qikttaFAzaAqPzq7Tr_OJHyeKik-_LU

On 11/07/2025 18:18, Bart Van Assche wrote:
> Prepare for calling blk_crypto_max_io_size() from the bio splitting code.
> No functionality has been changed.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-crypto-fallback.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 005c9157ffb3..0f127230215b 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -209,9 +209,13 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
>   	return true;
>   }
>   
> -static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
> +/*
> + * The encryption fallback code allocates bounce pages individually. This limits
> + * the bio size supported by the encryption fallback code. This function
> + * calculates the upper limit for the bio size.
> + */
> +static unsigned int blk_crypto_max_io_size(struct bio *bio)
>   {
> -	struct bio *bio = *bio_ptr;
>   	unsigned int i = 0;
>   	unsigned int num_sectors = 0;
>   	struct bio_vec bv;
> @@ -222,6 +226,16 @@ static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
>   		if (++i == BIO_MAX_VECS)
>   			break;
>   	}

since you are touching this code:

	bio_for_each_segment(bv, bio, iter) {
		num_sectors += bv.bv_len >> SECTOR_SHIFT;
		if (++i == BIO_MAX_VECS)
			break;
	}

if efficiency is a concern, then it seems better to keep the running 
total in bytes and then >> SECTOR_SHIFT


> +
> +	return num_sectors;
> +}
> +
> +static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	unsigned int num_sectors;
> +
> +	num_sectors = blk_crypto_max_io_size(bio);
>   	if (num_sectors < bio_sectors(bio)) {
>   		struct bio *split_bio;
>   
> 

