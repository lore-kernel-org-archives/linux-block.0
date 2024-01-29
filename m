Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AE6312C
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537209; cv=fail; b=sR8UB/V6V+FmTKhnkP4McsfZdsBNaooq7PPZnmh3fluLTqaEuuC1GC4NS16sFGgMYlmOqFxkweiZqX6foBTxbDtVzDWEkxJHg7Vzp42ogQ4M6lWPi2kw74exadPvB0ZIxv0ER+09Gqw1FVusZleTXEqvlZs55vyRJ9zFFeR6BMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537209; c=relaxed/simple;
	bh=WlmgLyBS4LOIjfezrM0Y6iJb6lOOo6VbH/cIjJ9Io1Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erbFfVqF1SICluZwhTVVkR8VcLI1JsezbsK3j86H6J4PniawQMmX35BaY3ei1yWGBBCZDHegun7xIpVgmYUXBwr2rUgBvVQ09kL0s3ly5g1/AEdp2BBnmufapUiWKspJ+w0Zfslj/PSUTDFHV2YOhlNbK3qZo/inQDlYRAqhBTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ng6w9U/w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tx/3Z3jf; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ng6w9U/w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tx/3Z3jf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706537207; x=1738073207;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=WlmgLyBS4LOIjfezrM0Y6iJb6lOOo6VbH/cIjJ9Io1Q=;
  b=Ng6w9U/wHEY7h5OlzKdT5seAE6WXHIcPrBAvuJWUKEkMTy8soF/4xbO5
   bCDOAHk4fpHv109CmF8QfnvgRTQ9W68LcWcEdEqhNiFTZ52qCM4MRy0qV
   cJtU65DqeuLG+PzsIi44Cj8gYdYAd14BVZtuJZwx4wSofdfL/YWj206Oo
   bZYFq9BX5ZLeSCGMhKk7zc3hjdwYxKjnSg0z/Rnj2bgmu1BcqEmFFaMDb
   ymooaHncTmzZUd3tBX8fezRttIy4+LJd0zlBvPZQ8P2Tbnd5WoipiIdTu
   MZ+yH6ZOAwD0CnhUyuyF1/IkgCO6e32KP+F+MmS/fogBxfmO7wc6GltIb
   g==;
X-CSE-ConnectionGUID: I3WAkpL9SKGo6HwbLvkUsg==
X-CSE-MsgGUID: +AqTRX4PSeuYRzG5tpk5dg==
X-IronPort-AV: E=Sophos;i="6.05,227,1701100800"; 
   d="scan'208";a="8504004"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 22:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llcq7LnpMfU8ycS/Ktj+WEnCIBSGe6JvptsAq6u4Tg8j/E/z5zDl2t4aCBfSvtaYdjJ7IjkAMDHnJySDTzg32n/1W4SgbG8C+eGlalqkEZLAI98VrnpZkDM+i/m4deB1bNqDVJHif00j/JBdZg+qCkcQk2zD7jP4yVvNES/KqrbRNG8Uo6cu9oteUrhBIk7HV3ex5OdTjQR8XFBcTGtHltvEniGnAwAK9O40yYLEFQerEurPN5BYhh9aHDVIsC8OgKrwGvTPMf1WDtAm2PILjlydCcxTvEQerN0zROCXdIHoyJI1A8fg3heY8ZkN6ZNyuzRKUDrBwYr82sVKKe8yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlmgLyBS4LOIjfezrM0Y6iJb6lOOo6VbH/cIjJ9Io1Q=;
 b=QAr+mesKpTatJj51kp4EMBnFL+7uOndSJ/IcOSAPr8kmgdRKie3350lgx+k9zxzxZfQmqEtV9PcRDGB1dk33H1ql3Ym9TmKJL0sezotm9hFqf2qBlIaY8P/6wldYQZPCtWOhmWV66TR9A8nt6KbDPbacgSw2BY5nnDpfjCfTI/QApdeo1cTvDFfiWV49O4dOFQZyr+79QZuKPnVawTqWqlPAPx0C8ZJWawDG3TxGezfDpX84P6dg7++guuYriJJQDDBA+dSyA/3ApMtSFdgDqt5X+WHDKGhPVU8SbGwsMLXWOvojBWj3dk+bLDJzc7ch9SiELCYe0ZxsGp6P757iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlmgLyBS4LOIjfezrM0Y6iJb6lOOo6VbH/cIjJ9Io1Q=;
 b=tx/3Z3jfFhhM67qIxnSJKZ5+8h6P6VTw9t8h9eQVGHVZXew1edbDq+I/TwZl1RHwfzXLEToG118Vfwn7I7nrcUH08Zh/Mqx1jTyqjUpdZxOAU07L7T8KeACsV0DhCEOX+8H2Kw/M3ulo4qbbMh08c/sYpOZ1o4eagok4dnMbBnc=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:06:38 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:06:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Thread-Topic: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Thread-Index: AQHaUKAVqscq6cU+ck64RpbGM6WomLDwcYcAgABkuQCAAAE+gA==
