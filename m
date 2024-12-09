Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AA214A9B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728825; cv=fail; b=rtwOIuaKK7zPiMRU0JXo+l0XPCIURB+qVy6du4sojanXE1cADRo/ed5y/jnqRUizISCqGi6EZnCAXVxW3b2Z/W15+yUZriWaHGJ4Z8TXMrWnvsX8vWgm6a9v/r433T457JG5WHIEso+328up/NiWcpI/SfTknWlbpgzXWR8bgew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728825; c=relaxed/simple;
	bh=gBFsWGp5m66nDkDhq6hwdQ40LBKadTtl4DASe82SROQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CltmRfutPo/ChsGFZnROvuItqR388BjLTSwHPAO3JsfvE4dFWP7LoqWt2KDR0uftVx2Fw2aI3CyCBj/A1cEW/DS5gmvpmg4a0g+QaxBhEJqkK8GSLJTVVvHR/LbvULWLK/geYE1uN1BRO2v4l5bpkpsiu5thYeS1ts+teLAmWfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cq7h/aWo; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cq7h/aWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+zQcDZoYxeV0E+6pm9S31V8MrvLQcZitCyBKc8Ndz0HieAdY5qAiRK7LYZi00nCQE8lhFqek20GePESs9gpR7sZnzdOd/XP8eX2WQF6ZLnzjTry25O7dZGhFHji7puqUf/ChU4aV0UKNSTPkAcFTVlC6NQdIiijdCVC9yKWQJOewRoQx38v+5Nh5SdCRCpbw0Qes/3S4ArGl8xXisyg6L9PURLjL3H6mhOYAEjplgUSOpb9eVZN3q1rHDAlmr5qiLOKAzCGgOTlsimQIVhv873eBAe45dN26ZURpHA2lxQcGp7jP5P/V8TZ2VSuCgcTHF8LLGURtQw+UXVMBDov/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBFsWGp5m66nDkDhq6hwdQ40LBKadTtl4DASe82SROQ=;
 b=oAeyH1Hl7PCv0FlrnbtFvLh4Ernc6L4M6/JzfKJjZYGxouTMHHUsbNZvc53BzMoJTa/G8adYJ2GSOA1V1LXKkyRW2bEaT7hiOtmHqHbW3lmhORe3A9CFsVOaB0PmOOu1cKjHb11GYm7YPUehBXrhSOaoQAqmE16yRsySiBnHLvYuPGkQAWLDnbsAKJxhv5f2UDq78wrr27zXVLFXrenUkwXz+2Jo84xqLhd1d0BAAni4LvpuXiqHt9ahgimJBic5UM95FX5tk/OpLPCdWBnSVNByl+PM9vSvTeeqzL5zRcnOyxl4Wgm5wTGSRuM1dmNM8BlnYqWfmhs/7ktxFpD0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBFsWGp5m66nDkDhq6hwdQ40LBKadTtl4DASe82SROQ=;
 b=cq7h/aWoPliOS4kku2l1NAKpTDisoE1iF9DurWZ0li+lU37nV15CXmgEukfRVAygm4xHvQOzy2sGcEOMu2QG1419Yn3S1WAtWNjUNKO9EeEk57xPtviz6CTpnn1XQ8712mKJdPC1mqBswmwwzdMPCG7u8lQoDR/Ih5n4FHrB2Y1cOADyhFdLTOdS0vSa/vme9feECyZx1j5qWdmYHD9d8DpyNKxblYOE0JOmXchsse71j8PkA3a2lhFaFhiyMVauIUFEFHYyaixIpvvJwLodWvI+PxEShq6zXpC4AQc76G9rMx5UxI9le03sWyzBHjB0qpPXQW2RNwB4h+VpaIyEvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:20:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:20:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp zero-copy
 offload
Thread-Topic: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp
 zero-copy offload
