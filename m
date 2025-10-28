Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93D1799F
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636302; cv=fail; b=qiCLMp7B9a7oC8rJyM/byxKhxCFZ6dA4EBzWDvHK7hZ4hAjZLs9AgafGYxFtZ4+o8y3JqwOAx99TDUXtmgMRJzbRiqIBiKYIeSOEsPrB9sIEGr98rUhl6w9bNpg9i1H+m/KzgwKotlGJ2djMJKx0n2nA9anizV9UJjej1T3B4kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636302; c=relaxed/simple;
	bh=E2v37oXLhZnF1la2GUMdYcCyQpPKOE6AyPPIiET3lKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0oxwzVtZs0MqbI+iis1TpKtl14WtcGNKmcpM0QJ//CyLp9pxPzCI0keH3BV2L/cqgVDSziRTvi4dm+xmycui65594NLI2fBnhjayRtwx8JU8sI1jz49xK+BPtT9UM2OSuOPe3tZyA7Bx1Lt+aDW2HcTcxTOdqVkVoe7T46itFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=duhf+Gxs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nXp34Ano; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="duhf+Gxs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nXp34Ano"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761636300; x=1793172300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E2v37oXLhZnF1la2GUMdYcCyQpPKOE6AyPPIiET3lKk=;
  b=duhf+GxsG4VlSQkOC7wfVsUH84Xj6sYoIHw/X1wlht0+je/f5/argBmZ
   4vdAtbY09rIHaJN5P+oOEA90Evnu1zq2ndL5xQ/tZdx2R0HLiH+BJ3CGg
   0Pyo+4ZdmKa2ToD40ZIKTpwF95ytdczw1Kdc+4f0LO+i/gBKe7wJJsueI
   LL9zhb4DHXegvZoHDvD4m/NTCALBnDt+o/pTIzEbx2njFCRI/8IV206br
   u7FmP54y71JD9RU8mSCe4jkAVhsenU2hXkjLcdnvf5+kv4Y+A/loMQ4ux
   T7bPZDrDEfPP3mq+D6AhIX0NbfCbKw38OmLKFmHOLgAuS+Z559yL3aZMx
   Q==;
X-CSE-ConnectionGUID: 0aZJ7ocCSxilJwC0u6FC7A==
X-CSE-MsgGUID: LYXIzZR3RmW++XqHtIScbQ==
X-IronPort-AV: E=Sophos;i="6.19,260,1754928000"; 
   d="scan'208";a="135282373"
Received: from mail-eastus2azon11010035.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.35])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 15:24:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3PWoh4WCP3YTSjG+0ZVXEqyBGRywZXyKEQAztBBCRsQA7sXAw3BV/kHapOcw/QO5kekrAdJhaGBfQTgbwTXcwkH/ag5DpeajFpJbJF2CVGWzn6GmTHZwjvECt6JHwc6zF2vIOmjyVrxN2NH1N3f8kgBoO6sFMEG8DKbjoIezP4wHSs9xepXmlr3t0S/gH7ANfvvCzeloFPoK45w33TEjI6ipJp+dGb2S1tU41tqIsYLDdYU2g/qb/0676EQI6NoQ5c8yVYN5xW+XczkNxq6OGMacc09p36IHKVDm0SYwnAfIh3PtrjCy9ixBpQOZODH9C0eLxvjHSTmPHwi1utPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2v37oXLhZnF1la2GUMdYcCyQpPKOE6AyPPIiET3lKk=;
 b=Vov8HrTiyLiFAklC64ziLe4CdPBwD7dLw5cVc2+7uxMRtXRQkY2Z4PVwuDREOwphMlKBIf4gUHV29QpWy7U5BgPNkHDImrfLWuw8lnzCUpywtTWJbhsO4h9tn4ykfHNDWb/D9rFZLP0eRmz35wdJ2dio1ggjenzp/uhPEajwzA+BT7a6Jd7qyoCKj0a9j7Z/NaC9dnX0ZRESZPHE2nViKV58yhKgBq5WGeNaHSGmOMfl6JqqqC2wa99YGFC+VYAAG+LIJ6IVNhUXTVxhtPmjYmFg2088bob4NMXxe/B0l8/mVDSoxdOtTaCvp3/VbD6LM9wYvHAGv+AiZ0QQDbjjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2v37oXLhZnF1la2GUMdYcCyQpPKOE6AyPPIiET3lKk=;
 b=nXp34AnoDacDxc2qNjkIRe4xBo7t38u95/WK9TfhLjhHkqs4675rh6ZdDfqzJ0JRgawiA290eqB0pcSfkna1WgYhLE5XZqgYmw2XlQ5ze1IDIGmmY6kj9fpHx78wAYdOJr7tRlV+DyCYzN0LgVwY2FECYQMDN7pUYEm/fH3Bmas=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7390.namprd04.prod.outlook.com (2603:10b6:a03:293::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 07:24:50 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 07:24:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] blktrace: add blktrace zone management
 regression test
