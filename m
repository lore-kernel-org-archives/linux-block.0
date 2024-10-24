Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6ECAD58
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729730535; cv=fail; b=ZcJUXJvuvjmDJI+Pir+NvSvD/cHakg6gRjjIxYDlzcHgIb+lnYSKCX1+ZgCNHQQUcIKKnMt+cDo5cvHN9wclT0tCImxjVliOuOPtJ7se9vbyE1paZE2+PPuipY4SiMjCPivtkp3TgfCcFfQ3Vb3x6/wR5A/65eyhnnskYP/u0Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729730535; c=relaxed/simple;
	bh=qANMLhCjLC1b2ZAPOz5dNEVtBw2zLbC2UtVNRbSwHrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKxemEi9jEXSK6sFPLwzjubfpOfaiqrNQW+0ksK2qSDRNIHK3hoQCCDletuzyP1pP4D+2irEcOnS/ikLKtK3kJNO8L2yOjgS2Cxwhy61B9gfBVI0qdJuwD5rTJIdakIxuPOhX16H+G6IURQgPZs+x7aSZzQpCrDYv0CzjfXjfA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJHrdAbW; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJHrdAbW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjHkoDs4AHBgOrg1E0xBxJgTnCP4l3eZsrZUdhpfrcOc0SGTntQZB4qV406Fqrx+nAZbIksMT7IUErVn67/AkYwWFdz/cINtaJfRUxMo6JXdvRiVEGN1UAONIgJ0sGEjlYTzDwh8v3toPbuERD01ub301j67Ql0jgocIq2PeaKsnGlQ0kk63BPt52u0XR7/PjXsLqXqmXrjBkRZfjwxsod/U5PPDq0btRwYfklOos0iBbVfw5bvNKyVrJRMYclIRGynGD0O/1mdtrfOAqLA8imyUbPbgGFqz+ab7Yt3wLGmjC/Lbg4/UWkUBAlUUCHXflqlLrcDZQTT0fpQtCa2mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qANMLhCjLC1b2ZAPOz5dNEVtBw2zLbC2UtVNRbSwHrE=;
 b=Rb8BJo0WO4fN07wmg/WdzWjstoTcYkw/6RZ9JIUOaOfVzM1IWQtUNAyj2mwcTGDxxBkHCXRU7Jn0Ur8HA/ssktxe5haFvqWRZznmNTx7niDdGjdbw2MTpHV6dIBX0cY3COcO3FSzW3vwnI7zCu8Jpp++Uha4CLw2vJpy6YonoTvt8i3YdvNs3k4M8Fahna1rSHE9zSBbLCXRvT/Mi8HSnGc15JYnICxexsdXmBq26FOsPUmZ266xgDl/Ey+csIhDsIP/sxDFA6M+sjEBr5S0UUnYM7Jdzbg1iKOcB9rVFqq7jnNWLbxQd0r02pwJNQ8BHCf66RtMlFxlOsTwQ5z/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qANMLhCjLC1b2ZAPOz5dNEVtBw2zLbC2UtVNRbSwHrE=;
 b=XJHrdAbW7bml7/sw4Jkms7t2mlFZviCZs7aOeB1FdKzpWbaBpw/OjKarX1hZhhOy08d2ovCR9dNMyDor3i98pV+9jr84VPNg66HQyBC/fA1MUDIO8eK3lE5j9shTMDYDx4oKTOiqhrRsTyMRpb1iq7g+b8DKYjHqhBSYnFk/9MCDa7br9eHiVAsBYbr7JeU/rtO/Ic6yOrYKsecTrZIYzqNsQvicTwutQOSMewNertsPuTgpcVh8HXFySdixkcwaWjrIE3caCTWVsXs0YWuWtOSNO84kGxwTxRScW+s7omvphlmwHvzUc3CgZIKnGKgN2UF1T9aXBT3WzpXQnjTJvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 00:42:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 00:42:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Uday Shankar
	<ushankar@purestorage.com>, Jens Axboe <axboe@kernel.dk>, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig
	<hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Xinyu Zhang
	<xizhang@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Thread-Topic: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Thread-Index: AQHbJZDFy0x7+z7HT0+FClGrt3SmjLKU8NaAgAAA9QCAAB4vAA==
Date: Thu, 24 Oct 2024 00:42:09 +0000
Message-ID: <bac29f65-b07a-4389-beeb-2b8cf54d1f13@nvidia.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
 <Zxl9wS2j5mUkye9o@dev-ushankar.dev.purestorage.com>
 <04c6aca4-5960-4fe0-91e6-d5eab71b8703@acm.org>
