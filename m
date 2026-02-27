Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A7301465
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185719; cv=fail; b=eY8Uk+IYyI1Yt6XPU36dka5PNYIQv3JcYSCRGaRbF+miIF2e1nik690R0FGakOwntYh+amAlaTpEk7SJGv8es88M4afwNQ9XOvviqkiaNxt+1WMHeEs4k5NmvXUoD9KcrIxkTl5AKnLMoTwvM9Id00ocWg8AoyM2YiTVlXaH9S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185719; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UGrICuRQMYkwCe6llrhye+BpVkytyQi+uH5DuGFOj4qMyL9+Kj/ijBzZ25OQDksD0GySII4Ic7YWvsndS3OKNX1AEkzNXLkRR68ckqaB6BwFKutrzUR6Av3J2qlK+fvJWog9bF2WA66hckHj4Ja9VGCzrdMnsNEPNXQUHZHOu78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AuPVJDSo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BqA5Xtot; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AuPVJDSo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BqA5Xtot"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772185718; x=1803721718;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=AuPVJDSoMTQRW+CUsZIuflXr5+MisiPdAc+/4nuibJi2MEhA/QIlqxRy
   py/kSUfNSCoG3rERco9tXrbcHTHXuV8pJkljVBhS2+ZpMEugjkyt4E/Ad
   YK3obFt4tdDkam7OMzUVgrUzVFtlPjW/B0tG/vF5lcjO7xjK1nmZjFP+9
   ue18nCCZriajs2/QoWqsEWimCr8dAqV8kuC+ikUxHpF5KIQqq8MCJtUBI
   6nGdEmNalXBUAw4i8aRadq1Yv7PAZdz3TPjqQXD250o11EibXOZHDCe81
   Ii3ijEtKs+UkWZmmG6Yx/zxiUYcnVxvfD+H6mSGeM7fndEwQjrrZvXZMB
   A==;
X-CSE-ConnectionGUID: mx9pzmnbQrqEg1jGuOvvSA==
X-CSE-MsgGUID: pAwUhCqvTj2A/LnsWjzopA==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; 
   d="scan'208";a="141583211"
Received: from mail-northcentralusazon11010021.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 17:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNUC6eipdcdfurgI7wYdjGrPeBQNF5J31099kVyGtNXUeELoky2f396V4Ti1QQMFcu6UWJLMb+h9Ub5/XFXvezvhtCNpwlrtS802xcnw7YJdJ1SP+LkOTSrnMFu6mwxfp7JN9WVR+FUt6/jVZkj4R+fOCJHv2kXCiVAZ0olSXTOSamXlxrKB/mey4RnP7uxoQqUgi+4jCNjgcblt4gVYoaP5vMcIAROPTxeB5VjEWgTJbig0GeQvKtdo40Y/gPSwL0X1SHzj3dy6HEpLQsnaQMcY3bhSwZ1Vg6ihsLqlIT2I+fiAtHy60chtD45NDNpK50dpgd8JWNlCXCBtNj4WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=tTypbyDtw/dnDkjEgx4DXj1e/JHb8vhX6i2dmuB9DmIsiTSHWGT5XM1LEWRTi58HoEhgtAyNfx9iZ9kEfHhcsTSL09mcXrYhIfcMThqNZUaFiE0ZO5txAnIsvl1UqjBWia3cLzHeb2xFdQNLndRStT7p7PjXB7Hxj7Q3xoFYEj47vl2umuwIOi2aZm3yDMI5Q2eVfl/pWTK0CGtWIDwcyvwoq6tG3KwKSLdBhZosSDlIQ61zcuGEQtZ+43185lxiicPh8ERKtZ5IgedOt8o3a2yNxKHCM5GIfA/NVLoIUROEfmmwDToglMxr+QPQhWNEC/YiejqL1MKdyOfTdDw7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=BqA5XtotHrCDLvE+kuhMa4sPzwLKYK+FwU/jmBSK+cajXb1smel0YPQdsrhlcXR31UATA0+CzSHJVZON2HHvC5FbZ8HtMP3Im7YtausnaSG6oMbcCvhsdZScTp7d7rXuM50JADmZyfNEoKSqUqAtw2UOFx9EdUDDgX4h1L8TKWI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6397.namprd04.prod.outlook.com (2603:10b6:208:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 09:48:35 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:48:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] block: default to QD=1 writes for blk-mq
 rotational zoned devices
