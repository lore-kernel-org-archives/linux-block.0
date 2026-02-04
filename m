Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F69274B44;
	Wed,  4 Feb 2026 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172137; cv=fail; b=HZzZhmmEeSC7yjuvFm2ZguWlJdXT1hbDRG00N6fUEELk1vVx17s/Y7MLkFSDqZ8ccj2eWeZxt2J0r9bJ+ubIEXI2ebBaLcv9qjMljBzn2Rd0OqsYH+y86x/f8J4wkMxHWS2yMH8r7/Ct+qXBjGnu2LzS/wbUZMFShBTptJpYYRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172137; c=relaxed/simple;
	bh=+CVQWOZJPC1fBofvzc5O867a5NccH0FmgDWsZSN4d0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Po1q9LE/J5PXvJcUbnIQj/J2giA3tpCO57JSqbwFhmq930AxEdt5lheRQWp92YRPCFoeN0R5xC44jI19UVg6YZuoprjzy445f57ihLPhEcOGRtHnddDuG01FZ5gvuiN2FwHV+tV4Ge+M2nyfKD/HtOj4j4F8KbQf6SjDzy03/3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f774cLR5; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f774cLR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8+aXW5i9fRyrKCYCANoQtGQA/K17Npjce7Pp/EwnicCUMZ7eduThtp1ezBROwr5GEfhOI+w0RMVKJ7gHZD27tyJEAoM7Y67oMoy8bfDdPOf0AkprbWOKgri9ALhZEIUu+oov4Eu3Vrw7rmV0MPmRl44YYQ0HGM4D/l3s9hGjY/aG1LOQk5vf21jrj0ixdy9ylIj2dZoRUMSeA5ccn74SlVsRao3G4EZtyMUlSM9LjTT+yDFtxrXDORB6Q/z0kBRcGdgPyy2q1iafnCDp1eH0i0Urv9v0YcDiMa6lmqn2tFM27QyQkhmYMb2jHAZFGbt1/RMXGwSVW+pVkZ0lnC6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CVQWOZJPC1fBofvzc5O867a5NccH0FmgDWsZSN4d0Q=;
 b=rLwn8WUekWeEp0+TvoEGbOFqm2QJOtEJU8929bouIyLcr97e3N2NldCBmAQHgcKgsJPkhj/0js622GBAL8m0Aq5kTh6MyPWrRyP3srq/9uroK+DJOES3apD8fKM63yF5WaoIJ62vbJTA9pRZrHfzbyw6xmuh0l8IRFF/46uMMUgwCanlUEH0Uch2HXoO7e7b6sOWg1IMvl7kL4rrcAUiaQZRcDJUOhJ0HfXNmOtYHmaLWeYyfkooJKMJyuokw3huF48uxhqGEeFOEorjUfZyhnb6GcTjByiJpIg3hjwiKfmCcVKkol3X28rEScypXnhvgircBLkKAFFFKE01KkOsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CVQWOZJPC1fBofvzc5O867a5NccH0FmgDWsZSN4d0Q=;
 b=f774cLR5QPtan/vxoovyn2UCajdXsCazpNlnul7qx1wnE33u5fEwYGncutyRrqTwrRE3oKq1Q9wHp5Eine0mK0369WOXqdxLfkwIlnjrpvPpaWeRiKhBHhNw+kcpTmILhweodw7h5HqJh7GBEszw+HfkZk+JuZR7gDof0MuQoUgGYIk8R9qN0N7DY8ypyRx4A8qDANKf1V1RxW0skfXUnaF2Dlv7H00Qk5kpDoTUlI/AKB22Stiefu8V2U5KTzYzerRMyQGqtOjmWx3S6MhO0P2kQCZ1XK50BmGj9jkt3GtUHQ/fcFkDDoaVY6WHZ7bdnT2EnIioL82wEEQd0insqQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DBBPR04MB7706.eurprd04.prod.outlook.com (2603:10a6:10:208::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 02:28:53 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9542.008; Wed, 4 Feb 2026
 02:28:53 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@infradead.org"
	<hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 1/2] block: decouple secure erase size limit
 from discard size limit
Thread-Topic: [EXT] Re: [PATCH v3 1/2] block: decouple secure erase size limit
 from discard size limit
