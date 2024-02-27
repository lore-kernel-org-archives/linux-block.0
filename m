Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831313A885
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032907; cv=fail; b=rRql0XGYZKlALDMLg4DvSWxk2qEMkCPDVMoouhSTyAA3dQxsnbnXMky1gv98qCp+Ao+L2zF9i7mC3jOGC1xwWMo24JyTrsv4jy31+PCQrt9apRrUFmpxqectwjkfIadQDK2WV0dq7k6Ip7WHUQ10oVqVtdM+Q0Ov32snZhmOYk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032907; c=relaxed/simple;
	bh=5q6jcXlidunMRhNt8eRT/Qo51WaHqkHVnueEV/B5DO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLpcfFsHuH+br3Nx62XbM5YdRtsGlMAIpuc6vgCKmb5d+DUQfTXG85RIsJuBKXJePHqcE4Nvjdwxyjc6LOi4pF3N4BDtwEYrpEnDtwB4z+tpDsLZVoggjfMpgWw8DMRZ4SJOFde9JA0V2VdySnvsdYejHo0zMDjtk/EEPKppaig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PiO7OnIs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=R/kmj75B; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PiO7OnIs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R/kmj75B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709032905; x=1740568905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5q6jcXlidunMRhNt8eRT/Qo51WaHqkHVnueEV/B5DO0=;
  b=PiO7OnIs7tyrcao3GbmwfbVAqHuKPESxyaXNOg0gPGpw9HM5+Ky20klT
   jpVHkDNIyb/vfnCb9el8Rzyx3WOdqcKsxIfcxWozrVk+ZiUtalsB3f/Xf
   /RYPl+R7X17mSheKWcNe7/k9DLM1SW4sKTDO0x4LMJF3uAkRt9nS8UIGi
   TVA9IVic5kEmtosAoe52RIF4r8OpqpVe0QLDxpijaxQG9MzSuIviGObuv
   OrIrBzVScT+7n6PnN3vmNt5YMKza1lZnUDh6/x18YCavwa8pNQ+EWPp8P
   F15rcW79hi9C5kBkzgWJ0kuQEXxP8Jk4PXuM/T+ouhSnECdToGF+pz7r0
   g==;