Thread-Index: AQHbR+YHkbmthLaF4kC0wbMMLBcZ+bLdhc8A
Date: Mon, 9 Dec 2024 07:20:20 +0000
Message-ID: <de992fe9-0146-43d3-8bb8-9a36b459537d@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-6-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-6-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: 9ac82784-6a04-4e3e-d8aa-08dd1821f0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWxVZVlVSC9HaGpWd2JRN25KbjZEd3V1V3VtYUZscjV6MGpWWk1EZGw5dEZP?=
 =?utf-8?B?R0xMZ0pVdmluY0RXOWVpYTlVOUd2QnhtUDZMMXJVRVQrY3pSMVRGR2FuODY4?=
 =?utf-8?B?a1lVVHgrNlRQUzBaMnpZVnk2Uk8wMmFIY2NtNDkyNEkrbVlJdHI5MzkrYXd6?=
 =?utf-8?B?bnk5ZkpUUUdPdVp3bi9obWhGLzQwbW0zNDRWc1IzWUNlMERKUFZHZXkyaG1n?=
 =?utf-8?B?OTNCS0o3Z1V5ZnNwOXNpYm5YTXMvcyt4aVZZS29vL05MQ3Q3bFZVRU56dnNv?=
 =?utf-8?B?RjNkRWRnb0hFdDgxU2lIUDVkWll2RVYzekl2T242L1NjUWZXUGtLeEFUK1Ex?=
 =?utf-8?B?b1ZkdzF0VzVVVkppMzJTU2Njemg4WmlNUEV6YzhtcTFNRmxoZkRBWXVqMlFO?=
 =?utf-8?B?QVAvdytLM2hra2RlbW9LWkJMOWRReFdid0paR3dYME5lSjdwVzBHTENLSjRW?=
 =?utf-8?B?ZUJiNkI1ZWlNNXZIcWUzMGZyTEFHL3lrQlVpSHlRSFVQZjZidWlVdVpBd2pU?=
 =?utf-8?B?d3hOMWFDRXptbm5ES1ZmSzErUTd1czJ5MUpGblpJTFczQ0tBRGtHRnBnVHVl?=
 =?utf-8?B?V2VXRFRRS0dxdG5FTG00TC9TS2x4dU85aGpLbUtUeEc0MlEvZmRBbloyN25l?=
 =?utf-8?B?Y2JjYmdXd201dXh3V0dPR2lpSUhaL2NRSEwvLzBLVml6Mm8vYXNEaW9tcEpO?=
 =?utf-8?B?MmVFaFhMMFlidHR5eFRYT0Qzay9SanNjdldpbEpJMkkzakRGdTFhanRpc0V0?=
 =?utf-8?B?dlp0aEc5NnkwNk5EQ3JESm8wZkVRK09aaGc1cmdYeC9OMDMrcWdualdRSGlE?=
 =?utf-8?B?N1dSWUJFdkxMQlhrWng5UHVtbVVtZlJRakJ5empLazZ2bmRSUEdPWWRNeFNz?=
 =?utf-8?B?QVFIOXdXajZ5YWZCa3lDQ0ZhVmVUWFBQeDY1bXpIMk1zQjNsNndQSG0rT3hT?=
 =?utf-8?B?NmtEZEhtNGxqOWowWGp0TVZnSkc4UmpNdEZNZ2JlOGVuOS9yK0xlS3hpYTRN?=
 =?utf-8?B?UWRKNUtEbTkxaGhGNE9KcjY4ZXF1WWFmR2lzQ2I3L2FBK1p6TGFXcWt5MmR3?=
 =?utf-8?B?dnNsZDFwN0RjNGsveVpHczd5WnI3LzBlcTNzaCs0cFJ0dEUvN1J6MFdNZGlR?=
 =?utf-8?B?MDl5UGxkOTliZnlMSnp0SVc0R1B4cGJSV3FKOWkvenpEWEsyTVlxSWM5SXEv?=
 =?utf-8?B?b29vc2JOMXJBclJvK2p0TlRFQUk5MlhoU0JuckFtcGRDd0dGdWxHMkZwOXhr?=
 =?utf-8?B?SlB3WDE4VjlPUXJ4bkY2YmNiZ084dDV3MkV3RllmcS9Yd05iWFp4L3Z6dytx?=
 =?utf-8?B?ZTFDa3BDRGFZUEVHRVN5bmd2TGhNY21sVWh4V2MwYkM0QTFwaGlvWnRKcHgw?=
 =?utf-8?B?V1d3bjFMcTNkRlRXNTcrREZMUXY3eTgwV0VXVW1IdlpPcVJpTEJIQTNwOWJ4?=
 =?utf-8?B?cVJkUFdCMFF5ZndyT1ZnZzJZcHVnSStONHpvWDlkcDU2K0U0SG9BaHhGbUJR?=
 =?utf-8?B?KzRQV3ljbkNyaitxd2cyU3c3Q2hVZnVpSm1vbTlSVWZLWWpneUdxb3RrRTA3?=
 =?utf-8?B?YkVVMjVNTk9YVzU3Q3R6TDJobi9Vb0xTQmwzM1k1ZWloYWxsRks4RnNUMUpl?=
 =?utf-8?B?QlMwMjk3RktROTJtWVpZR1liSFBwRWdxWTBlN29CalA1dHVmVG9nQUUzNTVx?=
 =?utf-8?B?RUgvWWFqU0UwRGltN0Y3bnFBaWEwek9mUnRqOUNaZkgwL0d3QkZHNWFGRjBJ?=
 =?utf-8?B?ZGtndUVBZVNTTXBDM3pwWmNJRE05c0c5WUI2MEU4WlJYa1lIbnhQMENybnRC?=
 =?utf-8?B?M2ZibkdUWGptTzlJV3lVSGR2TmxER24yL3BCVHgwWFF1SnlYOHV5bGg5dDNK?=
 =?utf-8?B?V1pkR000UEVoRTlBenU3QzlyS2ZBNHNkdU9Jbkp1TFdkZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGNWdkxnYUdWQ2NmdFhDQjJ2Vmc3alh1RGx6T2dGUWhtNS8vZEJyTTY2Tnor?=
 =?utf-8?B?WDkrR1ZpNStlU3FYWno1bWg0eDA5RzI2bTdWaFFnZjFtSm1aUWxmUmtoRnl2?=
 =?utf-8?B?L3NaTUFwVklQVngrd1ljL3ZTeFkvSCtKMU9aN0VNK3hUOHdpKzFVcTBkNFF5?=
 =?utf-8?B?U2xnaU55aUdGMCttbGNLNGo4NDlKUmhWR09tRTFVTnhuOW5XM1hCQ1RVQ3hz?=
 =?utf-8?B?cm1Rckw1b055a0UvKzhZWGxjV25uYTI4dGxCbnBLOVoxWUhYRURNSWdZd25J?=
 =?utf-8?B?WHI0T0hKRGQ4cUo2WTlxRW5OT1BoS3JETFkzbTFBTmUxbUNZck80UDVoN3BK?=
 =?utf-8?B?aFF6MGxqWHlnUUhLNWtENjlLM1dZWHNkbDczTWVXc2NvRDd4Mjc2Q0Jiei9D?=
 =?utf-8?B?bDg5a2c1SUtCQkk3N2NPblZ3VXQzdzNRUDNyQVgxQ2RXQUw1dTdMa244NVQv?=
 =?utf-8?B?TUNWUjNiSkpGdjBrNXBSVEY1cHU5RjRMczVGL2JQc3h4ck9YNyt2UzAwdFhz?=
 =?utf-8?B?U0tsNXRiVXUvVElpNXB6M1BLbG5hcGxaK0JkOEJja2xsVTVyNzdTTnVhbXBJ?=
 =?utf-8?B?SmF2Wk1Pd2FhVkx0bTdmdUwvZFdYbTN4RG95Vk10T000cWtFemxqYUZIOU1J?=
 =?utf-8?B?ZzRXT2JBUUEwckRtaWVsb01UMzdOaUFtTTEzakpRMTg4elExRnVDcGxxeFNE?=
 =?utf-8?B?dllwVkpPU2gvK0VBTnc3d0FsNUxLbHRpeVJLMmdqWVN6V2NkZlNsN0NETURN?=
 =?utf-8?B?VytHSjJYR0owemE0NlVHb3ZSSlRaVVdjNkZJVUVHenRrMEdwM2pUS1Y4dU9O?=
 =?utf-8?B?d1hlSDVQQnE2cG5XWU95dFN3S0xadXFhOTlBUFlSRUNWZXFDZ3ZHeDJyQXQz?=
 =?utf-8?B?eHE5VmhNT2xuK2VDZDh2QVhxcnMzNVp5cW9mZ3BtV2RMdTlpSmhMVm5TcG1X?=
 =?utf-8?B?Zy9STkVOek9aYTJ4WXVaS0x5M3FZM09ucjF4YysxVVErMGY4Z3lsT2cyL3Nt?=
 =?utf-8?B?M1JRVXFCQmhSVlJOdkU2Nkw1dlc4d0tYUnZha1FOTUQ3ZmlvRHQxZnAxT29D?=
 =?utf-8?B?V1VlOTFWVjRLNVBlTVpzUHM0L0NReWNMV0xjMTVkTlVjUlpkWmhWZCtXcDh5?=
 =?utf-8?B?ZWpNWnJzSGJ1OHFTR0RXN2ZIaTVNcS9hRmZmYzJTSHV3S0ZLSURDenVkajd3?=
 =?utf-8?B?TVJkUU1Sc0VsSHFvRXU5NWV5QUVzRFVWckhVZEcybzMzRVBlRVFxU2JWNTQ2?=
 =?utf-8?B?dmNTQkExNmhhWDVlYzc3eFAvUFl6M05obUVNUHRET1pKTlU4dUFKZlNCelZM?=
 =?utf-8?B?UWk0SmVZNGtJdFVadnJiL0UwMkJoZ2pLdit2a0FSVlBYKzF6ZTRkNGtrc1F5?=
 =?utf-8?B?akhhYnpEMnlaS2tRQ0FnQXJMSFluNE1TWFB5VEpVS0V0bWpTRW1BZTRjelVK?=
 =?utf-8?B?RjYwcHhNN0pQQ1VtOEswSjJlcXRWeDdkTkRPMk5qQVlNQnR3TDQzc3RzK1FH?=
 =?utf-8?B?VWxaaVRxR2dJMlN5V0NlVlRIVFdZWkxvbDFTbVJzcUU1L0RMTWFpam5FQUV3?=
 =?utf-8?B?azJUUzFvMUhJMmNHNEo5bVBVZWt4YlRCMThtL3I1WHY2bmRHdXh3b2I1bHZH?=
 =?utf-8?B?Q1NnbDVaWmVGTEJrb1NnLzF6U2ppQ2poVE9BNWhDUGkwcDNoSUp3dDYvSVUy?=
 =?utf-8?B?QWRyRndLd3NDTE1VbGRvQ25JVnZsdTdIbUVXcjMzZ0hMK2h1dk5nV2ptL1Rx?=
 =?utf-8?B?QndFZkVlUVJjYVBrdmlrR1dPcEh5U0d3aGt1a0piaWgyY1lqSUJJQUJYY3U1?=
 =?utf-8?B?Z29pSTNSNDM3b2s0MlNuSDNzaGRLNmwxNTZ3YUNKbE02NGZZZnhkNjVUVVkr?=
 =?utf-8?B?OVo4TUk0bW91b0ZjbjRMZ2tHaGRhRVFDTmRjQmJpZGp4L0pLUWVDbm9SbWtV?=
 =?utf-8?B?QUhTUFlhWjRQaTgvWXgvSnA1SnNFTkY5a2R3MloyRjZraGhQcXRVemlsNVA5?=
 =?utf-8?B?RXQvc1ZvRDQ0d1dQSS90VlBDSWZNelhxbThwbmMrNkxjT0pjaDNmd1pkYUx3?=
 =?utf-8?B?cXQ3T0grQ21leVlhNnBHVDE0QUJUMERsTVQ0RXRPbzB3MEhMblB6WjhTcjRZ?=
 =?utf-8?B?dEs1bUE2QzA0REhUUzF1NFNUby9IOUpZdU5yTU1Cc2U3QUVLMG5Qc2FGd05U?=
 =?utf-8?Q?D4Y7+adzuXAfjrugqPwjIBrsDg/puXDCNfDBhp+c21LN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <027F753D29C4CB4FB217ECE1EF2F1894@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac82784-6a04-4e3e-d8aa-08dd1821f0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:20:20.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roca4f/hns5Fv6D7iVbzLx9MPgO4rGqCDiWk87KTE1cZqh7IlKYAzzr0966D/tCuCd1Tkf5nUVrOlHcM8OX+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

