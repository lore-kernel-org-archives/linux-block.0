Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7573A5E9B
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683288; cv=fail; b=c7bnrGbIRTvKnJxDtrIdaV2fZXXiAUk9GJBqKI2B8kg6YVzUOUNn8T/o211vJ3jR5zncWnXhjV++4g7qnfJzUPS2Pq6puZVJGgA7cJIaq4pyzhejCfUxrMrnG9ycJcaRM2m+a9VPdoxOjVGDKwLcOlep0rtSF2nlDIhS4KpFLKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683288; c=relaxed/simple;
	bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uv7de/gq+nalhz41eobw3ZfE7+zA/UgXpxLGGRs+VI+wpzPtihPj2esx+l/xRYMPUqRIRG9KQ7ZCZxoQKkYGOBraGqXfr0wxRp6Loj5mozmTaZ0e1PBb9FVXMvzHQ2HjOZq9LHTCh8986Lp4YUK1J/YwP7nEzTN+jYYyXmpElO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUBTtd3z; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUBTtd3z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKq78NqJxOT1bgRzbrQHCzbW+BsUvXmdTKJNcmA7pqLJT5aUuJQH0op0x+55kdR3J2W4Zx7C3BWT9jNa160LdAzMPUgCN94skygAaMKYHWXsMkxY8ecc2JKESDOuvPH9Tz00qoZFPA/284GaV3X0HRgl7a7lXamAz0IWEHk9xZJtU8EipHOOK7JTmmD502HftX7ilOg7+FsLm+82+trMGv2izIgPE0yn5mupzGTMRoSA7/DLxzK3oR96CxgVyrbx0etNDH055EALXEwG3zMbqDsJRhpNsfIh8W4ATLtYejWGloDPL1/Grj7gv1ctsxwps4EpiD4YAdi8lmJwuqWUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=R6Jyrz55Xog/HV/LYhSjCXNkshXSyjulNXrRCnB8iWlkQdFwp4CD9keizx4ACqcK0YsDkl/vXQQH1BP1H6e1TJ3WXh2xRQ5x+BqfomEkDeFw7Fw7aF19drm6NHXhu8bNfIL1Xr/HTUC2fNjd8Olu1bQ0uptuGOSq0yTCq2zv/s2Lo6faUn+Fcny6k1MRdPvUDk44a+lGQn9WZV6vyVk+UccBcILWyk4VwV8I4NZEn7+N0KPyij0fKBLZgrYgzQaH1kS0AUfUbe0lTQkkAlufWGZByCm8j6y0n68HIRkwJI9TYkw9+QW/J1ZyRye1AMGD1nCsSATdc8L2t5Wepb17Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=dUBTtd3zXuoiNOi+FFslNPn8HBOqRyrdjqR7RgeaTSGiBrtvhsPuDLAcL+5ViDztWlSbYxwFpVpYwYxYYI59DGLMfbnvBdNkYScf0ym5ycoYyrp3R0LmyZkOmX4IIGP/4K+ezqu59w02jgu6+QqrtPzLGraivZPpIaE9t1Wfc8dafRITB37pAuKteqoQfRGXqcAerigX0nTaSQGz9sr0yEzNlcJogx8DxO1O/Q4ZFQnb5C3gmPHsOUOlSBXTptZVDsJtebBNoq+ZAjyAuI04pa4xW4EDKcyGiFmmqzugd6xYfm15RGSf7u21VEW6YWhSSc66axRfMmsZ2uYkilcckA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:14:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:14:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai@fygo.io>,
	Josef Bacik <josef@toxicpanda.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v7 04/14] block/cgroup: Split blkg_conf_exit()
