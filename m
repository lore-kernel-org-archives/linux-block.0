Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF8241CA2
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969143; cv=fail; b=lXoxHUoQTMlgzjodUwzJ6HwdvA85aaCdNVxGpWvm+tzrqe6rBa2BSUrW2HD/WKAuIGyKktf19tSJSslyCqmLNwOyUZvVscXqvxlChji/QYgD701I3aWyp7/iC2Qu9ENSdZpqcNV7QuqpaDYdiyOapVM9M2pvcy8yarOanN0ZgNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969143; c=relaxed/simple;
	bh=jX1G+uh0k6xAD6fsbwd1pBTIq0wsR7OO7zjh97dbvIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0skfM9uZgxb/KtBNLkbraoVkkRQIddSEbqUhXUYRdyTeJkWS30I5Wch98jiBdPcMKJeYO6BJIpmwLJJS8ATgtR0wwa+watGmw/f171Fgj5/VuYxF5juQBIHf+y5Zg0fKju88M52gAfpM13qYvJ4GYapeg+iXWR9CL48F7fbnAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZoJa15O; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZoJa15O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WORqedKSLDi79ODQJkly4T4Vy/Z1hPHUt50UJf8BRhZn40dWnkDnM9oGSuNHmeOAJ78smCuVtEHLAoiuVGZlLlJotZzoWna4e3g4ALkFsAjnsawFs1FQ4vwjgja77Y+mHmlpW1SOnDoY8yF++ieoaHMjd6LIk0a28UCYzgpXic5cHbKcNnOQHiNTi2zidQ2tU0PiV0uAVWQ/AtBLutdLxagU9LQDQTcrvdBzdJWnM7KCXQNuK/a7DSu0mMvZqKlpJIBm26OJO/iclMJADFOu67lSuxsN70ljJJ16zVlzvLFv7WHWsNvA0+57X86tlOcqZ96e+Sd14w+V3s/d+Sf1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX1G+uh0k6xAD6fsbwd1pBTIq0wsR7OO7zjh97dbvIc=;
 b=lG4wT17pg0DHwgpsBRd7Kp+yeXf7c+PMAMSFs0l4Y4Uig5zsfA9GljUvY9FOe8NcfXgTrJn9W1/T+NkAqJ+a3WZuGxufglgmH1H/mfMb0TxeT80PrTYZ1E2zeGvefrqTmubC+seTWJRtIdzhfjojiuPHacR+dS32BczlRYy7rtdOqqXF88vAkQDpKi3N4LKil1lzNwGIajhPOut2LNqZsIaF+zzUHE2gYol5Zg6pOLuuxeJqgFL9SIU5TjhD72rykPU+M2JDWEEiAfegwh4oYJCMBWvaR6GwOXfaVcwE6e8ek3eqHSxnBUwMi3P6pSpqgjG7AfnWKtKpFz/jEQkBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX1G+uh0k6xAD6fsbwd1pBTIq0wsR7OO7zjh97dbvIc=;
 b=DZoJa15OrYVtVIvc9JaRvuqwlWZMmP6neJRFbO6XK1hCrrgIyx+g1rq3oeqzXx6eF4TWUKnOTiRSkTGOb1LvQSZYo8EV7bi1G/I9CjjYXKgsZvEx1hUPu1plY0u4Ru1yI6UjGli6AJJb2Swmoz6PSlSTMcZ8mFXYwuWQOudNiTZZMan+JglmcmrlXjdPZkCGJcOhR9iWSfii8Ua8qvnhfj3/eWBFoPmXLMi5ZAAucqadpCoqnJpNES1UFLbkPypTG5b91ot47R7HQdQ21/ghm+s/wMgKS4mewr+SSX6qZrpE1GGbG0Goyh5Xs/3s5cj940cjzWKkmJ1LJ6JldQojzQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 17:38:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 17:38:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "johannes.thumshirn@wdc.com"
	<johannes.thumshirn@wdc.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] null_blk: fix zone read length beyond write pointer
