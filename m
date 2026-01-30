Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE529DB65
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762120; cv=fail; b=pRy8r3jOCdJXdN4ScHKcLK4ACF0fMmYWwK5xY/If+dQCQc1147E2oqsJtM5MLfoC1GsBdSz2LRJ0kAj8kuceJlJeHG+KDt9/zkOAN69WfJaCYRTC8SnbGMH2BjczuSg/W5P4cUZKKNPgwl1xtIvJ+n6QT2heEgSfEgVhH1El46A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762120; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCpxrQPf59TXSzoutQLIjUTyOU0DvRW0U78UYqw7WrkygqlCUZ91PUG4Gfsx/mgRNLrBmeO6ObmcdAekkh0FG41FeF2Gki57Mx1HaxbdUXLJ0Y8MIey1FZtpLVtshBfEfLo3rNX2Esf2EjtG3TmhJNHDPm2ONMZIal4oG1jA1cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=plPLbYM1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nfgKyZtC; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="plPLbYM1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nfgKyZtC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769762118; x=1801298118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=plPLbYM1aPJNw+JWhR4r6jGk6iCa9zmIlDCWk4EUHlL/Is7tT5CDfzfl
   gCGBhipF0ckEk/mW1fWp9AnnwJuEWhYd0JCX/MguvlCmea41d2RvehL0u
   haAYPtsPLRUL0bAUAIjxgf1UtnPRoCHVTibltXXAVko6ZVd5t0JVj9buF
   iswpZTgNp9iVk49hlmI32dGcRLA5M6Vdpe4pqqmOKt/D3Lp/VFL+qzLvz
   DDlQtbkz4KLXTjGOktiPgG5NPoZ2MfTDo/uvpVkqaOGiAzxkB5P9+two+
   z24z7buhv47w96lwK0JEqafkgYxBcGCHAntxNtq0VEX97LTLyzZklImSr
   g==;
X-CSE-ConnectionGUID: ib/LgeRTTEqUAiMuufCueg==
X-CSE-MsgGUID: pefLoBAFT/in9m4//Y1jAg==
X-IronPort-AV: E=Sophos;i="6.21,262,1763395200"; 
   d="scan'208";a="140935579"
