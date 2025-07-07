Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E975235362
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931365; cv=fail; b=fXtDQoiAJnp3tUhw3aA2BYN9AxJhBb/wEBXr0z59q5GJGkgLw4A5+g1CEFPP6EH6Y2UO2LIlBZae5HC6vwDYVhGHtca6pyRcTH7YPfLa16+BkIcEjMRYtslj70CbVqc3OuULmXH6WIAk0SkXWcyTZehfI1FVdTOp4AefSJqPO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931365; c=relaxed/simple;
	bh=ODmPzBz1xNv77oRuINtlTCc6AgDMQDCMoyACUXrOgMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0NMWW4MG/8wlbaAVlYhoKLC48Up+szYyQmNu9rP9fdRwLxN0YBKrSuAE+OhJWhvkxVjpCynPyR/13shEBJV3fLTSKGKGEe3qlzYwv2whyd1ZRLZMch/S6RMePFiPJAugWCM1/jsbRDM/esE67ioTmQcnDHOr3ORdBPlnly9les=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5Mfo85Y; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5Mfo85Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY1qcKd8a3cnnM3DKk7QHTFjqnL7Of+GkDFTUjr3TUlmOdfSpwtqRXnxK2Fvsv8gFl1JXEFF5lg6iuoxilCHgrWaVDxnTEXTS0w6idfKwhFFdVoX4YnOl9I1tyhUukKCsFDQSIpbkMY4hDvVDGw0YfpdBTZMuCKUHiBmxubBpYf8PhAQD9cKosatMFYtkFcox56q64FORoqWx2XSs+cwvVzZGa7iUVncqonYXn5p59QiGJvyY4Anl86oK4qQK21hGChcDZifF7hVb2jt13RXs1gFec5YUtXw5+aptIzErBd+cFwWA4X6zmRcjBYc8HUF+BM1rfOXwvoq8j00nEdgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODmPzBz1xNv77oRuINtlTCc6AgDMQDCMoyACUXrOgMk=;
 b=e7VoKWx6MVBrBS8+5PVAPxCCxV3TbLUik/QyOJKGqJYVYmM+/Kfroo7WUTZgT0ASX6/P9Vi/Ifb8x1Qu142wCkhadtyW3PDvJxlb+HFx41g2Gx7HUPg5sZwUYCKbv2/iQH0GNc0lBvYLYwDjyE5uF8jDMRo2m9p/4urqd2jdhaTftqYgJwU73IaS3vcFKiJrlARsmTkjkbRAugVrDoAUpZiP6IXkGcV6cJbPYO+1fqlxHmq6q7hYNyr7y5mificiWvU+YUjW3OgqdswGLbPDxqRURfs1lGbICscAE+7LlbyEwoE3ZTLJEDi/r9w0DHSre6sedeaq4rjB6pVK6i6oDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODmPzBz1xNv77oRuINtlTCc6AgDMQDCMoyACUXrOgMk=;
 b=O5Mfo85Y6mTH1wjfcalZmS/qBag2aECVPQkxFAaZpi4Oj9Q3TZcU+KJNbx4YzYhFBclJgx1bfaKZXR7Zs0wWQXtFOcajnha8MvM3yRa0DgbksfzpKLSwF1EqpJZLjnU/QBqefdAcsZe0uRS3cQ5MWnLX1/PvvziBwpUhlqwJrxwer1+8Ld9+UnsKsO0zddSeUGqwfTpN0vYkToC/puOF55ZeQriUX0oRhFVssgkFrm3bAdnU6Zleyk7N+OhztkbC9TWkUthqiQOo9oRZ/XGIzgoezhnHWnTa7fb/hMHOw4QvYXhrGsyfCoopvrAn+8OeQJu8MMGyAB+1O4efSsjSIg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 23:35:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 23:35:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: What should we do about the nvme atomics mess?
Thread-Topic: What should we do about the nvme atomics mess?
Thread-Index: AQHb70oTCdz19MVVuESes9SuPs3m0rQmtx0AgAARaACAAAhqgIAAgEQA
Date: Mon, 7 Jul 2025 23:35:58 +0000
Message-ID: <47ff4065-efc6-4c8b-b0cb-e2809ecb902e@nvidia.com>
References: <20250707141834.GA30198@lst.de> <aGvYnMciN_IZC65Z@kbusch-mbp>
 <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de> <aGvuRS8VmC0JXAR3@kbusch-mbp>