X-CSE-ConnectionGUID: 3vxEmT+nQkCQnF8IY1dU7A==
X-CSE-MsgGUID: ULRebSntQTu+6NFIMIQKpw==
X-IronPort-AV: E=Sophos;i="6.06,187,1705334400"; 
   d="scan'208";a="10297710"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2024 19:20:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl75tg65srhOhbDGKxIiJQSNF/sTZYTaJHkfMoP6gMVIHHFovdro/oTy4SMfOFjGsoFh4VhD7MLgXqwn3JbHtghJuM3OoQVQbi9cxPUN4NAyt5qsPYvW9g6QxcLacrkUCLhwecgIS7Ppkf7sd7h3zrf/mZY/Ob+ZKoBOVxM84WabpLEwLnqzaDAzGUttukv5o/dUN/rr2AmezDrSqmgoSV4mkTdhvY97fxcRw/8xsZhABiQtb1DaLhxajOdTOIi4viE6vdz473rdYMGuNUF45BFy9S17g87t9v9VX0teEFeNNOpgcjJv7eJ/hNnA2o10+3uffASxOZ28XjPTGSYR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q6jcXlidunMRhNt8eRT/Qo51WaHqkHVnueEV/B5DO0=;
 b=edcYRDalZTK1ZvLpIHH5AZqVdpuNCyHRxSStCfJnam3tClOXu9QY0d5VH1HMXjUa4BzXhAjaUUegrOc9+F5Ly85JyUu41sHlT5FYi7pR22IdCRCrmgvpu8VjWh5YFBUOrfE+b8q9JdPcdD2ETXBdiybdVG+FARODSPV49AKY6Gez0v7GYCon+/xQAwEgXB+8wwSGQtVflGeh9ZTBTUFYTJ0vl2FQgxfzfi/VVH7sYwCactSPSulQaTCClL0bSnuMHnpZbJ0r7uU9FA0q4bpoZ1ya2+1YylSORIbPQgNOEJparYFaEnen6gDQ2kxSo46XBeXukBth5CQLXGucDfiUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q6jcXlidunMRhNt8eRT/Qo51WaHqkHVnueEV/B5DO0=;
 b=R/kmj75BhThDS9Xd+8aLcsW3mjo72bdHg+WGJImk4l6ZWByJcFLH7MjY5Rmh6JdnVOlkuCQWAp5jyK9mA7toX+I2CjNl0dLMcwSr6sPUAIZoHMciLf1Dmdsn6azPiZrMcVgdzyHwM2xoU1eGzGSKoeqxRomoePJaTe55ws+biVA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7855.namprd04.prod.outlook.com (2603:10b6:a03:301::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 11:20:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 11:20:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "damien.lemoal@opensource.wdc.com"
	<damien.lemoal@opensource.wdc.com>, "hare@suse.de" <hare@suse.de>,
	"zhouchengming@bytedance.com" <zhouchengming@bytedance.com>,
	"akinobu.mita@gmail.com" <akinobu.mita@gmail.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "john.g.garry@oracle.com"
	<john.g.garry@oracle.com>
Subject: Re: [PATCH] null_blk: add simple write-zeroes support
Thread-Topic: [PATCH] null_blk: add simple write-zeroes support
Thread-Index: AQHaaIONYmhw0DNztEiOB9NduLw4trEci2AAgACisQCAAN7bAA==
Date: Tue, 27 Feb 2024 11:20:32 +0000
Message-ID: <fdf4b195-c660-4ee9-9953-00116f05e310@wdc.com>
References: <20240226071355.16723-1-kch@nvidia.com>
 <4549b888-4613-4c96-8ac2-ffe08b52da3f@wdc.com>
 <b826af45-a164-4b9d-90dc-dc9f30a9eade@nvidia.com>
In-Reply-To: <b826af45-a164-4b9d-90dc-dc9f30a9eade@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7855:EE_
x-ms-office365-filtering-correlation-id: 4717abec-b8a5-4afa-49ec-08dc37861cef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +eXIgVGm+Sk/q8aAR+7+X3ij6g3qgyWSOtHocUMeLy+laV8F20LfiULwJ7qT7ETIBO+D35VQl6qo1knn7VTw589IwQLdyhbFzefeQ0y7YFu/5ROCm3TcwL6jakpAoei5zRaj/+DgHuc7VCLaoLSFnTGuFYGgrhL44GxYNDt1IKCmrIWYHl+e7z8Scal0D4nLhgmcYVoTfnz+NFalFfHuuHBUL37vPgPV+8NoOFwPspGPToeEVMZ3fO3oK3u71+7LWYp3offyk1wBMiH8MpWsMSnkQNCtl7cp0vWL6Hr+kzSYw8rInEQAdllgmHPgb0zEjrDdGOObsyEg8N40F0tYfLA+s9GtLlxi02TqKoxqHB3AVLJhY/HA8rGMxu8DRtuhsudctHTwBDna60hk7a5lEQfRV960DyP5SHT9Ojtv1dvddyfYqPpu4k4qYExTB9PzCb1UkFaBUkjPN8aruxrZeEZYxGTZEXgdfU4Lp9knljpv4FvPdHSgFyCAET64HBB2+RUBXJpMQO5ln4l5SIpPrTq9KeEu95WwqzBepwu4VupbLrZ3cjQUoaq5oUbvlpy26UUI/w4aOg59mrI3HG/cLtIDt8l8ivsastRIYAkuI+FOSYsM8bMTMOt/PDcK2zPEVodvKgHi7kyw5V4Zu5n/rD2H2lz79+b+PRVYAue6WdqJQxzrs/XK53tkvQ9wmi/G/VAveIYKmytJEcwUNM2L4w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnBGbkJjUHVXS09zdFVJZjVFcm1DeHlscEo2TGV6RXRFYndKck5XQnBPVnBK?=
 =?utf-8?B?OHBveGdYN2RnOWZHRkphcjBsNk5hM084WmlucnFubm9idUNidnFRWEZ3T1Ja?=
 =?utf-8?B?VGh6L3g2TmZFdGVwVUR0VmJkeWg0TFBDVW9ncEtscEp1akNwRk1ZWERYYmpr?=
 =?utf-8?B?bjZKcWdzRzVWUmpVVHBwNTEwMjc1bWtZNzYrOGl0RU5heEFwOGVKYXVBbTFn?=
 =?utf-8?B?QldvNys3SUxwTHdtMFduMm0vKzY2QmtHcnhxeGo1UmZpLy80Rm5NY1FEMElz?=
 =?utf-8?B?ZmxaVVJ5UUNJdGlEb2t0eEZoVnduSTBPVW56YVdXM2Z1ZE5QdWxoTU40RzFp?=
 =?utf-8?B?b05CTmJmQW9waEVhS3h5cFNRcXVGcFhGYm4yNS9VRGttc1dIc3RJVFg5S0Fu?=
 =?utf-8?B?OHZoMjBKM3I4N0N0bFpjZU5PZExuK1g5Z2pQNDVxOVZZbmtsT2taQ0FPdWxW?=
 =?utf-8?B?T2NWK3B4RkdFaWhPOFIwQTBmTklJS1pPOG9rK0hUTmZPYy8wanJJS3NjbHVl?=
 =?utf-8?B?SWlySTFaMWJiYTd1ZlpYOWR6RmJUSjRITmg2OUN6clpEa1NXdDlTcnR3Nk15?=
 =?utf-8?B?eXBjeEZ5ZUV6eXQwR3U2Y2grNzZTaWxrUGNkMSt3WFZlTTRMVTljWEZaSDYw?=
 =?utf-8?B?MlhNYmZVM0x5MlBNakp2V1lmRC81QytqdFltYjcwZFhJaXpaWHBBdDB5Mkhi?=
 =?utf-8?B?QzRKUXpEQVlETEVVcksvQXFqT3QvcEI4U0VuS1JIYlQxeUhnODJoRUhodXRN?=
 =?utf-8?B?K0VWL1U4aGRCZEJuVjk1c1J5VWJjellVUHRPRjlCZ3NqU0l6U2ZGVElpYkVI?=
 =?utf-8?B?aXg4ZllWZVF6T2dEaE5pVDZ3ZytPNTFqbzVCc3NOL05CZVJGb0U4cThQRmo2?=
 =?utf-8?B?bHhNMDNqaXpnNWNBbk1sdDJ6OEo5WW1MamJyRWgzSTRkNEdaOXk5eThhQWZy?=
 =?utf-8?B?OVAySG8xZCs1NmFTR2FVenNERDFWNUMwOG83Z0ZtbzJmU090b3FsQUhQbDJ1?=
 =?utf-8?B?SFZkKzZqMzY3Y0l0YWU0SXIvNVB0eHhubTNpVlVqOTViYk5kY2Urc3FwN0N5?=
 =?utf-8?B?M2RISXhDOVVDOXprR0JZbzJZSHdUblpRU1gyZmVya3JhMXlPcDFlZjZwcFBN?=
 =?utf-8?B?LzZqNFVmS3pWMG5hNzRKMWcvazVCNWRJME0rN2tVa09BRGI0dThHMnlqcG9W?=
 =?utf-8?B?bmlqL0daTitJWGVFOVdTRng5YWhQbFBzTFduUHJMSkRFclc3eTZXTmx5dEt4?=
 =?utf-8?B?M3pmcVNMeEtsOUY5dHhiVGw1djVEQ1hmYUowYW1tNjVhNElhREg0b1pJeEoz?=
 =?utf-8?B?VFZ2WTF4THhZTjl6VXUxRUZ1NkJ1dEFxeERkVlA2UmZ1VkxRQ2FzYkJ4K0pN?=
 =?utf-8?B?U2E2N3p1ejlBYmo5Y09PRmdFTmZTWVVycEdpMWNVS0F0UEFYajhlVHpnNmNH?=
 =?utf-8?B?NGZxZlJvclBIOWV2QitobHdGZmNZWnZCa2JOTkl0Z0ZFdlRDVjZGcGc4R3dj?=
 =?utf-8?B?MFo4MmJIQXkvMnpQbGJRdE11dW1nQXpJZzRHNmx6MFBSNDB4WFZxRFowK2oz?=
 =?utf-8?B?R2xyeU5rRU9KOExCWEVtR0s4Yk10UFRuR0x4SEV4RGVrQ0FpdnlKcEJsNlB6?=
 =?utf-8?B?ZmMvTU1HalFBaWMvRkZSMHFNajFLazFCWHpLZFlkT3JrYkp5UHRJRm1hT3hE?=
 =?utf-8?B?QkZRalQ2WUU2cGZQRWRxaDVVbXpVWmdhb0lnbDdlUjE4N3VuQlhiNEVtOURH?=
 =?utf-8?B?N0pKamVLd2ptbmg1cnNXQzFQSVJVRGgxTFVIVEJFODRCRWV5R3lOQUxWUFpC?=
 =?utf-8?B?TTA3dmdlbjNpRkgxZWhhaGRtcjB5eG9GckxJYjJpN1lVU250SlpLVXRYaTU3?=
 =?utf-8?B?QWs3SnFYdEQxZWlvOHlxcTk0VUFQeEhOUjJURERpMmhCdDk4bjduQzBPcUsy?=
 =?utf-8?B?ZGxqbWRhZU5RUnU3N0MvNHl2VnB5TlVqdllqUHpEUDljM0VCS1p2WlRWREFY?=
 =?utf-8?B?enRTTkZtS09OeW9qS3h5NlNIY2hoRVFkZEUvRWQvZDZyQ3hBSlluY3ZEMko2?=
 =?utf-8?B?Qm5PdGtkWWl3bE1PNjltQVdUeUNlTFI1VHMzd2tCWWZpYk96WG1PL3R6eEpP?=
 =?utf-8?B?N0cxWnV2UTl3SDAwWXEwN0MwWnhBZ0xSY1hDMzRXWWVMWlhOdml1M0c3V1JP?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD62B7D8892B42478B45597BEC3F6511@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jnlB3NZSEzTmJq2WQkEFLkj2JeSJpI3bFMG/DOimA7Hr4qU/0kZLkYK6uAGtvz7bLYI3M7ACDyVVmNrtxjPOMR+afnF9+Ty/HspxGVuPF/gTGAI/hxrNLzdnqFnHVGEWvYhd1+VLBP5vzcVwfIJtKYmY9N2ttkyef98NW0fCZhtTB/QyMM7fy3C4Cv/K2bLO5eawoC6Lltzecl8PC6aNYq/whkXPBR8lfCC3juvCWs4nSAr66ShjcYpb6O9pjFWuVcE0F68/GTi6Dbpjna1zU0LiaXR7Kz1h5Lwj6K0dvjmo5ZvTQ74b7vlDmrzq2Oqh5w2S74lpaKYgmHWreSUuBXB0TsAIP9Fa7wTBzissH1yxvjdxlUbTOpbdcP9pvK1n9uxVstLJgBQEpQ2eDEjYwNCGcwP/UVrZRhcaFKvAmhjZC+2rF98EZTFBR/iKCO/7pMzRd0hVYf4SKPORSPDif3kn88knFqlmN4z8PEKhOxwi7zE5dlaO1jHikoYcRzyWfPTCl/HY1CS0YWQr1uls9B18pV7hLkj9LfEyNcGiXMtXtB8SDS11W5NU72GAsZTVSVc0PwbUWNtW/7EeiJCKu9QvdnfKAt5mukxVcErwER+wZ5kWAeUueYfXtf0NtYnv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4717abec-b8a5-4afa-49ec-08dc37861cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:20:33.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55vU50F5pB5zMi9vkCnhCnplMpjl+i7S+zjUw2yaXe1UOk5919TeIMjOna/dVLh3TrO7Wh/TxegIg0fEojnphcufXXp9Ko/ksiUiX+cQAVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7855

T24gMjYuMDIuMjQgMjM6MDMsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gMi8yNi8y
NCAwNDoyMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMjYuMDIuMjQgMDg6MTUs
IENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+PiBAQCAtMTY4NCw4ICsxNjg5LDEzIEBAIHN0
YXRpYyB2b2lkIG51bGxfZGVsX2RldihzdHJ1Y3QgbnVsbGIgKm51bGxiKQ0KPj4+ICAgICAJZGV2
LT5udWxsYiA9IE5VTEw7DQo+Pj4gICAgIH0NCj4+PiAgICAgDQo+Pj4gLXN0YXRpYyB2b2lkIG51
bGxfY29uZmlnX2Rpc2NhcmQoc3RydWN0IG51bGxiICpudWxsYiwgc3RydWN0IHF1ZXVlX2xpbWl0
cyAqbGltKQ0KPj4+ICtzdGF0aWMgdm9pZCBudWxsX2NvbmZpZ19kaXNjYXJkX3dyaXRlX3plcm9l
cyhzdHJ1Y3QgbnVsbGIgKm51bGxiLA0KPj4+ICsJCQkJCSAgICAgc3RydWN0IHF1ZXVlX2xpbWl0
cyAqbGltKQ0KPj4+ICAgICB7DQo+Pj4gKwkvKiBSRVFfT1BfV1JJVEVfWkVST0VTIG9ubHkgc3Vw
cG9ydGVkIGluIG5vbiBtZW1vcnkgYmFja2VkIG1vZGUgKi8NCj4+PiArCWlmICghbnVsbGItPmRl
di0+bWVtb3J5X2JhY2tlZCAmJiBudWxsYi0+ZGV2LT53cml0ZV96ZXJvZXMpDQo+Pj4gKwkJbGlt
LT5tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMgPSBVSU5UX01BWCA+PiA5Ow0KPj4+ICsNCj4+PiAg
ICAgCWlmIChudWxsYi0+ZGV2LT5kaXNjYXJkID09IGZhbHNlKQ0KPj4+ICAgICAJCXJldHVybjsN
Cj4+IFBsZWFzZSB1c2UgU0VDVE9SX1NISUZUIGluc3RlYWQgb2YgdGhlIG1hZ2ljICc5Jy4NCj4g
DQo+IEluIHBhc3QgSSd2ZSBiZWVuIHRvbGQgZXhwbGljaXRseSB0byBub3QgdXNlIFNFQ1RPUl9T
SElGVC4NCj4gVGhhdCBhbHNvIGZvbGxvd3MgZXhpc3RpbmcgY29kZSBpbiB0aGUgZnVuY3Rpb24g
d2hlcmUgU0VDVE9SX1NISUZUIGlzIG5vdA0KPiB1c2VkIFsxXS4NCj4gDQo+IE5vdyBJJ20gcmVh
bGx5IGNvbmZ1c2VkIDooLg0KDQpJJ2QgcmVhbGx5IHByZWZlciBub3QgdG8gaGF2ZSB0aGUgbWFn
aWMgOSBidXQgU0VDVE9SX1NISUZULCBPVE9IIGFzIA0KbnVsbF9ibGsgaXMgYSBkZWJ1ZyBkcml2
ZXIgYW5kIG5vdCBzb21ldGhpbmcgcGVvcGxlIHVuZmFtaWxpYXIgd2l0aCB0aGUgDQpibG9jayBs
YXllciBhcmUgbG9va2luZyBhdCBJIGd1ZXNzIHdlIGNhbiBrZWVwIHRoZSA5cyA6Lw0KDQo=
