Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023D2DA757
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825800; cv=fail; b=enzYbhQDgfYvrDgDREFvaFdRx48IvwlDrdhyXdF/QyCO+uYiu/4QNdYwcpFVmSXhA2sSrwVdqO4sUt1VoYaFW2RzCfwRk3Emyh7LErOksrESwqIamtKA14oXnYoE1b5fuwvC+4LbcC4a7nI22+LvBrR/KW6oq3uXt1XjmvItHFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825800; c=relaxed/simple;
	bh=/mRBjXmgetJ+mYTX2/ivsVIYpmxLnQbj8lJluHENBQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oj8EHbaEZKOHeIB3AC2L+kRnBd/eS+fQzGOksN+GeXFJf8vy9YsOQMZQ5AfgYIUKoZYYx5o1H7Pi24srW3vr0jl+WfprYMRsDaQ/7yFOhywQoOCZ9ErWfzJDJ2uWjvAn/ZP1cXXfSGcGgxdrHS/EXQHT3vxpFVA3iTj6M1NruKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFeO4EXj; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFeO4EXj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Z+wfZo47dHTr8iJqkCzIT/kWHkzNbWlcyVrjl5adrKEqJcHBHb0VNeUR6i+5o3TuBAR74LgR+GRUzqpYC7sgpzG+ZDLqeQ9h17YT3xzJpRBVD8fQDAWlKpUFOMPM3wZ4h2zNwXlP4vb+GdMRC0eY4FbD+OnWcC+7kVY9aFRG4Mx37ILaJd8Uobfc8ce3UypjcR1WIoWjWN8n1GxdMAee0PzqQ0O1uMqCn1owS9uzQXcVJrKjEvr7Fdzs4kqmLxj6cNFMxe+gBQHtiQVTS9BAaGOqfwAuGSWhY/IujITg4lek35pbasKQ23z2/95U3ozBGvn32CX1Z2GOqhaQ9abA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mRBjXmgetJ+mYTX2/ivsVIYpmxLnQbj8lJluHENBQM=;
 b=RuAaPJcc3es8psWg97P+56/pD6HNTA9h/Ms//hWnLcXVpGZOpGsHc9nLbhrfmVo56KtdATSGRHcTfaXidAB8ukWMumGSqqrX0UGYJU+6W4Jp4TzM6m1OMYZubv2cUuZUX20GrruDO953MjRJKqJQZqL7BtCsuGMbVOchzatkp6OXSPymjXjKV+adJ3vBgV6GY9iQyf090x03+kXSn0XZTVYtEWqN8X3QaxlfO4E7RgzmGrilp58p8+6Sgqoz7XXOTRUonniem8yhY6qDfOxrPQMY5JGt09m0PBV1SQpkCFRTu3hkJZZqAf/1NbCNmSShyBuyZ1QhQtHnNRug98YHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mRBjXmgetJ+mYTX2/ivsVIYpmxLnQbj8lJluHENBQM=;
 b=JFeO4EXjeuU5ehePcCEh0+G4w1OjDYKN27pNa4RbXZ/vgxvQDStjubd+Qc0rZ6Iswvtp81WtEtaRsxi8QQ6D+hk2LUpV7AHGhx2ZM1KnG6HJT368cqNwTfdgZvxgTevSIlW3FLEOnKRfAx/uF4EBMlL5Wd/fs7Mhhi6wnXtu5peoEopAV6z8R8z/ve30ICmTGya5pDnZPSr1SAGCjCBa2jvn1CNeFZ1PKsAEhUcLrNjb+XKd25E9ViY416kIQkE2h4twLB+YKwzB3ZfQWQhWVq/nR9sNYdwTL6QgXs/TxEa21uAkpPVYiqu+An2eGUMZzcQWxkNr3M/R+a0U8NwiiQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:49:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:49:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/4] blk-zoned: Document
 disk_zone_wplug_schedule_bio_work() locking
Thread-Topic: [PATCH 2/4] blk-zoned: Document
 disk_zone_wplug_schedule_bio_work() locking