In-Reply-To: <aGvuRS8VmC0JXAR3@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB8202:EE_
x-ms-office365-filtering-correlation-id: 75553d6a-60e3-406b-f16d-08ddbdaf06dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVBZL0VDN1JXbVVGcU14dzZDZDlxTFI0djlmZnJVbG04ek0rWVNZNjYwbWZU?=
 =?utf-8?B?SjdaTUQrdnl3VTdWWnJuWkYyZGIyNVEwUWVYSWdCNXJkTktSaU9JSm4rSkZ4?=
 =?utf-8?B?ZFFUSkN6eEdkQkdnZjMyK1VNSFJVcEV3c1hocXExMmp0K0N0bHcyNlNNeXpM?=
 =?utf-8?B?K1JOYzltVXpFSzE5M25xZFBzRW1rZi8yclg1dzh3OTRKZzEybjBWemJobnBl?=
 =?utf-8?B?ZVJkeXZIczlWSy9BZDY2VkVwRElteTFNR2NvbzNwbnJHMXdqdzE4Sm5ZNGN4?=
 =?utf-8?B?TlcvVmZYSWtTUTJqdDRSSmNPUGxZTHdKRFErUDJLZnpJVFcxanhoSzBHaTBW?=
 =?utf-8?B?cW5rY0JNWXB5N1hEdUUxV2FURGdIcVNjSTlObHc1WjlHZDl5N1BDczl4V05h?=
 =?utf-8?B?TEdURGQ2ci9LeWhBa2wzVkRJd0xrTHp0QmRnamVHZ2t2Z0g2cC9tc3ZSTG1s?=
 =?utf-8?B?blFzY3A5VTUxVXl5OHB0QzZNeXhJdXVOQURnNWV2ajJoRkE2ZjJ0N2dLK0l2?=
 =?utf-8?B?Zno2Q0U0OWlsemUwd3ZwMk5ESktwZzcwYmF1Mmk3b3JXQmVLcEVxMjN1S3JE?=
 =?utf-8?B?emJ1eDVUc3ZKdnYvbzlOM3Jjd2k2NC9ab2F2c1hsRzB2b3lYVnhlSFRJT3E1?=
 =?utf-8?B?Uy9ma2QrcnVGZDBUTGJqZGRWREd3VzNUTTZ0bXlhVUNhWlV3cXV3c3dSNHNM?=
 =?utf-8?B?aERubkVoSXJ2SGJUaEVBdnJ5VzBmR1JnOXVwWDdsbFJqRkxpZkI4VUcwMll1?=
 =?utf-8?B?R0x1enlBUk1sWGF4UEJMZlVWZmd2TzAvL2M2UTlkYUhHNkdMWExObXpOcWJv?=
 =?utf-8?B?d2NLMUlRV3RuV0VLY3JQWVJubCtxYTU4c1IxQmczV1c2MHdsclNKb0g5NHlY?=
 =?utf-8?B?SThSU2FwanBsUDJsdUwwb2VkZlRNYXMrK3Znek1VcmQ2dGZ5cjBRSHkrV3g5?=
 =?utf-8?B?NEQrUStKVUtjeGRXdWF1bGpNdXMrNktrcVVJOUYyT255VmdwcUtBd1BjdWUx?=
 =?utf-8?B?QVVkSCtmS3lRZ3EvMWxneUU0NHhRckxSNU16SGVMT3dUMjBwaEFWNlU0VC9O?=
 =?utf-8?B?dW83VDZRMjRNUHlkL3hqalZUU3lGYk9MdWNKUUMxVFYxL0tISGJLeEJUSWJS?=
 =?utf-8?B?N0xCaEQ1UlA5SUs2dHVaYWJqOW5FS3RCSGk1bFlNZkVFTjhSbWI1WGZzYkVE?=
 =?utf-8?B?aGY4T0RBSlRJOVhwM2UwNkZIbG1FZEV0eXplb1hvYzB0czM5dWl3WC9XUDZ6?=
 =?utf-8?B?ZGVJSTNmMG1IZGVteE9mZ2U1VFc5VlY4cFJJZmhUUkRpeHVCZUgzSzY1MFBp?=
 =?utf-8?B?SVU1eWRXS0pkUWNyd1N4KzJLai9GWTFUZzNxaUN5Zi84cURWMGhzQjJTQ0tv?=
 =?utf-8?B?aHJOaHRNNGRKSDhXWXludHpsOVhGNkthMktwMEtzZ1FOdkFuNHkvaW01c21j?=
 =?utf-8?B?UEE4SlBxamZ4S0VSMVJsYjJUbWU2S1hGMm92NTk4Wk5qd0h5b3pMems4WG5z?=
 =?utf-8?B?NHNCVTVUNUplWlJ2L0R5ZVFFUlVGOU0vNkN6THFVNFVWUzVrenVzWlg3UFV1?=
 =?utf-8?B?aWFQakJINFU0VEJXMmdDZWJaQUlCdXpnbm1JTll0WXMyNndGcmNVL1BBWFZy?=
 =?utf-8?B?NHd6SFNnclI4SmR1ZDRGSXcxUXZDbm14ODRuaG41SVpmaVJXWlpieHhPMWcw?=
 =?utf-8?B?eEkweFFwT0VRQW51Nm1kZHhFOW5qYTFkWGt4UmVXSFBGVTJ4d0tvNjJKZy82?=
 =?utf-8?B?cWp3YStXUnhJUzJTcmRWcDdsZGJvVlRNcDRldSsvMk5EcHNvWlJSdThoc3JF?=
 =?utf-8?B?cTVCTWtIUHBsUzZjL1ZoamdwdHk3Zk84SldUakx6alVjYk4rZ3NkRmtVZWxx?=
 =?utf-8?B?dTVQZzFtQWgydXliLy8yN0g0YXhsSVJTbjhBZjg1eHcyYTZZalh3dHlVSG5Z?=
 =?utf-8?B?UHJsZHprajhBNWJuQUtvYW5rTXFkRHJhbDlnS3lFdEZNdnh5V0RGb0hsUnBp?=
 =?utf-8?B?WXdqZ3RVcnRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUJHR2o2ZHJ4L1JZNWsrckNzb3BIYlpFOWZ1TlZHaUZCQW9paGtOdWxSRkFq?=
 =?utf-8?B?WVdNTGI1NDlVTmVRbXZ4REpkU2FBaEM4MWltM1R0dHVjMS9ySVBweVFHM0dZ?=
 =?utf-8?B?MkZDWmp4YlU3azBJcEI0THdZVDZtTzF3NE5ESGJZbnJML0VHQWNtWitIRW00?=
 =?utf-8?B?RWNYK0ZOd21Yb0ZxQkFqUUxxbmhpK0hrcXBMN2NEeFJEa09Sb21VMTRjZEps?=
 =?utf-8?B?RndFcGVSSG4yc3M5MTloanU5VW14RVJQZytybk8vWkFaZE0rY1FVV3Y3cEk3?=
 =?utf-8?B?TDRVV2NDOVFCRnEzQjRiNy9RUmZRNkx0K0NRYzgweDhBSk13ZTg1UEx3RzZG?=
 =?utf-8?B?UEdGb1ZmbG1EZlVrdkpiNVkzOGJTdndYTzhUeUdiZzJCRExpWlF6cWo1ZlRB?=
 =?utf-8?B?RDhhcTVMMTArd3pFOEx5NjBmNFdIKzZJSUZaMGxjMDJIdjBpdUhDWnVEZ0lx?=
 =?utf-8?B?bzhHbGJCSENiUldmay94S2REb3hxSHhHaDYyZlFuRXQrbktmS01qR01STVZY?=
 =?utf-8?B?N3REcmVlMUs1WWtjWk0wR20rM2lSVmxsTzU5R09nblVOc0RZOW1mZ2s0ajQ5?=
 =?utf-8?B?VEFIL2VIWTNzdDFDclJzYUdmSjl4N1dxQUVUck16L0xtdWxNWnhIcVczd1Vh?=
 =?utf-8?B?UU1wVCt6cHExWk4vaUVRTmJhT3hWUVY4b1RKZjV4d3lTS1RjOEI3QTZuSGhD?=
 =?utf-8?B?ZUFjNTV2citoVnVQcVlXOEVsbi9WQmozZytNVERTNjBteURQYUhVSGpCYlJS?=
 =?utf-8?B?Q3JhWHkzR0RTc29rRE9nclJzLysyQkJTdUZtQnMzMm1rN2pqcHMwUHJEa1hS?=
 =?utf-8?B?Z3B2SFhvelgweGs5ZlFIeU85SzZwWjEvVm1VamJ0RU1aVkRQZHlHU212UnRN?=
 =?utf-8?B?UDdLVUlMNXE2azlQSnNYOE9nd3dMWENsSmw1RVZNVGxKTUlEbEkzRUEweUJB?=
 =?utf-8?B?T2NSbGZlZkcwU1luOUp6YklJVnNBb0xiRTJsMXdObEdLeTh0c1FoL3VpMWZM?=
 =?utf-8?B?d0NBdDZYODNmczBMaTloK0w5WVNodUdubjBvQWJTblY2WlZWTWFkZXNZeVo0?=
 =?utf-8?B?TU1XdnpUZlh6UEVnZmc0TXVHNks2WlVlVmx0eVdVaEsyU0Q1MUpEbWxISEcw?=
 =?utf-8?B?dFU4QzVJTUJFeDNCRUtLWEg3TnJzU3kwWVNPbHY3NjExbjZ0VDFjYTJUNVFM?=
 =?utf-8?B?OTV2eFc2cm5SV0ZRYTJzNndmNFlycjJzSnd2WmZwTWd4SEdEYk5Na3ZXK2tR?=
 =?utf-8?B?Z0ZBdkNkaFFyRDY3Z1Z3UnRSeno1R0pJNjREdzd5RGdrdHJCK0Z6WDdKWEZK?=
 =?utf-8?B?Z1RXWTV0cmlCSGpXTSt0c2I1cUFzN01VekZoMGhOOVFDSmJzMEZHN3lPMkly?=
 =?utf-8?B?WmdYQVkrMkdwellWZ1dSL1VnTXlVOFlwdFVhNE9odjNEVzBrVGJrVU9KRUxX?=
 =?utf-8?B?QWZrOXJnSDEyRXpIYlpsdmhvbys3Mi90Q3VGdVp6RmxsTFNFNUhBNUROc1Mw?=
 =?utf-8?B?eTh0dnhocDZPczVIQktSV3hob2JLdEc4UjBqZ0xnSVBpT1ZmcXowbFg1ZG1m?=
 =?utf-8?B?TUpqL1hZZ01xQnlrRy82TGxtV2N6ZXJXMStPN0drbU44eGxGbnJFTVFBNHFn?=
 =?utf-8?B?TFRTa0UrS2piQWZzQjF1T0ZRRE9jWkRhYVFTQ290SUFTSFNqaXB3VDhXRXFq?=
 =?utf-8?B?MDVYYVU3TERRYTl1UXhsM1dRVUxNN2hxaUkxZUZRT2M2ZU85TWVRZ2EyQmQ1?=
 =?utf-8?B?NGIzK28rVTA3ZVdpaVJPRm0yeWVCa3l1LzlhK2JXbDV3bGdsWk5aN2VoeDd3?=
 =?utf-8?B?VzF2MXJ3dGQyZGdqZmxlSjQxdk5HSVdjdXluNUgvRHdud2kzQ2tpMWZIeHFL?=
 =?utf-8?B?dG90N3JRNm1NYVh6SGhabjhBM0hxWHBYdlBobldOVXozemJQWUlPV1lZbytV?=
 =?utf-8?B?RUZxdmlqclp5cmU0NjRoUWR0L1YrdVJ3Nk80QnoxdUcyUmJoTEJnMkpNbU16?=
 =?utf-8?B?VmovblVsRjRyUzZNekpMblVoOEdUYXJnVDg5WVVzRENibHpGNnVhRzA4TTJS?=
 =?utf-8?B?Y2tlOElmS1BZcytaSkpGZm9taWFlUmFKTzNoazAyNmFlQ1JyVXROY2g3TGtE?=
 =?utf-8?Q?luh22ZpB8SpVWmhs/VcQ6p/UP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CBF1BB53E9CF74DBC48697E49448C6F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75553d6a-60e3-406b-f16d-08ddbdaf06dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 23:35:58.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dA1XfZU/gUh5nmGqZUHV73LEuSD/SFSGcBKpukXaI4naTDGpiij45YJG7//CfozwOfV46le0T/MOfYK9Uzbv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