Thread-Topic: [PATCH v3 7/8] block: default to QD=1 writes for blk-mq
 rotational zoned devices
Thread-Index: AQHcp4wp338aFTeF+kKNkjt9I6FmCrWWTWCA
Date: Fri, 27 Feb 2026 09:48:35 +0000
Message-ID: <c0c50941-e07d-4bfe-87f4-dc32fc257d18@wdc.com>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-8-dlemoal@kernel.org>
In-Reply-To: <20260227014951.2327711-8-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6397:EE_
x-ms-office365-filtering-correlation-id: dcab62ae-4ac9-473e-b084-08de75e56024
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 HqVmxP2WvCTlwaUnygisTlgVj9mYaJQ7fkFzCfUPcr/7lYG2ftE7MgBTfKDCMUX/azadqIsYxr3Fa9aturib3izWtSjaNzV0GEhyDCjBuDYJLj3FNZtkdU47YK4H3TkW/ip2R4YKVBOmblxFQ3YMh/18sxL829XjbYs6OyPHR6/q+o3COg2tuJBo7iIBUbszItR3xhPtYSQyKKzUTRI7I4ton04GJRRsDX3MBruNb7kLJfl1yeHmWfQn5WUPNCX8jbXA8C7zA2BIKkBwZ+zwZ5IAT/jh+49/9m72T8NU1fsXRFX/rn8xCoualGfUfzI9w6ymyaUNfNSiUR7kzW7NkTdl0QQ19dPH3MmVAygXRvnOjWJ0j/bQZzQRqUYHFgcsnO5B5COtw0YhiG/+yJCHS6YkBhg1E5NmGW3LXN6hn2j6sePV5WalzfjXvrUNwR6WAruGbxsTdG0NvqO4/OkRAvO7QZostz3aldLK2gyRig/bmRV/nAH9GcMo+ChqGob8yS2qw2DUxmaH1NVLqBhOeBxyn5Cd9OLS91RlfS+Uj8jOtbHecRLpsj6Hx7nBki4oVMN7MruaFKBjog7PrJDdThOR6tLJulnCOxt2lYv2QgnmkklpXcFg+QmB68wPhA62RPoHLRnnYD0GmxwslG04koA8JH0bhqzWxKLraoQgHi7kKIAdArIvjbu9OwAsfOE3m2TrTFOBnOsT83Zsdwt8s4EJR+O2SedDzC4uj3xSbx/L4ay5gBzEKf+gM5Hz/jtrjCryyWqNiLt/kUGWZE1vjZeRC71n7rt+Gz3MjbJGNnw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFFlenU1cUpPUGRmdHRLaE44aFBKdk1Ia3lhU05SN0ZzUnNsUjNESTgxRmN1?=
 =?utf-8?B?eEsvQlBjZXZCcWJIaEFaWkI2aDEwQU9DUUx3NlRLamVQOWRmeTVrOEdmbEtD?=
 =?utf-8?B?Lys0ek1FT28xSk0zUzBhMjcwZFNsN0lPandYT1Y1RWM4L3dzWnlDd0hjd0g2?=
 =?utf-8?B?Und2U041MHN4dVBNT0oycHcxRjR0bjljRHQ4cXlGbVc4SmVKUG9NMWFpTHJt?=
 =?utf-8?B?Z1lpY0NQMnRGb1BYQjllMDdEbXBEVTdlVnh6eXVQWTNBdEw2TjFlSld5RDQ2?=
 =?utf-8?B?TUFTZm9hczhiRjhBVWNqZXNkVHl2cGhxV1JENTdYaEQxWEp2dUdzMWtvdlNq?=
 =?utf-8?B?VjQ0K3hEK01HaDBKb3BydHZCU1RVWDhTQWdBd1hqQXR3ZVpzdEVBdVNjNWJm?=
 =?utf-8?B?MTNMK1Fic1J0V1JGYVpITkFLZUp4dnAyRnVhd3Y3aWh4M3pBZjNGOU84QnBY?=
 =?utf-8?B?S0VaVEVDdVVQSGVuQ0dBU0tGd01jY0UyNm9qZEhNWmxsVE5XbWh3S3IxNVMx?=
 =?utf-8?B?TW1OeGxIN3g4WmtKellpdnRzcEFGbzFnK2gxQko2S0lkZzhzWlFlbmtIQ1Za?=
 =?utf-8?B?TWRTckZlWER4R3ZGd29IQ1NPL29VMENBaDB1MVNYOTA2NGxYT0NBUWJXczhP?=
 =?utf-8?B?aTRFeDNOdWVzTFB4SUIxTGtkek5LSlFFN3FPQVliSklPZis4MzRnUzNNL3k0?=
 =?utf-8?B?NWdIeUxMUHBCdUNTUFc2WVFNL2hlL0ZhaVJxZTRsQ2loUWd5TVlBajdVZ1ZY?=
 =?utf-8?B?ekVtc250akJoTHQzUmkzN2RFTndXSHZrM3pkcWVYMHZBNnZ1djJCZFU5S0ND?=
 =?utf-8?B?cGZqLzlkSHpHL3gyU3VVMUFXcmcxY0lsallKTUw5eWRKeE41Y2p3eitBaDg3?=
 =?utf-8?B?dzZrMlNoc2RMZVJaK2xITktkdEtwSnVrcXBNKzFzcFNaSG4wNUpaY1VUeHF5?=
 =?utf-8?B?Y0poWDJWYjZIb1ZuYUJ3Nkw5djF3bno5UDhIbEFsVjcvdUZ1R0l4NjcyN3p0?=
 =?utf-8?B?RklOY3lyL0dDbk5NNml2eHR5MmhyRnFiWDQ3ZDlSTWpNazdvSVpXdExwVnc2?=
 =?utf-8?B?SkZlMHBhcDZCWmR2Nk1UOWpJQWNVWFI1M3VTZGhxQSt6b0dhdTRIZkhnNjFl?=
 =?utf-8?B?Q0F3enU4d0ovUDNYRkJLY096bzJHcnFhemNrRjluQWxFMWcvc2krekVrWUd0?=
 =?utf-8?B?S3IvblBrL1ZHaWM2T3M2ZXZlMmVsQTRSQTAyWUgxN3l3V1ZFYnUvRDNpSWgw?=
 =?utf-8?B?bEMxK1hsMUxVbW5lMkV6YTRaZUgyYmY0NG92L1pLRG82TFE5UTVLVWwyYnVX?=
 =?utf-8?B?YnhuRDBOa0JYVjhabzBnK3lCR3Exd01jSHZUbWVSaWVEdGNyNy9wM0xaa0Vs?=
 =?utf-8?B?dDdFWTZNSTJkVHFCT1BqVEV2a0hOamJ6djFzajkyNWNkV1RFSldZcytVWFdU?=
 =?utf-8?B?OGNJd01GOHNNVFVybkpmekdySjJuUXlSaWZPRzhldTgxOE5NOWJXL3lrZS9N?=
 =?utf-8?B?eDRrekFLdkxsYXEzbUQ3SXY1VWZ0WGUxVERMN0JRSGo1d1E5Ly9FWFhmWEg1?=
 =?utf-8?B?UEIzOGJXdFVvVmZmQVI4Z1VCSmtSZ1lPaStIcnRBdlhWRUVZdFp4SHZVTEE4?=
 =?utf-8?B?bk90TFMxNmJwZEt0YjFMcGxudWxQU2hFSzkzWXV4cVhva1RPOVROUFBtcms5?=
 =?utf-8?B?U295cTI3STNPOTdlMDRtb0hCVmVBQmhpbE9ISDhLdCtEKytLUVVJRytKa0gx?=
 =?utf-8?B?aXhWZU42SFZQVUU5a2FzY1lybFpUbDhEZ2NlbEdsMUJ3M05DY1I5czVTamQw?=
 =?utf-8?B?NXdJS2Z4NDU1R04wNkVudG1PdUJMVXdjaUphcWdxTTl3NVdpOFdFNjlHTWla?=
 =?utf-8?B?OW9tL1Jra2lxV1VHenhqZGk0TFJIcUorSVBLYXJxcnFOejVwd1NyK1NRc3FF?=
 =?utf-8?B?U3BCeFA2eEVFR0p1WmNmQ0FFSGZ6L1lCUjZrbWk3ZEluRWllUS9kck5NUXhs?=
 =?utf-8?B?WE5zZGdrZEs4a0RwNGh1dG1XL3h4Q0xjM0xoYlIxNFEyeGtFWjlxZVZuclFV?=
 =?utf-8?B?YWVZWmdFNzU1bFViZHJxdXhZd3VtL005UlVVSnZqbklza2tYbEszMlVBamZv?=
 =?utf-8?B?K01MVEc2dnp6bGliSGMrRnd0SlVhenhES0cvT1p0dU56dEpZVHhWSlRrUW5X?=
 =?utf-8?B?eE1KaVhUQmEwMUhTUnI2QWFnaUhYYmtXVWJVNWZIRTlCRDZhNjZOWFUxU29r?=
 =?utf-8?B?bVdvMzJnVFJ2bDE3QWdHc0VUZzRSQmxwVXNSRExoMDdsOW9SYkhuanE2b0lH?=
 =?utf-8?B?SXNDN0QrUXNIUzRnWG1ITVVvQ0pvUm5kUmdMMzd4d0pyQitTc2g4NXBkMUlm?=
 =?utf-8?Q?RvWGEpg46vqKTYX2raN5ZUBYgS9PNphQGfig27N9k+WL1?=
