Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FB47A6B;
	Tue, 28 Oct 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635886; cv=fail; b=gIf2ZWLvtchEcwyvAZbf1Yli6pO9afN2mT64N2pXhuQw0ttTtdP+7XxRrHqOc74mietFdd7v03wqxfkBPihNwahSvmNWrIYPUKwEDMBnTLpzguBkqaZVB5oVL91pWvbbt2AfLB/nL6QQgsw8tbizXg6HLNuINDL4d4Ep3NdRZEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635886; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hteqtPILNEIrN2sUdolwX6kyjZtisA3HSuDFx2sN8eGc9gndOCDZrPQpn3oldM4F1fglMuYWozBTih5rRNm9fR/9Fa+/yLoiLVuCc/RbORLUBeJq561o+99qk8gxqQoIISr46QAkuA9dSmt0wSOd4vxzhCVUjjpq97SsvkVDcmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lIYfV89G; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Jv7Apkft; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lIYfV89G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jv7Apkft"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761635884; x=1793171884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=lIYfV89GZk+TCAPaFf35CrqLe/LqSnQawjQv+ETttyBkE1onD0zWLvFw
   w9eEs1FY/TiJJOBboOgOBSz83Psuvr8X3n93d52Yq8qV9BhssvmZFBlFU
   lpyb4QfyvcYR/vqfmGGN6ptyP3wdksZ3O4m0pHW928LrHwg9LOLjOk8vw
   ewZGRitAZH7NuWe8MRy42/clecJGgiueMJONnbX6req40O30WJSRIb75j
   8fzb/4CUoeEkqvulgGD3Wmsp/5+7GLGY17vBkoRLYisKpIwKA6uN+zGoF
   u+fT0Q/bFlXRBA1AbdpNA8PwCqrBl96e9pZDjrJnns5bCB0x00jvrzWPs
   g==;
X-CSE-ConnectionGUID: U/OFUDE5SVu7HDzP8dBH/A==
X-CSE-MsgGUID: b8Z442XYTDOEgP14GHYgnQ==
X-IronPort-AV: E=Sophos;i="6.19,260,1754928000"; 
   d="scan'208";a="133682645"
