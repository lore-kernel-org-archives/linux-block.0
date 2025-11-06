Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0B1F92E
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418177; cv=fail; b=mnAomQ8hfm0dmUN/GkvPqyGej+peFmhGa1F2U8dwuIhQuFxESFdnG3QViLai/ACC2Y5VvFpODE+XpBDhGf2BOvI0yP6Njg861m+DmLCh9ufc1IVDcZQJ7TImXg5M9shYO92Dyv6ymNTSPv/uo0H5t7a0d3huluyuW1pTB7A1+4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418177; c=relaxed/simple;
	bh=APUdrZ4M1RD8zX8O7ijpO6F9N/Zn89MHFO8ZpJQ0O8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWYl+Vbz4sSosoF8UxwYX38R0VMjomGULKyI6jER9idOMrnFjRSYjhppsLDuH8gNjyRW6nXI04/HZ0NXlXf+84zLPZt2C6dsvU67jBR+/ndig+xMgacqwVWGnHirWETS4fTbkde5rz723H1IfXYP3t4RGrpYVk2yHMxWi6FtwiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m5hG7Sjh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ftTlvQ/U; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m5hG7Sjh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ftTlvQ/U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762418176; x=1793954176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=APUdrZ4M1RD8zX8O7ijpO6F9N/Zn89MHFO8ZpJQ0O8w=;
  b=m5hG7SjhvVjytavdb1mSZAzEPQPB/HhtZo3lqFvNDpCLLVbeFzb9PuIa
   3vqppmm+tH71eGoyOZX0VH+IYwNx0hMzQFUglLlTk+lGZD5CPVjVPLmhS
   w8Fje7tBwPtmAJo7DXpj7JBBENi15i6diS0fSUxvj/9azU6uytRhUbXDz
   RWFwVCs9Hw36IEOXNyl3F/sdOTCHqiuX5jlsKjy3idopmFS07BjPKx0MV
   fq7uWX2RgcU1i8ANaU4Y/OInMEr+XUryGoIadV3UirfpGbQQpJnvnm+h5
   keg2x1w/t9QnTxeRLAzWBAOC2AvsRCtSLd3T0lRb1anXGfM7uXsZd4DpB
   w==;
X-CSE-ConnectionGUID: k0q2H/q9SE6OMcvIFVlW1w==
X-CSE-MsgGUID: TIl+3vgCRK27oXXrvIINmw==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="135550800"
Received: from mail-westusazon11010058.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.58])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 16:36:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAKGp/MjYNWoBdCser/yfi03ee9JEQBnOkGXkkPgDccdw1TVrO7XgjkCDKu6d3CVcNMZ3sp9cTFMR2CXpxAdOJcn5GQLLbDqkaI7G2yxy6hvDBbjflDDxSki2eO/neW4nqapxoUUs3KgVkFZrzOZ3XM2i97GE2uibzlHtnUk961gKT9iNZe8Xlnftz2ITqdm0H/aQZd4nAR5t7Xnf08+3D4CqQiGP83eDmnKFANjT8yrDirPN37ANkU1K/+0GPl7wnokq++mIWP7eq8FQ4BTgbjIEEolrdoyyHq2mnxbBkZVBg1woTjznNBOJ9MN7wgjjWvBAJLyWMOxJLRAj+DhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APUdrZ4M1RD8zX8O7ijpO6F9N/Zn89MHFO8ZpJQ0O8w=;
 b=nmQRmtSNz8c07Tq1MSvxcZnwucC4ajTTxsswRmeRDXFvnwaf6ZVZgGekhfkpBQlfTdAl5X2Nu1Tl0G7Y6Xef7SO+VT+ESJohGoqKEml8hk+QL4umB4q5e/QvmIQ5DubiJy3Nh7BVotlB/70QdD7DoOC6n9/MfLoO71fv3ULoE4++wLFeMYXDxNAPEFbvXZp2mOH5b6FXWC3tQtE+I9l166O8nVMPRYrhyzSi9hWamebG8dktH3GMlw5u1yJzXU2vE4DZWdq8Kof4A4vMas/nh0/grLZ/26LrADSU8E8MFvdgmwiUnRo9qwIx3d7xejqKvY4QwVTO7dY7HYBYETc5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APUdrZ4M1RD8zX8O7ijpO6F9N/Zn89MHFO8ZpJQ0O8w=;
 b=ftTlvQ/U3Trl152SGqvPYNLsfJIeIlF7lXJ6Oht3V22vsUar+2yht4HY352i51ZW+MPiwwNwzRGlJOjp4KeP7m67z2PrTKn2uPgkbher9aXZf3pDHjldDqY70qCLhXek8KZmKKgsYr3dd32MfxWbwsfCL0cGmnX0d/QL0RW36Z8=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by MN2PR04MB6318.namprd04.prod.outlook.com (2603:10b6:208:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:35:52 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 08:35:52 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/4] null_blk: relaxed memory alignments