Thread-Topic: [PATCH] null_blk: fix zone read length beyond write pointer
Thread-Index: AQHcU/p50apJs3tq10iE31Dt60VidrTvTnkA
Date: Wed, 12 Nov 2025 17:38:54 +0000
Message-ID: <c960d4eb-b660-4506-965a-c5170ca08246@nvidia.com>
References: <20251112164218.816774-1-kbusch@meta.com>
In-Reply-To: <20251112164218.816774-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7621:EE_
x-ms-office365-filtering-correlation-id: 7184c4a5-6a8b-4537-b940-08de221259e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a09LdXRqN2IreS85b1RHR05pQlJJbkE4YjhaOHo4YnFINFpLb1ZLdFd0ODRD?=
 =?utf-8?B?SW9WTnFLTzJNRlhwd2ZZSS80L0xrYzIvcFZ4VTB2M1ZLTHpxWTBqOG8rcXZy?=
 =?utf-8?B?MWdUUEgwekdpS1NQQkR3aDlpdEJNdWhlV2tOMWxoaEFEdkpYSmtaenJlS1JE?=
 =?utf-8?B?eDFmYXdPU01ubmdtSXgxTWc4aXVnQzY4TVpseFNOL1dXWER1ak5ZTWY1N3Bi?=
 =?utf-8?B?T1J5RnRqMkNoQmdtLzRIOG1KNkNjL1N2WFdsRXpRK3RaWmU5YlM0SHVUaHVU?=
 =?utf-8?B?cjhNS0h1WEV2NFZhUmNUR1VuTzh0dStEY2RGOWxzSVNSWFhVNkdmQ3VjZVdt?=
 =?utf-8?B?eTJIVElkV2Y3bFhucVRJK2N1YUh4eGVta3B3TEQrNHMvSkdSaTBrNU9MSmg2?=
 =?utf-8?B?OHFmdDJuWjB0bFlOS2M0L1hQcmZoZHlpLy95U0YxTm5HSjBuVEhLaklTQWpo?=
 =?utf-8?B?MzE5Qm56aFdFNnNIcktjM3c5dWhSNHhPcTQ0L21kWkJkNW5CRDhzaXBUVDhm?=
 =?utf-8?B?MUpDcUhWRG4rZnVZSmpCektjR0FXTWlZUWJyT3UvU2liR3hmUlR2UE1OWWdS?=
 =?utf-8?B?OE1FcktuQVNiQityNDA1cHVqQVFLMUR5WjNzS0Q0bldnQXJEV0ZRZVBsTzZi?=
 =?utf-8?B?WGpCaGhWa0xpYnpIYy9GRTM1NDFpQzRqZjNGZWVCTlcyZWlNR01sejJQc0lz?=
 =?utf-8?B?VllMY3ZkekJCQWM3Zlc4SEpVM1d4amNjdFdlSGJ4RGxCam5oK1l2SnNsbXVE?=
 =?utf-8?B?NFpYTUd5bE5DNWE0ZTQwc0QvS0IvbktFUnp1RzBkUHc1b1duTDdKb2FseldJ?=
 =?utf-8?B?dGVUam5YeE1BQUJaR0Vzbkx0TUs0ZkdTalY5RUcyNmlIV05zOXBGMitqMm5n?=
 =?utf-8?B?cVNLUGlEcXZGRW5FeXg2dmFXcTI3Z2ZVYk85eFgyWnQyR2toWml3SUhOZ3Rn?=
 =?utf-8?B?TnZDM1UxMWh2ZWZNWVVjeVVQUEloeUo4bkliTFVzUGxJTjBBaU1JY2RlSzlD?=
 =?utf-8?B?MFUvaisxd1hsVEt0dWZMQWNDaFBGRitndzBBZDFueldsbWdlT2RydmhMM1Rj?=
 =?utf-8?B?czVNWi8reHpUZVQ3QzdGVStxd3RtY0dGRHNRRGJrdmJUVGtzT0p4RVZ3QjRS?=
 =?utf-8?B?ZEljdUZWd2RUamRCdWhkUk0rQ3BvU3pSTVI0TkMwRlVwbzhsQ0tIU1c3QjVk?=
 =?utf-8?B?NlI1RWRxNUF0QkY0RzVUWCs1TXBDOUU2TnhvSE5kaWJXK1JVUm1VLzBtMnJa?=
 =?utf-8?B?dksvYk01YUU4a3hORzl4RUk0WDhsWE1LcVJTMVZUeDRaUDhPblQwMUtkbFpm?=
 =?utf-8?B?K0FaSmV3aEJET253UTJRUG9nQnR6UStkcHdDcW96Ty9jbEVXaGJoVmxtUDlp?=
 =?utf-8?B?RlRRYm1kaXpmemo1MWpRMWpRb05yZ0VINU53R1VQUHBneHRNUENkb3FVUElC?=
 =?utf-8?B?RVlwVTRTSlhvTUZHeVJNSlY0WVNGTzEzMEloeFBINUFmSnBmTzJGQ3I5RFZn?=
 =?utf-8?B?dFVsK2NTYTRSY0htQS9CS3NLZUxOWmFmbUdSdm1JRDV2ZVFKZ045RGRLTGlr?=
 =?utf-8?B?UlJjRUI5TThBRTVJYUxaemVnTEltVEltK2FwYVV2SFFudnRLY1BSanI3QTda?=
 =?utf-8?B?eVcrSkRwMG9YWDdBK3paZnkvYWVYRzJ4YWlxTmMxUW81M1hjblduaW53eFg0?=
 =?utf-8?B?eVJYd1ZRcFJXOXVYQk83dEZZczl5KzdXV3lxeHVlbklGbHZCVnNCZXNCRCtG?=
 =?utf-8?B?UmZiRS9qNEtGVTEvcmYzUjNZNXc1OEszUjlnRjVQVCtSdnNMZUZjalhRMHpP?=
 =?utf-8?B?YUlYWkFMVkxyeU55ZHlHZU9FRTU1alFpN0M5djlGekFObXRBQVFCMHRvTVVq?=
 =?utf-8?B?cS9PNmZGZ2YwemgzME5SSWtmalVBLzEyWmJVWVN6cDd3cmh5QjlLVHc2V0ts?=
 =?utf-8?B?eExpYlVkVmJSRngzZHdNd1I5TjV5QjdGdFdXUS9LbVlHYURIWU5HYlNxRTFD?=
 =?utf-8?B?ZzVscGh4UnJrQ24xdXl6QzByMWVjOGpOQ1dhTVdzN3NmakZ3aHFOY014RkJE?=
 =?utf-8?Q?jhROWA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXBZYXJWOFJtbU9oZHVWUDR2WXhnQVhhOFhVaklsYS9lcmRCeXdNcVJxd1B1?=
 =?utf-8?B?eHVCVDVKUTF6Umw3clk3T2x0WXUrRFVHQ3dOTDN5OEFwNFBOREE3MUpaaWNQ?=
 =?utf-8?B?Q2ErWkFVSWFKVmRtMnpuVG5aNWxmelJSNVhoNCtxQnh5empubVh3VVI2UXBJ?=
 =?utf-8?B?ekp4cWg4cXlBbjB5bS9ObXlGL1ZkUVI2QmN3MzdobFdtV1gyY3RKT0dVRThG?=
 =?utf-8?B?dmR1aEJUWWpnQzZncnpYdjJPZDY1RHFQT3FBMDA4ZGJQQ2RRdDBFNnhsK1Rs?=
 =?utf-8?B?MHVSZDh5alZnWStobzNjT3JGTWRyOG5NZGJJYUFISDJzOHN0R1Q1M2VxS0RH?=
 =?utf-8?B?U1ExSFRQWHZsY29tWDJKSHJJMHIzOXZGZkoyUWpsVHhxbys1N2Z2QWhqNmll?=
 =?utf-8?B?ZCtWdXdBajR0Vy8rQzc4bWN6OTZra1k3azhycFk4SmVYWEFlS283akZnUUhi?=
 =?utf-8?B?eXdsWU1MQXZkUlZWZll3VE8yNzN5SWNVT1Q3cWszK0FVT3VtdmFwTm02Q0R0?=
 =?utf-8?B?NXdPOGxJT0JLVllvMlpJQXNIVU9pdXhEdTE5MTFQdlNNaTFPOHBIczN5cEIr?=
 =?utf-8?B?UEZDRVRjUGdaaExBY1N1SUwyc2RLdHdEbWsrdGVPZmlCNGY0MlBJVGx5VHlO?=
 =?utf-8?B?eUJsOEtiZnBWbVU0S1lvWGdDM3hSTUpqeDRFZ2cvMVYxY3QyakJDOE5xby8r?=
 =?utf-8?B?TGt1VWNMcXZaTm56dXBPRGk5V2NEc0RKNXFiMGJaNkQxWHRNY1htQy9SeHc3?=
 =?utf-8?B?Zk42Rm55Vllxb1JsWUV1S1VEV0MyU0ZXRFZwQUZveU5LdTd1VnFvMHJTQ0dT?=
 =?utf-8?B?c2ovcHlPUGtTRm10emdZKzAvOVM3Znc0Vll0M0g5dlFhODNXQy90US9USk03?=
 =?utf-8?B?NXVVWmd3OGlxWDBKRThzV0o2eXlmSEhHTXU3aG9VOEc2R0JobkN5UTlvVE1i?=
 =?utf-8?B?YVdDMDNJbjVIZitYVTVQVFh4TE1zMDBGOU0vMUZGTTUxbXJFcW5SZGtsYzZ5?=
 =?utf-8?B?QUowZmZDbHIwVEtjNlBhdHlNQlAxQW1mQ2RsTTZrcXpROW5XOFdOYXBYaEZ1?=
 =?utf-8?B?YkxGVjBxMDREcVViQVNTa294aENLbXpudDkwOTMyYUZSM3dsWVRlZ29CWU5E?=
 =?utf-8?B?bURBQVF6MnY1djV3S3cyVGNBbUlYUCtUM1Q2Z2NYU2x5MWlRbWR5dWFka011?=
 =?utf-8?B?dk1CQUY0dXhkcTRlN2w1N0pRbHdmYmV6blJIMlZ5K1hEMGNVMEgwbjlkS29N?=
 =?utf-8?B?YmFNL2FnakZmOXlBV3JqS1h6ZExFRkdDK0FnNURGdHdPb29pV2x1VllZdGhz?=
 =?utf-8?B?UXBLaHcyYW5VSVlsR1NZd2pxdFBwSEN1N2pRUFRJL0ptMzZvWElidG0yTXBj?=
 =?utf-8?B?bGt3NHJEQkNtR1JUcHlVN2RVUGNpRC85enNlSFROZHlsRXdKUzFkQkc4emc3?=
 =?utf-8?B?NEFtQ3hZcHdQRDlZQlNwODNmSHlkWVAxZ0U5bWJxbVhvQSsyeXp2RGhNeFNy?=
 =?utf-8?B?dGZYMUg3Qi85OGcxUkVaYW8rb09RSnlDUFIrWkZSUy84UHBvTWlQZURuVkxs?=
 =?utf-8?B?TjYraXhtQVQveDc0cDNYbUovTlJqNUZ6a1lQdE1XQ1NXUEwxd3lXOG1jZHVl?=
 =?utf-8?B?K28wZVBqbEtvUFh6amlUNFlBTEl1N0NzNGNEWitvekhRSFdXRjB2UWNxclJs?=
 =?utf-8?B?L0NndEFBbFMvMzlKVi9Na3BuN3dMaDdROHoxWU5CQ0J1dWk1dU1oV0xYR0hP?=
 =?utf-8?B?a05DR1RUdVg4Y3A0YzdWc1RRakRmSWc5ZkZjSklGYStjMTVyRWZhWTZzeUZ0?=
 =?utf-8?B?c0JRNks3VHRLdS92OUlNZnRXUUxicVB5SnpCYWpRL0M3bWdXR2p0RFpFcUd1?=
 =?utf-8?B?STc2LytpMWRGNHJFakRiVHpUT1RCVnRlTC94clQyZGxaaTU3RkVMMEZKbWla?=
 =?utf-8?B?dkl1YlU2Ync4QStCY2tNR3QxRndYUXVSWS8yTnh0TXE0US9zVWRkbkt3TmFX?=
 =?utf-8?B?UjY0ZFhJK2pLYUo1bE1VWTR4bkVnOW5rOVo1RmV2OHRZUFdrREJSOVMwbnU4?=
 =?utf-8?B?dHQ2NkEvQ2R0TTFVdjI1Y21JcjJPcTdhL01uYmR0NTFqLzBSNEVaSzRyMy9i?=
 =?utf-8?B?OU4vUVQyQThablNLbXgyYUlXUDUxNUY5bHlud1hUeVF5c0g4RGEzQTdMdlFt?=
 =?utf-8?Q?ri9WdUScLpDRvpRjuHFVbrhXZnRdUxucnX8Wlsq8O5ex?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <349ABC17FDDF7E45A52515FA61BCBB3D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7184c4a5-6a8b-4537-b940-08de221259e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 17:38:54.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JN0kyGgr4MwS5oJ5zj6knlq+8bqHIHftsxYaU2WxPGgmDdfeYlwZnDltdlz03f5k0A+wcVmjLLYAOlWyCk4Ngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

T24gMTEvMTIvMjUgMDg6NDIsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gRml4IHVwIHRoZSBkaXZpc29yIGNhbGN1bGF0aW5n
IHRoZSBudW1iZXIgb2Ygem9uZSBzZWN0b3JzIGJlaW5nIHJlYWQgYW5kDQo+IGhhbmRsZSBhIHJl
YWQgdGhhdCBzdHJhZGRsZXMgdGhlIHpvbmUgd3JpdGUgcG9pbnRlci4gVGhlIGxlbmd0aCBpcw0K
PiByb3VuZGVkIHVwIGEgc2VjdG9yIGJvdW5kYXJ5LCBzbyBiZSBzdXJlIHRvIHRydW5jYXRlIGFu
eSBleGNlc3MgYnl0ZXMNCj4gb2ZmIHRvIGF2b2lkIGNvcHlpbmcgcGFzdCB0aGUgZGF0YSBzZWdt
ZW50Lg0KPg0KPiBGaXhlczogMzQ1MWNmMzRmNTFiYjcwICgibnVsbF9ibGs6IGFsbG93IGJ5dGUg
YWxpZ25lZCBtZW1vcnkgb2Zmc2V0cyIpDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGti
dXNjaEBrZXJuZWwub3JnPg0KDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