Date: Mon, 29 Jan 2024 14:06:38 +0000
Message-ID: <c2cad14a-6add-4301-83b1-be40e48c0daf@wdc.com>
References: <20240126213827.2757115-1-axboe@kernel.dk>
 <20240126213827.2757115-5-axboe@kernel.dk>
 <9e13afd4-d073-4822-92ff-936788f0c2a1@wdc.com>
 <1b0c9f7f-9b1b-484b-a9fb-bf2c42d9a18d@kernel.dk>
In-Reply-To: <1b0c9f7f-9b1b-484b-a9fb-bf2c42d9a18d@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7261:EE_
x-ms-office365-filtering-correlation-id: 6d7f57e0-4678-4778-5ffe-08dc20d382bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K34+leIYMW4e2xTCBASttjeoC6PdoCXM9Pso/EB4LaG9Dm6McCmCts2unad8YIvhHKVACD7Ma1Z5T92SaZAmfdTDhISIZtk+t8BJtsWpxM3zgyTfVPGXu+Gf+t/JB3o+QnZSd+F5OKhCD+Ld+ETw5QL9t+rnJWw04aOW2oSR/na5i8LpPyGtR8EScRGVwI1rcukS/MDaWdMxdM9XPnX00sFW/lPiyALgq5hkf2xN6qzLik5ubUJVKEXBkcrBUJo51ViiUpHpM4+1Mgv4DseBuBZgWQW/4uNCbhB+1XnXBntU5lzWfgxk99vMrjtowNeP+YZ+Lpf6HtOJO+hanKmgpSqE4LxA9jK6chEP8zA9rbxci3mH6ug2+HZePq0PqlPekobAF+62CwH6jsuAeaolxaTrK7iFCSCsviKM6r1iXdi2DP051kj6p6hIWABK1tFM0a4C/yy3yRq8hpcQUUs1/WwMk23FXGvrOAgjBxFbMXAaaW2NWbXbaWhTe9xe66G7aff43wSonyRWWbv1LalMLnj2ggBbqXFLECgKW9h0IpMlgDFPC9zzD75f4tiF2b/uC91D29N+5EOBmK9lMpsBB8E2yPlfU7uypVNIWJS2NX4lkQml3r22gn15S2fCuXclrWaB8yvYuUK+aNeQxO7q3cD5zv/V91KxDnVHHljW00jys9CAoezSWhjkbSuBOeg0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(6512007)(38100700002)(26005)(122000001)(5660300002)(8676002)(8936002)(2906002)(478600001)(66556008)(6506007)(6486002)(53546011)(66446008)(66946007)(64756008)(71200400001)(41300700001)(66476007)(110136005)(91956017)(316002)(76116006)(38070700009)(31696002)(86362001)(82960400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2VZK3VIWm0yZWRXN1ZzNmllNVV4SEVSTDNMQXJ0UEtNcnBpMTRITGMvN09u?=
 =?utf-8?B?N09rYzJlamk3eE16RlNhSENKN2hGaUJaZE9NU2tsK1VDSmhlOGFJVWF6TnRm?=
 =?utf-8?B?anN2amFQUlFqNk9PZmNvZVZMMkxiMW1XQWE3b3h2N0s1WFZWYk1TRTRnSWFN?=
 =?utf-8?B?ZGlXUlBmMEh6WFNrbnVqMkpWZmVVMldnVEpWV3Q5MHRZM3JRQ1VjYUtJUjFW?=
 =?utf-8?B?MlVoME9ZWFdaaDJjeUZSbVUzazFLWEFCajdaODcwcFdReE9YMWJvaXFSR1E1?=
 =?utf-8?B?Z05zZTJEbSs5V05CNTRHMit5VjJzdDlYMy9LUS81NjVJdVJWekxDcHI2cUY4?=
 =?utf-8?B?OTE3SGk3OHZPRnNXdUhKeTBJYmkrbmw1ZXdHNjF1dTNHYzV3QVFWUEEveDkx?=
 =?utf-8?B?KzcrYWtMd3p2c1o3WnR4SHhqUUdZNGZtS0ViRlZScEtDYVlYZHE2amN2R3pS?=
 =?utf-8?B?cmUvZG5oN1l5elNXUU5BYUpOV24xaG1HOWRjdkV3a08wb3ZodEtwbXR6VVFM?=
 =?utf-8?B?WjNHcVJ4clJxeXA0eEZhelY5SkJPdkF6N3pocXR6MS9SUHZYQnhqOXNZQnVh?=
 =?utf-8?B?cFdYNDNhSTljaDlDb0ZDOEplc1RTWFEraGhmbVE1S3BiL2xBaE1DYVBDdTE1?=
 =?utf-8?B?ZFhNQ3BTUDlFTUk3Nmoyd3ptUFNpMmhOVUpocDd1Y3hWUXNqeEdVTkNOTUFC?=
 =?utf-8?B?MEN5cXpOTzMwME5BTVBpa0xaZ29tZW9yMXZ5aDh2SGZ1cGlzSzlNRW1BN1I2?=
 =?utf-8?B?VGowWkFqVTFnV1pQeHlyZFNBSi9rRXY4VWd3UU42SG5TWEprTWtFSWVWaTha?=
 =?utf-8?B?WmF5aENVT1RPUFo3SU00YW9jY1VWdUcrdVdlZ3NYNXd6dmoxUFY0bzNTVXBE?=
 =?utf-8?B?aW9XeGRDRVVpV0kyUU1YR2V6b2VpY3k0dk9mblhXWUZMUEliYzB3NFBQOGgx?=
 =?utf-8?B?RTQ5aERoZDBYK3VxVTcyYm9UUGlaZG1ueFZYRmppb05OUUs0U29Ga1V4a3Zk?=
 =?utf-8?B?Sms2bmtJelFEQy95eWNkZWdwSEdhZ2JDbyszL0xjVzFiREhqQWk4blpDQmtS?=
 =?utf-8?B?cTAxVkEwV0pLR0FVMFRLRmJMSlZjWGFoSVQ4WVRhY1NHQ2ZGUjgzZGpkcUVi?=
 =?utf-8?B?UUZYclhvRWoyTmEzV09BT3ZFNElac2VwSWlpY3QrZll0R0dNNFUyUnZkelQx?=
 =?utf-8?B?bHgybFFUWE1iV2l1UlozczE5TU5kdHJwS1FXZGhOcGVEQ1I3VVZCL3g5UFN4?=
 =?utf-8?B?SUhTdGhaYjFSdEJqdXp6Nys1aC9McGtNcGswY2E2bmVjOWh1VHdWNXM1b0FJ?=
 =?utf-8?B?SlZXcmZsVHR1QmNxaGk0WStnOVJxQUhhaHNmc1FUMGZmMXFlVE5ycDBJeWVJ?=
 =?utf-8?B?YVFONDA4a0FhbllzQytBdG4vY1ZBUWhNbnBCL2RYZllKd29ueHBZb08xaG9H?=
 =?utf-8?B?LzIyNGxhY255KzV1ZUhBeEFxNW1weW0wOStzOFNBSEtzUkpwVnlLRWwyTzhL?=
 =?utf-8?B?L0VjUjJaekRiaDY1K1FXS3VTRm9WNjhKaGVuMkNDUFNhRXlKRUFvUUZBSUQ3?=
 =?utf-8?B?Q3VWWHJxUG5ob1F5Ri93aXJieTZoUGdUdGtjaTliSFkycDdXNmUzVWYxd09t?=
 =?utf-8?B?aGNNSVFvMmNXYUkyQVBGZldrRnM0eE8yQkxKUzdoZXBxWHlUdTA5YXBOQnlU?=
 =?utf-8?B?bU1OUGxlSjRBVUJBVXNnN3JnNmlDTFQyTWJ1QmtDeXlVYW1tZSt5R2pxWFBv?=
 =?utf-8?B?U0w3V2hZMEdLcmlBdTdJYnlxNFgxKzloVDhXeFBCOHhLMTdkMlZZS0Vua1Fk?=
 =?utf-8?B?aUFZRDZONVplcWNtSXF6Njc2RjNCUUlWVEgwN1NXTXVzckFieWc0K0JuL3U1?=
 =?utf-8?B?T1RhdkprbFNKUndaQm55QUtINGRIOUpOYnkzRG8vU202WjN4anZqS3c5THU2?=
 =?utf-8?B?eXRWOExkWXo1VjVHNW52dGo2MWIyeEhYWjVoZEhhZ2ZvZ3dFbFgrSmhsZzVa?=
 =?utf-8?B?MVdNNEIvSnpRUGZaZmhNTDZ3ZUNKQk9lT0F4eXRpRGF3VHhxQWtadnluRnl1?=
 =?utf-8?B?SDFlQjlEL0ZaV1FjR1BFS3BIUGpuWVFUN25wZzlCaW1YbmhJUitrR2ZaejlV?=
 =?utf-8?B?UWc1TklQVGFVYUVTRytxZHIrOUdBZmlFYlJURnkvTzRXU0lQZlNtdjFnRmFK?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABAD45B308AF7242B77850F34CE53D9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoqSUEjMQiyFjz3iiOdpow7DYABhVpFI2huM2+GrBW9nPCO2a6Pk7u3ymOdyS7nl0HVR2W5Vct4I9P4RY4VCJaXLNnDLWSiMmd36ecrJgF+dHa5ueG5GpJjNTLF64gEIwRGrWwedYp8lciZvh6NUxOLclsL0wiRsLEar4vb0wsxSlJy0/X0NsKkuzv+tnnJGlech+S+4Lzi6J5EGwc+XYP2r/hq1Npyqdp4NeCI2/GmaJ4KOB5Rpil8pOWaNt5kX6MHscGTdVBwV0qH/JF9E7FzGk/vfqNra5AeLNEJHyXGgAZzvEcXDjYzNNBNTemXMD5SiHitUdbGwlF8YKr17JzisQMD5Z8z2CQe1HdiA6MGKB5DmdITIfSMWtOaUm2KIwWI9GvvWZc2AEsOWA4u091nDLeDy75eE9Ognyc7cH8L4hcjbEDTKa1sX5qk0s8q1sA5w4JQi50oyikp3ZozAsa7LAmgU8vSchB/a5OqNM2RQSKGW4ZnAYiRsN0LXlowWTAr/PkQCsM8Nx3JXuPN8usSpW8Ni/bjJosvMYiLTWA2UkxEYAEFBbA6/7yw5I9j4BhihDEQfOsy70QWzCcpKEaKdTmCUa7TdMiPY9cfMuyfeKl0qBRvdIIsQoO8wgKz1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7f57e0-4678-4778-5ffe-08dc20d382bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:06:38.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKISC9C02+N4zdJYIe0GLdF4JD4idiuHYh0Uk1epwBgB+M0GgqkP+Batrwc01myLxtH6d+aQdxXRiJHA1KEYhXI3YeW6K4m6TMqEaK7FHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261

T24gMjkuMDEuMjQgMTU6MDIsIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDEvMjkvMjQgMTowMSBB
TSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMjYuMDEuMjQgMjI6MzksIEplbnMg
QXhib2Ugd3JvdGU6DQo+Pj4gICAgc3RhdGljIHZvaWQgc2NoZWRfdXBkYXRlX3dvcmtlcihzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnRzaykNCj4+PiAgICB7DQo+Pj4gLQlpZiAodHNrLT5mbGFncyAmIChQ
Rl9XUV9XT1JLRVIgfCBQRl9JT19XT1JLRVIpKSB7DQo+Pj4gKwlpZiAodHNrLT5mbGFncyAmIChQ
Rl9XUV9XT1JLRVIgfCBQRl9JT19XT1JLRVIgfCBQRl9CTE9DS19UUykpIHsNCj4+PiArCQlpZiAo
dHNrLT5mbGFncyAmIFBGX0JMT0NLX1RTKQ0KPj4+ICsJCQlibGtfcGx1Z19pbnZhbGlkYXRlX3Rz
KHRzayk7DQo+Pj4gICAgCQlpZiAodHNrLT5mbGFncyAmIFBGX1dRX1dPUktFUikNCj4+PiAgICAJ
CQl3cV93b3JrZXJfcnVubmluZyh0c2spOw0KPj4+IC0JCWVsc2UNCj4+PiArCQllbHNlIGlmICh0
c2stPmZsYWdzICYgUEZfSU9fV09SS0VSKQ0KPj4+ICAgIAkJCWlvX3dxX3dvcmtlcl9ydW5uaW5n
KHRzayk7DQo+Pj4gICAgCX0NCj4+PiAgICB9DQo+Pg0KPj4NCj4+IFdoeSB0aGUgbmVzdGVkIGlm
PyBJc24ndCB0aGF0IG1vcmUgcmVhZGFibGU6DQo+IA0KPiBJdCdzIHNvIHRoYXQgd2UgY2FuIGtl
ZXAgaXQgYXQgYSBzaW5nbGUgYnJhbmNoIGZvciB0aGUgZmFzdCBjYXNlIG9mIG5vbmUNCj4gb2Yg
dGhlbSBiZWluZyB0cnVlLCB3aGljaCBpcyBhbHNvIGhvdyBpdCB3YXMgZG9uZSBiZWZvcmUgdGhp
cyBjaGFuZ2UuDQo+IFRoaXMgb25lIGp1c3QgYWRkcyBvbmUgbW9yZSBmbGFnIHRvIGNoZWNrLiBX
aXRoIHlvdXIgY2hhbmdlLCBpdCdzIDMNCj4gYnJhbmNoZXMgaW5zdGVhZCBvZiBvbmUgZm9yIHRo
ZSBmYXN0IGNhc2UuDQo+IA0KDQpBbHRob3VnaCBJIGRvbid0IHJlYWxseSBoYXZlIGhhcmQgZmVl
bGluZ3MgZm9yIGl0LCB0aGF0IGNvdWxkIGJlIHNvbHZlZCANCmFzIHdlbGw6DQoNCmRpZmYgLS1n
aXQgYS9rZXJuZWwvc2NoZWQvY29yZS5jIGIva2VybmVsL3NjaGVkL2NvcmUuYw0KaW5kZXggOTEx
NmJjYzkwMzQ2Li43NGJlYjAxMjZkYTYgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5j
DQorKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQpAQCAtNjc4NywxMiArNjc4NywxMiBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgc2NoZWRfc3VibWl0X3dvcmsoc3RydWN0DQp0YXNrX3N0cnVjdCAqdHNr
KQ0KDQogICBzdGF0aWMgdm9pZCBzY2hlZF91cGRhdGVfd29ya2VyKHN0cnVjdCB0YXNrX3N0cnVj
dCAqdHNrKQ0KICAgew0KLSAgICAgICBpZiAodHNrLT5mbGFncyAmIChQRl9XUV9XT1JLRVIgfCBQ
Rl9JT19XT1JLRVIpKSB7DQotICAgICAgICAgICAgICAgaWYgKHRzay0+ZmxhZ3MgJiBQRl9XUV9X
T1JLRVIpDQotICAgICAgICAgICAgICAgICAgICAgICB3cV93b3JrZXJfcnVubmluZyh0c2spOw0K
LSAgICAgICAgICAgICAgIGVsc2UNCi0gICAgICAgICAgICAgICAgICAgICAgIGlvX3dxX3dvcmtl
cl9ydW5uaW5nKHRzayk7DQotICAgICAgIH0NCisJaWYgKHRzay0+ZmxhZ3MgJiAhKFBGX1dRX1dP
UktFUiB8IFBGX0lPX1dPUktFUiB8IFBGX0JMT0NLX1RTKSkNCisJCXJldHVybjsNCisgICAgICAg
aWYgKHRzay0+ZmxhZ3MgJiBQRl9CTE9DS19UUykNCisgICAgICAgICAgICAgICBibGtfcGx1Z19p
bnZhbGlkYXRlX3RzKHRzayk7DQorICAgICAgIGlmICh0c2stPmZsYWdzICYgUEZfV1FfV09SS0VS
KQ0KKyAgICAgICAgICAgICAgIHdxX3dvcmtlcl9ydW5uaW5nKHRzayk7DQorICAgICAgIGVsc2Ug
aWYgKHRzay0+ZmxhZ3MgJiBQRl9JT19XT1JLRVIpDQorICAgICAgICAgICAgICAgaW9fd3Ffd29y
a2VyX3J1bm5pbmcodHNrKTsNCiAgIH0NCg0KQnV0IHllcCwgdGhhdCdzIGJpa2VzaGVkZGluZyBJ
IGFkbWl0DQoNCg==
