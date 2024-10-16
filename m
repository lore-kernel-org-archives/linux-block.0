Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1C1B3941
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059233; cv=fail; b=XiVrpCfAPD2evmEcH/6v0GaK7vuoeCcMlTBWLHKMYjaWrGSYBKPxbYdYEGRRME1KGJP/fbOJguoviBVkBe0sHXgCuD7Pk2TkDKy0SvQd1ix0I0mjHZXJiDqDRZgrMKXASbJV+SgUCmVgPYprJE1xbgYOfsD+gfQW2wlmj92/c+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059233; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikOjPda70hXPgLCgDG98U5zCIrhiThT4gMapMrJ2u0ukxk3YMr7dj7cmFpzRLXw8lUTLnu+r5c1TAnn7+f9DhhMA9XctcjLJukLv/Hj8Lxdp/h8QyHQ5+qotyUhPf+zUObkGg7ueVYg9pTk917KeyW+UNxXeDpBsw6mpMSBJCDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JSpSSeyZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZCXkcxdq; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JSpSSeyZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZCXkcxdq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729059231; x=1760595231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=JSpSSeyZhj/Ss4cROQJZTFJUKK7yYFcWjoHb60qjxfYA8tDr0zuyTzOs
   gsIVBrEcrIXixiQcGXOIlc+i0UzVHS/HX7nC4X9UcgOAOoCZ/6Jx9Ny5b
   1usa6BWZc/jbHvQ4WOwPx75dOP2iA/+ttDnx97t4Mg4QexfhuLKypgJdA
   Ksy6sWFfis4DYA5Rxpl9pMVFJ7Rjqo3nKiP1W+5TU8grCNyakvFxb8Ald
   ZF8SrOKvuTb9tN6+ju1zLun9MqS+KDc2V9dop5vdvnObg6g1bSjG9Fz1w
   ZMrig7P96FaVb/lJLHW0C+eqLTset1SKh/6LIAGTZzp2rDLGSzfGV8OAT
   A==;
