Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866A39A815
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939112; cv=fail; b=tsQgmqPL5RPkY1fdS5U75jxE0juNRhrGU0q1nLCT4V24dS9BgS9uDgetli/cQVCNr97FxKn1x5CAbnG8OQsCaHmloTB6PMtEFRJKQ26xqaLwz7WuoOq5JzBJ5loCrfpbP+Eku2zySW5n57vj/QIxKijLH7StXD7vQizuOl6QtJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939112; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DY4H1ek4iVaxUnWgkQ06L2a4L5D1uMhRB1QUfA+BXoq7LiNsp+rBAHMoka3lxuXkUgpY/+WHvrsC8upeie5TUduaRanmhG/BM2kMobXosBl2llZHui6Y9QzTEx6ok5q3dJ53Hq4PR6trZZrpVC0EK2CahjrA3rLrJpcXo09VBR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bnwnfJnu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ulmxonbn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bnwnfJnu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ulmxonbn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771939111; x=1803475111;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=bnwnfJnudYGa/FIFu//cUojp0KZduVBy0UqCxXd88fyjZEYS3UspE21+
   XtWmjhHG8l0/o7bWa51rekzkYdtiGmPgezW1ss02YHboU5+1aJleKrbF8
   Pkg4jQpChE0SKpcwRcdZ/8IIOZ7jeeQF9Rq/opQBeDPXSXqJJl2WGerla
   zif5XcWHu4lg+oElDV5SIJuXSgPAqJu2ZSqrxQAMqDUDX959PGoyf9Ovu
   n9NOMvtaTe6TNjAT1FUD0hHWL+8z/LbUsc5Zb4gA99vJVX3TvM4pLXA05
   RL4sATk8aBPO/Rn4l5RqfZ7gRNSYXp+CkRkzM8rxmtKIwEZXVyVgkr3y5
   g==;