T24gNy83LzI1IDA4OjU2LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gTW9uLCBKdWwgMDcsIDIw
MjUgYXQgMDU6MjY6NDZQTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPj4gT24gNy83
LzI1IDE2OjI0LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+PiBPbiBNb24sIEp1bCAwNywgMjAyNSBh
dCAwNDoxODozNFBNICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+Pj4gV2UgY291
bGQ6DQo+Pj4+DQo+Pj4+ICAgIEkuCSByZXZlcnQgdGhlIGNoZWNrIGFuZCB0aGUgc3Vic2VxdWVu
dCBmaXh1cC4gIElmIHlvdSByZWFsbHkgd2FudA0KPj4+PiAgICAgICAgICAgIHRvIHVzZSB0aGUg
bnZtZSBhdG9taWNzIHlvdSBhbHJlYWR5IGJldHRlciBwcmF5IGEgbG90IGFueXdheQ0KPj4+PiAJ
IGR1ZSB0byBpc3N1ZSAxKQ0KPj4+PiAgICBJSS4JIGxpbWl0IHRoZSBjaGVjayB0byBtdWx0aS1j
b250cm9sbGVyIHN1YnN5c3RlbXMNCj4+Pj4gICAgSUlJLgkgZG9uJ3QgYWxsb3cgYXRvbWljcyBv
biBjb250cm9sbGVycyB0aGF0IG9ubHkgcmVwb3J0IEFXVVBGIGFuZA0KPj4+PiAgICAJIGxpbWl0
IHN1cHBvcnQgdG8gY29udHJvbGxlcnMgdGhhdCBzdXBwb3J0IHRoYXQgbW9yZSBzYW5lbHkNCj4+
Pj4gCSBkZWZpbmVkIE5BV1VQRg0KPj4+Pg0KPj4+PiBJIGd1ZXNzIGZvciA2LjE2IHdlIGFyZSBs
aW1pdGVkIHRvIEkuIHRvIGJyaW5nIHVzIGJhY2sgdG8gdGhlIHByZXZpb3VzDQo+Pj4+IHN0YXRl
LCBidXQgSSBoYXZlIGEgcmVhbGx5IGJhZCBndXQgZmVlbGluZyBhYm91dCBpdCBnaXZlbiB0aGUg
cmVhbGx5DQo+Pj4+IGJhZCBzcGVjIGxhbmd1YWdlIGFuZCBhIGxvdCBvZiBsb3cgcXVhbGl0eSBO
Vk1lIGltcGxlbWVudGF0aW9ucyB3ZSdyZQ0KPj4+PiBzZWVpbmcgdGhlc2UgZGF5cy4NCj4+PiBJ
IGxpa2Ugb3B0aW9uIElJSS4gVGhlIGNvbnRyb2xlciBzY29wZWQgYXRvbWljIHNpemUgaXMgYnJv
a2VuIGZvciBhbGwNCj4+PiB0aGUgcmVhc29ucyB5b3UgbWVudGlvbmVkLCBzbyBJIHZvdGUgd2Ug
bm90IGJvdGhlciB0cnlpbmcgdG8gbWFrZSBzZW5zZQ0KPj4+IG9mIGl0Lg0KPj4+DQo+PiBBZ3Jl
ZS4gV2UgbWlnaHQgY29uc2lkZXIgSS4gYXMgYSBmaXh1cCBmb3Igc3RhYmxlLCBidXQgc2hvdWxk
IGNvbnRpbnVlDQo+PiB3aXRoIElJSSBnb2luZyBmb3J3YXJkLg0KPiBJIHRoaW5rIHRoZSBOVk1l
IFRXRyBtaWdodCB3YW50IHRvIGNvbnNpZGVyIGFuIEVDTiB0byBkZXByZWNhdGUgb3IgYXQNCj4g
bGVhc3QgcmVjb21tZW5kIGFnYWluc3QgQVVXUEYsIHRvby4NCg0KV2Ugc2hvdWxkIHJlYWxseSBm
aW5kIGEgd2F5IHRvIGZpeCB0aGlzIGluIHRoZSBzcGVjLCBJJ2xsIGJlIGhhcHB5IHRvIGFkZA0K
dGhpcyB0b3BpYyBhbmQgYWdlbmRhIHNvIHdlIGNhbiBkaXNjdXNzIGl0IGF0IGEgbGVuZ3RoLCBi
ZWZvcmUgdGhhdCBoYXBwZW5zDQpvcHRpb24gSUlJIHNlZW1zIHJpZ2h0IHdheSB0byBmaXggaXQu
DQoNCi1jaw0KDQoNCg==