X-CSE-ConnectionGUID: m/rngYscRHSo9mIIlzwXzg==
X-CSE-MsgGUID: HwoaY9AvTU2ppm7zfdi8Qg==
X-IronPort-AV: E=Sophos;i="6.11,207,1725292800"; 
   d="scan'208";a="30009382"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2024 14:13:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwpiv8O7hz84X47okr6J/hJjHS8QrwmGD5AoYtTTFzpJjIiteoKCDF19LROwEcArXDYmaxmr1OCL3Ea566pa1s4IkEMUz/En/TaxGFV8HlUORx7i9WnW3QAvZXStvrTFzD2HnQY2CE2iQilTXzDL/TsuujLCbm0x31kVCXTFvXDvjA0cKXjyWCKljb3GUjU1BEWwh50PHXRoCywXvaIuwNBbZAgUrlJqfoR5v1cjxph/5yAMJlVnbOEJrYtn1DE8Ek7a1WhUJ1UIQ09+NDAUTayA1bIvK/VSxzuZa9FcxkBr/l+WbQQr+f9aERFeTzYA7rK2vfbfFjyLLBk5UeTwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Tq4acHElkaIrafthWXHi7Tkn7EhNwGPFcq4uRzreyvef0bhv15FP6sUTgBpgcdc0J306+hlu0moPSZQ8WUZ7pyaGj2TqIdVzcIC/9ryJBl6mBiYWktEkex7T9Zb69MFyutg3tU3MLqsUMBgmT/Jt0h+9wA2MykYy86UyWx0DwODqn/Pht4ShQxPcl9SM83DbqzYUykdzR3FRWrpwxt+7I/irsSVrlA0zGQtCFGXD0kEXi5gjrDOI+rgMVJUmTybcLHhVlCbkWtygRJgqAgOeTTuyE3DP5r3mPpK4XGpjJdKcIsY0DKdrE5jdfDCM3RSrEv0BBnycQt1a0+UQ/92tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZCXkcxdq7bMEO2T5/H8zj34lBw1fBRjuKPv3Wr127AZKLyF3yKbDL543nTfju89kW+jFUeaIVnIqkcf93Wl4UbjVqDnLiYvoDN0jMl2Ohzr2UOrIcIyyLCDb9Brk2W23B5GhBkzVeU1Kx8c2drRXFUdWGHxlJVqMcsEMmbR29pY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MW4PR04MB7379.namprd04.prod.outlook.com (2603:10b6:303:7f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 06:13:42 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:13:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Omar Sandoval <osandov@osandov.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "kernel-team@fb.com" <kernel-team@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs.
 rq_qos_wake_function race
Thread-Topic: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs.
 rq_qos_wake_function race
Thread-Index: AQHbHywT1yXETelu4kqFnVzyR+R9hbKI5r+A
Date: Wed, 16 Oct 2024 06:13:42 +0000
Message-ID: <35919a8e-6bd9-4fcf-9e09-985413a5e49a@wdc.com>
References:
 <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
In-Reply-To:
 <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MW4PR04MB7379:EE_
x-ms-office365-filtering-correlation-id: de0e0a43-8e5b-4343-6d52-08dceda9af24
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEw2Y3ZaLy9haVJsNmZYa1I1d25ZV1YwUGVRTFlZUXFtekVzdm1FMGVQOWZJ?=
 =?utf-8?B?ZFZXbytVS3AxaGY5WUN3bkVhMnc1dy81YUVucTFCcVhjYzU0MXpCOUtUR0JC?=
 =?utf-8?B?N0xJMFZydTRTOWkxSk92Z1hNNSs0MW14TWVMcnB2YkRGcVl2Y0F6TWJ5TUxy?=
 =?utf-8?B?UUtpd1FKS2gzSVJkYU1PU0trSHBNa0hsZGF1bHFEdEp6OU1IOEhrQTZOZlB0?=
 =?utf-8?B?WmdLcVFCMzFLMGpPRjJaMnY2YWQrV3RHTG1CcnozekdiNGwvYytva0JYK1NV?=
 =?utf-8?B?bDV4VTdVREVQQnQwT3dnN01SR3ZWaVJ4VzFFVmlnemg4VWhQMWtOUENaZWd5?=
 =?utf-8?B?dnV2bzlldGN2NjdaaVRSZWZhZ1A3c2xkSloxc1gwZzJnT01mazB5RjROOWVF?=
 =?utf-8?B?VWRsTkxiRFhJUnBVR1VZU3lMYzlaSmR6VDAzUXpjU2JFYXRSZEplOGRhbHlE?=
 =?utf-8?B?WFA5K2RVZ3lFMU40d1M4V2lJb3hNWmlsaVpUQXJVT1ovTGJ3TGhHQXVpbW5K?=
 =?utf-8?B?RTJUQjYyZHloVUZIWmh2YXlzZUNna0J1MjV4RDI5dHRLSGl4RU55YXVHWnE0?=
 =?utf-8?B?b1NyQ1hTUldFeFpXbDJGNW1ZVmhoRGQrMDdSZWh5d2o1VkZiMUlPYk5QY21Q?=
 =?utf-8?B?NkUwZGdHMnlkSnAxTHN2VWhRcE9PaUlCZ05yY3g2dFA3aDlGNjJPckF2Nk5w?=
 =?utf-8?B?K0NESHZ3MHovN28xNFZraEExUXdBZldoeWJDRnNPQStKeTBTSktpazhEd3R6?=
 =?utf-8?B?K1lsWW5SZUUzekdUK0h5UWJvcEZhUFFaVVYwMmlrRkJQeUNSMkprR1JNWVlm?=
 =?utf-8?B?Z0FFL1BsczhkUjdMSXZiOXluTnllODE1cTBUVENYU3ExaVVqdURVZnJmbldJ?=
 =?utf-8?B?ay9OOWNsZWJ5d3dvRDJxRXY2c3V5ZDQxbllyUWZmdjR6MzcwQ04yOEUrang5?=
 =?utf-8?B?ZXMwSjF0cnhyeFFZWDh3ZzZHWFJSU0RaWlAxOFlSZ1VJK0VJbWswOXhSMWlP?=
 =?utf-8?B?MlN4SHR5SXhRbHZWaHJ1WmxDS0V3R0d1ZVFVaUE2SnJCamthWHFteXhEaHJX?=
 =?utf-8?B?MEVOSFdyRGNxZnppNDQrd2hYc2FNTFordURzVFNCVW9jSDgram82N25vMWxk?=
 =?utf-8?B?dXNaaGpIQmg5NmZGdFZzUDRVV1BnVjNSREJkYkQ0bDNaQzdCeUpyeXluYTZ3?=
 =?utf-8?B?K2tQaU1sTnlyZ2hqMWVZVUZvRnR4eEtlRW1NZ2JxaEhOU01jMFR0cVJxWVRN?=
 =?utf-8?B?ME5kaWs2c0tHdlpzN1NUOExqMlNyQ0RpcFI0M3BjMWhUaW81VTlSdHJFSXBa?=
 =?utf-8?B?MERacVFrWmZaTVI5VmVOb2c0OTczTHFJOU5LZFN4V2R5OXdqR1JibEVSSmFy?=
 =?utf-8?B?Z0Nlc2NtY2xHNTk1djRCZlU4TEQ4ZkxnMzNrcGwwcXpQaHFEUEZQakZsR29z?=
 =?utf-8?B?VWowQVZmcTdqWnJlQVBrUFdRUU5MY2d4dFFOK2l0NzZQQmZrbDlya1BwTndG?=
 =?utf-8?B?MC9tektHeDhGaEk5amQwRWJ6bWMwcXlubEVkTjJqTEtNcUkveTF6ZXoyM0NO?=
 =?utf-8?B?d0pkOVBxM2U5NW9uU1R2T1VmeXAvd28wd0x6NHlSVFNkL0dNRUoxajEwN0gv?=
 =?utf-8?B?MXdhOHpzbnkwT3kzejkyU1Q4eUpyOW5hZHJQTVZ1am15U1NmVEpDTUlpT1dh?=
 =?utf-8?B?d3k5Zy9SVFpDUUI5U3pHa0tFRTRLeFZ0VHVLZm9tL1pHbTNPN01yc1JGVmdn?=
 =?utf-8?B?RE4yQzlITUkwNXJmZmwrSEhPMWlBUStiZjZ5TkFidHA2d1VrcUdaeC9Ddk8v?=
 =?utf-8?B?QW1XWjU4REhZampEeGQvUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlJwWlFjVmtRaSs1NDhCSTNvaUREQzhKL0pON1ppRnVhOFRESlg2VEZqUXBB?=
 =?utf-8?B?L3RDT2JEWFJsVXA4bTRoN2V4eTB6ejY3b3N6QUlSTzA5UU1HMFJDbW5aMHVo?=
 =?utf-8?B?TytHWG9paU1CQVFKQTFzTmxrZW51dGtiMDQ1VjR4dC9namJGQi9ncVZzNHlM?=
 =?utf-8?B?cGYvUXltN1NvTHJiSUVRWUZQZWt0SzJGUmlsaE9LOEtJdFhvOGdiLzhRVnRP?=
 =?utf-8?B?cUtrdmtwaWtlUHVvanE4YVgvL3NLeWp5eVJMTzROQ2swSWp4NUVobFliRWo2?=
 =?utf-8?B?WjF5dWVZTEhoNGVlV3dNR0JHMnpaY2pGMG5MOFRZWkhnMkJCenBoZE16bFdh?=
 =?utf-8?B?M3c0OG5hVjZWemttTXdKR1ArRGxDVHVKSCtOdC9wUnNQNXI2YmtlSTV0Z0xa?=
 =?utf-8?B?Zyt1TEN6S0FPZmRhQTBuZmlreGJkc2dnMktMZDI1dENpUXFwUWx6cVM2RGN0?=
 =?utf-8?B?RjVTRHNna1ZTWGo4RWorSllkT1F4OG1SK1pDalAzOVJ4cHFRNVl3VXRZUWNG?=
 =?utf-8?B?QU1sKzVRdE5RR0o2dC9scVJSZjhtRzRwTlNJV3IxTzM5NW5DT3VSSDBZUHBU?=
 =?utf-8?B?bDNGY3ZhN3BkVkJQRXlVVHZTWkFzam9qTi9nU3BpbWU4dW95UEthQStRZUw5?=
 =?utf-8?B?SmlmTkdiRi9xNEU0eEo1aFpWN2xvK1A1TXpBOEUwbDBqT05uQUJMODFXS0Ry?=
 =?utf-8?B?WUJPQUFsdFFWakphcEEreUVXYVdjTFd5ZitiZDV2MVVHc3BzTEtseDZ4cjFZ?=
 =?utf-8?B?RFJRSFlJdkZvWk5NTi9jOWdkcFdjOWEvNElOZ3JwOHlMSUloaDBIMFdWY29w?=
 =?utf-8?B?T0hvR1BnL3M0ZnZEejFNWXlUaVF2M2xyNUhObGlma29UV1owR1BEN1p0RWdU?=
 =?utf-8?B?OTBiOElwWEFOdlQxOTRkUTQ3Q0IxWjdGaVd4WWZyeThnYkF6Y0xWZ1VPUTJB?=
 =?utf-8?B?azBUZG1iNnl4eTdaS0w4bEFXNlZRcHZjdEdQR1k4R2VJeFNiSFJ0Z0k1UndR?=
 =?utf-8?B?MDJaQVpPa2YxTThXbGlsU0FWZnRRRXQ3WVY4QVFrSGcra0FRTzA5TitzbUp3?=
 =?utf-8?B?Ly9DOTh0Z2F6Y1dYRGVhVWJQQXd0T0FMNlhQek1VWThuSE8zTHJCVDM3N2VM?=
 =?utf-8?B?U21Mb3hZREFtU01KYVRRRE1yS2ZXTm5jcm5ZRjVRRytXanBEUldFN0FwNm0w?=
 =?utf-8?B?U2oyRmdaZU91SmxVWCtnemZDOFZCV1hvM28vMWdibVhYaHpGalk4dDRMREtB?=
 =?utf-8?B?ZDNhVktVcGVxVU9LcWR3UVVNdVFEaTgvdUxMTUZqS1A0WlhScGV6T1FzRDJn?=
 =?utf-8?B?eFpKUmloKzVaVEpHditqTldBOHlFK2RmVlVmdXdJUjlHVzdSSUtWMFg2ek5s?=
 =?utf-8?B?bFdiSEtuRytPRzBGSVlxYTNzSUF1eW45OHZYSmRlSnpIUi9zVTFxTU9hanRY?=
 =?utf-8?B?MTFTLzIrMnRBREJoQUVVVWJwYzZGRW5iYkZkQlUxRzkwVHpDTVJXZ3VLd1NN?=
 =?utf-8?B?WS82d0h1Z3VNSVVrTys5L1hHVXR6NTVTM1pJRXlTSmh3T2ZIS09HajFDdzhr?=
 =?utf-8?B?bTVWZThYQTUxVFNHWlplVGdkeDdteDlxRGJBU0hZNjR5NnRvMDhLWkp1aVJq?=
 =?utf-8?B?d2liNzZwZHVhRm9Ld3Y3dGxaZkl4d2FtMnlVaGZDd1U4ME1IcmFJTHFBU3o4?=
 =?utf-8?B?eUFlR2ZRMWdIeVIzSUdQbjdKa1B6SSt1UUphNVFudXBRbTQ5ZDdJcFkzZEkw?=
 =?utf-8?B?TWpUT0Z3TW9aQ1V6ak51dWRDZjlzU1NMZVM4TGRzcmdoeXRWMjQ2RGIwc2pV?=
 =?utf-8?B?WGhIQW5Ba0lxeEE3bGVzOUUvZzQrK2pYOGJLWXNGTGNEMmhlSVBmQkw3Wmhv?=
 =?utf-8?B?eEFSb0o2Q0I2WjlQOTloeThxMmlieCtzbHNDZHUxVGVzRVhpbTVwN0dPRmZP?=
 =?utf-8?B?a0JnTVAvMzZJUEtRTTJFdVhlMVdIcHpKRTlIOGJWc0l6SlBZclBKM0h1cm1q?=
 =?utf-8?B?Z08wMU16SHBHZzUwMzdtdlBnL1ZlVlQ5QktHcGRLWEZTQjF4TGhNaDhaOFRZ?=
 =?utf-8?B?L0JnY1JXdjlFREdSS1MyQXZFU3pPY24xOEhEdHc2U2h2blg2bE5ZQzg4N3pC?=
 =?utf-8?B?OVNZR2NvMWVETEREZ0VMUy93RjkxRG8wbGFVbXovVWJvWjBzUnFOTGdpaHFU?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1251083AADA6834282168776C35DB8D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d3XVid2nvQkgGXWht4zwT1S0kxEa07tjvc94LLMEGnA+iWP53o4Y/CpV955zxwWf5br4lRFMxuiWBjU4r114KF+c4UIvvjMgvo04LTqP7u2c+u6Q2kxsIpK3SwR120GCmOwi+5jM+y2R+0H9rtfy6Tb/TIr3QIvsOWvqZ8t0I3fna6GMWBN1yhsmHBPFQ0veTGo0SohWYGSpesT+DUYVppN5ynsuQpGiQFNlbBqmQC1m29owCrpPvLMYgkgK6YXRMBDbSeM3bOl2QRqTaWlsIwps8A2mZZakEumv2b4lvRKRqb6vY17iGtWIcIlI4ECOqAvvoXDRAqmchrsK0MVNpeQmLBB75MUFL8G12KtNjfM3SHGOg54v32LiwdpjL4e9M6mxP9RNMM7oBY2cyuR0knVOkJQCmYRNLwVU64/04qD3U1Xg6cqegJvSPV9uDYJw53vpU0FS/4QLvPNe2SRc9WRBNMUTSheRGog0ZP/7t9eZK1l2PEc+a9j5KwzPc/wFN+F5TbFsC9y+W7l+56P1U8orANvNQuN7Wa/SEba0dpVHuAk8R9Gi5mScmGFM8fDtHjUKsmP5cXeKbUdp0Ka62KM5yXZpnwlqSJ+mVK89hG2Bx3J8WsdGBFJIazlmUonK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0e0a43-8e5b-4343-6d52-08dceda9af24
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 06:13:42.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+m831MDoH6BQCqNXEe1pQb2uii7lB4fqAS2EtkFsZFADWlH/GNmYW/J5F1dIYEKRPFXJ2Y+tzFbWY2iC82Mc8i2HA66qBxfLXC8vQBJiME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7379

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
