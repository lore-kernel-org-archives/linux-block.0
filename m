Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012062.outbound.protection.outlook.com [52.103.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04B2F12BF
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765594756; cv=fail; b=ZF/o/9n8NpZoCR8i6m4TOLD8mDr299VZXEPRKq0mu2F9+E2R4SUNUV3MPevNWtpIQcePTEJiCbnrnCI9IxhP4pwP9hf9Sb/K+CW28QAqK8Os7dDUp6Vmsgjbz3w9imiNGHHCEUeuQCMqBV2w8SlYmcqkGPtbZpGiWDZU8hfPKAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765594756; c=relaxed/simple;
	bh=tK5EBjiwYwHicRub/xf4TzP0Wxlg36lEVoau1/qAIG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mo8zTqNcsj/qvZvONuB4wbUio1SWuJMJ4HcaKq6uyACSpaXZbsBG7SdWmmx6dYtoLUrdhE8SSkuvQX63b394Xfh4MqSBwbBxRfWNe+Cj6ll/FgyRBD844gt51G+7Dc16WAIp1SBj7KOrlNuc0sEpbvPaM9r0BhnYD4LuNXebh1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TAiSr+Z5; arc=fail smtp.client-ip=52.103.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TAiSr+Z5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKeLVk0+3AicZa5yuA1e/90Jec8M7+yWzRSFOXrF5DeoxMlgWxJUAH4uuOW+tYvpcS5ckvQm3JYxvPqvX8lVBtjikiMnBrznki1kXxTdjw/8I2KdRlEWvjUL3dF4NwzNpC7Py6/wcwsnC+btUNEfSgDo6cfhbD0aq4Ggt1DfY3/RajohxoIWlgHUF6E/Vd6Is+KGARL0qRQMH8C7qxBL3Ec9kZwTN2pfgAvq7hvst+5nsk5TEAN/P0dpvX+B7bHCV3H5V5Rcu+L/aTEjdiDijHIJ9KVczubBLlFAjmVnGy/Kyr5gxYO0yxz+kGItzY++xHZ817O5ddJlf7brHimPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98mgsEU4e9MlcOtIpB9iD+jarVzCChtyp6jeYaVfAes=;
 b=NVD7S+cc27CXrnVdAFfAV4WaYk+tKHT650u/qxgfRJJ+LOD+IrzYu1v5qqpoH2smjOmGCj+9q3S/TJjKLwMs+rgdkYqtzIkt8IE2lCJIm8472lAAnzsJ7jIuWAlhkya6TI69QVUqoVjpjn5oZczwYMd0TsWJ+RFWWvP2U2DuPoKE8tHXvdc+thTbRHVL27MBcM/4cazQAHgJjq6xgLnGCPR4E41j6nywKmSjjGe3WqzJx+cofiCWddV5oB5iEkaHqbf6sTDSX+chog6VskdfOPWkmqH8bECQhpN1ZDiDChs9JzpHrX9uJ4Zo1w5rRxBAZaBIPdWs5aTKJM6f6eunDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98mgsEU4e9MlcOtIpB9iD+jarVzCChtyp6jeYaVfAes=;
 b=TAiSr+Z5ftdokFmDRmOB0FFaeeU21XN8u8x/QA0FQGDO7K8+UHHyIPo1hBRZR83ej4ycl3pvsyGBoQ9byZqDx7ziHr+L7bOF1drKnB4cK9c9obc/OqJaYabvVZw16XJ7cin5p8575Zheofp4ChTW4hzC+hTtugX3QowLhgfcYPGRt7vqZe6n8pQO6JJqY7lzRDJ9Ynmp8Sybotq5sXlRxbIaZV+f1Dy0el1cbU4aa1r9JIBDlPF3Jxo65Yx4Edpi+eLe11xKNqLatuY6pXmtxXQ8d1l4U0ndJ4ZRhyEf3v3yj/wWVZ3BSDthzZkvyaCwly2MQS6IzmTZzOzbsYxGDw==
Received: from JH0PR02MB8688.apcprd02.prod.outlook.com (2603:1096:990:b5::12)
 by SEZPR02MB5862.apcprd02.prod.outlook.com (2603:1096:101:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Sat, 13 Dec
 2025 02:59:10 +0000
Received: from JH0PR02MB8688.apcprd02.prod.outlook.com
 ([fe80::3bbe:ddc2:9b12:c96f]) by JH0PR02MB8688.apcprd02.prod.outlook.com
 ([fe80::3bbe:ddc2:9b12:c96f%6]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 02:59:10 +0000
Message-ID:
 <JH0PR02MB86885D86B2A34028A160A0F099AFA@JH0PR02MB8688.apcprd02.prod.outlook.com>
Date: Sat, 13 Dec 2025 10:59:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] zloop: protect state check with zloop_ctl_mutex
 locked in zloop_queue_rq
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 yangyongpeng.storage@gmail.com
References: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
 <77d57ec3-134f-4667-b260-f8f5ca593339@kernel.dk>
From: Yongpeng Yang <yangyongpeng.storage@outlook.com>
In-Reply-To: <77d57ec3-134f-4667-b260-f8f5ca593339@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0120.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::13) To JH0PR02MB8688.apcprd02.prod.outlook.com
 (2603:1096:990:b5::12)
X-Microsoft-Original-Message-ID:
 <7093f74c-a199-44f9-a83d-65f5391b7d92@outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR02MB8688:EE_|SEZPR02MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4667da-7a4d-45ff-28cf-08de39f3953b
X-MS-Exchange-SLBlob-MailProps:
	7qh87CJt6y2KqegnoS4V+KljWAyhwvUzE8biIaGOxp59rioKTBJF0RSnxjj7yOiMOI3qSpzk3LdgaJJq1N5wkhrMZBEVnsG7ItqN9SZqT6POjrB8Y28+nsFaZEeuI4JfTvN6PnU/jXIbylY2dJwq/YU1DuGauEiYNAeOXLnVJmiIgvv4ipVQ6D9ndNdkoLr1ZkEJMK79Gvgnf68e8ftJQLnrBl8S+Hqcs66NHzih/cYlUxkzkOB9qVOC/SCCfwAaAOBllT/CjqQxk+24oyzcLpPG+5e0e4ic1SwX0VE5Q2Ck7ZJU+1FQw8EpofF/s171at58DSVZ2uLArKfoO+DebANSqba5tBaPUuv5bNR4gSApV9qlbuyFvGDbJ8E9m1mfNav/EReg8abwx2g+afAvY9Ieo2AciRLLlZ3EnOW2Ajygt36KGEasmE8x22OwxEXjqQdewL7FEnOjyyTcQ6vt6hIph7M7qQjWVZQF0h3zXOgFU4jUV/XSAfH+9jNo/eR9VLX1KKj/qOJkWKkvY+NuqiqtEXPAm42FTuNu8t+f65NSaLrXNObfHL3Uwxk/59zPaKSnpTOOpCNfRyJOyuSvoAjOOSrodCoayDsFeFZPeHl0JxD3TWPBdx+BU/aByFhlMUM4A6yZBLons50BtGBQ9L/6FdlwrzG9N8jN7jROT7NXVpG2I7YBWl9K+dyLiUM/IT2PN1xZnqap3fVgckUDAagFGyNiOdQe0bsXJP+TbrvzMjUMrSv+iOT2LhZXeDA5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|19110799012|15080799012|23021999003|8060799015|9112599006|6090799003|461199028|5072599009|52005399003|40105399003|3412199025|440099028|3430499032|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUV2ODQ1WmUrdWo0cXJpYURNVE96NHd2TFVScmxhc2tZeEdxQkxOcUFHVVpw?=
 =?utf-8?B?QTRNU1NUbUhGZDBIa2xxVGt2RHE3UlF6NzBXMzFIUm1lSUZWazQxUmZlYWxs?=
 =?utf-8?B?ZmhLZjI5OVdZb3FKSXZXWUI4NUxEQXZ1M1ZxQjIxQlNoc0N1UVhreU5FRUx1?=
 =?utf-8?B?d29HNzhTVVJnaERNK0ExMGYvY2JkY0pLRzN0cDh0cXM4VHlXbkRmMnZ2WW9C?=
 =?utf-8?B?SnlGVFphN2hjUGt0Y2NGRHRGeHVyWW9CRThKUzNwYm11Si9uVWh5akhlLzF4?=
 =?utf-8?B?YXJGdzJLbXVzOE56Q2NGa0swUitsUVFSeXpuNHBJQ0xtODBDS3VBbllrMkJu?=
 =?utf-8?B?SmYrdFVkM2hxcEVocFJGZEF0R3p3c054MEdwdmh5aGdZTTdFUkVYcGlBTzdX?=
 =?utf-8?B?ZkpoV3k3N1pPcGU3Z0RZSEJ1OGJYaURBbGd5cldwYjNmZGFRN0dRZFRlYzNz?=
 =?utf-8?B?N2tVWXRhb3doSXpVRkdsOGhUM0FBMXc3YVAyZkt6ak0vSWJCOXZtcnhIUWJ1?=
 =?utf-8?B?Y1JaZlFmVTFKV2FoRjB6M3F2elFlanZKSkRUc0gvYUhHaHJ5MkdXZDREb3Jk?=
 =?utf-8?B?RndhZExuMHc0OUt3a1E0YUlERDg3cUhIMVVlSDlzMFR3WlJDbGIwVE9pek8v?=
 =?utf-8?B?OXFCSUh5bGw4bS83WFVKWjJ5QXBqTGQydFMwOXVtZEh3TGdzbE1XRHVxMlUz?=
 =?utf-8?B?NXNpa0Fwbysrb0NHUUd3QUJ5VjE4WWFNTWp4VEk2OHU3V0xOWVB6NXA0YTJU?=
 =?utf-8?B?VWN5T2RGTlBhdzhRRSt2T2wvVEkrUk5hbXhndXFTaGJkZ1RYa3JzSW5SeTR6?=
 =?utf-8?B?c1pxdHQ2dENDWWpGZ3dkSEZaYjJUaEFueWc2T0lHM09weTJmOVhaUWVBS2dW?=
 =?utf-8?B?czlzSDBmS0VYcFpoWCs4ZnBlUjcxb2tHTGtVTnNQMHB2d1R6U2MwUUFqRzRT?=
 =?utf-8?B?NDBWRjh4eHNDR3hOcTVoVUVnZmFVU0NkNldKQVI1ZXZJM3IyNWY5RlhIbVRV?=
 =?utf-8?B?b1FvVEdXUVMzWWp2SHk3dG5hcHJZenZvNjZuSTlGa0VkVFF0TWhDQzMzNTFX?=
 =?utf-8?B?SkM5TjdQRGUwSG0ra3RLWlZYSFJ1RTg0TUVpcW5LSFNGZWpTVDBVYVFGVk1H?=
 =?utf-8?B?eXVuc1VMUUJQS21INXhlRXFmWlVwcDZwMmE3TDcwYnRRbmpXVkJvMG5tQ0JK?=
 =?utf-8?B?dUp2aStDR29nQjJDK3J6WWM1cWxYYkRrd1oxR0VRY2kySFkycDhPNEhEVlc5?=
 =?utf-8?B?aEI2S1NLbWlJREE4SVZERjMwMjlJdEl4MWd1N2ZhVnhpUUhNSytHQ0Y4WGIr?=
 =?utf-8?B?TUhvMi9CN0JZU0N6TVFkNGxETmtTUnFxTndrcnVvZUpZVmo0eFgzL1dvRzBv?=
 =?utf-8?B?enF5YWluNkEzU083WWYvWlVOb3hMazU4WWd4Q1VBRDExemdkTmVIMTFENWI1?=
 =?utf-8?B?MmdnQ1NSVlhGMkhTQzlvTy9oMkRab0hHSUVuVlY3L0pUeGpoNm02OGtPSGdW?=
 =?utf-8?B?azJKS2tpQ0k2OGV5SXdPUFJsWkVHckxSUTZlSDdXb0kvbko2OWpQSXdSWXpn?=
 =?utf-8?B?MGFELytMeFZXWHdKT3EydC9Ea2NyamJjMDdPcTRMcEZRNmhaQTVmcUJDdmQ3?=
 =?utf-8?B?SHhJS3JRNG1MVFJyQzhVd2xGZFVsWFYrcXpGZGMxcnBFWTlGaTJ5dSt1MzVN?=
 =?utf-8?B?cktnQVcyZEVEZndXWCtKenZObXArZ0g0Y1ZPeFl6VW04OHliaUU1eDY2WGNY?=
 =?utf-8?Q?Mn9NRqtJ1gQKnEy01I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnpPWW9leDFmejNGaU5XMUIvSkRPbFh0OUtWclVBVGRHYVNZbmhrVFJlb1pa?=
 =?utf-8?B?enVldzkxc0FFNHhYanlLWGRwZ3hDNFUyRjFRYmpzeTZKQ09RUzdtWktSSkt6?=
 =?utf-8?B?bzNmb2VFMFE5UnNrc3NTMUxmaUJaR3hLS2w1NVVKY0RKUVorbUdmU1cwL0lQ?=
 =?utf-8?B?Q1dWYlJFWGtxYWtDTG95d3cwWUJyTmtFWjBJeWdxTUJXOWFnNFdCTktLaVlT?=
 =?utf-8?B?aFVtYldINjcvc29ES1dERGlvMnQyVkhsR1l1OGlzUUl2cnRFY2ZsWCtiaFdi?=
 =?utf-8?B?L1dTdW45WVZjZG03RHF4R2hTdjZpcE5xd0o4QWoyZDJlZ3cxM1JEZ0NhNFhw?=
 =?utf-8?B?NXp0dlUvMHVhZy8zcVVlQ05FMkZvRDBUY21oRjFXRlE3eFpsZVVRQ3RQVkcr?=
 =?utf-8?B?S0NmbkprNW1QaU9oWjBrZEtJbVg4VXZES3ZpbFVlTkFVRml3aC9KWW5ONERr?=
 =?utf-8?B?cHdZUFVRdUpZdzRYZEJlQnVKV3EzMGtqRGR0cFdod1dSSENxMFg0SnMxdU14?=
 =?utf-8?B?eTZURTdyd1NONkN0bDBwejhmNkpuNitwM3lMWEJYZHhwQ1Y1aktIbXczeWs0?=
 =?utf-8?B?VWRiSTR2NXlIeUJ4TmgraWJETnJTbnV3NDJSWkg1QTFsZ1RvcWx6M1g3SkVt?=
 =?utf-8?B?dnprSXQyVGZSL0h1akIweWZXQWVRZU0xMXpDT09TWUZkR0RNVVJXWUlQMG9J?=
 =?utf-8?B?RFdDTUsyZlpvbStKSUJWRmJNRVcyOXducm0vNGxkanBhRUlIV3BCdWxYa1l2?=
 =?utf-8?B?SlBDVmIxeDlkRTZZSnQzamxhSkNXUWJhMWMraHJkOWNvUit1R2hqanhUY3ND?=
 =?utf-8?B?NmJtclI4L2NWZ2V4RXl4RVNhTEdrU2daWGdYbFc2MU1OQytvY3dBN1d3UVVH?=
 =?utf-8?B?d1hrakZNOUxNRUtFZzlSU0VWVzZueGY4M0Y0S1RxVndCSlU3UUx5WVNMNElI?=
 =?utf-8?B?L3VVbWVLTGFYNjFGWXhBMS8yV2pIM0szUU51TTdsUTlPTENndXdEU1ZXRHZ2?=
 =?utf-8?B?TVp4TEVXdGU0cU5yZnZ1Z3pjQWhJOEZKQW1RTWgwWWt1M2EzZVQ3QzVDOXh3?=
 =?utf-8?B?VGxVNEVRcnV5V2xuTjJ0TmNVeXdKNWI1M2lNc1BUYmMvMUNtRkpBTWkxTk00?=
 =?utf-8?B?blhVOUxSZm9OQjk5dVo0WVJzT2VDalA0SUp5UWk2aEl5RElIKzJFajN4dUR3?=
 =?utf-8?B?VTBmNmhmeTFtVHBBYnpvT2R3enpTcWRCUU14d2xMZDFMOFhCN2p3ankwSDdl?=
 =?utf-8?B?YVFGOTBPa2NKNGQ3enJSemthWEk2NmNxdHdIUSsvenhDUkFTWmR3M20yS3VM?=
 =?utf-8?B?dWh3NVJsbTJ3S3lMeE9lTVgxdHNuOCtHOTBCM3ltOXVYdlI1ZTMvRll0aXV2?=
 =?utf-8?B?Ynp0Z0lmbTgzS2NqRmZtZnpYZlZVWVREYVlla1E1ODZxaFlSTkoyYmZUa1hP?=
 =?utf-8?B?MlpOWU9HVG8wYlNRMENjQmNpTFlOQjRNK3pkU3M3djhxLzdqNU9nOHJ5VDhY?=
 =?utf-8?B?S0ZVMkp3MmVGNjlLVHVJWWtKb29FUGN5dzJoYlF5UDRsNlFEMVJuV2wwazVB?=
 =?utf-8?B?SHJJM0dDek5ZcEZoOE5yTFp2ak0xQmNRMmZIakVYbUdoVERLNTNXSkRHVjdt?=
 =?utf-8?B?Z3dNYkRwRGI3eDd4NmlWdDJLK1lJdFlTQmFIMmdTbXpSWmZRMFduUElqMmtz?=
 =?utf-8?B?QW5mVFZqTWhCUGFBVWVDTCtsKytidU5lamQ5UlZFK2tWTW9KWVlxUFM3ajRi?=
 =?utf-8?B?V0twbEd4NlA4SnNhb2JnR1hyMU1Ba2FWeXRMUjl6UUptTUFoT0E0S0NWanor?=
 =?utf-8?B?RFFWY3V1K0VORDM1M2VBdz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4667da-7a4d-45ff-28cf-08de39f3953b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR02MB8688.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 02:59:07.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5862

On 12/13/25 3:52 AM, Jens Axboe wrote:
> On 12/12/25 7:46 AM, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> zlo->state is not an atomic variable, so checking
>> 'zlo->state == Zlo_deleting' must be done under zloop_ctl_mutex.
>>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>   drivers/block/zloop.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
>> index 77bd6081b244..0f29e419d8e9 100644
>> --- a/drivers/block/zloop.c
>> +++ b/drivers/block/zloop.c
>> @@ -697,9 +697,12 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>>   	struct zloop_device *zlo = rq->q->queuedata;
>>   
>> -	if (zlo->state == Zlo_deleting)
>> +	mutex_lock(&zloop_ctl_mutex);
>> +	if (zlo->state == Zlo_deleting) {
>> +		mutex_unlock(&zloop_ctl_mutex);
>>   		return BLK_STS_IOERR;
>> -
>> +	}
>> +	mutex_unlock(&zloop_ctl_mutex);
> 
> Probably a better idea to make the state checking atomic, and avoid the
> mutex in the queue_rq path.
> 

It is more reasonable, I'll fix this in v2.

Thanks
Yongpeng,
