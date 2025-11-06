Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F330E83F
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428131; cv=fail; b=hkZ1y7wPN1uS7Ihl8qqjie5hFpudVKRapqEXGLUUzLwlbXMNAoHxVV9okxj6SMpylpRgFJpTymYrrV+ealEnQ2ITMlzItXMNTqb7IdshxU/EkDP931nrlwpdoYSv7asFalOaIqb7wFqWwfWIe/nJ93SlfA+5mjdthYJo8BFKvX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428131; c=relaxed/simple;
	bh=0znIqX6db17lQoHGHWPLwYp81JyIEMruFAR5ZGs26so=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTUFU564Dg1KgcfG8Vdkt70kWr+shAk2ilndg02J/JcaC5gGPDKUroBZv6Zo0sJoAqwfzzqp5AKQls6G0FDzwYjUu4Xm4tIzaWcQY9anYyKWH/n5yxzkHLOGfkdD0HAdAah5qQFTBUDnb8/i9D3A3/qGIQztSaoTSD9cupl93Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cE+g3jxd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qr6BUS+H; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cE+g3jxd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qr6BUS+H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762428129; x=1793964129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0znIqX6db17lQoHGHWPLwYp81JyIEMruFAR5ZGs26so=;
  b=cE+g3jxdpj8r63WAKeyJVZmvffNJSbuPz5fJuvQVdLbPIHU5F5hpbhxz
   MKrT0PHTwGEgmSQGH+BcoPsCfXMLLizFUS6V7zhMeRWpYt5MNRunSbpeC
   Mf16nbEKXCuyGKKq9t1AE1+4GU+V9qxZBU2HDFsYSajvGYFQb+X6eJbsY
   H4rFPrh6p063qXTTOEGmmGARVCGyBHPw+GT/Ww9eHbgF0AuMLUOoV0HZA
   pFAwVNAj9g5jgRnuTphbex/bB/s4E4IX2ODhrS2WDmQEKb7MAa0EK6A+O
   E71OasEPXFmxT2FSWZjbjvL3a630I9mC6fA01rNXn+ikGPNP8toE2QOVV
   Q==;
X-CSE-ConnectionGUID: jUbo7zNuTb+wJyMLgIlJjQ==
X-CSE-MsgGUID: 4fbf2I51TFOolfk89Pd4Jw==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="134255389"
Received: from mail-eastusazon11012006.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.6])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 19:22:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEh9ooi07Rxe4cbiL5hyfG3ZHibEsk2bWXfCiDE9m39Wi/1c02EUTp/2Mt1k7SWEbG8+HlGNkW6fW6IcLWXaltp2R2ppd4DJAq8ARKRPp8hc7oM0tQ7GgSafNo7YsWiWoER/0cjEjaOQjpTQV3XgAq1SJ/RJ4yF6hfTwGzAayAXgv9xNdSr7e/Io9uinc1oMsw/UuMLdo4VsrL+7PXBqfmnfNMX0lRPSTi61LvLD1Y7LAPyFyL4jqCdNmot6aZuNtnPzM+wOC10Lh0XHXluMeXtDd5OA8eyEHkdr5qcMyDr8uf+RvduN4ooJxPwq+W3sqbVy14WvJ7E549JnRdhaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0znIqX6db17lQoHGHWPLwYp81JyIEMruFAR5ZGs26so=;
 b=GQDt4YZMtjAP2IoluIjeTFiJz3n4xl+KP79YWzXQv632JYuhzYrm8PrzFLPN0vIkzAEp+ClFMjFgZ7DNIEK9bvo4Ao9c3tPSXAMrkFmbDeErHp9afuywaUNBSUHboYnTwpR5RN51A3yLED989YYypSDMBLVaD6F0/vlLEEpZp3Fkmw4SXY9kSpDJVfEctltvf/8G7K4YZo6c1ALjgVJS1KyhF9t6kLqO9FN3wrtbaRdIbsZhm/gfpyon9nXmdrR9jxo1hfb3pYzrxSSJG7G+NP7EcFFdbZPF4iiQwvNqLSGQ6aCwUNIN0DGJ3oWeRm38QMMZ56yCdd1lTcpe8EZAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0znIqX6db17lQoHGHWPLwYp81JyIEMruFAR5ZGs26so=;
 b=qr6BUS+HJoOXQAixY7CEBwue2GiJCMPt07/VGMR14XQEl4WqIp/zZPGKkbzdzcRjNnmMSYKt9mqBjP7H0DhQoGDLTOMsszVGdc3QosvTLMKsz3w9aXuMj9x5rn15Q1vaMsQL+hPwcgmt5eSo5S1JDtZIgq1FBBlH+J4ITklFNRU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA1PR04MB8854.namprd04.prod.outlook.com (2603:10b6:806:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:22:06 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:22:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/4] null_blk: single kmap per bio segment