Thread-Index: AQHclPehFfbFtMSup027tNF+gQ7WvLVw3f6AgADy/2A=
Date: Wed, 4 Feb 2026 02:28:52 +0000
Message-ID:
 <DU2PR04MB85671D007A045527195EC5F9ED98A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20260203102903.2953660-1-ziniu.wang_1@nxp.com>
 <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
 <CAPDyKFpu6BEqJCg+=E3VDH1DutEy0C-bobtvEXucRBd6JvRbVg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpu6BEqJCg+=E3VDH1DutEy0C-bobtvEXucRBd6JvRbVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|DBBPR04MB7706:EE_
x-ms-office365-filtering-correlation-id: 0e562be1-5225-4c14-d547-08de63952390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q25IeDZpMUFPWXo2WTMwLzM5Q01OdVUyY0R2cU1RdWZWUjlRbmNWalZYMTkv?=
 =?utf-8?B?S3lKcFB6NlJ4RmtNVnVEd3J4enhhS0N4bmhEOEZLeEs4Vk1FT2d1YWxDczF3?=
 =?utf-8?B?ekxWYlFuMWtWd2pLU0RKWUFmdEs0cmk0dk9aU0w1SzloREVQK3FpK1kvSXlw?=
 =?utf-8?B?ajk0TlVVcVVrWEk2TEdwL000ZExINnhGODZSc1VRQm9vMmpBaHdsMlZjeU1v?=
 =?utf-8?B?YVExbTFQeTVZdDIwZlJpUlpVRXJINExTVjlzQjc4ZUs5aTVUUXNNOTdsZEcv?=
 =?utf-8?B?TW5BOU4xMy9WUmplWXlxNWtmWEV3MjFGTXd2N21ZclNQcXBFM2piYldkVUtS?=
 =?utf-8?B?NXpKZWQycWhlSmtmYWRrSjdnRnFGc1pRWk5PdFRYamZjRTdYSzEyMllVeEs1?=
 =?utf-8?B?MXlzeFpsRUc3NzhGTDJWWnd0K1hlSjROci9abG5rVE14UGs2djJwY0tON09q?=
 =?utf-8?B?ZXhSNVArcEM2WWRoVGZkT2VjY0VjNWY5c2c5bnVlWDR2cStibzdJa2xpZjBM?=
 =?utf-8?B?Mi9OU0JBUzQ2eU5ZS09FTEg2UWdtYy9VclVMMlVZNW1RcHlYajBZMFhVTmJ1?=
 =?utf-8?B?RW05Ly9SNHFMV05CVVhJMUZINUdkMzZGY3MzWXBYbiswMFFNUXplQTdCSnpS?=
 =?utf-8?B?YUp1d0ZRK0FuVTYvVHMzVGlPdmNSdW03dzgxa1E2RENROHlrN0pSRlZrSnRT?=
 =?utf-8?B?QUQvNTlTOFdENUcwYWMrMFlpYytDR0xnZFM3Ulo5bTlDODhPS0c2VDlhamtu?=
 =?utf-8?B?RDJMNUphdzBhOFBFTENSMDlwVjBBZFZTRWFHN3dtVm9WdTVZRW1JZ2hydHlO?=
 =?utf-8?B?UWV2OGNOQm1LaXRtR0hxbHF0NE53aUwxOFNPTlFuVGc2N083NlQrRzBhMjBj?=
 =?utf-8?B?Mmg2TGdsWGJhb3ZuWkk0cWZOWFNtODhsK21VVFd3SGNsNVMvTzVlT1dVdXNN?=
 =?utf-8?B?akFYTWYwY3hhaXNFL0lvUk9taTRVbERacXJRQXdqZ1hQajhQYW5LdkM5RXpy?=
 =?utf-8?B?VDJRaFBPbEFIU0tmNnBGOUdveC96VFBCdkhyR3BPaWUvRnFSL2UzWWgyNUln?=
 =?utf-8?B?SWVPLzhqcEJtV0ZHd2MzeVJMNUV2bGRPTTduN1pQaXJ5VEEyZG1QNnlDMWRF?=
 =?utf-8?B?dDc3a2o4VG1ITjViVW1yaXAxc3R2Q24weDhjM2hkU2lSTkQrNlNvVG00KzFq?=
 =?utf-8?B?ZkJqcUs1RzU3VWY2WEJZRjMrQmpaRGxZZ0EyQ3hHaFc5TWtMNEZGNEk4SVFV?=
 =?utf-8?B?VFk0UlUvTXY2YnVpa2Judk9LYml6WUsyUUhvSDVuQmpWVXBZWmVTa3pHYWx3?=
 =?utf-8?B?WndIU0w5UEVJUGhsRkxrRnlpdjgrbmhvZUFBMnAxRkROMDh4aTdGV0NUUjBw?=
 =?utf-8?B?VXp4V01RTjkvRXd1T05IVVJ0cEFydWJoeW9FRUtsUWFxc2JhSmZkL3FERS9S?=
 =?utf-8?B?QzhCZndiWGV0L3MvakJ2dWppejlReVRONm1DWHMxdG5TRklSN0RsdDM0cmJ2?=
 =?utf-8?B?S2RQcVFodGJZZnFWRWw0OVZ2MXJRYkUwRGs3QXE0QkI2OHF5ZGdpbXlYWTZ2?=
 =?utf-8?B?VkF6ZExHNGVGeGV4VjVyWkZacDJGejRVbVhSK005N3Q5Yy9KU25LN1FGejRm?=
 =?utf-8?B?RklaRjBFbkFBQTQrT0Fjb3pSNGNrMDFiYVNPUUNiaitjNEhvVlF3RUg2Zm9R?=
 =?utf-8?B?QjEyN1N0Ly9FVmVPN0pma01pRWNSM01FdHhHVE5UOVpHb1U3aGRIcTl4d3ZQ?=
 =?utf-8?B?L2RkU210cHBCT2hsZnIvamloWi9iQkZhWmFxRjljNjAzckwyRkpvaCtkWEc4?=
 =?utf-8?B?ckZzdmtjL05MQkgwU0I3Y05mWlBlRUFVYVIrd242Wmgwd0lyY2o4VzdzSS85?=
 =?utf-8?B?czZlMXAyL3FTa3J6aWVFdTJhMmJyRkd2ZDVSSzUxOXo2R0o5a3VjUHdFeWVV?=
 =?utf-8?B?MnJvK2Z6K1NSWTMzZTZKQkZIb2FiNkRxNElkakxtK1VEWTFLbGVncUhlTWhy?=
 =?utf-8?B?ajVwQ283RXZWRzhUYXVCZzlmaFlSR1RMUWp2WkZkRXF3cCtqbXMzdk5LNm9C?=
 =?utf-8?B?TE9JVzE3Z2JBQVdlK0MySXgwWk9RNHlHaU1qbjNLRytQYUFkMkFqVXV6bURV?=
 =?utf-8?B?c0dyZ3FSYU5EdjB5ODMvYVpMWEZ1eHpHMXBSKzZDVW40TEJHQmc0dFpWQWxI?=
 =?utf-8?Q?kcflus/hQSd+IyipfitjXqA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDBoTmZUYW1xMXhMUmdPY2k2Wk5ianRZN2QrWk5zM1dNSkw2TFJLd0w2VUhp?=
 =?utf-8?B?ZFlvbXlzOVArVzYzUUw3b3dHd0lJdDNxM1VwMmRZYVI0cUkrNGdBT21tSHhW?=
 =?utf-8?B?Yno1R1VWb1hHcythaWkrM0dyVVJNZkdxdE9oVlJldFkwRHVldEU2QTlieTJz?=
 =?utf-8?B?OEsrS0gxTUo4Q0dFSTNXcmVPdFJzaDdPcm9PcDBEY0ZHc0hHbllXV3lGVDRO?=
 =?utf-8?B?U3BCWFBTa1JLYmxkZHhOeGYycTNpUzF2cFpLK1U3NnllTXVCN1BZeTRHNHNj?=
 =?utf-8?B?Y2lCNFdPcHJKQlQvZHV3eERQWDF6U1hHRGlMaGF6QzMwVUR1cStJR2VTN2Yr?=
 =?utf-8?B?Mk96cGlmbStDNmxXUUlwZnJUVXRSdjNOOWNiZ3pDVzRZMjVtQXQ2dmluS1lJ?=
 =?utf-8?B?ZjJEdkFCTnhQS3ZDU3NaRWZvandORTFIclNoWVErNWg4Q0lFYjhjN3VMME1D?=
 =?utf-8?B?VHoxRnJDTExqRi9lNkVjU240TTNkRVhtNW8vWnBveW9rS3RyTWFEMzFvSkM5?=
 =?utf-8?B?Ylh2b1lHR1pOVExUY3lKVURiVktYZDgvdXlWN1pBazhubEdrWjIzN3phN1Y2?=
 =?utf-8?B?djQ0WGkxb1pCaXZNVmFSOVl0V2lCdUVqWHgwMVVJNERCN3J1b2tCVzl5OEVp?=
 =?utf-8?B?c2tLRk50eVQ1dDlYSlBsK1FMUHdoQjlCTmdjWi8raDRRZm9WQ3hWM1h5WHVr?=
 =?utf-8?B?b054dmM2T2ZUOEs5bXpWVTYrb0ZoMDBWQXlzTjZ4eGh6Z01lRlA2c2xiZHcx?=
 =?utf-8?B?T045QUN3OGUwc2ZQbmRWTFRod3UzSGVPdXVENFJ5bCtBWU5DM3htOEhoWktL?=
 =?utf-8?B?a1p0em9jV05sQ2RMTnd4a1NUSG81NldBejYwY0F1QWJJeWZXbVNodjU5amFs?=
 =?utf-8?B?TkpWMlhxcHBRM2RKRXc5NzROWHNYbE9MM3B3QkpVVlR5TEN1N1dDbGtYWUsr?=
 =?utf-8?B?bW5rY1NYakErN2Ira01WYWpvSFlScVkwRjgzQndNQi9rUXpteis1eGRQNFNp?=
 =?utf-8?B?L242akw3clZVZlo1SWMyaWN5OXhBRFVIZ1ViQUZaSnMzTGVQbVB1NnJmck5R?=
 =?utf-8?B?OC9WR0dHNVZaN3hENmlZeHZadUVTamMwcEpXOGpodjc3VEFpRmlkZzBjQTkv?=
 =?utf-8?B?L3hCVkJWclZyd2x2aERuQWhvTXpQdGJLSzZkK1NnSmFtUGQ5QVBSZXNaRHVj?=
 =?utf-8?B?cyt5RWt2ckpBcUlqK25xRk95QTNoTHJBeUIwVzVoUlpNZzIxVDl1dDhGcENo?=
 =?utf-8?B?R0twRllhZHFUc1BVVjl5UTZZdnY3TitvSng4aWR6M0pOQlUwT1kvS0N4eTBF?=
 =?utf-8?B?SDVnWTJTcEo5T3QvRVBxWCtmQ0FzbndiTEsyeTBSZ0NxZmVVREc1VGVxQXpx?=
 =?utf-8?B?VUFHWHhyMFNjcytodDlJYUJ3SHR3TFpQamQ3eC9rOUhTR1hkSnAxNW9JaWpV?=
 =?utf-8?B?aFRsaG1BQkEzZjN5b0w3WDRWb2k1aGZ3NHR6a2NYNGs2RDZ6TmVyZlV6Zyt3?=
 =?utf-8?B?M0R3T05ueVhwc2ZMTWVrRVhaaElNaGIwejNtR095czFpTHIwa0hEbGVPZVhi?=
 =?utf-8?B?eVdJSG04R0RxZjFsQzg2ZmcyNUxqVE9sbGs5MWlhWVN0ZFRJdmwrc3NweFRk?=
 =?utf-8?B?M1hWV1A5VG5Qems3bVJndnhBWFIrQVdNaXdTVERKUWQxN1o3eHBoZ1pPU2Rz?=
 =?utf-8?B?K285VEZBUXlPZ0w0ZkYzTkc5ZmVpMUcySGhNNFlwaEF3WWJTdXpJY25EUU1E?=
 =?utf-8?B?TDdjaXdVYmtKWFZpMVdMd2F5eDEvK1g2akxLTXFZZWRRT05tSlZGTi9rcTMx?=
 =?utf-8?B?NHMzRnlUbVR4aEg4UFVZS1Rtb0NlNmlVaGZZdVhvaTNjanBTUUxuNXM5blZz?=
 =?utf-8?B?clhKcTNWTWdvS3htUW9seTNxUEo1WkFCdG0vY09lbCs1cFkzeDFrMDRVYzFw?=
 =?utf-8?B?OC9xeUd5d0pSYUlBMThKdFpJMi90R0Q2WVFUQm1FTVl3TDEwUk1kRms2eHBR?=
 =?utf-8?B?RUZWcm53eEFIUHlJak9UNXFNbWlPc3FxaHpQeitPaVp5aTNJS2dXUWlKYlZy?=
 =?utf-8?B?bnJQWm02dzRWU1ZCbGlzdkRQVVlvZ0U5SVlrSTRxblVoblI2NWoxMXZxUTBV?=
 =?utf-8?B?b2tJSUpGZWVyaTYvS0JWeWJpOUpDQk11MmFUL05qMGhlZnB2SDlQTCtlWTFq?=
 =?utf-8?B?NUtLWC83QUtCY2U2V0tvNm96MWI0cVBleS9NQTgvUjZkcmw3dUJ3RUZiVWVn?=
 =?utf-8?B?QVRGd09yRTFzOUptOGdkK3B2V2tjYmxQYXI4Mm1yVjd1TDMvbXAvYklNb25M?=
 =?utf-8?Q?Bhx7FXwUHSwZovGKgg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e562be1-5225-4c14-d547-08de63952390
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 02:28:53.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRLjmkOCnNVtmVFs0njk0y6h8GZE+khHh3NKqHRxB19dW1TBV4quSViiagTiuYxOvWatTX/weVpCfRgMdPCzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7706

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDMsIDIwMjYg
Nzo1NSBQTQ0KPiBUbzogTHVrZSBXYW5nIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4NCj4gQ2M6IGF4
Ym9lQGtlcm5lbC5kazsgaGNoQGluZnJhZGVhZC5vcmc7IGxpbnV4LWJsb2NrQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IG1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SCB2MyAxLzJdIGJsb2NrOiBkZWNvdXBsZSBzZWN1cmUgZXJhc2Ugc2l6ZSBsaW1pdCBmcm9tDQo+
IGRpc2NhcmQgc2l6ZSBsaW1pdA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcg
YXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUg
J1JlcG9ydCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiBUdWUsIDMgRmViIDIw
MjYgYXQgMTE6MjcsIDx6aW5pdS53YW5nXzFAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBMdWtlIFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiA+DQo+ID4gU2VjdXJlIGVyYXNl
IHNob3VsZCB1c2UgbWF4X3NlY3VyZV9lcmFzZV9zZWN0b3JzIGluc3RlYWQgb2YgYmVpbmcgbGlt
aXRlZA0KPiA+IGJ5IG1heF9kaXNjYXJkX3NlY3RvcnMuIFNlcGFyYXRlIHRoZSBoYW5kbGluZyBv
ZiBSRVFfT1BfU0VDVVJFX0VSQVNFDQo+IGZyb20NCj4gPiBSRVFfT1BfRElTQ0FSRCB0byBhbGxv
dyBlYWNoIG9wZXJhdGlvbiB0byB1c2UgaXRzIG93biBzaXplIGxpbWl0Lg0KPiANCj4gSSBkb24n
dCBrbm93IHRoaXMgY29kZSB3ZWxsIGVub3VnaCwgYnV0IGlzIHRoaXMgY2hhbmdlIHJlYWxseSBz
dWZmaWNpZW50Pw0KPiANCj4gRG9uJ3Qgd2UgbmVlZCB0byBhZGp1c3QgYmxrX3F1ZXVlX2dldF9t
YXhfc2VjdG9ycygpIGFzIHdlbGw/DQoNCk9oLCBJIGZvY3VzIG9uIHRoZSBoZWxwZXIgZnVuY3Rp
b24gYW5kIGZvcmdldCB0byBhZGp1c3QgYmxrX3F1ZXVlX2dldF9tYXhfc2VjdG9ycygpDQpJIHdp
bGwgYWRkIHRoaXMgY2hhbmdlIGJhY2suDQoNClRoYW5rcw0KTHVrZQ0KDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2UgV2FuZyA8emlu
aXUud2FuZ18xQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGJsb2NrL2Jsay1tZXJnZS5jIHwgMjEg
KysrKysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tZXJn
ZS5jIGIvYmxvY2svYmxrLW1lcmdlLmMNCj4gPiBpbmRleCAwZWIwYWVmOTcxOTcuLmZjZjA5MzI1
YjIyZSAxMDA2NDQNCj4gPiAtLS0gYS9ibG9jay9ibGstbWVyZ2UuYw0KPiA+ICsrKyBiL2Jsb2Nr
L2Jsay1tZXJnZS5jDQo+ID4gQEAgLTE1OCw4ICsxNTgsOSBAQCBzdGF0aWMgc3RydWN0IGJpbyAq
YmlvX3N1Ym1pdF9zcGxpdChzdHJ1Y3QgYmlvICpiaW8sIGludA0KPiBzcGxpdF9zZWN0b3JzKQ0K
PiA+ICAgICAgICAgcmV0dXJuIGJpbzsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0cnVjdCBiaW8gKmJp
b19zcGxpdF9kaXNjYXJkKHN0cnVjdCBiaW8gKmJpbywgY29uc3Qgc3RydWN0IHF1ZXVlX2xpbWl0
cyAqbGltLA0KPiA+IC0gICAgICAgICAgICAgICB1bnNpZ25lZCAqbnNlZ3MpDQo+ID4gK3N0YXRp
YyBzdHJ1Y3QgYmlvICpfX2Jpb19zcGxpdF9kaXNjYXJkKHN0cnVjdCBiaW8gKmJpbywNCj4gPiAr
ICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLCB1bnNpZ25lZCAq
bnNlZ3MsDQo+ID4gKyAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBtYXhfc2VjdG9ycykNCj4g
PiAgew0KPiA+ICAgICAgICAgdW5zaWduZWQgaW50IG1heF9kaXNjYXJkX3NlY3RvcnMsIGdyYW51
bGFyaXR5Ow0KPiA+ICAgICAgICAgc2VjdG9yX3QgdG1wOw0KPiA+IEBAIC0xNjksOCArMTcwLDcg
QEAgc3RydWN0IGJpbyAqYmlvX3NwbGl0X2Rpc2NhcmQoc3RydWN0IGJpbyAqYmlvLCBjb25zdA0K
PiBzdHJ1Y3QgcXVldWVfbGltaXRzICpsaW0sDQo+ID4NCj4gPiAgICAgICAgIGdyYW51bGFyaXR5
ID0gbWF4KGxpbS0+ZGlzY2FyZF9ncmFudWxhcml0eSA+PiA5LCAxVSk7DQo+ID4NCj4gPiAtICAg
ICAgIG1heF9kaXNjYXJkX3NlY3RvcnMgPQ0KPiA+IC0gICAgICAgICAgICAgICBtaW4obGltLT5t
YXhfZGlzY2FyZF9zZWN0b3JzLCBiaW9fYWxsb3dlZF9tYXhfc2VjdG9ycyhsaW0pKTsNCj4gPiAr
ICAgICAgIG1heF9kaXNjYXJkX3NlY3RvcnMgPSBtaW4obWF4X3NlY3RvcnMsDQo+IGJpb19hbGxv
d2VkX21heF9zZWN0b3JzKGxpbSkpOw0KPiA+ICAgICAgICAgbWF4X2Rpc2NhcmRfc2VjdG9ycyAt
PSBtYXhfZGlzY2FyZF9zZWN0b3JzICUgZ3JhbnVsYXJpdHk7DQo+ID4gICAgICAgICBpZiAodW5s
aWtlbHkoIW1heF9kaXNjYXJkX3NlY3RvcnMpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
YmlvOw0KPiA+IEBAIC0xOTQsNiArMTk0LDE5IEBAIHN0cnVjdCBiaW8gKmJpb19zcGxpdF9kaXNj
YXJkKHN0cnVjdCBiaW8gKmJpbywgY29uc3QNCj4gc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLA0K
PiA+ICAgICAgICAgcmV0dXJuIGJpb19zdWJtaXRfc3BsaXQoYmlvLCBzcGxpdF9zZWN0b3JzKTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gK3N0cnVjdCBiaW8gKmJpb19zcGxpdF9kaXNjYXJkKHN0cnVjdCBi
aW8gKmJpbywgY29uc3Qgc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLA0KPiA+ICsgICAgICAgICAg
ICAgICB1bnNpZ25lZCAqbnNlZ3MpDQo+ID4gK3sNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBt
YXhfc2VjdG9yczsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoYmlvX29wKGJpbykgPT0gUkVRX09Q
X1NFQ1VSRV9FUkFTRSkNCj4gPiArICAgICAgICAgICAgICAgbWF4X3NlY3RvcnMgPSBsaW0tPm1h
eF9zZWN1cmVfZXJhc2Vfc2VjdG9yczsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAg
ICAgICAgbWF4X3NlY3RvcnMgPSBsaW0tPm1heF9kaXNjYXJkX3NlY3RvcnM7DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIF9fYmlvX3NwbGl0X2Rpc2NhcmQoYmlvLCBsaW0sIG5zZWdzLCBtYXhf
c2VjdG9ycyk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50
IGJsa19ib3VuZGFyeV9zZWN0b3JzKGNvbnN0IHN0cnVjdCBxdWV1ZV9saW1pdHMNCj4gKmxpbSwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
IGlzX2F0b21pYykNCj4gPiAgew0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