Thread-Topic: [PATCHv2 0/4] null_blk: relaxed memory alignments
Thread-Index: AQHcTsBu8QHkaPFl7UKwhTEK2x+DobTlUzaA
Date: Thu, 6 Nov 2025 08:35:52 +0000
Message-ID: <8e8f4bf9-34a1-4582-b9ae-7227c103fcff@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-1-kbusch@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|MN2PR04MB6318:EE_
x-ms-office365-filtering-correlation-id: a13d0ef2-6dba-4cf1-92e1-08de1d0f7ebd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0RPc0w0emFNVkZheVlBM21veGhNK2RGRmE3VFRaV3FiaVJQZFhydzJDSFZH?=
 =?utf-8?B?ekFiSnFSYUdMSGFqOEJldFd0U2lrQWp5REt5Q1BVM3NXNjZJS09IOXZGY2sx?=
 =?utf-8?B?WmUwM2ZlWm5pRUN3VkZLOEVEaFNCSWZRd1RkQkFzS0lWS2M4TndDVVhtYVU0?=
 =?utf-8?B?aURJcnVaZjNzZUpJN093bHVRVy9nVG9rOWJaYnphUXFlQ01HS2FSRmV1ZzhW?=
 =?utf-8?B?OWhXZlloU1QyaVUzaWVRUXpQOTR5STF4VXRVS2R1Q3dHWjlEdVhieUQzblI0?=
 =?utf-8?B?a3hXZlVpYStlZ2FPY1h0NEJzdThmKzd6YUIvUGhtaUNQTnQzVFJEMjRiMkJG?=
 =?utf-8?B?clRGN1ZqNDdvMUVna2ZaYS9jVGczUGRXMGJBQjZyalhsY1dUSldxZmRtTU9O?=
 =?utf-8?B?R3BmY3E2YklFdllJZWg0RlE3MlU5Z2M2TWQwY1o3TU8wVGNYRHNObmlRU3lZ?=
 =?utf-8?B?M081bUlra2hHU2xuM1hJQysxa1VFNUg0ZEdKV2k4MXlrdTkwanhkYTljQkpa?=
 =?utf-8?B?eitVeWk0SVB2WjRiYVdBZXVKNmlWZHE2d1h4aThaNm9QV2c4a2VPcVpxamM0?=
 =?utf-8?B?WkJQa2tibFVxb3phekFXQjU2alB2M0wweEgxTjBZenZYRktjMnFUZmRLT25Z?=
 =?utf-8?B?M1dmd1IxOFpaY0VnVjhEM1FmSjZ1a2NUWHRMSkxWeDN6L2VZREhnbEg4WTk4?=
 =?utf-8?B?dURNSnVkYWh5Q2lhWFYzWWJzakg5Y3dQVmY0RnVOVERCVERqcE1IZ3lPMXFz?=
 =?utf-8?B?a1N4QWZBSVgwVzQ2ejFidzNqdFVNeFRmZUhLNWtsRFUrbStEaUVmM3hycjZ5?=
 =?utf-8?B?dFpjQ0RFVk1HTUNYblFQVSt4dzdEYmdLSzhIZzVrU29rb0wrTmJBdVdOd1k5?=
 =?utf-8?B?MnNVSEkrRnBwbTVSOFoxa1F6aXRRN1M5cnp6YWh3VjlkUnVFSWFuemtNaFc1?=
 =?utf-8?B?UnVmK0JObG1LUHRQYWpvSVZ0Z2hxSVFlWE8wcU5GY0o3TG12MmZac2txZy94?=
 =?utf-8?B?RG03VVhnVWtESmlWZEYxT3k2OVUzUUVpcWh1QXoxbnpiK3ZOUjUraXAyTFd3?=
 =?utf-8?B?by9jQVMrRUp0eGRsTHNVNnp4dVM2NXRyYU00YlhXNXlKOURyR2ZnZmtBU25r?=
 =?utf-8?B?eWgrR1JWZWtpZ0dYRytnTUg0NmJ0Rld3OFcwUHZwRW1mZFVqSlBzVytiQ2xB?=
 =?utf-8?B?WTB0eWJuMHZCYnlFdnROd3ZTUWtQS1JVdC9taGJxdHpCbHM0Z2tqNHRoNExu?=
 =?utf-8?B?M1p1WEdTUzJjUFdtdkhnQ2pwNThPN3ZWekJaak5IM2FwNkUrVk41YStNU1pr?=
 =?utf-8?B?cVExaXNxV2VIK1dSYW9wVDBFL0dnQ0JPZ051UXpacTY1RDVhN0hYOVVhcGZT?=
 =?utf-8?B?UE13UmlHYWRseW1WSXd6VHQ4MDRjNXB5bGlzVTFYR3dDVmNKV1IvVk5VT04v?=
 =?utf-8?B?U2hNb3VOWWVmVE5ucElNcUdtVWNOS2FzMFJVblZ6ZnBweU5OUjdYSmZGRmNM?=
 =?utf-8?B?d0NjcE9EbmpVa0lBeFFzMU92TWlxaDhnRVpUbEFGZ21PQ29VR21YWmluRGNo?=
 =?utf-8?B?T0lsc2VmWmgzUXFmVEYyL0hTNjVHTVpVNUxQNDZTUTFqODJyUC9weTNNUmhO?=
 =?utf-8?B?S1N0dllodStzU2FiK0s2K2xkWmxzeHNPdjlUNHZ6d2xyQkw2VkxRSTFLRVpD?=
 =?utf-8?B?bTRiWTYrUjVrblJnRVBQNGU4RmV2Q2FxbzBabmtaRXQwRTYrRjZ4elJNa0NX?=
 =?utf-8?B?STFXNllhNnhFeFhDN2JadEphYXIzeENXMTZPaW9vMXFGcXNOVmU2MUtPdWF4?=
 =?utf-8?B?SmlPeE1QbWNEbVdaanVzY3BsaXFhVU9XYmlWVUtobGZHdldvYTRBNXY1Vy9t?=
 =?utf-8?B?ZS9YRHo4NDAyN2dPZ1g0YlpUTDM4MWhUWHZVUk9FWnR3dG85RjlKY2MxYjgx?=
 =?utf-8?B?R1RIWGZFcG5iemZIdGxZOTdxdVlyZldtNnZObEpBeUcyYk5BUnE4ZEdIN1lO?=
 =?utf-8?B?UTRIcjlxeHAxdm43eDFtTE1jUFRKV0VMUHRRRTAwdjQwc1l6SWlLT1R0ODNp?=
 =?utf-8?Q?puAj+w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUtPK2dIdG1KLzk2YnhnZjJRRU55VWpETkMzbWFvdGFqaUoreEkzM08zampN?=
 =?utf-8?B?eTJ0d2FJWWVSU2JUY2Q2RFBlSkJOeTZzbG9NUW01K2NyT1dxYy9YY2hUSEQw?=
 =?utf-8?B?ODNJMzRtZk8rZlFIMTgvaGVtMmpiVjZZV1IvbXdUcmtZQjJNbkJjOXV4V0hv?=
 =?utf-8?B?RGlUdW1jd2d1SFNIelJTTjBzTXF5SWYyd3dCNDVuT1c4cFYwMnFHUmt3RWwx?=
 =?utf-8?B?bjFRZTZLbUhxa3NPeHoxZzZrOFhlM0pSaEhka1Z1cFcxNTNnTDZNVERYZ1FZ?=
 =?utf-8?B?VWZoKzFSNnFQZ2FUeisxYWtFb1NJUTlHbGxYRm14NkluWlFOdGJsVmlCOGpi?=
 =?utf-8?B?QjZLUmxEUWdWaGJoczBGU2lBbHg5UHZSSlVmVDN5cmhNaC81TjVWNFF0RGdY?=
 =?utf-8?B?UnhZbENDUmZQWUNLZ0hrZUNLcUJ0UGdhRnZSWHozNkNnVDZSTjErK2xhTlJX?=
 =?utf-8?B?RXZuaGNESzc1SUVJVlpzMUw1TEhYVWREb3JzRWdRaGZIWkdySVJZcVF0L2ND?=
 =?utf-8?B?WWsyMlVQVEZzK1FIRVdGM0NRWitNUldEUEpMNjZQT21PNXdBTlc2eGlneGFZ?=
 =?utf-8?B?VTF4OVNFQ29yL21HQ2tZYkwyYWlWTlplSkpramk1VUozTnR4ajRKQXhtKzZ3?=
 =?utf-8?B?SDA1eTRLUmw1SWtsN1IzQkk5dStLWnhQZC9kbzZLYklDOUpWaGRTY3pVMVhG?=
 =?utf-8?B?alpIZHZvczFHR2NYSjVwaGYzOW0ydFpvOGRJSHZZNnlaQ3VZMmlBQlB6K29Z?=
 =?utf-8?B?My90RlJIZld4ZGRlUVBTdW9VcG9ZMUt3RlF1UnhLYk9HYWJpSUp0MFZsL1hT?=
 =?utf-8?B?eEMyQTNaNnp1dVMrTjJMbllMYUtIYzhYN3NVK3UrTlpNU2NUcUhydmlGY2l3?=
 =?utf-8?B?aFdzWEN3UXAvUjZqNXd4a2hqTjVNMWNwbkt5T1A3R2cvOW9Dd2pDMVl5bFFK?=
 =?utf-8?B?QmF0bDB2Tm1DSEhNZk9zSUdUaHBObldsOFlaV0xzWVdHSzhqSFVFS0tnejBx?=
 =?utf-8?B?ZUJqM1g5MEtvelduVDdHL1V3cjA2a3VrRThZclBnNVBjSzQrSFlEYWhySHJo?=
 =?utf-8?B?QmN3ay9tUDF2QmFFR042RXJhR1BSZWlEVnBibW9sbVhjMVE3WXJxUENFWnBl?=
 =?utf-8?B?alU3aCt1K0dMNG5BZVM2ZFB4bFBxMG5GZlB6ZTBxRzlGYmsxZzBqRkkxTVdX?=
 =?utf-8?B?Zm9uWDNQa1VMODczS21naUdTWll3ZkFCQkNCZmdCNFBPTFhBbmhXWGx3Y2h4?=
 =?utf-8?B?THB4QkI0R2Q1eFloN01YaEtRS3ErcXJ5RXc3L3QvOG9tdE9ZY0R0cUg1YWpN?=
 =?utf-8?B?NWtId3dweGxHN213Q3dMMm1MK1drWU44S25HUFJoR3BWMFFtalNEWFZmWk5w?=
 =?utf-8?B?cXZvMXFDUFV6bU1mQStLQ1c5Z1BIbFNIVmJoTENKRXFPNWlrRDl5OVZnK3RQ?=
 =?utf-8?B?a0NlQzFqVnE0YUJhQWthSDhQOG50dUZjWHh0RTlmU0RRSzZUVnlVRUhFdFlO?=
 =?utf-8?B?RkFieTNwZGVDSXFRV0xGNWFxY0pqemJtMW5KcFN1Q1FRd3Q2dVk3YkQyVkYr?=
 =?utf-8?B?ZE1WTEgwc0o0TTQ5dVdaRGtlY2dKeFFUUHJwOFQ3U3o3REZtc2g5Q1gvRUk0?=
 =?utf-8?B?czNKRmtGbm9CVjMzckVNdFc2c3F3MWZrNklKRllyakc0UVBkazZhS0MrZzFx?=
 =?utf-8?B?MXowMG9TYW5CWGZLazd5dm15OVE5Y2hvbjFuUjJ2dHBlMDNSd3NYVmsvYXJM?=
 =?utf-8?B?M2JTWnVUMUE5WVYweFZiRkdVY0k4bklZOHdtRUJ5Mzg5djlpR2dhVlFUQmY1?=
 =?utf-8?B?U3krcCtsaTl5Q1B6L1Qxem5HR3RsaGZRYytkeHA2MDQ1NHdVU2xYUllSUmFN?=
 =?utf-8?B?YUllOEhGWDNwTnQwckQxRUlZYmJ5dGV3Q3hkWlZPeXdsRVBWS0QvTTRqSWEr?=
 =?utf-8?B?OGltSkJtQ1FQbXRjY29aMkc0SjQ0ZytNRGVBaUQvQ04zdVl2VzUrdkFPNXhx?=
 =?utf-8?B?Z3kzUENWQ2dxTTBGQVU5bW9jRW1HMW1FeXRWTWQvbFQ3NTBnVDFRSzFQaUFo?=
 =?utf-8?B?dGEzRWlYU3FjaEs5aENFK3JNOHpmKzhDV25iN1BRYXJPSXA5YW5tR2liN2RY?=
 =?utf-8?B?YjNsbDBVc3ZuYndWNDZGYXowR24zVVNERy9MMkpGTWJuMU5hZ3E2VUhTTzNk?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDCCBEC33517E84E93C4427693E3964C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nnbZR7QcpIrxrg9QkDEPmOE0dvuHzSTX13x7iQmfqXAY1m41V36/zud0vhw4yCZPFXOPLRdW7ByUKpJr4k9fjFCBC2JnG7Q93LeVIuY0nPrf5PvepiKa7MfBxWsS/8CEy5IfwsgvVdjWr+JSM7MwZdhYknpo8j+WZUI4gLjDmEd4eCBFKFAXcPe68g5ftAhL5xwQa2hRgD7vugpm2B6AZSHFdPQbBeEhOn63JPsClm7R0zrbuA/W6hBpFk0tzNMFo2kIRbSEelYenEcD2Pm5ZliDvgA3FxmaFG1uXbDOi4uPU9aCXdAlvoilWylRKljjK/UixORGANjRwOokCbuHdjLS24hHcN4k/eeu4mOtgjAlPOXipxiyOl+cC0ZZOYSRy2T1aE614JJH74a4R/I+YVhBVVTZDlZeS6rbKOKEsXQ1zOK29Rq4+UrCml8/QKVqSsVThPdh3fXalsN8mAAPuJPMYv0ms80pXQKH2EjQ173E4z+kjacT+eYFqChQ8SDVVzMyV5CvCWpANssEJI5TqX+NhX+NICQDDleU9jy4lCsWOImHR80nnujkC+dHVZB7yI/Iajay+x/ffWNM0lzeLn+kQ1go6QhSqVHCTPdmWI421G1IuBkWHI4IMR+bSPGS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13d0ef2-6dba-4cf1-92e1-08de1d0f7ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 08:35:52.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEWYyqAkYZYAECWrnr4uyMHhcXaBL0Y3qT7IPm7FiNaGht328LbLO/JqMtsehIKpXrT+w5udw/y/kbpKsJahRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6318

