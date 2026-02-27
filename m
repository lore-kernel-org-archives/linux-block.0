Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496393A9D83
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199883; cv=fail; b=c5mWJnxD8ezRuMSu7CzrsUC42HOK8M1JmKqnfaTwgzMRaa1wbzb2ZYm/d/AP0Q4WoXGWdB+AyhA2ZZM9dt84mksbg8pF43BSjzbvrcvzymk5TbxGAcBgJ0CJILvsX/s9jroD2SIjNkQHMUDQXfr8hnpEIqoSo743QGnEtUj0c44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199883; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XCHD3B7FR/ukpG1WDJtyYEuBIsii1Wvb709V31e3BWDuMuqcOnVnVcoMPp55DLum3UwLdTI33eCn8XfP9dGGDXFhu9SvkzDNieyMzduxxqHRAa2lAmr0xxULMr2WE3gAxU9hweOIS72Fc1ospXnbuHF8ech7rKCnp4MWUkB5Vx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Uu37ZIVh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B4UNn5h1; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uu37ZIVh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B4UNn5h1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772199882; x=1803735882;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Uu37ZIVhvVPPLGxHlyNVghxf8OXpteOJn4nzgFtTAiK169Xz6sbgqyRu
   apJzQOxKl7cwd0Ofh7lsNWgPTzCo5XzUqmGtnYkLPhXn+5Kqg6wZ8WewV
   O7EqTCc24olGhfX7y5A/KaUd4c2925YIshpTHtuthhyNGcjz3v5MlW99U
   sfe7+uBlpVVEQl+kuu7FTM78pLdvvkBdmiL3kwO/YRtj61TcIQ/VrRQl/
   frgXF4CghsNQ1DR25zdc5vt8btVLtyp/pu9nTdsZyYi2DZq4Gt3VWf+aq
   MwQW53I0w+ZEPGChBmARZntT5bny1wVWV+75p+sNAfuztknmoznB//wnu
   g==;
X-CSE-ConnectionGUID: sEw5ctjfT0+eZOkNWPcb8Q==
X-CSE-MsgGUID: PhnKuM0lTeCmRSiU1L8reg==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="141592544"
Received: from mail-westus2azon11012066.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 21:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScHATUQqXGp7ay6TvVJr7GxSuzYtHjwcY7PBJ90tYO317I4fpTtqcdUBOfhgcHwGkik2E0M3OkWyvKluvx2B03e3PpNsHSbKNV9x0Ra97qAFkUWgmtnmE2dYa5ezg8JBSxcR8h54x/j0a1nUIbwxx1nvPXRt+tjNjvUluGYPw/LSy67nmNRNfjYFkHt2z3+0d5Zl9Jp12+QYT0mucMQDnUWIDpiNhVSFp+5NoWdrs30cBoCeRoZ88rlT2akkWEaJsHbz0iPs/WMSKf4BrxeOifs9K76blmR/TdsXT2kNZ7LgqAj8KzlqXEvk1rTjil5bXKqnC5zbAlQ7TLlfMsF8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Du0SpkBGbXo3XDVDvkEkh7P4znaqo/qerKcNdP992sNzKUm9+xmdd/n0zVeJGkPD81AYpNAo0chsP7eCSZnpQ9tIDspa/Qi4NTe/+wINb7Q65vJwfNHnmOI+ENzxm8Gu6cXJOEulPxnqNjG+9u1EOLkfSJFIGLAYamasiFONatmzUIddfv1f5+DljRleEEEcT1prjgqxFSScepFbhJ2RxTadF0+04ib7AqgCcdfvio6T1bt/MYCMlZ+O/KPtEjkBO5IgHwRgf0ahdflcsX8C8PFessPYychMW+XmCOUOTeRWlCp26vSCWZ8c63f0KOb+NbTbC1ESDOMQ1XsqzyOJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=B4UNn5h1txCX4/+g7Pi4z83zGSRUOYJZPEL9lOpr4DGHfwV7oB45fUp4H4cXuGcbZlomPo336YSwR4bZQdLzhIJMWN9lskSHM2pttJIGd4gNasGBg7DMBnInB6TyL0iq/il8q51zyTuWbkOccogatJamVse6Ek0ZTfm5gVpSJWM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS6PR04MB9919.namprd04.prod.outlook.com (2603:10b6:8:368::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 13:44:40 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 13:44:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] block: fix zone write plug removal
Thread-Topic: [PATCH v4 1/8] block: fix zone write plug removal
Thread-Index: AQHcp+06Zg9cAXlv/Emg2HpHlUPTerWWjpWA
Date: Fri, 27 Feb 2026 13:44:39 +0000
Message-ID: <aac07932-01b2-4626-b0fd-d4ef35063404@wdc.com>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
 <20260227131951.2464150-2-dlemoal@kernel.org>