Received: from mail-northcentralusazon11010012.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.12])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 15:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtWRX9ACbePpcAicA/NonEu6F/uPltzncfEFlUArWzMLKxyW1i2ikgVsfI8joGXCIquc5b1NvyC0HC2faBfAfKkvIIS9cavZoJDo0IrrQY4C+hxLjRDH2L6CEo8YjXJQAiafPTHdmsu+f2q3mAA5c+39x47b6UFv4wYiov64KWiLI4b2WJckDsX0gCxoadIrmopGOy2L6EAUsemm7tRLd+SVOvDNIsiqmzXxQOSDcW94b4lH8Fa+oT53Q1iIzmNr5JXauHe/QchZ6sl36+3XHGln7yl0g+vHpdL9SUE6e5gEMtBLDMhSuUkXqUkFSOkAo91F2SPXtKKEERwAW3ZXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=NWc8fQdAhAs2gsUfF58fL2sDUOCYS7D3PybBkDgikTvcjZyg9L8D0CYgdp49n1b6zRpAjbLm6LHtsLv00LJOnasm2L2Qf5v1sWvqxHIhs23S4uIJC71rwBuooDAxl6/1vpqUupYxargFQIYGjUGparx2CA09PkR1vW32ut8bkEF07hLOFUzCE1P6nwxq97E7NDDpE+m3FFqR6Q25aVJvsNCMqJhmbwCzBFZxNP52+31ON4KPR5oXfZdFNJ8MwfVZMJlDu+uQ+DY4rR65t7509iJk1nkseagsKxuyK4Iw7MqRErxPkXJPfqIwG4r9Ul3itcvgBvZCl0QREdOM9qgJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Jv7Apkft6kO6MXdD6xp07gGO9EYRFfxOCLqb5aG5/hwr8qIU8oifAbbyibNoDrgSEfB9Hv70BCgzVtVE4VVWPI5fw4qaAMAZJH3VnRh+LEhrDd93GWb/gasmq5aWlByEydtL3AO+B3aAGs/UG80WJ9cwQLyly2LMuCwPFHNFe1g=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BN8PR04MB6324.namprd04.prod.outlook.com (2603:10b6:408:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 07:17:56 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 07:17:55 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com"
	<syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>
Subject: Re: [PATCH] blktrace: use debug print to report dropped events
Thread-Topic: [PATCH] blktrace: use debug print to report dropped events
Thread-Index: AQHcR7UPF2h5XIBeYUqkEuhMeX+hcrTXJouA
Date: Tue, 28 Oct 2025 07:17:55 +0000
Message-ID: <b7ce769d-3cc0-4c92-9446-20277de3e432@wdc.com>
References: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BN8PR04MB6324:EE_
x-ms-office365-filtering-correlation-id: cfbe838e-93c6-47d8-31b5-08de15f21dc4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmhEVlZJTm1LNjZaMElzN0JVMTFDVm5QamNoSFY0Y3lPQXZWOFdIMTZxWEor?=
 =?utf-8?B?YTdDYXNTZ0ZHZ0FLQzVKU3FDbWtNRXA3R21qODJLWVZ1N1ZvekFBTXBIYlpk?=
 =?utf-8?B?c0JkYUVmNzkwaXZ1K2dEb08waW1SUzVMZ2swVENPRStzc0x1amJjaXFFU3kv?=
 =?utf-8?B?OXFaRVh5bGRmbDZJRDZ1TTJFbm1iR2FOV0VoakYxUkV6bHVNVEpZMDV4c1dU?=
 =?utf-8?B?aEh0R0FnaXpUQ3FPYzFoWktmN1VMUGkwKzlLMGhuY0tKd01OUnB3UTIwUVNn?=
 =?utf-8?B?bUNRTk9zR0o1OEJqYklZbFJIV1J4M2hqM292V1JXMlNXbWdpbDR3cDFNU2dC?=
 =?utf-8?B?bDBaMzRjU2tFRkdnTUJ3ZzVtZ2xEOTBvT0ZaRzJ5MUoxd3ltakFPL2U0bzNZ?=
 =?utf-8?B?ZldJeXU3VkNYcXBCK3d6SS8yeUllQmVUWXUrYWtMOTVrUnZDSmtzN2xLaG91?=
 =?utf-8?B?REZtS3JoTmZreWZhVkZvZmV0SnUrc1paazlscENJbU9KU0wzekhaand6VUVI?=
 =?utf-8?B?d3VwTDBwT1Y2UEc0dFV1VFdVVS9VSUYrYVZmODJ3NENNMkRNNHFZVldydG11?=
 =?utf-8?B?WWlOcjdGb1U5a1lCTkZZcHZHNWhkUTZWMTZrU2pXOXZCa0diSTAycEJuaVBV?=
 =?utf-8?B?OGxrWnl3cjRmWk1MY1g5WjJiYWxLS1VwMm5KbFk4QXBnWVlDa3JTNWlVRjVu?=
 =?utf-8?B?bzVReFNYNUtsaVc2TXcyN3E5VlJMSDIrUEZPSlhhTlNYREdQcHpDeXpRNFN0?=
 =?utf-8?B?cU9QS3JxNll5dGtGQUFaTmZ0MlZDa1Q1UHFaR1A3L1RycEFBZHlaUnIyTHdZ?=
 =?utf-8?B?WWJ3Z0thaTgrKzg4SEhUS2kvNVhuY29BZWhhaDIrL3pvYmpmd1pzQzBOMWhF?=
 =?utf-8?B?TVhhT0ZaUWM3SDVjdFp6TkhuWmsvck5EZmZRY0VqSGJhMnVERjZ4eVdLNFRq?=
 =?utf-8?B?dzRJWk84dUV3d1VxangrSG5rMXdvKzVkM093RUtaRVplYkJxYXNpeEQ2TTJr?=
 =?utf-8?B?Y1I0SWFMMXFaSkVJRkFaZENmTTB5MG5JZXhsbXBrcFkzcUt6ejZwMVhJR2dP?=
 =?utf-8?B?bVNXOXZFNGpLWTdXK0t3MXRUSmdocUdGMW1HRkxGazdFV2xPSzNJMTE1TkJ0?=
 =?utf-8?B?NkFsUDloaWlnTW9GMjBvMWl6VWJJcTNtZ2JaWkhJSm8xU0JFZjAwME5Gdm04?=
 =?utf-8?B?SERpNlhMRGQ0Ni9CMVNBb0ZPRitja2VFSDNaUDRoK0g2Sm8rUjFubUJyVjR1?=
 =?utf-8?B?MlZUbmVqNHgwNWN1UWNlakd1LzFiQ0hWeklXUWpPSWk1Vk5SRngzcU9CTm1k?=
 =?utf-8?B?MDA4NHI1b252UmxHemkxNlh6dGtqMUJsSnppRG1vSDFGWnJrU05zL0hrc1NX?=
 =?utf-8?B?c2FDOTQ4bmE3ZXhpbGJmamRRSEk4MnhrN2hVcnZJaFV0T0djQzEzYmJlVVRs?=
 =?utf-8?B?Smp5cDUwK1ZuOWd5NFM2SENVVUUyamxBeGpsUTRGWm9maXVQVHhqckNEaWVw?=
 =?utf-8?B?YW9nanRsNFpheXhBeEhpQ0h6Qzl1bHR3cHJOR1FIT2cyeDlhcTBJK2lwWThC?=
 =?utf-8?B?QkJwL2JNUHZTbWJKbVozYWxZeS9XM2JmZmFzYTBaRFdhMmFKckh0UG1zYXp2?=
 =?utf-8?B?S3p6c2oreTVpUWhvQTYwZ1BET1ZVRlNHaDBnTzdLSTBVUUFkMUFmaFVacHJN?=
 =?utf-8?B?QTlLMEgzZ3ZINVo4aWVPVHJiKzVoOHRzQVFuSzY0YUdrdG9OUUxEdjQ3Sm4w?=
 =?utf-8?B?Nm5tdzZGa3NXRDNRMURwdWdQWUNtR0Y4dnFRdWhyTHZtMEJ5dWdGNk5EdkZ3?=
 =?utf-8?B?cThIRWVDVFJvVGtxMitTeGlKUm9JbmczRWNoUVhKNk8xN25KcXR0RnFkWEV6?=
 =?utf-8?B?ZlVaREJIam1FL3MwUU93YitlYlpoK1o4bGtxS1VJUGR5eVVFd1VMVmJldGdH?=
 =?utf-8?B?aHVDUC9VQjIyZThnSnlVRFZZc29GOWRTWVJ0WndSQzdJclExSzlJWGFLQmFr?=
 =?utf-8?B?VHlGdUVkWGJieEMvQjNRbmJzUkhNdlgvSzV2dGhuSEV5cnpESDlWMDc5bzAy?=
 =?utf-8?Q?PL24Eo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmVzMXlmRjJlM2Zpa1psWXd6UXpTQ2NBTitnZklJYzNIZEo2dlVCTFNUQ1o2?=
 =?utf-8?B?RW1IU2xPMDFhZnpNYmZuckd5QWQ4cjhBUVJBTFFjbWdkRmlRT1U2UXlxSFhj?=
 =?utf-8?B?bll3SllTQVZHcXFocENzelpVODBjVjNZUzQyVWdlWHBtVzVlVkg0aTBhUHhY?=
 =?utf-8?B?Vk02dGxTMlltZG9PQUlRR29tUHI5ZTBtQytXYm5JMk0yWEU5dlhmWjF4MzUz?=
 =?utf-8?B?Y0Q4b0NrWjF6bDA4TER5elFGMEVWcXpaRWhHODVIZGJidmorbnhxMWR5SVFa?=
 =?utf-8?B?azFvdW9Kek1uTXNvSFZNVExpcWhSdy8wb3RTUHVLT0hkNDJ2Ky9Na0hJdVJm?=
 =?utf-8?B?T2dCU0hxZ3lub2RrSXVoSG5QSlByNGJNMHYrY3dMazhuUURaSXNTTjQxS1BP?=
 =?utf-8?B?dHFPMjh3d3VUWFMxdi9GSEZYM0VvSE82aEdGL2M5L1Jhck1vMVA5aWI3T1Vv?=
 =?utf-8?B?Rmd3cXFjWEFUVkN5Z2x3bURsekUrUU4wcEk3UGxyL09iN1NPQ2FtblFiVW1L?=
 =?utf-8?B?Ym8raHc3dU1sZVF1RDhSOGtXU0ZoZkpWWlNKbjBHTDcyS29mTHNoSWdlSFRJ?=
 =?utf-8?B?NDRFNGVCSlF4cVR2eVFuaVRxbGZMY21SalE2Sm41NVNHWjF5S0QrcythajJo?=
 =?utf-8?B?akJYNGZrdlB5RG1CTmdFU1JBbTNxckJZVm1UemQwcjNhc2ZGaGlhWk1ubUE2?=
 =?utf-8?B?VytJYTFIK0FMNGNES2pqVEszVHRvK0NLRHBnemZwSnBkMjB4Nnp6NUdyeW9m?=
 =?utf-8?B?SDY3cjVUZFNEUEZBSUtaYVNkZ2JKZXNrekRyQlk4S1NxenZ3MEczVm1MUTdC?=
 =?utf-8?B?RHlYRDZ6REZaai95SFBqWVI2bFVKSURFK1dNd1VQNjFkcDErN2xiWTBYcUJo?=
 =?utf-8?B?QWM4eWhjVXVvdnZlREpkV2hTcGgxUlRjeVRxWG1VSmRBb3Y3Qm4vS1ROZ2pN?=
 =?utf-8?B?QllyNVpBZHM1bU5uOW9SL242REhXaSt2SzdVMEZGUkcvcHdXNnRlZExhZCsw?=
 =?utf-8?B?WWZ2RGdDa3NJTlRUdTErOTQwM2FnbFduQTNGQU5PcXNOWThpdjFlNkxRNHg1?=
 =?utf-8?B?UTZEVkIyOWFlYi90dUVLWFVSUnZydUV4Wjc2OStoUUc5NWVkVHI1L0dsZmY4?=
 =?utf-8?B?VEpsd0tCOTZWNWVCcG9DbVlPaEx4bHJzcG53blNTTElRNHdxQUV3QTRSaDIx?=
 =?utf-8?B?M3M1cGN1bDF1ZUI4dDNReFRNRitySytucm9XZHUrbERUWDcyOVA3WjRkTlVC?=
 =?utf-8?B?ZitMSEZjNlNNc1liMWlsbmY4YVY4Wkd5QXRYOWEzNkc4UGxESnJvNngvaGxE?=
 =?utf-8?B?SzRlaEZJUjdTS3dDR0JrOUVKc1NJNGdSdmFsSk9QTmYxY0pibDZVc3AvK3N2?=
 =?utf-8?B?NnBtOVc4QUkvODV1SjA5eHowczJSZE82R2JwL2FzZTFvcXVnOG5nSU13dkdN?=
 =?utf-8?B?N2dicldGZEpWZWE2OWlLTU5TM3BDcTVCTWw1VjZXczAzK1VHeHNOWFFydTlp?=
 =?utf-8?B?dVJaWXkyczJLNHdWZTdrRjdHK3pBZ3JSdWJiZ3Z3bldOMnlQcUd6VTZwL0Ux?=
 =?utf-8?B?QXlSRVdJc241Nys4aHVoWjVzRG15MlBFU2d2cDhqcVNNNVRwT2lnU3FzWnE1?=
 =?utf-8?B?TTI3aVFMdjR3cjN0R1hYVkNtcDhlQ09ReG9ZYjFkMHl5bFpXWjZmcGZXcWJ0?=
 =?utf-8?B?MkIvTTZRRHJmYmZWOFN6TjVBR3N2bkc1aGovZDdCRUVEdVNVUHRVN25WTEUx?=
 =?utf-8?B?NEhyQjFjNVRSazVnM2tUNEV1bFgzUkxkaGxNckdNenQ1SmtOZ1BmbXJZVTQy?=
 =?utf-8?B?QVZJZUFqb284Y1hGUFFwUjlXSGJ2NHNyYW90LzZQbFFVOGZCME5zaUltTDh1?=
 =?utf-8?B?cHFtK0pUUGExQU4xVG5qMENURWZ5YXVKaURUR3oxeHgvV05iL2RTT2FaaGhC?=
 =?utf-8?B?K2dRYUV1MGxFQWFXUUpMRUhPK0xNcyt0Y0JpYnVaL2tnUWdlR0wwSlhGVmJu?=
 =?utf-8?B?VnM3THM2NXBrMEFuV1loOVltN1ZrK29xMTcybS9mT1BidjBDdzJBdlpRYStz?=
 =?utf-8?B?NllnTnZWY1FQMElWN2xpK0t3VS9ROTIxRkpjTDJoVEJJY3NXNk4xU29pUURp?=
 =?utf-8?B?eU9iQ0hOMlMvMm5LUXlXYkI2QnBCcHA5VjdCN1BrbDdWd05TQ0s1SFFiMzZZ?=
 =?utf-8?B?dFpsUkhlMWhyRzl2Vk1iTmRRaTY4WWduTGxSY3NNeUdrTFNqQXNxZGREeTQz?=
 =?utf-8?B?SDBoVmNHUDNrSmxweUVhRlB2L2VBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A461B0E3388C3B4BAA8B285661E76CF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o5TNdOFaqppInbn62gIZRK6vIdpSII4gT1KWDFcYYfqvJRmLbVZE30YMaTL03/DXpjD4ESQYyhLtgVSnxQ4jLCNjEAMfhPQScQTHi+2FRoWUtwInJW+KmnR6JJR6D49oDQPY6zljx75HVv6z5BrStCqLqHoPXIBjN8jgBXisX+s3VK9EiL1fYSomS55F/FXtOFwhTyDgMYawTf7OhewlhU/H1YjqJP/M1nYUk/R1EYvLgPf03it+o3yi2FHjpHDlYdf9tCFb0d7cWQug/XqmPivmUAV0IEfHUTerlaqjHHDs2T1DQd1HVxLblf80Ou7ftl8R/pwpxoEG8rCBJEUz5qa1u1lBT19wNi4bs9i6y3IOoyrpJj/MbGrUYKfrc2uBaWoCKcSgQgp80mFpGfT+JQmhYfd6V/Qd+lMJqKvf7EZdEtzRdYWoTE2mGHeIRV3a38fa+U+4Zos2QBSAUugL4sjlZYHjREU3Z5H5zDFoRHVPvlveLpqf9JFuFPLQOynTE6leN2dDXM6xYZ4XbivRyd892fBS/ewjUM6M0SjGuUlKxllZKiXfL+G/CYhJS2RT8Q+go5qhufeskpRNnOEO2mDRpTVxWl+YxYtu7fkYmTqW4Ba1/fm0W1u3F+n8MXbM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbe838e-93c6-47d8-31b5-08de15f21dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:17:55.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p56dlWOl/cvfNU72lXLi8FB8561Yd++uAcg0eSaMH6g7QovC1RcncBu9qxndpG6LKCHZ7/QdqOGCNIW8D3de25WncKakKw8vDnPgkx6sly0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6324

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