T24gMDYvMTEvMjAyNSAwMjo1NSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1
c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBkaXJlY3QtaW8gY2FuIHdvcmsgd2l0
aCBhcmJpdHJhcnkgbWVtb3J5IGFsaWduZW1udHMsIGJhc2VkIG9uIHdoYXQNCj4gdGhlIGJsb2Nr
IGRldmljZSdzIHF1ZXVlIGxpbWl0cyByZXBvcnQuIFRoaXMgc2VyaWVzIGVuaGFuY2VzIHRoZQ0K
PiBudWxsX2JsayBkcml2ZXIgYnkgcmVtb3ZpbmcgdGhlIHNvZnR3YXJlIGxpbWl0YXRpb25zIHRo
YXQgcmVxdWlyZWQNCj4gYmxvY2sgc2l6ZSBtZW1vcnkgYW5kIGxlbmd0aCBhbGlnbm1lbnQuDQo+
IA0KPiBOb3RlLCBmdW5ueSB0aGluZyBJIG5vdGljZWQ6IHRoaXMgcGF0Y2ggY291bGQgYWxsb3cg
bnVsbF9ibGsgdG8gdXNlDQo+IGJ5dGUgYWxpZ25lZCBtZW1vcnksIGJ1dCB0aGUgcXVldWUgbGlt
aXRzIGRvZXNuJ3QgaGF2ZSBhIHdheSB0byBleHByZXNzDQo+IHRoYXQuIFRoZSBzbWFsbGVzdCB3
ZSBjYW4gc2V0IHRoZSBtYXNrIGlzIDEsIG1lYW5pbmcgMi1ieXRlIGFsaWdubWVudCwNCj4gYmVj
YXVzZSBzZXR0aW5nIHRoZSBtYXNrIHRvIDAgaXMgb3ZlcnJpZGRlbiBieSB0aGUgZGVmYXVsdCA1
MTEgbWFzay4gSSdtDQo+IHByZXR0eSBzdXJlIGF0IGxlYXN0IHNvbWUgZHJpdmVycyBhcmUgZGVw
ZW5kaW5nIG9uIHRoZSBkZWZhdWx0LCBzbyBjYW4ndA0KPiByZWFsbHkgY2hhbmdlIHRoYXQuDQo+
IA0KPiANCj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiANCj4gIC0gQSBjb3VwbGUgY29zbWV0aWMgcGF0
Y2hlcyB0byBjbGVhbiB1cCBzb21lIG9mIHRoZSBlcnJvciBoYW5kbGluZywgYXMNCj4gICAgbm90
ZWQgYnkgRGFtaWVuLg0KPiANCj4gIC0gRml4ZWQgdXAgdGhlIGJ1ZmZlciBvdmVycnVucyB0aGF0
IEhhbnMgcmVwb3J0ZWQuDQo+IA0KPiAgLSBNb3ZlZCB0aGUga21hcCdpbmcgdG8gYSBsYXllciBs
b3dlciBpbiB0aGUgY2FsbCBzdGFjayBhcyBzdWdnZXN0ZWQgYnkNCj4gICAgQ2hyaXN0b3BoLCB3
aGljaCBhbHNvIG1hZGUgaXQgZWFzaWVyIHRvIGZpeHVwIHJlbHlpbmcgb24NCj4gICAgdmlydF90
b19wYWdlLiBUaGlzIHBhcnQgb2YgdGhlIHBhdGNoIGlzIHNwbGl0IG91dCBpbnRvIGEgcHJlcCBw
YXRjaA0KPiAgICB0aGlzIHRpbWUuDQo+IA0KPiBLZWl0aCBCdXNjaCAoNCk6DQo+ICAgbnVsbF9i
bGs6IHNpbXBsaWZ5IGNvcHlfZnJvbV9udWxsYg0KPiAgIG51bGxfYmxrOiBjb25zaXN0ZW50bHkg
dXNlIGJsa19zdGF0dXNfdA0KPiAgIG51bGxfYmxrOiBzaW5nbGUga21hcCBwZXIgYmlvIHNlZ21l
bnQNCj4gICBudWxsX2JsazogYWxsb3cgYnl0ZSBhbGlnbmVkIG1lbW9yeSBvZmZzZXRzDQo+IA0K
PiAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMgIHwgNzcgKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9ibG9jay9udWxsX2Jsay96b25lZC5jIHwgIDIg
Ky0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9uDQpzKCspLCA0MSBkZWxldGlvbnMo
LSkNCj4gDQoNCkkgYXBwbGllZCB0aGUgc2VyaWVzIG9uIHRvcCBvZiA2LjE4LXJjNCBhbiByYW4g
dGhlIHNhbWUgcmVwcm9kdWNlcg0KKHhmc3Rlc3QgeGZzLzUzOCB3aXRoIGthc2FuIGFuZCBzbGFi
IGRlYnVnIGVuYWJsZWQpIHRoYXQgSSB1c2VkIHByZXZpb3VzbHkNCnRvIGRldGVjdCBtZW1vcnkg
Y29ycnVwdGlvbi4gTm8gaXNzdWVzIGRldGVjdGVkLg0KDQpTbywgZm9yIHRoZSBzZXJpZXM6DQoN
ClRlc3RlZC1ieTogSGFucyBIb2xtYmVyZyA8aGFucy5ob2xtYmVyZ0B3ZGMuY29tPg0KDQoNCg==