Thread-Topic: [PATCH blktests 1/2] blktrace: add blktrace zone management
 regression test
Thread-Index: AQHcR9WsWRFNG35YkkuaYXpuIHMN2rTXKDeA
Date: Tue, 28 Oct 2025 07:24:50 +0000
Message-ID: <4513674c-9d99-4356-9fb5-f39030cd6a92@wdc.com>
References: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7390:EE_
x-ms-office365-filtering-correlation-id: 8283d2fd-1e50-4f05-961a-08de15f314da
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnNOSFdmYUJKV1c3ZmtDMGs5VXI5RG4yTzZTMm9oYXZmMzU2M3prSkFhN3RD?=
 =?utf-8?B?NWU5SHd3SW42ekdCd0Nrc0wxU0RiYXgrcEk0RlphVytGcjgwSlZ4YmJhTklW?=
 =?utf-8?B?ZUpPRGxKRWtrWEJFZjFuWVNMalJNUUtrQW9UK1FsVUhKK3NjcjBmd3ZyU3Nq?=
 =?utf-8?B?VjFnVXZEOUxEZ3FoUUQ4WlBIcU5ydTVyS0c5SHFMeFFMRUc4MFdwRHBTcHhV?=
 =?utf-8?B?RXhVaE0yWDQ2ZDdrcXZMVDg5TnpVR1Nzb01IKzZNaG5pZ0lwTlJQeG9EQUNq?=
 =?utf-8?B?L2FWc0duUlE5c2dsRXMrWmM2a0syeEh5Z2hYTk4ycE5WK2RweUJTZ1orSmJ0?=
 =?utf-8?B?SUl1T0t6RC9ETEkrL250N3Jyd2llRktVY05iTHB3WHRPQWFwRXZ5SkZCS1RQ?=
 =?utf-8?B?S3o4Z2x0ZEt3enJRNXhxMGJxeHF3RHNlZUZseUFDalZMYjlncjIwZWRDdVpF?=
 =?utf-8?B?VGZxQkJMbE1vYU9nTGFrSi9Pb1RRZ2V5OWlTSmFVTmZZaHpROGtKdXhhZFhn?=
 =?utf-8?B?VTR0OU4vSjZCVFcydEhCNjg0eU5rRGxyNXgrUHRkY0hrTU9lbXc1VVpBRFlX?=
 =?utf-8?B?OHpJaThLSEdQc0tLRXdzK1JEd1VXdzA2a2o3Ri9SaWZYdFdaWHhmOXQ3cU50?=
 =?utf-8?B?T2lpWWpYR0s5VG5OK2ZrOVF6MlBPRmVjcHl4b1Eraml0WlJGVjZLNmEzSWpV?=
 =?utf-8?B?YTRrMFBuVVB6TXhIRVRkWW1aTkczTGtGNWszUDBCcnVpcDc5WGNhdkc2clZs?=
 =?utf-8?B?TXRESDhZYk90N1N4RklRMC82emdkblRkemtzbVJjZ3BmUUl3eFpTNmN0TjZ0?=
 =?utf-8?B?eVhsb2EvOG9FbU9iZndVenI4TVFHOVN0MWYyM1djTHdnTmtNMXdwa2RpSnZW?=
 =?utf-8?B?dE0wcUFhc0xVNldpVGtvWmdyb2s1TkZMOVFhUVkzVElrWTVIUno4ZmNJNDFO?=
 =?utf-8?B?d0cvanUwb2JUbmQ2OVdmZkVtYlo4NkJZK1Z1Z3ZkRTdua2pkSmpGUDJaSWtB?=
 =?utf-8?B?eEc5NE9CWmtQb1VJYVVrWUhHZVFZOHBVS2g0WWJVeklvcTlsWXFPQnVIUUVC?=
 =?utf-8?B?ZGdjTjY5cW9rdU9rTW5mN25aNUJjeVh5N1ZxNlNpY0V5b0JtVk11TzN2V2tK?=
 =?utf-8?B?b2dmL20veHc3aUVTck1JemFncjdaMENlZUhlcDR5LzFtRDdhT3h0c3RoRE45?=
 =?utf-8?B?Vjd4YjlEcDAyQmkwKzVIa0JyVUh1TWFSQm14OEJqbE9HMkJCVmo4M1ZQTlRN?=
 =?utf-8?B?bmU0VndlcWZLSTRtajFITFFZSVBaNzd0dTFwNkxaVzJlT0kxcGZGS1RXSHdx?=
 =?utf-8?B?UTQyOWpnNFh4QUpiVXVDaU9BMFNRVG81V3lFaDhtWDdld0dkVVN4U0NyOXd4?=
 =?utf-8?B?dTA2U0RxbW96V2ZMZENsclVpRjFiZXE0TjJtNVljbUxycittSGU1ZUdBNW03?=
 =?utf-8?B?ZlFVRE55OVprZCtRdUlGNVUwQUtQUXlKcnBoT1VFVy9YQ2NUdHlWUVdUV2Nk?=
 =?utf-8?B?dTM4M0NJQmlRRjA3K0thMCt2YlVMb3N4dEdsK1dWSXZRK0tVWW5oUkdpM1J3?=
 =?utf-8?B?VHpyejZON1FIRTFlTjRPMVB1cDRuOUlLWGRVTjIyU0NmbzdyemR2bWYvTy9x?=
 =?utf-8?B?LzlTdHQvVFhRbDJpeHVPVEJEVDZTc0RaQSsxVlBMaVcxSjRCS3FzYlg3SlF3?=
 =?utf-8?B?OXBJNEtSZ2xJMTF5Y0FVaEFRdGs4bWh2dm9Wc3BxWG5SYVk1RUozR3ZCbWF6?=
 =?utf-8?B?RkJxcXZ1ZXg3SC9iQ0JweEdGT09VN1FMVkxjQnZJM3gxNWxnRVV3S090aEly?=
 =?utf-8?B?NHZtNTcwVFZiZ0xZU0FYQzFWb0lJVVBZVnpPOUNONjZLZGx6UjhXdnl3WTRI?=
 =?utf-8?B?aU5rYVNHOEhkaFRBTnljM2ZkN2p0M1hoem1zeWFvZTR3bWpIUGFGSWFXay8v?=
 =?utf-8?B?MWJyMVNzblkzbkl2bExjZ2RWaU93SzY4RW5mM0NQQVc0ZENtKzFZcFUwOXZt?=
 =?utf-8?B?cVRYNTkreUZWWkUwa1I2RlBqYkJDSFdNNDhmalFoM1ZJRkpKKzZxMWhRQ1Uy?=
 =?utf-8?Q?cb491H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmZhclBGZHVBNW5xUkNGQkhnMG4vZlBSelp4bXo2NUZBVkUvV2NqbEZxdk10?=
 =?utf-8?B?dlpvaGQ2Vm93SEJMQ3VzQ3FmVjE3dFdEOUZPZDFueUxKSjRLNm94cXZvMnNE?=
 =?utf-8?B?V0ltUksybERLcVlWK2Y0OFhIZE94NG96Y2ZFSVNBL3kyL0hIWi9Oa3pnd2s2?=
 =?utf-8?B?VExQTHo4TDQyRU9IS3E4LzlSUWJnQS9UMStoRFN5WmJXeDBRSmgrY2k3T1ZI?=
 =?utf-8?B?WlFIV0VKNlhLT29nem43N0lzNWNnSkJJMmZQblVQZndvZHZEVWNpUlBUenJy?=
 =?utf-8?B?NmpiSHk2ZjhzTXVmeGlMdlFZM0c2VkZNUjhLOEdaUlhiRXdsSkJYSG04cXBo?=
 =?utf-8?B?eVM3VUxhL1VOazVJd0x0bTVoWnJRY0V2V3ZIYkZTdDYvR2h6L24zdmNlUFhG?=
 =?utf-8?B?eHMyY0tlYmN6RmNFaE5wWTdXR0w3cklVdm05UDEzanFIQ2NVbitmVjNmMXhX?=
 =?utf-8?B?MkNIazR4dG9KZFBMRndqRkdFcUVhU2RYYldFb0NZUXZXYnF3YlFKeFlDQUFZ?=
 =?utf-8?B?YUNrSGRuNm52bE5tRUdrdmtKRHlKaDA0VERScGFIRlR1OURHUlFvMG9MbHJP?=
 =?utf-8?B?ODVqazJDK01waG83ZG9EVW02NE1iOWVabVZITStNVzRBZUZUd0lCKzA0Mmgv?=
 =?utf-8?B?T3JVU0x1TWczQno1Vlo3VjJqK1VUdElLczRFNEpQQWxyaWUyUkxmZDN3bm9E?=
 =?utf-8?B?ZlFFckZOZ3VTaVJvQ2NlTm1abkNpMEdhcHhMR3phK1JWdnFaTU9xaGplMjBh?=
 =?utf-8?B?M2tuelh5MWNrVDdWNjk2WGJjT1RJYlhPN053QytRNTRMZHhmcGxCVGpPZmFp?=
 =?utf-8?B?aEZDR0UwWU03K2FpUlhic1J6eUtNUHIwWldUZXBEMTA4UFJSNXhXTldsR1pv?=
 =?utf-8?B?KzJWaHZIVUlaZDlEVzhONW0wN3dMNHhNaDdyQ1UyaVB3RGV3WE43NXhLSytB?=
 =?utf-8?B?WXdOV0N2NHF1MnBlWW45c2hZZ0ZhOXdITkwxdE9ZUVp3aTFoeGVxOG5VQjZG?=
 =?utf-8?B?Zkl6a3E3QjBFQUpUeW9ZWXgrdnZUVXJnODVIYmVyTTYvb01UamdDMnJDSnUv?=
 =?utf-8?B?UEp3K0FNdXJoWVZ5akNnRElMZGwzMGl0Y2JWZnNkcXh0S3FBQnVkclFFUUNG?=
 =?utf-8?B?UmU4c3NRRStmWmpPSnIyQ21oMUxpdEZMT1dOcTErMUQrUmVyOWdCdy9ja0hX?=
 =?utf-8?B?ekkycW8yM2J4WnUyRWRKOXA1NHdkLzlPN21zQ2xlNGRlU1lLVjl0QnlleVRG?=
 =?utf-8?B?WlhpNnB1VGQ3a2huRlV2MmJTZjZaYytiR0gyZXdZcHNzUWZUNFNOWnI0M014?=
 =?utf-8?B?R09GUVJKSWh1ZEVCNDRuMEJyN2djWU9lbktNUDFUdXpwOFU2cnR5a2c0UVpO?=
 =?utf-8?B?N2VzendBNzFpZUdFRmhXcnQ5TCtscmtkT1JwK1cwYlQrSUtJb1ZBc1FreUJx?=
 =?utf-8?B?RGJGazFoQmtMMWRkSGwva2FxWVJNZVhXTkZmUDNMWmhma2xaYVdiSVNKMDZC?=
 =?utf-8?B?YjdtV2wzd0NxTXlFQnFzcVpxQmVOREJSWWFXc2VFcnE2elFRaVBJTmhNUDUz?=
 =?utf-8?B?TnlUSDRRUVN4dUdMTlN0Q0JxQjlkN1lmaVpoZnhVVkJPeXBFTGNobE9OcDUz?=
 =?utf-8?B?YWZseWxsMVVQZFlIYit2MytJY0dURUU0Ky9xTThTN0JlcXFTRStoK21BUSsy?=
 =?utf-8?B?NytOOWk2SmtoaExXR0h2RThNUzRXUjU5bFZ6dHRlc05wNjdrY3doYmJrV0VS?=
 =?utf-8?B?L3ArdENUMldCd1ROWmJVeE5GdEZTRkpiRlF5QXkyQjJDY3plUTRDQkdRYzV4?=
 =?utf-8?B?OWE5czJnN2lXNU5uZzBkUC90cEZleWtpMnUwUFUrSmVrV09rOFl5Zk95UW55?=
 =?utf-8?B?OWdIZ1pwZnB6dmx0bEVZY1ZMS2ZnT0pJZUNmT1JLVW9PdjBMdzA2enFsSXRZ?=
 =?utf-8?B?Z0NhbGhiVFBpTGNvaHphZ3MzVktIamdYUHlrZG05OVJHTGFGMGlDK1dNbHU3?=
 =?utf-8?B?MkdtZTlHcWIyYW9YSVZkcGdCNytDL2k3Smw1cTl5YWlsT0tvUy9zT1dxSEs2?=
 =?utf-8?B?a001R3dSbVFselVsOVNHZE9tUWFGUW1taHBOREprVk5YL2JjYVZFWGNWLzFh?=
 =?utf-8?B?K0lDQmN3cXJNNlRxdDBUcnBVWGR0aFpQTXZ1MFpGbGRQTVdhMDVQWStoNjU1?=
 =?utf-8?B?TE0xYmZHdFdCckp2ZXFGTGI3STF6SmZXek83bUdGdlhTdGlkcTVqd2MyeHRy?=
 =?utf-8?B?WUtDL1FVbnBtNkpNR1RXMkZnUnp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4E9B4BB4785594C919D86E0C2A409C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3u/dq3TCwa5S4KTDPomLCsTGLobEuBvqiJezkdB7T+B8DUQxtVVxvP1diZ/YWVAkS+WZQYrVcZpi9lFDSzHmNbRfwWDzUSRelm5HK+mMAGXgTUwW3UJf7mghGiFMqkNkPsaXJKWVvL4jgxnZF6k0HCkgfI2OkL6ztvDDf/D2Pq/DgDtmjW9AdiMfA1wIg0x4Hnpt8bS8Y0twMV0L2GqAGhheK8b7m6jBZj5oM5KQzd89sj+vBIzSkXVa5xbgX08kAVemysPB5sXLQqXl9mitGJTvlCwEIt4D20FBQk8d4HrEoA7p3cEFEM221OKGR8WeT9QZcescvag1AuZE+/PvPeWoVnC1Wc4pHo0XkV5kpfaqVEI81D3qbHbcQmxwav+lZo3XzXaoug1oAFSRK/f+pXmj9vNkb+1s9V0Q+Qnd6bzXv7POozy+615+rWAHlKH+lJD2t1bH1LIKq1HEo7kxOk70eFhsiZoMaPKuVq7nNBASPhlrLyf7VsOplhRhS3CRRSv1IBoZrDFn/TixaJHMlP4LZ1+A/J9SlQl7Y0jJGdYxXlugyrCvku2Ei97ggC23+I95m5Ui5KdDNn6Ca/BoWCgBFe+1HzLN6lj9lGZUnZBH872eRoqHk6Dcs2ke9x3o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283d2fd-1e50-4f05-961a-08de15f314da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:24:50.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oQcjWwFW/P7RE8oThxH5MIfsO6XPqRMvzPqge4OuHYYfCe3OHRSZjvuGCoqIAItvcWy4wAVKQzWuwhHQOd4eDTSqhMTnZhcB2S2uqQYSLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7390

T24gMTAvMjgvMjUgNzozOSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiArCSMgQ2xl
YXIgZG1lc2cgdG8gaXNvbGF0ZSB0ZXN0IG91dHB1dA0KPiArCWRtZXNnIC1DIDI+L2Rldi9udWxs
IHx8IHRydWUNCg0KRG9lc24ndCBibGt0ZXN0cyBoYXZlIHNvbWV0aGluZyBsaWtlIGZzdGVzdHMn
IF9jaGVja19kbWVzZygpPyBDbGVhcmluZyANCnRoZSBkbWVzZyBidWZmZXIgZnJvbSBvdGhlciB0
ZXN0cyBkb2Vzbid0IHNvdW5kIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUuDQoNCg==
