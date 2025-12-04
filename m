Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BE398F80;
	Thu,  4 Dec 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831728; cv=fail; b=RO/tgpuEPikgOr4v0sFt2uCp2HE7xStf7SlbKvbr6xbKolyIoKOdDSRT9Vd+Ce7KBXE/VNZls4n071aHxOX9kwVi3XBGeQQRDjfz3Ox5TbJphcQ6jZOoD0tcI1aovM2Gnd02+a/jiS7a0ihDiz+zK4yZK2kiXL4g5Zoe5C1O4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831728; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/2QPqWINSX4hZIHbf/6pzFzagodrsBk8xWwBqyjtEPHQS+FW2S0d3W1SbQAW5Myz/hygvtoFmUJOAGLTRpcqww6PKRxFdSu72Z+haztMevx90x4YSDyc6yX2pd9EMGlhRKkX+35n954AmsNUyZ/8GfRdr031FDEeMXE1X7/huY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ARD6VFqC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uKLzDJ/j; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ARD6VFqC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uKLzDJ/j"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764831726; x=1796367726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=ARD6VFqCJKtP6tDbOqKTQ+eLfdZi+ggUnLCMuZ04zlDwVkdJHrExqtKm
   DveqfjGMB8gEV9H13KUiBYsmWETaqOWYPorVYl4i4hXyZLyfbv+b44K/c
   RaiXH9UjZvQ5cDzu2U3eWzl0xLDGcWiBibSXvM/yUFpRjZIJ8AW5hK1Hb
   KEbgrigRrz0Cwn4/QsIB2+vzMvfPvSXgGvMH1I7xcBLEJzPfXBOO5+HYK
   D+HXAFU6rlpNHHdyYRk1oss88bU0XxPwu3Mig2omFghmNmuCR62y6sD21
   qdtGl+LK/W7TNmMDo2oFbs4TXayjz1bGkLuRvMjEN4VgduPCYFeeKXei2
   Q==;