x-ms-exchange-antispam-messagedata-1: BmrkaETEQ+S481zzGyG6mbZLGZdkwZ4P83I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9CFE3FADED16D4684688AF23C0E2C47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6jcDaNkLYdp1TdPJyI1WxscsKpD++t6OsAZ4o8NlzV9yrVoD6k7LzdhNojlxuWMTBxA9iqMCinslOgJQ4S2XnFdvl+KIhXrD+F8EYWCOwilCuiPrqBtCq8j6C/nNxqYDD7R7jrtB7HUMczb3A3p9ycXzaT2zKaPdY+kkhHSimIdL5muZtslUA3fWWhbmMuPhG4WtMIzLGR6KEbf777+f5UAsiCRCEuJB0Kq9neVFRvd/90pjgdLu5FgRzQ4K6FktNf/zE724fn877kzjzTjNIbbm8J5sgNgSspE+fcbmrKjKCVzQX+X8yF+8SYk8uAkd/uH5Sy6hdb1jvOZiRFUNzuKiO62LUv/chPiPnpE3aAz47W1m+kPBesebCz9iuXvNG1nqNrhuqnCkidp4QFveSyqegjCHeltCicAD7jquh9lgHdOX8AyYL6MLm3kqVbRdL9ToK/YxNahqU2+2SzaYjxqj9LnA0FRH1Bm1Yohnc0Th1MgnVfm7vQz+ihNXldEazcJtHS3I4G/yv9HYc9h0FYgdSTztWxlaQfUDll8PrjJRCDvU6b89PLzVjzYfwFU4zVCpMnmSqjyN3ZeDya9FBZVdAbfqSEHEE17lxgGocoFknJbG33/v55wdxeVc586e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcab62ae-4ac9-473e-b084-08de75e56024
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:48:35.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmhE2hRLjUTZmRa+zaDNl3ItO0MXWaSvR68iQxZSIBLZ3FzNGLkAvaicxiI0Uz8qa4zvWIDkCqC07FP9iNB26Kjx2ZIJua0pYY1Dj0mV/pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6397

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
