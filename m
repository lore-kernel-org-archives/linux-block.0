Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1801ACEDE
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539041; cv=fail; b=E2e4G5pQC5Br8R+yYtBWpN4p87XWkR6G2mow7/x3HxCSZfdrZuvM76Ov6eQaA7h0sD7jonA8Hw0QST/XL/bR3j0MhnPsqaUrLrVruD97KuxUkifUbwO+yT8Y+0uEaw4JkpFIIRfcs4Oyv3UFZDMSEB7N9xvzHegqnnwjeFX+v90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539041; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrp8NoiEa9OYglFmvasqjJ1d2NM3DutlfmC4GyauB5jvuvC5WMMWvuXLP7m7PEpelCbhHrU0FhESCTiyueMFjsAdowqvaITyCpAjNFPe5BYGyvI8PFFgyAu3AZy6CA9hums+LgwkWFNYIfI54w72gcCzpoDeFLc6uEFFhCzeNgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZsTfGK1u; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=o+uazv9x; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZsTfGK1u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o+uazv9x"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763539039; x=1795075039;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=ZsTfGK1ubqwmWQ5AIgr6zskb3ScAMh31CaPpuGLOcALMAPJasFipEUkV
   73hBaoCgjCRDv500GugFKZKJpPuARnmCMyANgrQ6KRUBKbXhpv8PNQclp
   eYQDRx/5Ne9I6nNJnWkfirBvVP9eJzpg2MyxrYmfBGyd6y3lzPtphHwHi
   JELVbhI2+tbBr/DIm/suNAXfjsTR/X3mE1vquv6tL/7s/KcEkpzBB6LK8
   XLLI8d4REZrQOB2WAh/F/u2U2sxdLEB3oFoippqrdZVW/mfB+COx+sxIH
   DmUBxNaV1Bq1zYrrTyeso+4iMb9vW7XR7vkUFV525WVTRgjk2L9woiBJ6
   w==;
X-CSE-ConnectionGUID: pVVCt66VTIigUrwm37vHvQ==
X-CSE-MsgGUID: Hz6JRDWYR2eEfnJJyCwThA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="136705717"
Received: from mail-westus2azon11012052.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 15:57:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSrhx3U+/29MMfqWwsYVFQP8O4zFWZzUmkLm6iz9dJ4ZgKVlgoF0wZznwZVtqrUUbjs/DF/euAEH47pRQh8Cs9V8Urb2hl9jYe94/ioCiLfCxRnwNEatKqQOZOcBti5rrDjYc11ATtB/X/EIW371d0aDG9J5DE/D9u9twlPzAPjfKJLLm1pixvlU+HaurpvJ3RdPJqGxIoi7Ix5d8UHni9/Fd5nSQNOP4Oh3GM3HD8ggpnEWXbpIg8ABGTC6+XJruWzb6GfU1bYxr27BPXLca848OuJHet7jS5Dudl2CZd5PUV0UhjmFXNZiEpqr/K5eGwdDBUcJSZ5NYd2SUvYUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=oREU2v2nQy2L1pqrhX5NFebVMpgB3rJbpc2+fu3V4XUDAbJgsQsHj2innVf/0h3jT3TQo5NEqtiHBYLS2VexTRjOVOyj8+Nlxk9Qrco443U8xjI/4BpAq9QyZ9/GISzfBtOUEhhbDXSVUT4elhYUOd0Rji3dg29VHMgq4oG5sv3D/9miC8/ykg8ciN5gqELO4KBMQatNSC8hlkDIkaY9sD32p3/qIvg5tF4A/w/uwtO8NZOJo9X6NejtSw3U4oAelMhGnvQ5gMlcCUWG/Fka7F7PuIrfoIPyR9wdLp191cVq2GMLnnJX7L40rCwvWnW8ma3OdVnFy9NoLdY0sQxsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=o+uazv9xdttiCthQuxz+0QyIxeiejfT23+yln4b9mw6ZPSfuXBDgQwWsunAXbjsXLTzxWwIzNvsx3//2GCGrsPgK9vosoRZxbfvzP26tvvsY1e2GaBbj4ESqmP0PhggP1mRrAEhyue/mrj5NxddvdzvWklJh+3YIfRo/GKNhYU0=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH3PR04MB8925.namprd04.prod.outlook.com (2603:10b6:610:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 07:57:16 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:57:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: add a maintainer for zoned block device
 support