Thread-Index: AQHcUpJzmUi7GDQykEKHRsnXggxWULTstdEA
Date: Tue, 11 Nov 2025 01:49:56 +0000
Message-ID: <e5daf1fc-d55f-4dfc-be93-df69a7329b52@nvidia.com>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-3-bvanassche@acm.org>
In-Reply-To: <20251110223003.2900613-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6242:EE_
x-ms-office365-filtering-correlation-id: 527c9ffa-abaf-403e-cfd1-08de20c49da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlBrYW5MSmN1SEp6dUlaMWtySHl5SkprVndZSHQ0WW5HTjdESkcvSWhyekc5?=
 =?utf-8?B?T2ZCOTErMlZneEFveGFac212bE9pbDVndUJmQVByeGZXa01NV2crK0JVOUpw?=
 =?utf-8?B?SWd0citWTUtiU2hwWnJPZjJHYXlRMkpzVUdDYlY5aEk3ckRSenVwUXdsN2gv?=
 =?utf-8?B?VVcrVGJSdFRyRE1kL1FHbHJMUzNjRUYvSXhDOWR6TGwxWVZNY2RSWENkcmVp?=
 =?utf-8?B?bnprdFJ6d1V2UmdwYmM1OG9QVVUzalo5c2NXd1ZyM3ZMMzZsM1BMZnNPbHRy?=
 =?utf-8?B?Q0xDb3ZWb2pyQkVoOHJpbS9YeXdxOXMvQXBiaDRMSW1GN25YbGNVckpSVDlv?=
 =?utf-8?B?NDcveTVBQUN3d3crQVZSVm5GUTRPUTdLRUd5NE5NZlhBTGhzeHAxUXZMK29x?=
 =?utf-8?B?TkJ1UEhwVTFENGdMQ3BCdUQ0cCtXVGFXa0F0TWwwbWtWeUZvSnRkWlNVS0hE?=
 =?utf-8?B?SXNaelRvVmZUUDE5VEZtYUxSdFh0eEZScmYyNnNuYUJQUC9pMVh3TUpPTkRQ?=
 =?utf-8?B?NkIxcEVTZU1sZVM3bHkwZWdvVSsySVV4MlBJL3pkak91YzNlQWtCcTE5Z2Z4?=
 =?utf-8?B?NjhYM0g1ckhkaTFjbHEyRU9vZjRpenVHTnRkL3VjZlF2S0RxN0hmOXhZaDFa?=
 =?utf-8?B?MW5scmllY3ZZRzgzdHdwSUkycXZmSUhoSnhnVitZc0o3b3lib1B0b1JmQlRD?=
 =?utf-8?B?a3g0SnZGWGJGa0FUNVNuWDNaWGh1K3crUUd3QU1SampQUS9DNmhMUmk4Y0gw?=
 =?utf-8?B?cERBb1RIVjRsbG42T3M3WVlyYjBIeEplNGtRRzRCZk03MDZUdE5wUU0vQWpN?=
 =?utf-8?B?aE9ZUHJQVVYySVhpMjZqdFJ4Q3JXZDZKL0k1Z1dmNlExVWJ3RC85WXBHQmNn?=
 =?utf-8?B?ZE1qMWdRMUFRRlZubkQ2MVljWElRVWVBQ05LT3lPVzNiaXd5aWhyNFNVcFA1?=
 =?utf-8?B?T1lJSnBHZ2hKblhqTS85REdjZ2p6dENraVBZSlUyc2JucFBCZUVISFNTYXhk?=
 =?utf-8?B?cExsdDB4Q000dEpLR01COXNiTHJSajAxWVhhUHUrc0RBSU45Zk0wYmEzMXdj?=
 =?utf-8?B?N0tpUzNSSW1heHpQRW1sZTluUlRMUkdmVitvb2JkUmhvdUgwc1FCUUpkRDY0?=
 =?utf-8?B?M0JhTDNDRytWck51SGJyQWJ0akpmQ0NHaHJrNUV1NmJ4Qkw3NDdaTHFRM0cv?=
 =?utf-8?B?dnd2dVg1dEZhbXJqQjdKS3h4RlNwZkpCeFdOYStCcEw5MzEvdVNHa1NXSlFw?=
 =?utf-8?B?QlhZRElMZ0JGd1MreUtpV0MrSndBRVFMeTdXa1FrQkdXVFZER0dpTjQrN1E3?=
 =?utf-8?B?d1Y1Y3FLNlNDcFRSaVFNVElYWDZ2NlBsMzZkQVZUTm5TRDdFZi9aVjZ6QWRB?=
 =?utf-8?B?Z2twSE9MV2dmU1N3Z2lSY29MSWR4WTd6Skw2VXdLWnVLZ0EyWXNjNHZrbmpI?=
 =?utf-8?B?bzl5STJLMXBITFY5K0thdHlMQ0RRYVhBNXpNbWFqU2RpWVhaOHZEUWZKM0h2?=
 =?utf-8?B?Zk1XNHRsUXd3TGJ0R3YzNzFSQkI3cW4ydTg1SzZwTUFlVmNlNkxjMnExejIv?=
 =?utf-8?B?VnU3ekF0QndZdEhOWnJlY3ZEVTgzWEpMVmt0Q01FOUhvamJVdXNIS1gzaXNK?=
 =?utf-8?B?RE81RHNEMmlMQWl5V3JLdkVwWGZGNWhoaDdiTDNUcmt6TUhSTzk2TjhaYkhj?=
 =?utf-8?B?TTVRUTJRS1NHcllZZ0xjT1hNWW5ScG5TRCtJRUE4V0hhRDR0dktSUWNYVDB3?=
 =?utf-8?B?QVA1bzJnNEkwV2lYOGZhWW1GdGQyS1hXUVdESXNUSUUyUW9XaDhMcHBDV3pj?=
 =?utf-8?B?cThNNm1uU3BBeHNKaENCK3RTUWtVdFNDNFBNV1M1dXNzc1ExeGRyUlQwTE5R?=
 =?utf-8?B?aGc3RGRQMmZTU3FLNXJKWmVDdFp5SVY0OFhWaUloQnE0dDVEaGtFWHNlQWpx?=
 =?utf-8?B?VlpBMmFhaTY2eGxIV2J4cVU4TzBYdGJNQklnZjBGdWlBZnpJajZJdjJWc1ps?=
 =?utf-8?B?QkhQeE55Nm5PUmpJTU5rUnFjcytKb002QS9kbmZCbXBkakpoRkhpL1VlUElx?=
 =?utf-8?Q?SQ7i+v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3JHTWkwSmNKd0lMcEpXN1RGNWIxRGtmMktEZ1lhS1dVWngzVHlmZmdOUldR?=
 =?utf-8?B?bHErN0g3Wm5rMnMzNWV4R2hGdWwxSm8weFg4dWNqcXJvTDkrNStuT0pJVElr?=
 =?utf-8?B?TUNMVk9Mam9RTXUvMHJDd25jaWFuN0h5SGtLUklDelZBVGkvdmIwU01YenhR?=
 =?utf-8?B?TkNxOHQweHk5N1VyOXZBQUZUTWl5T1M3OXN4eVBEZnZSN0RJenNia0JPdGNX?=
 =?utf-8?B?WGtMT1g0UUU3T0NnZUpySmVmbW55QURSTHRTT09jWEZNdk10aGw4ZllMd25V?=
 =?utf-8?B?bEJQM0tzMEpQSnNYOGNEQUFEVTZGWW9yemgzNFhkSUM2WkVyTFFKZVY2M0J5?=
 =?utf-8?B?Snd2MjZ4VS9QUm5SNjMyOXpIWHd5QUJXSVB4QjFxalZCWWRXMlh1eTZUOHlY?=
 =?utf-8?B?UVZDVXhHY1dkUUlVWitqWW1FcVZ1WGh3bHQxRnNrNDQ4MitiblgweTYydUlZ?=
 =?utf-8?B?ZkwvQXZURjNuS2dZZ1FqZFk1R2JVYnMzWlRNM0FGbmVXcjRRd2RSbHVTc2VU?=
 =?utf-8?B?NU5NUUprR1dPVXJPZG14SlowNWxRcXFzRGdTZGlJSU0rWDZldzdJTjBzUjVL?=
 =?utf-8?B?S1U0TVhYM1ZNNE9QR2Y4eFd5RjVhbGNybm9aRi9WUzRLUURKdUw1SXcvekxw?=
 =?utf-8?B?K0VpdlI2cC9qTk9YR0Z4VThXUm1OazYrTEE2bkpBQlZQREQzNnRkbWVVb2FW?=
 =?utf-8?B?WXgvTGNUenVYTzU5amI4ZGMvWHZrMTl2b2t4RWsxRzZLenZMQnh0a2dEcGhI?=
 =?utf-8?B?eDV0MmdBem9JUnpPUkpoYVJoOU9wM1RMQ0pqaDlPcFV0b0NvTFlMRzlMMnV2?=
 =?utf-8?B?aHJUdlIraHdzS1VmVzQ3SEswWCt0bmJYTGFsYlBzRVFDM3Q5ZVlUUXdteHRB?=
 =?utf-8?B?eDBVb2lNelRxbEJSb0c4K2lJRXdKdEw0a3RsUzc2RUE2Uk9jbTVqNVBLdDRI?=
 =?utf-8?B?RXplTVk0aUpkaFNadHE5Q1R1YXBHTlRnekVoVnVCREZqVmdQWUgvOTNHdkFS?=
 =?utf-8?B?UXJTbGxvK3I4MjJiT21mTzFENzVYL3pSbnJORWVlT09YUzlNME9TSnhZbHVz?=
 =?utf-8?B?NmRzNUh3QmkreFloTEMraVNuM3J1a01CQndWai9FVnRBenpxcUQrTlFJdkJs?=
 =?utf-8?B?QlpUZDUwZGFsb0FxUmQ5ajBzT2ZNRVZOTUpiMGtaNE01WXpMY0RYT2h2VzBl?=
 =?utf-8?B?VXFveWVHbDVHZ3lHdGI3ZmpjZFlzekNUcEI5WkdLWW83MXFYb2cybEUvQXZt?=
 =?utf-8?B?ekY0UUlHS0NXR1NzNnhSUWVJcGRhUnRZTy9JUE9CZnNBT0ZMTi9iTk9DZm1m?=
 =?utf-8?B?QUljZFZwbDhsMTNxYlRmaTR0Uk11enYyRStQMEZ4ajRHQ01xWHhYSnh1dHoy?=
 =?utf-8?B?K1dYdHhudE5Na05BUWVsWGllLzExOW51WjlBSjJINU15YlhtaUEzdndlRE1j?=
 =?utf-8?B?UFcxUDZqWk5oS0FPQ3NoV1hXM0NwWWprd3VIN1E2Y0tPdGoyQ3l1QjN4Ynh4?=
 =?utf-8?B?cTA1R0UyWFJlWHVLUStDVDRkTzI0dDFSRnE1QzZRRkNHUTNsaUtpR21wMWds?=
 =?utf-8?B?aXR4Snl1cm9WSjIrVkk2N0k2M3RjQjR5OGtHWHpUT3o2RC83WHYxT0ZraFlJ?=
 =?utf-8?B?TGt3bFRxOUduQUtRU2d6ZFBGZXgrRWZWazZWOVFIYTZQRFl3emxKcXhDRk4w?=
 =?utf-8?B?NkNsbXViTCtDWmdtODkzVHhsZUE4V3lEQnpKcTlPNndZVkZGRGRSenIvakMv?=
 =?utf-8?B?N1ZWN1RBd2JtNkhPRTZiWGZZMG1rUE1xcVh0RHQwSDZSVU8zZVIyT1V1c2xZ?=
 =?utf-8?B?TEhOa2Y4Und0VlZZRkNVeEVoQUpSSjNpZ0RyT0srdnVpdzlTcE1BZkMzRndD?=
 =?utf-8?B?Rlp5aVJsb2xMOU5DNTZIWWVGWEkrK0YvaEVsUjdMYWJjNmNQbFIxMUN6WW9T?=
 =?utf-8?B?OEVoQjZmbVh2UG1vWWIzd1FDVTN1c0RzZnRGRGFYYnV5Ymo4MlhkT0JmdlEr?=
 =?utf-8?B?ZFd5YlpzK0xIRGdhc2xQM0VpQSsvWTlYemwvWkovcll6bDl1YTIwRnBEV0tO?=
 =?utf-8?B?YzdpWjhjZUdHUDBqbFNoSVRrQW94d01qcW01TVVHTUFjYkFGWWh0RzdjZG1M?=
 =?utf-8?B?eVZRWHYrRUJlaUxJalk0SDlnZjlmelJRdEVaRm1mWm5xN3U4bzVxMzRtbVJ5?=
 =?utf-8?Q?yxSNEgL1Qp13aVHyX4orGfPqNEl6pleb6Oi79fU9vL9y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9CAD7C4CF6D349920F3118FF46CF5B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 527c9ffa-abaf-403e-cfd1-08de20c49da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:49:56.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysaDrzxde2iNzTeLySTv7zxU6pBUr334UTWlqgoR1yXW0RKEwrDt+dCnVCqyfGcfylkN75RFhGzcRCIn/CGrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

T24gMTEvMTAvMjUgMTQ6MzAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gRG9jdW1lbnQgdGhh
dCBhbGwgY2FsbGVycyBob2xkIHRoaXMgbG9jayBiZWNhdXNlIHRoZSBjb2RlIGluDQo+IGRpc2tf
em9uZV93cGx1Z19zY2hlZHVsZV9iaW9fd29yaygpIGRlcGVuZHMgb24gdGhpcy4NCj4NCj4gQ2M6
IERhbWllbiBMZSBNb2FsPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gQ2M6IENocmlzdG9waCBIZWxs
d2lnPGhjaEBsc3QuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZTxidmFuYXNz
Y2hlQGFjbS5vcmc+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