Thread-Topic: [PATCHv2 3/4] null_blk: single kmap per bio segment
Thread-Index: AQHcTsBnN1aDNewfSEGVuaOSX3hpy7TlgaiA
Date: Thu, 6 Nov 2025 11:22:05 +0000
Message-ID: <8b2f2b5f-562a-4bee-a945-61b4e21b2793@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-4-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-4-kbusch@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA1PR04MB8854:EE_
x-ms-office365-filtering-correlation-id: 77930e82-ab5c-4ccf-e89e-08de1d26b7a1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUJXbXB1eEZyc2IrVjRwaTdBU0R0VlJXK3VucGkzUU1YSm95ejVKZjNKNEJL?=
 =?utf-8?B?UUFCaW5xQjd1Nnp2WnlJK2VFNVhUNzJoSjVlMTJGbXc0VXg1SDF1RFFScGJD?=
 =?utf-8?B?dFJtemw5anV5ZUNTNzQ4NXpseEorWW5DUVJmZDhQdjRNU0F2ZXNuKzJsUGVl?=
 =?utf-8?B?d1h0ZjlzaTRzTk1JajJtMUFKajd4VkZweU1HMTFPZFMwWWlEQmFHSXcwME9r?=
 =?utf-8?B?SGlSMEkvTDMrSGVjU3IxY0pHKzFsTXl6Ry9PZFNUYlIzMWZCNHFqUFVWeUhJ?=
 =?utf-8?B?Q3RybUExT1dpQUxSMkdpa0xHRXFkTlpnSjQ1UlZ3NERuWkRoNXFHT3JMbnJG?=
 =?utf-8?B?SEUzVWc0bS9maWlNQVdKUVAxV3lWSmpLTVBtSFhyN2ltRzVudnZ3YVlPTVp6?=
 =?utf-8?B?a0dleWovWnRRYmxqeW9LWEVwWXVzQUlGa1ppZjlZbXJ2YlN5aGYxSGN2YURv?=
 =?utf-8?B?Q0plQThBM0t2ck91Vi9TWU5DQlc3dWQxazlpVHFUUHYyUm1qNktFc1hWOHY2?=
 =?utf-8?B?SkhYdWRhTG96OTFPZzJua2JZTC9BTUZjWGc3eE5rVEtXWmx6RldWOHh1c05l?=
 =?utf-8?B?ekNic2hYeDlTaGozZSsrK2xGcnpLSkhuQU9XejNlVjZMaDFNNlM3SkR4WkNC?=
 =?utf-8?B?dHFyNEpvQVpKMTRIb3dtV2ZqbkQwWXJ4NmtER3JPQXNucTFaaEhhd1RtN1FR?=
 =?utf-8?B?d3BRN1c5VG1Xd0tEWjZ3UjROczdJb0k2M0hubXVjYXdVaVRwS05ZcTZ4TjYy?=
 =?utf-8?B?Z3JlTzJJbk83ZWdGbDZTUlRVZ0xucVhHNWF0TmErVGVJaGFTelJFU2FXUm9J?=
 =?utf-8?B?OC8vdzd1QTdEdWVqN01wS2c1RWh1Y2h0d0lBeUluajFEQlhxMGY4THNsZktw?=
 =?utf-8?B?SUMyMUorRVZiTHl5cXZzalFSbFlOMTRXaHM5T042ZStVZ25wRzdiSUZxdmhh?=
 =?utf-8?B?T0pVMmgzaStPT2tKdi9DTU4xdkkwVmRCK2QrVGoyYlVxZnFHTjJHWXBDUTBR?=
 =?utf-8?B?RHRQUG5ZcGp4cStHUE9oS0FEbnFRREJyRGQvelN4VnlQcC9KemFPMGZJNnBF?=
 =?utf-8?B?RnQ3QjlKMzRYQ1BXWlZDalExazduOE15enBBRGJrS1FOdFFMb0d4SEhsdjIz?=
 =?utf-8?B?TlVVUmtqbTE0V2FFS3hla0xpekZHMUl0UlJkaitPZTd4eXVWeXF4cWhqbTlS?=
 =?utf-8?B?MStwMEN3QjZ2TEFOT25lMGI3RkpqalZPTjJnLzRzbmhhMUdiRTRHS3RCYTY1?=
 =?utf-8?B?YWdyZ2JTdWQyZ3ZYL0pDNmNIdjhFM2pKbVRrajhFaUt4ZitZU25weXdCb0Fy?=
 =?utf-8?B?QVpzQTRyTlZDL2pyZmJCQlBSR3N0Z0pCaHJyUElFU1dOZEJERUFZOUtqRzhL?=
 =?utf-8?B?NlVQZ2pPWE9JM01sRjZLb2Zqa1BiRm1HTHRQd0R2ZllQVjkzSFIxTnhQaUZT?=
 =?utf-8?B?Zk51dXZHWGQzYUFmT3NuRS9rdGhrUENXVHZPY0MwaFcyZWR1YjY4bjZCVUJT?=
 =?utf-8?B?V2d3ekgwbVhTRkpObTlia1BreFY1YURYT0I1T0htUHdaUmJTdVdDSjF6Z0py?=
 =?utf-8?B?Y1pONlJkbVNZcFIvQWc0ZHNVR2F5ZGR0czk5QUpWYVlhMDY5cFRNZ3NJM1px?=
 =?utf-8?B?M2Vpa1FkKzJFU3lOYW5mdXhuVzFramEzOGZTV1c5RGh0MUNDUG9IaWkxZm1p?=
 =?utf-8?B?d1NzTGpML0JlVElkeFJHUGpoTzVTT2xUMkwyU216WTNCL0FDdFdUbG01WXFN?=
 =?utf-8?B?MmU1OE9oVGpMQlFIN29kMFBmNlJ1aXRWZGdLSW1OTWhCVjJ2SlhPZ2toeFVY?=
 =?utf-8?B?aUxLUVFpR0wrRnpucHhsN3VTYVhrT3NJODMzTWpvZkljNnlZZmlROFk5ZkRj?=
 =?utf-8?B?VXo0OUdtWXdzVlp5cEFsNFJuMDZmQmdhMHEvMG5jWFNwcDBvekx3TWU2em40?=
 =?utf-8?B?aHRUZnZBa0dOeHdNdW85ZDB4blA4ajAvWERBWmxnUDFoWXFLY2s0M3hkc1Qv?=
 =?utf-8?B?RWNtbWprSUNTUEpxUGI2WVE2czgySkFSK3FVT21kSHpmNTEyaFBEMVF0bG84?=
 =?utf-8?Q?9ieDVP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHh4eVVGOFFWcThHUUNGSkZHOUp1UEduM0k1N1g1ZEFIeUViWE9qNDNSOXIx?=
 =?utf-8?B?L1ZtQXVCYVRFL2paTFByd3ZzelNyOENaSUpNWXl1YnU4Z3U1YTRnRk1BVXVZ?=
 =?utf-8?B?RW03dG43UDFKWCtxOW5tSzlJZjBHbWhxbjdoZU1nTEw1RTFoWTBjT3o4RWM4?=
 =?utf-8?B?bUMxWElHVlllN1lvSEluaXJxdDkvY0I3VFdnSnpodjhJUHh0eEprVTZBVWx0?=
 =?utf-8?B?cm54TVpqZm5VOXlvRWpHWGhRMWxNbmlUQVV5cG95cmhWOWV0bXlXYUVhWG1k?=
 =?utf-8?B?VVduUW9RTmd3N3B5SXo4REFGaWFQcnJKa2VSdTdlUVFCMEdFbTJPRjNzdTRX?=
 =?utf-8?B?ZFlPR3lrdDA1NytVaXpQRWN0R3UyRWcyS0ZYaXM0MUtVVE5aNi9PdUEwRytq?=
 =?utf-8?B?Z01aNHEzNDFieGVRTno3SHBnNnlGdnluWmpmR2YwYjk1SFFMVm04UkFFQVBS?=
 =?utf-8?B?b0ZnSjJmeldobmh4aVl6UXZCWjZrQTlCRGY3QmRUQ0N4VG9mRUk2MEFWQ05n?=
 =?utf-8?B?bStyNjgzQTNISm5BT1NUWW0wakNuc3piNFJKWkwrSWQ1VVJDaU5sbXJ2d25D?=
 =?utf-8?B?RE1yQjA2N0NJcHo5bFVGL2phcFIveTN4eHlyNlpjMTJRRHpMSVczUzMvZ1Ev?=
 =?utf-8?B?eVJQV2k4UmRBa05lMDVKd1Rtd0NrdmdIcTF4NnZzZDN6Q1VSc2NiTUxybTNP?=
 =?utf-8?B?T2daT3NoTGVYU2JLNFJFWFVMMU5QQ1FQOU1hNnpYeE4raHQ3R1JLSGhnVjFh?=
 =?utf-8?B?ekVDM2VJYVBjb3VmZDNhZFA1YUI4VDNmd09IZmNodHE4dmNPTitab0hVaGpQ?=
 =?utf-8?B?cUo5dnZyVllhL2svRFZNRnFGNkJqMFFlM2VwcXdZbTE3NDc5UUZHM1ROMFZ1?=
 =?utf-8?B?a295YlQxQVJLSGpFb1dHd2J4VUJGKzJjWVcyeGhvaHB2YnhGKzdoa3FyUnZn?=
 =?utf-8?B?UnRIZ2UyYkdWMmJhWXV1QUZ5dzkvWTRNdEwvVUNnOTZZeTNQcEV3SGxNa1k3?=
 =?utf-8?B?UWpPRGgxWDFoWExKQWFyZGVnZnZ0a0VNL2ZxRElGZXovRzQ0MWg0czZQRGtJ?=
 =?utf-8?B?T1lCWlVGcFozdS91aElQOFZOZHNIcDQ2NDRETkJKTzFLYXRUWXhsZ0VueTY0?=
 =?utf-8?B?RXhWalNYcVJyU21kczIzbVlyMUxCaUZnNkIrTGpLdUp4U0VtcXA0dUNROUVw?=
 =?utf-8?B?Z2FpNVdlVTFZWUNJYldGdWtpVm90ME9mRmU0Zm10YkhEazBIeEV0dkZxb2Vr?=
 =?utf-8?B?SXUycFBhZUZkZDdWaGJDRjNmZ3NKVlUrOFUyd1ViOW9BVTNZQStiemlwOTBS?=
 =?utf-8?B?WS9kVmRWL0JOOFVWZGQxMDZMTE1RWUQ1Y21mZ0ltWmpUSUd5SGFsNUI4ZDVH?=
 =?utf-8?B?KzVtMVdIS2M4cUlvbkRCYkhBaDJrV1VIWVhSVDF6cHlaZkE4Y2RUMmZrWXlK?=
 =?utf-8?B?MGRnUm9vSTNWSytCNVFoVWwvdlpsNEkrdExYVmtDYWUxL0lSaE1UcHJleEVl?=
 =?utf-8?B?cGZNUTE4bnpWdjlwLzFKblYvTVFGR24rMUptdU9tQUowWkREdFQ5TDM3T1Ir?=
 =?utf-8?B?WXR3STdrV2NzR3ZJbVphNS9WWEhwcFpxeHhTQnRiWkdzZ1NHQ2V6VzRiQnlE?=
 =?utf-8?B?S2prTmo4a1JTVEZ3czU3dmROd3lZbWdBVGhwOFp3YnBWb21nWmc2eDYxbW5H?=
 =?utf-8?B?ODhtRWw0VmY4ZGM5cUxIYnlTMC85U2xHczhCRHQrQ0JXMHJjOStab0lzb0tm?=
 =?utf-8?B?VU1IYzFDQ0hOSFFSWEhVVWpNL0JJVm84d3FNdU5vREM0Vis4VTJ1TjA1UEdQ?=
 =?utf-8?B?MUUwWjdzbTRBZW13bWVQeEFKZldmNnViSm1CTjFnekJMUzN5WEY0RmFqKzhl?=
 =?utf-8?B?SmZHT0w1blRheXp4dkNvQnRycjQ1WUtVTXBHMFYwSnVoVnFPaEhWY2JBWmNB?=
 =?utf-8?B?cVRQYnVoL3ZMRVNyeTJha2wwV1FTZnl3N1JyTVpqN0xyR2lTM0ZDN0pUZ0ZT?=
 =?utf-8?B?ZmFzUElTNWFOUW1BYi9vKzY4QU45Z3l1bmtJTzZvc0VBUDJYM28wbDNzckVw?=
 =?utf-8?B?R2J6Qi8rQzJsL1lYK2d0aGM1dEpEbHJoSXJjWnN5bUgwRmhqS1dBRmVWVXBI?=
 =?utf-8?B?Z2M3eU83c2gwWHI5TjZtSUFrSW5QYS9DcTdPckxUeTNtVjhrU2hOVTRSbC9B?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AEDDB17A198694AB29D47E3F36FD1DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+wlg4khaPh85J09DUu2+M6uvK9rPrDewxeVe+Rc3+iL3pXc30bzTqeenxtA/3GUeAjarre/GGMttbOd2Aja3bPrff3IertUiMmSBDe85KHCj+hqNt/qN7RR9dl+v+7vy14Gyn0TOaDgQJQGKY0GbXhAR9l/SrrgpKZOMOYbCuUJ3sb8nL7X9MCMofOaXBxFBsWtjTNv1AG6JjnfcFlXWWlyUM9DNnR3jVsUOsfgxK6x6AkYymUltEKc0HmUsiX0c1YJlbnY8JP0SsEYoT4Bk5z33IEFFfAQNHPeq0LATrs46TUc92HfdezShUi5NM1swH6awx3QlifnTBsbTZeMJxGjxd66EExXX+yx50eUmeorm8HHM0qlD1zclPQBXPLowU5/zTDI9HX6zpEPK+AOT1FbP+CkAC8b27N+QohqMEBQvR+jcjDzN0w3+TDrvY+dEKSuQ778yyd8dczNV4Pen0Cu8d3DcC5meuCE4Dts+xJWanMM44El9vfj+EsylRcuwJ4AFaqbUfTLKs2rlhCapKmdxtmREiY27cLNZJOy73ZPrHqfO9foH4iM/YHi1dsC+GH8spaXnBwzjlCJ63Q/On90tPL/ajP9+cpqhef0n6fb7yFYUyZ8lW8ehvyMuW60y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77930e82-ab5c-4ccf-e89e-08de1d26b7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 11:22:05.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvoB+5VrE96AhQrkubcxF+Jv1zM6pT0l1lAvfLWXliiMVEti0FQkB4Yi69pyJZSkem3S6ISSVQQ1x2rYqeAyCycWAz7jhLpC0nPgKbKOlbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8854

QXBhcnQgZnJvbSBEYW1pZW4ncyByZW1hcmsNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
