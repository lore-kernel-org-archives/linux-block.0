Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78E2E8E14
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751959; cv=fail; b=mmEeGBQSbQSVwSU3nYBCAGt+pWEIM2NVZNq7bjGeNGtf+GwKNrpiPKTBXDqkesl2Wr2lcZr2i0cXrd3pI02ToqD+cFbO9rBHo2E38n2YYBGK/37rKSHvp1f3re2jtJvSEei0lxPOwQpdchS7RV4URIM9Mzrj7ZhVhvfFeH5b8gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751959; c=relaxed/simple;
	bh=arpcQP/2gfE74TmnSBlRmwdFIf9TnolVvJw97qOhMTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tk0sNTayzy3qsPKQfVG0znckl+voDDK8aU2Hi/XJ+uUt5rFJwCGbdzE++IRDMrrqkG4MXLWJhRsEDtzJc/Ao74Sfhx7tUsO/XZfzMxDPkuPcnvsEITBLw4bUlVJgVqjgLyTzhP4+9Qqz49abnDvy8htpDEpdkxaJL7Gs6QtJoXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VztMusVU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W0Igs5fS; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VztMusVU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W0Igs5fS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761751957; x=1793287957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=arpcQP/2gfE74TmnSBlRmwdFIf9TnolVvJw97qOhMTc=;
  b=VztMusVU1tuefXj3rHawo8sEjWCtKEgnAKwWGSBg8flv+ISB4YsQUu/5
   jGja33sfA5kjoNgfo/9qxWq6CtKdIw9FYt+vXUAdDN3h7RdnDxEm/G4ap
   VuDNCbDYczu2mH2DqNLOXTLNZQ67qD01H8d9gZOuzEuI/CwYEMJI/s08i
   X8r5oG8K1oLuQFuLpP6r8yZpuXrz0Djov+DNg8AiUfRUARr34okupNOj4
   9xIC7LzRu3RpvjLgP4Ix9z9eibCTj4dtUWYaNc+pksfdyPurPaZhsUFSH
   +XbecLmwo4PV9V5ghXhF17Z0SzDCOCPY3+FYiXfWEjP4WrviLL216cM+y
   w==;
X-CSE-ConnectionGUID: zL+50L3hTmuTa2xHELeYCQ==
X-CSE-MsgGUID: auQWsbSgQ5CoD5zxJFpgJg==
X-IronPort-AV: E=Sophos;i="6.19,264,1754928000"; 
   d="scan'208";a="131125281"
