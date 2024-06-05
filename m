Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2324163
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546037; cv=fail; b=Ee/tu5s0Sp9kO6jAaww2ZmIGKhPyOSMqNWwb1Vg9pPn+tC1sIoWi34ZjO0agmPuSSO0W4gi773fjl38LBBDx6KupAbEsat1WAs8ypundIdXKb00h6TKVfuQag69oEid3XG+nsdWEzRWQ4HqCzenFGOb09QapKcWv9pvy9P4PjoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546037; c=relaxed/simple;
	bh=g1fvCxUjcYWx0Q4iLiOI5X1mD9V7NXqlaKuEbFuiU0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AWw788UhUNGmhZrXBoZzzJkXpI45RfH7Cs2cIrU0p62tYizc+V1rI3CS24OfDgIiy+wjuXqOOFYROXlysl8ozSjZrVNj5TmBDkAGhFLIgutcx4KT91qdZdll+ejUzmczIK4NGl5O6jM5NjXBGDwKmPH0+1M4rMCcwGEbYVdedoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqWBaHni; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqWBaHni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doRTIRE09UvzuPejivfmTAUap/K9sGEjzTiyi7DedMGZ21EGGZvHh3iC5SGCHqrP4FBM7MAF5jEojRutvHlMogOp2RQScb/sfPSAPr0r8ifPCpyr9DKiyF2zxjZmwaDED5hQUi2CaR/I9N/AFfRB2FW/tpHAtU7bVHyEw5zMMenhZ68TX6fp99xckmpmPqQUhPZtJTN77Fi1tCm17C/UsGOexL9VrbJveVS2oiEXbywN8ubCBnmEGEmzr/w/MDHj6eu/4EvrDh7w1sYwxH5OoGOiHeIorYw/2LIiMZGvZN79x9EIXqG/TPkLwQwr35djPq7BAOeA4cph1M+zaG/gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1fvCxUjcYWx0Q4iLiOI5X1mD9V7NXqlaKuEbFuiU0Y=;
 b=be5OIGALuR60Nr0dIYpIAoPJEkLp+uYI71KIyOi3Pspg7XHK/uYUin6m2Mc35+lYasUXj79W96RJnkZEtNuA+hdFNk2cwNgknpZfaL7jSGgCDSOnGc6qDrvYW0itoB+AIJomFYGF6oEv2ldejzThRPN2w75Yhmcm1zUbFSTfR5N2Jjc05ZQrdhusN9K9V9+eHRiSedJPHibIkN3EvEtD8n2eenfmqz6SnTAlF+nz/zhtJaRfZGP8OmaecuIlGGsSz3qB5ZVKtq6e0NFO6EHcwq7gKq5gPKQ3NHJoFte3pnN/AsB+Uwlo9ejIxTMo0GS2I7trykfLDvUeUiWl/1yZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1fvCxUjcYWx0Q4iLiOI5X1mD9V7NXqlaKuEbFuiU0Y=;
 b=UqWBaHniH3dryWy3wtw3IUu6ZvoOAAIY05lKMkr9jaHaiVW4qDj2ivjUYyLplHPRlbvvmPRRfB+vyQfy6K/ouwUlie5UM5424qUZaaB2aKT0QLqXn+x+T99xo91pN+cnmnd6t7YHad23OMid+aJg9uo5Epp79LDXrGJeFN1C3BSwDt07PgaR4C4jG4VHupxDiT2ZMN7GHA2TwyoC6MUiQ6I/mmBv1ZFFz2WzmMnBaMl+fdjQ8GtPDrJHsCXbcn5D+mos8hpmZNoXqQeBTHz163HlYayBtPpWWwi4rISM3a7+LuoydtL7HwieNH7Kxs3HFCg6vflN2tE/CottdFbFYg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 00:07:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 00:07:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3] nbd: Remove __force casts