Thread-Topic: [PATCH v7 04/14] block/cgroup: Split blkg_conf_exit()
Thread-Index: AQHc9RWGg/J9/duhRUuXfsa++VCV2bYwRDMA
Date: Fri, 5 Jun 2026 18:14:44 +0000
Message-ID: <3170ca16-0235-4bf1-9378-95068e27affe@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <c1ec1f1c4b675bc5f187f77b3e6436234c6b244c.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <c1ec1f1c4b675bc5f187f77b3e6436234c6b244c.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: 90592f74-ec15-43a4-62a8-08dec32e5239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 VHYleMmMStgJBVA9gtnR07/hSBuYMeEIuVb6RC5l9ekgg0JsSvXl44uOfiNvRtqTLWrXW66Z/aX8TvO63YI1DXKv66Vmy3WiRI5FwTb/XhfKLBH9xYpJsnKXj8fAiDvk/MCJhtHU1alnFfB2KrFzzMiWY5WcqZC/wgYDJDaiL1OXOG4Hxi37wVlDcM17F3q9FgFnoaQRBF86yXZVQny6vYzJPfWslu+5xK7pxAp7zy0osNaHQRNhRCB5cuiClMdym87NdqYJRypWtkk/a3en/6cV7FE+WTTarn2hpLPJLCDHxf8Zx9L9nh+oJMBfpW18CtrLKtEKQrG+qlzm0SkGrsJXwkkWDGJ2t1qwXfBE1w+bVLcrWXRKF6LhxDJ2cRBxtZFaJShvjJppBpF1Ch/bp+3MgnKy/WVWgeXGOeCsabct1d0hG4HLE/BNagpmnxwRxzmk+Rdbe0c7/iVrYXllwACRusFj7ORUV2TYEH2fsAUYx1LpEpjpkjyVf/63o0ALXUDMQyhqQzu8yfjeUoa0HuFycXzVBvTZAadTwgA31aOOL6w5085WON0EUBM7cAV95cCEyCWhSg0Zbj0jWenBtQcsbyoQ9EHOsQf5fjJnII1lX1gxVeJYi+KI2hkbtmEnD7F/NT3Oll0ifAPs07RWziHrd3DXQ011sei2RBAFN6lZxrjLmlWE8wD9Cm2udQ5rwpI0hrzvYENbHlAmFZwHNc0qV0CykBD/PtdcPY/YVtZFmnhqV3MW/Pv469Rxq/Ia
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWxPSDlCSjZRMW90eVVwMGN2TG4wVk1NdGc5UlZOVG5zN3pFblNYZTVhbVgr?=
 =?utf-8?B?cXdKVERJbjlackJzZzdoQXh3UTVXY2lLdmlEWmZidkxXR2ZEUHVVWldWeHBa?=
 =?utf-8?B?c0xta3E5Qy9pcm9XTXI0dEFJUTRrMERTQ3dCZWZqWExwa0dITFhDcGVRZUZT?=
 =?utf-8?B?bTZOZWpFZDhxVS8xaFIyaC9zU2tOQUxhdEVDMUFPem05Z3dKdlFUZTVwU2dP?=
 =?utf-8?B?WFdrNnlaY0NObGZPSmlQOUFaanV5dDdKUXUxbU9qVlNKU0pYUXkxUXZPbm9X?=
 =?utf-8?B?RUNHcU1lNEV6eU1UenNuWkpDMWJUQktoeW5SN2Y4RnovNkVUbXRwZkQ0cU9V?=
 =?utf-8?B?M0NtTGZvS3BUOWlIR1V4RWdnZmg0ait0RUY4V2ZuamlKbnJhS0RJK1BPS3ZG?=
 =?utf-8?B?SnVDK3Fhd1VPYWNrSElxOE50RHNwSWpFaVRGWkFCRHhjbWVLTE1IQmM5NjF6?=
 =?utf-8?B?OVJ1NzFZcm4zcDhYdEthYmZ4SEdOWXBxYU85YnIyT3EwY1krS2lpTVFSNXMx?=
 =?utf-8?B?cEE4cUdxcmVHb3ZVdXZMOVc4TGloYWZIZHI2b2hBbGVMWmZGUGxUUFNyUVFa?=
 =?utf-8?B?TjhBdk1ueldkSVRjQ0NycXRmWEhGTEJjWTV2Tmk4NzBTQzBGMGxaQWtIdGJZ?=
 =?utf-8?B?SFRoeW9oWmgrK0dXZzhMWTFHcExsQWFsOHJQckVhMG11L2xQeXFISXJlRmVz?=
 =?utf-8?B?STd4NzFjOWVWc2ZOVkFOekdybHp4b2pKVTFxZW1KRmk2eEtCdVh4cGNPU1ZK?=
 =?utf-8?B?Sy9IcjJmUFRxMmVKMHJ6UU5zeXlrWE9oQ2JsQkdaQjdvM0xqRkw3OXJsZyt2?=
 =?utf-8?B?TWRQOFhSdjFVRXI2eFN5VndsdjQvRVhjSmMyOHllZnc5WXJKOXBlWjJWOEtU?=
 =?utf-8?B?S2JhNlNQU21XNUxHLytsVWFVeVlPYmxvRmdDTGNDRE5pWVpqZWVyZ0oydFc3?=
 =?utf-8?B?TFR4bmtKZjVVUWxTQXAxQWVITlMranViUlhuNHR5Y3FUaFdGd2QzTnZheHBu?=
 =?utf-8?B?VE5oRFo5NEJNc2R6cGdJQlVrdEllbkgyeGpYdUZSL0gvMzRsV25yWUpmT1Uv?=
 =?utf-8?B?aGJJTHBucStaVkN5MS96VUdvU3R0MkdPRUhFeHVQTndHREp0R2hJS2JpRlRz?=
 =?utf-8?B?YUVlazhvRVQ5d1VKdWRUUWtScjBoOUFJUEluRGtNbDd5dXZPeGpjcVR1S0Fr?=
 =?utf-8?B?V2x2NS9mTnZteFluOG5zdDlLK000Yy8wemFPakNQT1VndUxWK0wvcWtSdnB4?=
 =?utf-8?B?VUIvRDdwNFZXUEV5UERZYW5LVUpYS0d5bTlaNjJ2TnFUSWNXRjV2L1BkNkNs?=
 =?utf-8?B?YjRyc0lCTjlPN1NzOThIOG80YUptdXpVUUZ1a3NMQzVtRjN1cWVrdHd4YWRF?=
 =?utf-8?B?RUxsRWxIdXdCcWpoMC9ZNWVXa2dwdXJ6RUpJNHJLLzJ4bENEa0lWbG82MllI?=
 =?utf-8?B?eGd6Sm1TSHBIUU8wNzc2TDV5UWZsc2lFN0lhbzJqdWc4TU1qT0lSNjNEVFU4?=
 =?utf-8?B?QllVbm9ZQmNBY2FadE5yVE5XVTJnbkFYeTZHQUtkZ2M2ZTgrUVhFKzFNdjNL?=
 =?utf-8?B?c0NFdXFxU2FMNmVJcGkzakhwaXo2RG1NVjRJeDllVjZxZURuY2M5akFyc3FW?=
 =?utf-8?B?bEZDcngyckxURzhRUmdXSkZHSUdSU1grSHkvZ3VIZHZFb1B5WlFPeUpoRTVn?=
 =?utf-8?B?VlM2RkNtOGdMUzVwVlowMURVOTBURTRyenlwNzhwb3VHT2xoL2IyTXErVEdv?=
 =?utf-8?B?Z0pjVHJKcU9KQXZEbHZqSGdzeFVNbS9HcWx0ZDRaK2JIS00yZ1VKTUxwa1A0?=
 =?utf-8?B?NncxU3VyZXlEU1pocHo3YjNUSGpSNHNKeWlMYUw3RlIvSHhqZWpXT3JOc0c2?=
 =?utf-8?B?VUV5MUVITkFscXdieWZFM2lVNy8rNjNvOHkvYkkySVNEdm1UcjB0bXBLc0dP?=
 =?utf-8?B?VFZyM2d1VHVDMlVzaTh5RVY1czRWQ2ZEbTNRbFFDWCtieFpGd0wrREx6UGtw?=
 =?utf-8?B?Mlg1OTJGNzhpb2MxYWQzT0NMZy9uL0tuc09rcWp5ZU90REtJMjBKNEVDanlO?=
 =?utf-8?B?ZFovVXFLYjRJMmlDa0wzV2svZjZyRXEvS3pFSktaU1lZQWUwbU5JNE1INmRF?=
 =?utf-8?B?WVdBcFZjeWVQcUJQLzdiYlQxVDJuNXJXbnhEOXhDWWM3d0ViSVpISWk3c1Ew?=
 =?utf-8?B?Y3pCZ3FnL1lCRWtZNlZWRUJiNVJyWUl3cFJ5Q1lPRXFpNm93Q3M5TWZZN3dQ?=
 =?utf-8?B?V1ViS1Bsb2hSeGhEcjUzdUR2WGVnUHlyV09mRzJ0bkZxaDE5aGRCLzNxSlpI?=
 =?utf-8?B?M3p6T24zZW1UVW9oMGZDeUFJTWViVUlBUE9SK0I2eUQ3QnIwVDRSQUZNckxp?=
 =?utf-8?Q?6cNgvU4YFAn3W6Q4MsFpI92qVYTLQadXJkhU8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <360412F7B37AB0488F48CF333E632AC3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90592f74-ec15-43a4-62a8-08dec32e5239
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:14:44.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0G/AyBXRuBzanYLDVXZFKHvKCluv58YXm0q8urODkQOwDxA51OraWSpeVqy/eZEqim8g2oLQGN7H0q52Q9iS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