Received: from mail-centralusazon11011033.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2026 16:35:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSD2fJQPtRaUXIoE376ku6dOCAS+87CG8ZjsTqFV33xXFhuisLWac2FdWL05OMxN28xLUWxhb80/P3TPh6wTNW1ToWq0InG3IKt7YujWqcdW1DPEvN9uQ/6F19xxRfL5svMljAyU83plILug1X8Lqi7EDoSJTxXAunsVZS2ZjjMxHx3AFt0pclWz9Sp7hi8Oq5Fl32av8HMaEvweIoxyrZTG6v9irwbBRsj8THqvLFbb0x2Ps7nbXBumkn3L9hylaIZG6ZvQaMx1lid8ExGJB6gAC4TMbXwrP73pI/nZR3cQEJal137qphhgsL9woDbME3Dd9R8cOOQp8NZp94ErQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=DqyzJEVWk0/+av8kH3uJBYVj2A5n13aaePwPk5bGwREHPZk/WJGN+VVQmdBwyzbfhj3/KFu/QI4bECTMlnLOxcyHiud6oCpr0M2oX1t5l87bajn/YJx7heOsUnTuWYWEZoCT5iCBN8QR1+FzfOmpgm6D8Csa88CxqT4XLNp4NsH4gsOTBOHdXYEzz86jDAa3aFx6k5sE/N5sdgiOpq5RKph0DJkMhIUlczfWjAlKRlmIDOEVsonqkjqZpmkRl2J/emvWOB3HdKUK8Y6eaceEvD6vfnWUBbz4BMdfXk4gM4dBM0CgItjITTBIQ4VoEOPeFr2LHAI6p/p/4YBzbhlIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=nfgKyZtCHPSjoUT0V0h4R7b7k5Idw0wMNjkyo/R58qdo0Rn35fGd2IgTXiN5gdBoGLLVbrbXy800/JzkhiQEBYucogzaqqRlPjgwLL0Nq3bBss0ZSf4Kmnx1Fo/thwTkleiMbuCLMu5ZhpG6srEfKqnlPRZ1rNjvnEFjLUWnD8M=
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com (2603:10b6:a03:557::20)
 by SA1PR04MB8256.namprd04.prod.outlook.com (2603:10b6:806:1f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 08:35:15 +0000
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421]) by SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421%4]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 08:35:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: introduce bdev_rot()
Thread-Topic: [PATCH] block: introduce bdev_rot()
Thread-Index: AQHckbJljUcUfHX4aEGPrNA/h5wLQLVqY1GA
Date: Fri, 30 Jan 2026 08:35:15 +0000
Message-ID: <7aa36da4-24aa-4a0c-9da3-bf2a3a725dc8@wdc.com>
References: <20260130062846.1227392-1-dlemoal@kernel.org>
In-Reply-To: <20260130062846.1227392-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8987:EE_|SA1PR04MB8256:EE_
x-ms-office365-filtering-correlation-id: 650761ca-2229-4a05-0a8e-08de5fda7e04
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qll0eDJOSGJ5dnhTTDFqVWpHT1A2WnptN0Z1bmthRlJCRVU0MWczQ01uVmc3?=
 =?utf-8?B?MXJzOWVPNzRvT09LSXU1d001NW5VZHl1eXFKV2dNSWVrOGVnMWtnSEJKYzU5?=
 =?utf-8?B?NHNKM0hpR21LT0RmR3RCL0dEQWxmWlgxYXBRaHNMNk8xYnFFTE80S1hkeGVy?=
 =?utf-8?B?eDlHV0NjUDROMUFWalFlU0xhRDRmUVhsZVY0aVhQZ3RPeDF4eTQrRTYwVGl1?=
 =?utf-8?B?TFZEQ085cVZaOFR5RHdRY1JiV1BVZktEZlNLd1VWZUY0ZmErTW5oeUFxalMx?=
 =?utf-8?B?bFRrS285Q3A3RHAyR0tNWDd4WjBIYjhwNEZuMkVMcXU3MWtKa3ZpVlY0Tnpk?=
 =?utf-8?B?bnR2NWRxNDZURmE2bFAxNUdMSEk5SjF4eVA3b01FWlhpS2JVZ0xzc1QyTDJM?=
 =?utf-8?B?cGxhQmlCb3Z1V2xKeXQvWUJqMm5ZallwQjdkUkRwcmM4a3VZUkNFVDRrWEpq?=
 =?utf-8?B?V2JCei9rbGVKZFNSb3pZZWVubDRIOXpMbWRteWVqeDZVcnVYcUFtREZnQm1Y?=
 =?utf-8?B?Q3M4UHVsRktEakRZa0ZKdDFjZFBJZEU2aWljMjg0b3dzZzVGS1ZpQVVJVnc3?=
 =?utf-8?B?ajhTVmF2M1lObFRQdzlLSDJmYWt5cGptQWxscUZUYnN3VUZCMHRoR3F2WnhM?=
 =?utf-8?B?R2o2YjFUeW56VXYxc25TR2tQeUVseW4wNGxHY0JyOWw2WE1Oc3hJQmpLWm9C?=
 =?utf-8?B?TmFlTHAwS2JrcCtFaUp5cEtsUklkU0N0cXo5ck5tYVdFKzh2ZG5jUzhUK0tj?=
 =?utf-8?B?NVhJZHlKenJLYkJHY2t1azdZR1EwRVlmYjBEWXk0bm1aY0pqcGdlS1dsTHJk?=
 =?utf-8?B?aDgxNXRCcGgveTBpclRWZis2RXIxMVJPWTdnSlIrVzRxWXI5bTI3by90REc4?=
 =?utf-8?B?NExEQ21rT3ovZVBBVXNKS2tPMGhROEZBK1FPV1JxZklSTTJONjE4OUVZZnIw?=
 =?utf-8?B?R1lxRGxjN2Z4aytMeXZKK0VPRnJTT21rdzRyOUd1V1NMdlkyQ2hqbzR4cSta?=
 =?utf-8?B?akhxOGVOV0J0SWljbHBKN2EyZ1ZJTTZVUzBrSDBLUWhCN1FjRTE0QnloT25h?=
 =?utf-8?B?Vk1VNzYvUXkwUWFmWkdmbzRrOTFkWktzMk9FTHpaeVZ0RzBLODFSYkM1YUhz?=
 =?utf-8?B?eDVnNzZJN2UxWHhYeGZVcjlyK3V1cFlRSjE5OTBOK1YwTjAyOGJnN2U0WStE?=
 =?utf-8?B?Q29ObTNlMUdKcWtJdHFFb3l0TU9YS3VXUTN2Tk93cUlwUkVmTzVwZ1hwUE10?=
 =?utf-8?B?ajY2T1NwNCtBR1BWQmJ2VVRBb2M3VEcrT0hVOGtVc29kSmZhczdpOFVMSmJE?=
 =?utf-8?B?ZFJ5TkZtaVhpRmFlVFp4dGVobmk1YTVVdzlYaFRnZi9qaXFFT2pQQ3B5Skh5?=
 =?utf-8?B?dzd1cVhyV3hLNElxZXJsK2JMMGxyUWwzczFabEhwUGNzc1dpalpMbzdURWZu?=
 =?utf-8?B?aVJjT2hGNWExVXp6MGNmSHRJZEpzOUtqem8veU1oaXZCU0MvL1RLU1JMR3RU?=
 =?utf-8?B?NUdtYXZNVGFobjVubFhtT0szS0dwTGdRWDFSSG9sTFRhcTlLeW1Lbll0dDZP?=
 =?utf-8?B?dmM1bGx4Ykt5YlpwODR0N1F5cTI2VWI3dDY0RW04dEVLYVRabjJQY3dFb21E?=
 =?utf-8?B?ajFPaW45bkx0dVlad2xEZEM5RnZUUGNITDBNRmhaVFF5b2hUMXpITTJXTjRS?=
 =?utf-8?B?N2U2SHFaTXpyOVM1Sm9uWCt1TEdNU1BrSG1CcjEzd3ZpVitXbTdZVVFTdks2?=
 =?utf-8?B?aUlsUURqK1d3V3EzajQ5aUgvb05YdnVNNFA5NW1yMGVXR21ocHovdUZlSThC?=
 =?utf-8?B?a1ZYOFRpUmdKMDg0YWlISjd3OFFMQldza1YvQjBJZ1QvOHdoNDA4a2pqNE1a?=
 =?utf-8?B?ZGNEblNEOEM2UUJ1MlQ4RkVRUnZCSVI2bFlLa0ljWHVQS0tYOG5LR1pVdmJG?=
 =?utf-8?B?dWx1NksyZHZkVzkwcXZWUTZoQmRybjR2Tjd2cGJ1bDg2V1NlVW9TdXI2cFlE?=
 =?utf-8?B?UVFaaFlqNmZBeU1sMTJTS09mYnlEUzF3SGpNYlBpWkFmYzRsaHV1T0lKVUZp?=
 =?utf-8?B?azdEbFZBRXF2dmh0U2d3ZFVnNXh6QkIzY0d5akRKU1dENW1jdDcwSi9vUG5q?=
 =?utf-8?B?Y2dtOVV2UldTMjRORFJEemQzUzI4bUl0d3pYTnNoYWR6ZkJ1ZklNQjd1Sm92?=
 =?utf-8?Q?XUi6OnfdAYg8cgf8IaTu3JU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8987.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmNueEwrdG1Tbmw3TDdzaFpEUzJrbG8yYW9FUFBPNkVtUnBEUGZuOHh3UW01?=
 =?utf-8?B?L0NQc0tsTXQ1R1FVTEkzMFFBNi8xUVh3eEdCU1c4RnFQWFNoTkN0VkN4Ky9H?=
 =?utf-8?B?WGdVM2J4UWlHNE9QQ1JPcDU0b29CVHFTY2J2V0FxRkFVMzBQYmZyNk9XOWpN?=
 =?utf-8?B?dlhVMTdld0RTU25ocnhpZWd5OGVRMmhRR1lSN2NWbjBTL0VmZWNUclM3ditT?=
 =?utf-8?B?R3RmRG96cmw0N0JkdVc0eGZPdVZ2OEJaaHRFRGtxZ1g1RE0yQ2dwZXRQNEt5?=
 =?utf-8?B?RlpqUmgwdDV1TVRaRi9pb014SFRROERKTGZRRDdFS0VJd1RSbStWVkNnTnYw?=
 =?utf-8?B?RkJkbFdUOEZBQVJlWjFvK282eFBrS2NLSW1xeDUrWFNseDRJbzVkL0NFaGg3?=
 =?utf-8?B?V2tnTWJMUnVRbHZWcHBzV1E5LysvSFl0ZnB0UDdNaGVHTzJCelBwcHErdTFh?=
 =?utf-8?B?cFBuejVsSkZ2Y1RHSkJEU3hER29GVnhremZ3UzRCRGdwUkVGZkZ2REMycjA5?=
 =?utf-8?B?YnloN1R2aVJuMVYvRTMwckRzWUs2SWorQjByZVhhcjJXY1RpYiszRlFBZmN1?=
 =?utf-8?B?Q1A1MjFscDUwbDNNRkVHMHJwMmp2ejdiL2ZXQnNHdU85d01jV010UysvT1V6?=
 =?utf-8?B?TTZ6N3lsL203Si9FU1NSQXVTV0xkRk9pWHVXd1lidjAzTHcrNWhOdnVwVGRh?=
 =?utf-8?B?V2VuV0thQlNTSXhFRnZRbjJOZm1NbUxpZDA2aEN2THpyaURGYjNWZVJ2Sklu?=
 =?utf-8?B?UEF3UUZZbDMwTUlKZDBSTEZkMkd4MzkwZ3Z5MkdQMlVhUDBuRHpJNUNSTnNL?=
 =?utf-8?B?ZFAwdUtxYksyaWdwM3pQWllmRkM4YzVLb1pVM1MzUDZGU0crR2gwc0pFTm42?=
 =?utf-8?B?bUtQTyttaWxDMlNBbHRJMm9vMnlwYjJQdDlabnZOSE9kdjYvZmRMeG5WWUNy?=
 =?utf-8?B?R2UxTmVDTXRXdzFhWWFKUjBSYnBPOWt3cU91SHNpNWhNUVdlRW1zSlNNU2pL?=
 =?utf-8?B?NXF6YUFrNGVpL1Y4TysydHNaKzhjVFh2a1NoK3FwVVhNcXN6YmRia1BTaURM?=
 =?utf-8?B?TlJudHZ5cGEwZTk1SU9BWVZKN2x2ODVjWDNVVDNoNHBsVHpidWdGKzd1SzdP?=
 =?utf-8?B?NlNMMmpSSGhBSjh6bXhra29iYUViZWFGWm84UXR2ajkwbUFmK0tOSVgzZEQy?=
 =?utf-8?B?Nk90cHc4TVk2KzM1K1JQeitTdk5wZEtoMFZiSzFPempJcTdkaWlBRmZ4Q2h3?=
 =?utf-8?B?T0M2U3RiQ3RscjdhOGRYVzBkbloySDFNSE8yYWlQQmZHRGR4SzZITU9FbWMw?=
 =?utf-8?B?b1IzeXBGNkdmcU5jUE5oaVZ2b1d1R1daclFoa3h0L2hucmdOVHdRdVV0dHZt?=
 =?utf-8?B?eDhlbHh2eDVHRERtc016SGd4cSsyKzA5aXE2QTJEeVBSRjdzUE1yd2VjanRZ?=
 =?utf-8?B?WUYvWFJpNHBFYjdldHdJZjBTVDMvS3d4WEw1RUhXOVpOMEJQcDZ2dWJ2QXpa?=
 =?utf-8?B?cEFyTFh5OE14cjd3OWRHajVoNDlRUW9ILytDeHFNMHI3cTBrZnQwQ2ZQZjdt?=
 =?utf-8?B?VVdUZy9hcFcwbFd4ekE4cUlGNFNScFk0cURWczhHdjFDUG5kcWVWUStaSnl5?=
 =?utf-8?B?Z2dFR3puZ0ZXbHZRZlBjQzdGeEsvNXMvMk44VWo4UUEwVjBZRHhqdmQyOVJD?=
 =?utf-8?B?NFFwTkdRc2plU0JPSkxrci9QSjYrOCtVeWhnbWgwYVlMeTBEeEZnK1FWM09L?=
 =?utf-8?B?UHlmNXdSQzFkcWVtZGMzSnJVK3pkQmVPOFR0WG5qaXRObEoxZHFHTHhRRDFy?=
 =?utf-8?B?UWFPbWlGMFU5UXFLdEgyT1BYNUFTS2oxRFpzU2hGNEl3ZUFwQTdYN00xOFFP?=
 =?utf-8?B?YU14NlFKTXhseGR6ZlI5eUhra3YwM2pjMjZIQVYxakdGdDI4WVNMOXVxVnBL?=
 =?utf-8?B?eVZZWFlOVVZOK0JZZTlVczNiTXlLWHR6REdmRVdxWTNLTU1XQkI1NUFkd05w?=
 =?utf-8?B?Zkxsc2dCYTZ6MEhLZ3p1L2g3SXBDNFErUmdETjFyZEcxQ0EyRWxHWTRlSHNn?=
 =?utf-8?B?WllYdmVObDZvb0wrTEhzd3E5eGpVWkMzVnBOMzFyNTY0TEZPeUgrS1p5aWU3?=
 =?utf-8?B?Tm55N0Joc1JQMjlMZXZsRFNsUnF1TWFjeHpKYTcvSzduLzRZd1FRbXR2cnhp?=
 =?utf-8?B?VjlYdk9EdWxBYlhwSlBCdWNXZGJPMDVrL294RUFkMURRcHc2STNIaGxjWVU0?=
 =?utf-8?B?SCtIdC8rcGtGOUJLd0VmUU96RUszaFhxeFIrRlIyMzBxN1VWU0R3UHloeE4z?=
 =?utf-8?B?dEZwNkJNY050MUhNbFpNWEFLQzJjUmF3VTN2TEF4NHIzNDVXTXY0TGNucGpq?=
 =?utf-8?Q?UC9dlKl4ZXFH2Dv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1681FF80B14A8F43B7608EB63C224755@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A+S7BhDLFGedsjWvXnVyZxnFRqbvx7kh8y6D75coP3tnkbMPPbaqM8wpAsQjP+Mevjgj38EzvcDl8H/Qf4XmOX95n2VC+BA2zQYeIFK0Bgh25NfeLBzYP0YETb7DnCqxV9vNw82UEyiQ6HoQPEL+/AmLeeLXUeEcYw98YQPc5v/ZQSlHKIUPL0UPunkh2W1ls/qs+qeHqFxfMuPU1XnHb9cenfX9+LRxhRB4f54FLkwEky2vCJDr85e4R7L1/aW2zCIOoR6TpBOvtIBLG5nqu/UcecU1pEW2Y3nNvhlj8sD5Avgk/lLZc1AZTnaEyFQXuRfADQKf13zlNm6xRGSofVJGlOrD7Ob/CQ8N/i2Z/ngBt8QueE4M3Thq2WpzhrYIrRHOzzDPov4sopsPqzaPO1xBeB5izW5YYEUKaNLO6VpSBp4ahFLw+27j8QCEcoeLQejEsIyeB1ZZuuteM5ojeC4yoA6Rwws22TnL6uvQE0pEHjb/T6D61IdMhXdCKwHeSfeti3gqeh7F5RUur62cNrPUFUY0B7NVARJUV5eM8rB77yKZMMHe8k42dd//RX4lyZ1i5I6oXDWdL5i/AmM9QK69kGgbZXkSISCaurIqqFinilpUhAivNce4wIBwkdt+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8987.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650761ca-2229-4a05-0a8e-08de5fda7e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:35:15.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEgEY3mpVeVSf9t5Td1HdXoRW/PyCOSwahxpQPwL//Sste22VfOLvvrOqHNCjMBXqaMVkNnIf6g0FdXVmbnzwAe7iamyqZB2eB42WSkaIlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8256

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