In-Reply-To: <20260227131951.2464150-2-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS6PR04MB9919:EE_
x-ms-office365-filtering-correlation-id: 4ea10ed6-4b4d-4379-8053-08de76065aac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 kZ8r9ME8IEzHNtQurHJ+FpNl/LKxSVw8ySYBAi4e8az7z4bkQVXIod2W/mSI0/nfietTSr5sL3Hef58dPl1nzQ5lDsnpQjFdSonSwcxw+g/e1BCZkpLlyqRYB5fKAf7g/BztKVySm8MLuBlnGn10YgliL0Zxf+TmiMcjyGq9cg/UfGTYU0f+VVBPsghlYA8hlmVGkxD9qzO9M4eDnAtNAHhPOuEXebTcC7POlIqaAshFCeqllrrqFFJ4wp6nFAc+xUPdf/XJ5em9H4qlE+BaUeLHjNpsmwVrjtoX5W1JqoF5Ftvo2wa8Fm3t64UEPdlvKDH/h4uV720MlGgH4hjSLEGrnAi4YgAi5BE6h3sB2N6mpIav3Ap7tPoUeZ/qrVeGNulEEUU5IqKCfH1CpOzeP30ghrEN82fWOBDdLAU0z3vF+odL0uOYwwaw0VIrP/vK3RNfe9u+OyhZgpb96xc+C8deHvIEennGfaQLNIj/0kYShAiZC1zaRvEx4WNV7f+R/KOuhyKWEGIgjhTt++ENsvtRxoFw11Fq9nFIt32PZmW1fCLGikmE5vU0Jq0t07LAZ2e0cJtz/6c6D9cjHHvPM+ZwFYzYfOnYYpV/wv75/galQbY4vOXZonRa+qbFJalGSDEwxL17YFQ7qDHWjhvdoMCOAvSIcobFhcis7FWeOOIlb9QGpA5dktBD8GJ9YuCk0EpiLy31+5RadEH/pvdc0C8jGRDc11NUZVvVrefKU8YYPXp36KiYfuESzrLfxh/tEEyWgQyhhZczqmJShnTVhBfQ/09cAnCL40o28NXmdfc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmRXRmIySTRPUjNHaG8zQkkrZnJRUG9JR2VqdUdTU2gwaHFvZHMrd2ZPODc4?=
 =?utf-8?B?NGU0SXZSSnVTS0FQelgrdHExSDFLUVFRcnpOUXVPRnNqTzVNREE2a0ZqeHdC?=
 =?utf-8?B?Rm1NSStKUzhsUlNlSTd4TFZRV2dkTnVzWVRpWmZGaEZGWFgrZ0M2RW8vNEJn?=
 =?utf-8?B?MVZ1WXlMdXRpclN3T3loT1R5Z0Y0eG9WOGxuZmRkKzJlVzlnSzhnM0p5ME92?=
 =?utf-8?B?a1IrS3ZhMGtWWm84b0JiZ3lncFF5NE8vTUVSYzQ2QU0yY2FnTDdpanVCT1dw?=
 =?utf-8?B?c2djQUdtd3VjRjhlK0hNQU8xcW0rdlYvelpseTlJWFo5RDJudGRoYlAzRDFL?=
 =?utf-8?B?MFo2ODYzOFBNREVTOUZmZGNGQjdyb0N4N0RhL1lhS1V3OWV0L2JlbnlzMmFQ?=
 =?utf-8?B?d1MwVHF4MVAxeXNHUmpmSzk1WWxoOEdIaWk4MlRzWjQrQS95eFFIM09Fbnc1?=
 =?utf-8?B?elE4OVpIMkFXYlBHME1hOWlLRjZNTjNTYkdFak1makNGWlFEWEMxL3ZUVHZ0?=
 =?utf-8?B?RjQrQ0ZuY2pGS0FrUnpPVXZrTkJQdnRnM3luTGViZHlGQklCUG1RbU1HeWNH?=
 =?utf-8?B?dFQySlFFVWo1b09LWUR3YTd0dFEzR25sam5iZUZWcUJnV1NnRnBKakw0WHNS?=
 =?utf-8?B?NGxTNnVGK2FYSkY2a3luUVNCVHBVK0NVblpYRTU2RWc5dlcvTkVhOXpMZENQ?=
 =?utf-8?B?NEdld2VaRlVnSGpmWStkSVpOSEhYZFo4Y25MWU8zNFVCcXpsSm0wZENUd014?=
 =?utf-8?B?R1RRZmoxc29XS201cjh0QmdZR2ZXcmswMHFhZ0pMUTdZM0R0NkREVVI4NHFI?=
 =?utf-8?B?YVBkRDVKeFNNQWNjT0YzUW4wbFZHYk5nRWNHR05DVWN1cXNuSWIwbnk1Vm8v?=
 =?utf-8?B?MmhlRW8xTmdTZEM1eUJ3MmdiMXZ6Q29SYXNGR1lQWk5QVzd3elFyMDBNcjVF?=
 =?utf-8?B?NHNCQXczbm03NFRBQ1BzRzE0cjhwWGc1NHM4TEs3dEMzbHFxZEhtZ1phUjha?=
 =?utf-8?B?UjBTVmdTTXNzUVRzWTI1QlBRZnNFbVhuVHFzUldCSXRySklCbmtETk5qRUxX?=
 =?utf-8?B?aFBwejFSQjRhVEdwaVozWDZNSjBHSjc2ZGlTMWE2ZncvMWpuUEMrVjVQZVdL?=
 =?utf-8?B?SG52bFZPTkpmUnIwcHptRnNRNmdtcGUrQlZha2lIMlVFWjdDMEdUbEpBbGhW?=
 =?utf-8?B?eUNYT2MxWmxkSjNRcFRWM3FMTW51ZFVpSnRkYlRQenVkMm5DZnFienM1aVBw?=
 =?utf-8?B?Ymlxa0VWYlBtRTI5Unlmd0pId25jU1pWZ0ltWWdPNWdRNDd6S3VwaTM2dVJa?=
 =?utf-8?B?b0IzK0xMckpBaDRPR0lPemRPU1VwY1RWY0g4THVQTkY4ekl4dUw5M3ZhWnJL?=
 =?utf-8?B?bXZpSWVUMmpRcWhIQlFTV1YvZVM0Qm5pT1YxRjZvVjRCeXNBd3k5aXB5S2tZ?=
 =?utf-8?B?L2puR2tHSXRjZW5FWk5jYXBlYkg5bHkyZ244MHRFQjNaRzkrblpzQVo0akFU?=
 =?utf-8?B?eVBGUGpJYmMyem0xQTY5aUovbHpCWktKV2lYSWFiYWI0VkdLRjFBWFhPekFy?=
 =?utf-8?B?L0QyemNDRUpGM3hwTlNRYmhwR3A3NmVjT3J0N0dIemFZV0dxWGZ0SUN0TXRJ?=
 =?utf-8?B?ZWFOK2E0bi94c0Q1UzlqS1gvZm5WVlFzdzNJamlPOTk3SmwrWU1nSEFqM2ly?=
 =?utf-8?B?YVVHRFlJb2E3K0wvK0kzVHNVRnl0QlBLaGlOSDE2Y25mRnNDNTJISHJpNlh3?=
 =?utf-8?B?eHkwMU1MUzduZ2pNSFFYTzhaa1Vqdkh4ZGF6Y0hIYzlUK3U2RkpyNUxTTUxl?=
 =?utf-8?B?Zy8rWTdXNUhsUWtkeEt3NkFRQ3VwbHE0WG5aWUlSSHhsdzVKdUFQbzc1ZXhY?=
 =?utf-8?B?UTZoTVg4YnprdndkU0xnZlRyRzJaSmdxcDh0NmJzc3dqdzF0ajVVczRxSVFS?=
 =?utf-8?B?ZUxtVkVpakVnTENFNTRnZUtSK1QyamxWYlBGOUpqS3BaNzFKcWRHMERKSUE5?=
 =?utf-8?B?RVlSWTNjc0Q0UDFhSEppbDRJdUtPVWJjd2x1c0dDSC8xclA5Qkc2THRxQTRE?=
 =?utf-8?B?N2F5dFJheEVTRUVySlovS1hMcERCL3RaMUp2dG5oUG9sbnRQeHNrK1ZOWitm?=
 =?utf-8?B?SC95bkhSMDRWaWdRZmRIZ1o0UDg5c3h3SmhJa0tZSlU1aW5rbVg5enpROCtw?=
 =?utf-8?B?QlVJdHZKaGhpSjRWU21UVyt1QXZCSHpFb2dtRTdGaEhxMHhSYTFmbGdFbXlB?=
 =?utf-8?B?U0lnSEtTTFVVOGtRQ1FVRlZTOWFLMFNrRWxFMGppN0xJUmgwZ3ZwV1YrejRX?=
 =?utf-8?B?aEhKUzJ4Wkl6R3U5OEFvZzlZaUVEQzgvZXZ5UVR2V2JrWnkvMi9DTFVvQTV2?=
 =?utf-8?Q?02iuGaULkadnn7eg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1483DA628FBB642A12FD9583C9B9A51@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xpVwDERLrZQuiS3HOmwptFAg2g/yW7CN5FvaY7UuHdxhzKWnQ6kNrcprWZiN06eNLauQe0lRw4ANKNq6l70ZZaxqozANTwXLTcEqjTTIn4c5EB8SfNXoaxRd9qYvplRIRgUmxfjQb5u8K1890+NQnVmusrSYGRQUHLx5cNYkr6ri7nSv9xNfUqlAiac7xYOegMnU8dxu6MqUbj3MnRE9CGCsdT3taUD2xnJdfwLXDbafSoCYxZ1GzCDzCjg6TVQ/s9XWenPN85djTewoKGFERcAmuxvpAWpPNSdfSO5aP8OYUddfufODf1ySkpqjhjLnvOOkeE/WxB1Kzv5+pLHlS9yPRgCFKd9Qq+8dbpshyNpIhFKmvkr+upnc/huzyADJjRyCsLFa4+ATyODaHORuc2W3dNzhXUuydodU309lXxAWbgTlYa2BAgz2Qj30VfZa4g4aXhgrj+L1ZdsBuTPXVQbgloqfL79O2DUDdbYc4IdNQJBhSlKUGhorse/m2f1xRzm/4TdRtt19u3+vcOzTkjM9gmjfql/4oz3TuwfXPtLOLNbnPcfF9OrCZgJE3M9PV3u/VrSbxdLSG4FWBJ4JANTeiUyyBheNk5eTRtMmzWlKMxhz2flSSQLnLU8/VZwH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea10ed6-4b4d-4379-8053-08de76065aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 13:44:39.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HzKreCLVH6KdAsh3J8+b2dCcBGDlqJyPCChJEKwIBux/cVpSBmmHAcAYiHFJ+EZu0KRBPDtHXYaiy4iR36ltTAU0r5QVEDXtoqVfBbbQvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB9919

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