Thread-Topic: [PATCH v3] nbd: Remove __force casts
Thread-Index: AQHatszXFCd+qCHZAEWU+nodlIzW+rG4SwcA
Date: Wed, 5 Jun 2024 00:07:12 +0000
Message-ID: <6f04b95f-7b12-486d-b56c-414114f96c51@nvidia.com>
References: <20240604221531.327131-1-bvanassche@acm.org>
In-Reply-To: <20240604221531.327131-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8513:EE_
x-ms-office365-filtering-correlation-id: c38c4b70-6d48-48cd-a79f-08dc84f3736d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUR6cWJLb0wrY0ZJQk9Oc3NaQzlVT1NBUmNkUlRvdDI3SDB3cGtMUk5yM3FP?=
 =?utf-8?B?R3ZoK2JKNUtjZmtiaDBjUVdqYkJnQjRTZU1RWXowa3NwWUNFdXYvQTNIK2VQ?=
 =?utf-8?B?bkR0MXNMRldpQ0ZUQ2IxUTNKVi9aTGtlWmpYU05ydlVJakNQakFsK29BQk15?=
 =?utf-8?B?dU5JWS9NSDJoVmtSQWd3OTZ0WVBETS9VSnU3Mi9SejlIb0FjTkFnTXdUY0NB?=
 =?utf-8?B?UFVvT2psdnlFc29qQjhpazg3TXZHNXU0RjJPbXhjT0Z4cmFKTzdQUGladkh6?=
 =?utf-8?B?eDgwV0VtUnVUUGVjVWRKS0ZIaERtaVQxcjRoSHpZVjdHT0wvcjJ4N3pkQkJo?=
 =?utf-8?B?MXo1UTlST28zT0szUmk5TjNobGRzVy96MkxLNnJuMk5naVBQUXNCQlNva3I0?=
 =?utf-8?B?cUg1TENzSkpXaTRVcFFCclZvWXQxQjJCWDJPMWp6OFJENE5ROVE0N2Vtbmov?=
 =?utf-8?B?UXJWS0dmTHZnbUo2YTFHMFp2RUYxMFhWQmtMck1oeUZXSjhsWkNwcmJTTEtx?=
 =?utf-8?B?VHg1UWZYWXRhY3M0bFJ1N2ZpQVZ2TlVnMlVHcTFKc0hlNncyemtVS3RoM1Z1?=
 =?utf-8?B?eG53bGdYVW9sTklQTFpMcGZuY1FmNndUTHFONzQyaEJvY2NOZGgrNi9JaCtw?=
 =?utf-8?B?bTBBZEVTSWRVWGVsTjJIMjBQN3pOUVQ2UURvWnM1dDdlTjFnYjB2azJXNmdI?=
 =?utf-8?B?dnFNc3Q2S2NCdUN4MHhJY3FxSDNYZ1MxVEtOY1RzTEtUeUhiZ05aUk1JSTFi?=
 =?utf-8?B?NGY3dUhUejhmdHZyUVVaTTlqZVRySDBNMHlpV0RwM0RpV29WUy83TVBPczlx?=
 =?utf-8?B?Tm9Jcjg4R3kvSUtRSzJLOEJMdWo5V3FaRW1JZEV5ejVtQVZvMzlnT3ZEZnA3?=
 =?utf-8?B?ZTdGTUdpK2ZwNVBGb3JPZWhjNS92b3p4anFmQXFxSG1ma0src2Q5MHU2VVRB?=
 =?utf-8?B?b2FwOSt1bSt5MGVLRWNxVEZPcXIxMHUzNmltUFFEbXhvd050NnFTdzB2bnhZ?=
 =?utf-8?B?VlBMVEM1VWs4azdETHFodDJESTBMVUlBYzd0VkZ6ZHZCeVdCZzlxbDFrcWVh?=
 =?utf-8?B?bVQ0V1ZjTk43blhKZ2t6emtLZFNzaWFWNHNUeGo1RzZEbXlGR2VHdWNJSkFm?=
 =?utf-8?B?dEtUTm1ldzFDcVJ6WkRmaGdrQ0lVcXRtV0JwbUl0dkpSUEMwVk1Vc0VyR0xR?=
 =?utf-8?B?OTN4UjlFcVV0WVNnZEMyS1l1QzM4MGxQSWdlRDRBNXlzckxqUklzSnEyWjVO?=
 =?utf-8?B?SEJ4c2xra2dpTmZITy9IeTNWbk5vNmkyRmRjVk5lQ21mVUJCWnF5aVdTRnpR?=
 =?utf-8?B?WTZjc2gxbitJRW1SRmk0akI5MENYenNDWXUzVFN3UjV5WlBXWTJxNG8wZTU0?=
 =?utf-8?B?aU1WUCtKZ3lPcERkUEQxQ3h0cU1TaXJHZzhtNzhGdGd3SllMWWR4bjVRRWhh?=
 =?utf-8?B?UHFvY3VFamNacG52N0p1SlVmZnZDK1FoTnNGV2llQTRTNGNlNUFVeEc2Vm9v?=
 =?utf-8?B?bTdyTHVmQ0V2ek50SVVQWGdSUGlhKzYvRDJTYnRldHByZFNLU0FWaDNFbE9W?=
 =?utf-8?B?c2dvb2dOUGcyVGxxQ2orRFVvZ0RoU2dtTTJrNFBsdVdpa1praUdaUlI2bjgx?=
 =?utf-8?B?cWRsWXh5aGtpb2EreG5JUVBrNThqeFJBZ1hwYitud092MldaUnZXL1pEc1JR?=
 =?utf-8?B?aWpiQzBkN1ZyYWtXakxjcFRtSnhwUzZ0VzZBWlZLYkloaHZlSlBpU2srcFRv?=
 =?utf-8?B?SXVJbG83aHh0TjVTU2c2Z0NBQjlwNmZQUnJlbzdXUWcrQVlrSXBvYjQ5cjFY?=
 =?utf-8?B?WCtZT3Zaa1FqNWx6MHhGZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2JWaVNUOHY1QzJNdXZHOW9CZ3lkaExVSXVMenBzY2dIOWI5U084MkZHcStj?=
 =?utf-8?B?OE9STTRFQ1dmLzhQWkJxQTdPRTlvcG9zZTRzUW1jNENERWVjcklZbzcyY3lC?=
 =?utf-8?B?R2JhU3hGVnZVd0hXVnE1NGpMa1JHMEdPYVJva0RpV05UaW9pVTg1bWZtUVNS?=
 =?utf-8?B?RFI5S3VwMGFZbnF3ZEdZbHp2TGZSVENtYUtWQVhoNW1McTRvU0lQRzRrOHZh?=
 =?utf-8?B?MnhMTHhXYWZMaWVJK3BCVlNnazM5by9zUFFmN2tVYitjNklXZ1lpYVQ4Z1pB?=
 =?utf-8?B?NjRtZENXQVh2WFpXZzQrSFJvVFZ3M01KSkFKT3VMNkYwNStYWThYRzBNMUxk?=
 =?utf-8?B?aGxueEw2QW4rRFFDcUdBam1nVit1d25YZ0FaY0kvQzJUeE0xaThsRDV1UkMv?=
 =?utf-8?B?cm5NRldoaWkweUs0SWxWUHQ2OVhieHJWSDBsMlZrWHdGWjUyd1RJMit5UXBM?=
 =?utf-8?B?b1JWSjBlWC9EMHVvZHJnZnZNTU1yOXhNRXRLK0F5RGpVbCtHSEdyS2RrSGdB?=
 =?utf-8?B?bFVTVEt2WkpjUTBMMlJqVVNCV212TzdHVkRKZEdvRUJDbXpvMlc3Ynk3NDc0?=
 =?utf-8?B?VUhkeXIxZGFuQ3FYeTZRNTl6dU1UYXh3U0lIaVkwSzJKeTN0dThMMm9Ka2RU?=
 =?utf-8?B?TE11VFdYTW90RGVIbjAzc3YxaFQ0YWt2a0dsVWVGajd4NDhLVncxdzhvakY2?=
 =?utf-8?B?Vnl1WnpUSWZlc2tBbEhqMXBSN1YrMkJoZHRmRGRGN1FxejZ3RFZKYjlHMnlk?=
 =?utf-8?B?Q094MVliYURkQlNLK2NsY2M4Q3BDUFd6SlFpZHhZb2lpY2srcFVEUnJ1RkQw?=
 =?utf-8?B?R3UrOVJ2ZFFlN0lGZjVqTHpLWnNHU0xDWWdVaFZaaFFZR0I1QmN2QnFBeGpw?=
 =?utf-8?B?ZzgwRHRHVWdLQjRleTFweEpLZS9MVVVVMjlMbzg3bXdYdVFUNThIbzRPaFFH?=
 =?utf-8?B?YUpuY1d5MWRzR2dlOVVoZGdjbnoyU1pPUi9Fa3JFUFJDTldsSnFjQkJjZnFh?=
 =?utf-8?B?NlkvQU53eVpqTDVMQUJ2aEIzdlpWZ1NlODVCWXd5VExuRFlEUGdpTnhhRllS?=
 =?utf-8?B?Mk5YWU93Z21mYXdVenQ3eVgwcW1VOStXZXE0azJvZ1JUeG8rc3IzbytGZ2tu?=
 =?utf-8?B?ZkE3S2RDTndTM1pSNEdWUE5jcXE5Z1lmNStNQ1BIN3dyNkdSVmJxcHFNRWw5?=
 =?utf-8?B?TkFDQ0JKRFRveXA1WHc4azh5NHBUR1VDZWNiQmdMZHN4YVYvZ0lLZUxmOTdF?=
 =?utf-8?B?REZ4bkFOQ2hVc1kwZUd5cXM4SE9OT2pZUFVkazVvZmFtazVzbURiZ2MzLzhk?=
 =?utf-8?B?Y1ZyWlYrU05mS3BIOGV2Q2xZWUxDWGhIKy95MkloZkhxcTErZU9ldWJkbUhy?=
 =?utf-8?B?SEpFK2NIZVhRS0p4VkJqKzlIajdrdXNIY3dZalRzMllwV2RuZVZLYmJZTWk3?=
 =?utf-8?B?WktwMEF3WkZzSnIvTGk5U0FiS08xalc4bFZha2V0Z0NMODJPY09nT2VjM1di?=
 =?utf-8?B?WGl3OFpvckZTaGJSMm9VSnlBVEJTa2RRR3A5bUdZM2J3RTh3Y0hEUy8vL3Fu?=
 =?utf-8?B?M01NNzRLNi9EME5LRm82T1Vjb3RSNmdJZmNpVm5IQU93bHJ6RnhiMnZ3dmwr?=
 =?utf-8?B?bDdjNStPUFp5RWdvNG10c3E0SkJ4WUcxSzJqUDZOeFJqYmlzQTh2ZUV4RjEv?=
 =?utf-8?B?ZDFCMktXTTdnc3p2MmNIb1hySk9UTUY0WDYyR0doYU1RTGNZaDd0ME1vL3BJ?=
 =?utf-8?B?MkV5N25IY2FqUVRReU54Z216U2poLzR1Vm1icXEyNWtMbm8rUFZnMTJlYy96?=
 =?utf-8?B?T1Z0bUwydUNhaU9KZ3d3SWNsLzRPeG5aVnpQT201VWdLYVFNMGU0Z2piVk5x?=
 =?utf-8?B?RFZLekt5d2NsSDFKeGRMVUhIMXNINVQzUHcyU2JZOGpuR2dKbmMwUEViZ3Zp?=
 =?utf-8?B?c1JpVXRwbytoby9HQVY0UFlNbUR5d3JHbEhrT05VVVVURHd5RmFhQldTNW9U?=
 =?utf-8?B?ejBFbFZZcCtDNWprQTg4NXYvaUt4dUswNHFNd3JaZmEvejJrb1JUMUVFbXNF?=
 =?utf-8?B?cGFNcW8ydHZlYUl1RDFKWE9veW5oSVhidytoUllmTElVeWhPd3R4bTFmYjlB?=
 =?utf-8?B?Z0lMcDAwN203TE4waDZiMVhhbDZxRENoU1czeTVhcjdiMTFEMUtpVllhcjBx?=
 =?utf-8?Q?gycFSNIByvkeFjRTESGMFQa2DQwDEZlYRbdBhckQlSSf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DF8CE64356F54596699A32D7B1E3A4@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c38c4b70-6d48-48cd-a79f-08dc84f3736d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 00:07:12.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: samS025BG0PrSUfLiqFjdbVT+vcO1/nr21LChB8svKGGD9eMbmDZd7rTVT9hPpuVcfBR1f5nZ8YhlAZJSc81kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

T24gNi80LzI0IDE1OjE1LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IEZyb206IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPg0KPiBNYWtlIGl0IGFnYWluIHBvc3NpYmxlIGZvciBz
cGFyc2UgdG8gdmVyaWZ5IHRoYXQgYmxrX3N0YXR1c190IGFuZCBVbml4DQo+IGVycm9yIGNvZGVz
IGFyZSB1c2VkIGluIHRoZSBwcm9wZXIgY29udGV4dCBieSBtYWtpbmcgbmJkX3NlbmRfY21kKCkN
Cj4gcmV0dXJuIGEgYmxrX3N0YXR1c190IGluc3RlYWQgb2YgYW4gaW50ZWdlci4NCj4NCj4gTm8g
ZnVuY3Rpb25hbGl0eSBoYXMgYmVlbiBjaGFuZ2VkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gWyBidmFuYXNzY2hlOiBhZGRlZCBkZXNjcmlw
dGlvbiBhbmQgbWFkZSB0d28gc21hbGwgZm9ybWF0dGluZyBjaGFuZ2VzIF0NCj4gU2lnbmVkLW9m
Zi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IC0tLQ0KPg0KDQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=