Received: from mail-westusazon11010019.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.19])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2025 23:32:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3SDRBRXRa0ANN2CWAy71I7i6JWMkAD4nqJxrJQyNLfvB5vOBQn3hKCO5kMoijSL8CJnlahGKj6ILXa19FiElnXUEpLhEq16zR627mkY/NjHev88H1838DnqWYOakkAU8s5CXmqv/UQF0u1MzXjupcr3tzRrX6hL3l+fatChgSrfmJnlfsKqxYprLGDJVjNcN6LMV9Vgy3kkusfl5B2E2TsmKO5nE2dib4rqIQyL0fMhz80ArpAIcksYJ7MXt16Qa0ikNUNUEWYWAm8zrePeRAXqYvADG1UP0nfVvx0NnQhbWGj5XQ3xOjOBxTCYPpXSruhiDfP91JT/zAx07wDzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arpcQP/2gfE74TmnSBlRmwdFIf9TnolVvJw97qOhMTc=;
 b=JSVgZcQV8kpta3r8eAFc71Oe/+/0zs6kVEUVgTtv0NfMWvPnRTy+ikPQCjGGW4Ye4BYr6oRjARVps6GQ+Ude60EeDvd20HIJt10SCspqpXl0vsZRIzlPtVMDEeOVLLufd6w86MuUFPe7MVo6uHKlCdnDXRvy74IzEv+oNDijivtpp3gqXm2M45BOdYKp4sGA9XLfpfeXADf5NJfPOrBvmyEwG/4Oy8HVkrKQF6chTDIFstz3CkhLRm5/yqn9YedXdEBJgyZOXtQ/H/RQ9J4QyX4P+4y3o008c7BySJWCry2JFuSjNGILiLvoBYy/nTo/C9n2HvRckVNWWIWJTf8iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arpcQP/2gfE74TmnSBlRmwdFIf9TnolVvJw97qOhMTc=;
 b=W0Igs5fSKPklUvaRN9OhocPT+gePI72x49SF2HJboBcCJy9cXTwTqgaHeyFOYHssRCUIutGzSatMUPfqUXyIqv6H7VBGsrrvEUU3wVQ/wZZVoCR+L4ekp5wcz7eHTIccuWzpT95CXJaz8QMKVbKcvN3inI+otU5aB7Btu5FJvf0=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by MN2PR04MB6800.namprd04.prod.outlook.com (2603:10b6:208:1e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 15:32:30 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:32:30 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Thread-Topic: [PATCH] null_blk: set dma alignment to logical block size
Thread-Index: AQHcSNmRMl31g9c7cUqN+P/TmYvZCbTZKlqAgAAWbAA=
Date: Wed, 29 Oct 2025 15:32:30 +0000
Message-ID: <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
 <aQIgvwec4Ol7ed8K@kbusch-mbp>
In-Reply-To: <aQIgvwec4Ol7ed8K@kbusch-mbp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|MN2PR04MB6800:EE_
x-ms-office365-filtering-correlation-id: 6b81f351-e5d1-4437-9fe8-08de17005fa9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzJCek1iNUM3alV2U09xOS83VytIaHNsZ21ES1l3NmdGeDdxcGQ4SkFRa3hw?=
 =?utf-8?B?dVhZWnpQcHVYZ0ljaGM4Q2VaYWdIL0V4eG03azhmSkR0ZHNJNDJlaFd6b0h2?=
 =?utf-8?B?Y1c2VE1CNlYzVlJoNzIxTDEyRWRwWkV5cjJncm1KK1FNMzZ0MzNFV1oySVJo?=
 =?utf-8?B?Z2RGT0xJSUdZUjR5SUVBQUk3UkFDUlp0QXJ0NFdTL1h2NUNHMkJlbWlCNGt1?=
 =?utf-8?B?LytmNy9XdFJ2OUhaWmNhK2hnUHY0UmJQOHJURndBQ1NyTHVPTVdyUXNoWDlX?=
 =?utf-8?B?dDdIZzhPemh0UGdmOUNIWENaS2F4YmVJY210TW1mc3VSeTkwWFExZWpqUkZx?=
 =?utf-8?B?cjhEczFaZ0NFZkdXOElxREVtcVZUYjFoeTJickhEWTlNOC9JQ1JLTWZ3RlR4?=
 =?utf-8?B?MloveDV0anVtOFMwV0RiVDRWWnJvbnkwWVkycEZoT0hMOXZaOC9renpQajBB?=
 =?utf-8?B?RElOZ29KUDF2cWhFR1RINXdYSk5ZdjRha3A5QkxDRThTUkVXd1hndDdiWnlX?=
 =?utf-8?B?amJIMk9DYk9pNVFGaWM0YkYwS3RGaHZWUm93YWtSVlFLaU5VKytQWXdnS2lO?=
 =?utf-8?B?aXRTWmEycDViQ2JNN2JjSHhoNWlIOEo5dUJUTVZvU25pNEFxTmJKWmpveFdt?=
 =?utf-8?B?dFo3ck1TU1ZxbDNZdXhiL0w5SVNPNzAvd2VjUVRzSGlqU1RwY01rbjl5NkpI?=
 =?utf-8?B?WjhTQ3g4VVNhaDFnRzUxM1V0QzVFSXQ2RTNBaTZzN1R2NG5sdGk5ZzlsQU95?=
 =?utf-8?B?MEl5ekFlOEJ1SG90c1RwSVpGTlI4L2J6Z1J3TUtmRTRTejNKaUJJUTJYTkNP?=
 =?utf-8?B?bEZXNFJNRkFXVXhPcDVWUlZhQzFPMzlsV01HTTkxOWtXVGR3b0MyRWMxWHEr?=
 =?utf-8?B?eTcyQ2kzNGRPb0xpRlNZd09HbitoZTZjK0lJVHJpYTBPOTc5QVJsT1dtZVJ0?=
 =?utf-8?B?S0ZZQU9PaDdHTnlUQjFicGNXUnZKa09lWElpUWdkYnV4UGh5c1RaVHRFTjMw?=
 =?utf-8?B?UEZIS3QyQWlReXNUZnk5NmtuQ2VHeVYvMzFHRVRLVzVBUkk5N2NEZXlqTWJu?=
 =?utf-8?B?akZoOHY4RGloYXVYSTBVc3ZSK0ZXNGl2Y0x5em9OY2FpYmo4dG5vdmNNcVll?=
 =?utf-8?B?b1JoMFNHUFc2VnZjOTB3RmZUc2dYb1NjQ3Vxa3EvbG9MdmZqTzkyZTBLT2pY?=
 =?utf-8?B?V0JFMFZDMHJ5QzAxUEp1blhVaGdRQXB0TzAzWEY5MFhydE5zNHVBSDg3VkRF?=
 =?utf-8?B?WW9kdlUzYWJtS2U1VXNEaE5NWUt4T1BwS0RpUmlCeUE4QzhsUUpCOElpc09U?=
 =?utf-8?B?TSt0ci92ZnF4aWNlK2RaVkhwY3RWb3d5aEkxNU1ydm56SWhjRlN2RWRKQkVq?=
 =?utf-8?B?RnlZNHdGYjhVRTh1VjdsdWNZWTNRM21KZGM5K2RmaGZnMEQ1WVlPa2xLbWx6?=
 =?utf-8?B?K0htbVNZVFMwR2ZkQitOQk9IcGw2ejZxalBSMGc0bjdZcTdUcUc2ZWh2SzZo?=
 =?utf-8?B?Z1pCV1haZjN3RFVaeTNMVXFSS2x1cXhaa1V3OVBLWU9XVUFqN1hNd2g2eW5Z?=
 =?utf-8?B?NGNDY1EyYmkzaklKQlNTZ2NtVFdDczd1M0RpdkRiUXlMV2Ftby9vZlp6THdI?=
 =?utf-8?B?d0s3L2FZaExKSHZSVnJheHJMT2swdjlJbDV2RG83dUpkaEJndTlYd05pMzkw?=
 =?utf-8?B?SDZmaEVNbEhTS1FzV1JyNFh4RTlyUDV0VlQ0NXV1U3lHLzk5U2dvbmVjK2JH?=
 =?utf-8?B?MDBrRnFFSWJZNXhZUGF4UzhBalV2dDVzTk5kd251ZFZUdG1JRklHTlBiNHVN?=
 =?utf-8?B?UGhHS1NaZllEaTZVWlZuS05kby9DMFVYdFZ2ZE43V1owekRIeUNtOHV2dkJx?=
 =?utf-8?B?OWtCcXBVbmZWUysyRUlGZFdhQTNodlBlRmFsMFZKaElCNnJCK0lmcjhuSVpr?=
 =?utf-8?B?cU8wc3NYSUtOZVp1b0UrVHJDRGlHT3hrSGlwOVFYT1UwdWxFVU1sa2VzRi85?=
 =?utf-8?B?NHRGOCswY0F6c2NadDM5N0RQR3IvVG5jQ2dMN2xiM1hlOUN0TVpia2tTN0lO?=
 =?utf-8?Q?mcuiKm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3VpMXpLSjlpanNvQmdOelZCZE9nUS96QUNCZDZpcXpEQ1Z4UEdFdWNXdWZp?=
 =?utf-8?B?Nk95Und1WXIwL2I4WmxtdzFoL1hIOHdSSmZFWnRDa0ZBVWsraFdwQkRrMVFT?=
 =?utf-8?B?SmZUeEY0dXBuRmF4bGttY0NSQ1dQbHozZDhoUFI0NE1BdFdIT2svRlM5WlQr?=
 =?utf-8?B?c3dWa2FZbW4vWDBQRVlOTXlUcExobmJaKzNDcUdvUkxkbEp1QlJjVkM0VjdW?=
 =?utf-8?B?NlEwcmxqNnBaSzBvMFdkcEZkNFlneHZ6TndwS2N2NHViTnpBWElOZmxMbHR0?=
 =?utf-8?B?ZW8zSUN1K2p2Rm5NWCtidDdCdGtQeUorM3A2RThIRlhRZFF0L2VWUlkvbklM?=
 =?utf-8?B?d0JoR0FvTlRxMGlGU3cybkhqNUtFeU9WUEVqRHdJM0d3RnJzVzdGUlBOQ2Jy?=
 =?utf-8?B?d2xpdjBBN2tFa09jR1BOOS9OKytEWlpIRFJLZHp2SUVCVFR3ZlhRai9zd1o0?=
 =?utf-8?B?aXNrWXJEZEM2OG1ITHZEVkpqczRLU3lwa202VjdhVjFJTHFMQm00TFlyYm10?=
 =?utf-8?B?NzBVVjljN2F3ZHo3V1NaMy9Rb1M0dkpiM1krTzZxVndXTkxGemwwbnFpZnps?=
 =?utf-8?B?SWh2a0FjdTBrOVdST2RoZGxXaU9UM3pyZWRESlFlYWtjL2YydTV2dVVOVU9W?=
 =?utf-8?B?U090Qjljb01LanNSOHlzY1RMcW1ycGp1TzRrZHh2bURENE4wRFFnZ2tJWmJZ?=
 =?utf-8?B?SmdsZFZ2cmJ6NExsdk9MZmtDQUw5VFY1TlZxOE5HdWZMRklLS3l5cnZ0cWZE?=
 =?utf-8?B?ajJ6QmFBOVBCM1JHeW85YnlGTkNmOW1wQU1sZlk1RkhQU1ZET1V3WndCek44?=
 =?utf-8?B?VGNuWWxlRXdldU13eCsrSWQvbzYvUnVTbWgzYldUbzF3a2Mvdi9oeVhpV1Fj?=
 =?utf-8?B?d0FFV1dYb3pnbFlMMVhhOEp6Y0FBSFJlVXhvUWNBQ2FrWDJNZG92TEczVmFQ?=
 =?utf-8?B?TWtFQVZzZzNJalBPZUZzMU5rZHZ0dXFlbWVURThyUXVmOU9ZK00vK3ZYb2RT?=
 =?utf-8?B?VCs3aFNodDJOUVRNK0NXR2NHRWpoN2Z5SjUzTnJTRUZVMHF5Tkx3UW5iM2Qx?=
 =?utf-8?B?L3NLNGRTejNwaWlvSmhzVnIxVmJPMVNaSkY5RVBoSm1yM2pqZHZ1b2s0eFlu?=
 =?utf-8?B?em14eXVBNTYxSE9JUlJXWjVRa3lhNEZsekRlTklzSWVuNDM1SktER29TTzhw?=
 =?utf-8?B?ekFHa3NtdU1BRXpUbGZvYmlWTUQ2TWVHdno1akxjbUFRSHdvT25iZGR0MTZT?=
 =?utf-8?B?dEZENjE5bDJaWG1LenpJaVV4cURBbmRva081TUs1YWtPRm85SkJqVCs3c2l4?=
 =?utf-8?B?b0hhVS9IRUhHTW5MRituSzZxQkR2aVUvTWJBaUFZdnUrbFJIMXM1MGhiQ0Y0?=
 =?utf-8?B?UGRGKzJUNFNUUkxQbFVMY0VuUmJkSmZEeHFkQnZ1NmljWk5vL2V4eG83dk1q?=
 =?utf-8?B?TzRmOURBYlVEM3FuS2Z6NDlYK1VrU3NYc2wwWHlZQnordHUzT3VOQ3ZJbkxH?=
 =?utf-8?B?NmJlbkR6c3NiQnZVcFZxWW1wYTc0aW82VGpUN2xxL2lYalRuVHhPNkk2MU9i?=
 =?utf-8?B?Sy9wUTErWDExbm9neDlWcThOR3YyQUZHOVlJWU5mL20xdHZSQUV3dC9MNHR0?=
 =?utf-8?B?eW5mSEcrZG1sRnBEbkcxTEt0amhmZXd4bGQ5dUNCU0ZybXdiSm5DckZnVTZv?=
 =?utf-8?B?ZDRPY1Q4SDIrbVBOd1lHTGlKZElsN0NFMlc4K0ttOGlBWGtubjBHYXQyOW55?=
 =?utf-8?B?eVMramdDMElHWFpmS1FjdWRsaEhKbHFBU21YRWluUHhMWlg2R2hzdlM0SSs4?=
 =?utf-8?B?WjRHWEtwcTJTUFFzQThWODV3YlNuVHdUQXEvR05HNmVMbytWR1JrRUVHdTBP?=
 =?utf-8?B?cTBUekowSFMyb3ltdlMvNVE5TVlGaWxoVEtoL1gvL0FPSGZ0UjFETGlSS1Fn?=
 =?utf-8?B?MjFyUUwrOWtDZyt4Zmg0UjY5aTJxenk5UlBabUM5TjVQUHFmRTRIcWQrS3Bs?=
 =?utf-8?B?VTNCODduN1lBTGw0RmZDcUhHNCs1anpuZk5XTEZoMkEwOU5QKzJxd2V6Q3A5?=
 =?utf-8?B?QTMzbTh1VFRadTVhRUxHVmlvOVZuZnhWNGJldkVWTzZ4UVo2ZVZGVzFIbjZ3?=
 =?utf-8?B?YU9VM2JpeFAzejBGTkdWQnR2UU1LSmhxN1Q0ejl2TWZRME1JTHcxa1lid0dv?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5001CFF93AEF647BDE175E5B1D97214@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NlL8ZFoYcViMTkqmkVVOyaQyrkCff3gM+ZgFILMb/9CWmgni/3OuHYaaAZHroeyzm2Kwrr9v2Y01TEZnwTO7sFC40BRfoRe6h+ECU8CZIvgA8oYnevOAraOalNJJjqygGaB1Dj7ApD19Lxaplj3Y4mv1h12eqBxcm4GLlb5lhCugVXjWtl3WgYZ7sX7fx38q4Su2MnnEANpjhmr9Z+w16A5K2rEtcIgciUP4N72v5pnzebJUv8rnJ+ZqCri0mvDWHv06G0oRVj17tvZj7akLC4VZfHvMjuSeIpqw2wjV5ScokDH2UW8craGQ3rV58sg6YRKFqwAs18DZWYt34Nb+dFetG8m5YlqIVFacZvk6JA6lZIX9o00btjXvNDkQHR5ejZXy+X+RAj5q2NZb/O89tdd4rkaXsDBcPI05MkPEe9VRM2xR+sg5yRzBixL6CR/ZLOZJIo1VqGIIn2ZSZmTItwxbG23pMccrk/qe23r1+2R4uCr/PufSkbIeRr+MXE2BjmDV37ItQNfm1nXifxj3OnHmhF/2kuwam2rXewSiLRWNybXl/BqMYzmWCwngaLlnfErgCUGV9jAKkHhoE7jkpqxwdvlSnlKBc5wxqbPfFrj3HAM1SCoRHxIC8LJ/CQir
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b81f351-e5d1-4437-9fe8-08de17005fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 15:32:30.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMO1BJuvbxk0dLFPUVDt2bV1sRV9Kh8Ijbbr4yHz/4q9zFDN8UZG4BfC/dFn8EXdGVtkyWiV36Uq3s4p3jajiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6800

T24gMjkvMTAvMjAyNSAxNToxMiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgT2N0IDI5
LCAyMDI1IGF0IDAyOjM5OjU2UE0gKzAxMDAsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+PiBUaGlz
IGRyaXZlciBhc3N1bWVzIHRoYXQgYmlvIHZlY3RvcnMgYXJlIG1lbW9yeSBhbGlnbmVkIHRvIHRo
ZSBsb2dpY2FsDQo+PiBibG9jayBzaXplLCBzbyBzZXQgdGhlIHF1ZXVlIGxpbWl0IHRvIHJlZmxl
Y3QgdGhhdC4NCj4+DQo+PiBVbmxlc3Mgd2Ugc2V0IHVwIHRoZSBsaW1pdCBiYXNlZCBvbiB0aGUg
bG9naWNhbCBibG9jayBzaXplLCB3ZSB3aWxsIGdvDQo+PiBvdXQgb2YgcGFnZSBib3VuZHMgaW4g
Y29weV90b19udWxsYiAvIGNvcHlfZnJvbV9udWxsYi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBI
YW5zIEhvbG1iZXJnIDxoYW5zLmhvbG1iZXJnQHdkYy5jb20+DQo+PiAtLS0NCj4+DQo+PiBBIGZp
eGVzIHRhZyB3b3VsZCBiZSBpbiBvcmRlciwgYnV0IEkgaGF2ZSBub3QgZmlndXJlZCBvdXQgZXhh
Y3RseSB3aGVuDQo+PiB0aGlzIGJlY2FtZSBhIHByb2JsZW0uDQo+IA0KPiBTb3JyeSEgVGhpcyBp
cyBmcm9tIHRoZSByZWxheGVkIG1lbW9yeSBhZGRyZXNzIGFsaWdubWVudCBjaGFuZ2VzIEkndmUN
Cj4gYmVlbiBtYWtpbmcgdG8gcmVkdWNlIHRoZSBuZWVkIGZvciBib3VuY2UgYnVmZmVycy4NCj4g
DQo+PiBAQCAtMTk0OSw2ICsxOTQ5LDcgQEAgc3RhdGljIGludCBudWxsX2FkZF9kZXYoc3RydWN0
IG51bGxiX2RldmljZSAqZGV2KQ0KPj4gIAkJLmxvZ2ljYWxfYmxvY2tfc2l6ZQk9IGRldi0+Ymxv
Y2tzaXplLA0KPj4gIAkJLnBoeXNpY2FsX2Jsb2NrX3NpemUJPSBkZXYtPmJsb2Nrc2l6ZSwNCj4+
ICAJCS5tYXhfaHdfc2VjdG9ycwkJPSBkZXYtPm1heF9zZWN0b3JzLA0KPj4gKwkJLmRtYV9hbGln
bm1lbnQJCT0gZGV2LT5ibG9ja3NpemUgLSAxLA0KPj4gIAl9Ow0KPiANCj4gSXQgbG9va3MgbGlr
ZSBudWxsX2JsayBvbmx5IG5lZWRzIChTRUNUT1JfU0laRSAtIDEpLiBBbGwgdGhlIGRhdGEgY29w
aWVzDQo+IHdvcmsgaW4gc2VjdG9yX3QgdW5pdHMgYW5kIFNFQ1RPUl9TSVpFIGdyYW51bGFyaXR5
LCBzbyBkb2VzIGRtYQ0KPiBhbGlnbm1lbnQgcmVhbGx5IG5lZWQgdG8gbWF0Y2ggdGhlIGJsb2Nr
c2l6ZSBpZiBpdCdzLCBmb3IgZXhhbXBsZSwgNGs/DQo+IEFuZCBpZiBub3QsIHNpbmNlIG51bGxf
YmxrIGRpZG4ndCBzZXQgZG1hX2FsaWdubWVudCBiZWZvcmUsIGl0IHNob3VsZA0KPiBoYXZlIGJl
ZW4gZGVmYXVsdGluZyB0byA1MTEgYWxyZWFkeS4NCj4gDQoNCkhtbSwgdGhlIGRhdGEgaXMgYWN0
dWFsbHkgY29waWVkIG51bGxiLT5kZXYtPmJsb2Nrc2l6ZSBzaXplZCBjaHVua3MNCg0Kc2VlIGNv
cHlfdG9fbnVsbGI6DQoNCnRlbXAgPSBtaW5fdChzaXplX3QsIG51bGxiLT5kZXYtPmJsb2Nrc2l6
ZSwgbiAtIGNvdW50KTsNCi4uDQptZW1jcHlfcGFnZSh0X3BhZ2UtPnBhZ2UsIG9mZnNldCwgc291
cmNlLCBvZmYgKyBjb3VudCwgdGVtcCk7DQoNCkp1c3QgdG8gdmVyaWZ5IHRoYXQgbnVsbGJsayB3
YXMgbWlzc2JlaGF2aW5nIEkgZW5hYmxlZCBkZWJ1Z2dpbmcNCmZvciB0aGUgY29weSBhbmQgaGl0
IGEgYnVnX29uIGluIG1lbWNweV9wYWdlOg0KDQpWTV9CVUdfT04oZHN0X29mZiArIGxlbiA+IFBB
R0VfU0laRSB8fCBzcmNfb2ZmICsgbGVuID4gUEFHRV9TSVpFKTsNCg0KKFRoaXMgd2FzIGEgNGsg
YmxvY2sgc2l6ZSBudWxsYmxrIHdpdGggdGhlIGRlZmF1bHQgNTExIGJ5dGUgZG1hIGxpbWl0KQ0K
DQoNCg0KDQoNCiANCg==