X-CSE-ConnectionGUID: hsnibVooRuSwiHjci772vw==
X-CSE-MsgGUID: /X9FRD92S4Soy6qPN1T83A==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="140393766"
Received: from mail-centralusazon11011035.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.35])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 21:18:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZQfpAImqYAWgJdBfTx2lMIJDouN7512hGpzhW8VI/UQZSlfK/sEcwBgK9FzuPlhTbp4joSOl/12wHC1LbREIe+sVOoIt4dPu8D7ZuinHLi4Yd0UePExbqE4i20RumJP5+zhLuHVgb62leHDuV0xVXVQpPdvRosHE7KpZ/88D493Bqk8LsR2IxowqRHl8Nx2jsxIqSMcPF6MfddMCjdw5gCpV/anro+YK56qJeNR45xoPP89CJdl5bdjfR+UQAJdsM7jvbbOz965zxfmKfG+i5OSq/KpMQiQS0/B9xkGT4oeMQlohGmWyZ3jewWEQOBCOgl0f/gw7J1oYg8SRBRQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=ILrKtGP62PQUHVpbEdONvECz1u8/PdttLEatz0NqQyTbeMmjvMLH0sX/+Rm4oABcnJIM1XLeP+Dpqp4rcDt8TFLkvR1ZsFKVD0I8aEYAURWq+0LpmGnJbEgek9jNi26Ouqlh1bh3hsD7ACU7SCRnLKzbcd+SoP7FQNiuGnjA4t32uVUi0B2QblW4roa3QF7DH34HiNJd35u/Ykmtn7oaGcBsgUZ2SKNwIaYIyNXRaFLHJIQmSNcMpgc4muNsTiOEk8zlalO63nJvuQ4ZlqPQOFpsHfdgQpo0sA07XzJvsP1HUcW6DPvroHieZ0Nb5idiNPXBzk2SatR4tOV5HCkXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=ulmxonbnrEBKoIVPKd9ZUAzv2dgLG3mccNMNT81Vxv7myQdhzcLH/hdHWJROniqeGTDpidR5J+zmPMCL3+e9hmQ+3EGTwrLtJN/qHzwk+VMsPSxGCGN03tsjJPkk5XF3OAMqstb0U6xmb7xGRacBg3M22RPA2zOTVx8HlhVhSZ8=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY1PR04MB9564.namprd04.prod.outlook.com (2603:10b6:a03:5b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Tue, 24 Feb
 2026 13:18:23 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 13:18:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
Thread-Topic: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
Thread-Index: AQHcosv0m0JnOL24k0e+DVkFjipLxbWR2oEA
Date: Tue, 24 Feb 2026 13:18:23 +0000
Message-ID: <6d1c8550-420b-411e-8b6c-1a53f1cd8c63@wdc.com>
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
In-Reply-To: <20260221004411.548482-5-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY1PR04MB9564:EE_
x-ms-office365-filtering-correlation-id: 9cc69deb-63d4-41c4-64cf-08de73a72fbd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzlHckhBc3d4Sk1hS0pxcXFsYS94dzJYbXpXc3pFanVKNk83M2FERUhxMlp6?=
 =?utf-8?B?MCsxT3g5TmVXWVhEaW5kaHlkY2JlVTFDdkIwU3EvL1BlanJVYlBqQnpKVU81?=
 =?utf-8?B?d2hWT0NQUG05N2VIMTgzOWtyV1NaR1Flc3lnT3hLV1dCNncxY1JOaU1XYWJs?=
 =?utf-8?B?TG5sV1pvVXcyK1p4UDJkL09ocUxXM3ZHT2RYdTNoTXRTYVJhVEluaWs4NzVS?=
 =?utf-8?B?d0FZdFN1bEJnazRZekZVeW5JNW95RXdzaVhlVy9SMk05TmMvUm9XRG5yaWcw?=
 =?utf-8?B?MFFINXoyZCt6aWlmblRaUGsva2Y3MHJsSWo5ZE8rTGd1K1cxRWZmYklGQTlY?=
 =?utf-8?B?K0FEYVZmL2JEdUJsS3ZBSW1jZy9HbFVZZUErNC9wNzcwWlVpVC95UzJNSUZq?=
 =?utf-8?B?RERLNEpQWEFBR1VqYlNhV0hGN3MwVWQ2STJNV0pwTHpySXRxblk4MHJDbWFp?=
 =?utf-8?B?MFpZRHVXby9sazJxVExsNUNnMmdBWi85WlBidzZub0dNM2RoWFVjd3RuckIv?=
 =?utf-8?B?ZnR5eWN1aEY3TEppVGJpdSt6UkFYV0dCUVRFWlFVeUtwcGVWL2ljUnlGUkZX?=
 =?utf-8?B?WXpUOTgrTlV1Um1oWDJzbGl1MzhqS0tnK0dDOTJsMUNWQzAzRE5qVFZ3eDN1?=
 =?utf-8?B?SkxQNWNBNnkrSncvTnhzbjJycWp6bHhiNS91R0Vld05rWm5hZlRLb1JTam9C?=
 =?utf-8?B?UmZ2NHlSbzRpQnJWaG1EWTNvazY1ZFM0TG9tZVFuUENCbDYzYThwWkZjWjMx?=
 =?utf-8?B?TmVVTWxWc1ZYZ1kySkFuVDUzbFdvOXZUU21sem81dDRIa1QxWHhLNHZFUXdY?=
 =?utf-8?B?MStZcWhZbE54K2xxSis2UjdlVmtSRDA5MEVIQnB3Y3NDZEl0ZzZ3a1MrY2x3?=
 =?utf-8?B?cmpYUWgwS29vZHQwdVpkMzFvamsxY0ZyOThkOHlxUm1DOEtHR0RZUkxSR0NM?=
 =?utf-8?B?WVdyRXlpc29JQUdTRWZCQU9tSmNXMVZSd1RERXowNDQrcmZUdnRjQkZpeFky?=
 =?utf-8?B?eEcxZFpLTFI4eEYrdTZQYzU4dWgzK2FwdE5PcUxoQzRXVVZyenprZVN3dzFs?=
 =?utf-8?B?V21pK3lxYVdzZ01ucHVKby9FdFQrU2libEpnbVZzdkhnL3FDd3BrUHFiWUpL?=
 =?utf-8?B?aTFnQ1lEWHFmVDNTdG9rdTdPMXlKbEZ2TW5VR0FwNzVWeGptNmpVL2RqTGkr?=
 =?utf-8?B?WFFJQldCQmNQVGpvT1dMWXdLU1lVK3RzZVUyMXd3RTA4VW4wdDRSYzVHWkdl?=
 =?utf-8?B?QVBRbnZIUzFja1VvSUpuNVV0NkI1Q0FzTUllNWlJMlRFS1JlQnZ1U3Z1WDJM?=
 =?utf-8?B?L0JKQ1BwNHVaWit0cXp1Z1Era2RXR0dPZWdxcUNWOXlQVmd6ZWpDNE0xYVBu?=
 =?utf-8?B?TG01S3Y4Njdoa013eitsSnc5T0dET0lpeW15NG90MVBnYUNaNnBjdDBlejJY?=
 =?utf-8?B?Ri9rejdGbXZLV055aExKWllDelFKOUVEU1pwcmR4QS9XM0N1TmZNeFJVZXpJ?=
 =?utf-8?B?Wk9UN24rRE9jRWRDSm9sazFTUEdadUFFakgyOUtFTjA4bVEwUUtEaWRpNm9x?=
 =?utf-8?B?MTFZdm14ZWM4bFNHQmFhMHM3OEIzYUtYVStLS2xrdHMvSkR5SFF6NzZmd1Vi?=
 =?utf-8?B?bXpDbEc5OEdIVjR2OC90OTMrcGJlQlpyQ1F4Y0lYc1JweU5LOXR2QXBJdkdr?=
 =?utf-8?B?OWR5bUd2dUswWURIQTZ2bk1ObWJCN2FHcTluSDFxZFN0WUdtR2JUUXFsRmR5?=
 =?utf-8?B?ODNlcXFidHE0WVVEMkNoWTZPVHNyYldVWmZ2RWthM0o2T3N6azZyL2JCdGl1?=
 =?utf-8?B?NDBpNTMvNlYwY2tsQkFEMXZ3RTl0R0hIV0EzQ2wyRmRUeUJqVzZlTFR2NWdJ?=
 =?utf-8?B?MGZKVG9YM25meUpYcC9NM0paZDRXUUlES1dYOXBoMlRiNCs0QlROYjQ3TjRX?=
 =?utf-8?B?WlJ6K1Y4UkYrbkJhaTlCTW9MK3BNRGxCMVJ5MmZXd2ZzNDBlb3NjQ3ZOOTJ0?=
 =?utf-8?B?a3BJUUJ5WHF2eVAyd3U3VXpEVS95NkJ0YUtlQ1I1Z0tVVHJxZStrVEF3eFVZ?=
 =?utf-8?B?SFYrc3A2eGU0bE53SVBzYVVIS2kyN3lKelN5enQ4RHZVMXJnRk03Um5lZGhF?=
 =?utf-8?B?QVNBc0lzY3Qybnd1aldZSUZJSUVBUURGbXM2dk5vUnhGcTIvZnM3bTQxN3F4?=
 =?utf-8?Q?Mo3VuwiUNQmWp5qO4DBT/o8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGxxU2ZVMzNISUlWUElOUjhjZDZxVHhsaEx0NkgyUEJrQXdEVXlOcnlnU0tq?=
 =?utf-8?B?V254bDdOTlRTM1lhWVlYcUZ2WnRiQkc4eUxUcG9ralRmWU16N0VwNVQwVmQr?=
 =?utf-8?B?NTlsWDlKeHNlR1BFY3ZrUGFJdmxEbnJHNGQ1WEZuZjVjZFJVUUlKcUxGS0Rx?=
 =?utf-8?B?OTU3SFVlLzRXRTZva21hcDYrSlNPczZCWkIzOGxEZEF6N3ZaTy9nQWxrUVpz?=
 =?utf-8?B?S3FUT2pLcTFJYVpIK3JnMzVXNkcvYUcwREhFbUtuT1k0UXNPMXBYRWZnUU9O?=
 =?utf-8?B?TmVjZHVxbkN0RURlNEczR2l3eFAvbHZTbzFLN295UTZhV0ZScVh5M3Y3eDdL?=
 =?utf-8?B?bGI1Y2l3SllKL0tJRGMrd1hhNUg3NHd4MzljRTJtd3AxZGdiaytUMFZYUXNi?=
 =?utf-8?B?Z0V3N2ZYWk1pcDNsOXQ2YVBJNFRVRUpCL1R3OHMzSkVHd2xEb01SbldWT2lR?=
 =?utf-8?B?Ym05RTkwTjFsL0sxaitJWjRiSlIvUkNpMjNhb0JnVW02NHUvZ0FKUWNQbm9o?=
 =?utf-8?B?VlZMNnhCdVZrMkt0VXN1M2YyQXVndEIwZXFScE8vSDlJdzdYZGZaZStCRUph?=
 =?utf-8?B?SXlTbU1JZzVET3loOXpUd0c3WGNZZDlHV3Nnc2orMkViVUNQempBWTNSNkhr?=
 =?utf-8?B?dllkVVNXMGZDMEpZSlNrMGRjeHZMc25VMHFoaDhPeVhDb0tJQStLa0JkVmVl?=
 =?utf-8?B?eEl1NjBTbElJcHVGOVlpcC9adkxCSkJibS9LbVFqL0ZTak1mdlhPUlRPazJy?=
 =?utf-8?B?ME94ZmlHcWJWQkhRZU5nQkhVK1VkYkNXQi9mb0J3cFB4UGdpR0RIWlBCQVE5?=
 =?utf-8?B?NTd1SDlFOUR6MWo1WEM1VExBb2t3NEozVk5lSUFqRE9ob2hZYTFTd0NaNDAz?=
 =?utf-8?B?M1BTS2NVRlVQM3RYYU0vcmtPWjUwZVFnekRKYUlmY0NiSm44dkpOUkVvV0s1?=
 =?utf-8?B?VzdHdjhkejh2UDVMaTVGdWFuVnRlbW5YSkxSVnhjZ05XTnA0VnB4bE42RWE1?=
 =?utf-8?B?a2VrYktoRzJCclhsUXZyTEp4ZzVZZ0JteFVReXlWN3JlMjZkR1FKdjlqbGVy?=
 =?utf-8?B?SUdDYytMQmt3YjdLR29uMENPenNubk5qN1JMc0trV0NUWWo5Y0F5U0tZMmFx?=
 =?utf-8?B?K0wrNnBDVlJ6QzJuNjQzZGl1ZWVJWUZ2bUQzSEdMSlM0dzA4K0srajNpblBE?=
 =?utf-8?B?WWdQUXFSOFl3S0JVcHhOUlI4SDJLbTBrWHluMEtmbHRaeUtLY2M2WFFFK1Nx?=
 =?utf-8?B?WGtsWnpVandseWhHWGU1bzE0bVJEMlRBb1pPcE1OR0NnZXpKWDI3TDB2dFA2?=
 =?utf-8?B?ZUdxRDBDRjdjUVpnUVd1YXErazFRTW00ZTM4cklicUIzcDdZNzhyTDJ0anVE?=
 =?utf-8?B?ejhTa0VMNXlHeTQrUFFKOTU5M2xueDZwUlYxeWlNY2RVNWQ4TUl2ei9NZHhC?=
 =?utf-8?B?ekFsMitjQVc0UDBETyt0MUsrSU54MjdOUjQxZnNuQVlxR3ZDL21MN1Zhamxj?=
 =?utf-8?B?ZGZ2UFR0QXVhOUNoU1pReHJLV2tTT01QS3NXK2FlalVNazdiSVQ0c2VXMWlX?=
 =?utf-8?B?cm5zU05Rc2hBMjFPdW9UY1drUEEwV0pSNjkzQ0MvQ0JGZERKNkR5OHRJaTBJ?=
 =?utf-8?B?QXU1OWs0dnhDSEp6SFQ0R3ZhQjM5M2VlWHFZU3dSZzBzZWhRV2R3MXd2cjhF?=
 =?utf-8?B?YTExM2lZNzZmM1JiQmdPMU1lK0FQUDF2bXA0TnVwWXgzRGZCMGVSTVNZM1JX?=
 =?utf-8?B?Q0JaYWV1Z2VUS3ZoenVYcE8yTXUyYWNOc2tWTXpHcEV3Wml0QWVYaHlMR1ZM?=
 =?utf-8?B?aVBiV1l2TDQ2RHVVSEU0R0dTbDQ5V0J3YXJrTTdFT3A2M01oOE1jeVYyZUdj?=
 =?utf-8?B?Mm9iZkVha1NjcGxpRUZ5L0Q3UUI3cUltYjJHRS9qTWEvZWE2VFN0b1RmSFJW?=
 =?utf-8?B?NEFiNlpxMUVyVGxmM1BLTkMwQUVaNEdqSWJFVjF4c29WekpLdUdtaEo0N0FR?=
 =?utf-8?B?VGhRN09nT1JmSjhDQWxtUm9ZR3ZPOXBVeTFUeno4N1VocExqbU9uTHgzZ1E3?=
 =?utf-8?B?Y3dqalBoV0x0bTZrUms5KzBTQkVoRDRUUWtsRkVtSnlPWkVMSm1kNkdwOHQz?=
 =?utf-8?B?WWl6dUgwdUQ4UFVNa09nc2FLYUVmQnBGVitLZEsyOTN1ejFiMWdaSUFHVUox?=
 =?utf-8?B?NS9KSkdhOFY5SkFvRzNGZGp1d01zREU4aCtlcm1ScU54cEpGMXZmZk1MOVRQ?=
 =?utf-8?B?Vmw3TWQ5L1BPaDVoZzFPdmpDSmhQMkV4cnVSZnVsUEwyVFFUeXAwTmVSRGps?=
 =?utf-8?B?eDJESHlnTVNaanduVzY4d3VXYnM1bTJmd3dzVElkWFhRb2NsRm1yWlJMTHBJ?=
 =?utf-8?Q?0HopecJMSifIpmY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <266188F883FE9A4D8A22BBB9ACE0BA67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9eEZYLRon/jIC8TUmCh5FQMY+mWPXtBrAYMkHpqcuiR0WmuUEAgjyVFltCRQkZjc5zvKO1GhxItM0PEacOX9SO27uzvH9G8sH7D+Y6USnfFacvzU18P35/glGR9s3+6udPoyTmE4mySMcz5D84VLvoaIOkrDiTmS1K/aW6PZsQzdTUDtfKFxs0CtSaVICGJq9OQqzeetiBTfM4c4CMOPcjPjyizJVBu+OFBXAoDJVVepP9vCpFRJKxzYFHTNmkTvKdgetYQtMHUF1+PubFtL7RCe1bIOUe5VXFo2tEKxgXulovof9XNDZvpHXRXGlCnSb4LGlRjX5Tw6HakvdFNMxKSFCpOmEYRqKB6GHF+v9I1tV6/eg/U/ospJ5piV4YOai7A9HTd4i0d0WFwuE2sTI5/ewpXeM9wQANvI4bc7hW4aVRabkkVJGRhne6me5kB53t1s6gFpUaX1wm+4M1tgD94keEeoq9kzg/v2MeBOESqlzUNux7XirjatKSHFleB5ziEpHf5o6o91jk3OcjvlM1gO/kDhzHqA1eLEbxSTERHLLq0ztOoZ7NcXHYkEP/3CnuNzN3gTMpgab76YHvpPW8Wg96w42Anr0+izi0t/DGaQwQB+OWEeN284BTSPm/6C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc69deb-63d4-41c4-64cf-08de73a72fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 13:18:23.0308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGuB6yhDGmb5VDXp2uL79wzwIoR6lEdmlZf8L0SShqOPsofgIdJszSQ9vC/nU1yg15QNf6MvShIo3/7gGM3NGWqjKcMzhKEh0xP88PChsWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9564

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