In-Reply-To: <04c6aca4-5960-4fe0-91e6-d5eab71b8703@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB8053:EE_
x-ms-office365-filtering-correlation-id: 5a7706b1-776e-4686-7508-08dcf3c4b128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnkzb0tKU1hlQlk0U25lRzhJRldPcVZzaVFPUnNEbWpETWN2TnF3UG5LUEEy?=
 =?utf-8?B?Z092RDRuL1JRU1FKcUhlQ2RITmsrQkdoWWVlU2xIQTB1TFFleWRLMExleXlR?=
 =?utf-8?B?bisvUVhzbzF3dENBSXo0Q2t0SFF1UjNhN3g5blhDbTJZMXZPNG5uVFhuWk5Q?=
 =?utf-8?B?ZC9NYjJzay9OQUlHK25uUTV0dFZKOSswNVJQck05TUVvRlFLUkZYNi8vWEt0?=
 =?utf-8?B?Z1FuVTJxaVZBakJTLzk5cVRXMzJyc3JSU1FhYVdEeDVFQUlmemZndjRDWi9U?=
 =?utf-8?B?Wkd6NllRVm5HSHdWY3BJUFFsUG5yRWNRaDJEOTJqSFdXV1E2WmJFRjNKWVE0?=
 =?utf-8?B?T2IzazhIZnFFZFVUMUhtUDVlNjBOR2lCQmdJVGRVRisyQUo3UzZDQytreHht?=
 =?utf-8?B?REROT2FYVWo3T0F5cEhCZ2VkVWhHSEk4SlBrc2NiQkNyd0JLVWo5R0d3cFE0?=
 =?utf-8?B?TVhhdUJZREgyV1pkWjd3MldTMWdBWXJWRytjS0h2Zm50K040SHNFNjdxYjBv?=
 =?utf-8?B?RUNlc29mQTlkVWYrOXNHM1pKZ2F4eDFJRHVYb280bmtkR1J3T3QxTkw3TWVw?=
 =?utf-8?B?bUFiTmQ5Y1FwY2NrbzErakZnUTNIaUJ6anpTYmQ1WURHUFRjUVhqTWhqV2tV?=
 =?utf-8?B?WDBwK1VDUHdpR3NCRHJIVTZnV3dLRmRkOS9jbHR6SWdpWmVwN1pWVlNDMTRl?=
 =?utf-8?B?ZXlsZjJua0tBaWFQdC9QR3QzRWs3VkkwSjdNcUZnSGF3VDc5bmVnYlZQbXhk?=
 =?utf-8?B?Nk9CQkQ0Wmk2cFZTSzA3dGFBYm15YStVSkhFYWU0OE42MURPY09KQ0tYL3hD?=
 =?utf-8?B?WW1kOG9OdmpLOUdlbTR4TFc0amdLcXdpS0dQZEdxK3pNWXRLNkVCSzVtT0Y3?=
 =?utf-8?B?NjZJQStoYVl6RFRocFB1dWppVTlrSXh4NTRHNi9pK3JXOWJNSXdDbExBUFBM?=
 =?utf-8?B?NHc0cHVFSFFZcHZNVm1uNVRSaVU2S2IybUxHSXBRSlRCcXY5eU0zblFhcGpy?=
 =?utf-8?B?UnhVaG1LRUdLN3AyM3llOFJWNGs4SHkwZXJuelRaeWlnam5xdStETFh5U0gy?=
 =?utf-8?B?dGxLbS9RdVU0eEV0M3dILzFJQWZOcFk3bTBsOHcrazYvdDhzb3BRaE8yN1Jh?=
 =?utf-8?B?ajg3bFhUc29Ka0hrSjFPL3RYWkVtM0RRVjZadWJlZzZyRDRSc1FWeTg5STY3?=
 =?utf-8?B?R1BJbndBZ2t6TCtOQTRTU0gzMlRKM0lTNTZTU3VESDV0WUQxcWZhVEFSWkxL?=
 =?utf-8?B?NE0rT0lZRklGSkI0NkFMQnM2WWVETzExVjNPNWlDMlRVeWdyNzU4MGRoOVpC?=
 =?utf-8?B?ejUwSWtBVjVXQnB4RURwZ1RBMkp6dlhFRjJjcHVlN1EwTEdwSmdmcjVCT09E?=
 =?utf-8?B?SmdIa1F4TzB5ZTFXSWQwMEJjanZGY2pBYXVBTzVFRFZEcCt1bnN4RmU1UFNv?=
 =?utf-8?B?dG9DdHhiVW9OQ1B1YWlBcXRYZ2tucHJvK09xd1JXWjJCTjZJUFBDMXhsdXc0?=
 =?utf-8?B?TnVtMi9zQWdBYkxWZGRZMHdoQ1NVT1AzcjZxZ2ZzUUo2MGthS1ZHT21WZEgy?=
 =?utf-8?B?bHB3K1RjSW04NU9lOVZVYVZYYTZsK0lTQjI4WE9xUVJQcUhoWk5IS3E2bWNI?=
 =?utf-8?B?RUo1MWFwdGF5b2F4U2xMZkU4Vy9KZWFWRG5MK1NLWGcwdDZ6MUdSRzJhQWcr?=
 =?utf-8?B?YXdMNDlpSFJlSkZOZ1NsWGFjeE1PT21nK09sL3NSWkVGS3hqbjN6STdLc3Z2?=
 =?utf-8?B?MG1nZSt4Y0c3T0FnNDQ0am5WUldlRVkrYlVhcmx5MXhiZUNyVndialB0eUo0?=
 =?utf-8?B?eG4ydGhlbTFUTWFQZk9kUk5JM2FXU3Q5VlYrN2szVEZJNTkzdWE2SkRINUVk?=
 =?utf-8?Q?SELf80Z3TCyUI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0ZRYUNEWkFXdG9DRXlMcDl4N3lyUWtTSy84bFQxTElMbHRsUkJlc1dERVJ3?=
 =?utf-8?B?VHExN1B0eW5MMmpLZ0pVWjNIYzBhaS9xeDdDUUhaMHRJcTBtOWtxR0R4ZGFH?=
 =?utf-8?B?cm1MVDRGODFKa3hrS2k1ekV2bUxGR00yRlBiUjByMTJlSG5KN3hyTkpDaWZJ?=
 =?utf-8?B?Zit6WSsrMmZpV1BPc3RoL1RLOW1vRi9Zc0pxbUp6M3ZsZnJrNEtNS1I0QS9Q?=
 =?utf-8?B?YUZHeGpZV0JzR00va1FURjhsT0FUeFFFNE1tWFRRZ1VkNlI5bDFEZzhxYUlm?=
 =?utf-8?B?NUhmS0lyWGpSakFtYis3MGtjaUNBVW5ZTDQ4WEErRFRVUTRMMzNHbGcvTCtm?=
 =?utf-8?B?cHV0ZFEzRU5RaE1KZVlJbkFXR0JYWFBueWN4N3VleFFScWoxNWJ5dzhSc2dy?=
 =?utf-8?B?dWl6c2U2Nnh0WXVmV2FLZnVnZGVlcklTZVpubzZKUUNOM1k2NUpnVE12c0RB?=
 =?utf-8?B?dTdJSGFvbzVQUGg3UmorWjBEVkdiNjlqR290enNGdFpKd1M3Z0pXMHdLVGcr?=
 =?utf-8?B?VFV6ektKR0ZTMDFFQ2Rvd3VIRWYwRVFoVDJLZ3pzU2xMMFkzeEg1UloyZFJ0?=
 =?utf-8?B?RlVpZkRsMHVvR0poMnRGaUFMb3F4QzcrVEluY25TcGoreG8yNlRDRmt5R3dw?=
 =?utf-8?B?Z3lSK3BsdTliSU1wTXNGQkxjcnE4SXA3Y3RWNW1oaDlVeTBpbHFuNVBLLzBw?=
 =?utf-8?B?aFVBRytiaWpBdmpSQndFTzJYZ3NSRWU5bjFTdFE1V2l3Uko2MFNVSWo3TFdM?=
 =?utf-8?B?RnEwMmFZaThseTEzcW9IZENpWXJzU1UvTG92NUM4Z2hVZUczMU5NNHlTMzdq?=
 =?utf-8?B?MkhkUjF5MndWMldQWm8wWDcwQTJLYmFFY1FaZHp2Y3J6Q3lLQk1FYkovUU04?=
 =?utf-8?B?SVFadGhvY2E2UVBEdE83Z3N6c2JhZnFwaC9qMDV5VE81SE9DRzhsSnd5SHVx?=
 =?utf-8?B?cE1odUN0S0JWZXdJUjlkWW5td1lSSzhpaU9hZHJtenhiS1U2cVpiWGRyZms3?=
 =?utf-8?B?YzYxWmhOVlZjMWJKWnFabHdzcVlESU5aSWl6djNXSmxmVGJMYVMzRGdLbEE5?=
 =?utf-8?B?bHBTdUtEYStMbGlTYXV6blFKamJzNUZFbTVCQ2lIMmhNL3JwbS9ycnNHU3dY?=
 =?utf-8?B?OHZvbVI2VUhBTzBMc1kxSmxjY3hlQVdJeFJGNGEzWHEvL0V1SVdxdk5qL1Y0?=
 =?utf-8?B?MW91aW1mOG80L3NaS1JlN2RLYkJYL0tNTkUwaVQ4MFdmL3hEeXVGT3lkam1M?=
 =?utf-8?B?bko1aFZLb0JkdTczWk1LaDJBRmpwa3QzZFpxL0llaCs5bWtQd1hyek8xYVIy?=
 =?utf-8?B?SDMrd3RidG1UUXNPTUdxZFBkRys4RnVlWTh4SVpDdG9GRWNzcXVwMkVSN2Ro?=
 =?utf-8?B?TUVXV3ZlTkpQeERHM2ZGdEsrU2w2K3ViSFUxdHUyQ2t3Y3dyWTUyVXN2cFRj?=
 =?utf-8?B?RmMrMnBaY3prNHhYeVRYOXdqRndHSTBqRXR6ZHBUNzQrZDBjb3dkNHh0K2Ny?=
 =?utf-8?B?Y2NENmNnMjcvdDdDcUFrREl5b2xoa3NYaVNoVG8rS25UMUdKcXoxSENsYXF3?=
 =?utf-8?B?V0xXR1VJSUNIUTNpeHFnWmVDTThrRXpoTm5LRS9aTHE5M21kQlB0ZDlwakxE?=
 =?utf-8?B?N2d2OGVsZ2VUeFJHMHpxOTZmRWZoS2dxdG8rZ0Zab3QvWU14a1paRTFCL0l0?=
 =?utf-8?B?aG1RdFZhR3c1b3NZUVJTVjRFZ1VKWmtHeEVQSkg1T29tbTVDWkRZQ2p5WFpv?=
 =?utf-8?B?a05zcHlzR1lNd3k5a01uVFJzTWRMN21PSk8wdFBWVzJVT29xTDdOdXdZbnZq?=
 =?utf-8?B?U0dsVFo5Tkxwd0xveXVtWlowRjg2S1JvQXNXOTVUdWNyUk1acmpteDVMRHNl?=
 =?utf-8?B?R09kUk1uTmc0aEtrYjRRQnczdVplWmRGSXhoM2QrT1BHSFFZTWlvZHR4Z2ZY?=
 =?utf-8?B?em1jbE9nUUZtcDJmcldBemwyL2lqY2ZLVytUaEVjWHd1SDVGK3JJZWMvRzdu?=
 =?utf-8?B?czRCM2JNYjBQSVJxNnFiYmFscm9IRzBqYXM2ZTFsQVUyQTdVeVFNZjJtK0Q4?=
 =?utf-8?B?em9HK0hWQ2orbm1Ycm9JNW1STHhHVmEwcWRhOU1oRzZnOS8wT3BVazY4c0xj?=
 =?utf-8?B?Y2RmSloyZ0djcEJyT09JVzlOS3pFMVZoTklWMjR0YUR0bnhQRzVKYWhRVmht?=
 =?utf-8?Q?ydjsAJya8TAVUq+kNiE9bi006OFXm8/ZSt8+mnnnjVoA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7797C4D32D6FB0428F63CD0533D2932C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7706b1-776e-4686-7508-08dcf3c4b128
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 00:42:09.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBYEI75dawFp22wTGhnYaynbWSiFEnzi/E43PLHLnpqrIGoOhNbVVP3+ZjGAPCiT4M+h6ltovVVe8lS+ZTJqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

DQo+IFBsZWFzZSBjb252ZXJ0IHRoZSBhYm92ZSBjb2RlIGludG8gYSBibGt0ZXN0cyBwdWxsIHJl
cXVlc3QuIFNlZSBhbHNvDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rlc3RzLg0K
Pg0KPiBUaGFua3MsDQo+DQo+IEJhcnQuDQo+DQoNCisxIGl0IHdpbGwgYmUgcmVhbGx5IHVzZWZ1
bCBnZXQgdGhpcyB0ZXN0ZWQgb24gcmVndWxhcmx5IC4uLg0KDQotY2sNCg0K