T24gMTIvNi8yNCAwNTo1MSwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IFRoaXMgY29tbWl0IGFk
ZHMgYSBuZXcgdGVzdCBmb3IgdGhlIGtlcm5lbCBVTFAgRERQIChEaXJlY3QgRGF0YQ0KPiBQbGFj
ZW1lbnQpIGZlYXR1cmUgd2l0aCBOVk1lLVRDUC4NCj4NCj4gQ29uZmlndXJhdGlvbiBvZiBERFAg
aXMgcGVyIE5JQyBhbmQgaXMgZG9uZSB0aHJvdWdoIGEgc2NyaXB0IGluIHRoZQ0KPiBrZXJuZWwg
c291cmNlLiBGb3IgdGhpcyByZWFzb24gd2UgYWRkIDIgbmV3IGNvbmZpZyB2YXJzOg0KPiAtIEtF
Uk5FTFNSQzogcGF0aCB0byB0aGUgcnVubmluZyBrZXJuZWwgc291cmNlcw0KPiAtIE5WTUVfSUZB
Q0U6IG5hbWUgb2YgdGhlIG5ldHdvcmsgaW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSB0aGUgb2ZmbG9h
ZCBvbg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBdXJlbGllbiBBcHRlbDxhYXB0ZWxAbnZpZGlhLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbnNtYWxpbkBudmlkaWEuY29tDQo+IFJldmll
d2VkLWJ5OiBEYW5pZWwgV2FnbmVyPGR3YWduZXJAc3VzZS5kZT4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQo=
