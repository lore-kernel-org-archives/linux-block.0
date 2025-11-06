Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701D18EAB
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401108; cv=fail; b=jnKsW3BUhGjrQDoPrFvh6QAgY2fAzBHOL4CuVzu2aacOpvImQNL0R8yE4H+mzMDm4F3TIRh+O9efioEFJHCXSC+EKwzfKHNu/RRwt5Js5T+4eJy6uVo+nXpdbcUiwu4oZm/QO4PGEr/y2095guO6Rg2uEASFHnOaKkYpSWyBrfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401108; c=relaxed/simple;
	bh=HtHdAvyDyE0cjYiZ6wWtyltDi3pyPhm3oBFNd5gRguc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vj+dziNd8o15E1jKz3Cdq318xF4jrgWuYFMUMDVhRZZLedfvtNXOcm55rtgPzgAB4dWa9Oo7sKUQXCDHifVv1qO2hYv9TNoBK8eVdXA3OwIGR4aoNqQ+t9/+p3MZvJyFhHscohLrGPGEvOzCi9wnvYN/d9RrvwmXUkh6mocFvCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHVYd8nB; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHVYd8nB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjZn8Vf4MbgGaWxsNqhvZ1MyFcbDTYbjq4PyleTKixAUR0G5vcD0D4LkISveUnN+DJU5kDZ5fCeMs3aWbgmyV9WmeM9n8/vcRBm2YtWOjnFreGWlA9bKu7Fd5bpTtLXvCVN0KJacaXw96zQc+WRnTvOzBYyJcXgKkCPglHkV9Xb6P333UwrhnywH7lzJ/vCsS2atHxDeklAskB33SLmCtLpBRAgTRFMmUQYvtT9fede4LKUCp2MmpvYRUnYsXEoiZP1VWkioCIbFEE4wwnqx8jOL6I53T8REd4FQAvmbztAAuSklcgS6431HMo7GR4myisSCWNqRJFSGCKK+B/HJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtHdAvyDyE0cjYiZ6wWtyltDi3pyPhm3oBFNd5gRguc=;
 b=gzztVjF1IrgrpTGp2l0gDtGprUFGC1qDnnz3PoGdY+LmGgFHFd2MLLCzHZqGwhW+FcgFErzRM1LG0JEp3jUGGf6kOgO0258EH+30yGe9OWiHE7NzoDqkU0Fk7XAVyNtObeqevJZzpch/PBOclFJrlM1MVQdYypuIJud0PJTCIl7L3c1OjG+M2vO/PSa6CrlhYDhdaKZNud1k5lV+yyjeLJ7Ero2PheShbOSvnW4cQd99sk9UwRifelsrKdYLEKvHxsHvaUoa1EtJr4J7mf+RvMYOTpyJd0i5otVegi+mtfrtYUE51NiJxehGrDvf7B2v0tH/rAEEx/SdBt9mDPVOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtHdAvyDyE0cjYiZ6wWtyltDi3pyPhm3oBFNd5gRguc=;
 b=pHVYd8nBwL7vCrG3pp+3sWu3r+pQekItpsRuVYi4dZpyH4nBllH1nE7l3aP1UmGs2FAhATnLXmalraWdi22u8JuwMCCTqe10ggH6PPni0InPaazkaxM46i/YCQjEwNrKx6EThwq68qxv75Epv03yq9ITpIny47NFaPKzcfRYhmv7WPZDfI/42wTk47MTPS+hOtHZ0dEoN7I+YiLtqvlMlO2YzsVCcRRYrbTmIohKiQ9dNU+VHDyQWL2VNL7SxBSG86WcDJYsx8mvFW3YDP6AlTQjhGf9/es2QeuRW6+WLumjdNQDc1niB3U7bFXL8NUuoDtwFTbyXxSmyrlJJY76eA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 03:51:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 03:51:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"hans.holmberg@wdc.com" <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Thread-Topic: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Thread-Index: AQHcTsBqRBV+C8F2HEeg7uo+/WDh1rTlA9GA