Thread-Topic: [PATCH 2/2] MAINTAINERS: add a maintainer for zoned block device
 support
Thread-Index: AQHcWQGIqpAg1v5crUKoJPr6Ti2ABrT5ojsA
Date: Wed, 19 Nov 2025 07:57:16 +0000
Message-ID: <2117c10e-e58a-4cb5-be88-b312f6c90759@wdc.com>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
 <20251119030220.1611413-3-dlemoal@kernel.org>
In-Reply-To: <20251119030220.1611413-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH3PR04MB8925:EE_
x-ms-office365-filtering-correlation-id: 5f36e899-4485-43e1-1bc4-08de274141c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHE5akhwRS8rSkZPcm5TcW9tbnRZRXYwcUdwU09sSXdUU3F3RGRGVVRrQWg3?=
 =?utf-8?B?NVU1K3dTNC9XWUZNdUpBb0hESUlXeU5VQ0JyOWRSN2kxUElpUThnZFl4NFdZ?=
 =?utf-8?B?eHlyTjZLOXFtMTRaMWhoV09mTkdGaVorRXk4Q3RhUkxidFc1TDc3OVRVMUc3?=
 =?utf-8?B?bXVnTG51SWJub1BUdTJCckpRTHF0VWxvMzVkQ1NlbWY3eCtJbUI4MWhQQWlk?=
 =?utf-8?B?djhGUnZDR3N1Z01rVGZlVVo0d1RwSk9sdkNxNnJtd3lKTGhYK1FXcy90N1V3?=
 =?utf-8?B?bFk1MUFyVHlycTY5WnZocnVuR0FUSzJzSlhWMDBkMXkzL0ZFcnBWUThqM0Mx?=
 =?utf-8?B?WjkyRmxTVC9Id0kzYzlzWHdSQVZxdmVoTWMwb1FrWUtIZ3c0Rk14SzM1RUFS?=
 =?utf-8?B?ZHdiU2tudGR1clhsYXJzQks3RytOV2J4bm5DeHVSWUJ1NllqS0ZFM0ZkajZS?=
 =?utf-8?B?SXB5enZQNkRqekxVYnoyQWdNUWptd1ZLZGt2YXMvcmdid0ZITjl0VlhDaDZD?=
 =?utf-8?B?RXJUbDBGWFpaUlk0dDFxL1BzTzRKdGRzWnFiZ0hNY25aZi9udTJnT3Zxenc3?=
 =?utf-8?B?QUJUVkNDdysvaEtDTkhHamZDOGVTOUlISHJNQTVhQzVRKzR5THN5clkrUGNF?=
 =?utf-8?B?bEJoMlhxN05PYWJuYU93VXk4OEV3TkwvclRiVFpOdzFpN2xobkcxWmRoaTVV?=
 =?utf-8?B?aUJqVDk1U25CMUsrQXlaeWhXdVc5OHRaSlQzd1JEbklmWHhUck9nd3FZL2VE?=
 =?utf-8?B?ZVVzb0xWZGVhZlJjcGZvL05ESERMVUJyYVdKZXNxd25XWTB2eEdDMjdUSEdu?=
 =?utf-8?B?aThha0JyRjJtOHI3WDhCSk40amRQaFdYc0FWZU9RTXl2M2IxdXVSR2JFQ0gv?=
 =?utf-8?B?YWlQSG5WTDhqUHJ0VVBTU3djaDBvSUw3c2o3byt1S2diak96eTdvWko1MEs0?=
 =?utf-8?B?TTM3WkFmNzdCV3puTUhkYWtzZjdwKytrU1JSdWsyb1RGWFQ3Ulgzc2pmRDQy?=
 =?utf-8?B?WmQ1SkgxVlBTTzJZcE43NmlMbHZVQkJkSEFoNG5XeUcwQ05jY3hLRzJKUkdF?=
 =?utf-8?B?eTZhUXV3YnNVNjZuZHovWXNBZCt5ak10VFpWeENieHhqdDlqTnNkWEpHVFZ0?=
 =?utf-8?B?VU5HMlE3Ry9rT0FJTFdlbzNhTUZ0YkcwRk9HVUdzZGVDSzM1YkdmOWFRaVJh?=
 =?utf-8?B?bFV4VkFFWU55TjFDc2lnWVlWM1hjZkJiNVZuTFNGRmxLOGRCU0FNblpNeGhq?=
 =?utf-8?B?eTJ4b1I5eTVoRXhXSUZTVytvRjZ6UldNZ3RMM2dqbkhyYlhTY0xYMndvMzl6?=
 =?utf-8?B?TlZQM2ZjU1M1TCtrRWRBcWs4bktnWm4xWUpNRzBsNmVqRjdUSmtUdWZDMS8v?=
 =?utf-8?B?RStvZFo0enBRZm8rL0FVQkJrREkyUHNpSWlBYit4ai9NZjN1Nit5MHV2Sm1P?=
 =?utf-8?B?WVFKUklIYXYvT2EvMjdkYll0Yzk3TzdjOVp0OENqbCtmMHhDeHh0Yll2S280?=
 =?utf-8?B?N1A2b1lQWGgrSWxyRXkwTlZQOEZsL1dNY3ZnUmp0UzlzRnpkOFJ3amtGRG05?=
 =?utf-8?B?Q09URlZsZUpaejBqKzJaYnVEbHVwMndrRjB5T3Z4L0xpbWZzZ3IraHFnN3lB?=
 =?utf-8?B?UU9qMVlkbVc5am92TzZpQVFYcE9zcXFRWnVJcisvZFozNEk5ZUxVWVRlNnpY?=
 =?utf-8?B?TW9sSkxQMkkzMnNCZUpXeEp3cWVER01IbHVNd080SG9yME1SdXo3NENqMEZQ?=
 =?utf-8?B?NGhDakhORG11eWY0ZEdZeDFHTVcvUGkrUW1ldktIUWx0Nkx6REVRbzMvUVdY?=
 =?utf-8?B?c01Wbmk5SzgwUDdLUm1zd1JPT0dEV1ZZUTc0NXZYb3J0NFJFV0pVdFlFRitX?=
 =?utf-8?B?MWl4T2o1LzdsSzVXUWJCbWJUVksrL0RPeGhOMTdGZ1o3bTFTZ0JmK3ZIajVj?=
 =?utf-8?B?amo4TmN4WUdtQ2cyZkw1TlpVUnczUUh0K0V5RXBjK0JFWVdtWWVVbWl1MGE4?=
 =?utf-8?B?cGdDVC81cXdFTU1kNlhpNVRNVWJhdFNPemU2a2Jndk8reDVXVzJrZ1lPZ2JI?=
 =?utf-8?Q?8arjmj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTNGNVZEYnp5Y0JsckRXaGh0MHB1UEk4VE4xdUFZNUhJNzV2N0NDcXE4ck51?=
 =?utf-8?B?a3Z0OERxRkhOdDRIUHgxMFZ4MEtYMFNJdWR1dVNYV3Robk16NHJSdUI0Vm1E?=
 =?utf-8?B?SGg1SlA0em1ZWFNPZzdpbVMrRkcyVm9rVUtSdlJNY1B3TGRlbVJhcjZHQ3VO?=
 =?utf-8?B?bmVYSlV5WTI4Q1VuV0lBcklnK1dNNHBsQ2tpZlpLRnZaNmEwdE1ua0Vnb1JV?=
 =?utf-8?B?Z2FneHZxTk8zbk5UTUNocXcrTzVvNXpYaDVrYUhOWXdDSit3bWdOSzlISlpW?=
 =?utf-8?B?bCtrOEdGQUJNcW1xREtFWnl3Y1J3TmZtTGVqWDhWSmN6UjV4WFdaUnpjSjR4?=
 =?utf-8?B?ZGZ4OGZkdjMwa3lFWURMZXVrbmtJQnVTd0ZxR0piTmRtS3RuTmZaUmhkNEo5?=
 =?utf-8?B?WFFlTXNHdVFKdTZwUWdKVU5acER3SzJUcGlCcmlRZW0zUXBLOFgrSlFJbGs1?=
 =?utf-8?B?ZEtabmsySmtJOTVFM3d5Sm84SWxUODNJOERHQUdzZFUxQmFnNzg0b2tDMjdO?=
 =?utf-8?B?UUNFYTRzdUEvR1VpKzhRZFlIdlpiN0VqM2V0bHk2ZXJZd2x4OVI0WlBRaUhY?=
 =?utf-8?B?NTRJRXpsNjJESkowTHZ1TEtnR3lMbGZPUlluU0Q0anpxWWhJNTh6ZW9jMWZs?=
 =?utf-8?B?a2VtUTVwUGhqYk01aDA0djdlQ3YvZmEwdEl6aktrbzNWMVVnZlJISkY0eVJ5?=
 =?utf-8?B?dnhBMHRNVzVIWWR3VXMyQ1ZNd28xMUovS0RyWU9KVU5TWU9Kbnc0SCthQ1Bw?=
 =?utf-8?B?TlVxekV0NkpESzR5TDd6NEdPRGxkVlUxZHI4T1NRNWplWjVEYktpc09aL0Ny?=
 =?utf-8?B?V201NldzZ3drcWR2R0hFTG5EYzF5NGlCeUVBakdTRFpud1IwZDcyWk9iVFkr?=
 =?utf-8?B?YXA1eW1LcWt6eHdyVjJEd2tGNnhSUEtBVW1uclNQeGhJdUFyYmpubHFIa1lB?=
 =?utf-8?B?eE5DY2kxMldQZ2RWdCtoWVFXcTZkaXlFYThrNWJvWjJ6OUFpUk5zbDQ2RWx1?=
 =?utf-8?B?REhRckZKZ2pSZUxDWVNuWndoSW8yOXl6RW41N2tiazBWcHUzaGR3dGkwbWps?=
 =?utf-8?B?NGZ5TytGVDJ5RXFWMkJIL1FNdk1LUVNEaDVYTlJqc1RKSWlNMWQ5SC9QeGZj?=
 =?utf-8?B?dmRVZVd5cnJJMXlvZnA4V2dVN1Baa2RocGl1dGxhUEVMOThSSGh0U2FqcXRt?=
 =?utf-8?B?MmcrcnRMZmxJSVdtNkE3K3Rva2xRUWJWdWZwUlV4UzNYMFRPeW1sdTAyc1RH?=
 =?utf-8?B?T2ZZYks5dHdOUU9LdFJsWEJlYnh0MWhteDcrNURZbzlvaVJIK052NXJaS1Fa?=
 =?utf-8?B?K3VybVQ4dEM2YzRpKzdoL0RlSHBhdk1iMEg4bXR2ZDQrSGwzSGZBWlhMdEVv?=
 =?utf-8?B?R1ZySU1ldzJjblIyZ3JoanBraXJUOTFNSEVtYjBYVFE4a1hMWXA3ckplR0Ns?=
 =?utf-8?B?N3FGOE1CUndqdnd0T2xvVXhoZ0dEWllVY2VRQTFiVS91aldvMFZhVDdHanFQ?=
 =?utf-8?B?TnpqN3lLWVVXSUdsbHhkck9nbDIrcUFOam1vMW1YZTFjak1VR21Ib1M0Wm8x?=
 =?utf-8?B?clV5bXdwRlQ3RlU3aUZROHh5dWZqZXNRWit1eGZKcW93MU84UmF0V2QyaVJi?=
 =?utf-8?B?SzBKSzB6YTEyVnJxbWNXYmdMajc1UGJvWlA5UUQraW9qbFdUSDh5a01ZaVNm?=
 =?utf-8?B?bDdXT0dxRGJQdERlcm9uWmpnRzRZZkdDcXBsblN4RlhoTDJVZnEzUUJ1RGIr?=
 =?utf-8?B?T0J4dis2N2o3bG8yZkRIU0VRUXp4Z0FSL3NuUjBTTFZFcnBwNXcwMkI4RlEx?=
 =?utf-8?B?dFB4S0xudjUwenNNT1lueHlIKzIxTWZEUFdXb0VVcTlad0VyNTJwMlVGam10?=
 =?utf-8?B?UVpIZDJWS0o4eWp0cnpZWGhMTTQ3dVRJcWN2OVhjZ0xXQm83bnRhbWtjZTc3?=
 =?utf-8?B?S015L3Vtd1VSdTlCdGxMRkt4ZXYzWWtNd1cxU2tKQ1M3L0R0bS9BZjFSU3ZC?=
 =?utf-8?B?bm82Y2d6emMvcXFyTTdwS04rdEFSVG1GSno4YlFEUzNicDdBMXFYMTRWd0Fx?=
 =?utf-8?B?Qk9LU1dxbzF4Y1ArMXgrUnlSZlRYYkdKaGlqTUhSV1h4S3hYajBuenkrMkNY?=
 =?utf-8?B?cmFuTVR6RHVmNS9jS0tLWG5qRUlpc0trQnJXamlSQ1g5MkVCYjE3VW1vNHh4?=
 =?utf-8?B?RHJNS2piYllBdG8rWTFhdFhqVXFQNVkzelJvSW1tV1FWOVRzQ0Z2dkxXc1dU?=
 =?utf-8?B?cklPNk1mYnJhajcrNUlrOFpxdkVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <563A3218C4E5014286ADC46A56E5C8C1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6HSQncLKMNTTjuyDQLSolSx9KKRcZa6+4nFv7V12h4MuNuR0cIhQZazsefT3yWDaZvo7rJ2uZRkEdpaa7VBYxg+xbujLEW2n7V2vkwvmFl1SdRtJZI/q8PLWZqSKywMAiNI+glx3J6mmxv3FZ0nN/LqImquComQJQYMwGiI1MPTmLO2F/K6NKaKVFJdTog/ZbEWf4QZAbJiaJO3V1kmTt5bss2k85rOcC1Ddq4U0yanr2Uj3j25JZJaoxh3gRDvSdpLZw85b9GbiAuE/Fdlt0DKOaOP0Lirt629ays6E6AHXRwA3Q2MK2DJWIxE4i2jbfVfRVEPxbmaqykwMK2TRRC+/9+MmwGrxmK/8WkRngUJbXvt4EgKVmH5C6q+KzOz1XZSbP+cg+eDWDY4+UfEjNKZ1uxbEYUEdLqGcwmpf++qg/w8L9HUZthV6RcN2Oe2+jlA40Cl1SjRE5lo3oWddW9C3tBVqCCa6nYpZ2xs3tybNpH4w2seIBegaWQlM49YkONLhcc7QEi7LLkPp4ygFb/SDeucx9rITLuhBg5vVzqqgt5xeyXPxVQPOko2ELN68PyMHojA47r+Ki7BBVc7TcItW3BiMcY3b7IPnyEegR4N/GAMN0d60hkbbp6LMLoZS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f36e899-4485-43e1-1bc4-08de274141c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 07:57:16.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7EI4rG9HT1FuV0yZHKm5GEHcRuoSOURFUtXUImOsd4hNw4IasdNgiJ8Ei7FGdkV4V2RKbMImwrCptfxRsLLUlUYfVq63DXiFrXBadaLV0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8925

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