X-CSE-ConnectionGUID: jUEEQlDPSniSqBH/Moiy3g==
X-CSE-MsgGUID: +sgZAfxFQOKZEQCvGJEOgA==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="136311424"
Received: from mail-northcentralusazon11012023.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 15:02:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yd2A75/pCEXAAQrPVuUz1l7jVD2yxX2s3F1HJJ3JzgqMdIy+CNd1bqwGfzQra++TI24C8yB63gLoh1xK+IMMF2m9IEgNbBAOZVXAjQkCccBnKgPf+Ur/J8phUBJhOQyVR5DDTYqzky9iYysJOxN6LzYV45vvFxTuJsia7pN9ntoYDSO15Yol/N03qsbRRobqjlvgSeebMgzJfG1W4GBBzF8RL+0H+PTZcOY2L7g/cA3/jEoPCjEMJ/3iL0SEgB+p2pC4rK1lW+e4oA3DO76RoCuQYLqgBiGo0TP4d4cLP/kl/Mwiy4z1an6jpQZ8XB0+ozILZv/JmvH29ZX1C1QXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=WceWsVKmphvl6Wqf1sNNeygjDuPBnCXflRqIDKokyL+3EvYNxp7hafhA7NQD9fEYUrsJ1wjb+89JIgSroFAEt00E9Lskbb6aTYIvCfatxgqm6PqI4FjkdSqDylIqgELO+zeqMccTD+7QIA9DCk2E1LEdErDYrjPWKai5qsa1ifSJ7jGXNAdPOyo/lhbuMrUdfjDi6fug7/lw7nZueMjQKBlOiUsgv+eH5rmpSCdDUuZoX83t/pbVW3ihmpXOrpflqE1DqUCrEpqt0aEjfbSw/iy7s3X5iWA+ZcbwHLY4LIbp6hNByyUZrhC/1RzezsbmZBH94T0EHzBxv3tTkq0JFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=uKLzDJ/jlmOY26fEXadCccy7e7FF4Ywzx3Vt/pTA2OnEuW5pFa8UejgwJvBe9Yo5UhqTBpRwy/A9SnueDIqzUUiR2o7BkA4WkZ0bmpXyUIgSvUhb+Z9elhQ3YBA6iDVW54hwOSf1lXbuIoKZgPOYdSGySOZl5ih5BzNTpEFWPLQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH7PR04MB9618.namprd04.prod.outlook.com (2603:10b6:610:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 07:02:02 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 07:02:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: shechenglong <shechenglong@xfusion.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stone.xulei@xfusion.com" <stone.xulei@xfusion.com>,
	"chenjialong@xfusion.com" <chenjialong@xfusion.com>
Subject: Re: [PATCH] block: fix comment for op_is_zone_mgmt() to include
 RESET_ALL
Thread-Topic: [PATCH] block: fix comment for op_is_zone_mgmt() to include
 RESET_ALL
Thread-Index: AQHcZGjy9KKJyx8yyEu9qioiKnU61rURDvSA
Date: Thu, 4 Dec 2025 07:02:02 +0000
Message-ID: <bcabe5b5-f544-4a0c-be1f-fc31317644c7@wdc.com>
References: <20251203151749.1152-1-shechenglong@xfusion.com>
In-Reply-To: <20251203151749.1152-1-shechenglong@xfusion.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH7PR04MB9618:EE_
x-ms-office365-filtering-correlation-id: 2ed3871f-16ee-48ea-3039-08de3303069f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SURSNU8zZzFmUDZVTlAyTWNXMzltREJtcGhQZXFhMmorbzZ2b0Q3NmQ3VGxP?=
 =?utf-8?B?NjhQQlBUSTFsY3RMT3A5eHduaDkzTWFMcHBycHhuSUJuMHArNkRCTkZ0RHRz?=
 =?utf-8?B?TFVuajlKTGFkYTY0bFVzNWZBU3lPRzkyZEJsOXJjRGFLWXU4M2pDTHZlSjJD?=
 =?utf-8?B?T1JFdXNhMDBJSC8zOE4xOGdaYzFtL0ZoMDFBU0tsUXVubC9Kc1hrZXV4emk4?=
 =?utf-8?B?VjFxU1FjSjZoZldtOXgrVk5uYnQ5Qmx4Rk1qa3IxRzdxeCtrNnR5TDBXV3dr?=
 =?utf-8?B?WWFCLzM3aTdrTVpaOEVIQUV4SlVhQllEM25iaVA1d2xUOTRaRWxxRTN3ODFF?=
 =?utf-8?B?RTh6bERiOGZ6RmVvMmxab21ZZFd4Q3c3QmFxVXNiR09OcVJKRGE4b1hqOUJ5?=
 =?utf-8?B?dmEwVjRsS0NnVHBpazZ5RzZncC94bEpHTnArR3p6MlROMnpxeVc3NUZuSWVa?=
 =?utf-8?B?angxcEhzWlorYzA5Y3MwTk9tWEx6OGg1cFBOQmdWY3Rnek4xMDNIMzVZNTc3?=
 =?utf-8?B?aG9kV0RCRkhRaW1yaGNndVM5MzUyNlJONzlvMnV1Rk5CM3UzT3ljbnhkWWRr?=
 =?utf-8?B?TWlMbVNEZTFnajZQRjdmMU85Z1BoSTNGRXRORmtaMTZwYVpqRUExa0dTdVZ5?=
 =?utf-8?B?QlcyZVcyM3pia1VRbCtzMWxOTkpGekJ2Ymt2UFVaMEo2anZlT083OGNoQUtp?=
 =?utf-8?B?Ukp3aUpwWHhPTlZCcUV3Q0hzUVp3REpGV0RyaFFFRStXT0poSW9xZHlSSmdH?=
 =?utf-8?B?NHR4VmdndzBZYUV0SDZ4SzE5T21EYUs2TkswRGJRNldubGN1aU5sWHBiK0s5?=
 =?utf-8?B?VlpxQXk0MUNFbkIrdmVXOFNEMVJvOThEM2p0dkdjQUEzQnN1V3BDRm1qZTlG?=
 =?utf-8?B?blNYRWhpSVVYZUZxcHBjYUhvcndOWEtlaDhLUWh2dXdqZUtRQ2pSUzVibkZ5?=
 =?utf-8?B?bXpBVmZsOFQ0RnZUNzlqQnFvSUFJdUhaUWxna3lhaGU2aG1DdHdpNEFVUU1S?=
 =?utf-8?B?K1JJdG9rQkZtN3dDUmpQWjNKQ2JER2dCNFdyUWl4ZWNoMjFRcytwbnVCeXRj?=
 =?utf-8?B?QW9CQldlSXFDd0UvSHlCWjVUYTdTUVhrRG9PaDlTc1hmazF3NUxlaGJyQndk?=
 =?utf-8?B?RE1WcWQxMllvYWl1RHdZL01ReVh5dFY2a1Y3RjhGelJLUTNCeStUMU01SEpI?=
 =?utf-8?B?R1I5VDlYaE0veEpMMmtVS01MbUJQTkpZRXM1RXpXWlh6bzZpenVuTGl1NTlm?=
 =?utf-8?B?YllDUGVHc1NCMGFGUlMxU01lNkQ2cS8vL05tZnJOamtrUmZxckRialFlVHEv?=
 =?utf-8?B?WXliN3NjaFRqampKR0FOMG1oeTM3MDhZTEZoK215cWs0UUdqNjk5NDdKbXBQ?=
 =?utf-8?B?enhOaGxQMUFCczhmbjdaU3dlZCs3emtMSlJZbThLYUFDYVdqNHJ3OHNqUlcr?=
 =?utf-8?B?MWZiWmV1ZGRNazNjKzlmbThTWmR2OTVGbTQ3NEdhN1pmZUJEY212QWtRR2dZ?=
 =?utf-8?B?azJrMFl1a0V1b3RxczNkMHF5di92Yi9xVi8rUm44WTl5bXk5aDlMOWRCRU96?=
 =?utf-8?B?VHNVU0R0bDE5QXpLZjI3ZThUb2g4cnQyY2RVTWQ3RWsxSjhNY3hta2FOQnlZ?=
 =?utf-8?B?Rk9aNytSODVncVdFeURqc2l2S0JKVVAxRWpjUGNxZHUvNC8vZGkvbUkwSTJO?=
 =?utf-8?B?L1RqMmhwK1JjT2JTM29aTzJEbmp5R2dzeXpCS0RlalRudkppeXprZUJaSWQy?=
 =?utf-8?B?K1FMSitEc1NrcVoxN1h6R0J4RXZSYjF2NkoyV3ZFMkRMZ2hHZjhHL1BPZ3ps?=
 =?utf-8?B?WjYwcWZ6M1V0TU1SR2NVSnJoV1VLc2xCN0gzU1NnNVRSWk5zSk9ZRlhUT01H?=
 =?utf-8?B?SmZJL3hyY3NlUklhUzlJbHJIZ3R5TUtXSUFoNlpiQkJoaEVaYzNOL0xQcDVa?=
 =?utf-8?B?YjFYZmd6dVBoTWdvR0JuUDJ2SFBFZkNoaC9kbzE0eC9kellIekxUSm5jOUxF?=
 =?utf-8?B?ZlBWdUVXSUllbTA4UzdJOWlVQWI2d1QrcWUwd1M0OGpWNEZmR0RTbjJaR0xu?=
 =?utf-8?Q?chv0Et?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUl4ZlFYcmhxb0hiaWhNYURuTUUrNm9HWHhTREY0S2RnS0hMZDJqaWlJSFUz?=
 =?utf-8?B?UlRzeDlYQTFyb2VVaUtGaCthME1lSDZPZmtlR2lmTElYQVpIRHZ6anJMcVhH?=
 =?utf-8?B?ZDdBT2w4SXlNdVVUUlBySHp4aDhFTlY2QUlrYTVWSVJ3c29JMmE0c2Z2S3Ex?=
 =?utf-8?B?M2pBYW9kQzBWUXRlclNkdG5ra3BvMWx6MnlHOVdQRG5vS1NBWnVSVWZrUkp1?=
 =?utf-8?B?VVMzU3FVaTZIWGZaWlNXZXFTYkw3UXBWaGZNUm1FNUJ1MUtKZkl0VXlDdDQ4?=
 =?utf-8?B?a0Joa2lDcFpFMjBsSjFYdDRCUHpXb3FMT2N5NXlPeC9VZVBHN09PbUhJejVS?=
 =?utf-8?B?Nkg3eEJTUGU5dXpwaEhDbGhwNURVZ1hLQ1NWM29VMERNZDFOY1A4eXozcmRP?=
 =?utf-8?B?d1pSOFlXKy94UG5ScWxNd2FKaFQ0WXpzUGZKRFpHUGY4S1pQejVCWWtFRWQx?=
 =?utf-8?B?UjUvRFA5emwvRFg3VERCb1pPLzhyUUNrT0V3RURSWUxrM0ptcW0vOGhGS0pT?=
 =?utf-8?B?N2t4cEtveWpCU1pNNzJ4Q0x0SXp0SXpBTkJvKzB6VExRVHg4eHBWQ0I2TGV4?=
 =?utf-8?B?dlkwR2tHbURIYVUzY0hmQXF6SWo2NWpYcnM2MWQwTEl0SWUxNk5qaFZaN2w2?=
 =?utf-8?B?azJaS0xvOFFpYk50djdzayt5S3hHZGRvRTdXbU9GMkFrZlRWSTdadGxvYVpy?=
 =?utf-8?B?ajMxeFcxcFZodzRRMnE3WFNBRWpaWXJBUnRGOThoMVlGakRFT3hBWTEySkFi?=
 =?utf-8?B?WnIxZ0VtT3RncTFtQUNHQTVCeXI0VmJxSGJ5dmJwcmVnQ3N0M2J4Z2dybHBI?=
 =?utf-8?B?UkNGL0ZNU1RTUHdZcTZGMmJZUDFvV3VLWDVGYThxdnIyMHVyODV1aVhDUHRp?=
 =?utf-8?B?TlpIa1lzTmMrRy9WaGY5bmN4b1R3RGdHMi9CL0hPc1VBdXFNQ3ZFS0hLMXdl?=
 =?utf-8?B?Q1dub1Z6SGMvTFRxYVdEVHhhQ3h3a0x1THkyWHJyNDBQMTlmRHNoZW1GWTEr?=
 =?utf-8?B?NEw1YnExcTJZK0Rxb0FBL1d2RUlDQ0dzWHpHcmd5cHNkS1JsNUdBUmpqMFlh?=
 =?utf-8?B?aHUycWc4Y3ZhZkZWNUJ5VlVIMTdFbUY5UFFPa2lsK1lZTEZkZ2xWdDBMd2pz?=
 =?utf-8?B?Q0dqT0NiajUvc2dWZTlaaUFsTnI2WTRaZ2MyNnNNNlJLeWJqNXR3ZGN2TGEx?=
 =?utf-8?B?NUFIaEQ1QzJmRHlNcU45RklOOG9oTVFRb1lSZE5qcGFuVmdSMTR0cUpYa1U2?=
 =?utf-8?B?K1hlUUUvUFVaaWxiNVQ0NnhzSHdDM3lVMXdkWDJ1TVVPY0haTGFuemQ1N0dQ?=
 =?utf-8?B?Z3djdTVxM1hvZ0plRThsU2g1eDZERkEwL1FZb1VBTS9BSkIyb0t4am5NSUVZ?=
 =?utf-8?B?VGNIOFBaZzBDWXJiMmZ2ditkTkZZc2hPZGRuNFdYcjI3OUlsVjJrbjJhUU5x?=
 =?utf-8?B?TXJmRnltNDczODN4TSs3S1JGcHNZSkFmd2Y1L0dhblRBQThrRHRNNWJqd3JK?=
 =?utf-8?B?bUljWGkwUFN0VU1LQ3FyQnp2WkxWNUJ5SW1hdENQV2M4N0crckhnT2JjTHJk?=
 =?utf-8?B?NHZwcGNLUHl0KzNzUlYybG45bGpNV01NcDhSNEIrQ05HY1M4cjR3czh4Z1hW?=
 =?utf-8?B?blVWb3liY0dqak9GV1V3T0l6MjJCekowWXc5aURzeDhyaTlKRUFKZjJJN1pH?=
 =?utf-8?B?bUJPWStLQzRuOXZtYzBiTmQxSGU4S2xjNTkzR3dhRjUzNWpQaDJJL1Nzd0Fp?=
 =?utf-8?B?dWd2TmFKdE8wNTB2NHVNalZZVTR0VHNCb2Y1M3ZXRUVZR3dhM2MyYlJrbkZL?=
 =?utf-8?B?OG9rcVBZcEdlaTh5QmlmZzdFRndILy8ybjMyUitxeEhpME1MS2xSMkR2VE5y?=
 =?utf-8?B?dGlFcHBlVHF3RGp1d01zKzVkOHQrbXl5NTNzTytpZ2lxVkRCNVRrQ0FPNTBu?=
 =?utf-8?B?T0E4VHpTVVF5VHBON1ZoRENEVWtJUXJVUmlseDNuM0g4R3FUc0Z4Y3N5RlBV?=
 =?utf-8?B?QzlXcmhSc09JVSswOStqanl0V2dJOFNsUXRaRW9rT0pxV1hrOWMzTitVU3Rq?=
 =?utf-8?B?NFR2aSs2Z1JkYmsxOE9WMFl4TFoybElBV0E1NEN2cnBUUXhPR2t0RXRHQkNm?=
 =?utf-8?B?ZDNmaVZ5eWJ4Z1hDcTFLYjhteUltMmxNcUhHN1hEdzc2OVA4RU9vWUpJelUx?=
 =?utf-8?B?cVFmTTNDS3N3SjZQTzMyb25qUkc1NzVnNlIyb2ZyVXBuSm16WklRSVhUbkhl?=
 =?utf-8?B?VWplcFM0VXJrTzdqUUxPZTI3TENnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE1FD133269FE439EB7A5B9ADF6934A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAExZICuNO4PJLsNy7XkBlfDOo0tdxzXdlBiG/dxHNR0lbOf/RROBcKQqnbvxE+bkSLnrjCKXQMQ8aTNJ0lEjCaiBzxuv+rbPTUJ66LuqpqhrBqgJyF5i/g/EZnALDywQYnwwjke8N4TeMwRkS9PYZ8t3iDPdwsEJUzZIWyC5agcwr2jjencU/mL4A9NPNG6JFVn3w44Kik6NjL4LqtF48X40fX+ZozrOdKRz6uOdc+XKRF3I2x52j3iGVBraVWBrvx5W5QMf2F1TEcHBqI2KLgGmoTiC0RYNirbNn+zAOYx7qT/rdvWdXwxnEsgqmBOQgVpNrCs0uhgCyfEJkotTALXmWGfTnI4OYaz2bK8rVRAw1ZxS7+LEL/9yuenjU+7vg+saiIlykhfVfZSOEl7sCbydh5b4D+p/0Eby/z4tJDOZWgKMyqsafGnV/qxg0MB4/1645wdO4PIsI98NgDwmlkYiZm54G5GBM6Waxazlj7BCa10RE4H88wi7ytDh8ZioTk1RfgsYV2wrqQCg17GR3//z/JGPboJc7gaZeltBtnPohLDTwlnKE81KkFqQ9OoDy98GC5Qn4LDwks1v96qxGfsPuhy3FROHN2LqIiWJKp7ES2NuwIL6/MMlCMTB2X5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3871f-16ee-48ea-3039-08de3303069f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 07:02:02.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwyKIvaBJcfjohhXjFZCSs2TzmnnZ4hZupHE7eFf30C9uty6c7Ao807wKNODKMRxtic7+g7pf7A6NkfJchlfJCLNxGyaCJ7Od73Xv4MwW70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9618

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