Date: Thu, 6 Nov 2025 03:51:41 +0000
Message-ID: <9e8e3439-6ade-472f-ab07-0442dc97f843@nvidia.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-2-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 86a91904-55df-4502-01fe-08de1ce7cc0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHRqaXVZZ29hL2hhUjR3aDR0SmtEQUJudXdPb2ZOWko4YkdUaXR4ZmwvUVFx?=
 =?utf-8?B?aklHK21VeUlPeWJ0bHE1aElFZUlHVGRxTkphb1lqc0V2YkVtUEUvNjdRM3h0?=
 =?utf-8?B?Nnl5VWJES3FHMmVnQ3cxcCtUa3hNaGxvNTY2bmJ6Y3hXRTh4THF4VnRhQXNl?=
 =?utf-8?B?OFdISUZONU5rcTlHMDRrN21sRDNDQzJRRk5wSm1TOHZIRVhOWTZ1aWN1MXhP?=
 =?utf-8?B?RzY3andwYkRYUExMRWpFNDZ3TFZ6bGdrVC9mQkY0Q29DeXN2emxMa2YvZ0V6?=
 =?utf-8?B?M213SU5lZTVZWVNENFM3c3NBSUxGcEplckdQVDU3ekxqZTJ3eTc2T0hnUStB?=
 =?utf-8?B?d3lacVFxejNvQjBNQTl2cUc3MHg5SGpnYWFURTRIbk9VcXlkcCtKNEVxdXNm?=
 =?utf-8?B?ZWFKeFFEMmh3Y2g3WWFaR1FsUkp0VEp0TlZuTlBiTk55ZTdKbnFSY1U5L1hp?=
 =?utf-8?B?aVZld09uYTM2c2lBRXhHeEdBZXJQVkhScStyQVVqMXNCRXVmUFlWNGNDS3FF?=
 =?utf-8?B?MXVRZWVaUmsyajBzNERrSWRIWWV1VHFuaUdGZndKQi9xSkdxL2xkUmJ6K05j?=
 =?utf-8?B?NHRpc0p6a3FPTjNLMWdpcXlzU0djNWhoT0hXclBaeUdNS1FuMVZDcjViK3lQ?=
 =?utf-8?B?dlZDRjY4cXhYWWtURDg4NGU1d09zaEpTakQ3WUl3dDdNZ09YOWRKVmVwV3p2?=
 =?utf-8?B?R1JHdkx1aHAzVUI5TmNUbVkvWERTenM0eUtVc1pDa1lEbFVrcHl6bFZzcVlJ?=
 =?utf-8?B?KzdJTUlCZHppUFFTek1xUEFrTUVFKzJXOXBidkxTalBsSUdBcWJSbjEyTzJz?=
 =?utf-8?B?WXp1Sk9QTG8zNW5xWjRkMkhvT2lEdk95Si9wV3BNN3k2dWVKSGl2MTYydmw2?=
 =?utf-8?B?c1hINjVnZ2VpMmFPTGpKclZlM0RPSzJINUQwTTdNandKYk4zclpoOXZuNGNt?=
 =?utf-8?B?ellBWE5zRHNHTllVZGZtVjRQaDBoMXFaeUdiajI1UVVESDAvbmE3SE1FNU9j?=
 =?utf-8?B?M2NWV0g4cjNJeFRUM3NmQUlRdVJBZjVFWUtvcWhQVERxWkczazVaTlN2UWhI?=
 =?utf-8?B?dnRrb1BmTWJiZ1dMSEQwRkxhR29JV3VLREFKNms5Yi9qMkZRTzlqak5QQWtI?=
 =?utf-8?B?bUVLejNITktWYVdKc2dkYngvdEdncnBkTDdMT0xSMndDTFBsM254bkRYU2JE?=
 =?utf-8?B?ZFkwZGw3VE0wTi96T0d2alJyMGZHTGlhWGxyNXBEVFp6czdPUW5RdGE2Qksv?=
 =?utf-8?B?c0Zodk1kU00yZEN0VnRibUJGbE9lN0ZEZUIweUdkU2g0TnhyMnNaRzRoZkRN?=
 =?utf-8?B?WkFYK1FYelFrVHovb0ZMZDRzU1FOdktkSGw5bUI4aEpZYjl3MkJnNStCZVpK?=
 =?utf-8?B?VytzM2J6QW9KbFVRQmVRQmRoOFdrT1J3aTYvZzFQRk42Y3BSZVI5aUxteHZE?=
 =?utf-8?B?UWZkNTZyT0lHQWVYd2REbXFFU1pxTmkreVVGOHNOL2k3YUFZbVh5SDVTQjcx?=
 =?utf-8?B?R2hjTFJVanlrMHRaSjhTYmVNNWxOSzlaQUhETUdyTktoZDJqazlVSTgva0dy?=
 =?utf-8?B?U1BlTGNjSlBSR1dKNXBMZWFFUE8yVGJwOG4wUExTd2NESm5JM1daTHJMZTR2?=
 =?utf-8?B?ZmpaSGJ4Ulg0aGgvQzRmNW5FekU4a2tzN2hzbkFDTGNVY3BBZ0FBdTZpbFdt?=
 =?utf-8?B?VG9RTVRIYW9KV1RtUENJZnh0Mm92V2xYTGNkVU90bWNRU1NMVEpyZlhMSkxa?=
 =?utf-8?B?K3R1Q0c4bGx1M3FSZUN2eFlVSHRXUVJpQkdpekNJd3pEZ3k4aDlUdmFDajlz?=
 =?utf-8?B?N0V4S3RpbkcvNjNVcUVINWllUFhUcHJaSjZWNUNWcE82NGRKKzVhWW9OVVhv?=
 =?utf-8?B?d0N4L1RUNEliaUFYZkE4Y0t3RU9Pb2dWOTNrcXQ1bHpBL0hZeUxmSVZWVnlF?=
 =?utf-8?B?SjFVZ3pKMk1TVElSck5DZWlYbUJ3L0dFWHpOV3lEOUhVYjlvZDdBdnAzcU1a?=
 =?utf-8?B?ODI4QXZlQzJLZHI2MEtqcVdDMEhNdHRBTk9Hc1BTUk1ML3I5MHNJNWcxQ1Rx?=
 =?utf-8?Q?+9xEPs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTRlRDJvVmhWck9uSUVMRmtwYlF5djNXM1poek84RjExVEpzZXdYN043WUxv?=
 =?utf-8?B?eDRUcFRPNkVSSE0xZGd2L1pEOGdYOWhMVkRtQ2J2a1lHZ2cvc0hYdVJQOW9x?=
 =?utf-8?B?Mi9sUG9jWkJwWUtDdXVSVlhRd0FTb3VBZzgrVXhDaHdrOVJJdjViM0ZETkpi?=
 =?utf-8?B?eFJTL2w3YlZrT0FiTUhpRVRNMUNvMVc1R0dja1g4WG1ZNWM0RlcwbGw0NFpz?=
 =?utf-8?B?Nms5UDFUdjRqNy83LzhMSHdHS2lTU3pwOE9ibW0yU0lXNzdvV2FNM2FZYnNr?=
 =?utf-8?B?ZmRSVTY1czFvdnM1ckdrRWFZSmxPRWFnd0hmeURGSTNHU1g4RmVaRjRadHlq?=
 =?utf-8?B?bjBnR2hSdk9reXRJNm8wWHJEWXVLM0pkM3o3VVJXTEg4Q0hTMXZVOElmZUZw?=
 =?utf-8?B?MmxBR0FoOFVrQk5Ja3lyQWRoMFhWWmY5bnRXYUZSY01EZSthZ1RiNmNzY1BD?=
 =?utf-8?B?djBwMEoybGxyamhWU3QxUS9VR2NuT1lxK29wWjZ3d28xamdQRlhMTXZsN1ZN?=
 =?utf-8?B?U0RqWkJsOFRlUjJGNXVESFpGemVRdEtaTFd4bnpTMnc3ckphTDJvWktTUXdR?=
 =?utf-8?B?dlJsaTc5T3piWG5lSFhUZVRFZXRWNEQ2UHhUM3czWXgwVndQT0lkemQ5MHNq?=
 =?utf-8?B?a2ZJcE1CWUlpenlzVXpIOFJwY0VVejFpVHZmQTJYcDN5dTFibytFVDZTd2xj?=
 =?utf-8?B?VXI5QWlsQUc1VXBVZUlLVzhkdjZzTlY5VDVORHFTL3BVaE9vUnN0TkF6TEpx?=
 =?utf-8?B?RHZQK1VyNDJwL29ZbXBwSHhTbGkxT2RuWUgzeVc0dGFMV0lyNkFOV3E4clNO?=
 =?utf-8?B?ZU8yYmk2bEI1TWEwcmFScXduMlh3WnFQdnFRM0lHMzlkU0hJUzBjZldzeGxv?=
 =?utf-8?B?RU9CUG9iMTNIRmhtMkVOMTBKb1lNRi9lYmpjcngwYXlWN0xCaURybUprYkVB?=
 =?utf-8?B?bTZ1eFNFUmMwdTlpbEcrNERnTGNKeGhhbDlEV2FheFhydnlnaVk4RGdhcHg0?=
 =?utf-8?B?TnY3bkxQQVVoUU1DZHdZTzZOWEttakEzN3hIelBja1JUM08rUTB1a0lpcHlv?=
 =?utf-8?B?cVVLNEdkQlV4VDFSSkRGTnBOYy8zZjY5TmtyU3NRQzdPM251dG9TWE4zcmNp?=
 =?utf-8?B?Z2ZCaHBtSUw5UFhCc1ZKT0lEaTNZQXZkT0lQc1FDaTd5b08wbVM1MldUN00v?=
 =?utf-8?B?SFk2R05TbGwyN21WTmxIblJjbWcvUzBzbDh0OHVZdGRuWllOd1NhY0FPMmRa?=
 =?utf-8?B?cy9EWmNRa1AyeEd2UVN5UERweGd4RkhtQlVOYVd2a1F2TlF6VjRuQXlNMUFv?=
 =?utf-8?B?TVh3ak1pdTBPR3M0Wktpa3V3N2Q1Ly9ETS9XUFBMWFBIZ1NKRUdxU0VCMDdO?=
 =?utf-8?B?VHRudnJwQzl4ZVVzMG1OVlhCNUtzVUhrMXBqMk9ObkY5VFdZVHBhVzF2MnAy?=
 =?utf-8?B?M2FaMkdDSGpCelZTeCt6QllSU1F4aE51S2RpRU5PcUhaZzhqWUJpbU5KR0ZN?=
 =?utf-8?B?bkNXTlducG1Db0YrSUd5YnNRVEdOWlcwNXM0WEpidE5sUHk5TmFWQTRWUUww?=
 =?utf-8?B?a3pHd3dEbytwbmQ1K3ZhNHM1NHdVMWF2MmR6WFdBL2RmdlNRS0M5OW9RRDEy?=
 =?utf-8?B?Z3RJL1RVQk42V1RxV21uZzFscFpQNWs3TklUTXVXTDlSOHdTdzg5MFZpQzFZ?=
 =?utf-8?B?SW15V3R3UXcrS0hFOEF5QVFTL1NsT0U1WXE0cm1LNER5dVZ1VnlZWHIrRGx6?=
 =?utf-8?B?VitxTHZBN0R4dDZxUlJpOVNvNnJNOGROLzF3eWhucU1iUUx0a1Rla29QMHhW?=
 =?utf-8?B?RU9KeXF0VWF1bkQ0b0c5cHpZR3JFeGYrSGhURlpKR2RQRS9FclU0eVdhNExR?=
 =?utf-8?B?eXVCTFBlTkc4WEpMa1BlRHpBR0Z1cUJnUGdmZjIwZ1ZZaytySlNrUmpQNTNV?=
 =?utf-8?B?bDFxWWN5bSs3eU9wWW9UNFd0S3ZaeFVJeVgvMzF1SlkySGJGWGZkMWtDempJ?=
 =?utf-8?B?R2kzSXBqd2wxNGRxckRHT29aRFJiSXdCUFJkUlhXc1hBZFJadlVuamVzaS90?=
 =?utf-8?B?ZjFxSUxtV05DVTZuNU1WaEx6dDNwSDRIVk54ZktEUUQ5L3oxREs1QkxWTGF2?=
 =?utf-8?B?bUkza0laQ29SSG9lM1JGQkJDTENrb3hXV2NIUkNhM0dVNmxoZlk4RXNvTkxC?=
 =?utf-8?Q?ktPdqe+1nyHBxH9aqjPt66/ZxnXXn/Fhy0SLWvwRol8Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDD339886F7093428FA6A2C071835587@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a91904-55df-4502-01fe-08de1ce7cc0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 03:51:41.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/Br8YwqSSWRCiwQCT5f/Z3hD2NXMtkNEINWoTHasKJKL/giiuqarUV8zejSq9JZH2F+TuucueCJdeCOTSlkJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

T24gMTEvNS8yNSAxNzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBJdCBhbHdheXMgcmV0dXJucyBzdWNjZXNzLCBzbyB0
aGUgY29kZSB0aGF0IHNhdmVzIHRoZSBlcnJvcnMgc3RhdHVzLCBidXQNCj4gcHJvY2VlZHMgd2l0
aG91dCBjaGVja2luZyBpdCBsb29rcyBhIGJpdCBvZGQuIENsZWFuIHRoaXMgdXAuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
