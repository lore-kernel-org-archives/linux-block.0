Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4349757EA
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838116; cv=fail; b=OCdRxFmuiB9tnLeJiSahx4mwQ+6WQW9qbpMwCCXe8sEJRoPMbaNiWDkP89v8EBhcwbp0Pv89lgWpOBI1DjIdNcYrgdk+1k0RGypb2aRWMvAcjkGJgku4CpckrDpArQgmHs+Y7vVoCQAWcKQ3teFkJN1GLol/25mzJIya5wNimaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838116; c=relaxed/simple;
	bh=MeZ3e+/HCS3jLYDb/reDkaO8cfMKOpqHAIQHayzfcDk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dunM2KGNT0JacfTz/7kotfkjOw2vyqY+r/IJCHtatU3Zpx4QSbCFc70x94LwRSzj4tKo3HZxEXqgQO2Nh8h7aUN/4V9in7Braadxs0mmgbcik1JWE3S3iUFtl57cVULosEMHYNu1TM6twxGktd6g2qh2S2u4iIJEXqH3QrPNqM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KELbz3cI; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KELbz3cI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpcLsGvXhj0lKAkCLoJAEUV034m3VMDILfQaat1/BdeUUIRBdP9dS8zs0a1HHWrYP2HnYlZCRnlJ1ADFcohH/z76nWiF3v+U6TEFcSRervqWSgDD9eOVhK+8XixVo3r32l7qnFD+egIOlYslcMbCax1dIS6Ldx7quOzvnqArDtIMnqw9w45/UYzJ12ooo7Ro/wz3/81wiC7FCMP/NZV2rQiH8MuTju+F8yZvrki18aH6oPKD/Fvx9t527cpizw4s07iOVGnGfGmHz4T/CTcyiJknergfx2d1hI/4Od8RUR1AW7ucNZZWdDpYXeMinTWqHWPkZyV+WlDWo3EkQ0TyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeZ3e+/HCS3jLYDb/reDkaO8cfMKOpqHAIQHayzfcDk=;
 b=fhYBOtjQgRj6jAZ7j0ipPl3oIEhw+0tWWGoDA9Olnc7iGG9Gvwyv3wMoWmXSWt+2kQqEiMSzEy9Wf1z+0fY5M8JsvdUoNseD1zd09F95GyjNufhx13mWsXXJ+Qguhp5kkzaOaoRjxk2jAVSU3kyM/3+lDBPAkEFWK+PCfXVHrOMgPxVZx205aXq5XAe6iLplSPZuBO2k+P8UeqqSxMiGZEuiIBDL0tbjgvHYmFLa8U61Gcb7ufbvgZIM90f5zsMasT7G7+6uwCnfCInVAosPtCjzanr1rJrc9UT+hryRBL55YFSdAT7zBKV/ALBFwXe0zWW1qIlZ5w3ujtg9UnNSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeZ3e+/HCS3jLYDb/reDkaO8cfMKOpqHAIQHayzfcDk=;
 b=KELbz3cIjLQ7UwroWlAYXPloRq0fPAsEjCyBebJhOXLmoRg5rqb6m3x1tpYPd1K0KI9ER3+N7rR2eJwmns4yLI7G1uCK35G0gSeSgQzU0DBzLDoCTg0BXyv2ncCXSHESSJiKthFtFdDOgSUvNwfDCbrEfm6UMSFcQwsipWb+uAVcDBbhoYaAWNJBi5ElFQupEx0OUP42/5uY82K4ooeKKOLEr7+dmQElFNYs0qFDA+6/ner6lqYvqVj9Emsl5cqs0lqmoydF/xbSdiexSZ1yGP0Zqs7/mbd4r3HULt2wxp1ShHPD0FbcHTqXsKyooXe1S59KtC4yWE8Z4CU2u/vhfA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 02:08:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:08:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: improve blk_op_str() comment
Thread-Topic: [PATCH 2/2] block: improve blk_op_str() comment
Thread-Index: AQHcftrpbgvaI0I8OUeSNO3AWE9LAbVHiamA
Date: Thu, 8 Jan 2026 02:08:31 +0000
Message-ID: <14d53599-1f41-4e60-8a48-8ba3d2e4e6e6@nvidia.com>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
 <20260106070057.1364551-3-dlemoal@kernel.org>
In-Reply-To: <20260106070057.1364551-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: f1c17d81-47df-422a-382d-08de4e5ad28c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUJHVGI5bmtIUmQ4c1diWXI0OFBWeFdVVEt5VnJmcFRYOENxRmNLbFdLa2FQ?=
 =?utf-8?B?MFEydFBvQjFNTUtkMTdDOXpYa2FObUhXSWZOVTFRSnNFSnBlRnNrekxvOHJU?=
 =?utf-8?B?akcwVG9qWVl4TnRVUDA0ZHhXdWlJOU5sTkdyemVZK1AyVTIvQk4yOGwxT0th?=
 =?utf-8?B?OVc2a0ZIcGRxamNnODk0ZVBuNE5zUklTRHdhVTgvK1MxQmZFTkhmRU52SDV3?=
 =?utf-8?B?cTV2M1o2Ri9CdmpNQXdyRFZpSTRocHdQaVJOMmlNd2Y5N0ppSVZGWHozRkxT?=
 =?utf-8?B?ZFRvVVQwS1lkbjVhajk4V3RnUEwwZCtvRit4OXh5SkhsRHhHb1Fwc1NBZnl3?=
 =?utf-8?B?cXdtdGlRNUVvbExZTGxjTmoyVU93Nkx6b3NDZlFlcVorZkdQZEZSV3Vud1FS?=
 =?utf-8?B?dVRXNUswRnpHaDVKTHZ0SDFFQ042RzdxT1I3R2tOOUVMZjArWi9hOXZ0Zzg2?=
 =?utf-8?B?bXZmYitqVlFqV243K01XVkJxVmk2MzFKdjI4YTUrcVJWZ29aNVk2TElFdVEz?=
 =?utf-8?B?Wmc5VkpvaTAxYnlVdG50T2JidmhoUEhVSkFFOHNWOEtSTTJSVUUwd3Z0YTFR?=
 =?utf-8?B?dzd4RGJWWW9vVTIxa2F2bUJFc1liSlNpL3ZCeGhnYkVFbFdOOGhsYys5dG1R?=
 =?utf-8?B?cHFsK2lLc0tDMTBFZHZXWnpFN25YNHRpL2FGODVEMzVOZlZvb0JIemNKTFRy?=
 =?utf-8?B?SFlHbFhmMEtDYUxHKzZsdWkzazU4ZU1oU0dpcUtqcjRKVmUzY3RMWkRST1NC?=
 =?utf-8?B?WngzYWNvMEpiS3lNOUNUSHJJT2Q1Q0Y2cUVmQlhkSDVzbXRJYmdacTNHMk0x?=
 =?utf-8?B?K1hmbUZpZVVTMWtyNWI0ZFQzTGkrcVFiY213dmZjS245OHF3bHljeDNyODZX?=
 =?utf-8?B?MlFrTEg5Rlg1Y3RvdGM3Qkh4ZnNIK2lRUEt3YjlhTWlVYnpSYmYrRzhrMkhH?=
 =?utf-8?B?SnhKUTFDdm1OcHNuQ1pkZ3NtYmpSMUgzZEkzOTNKRURSZ3JVY25HZ2J4a0t2?=
 =?utf-8?B?WGYvOFFmL0t5bXQ1YjJkbEF3aUR4NVdwNnNZTStHUnBMT0FtZHVDODdINkNz?=
 =?utf-8?B?ZWNTcElMcnpLR1Q4OXhlUXNZK0FqeXJjdnpDTHFaNms4SkxFZGxGNHd1a2gx?=
 =?utf-8?B?WklyTVEzb3FYdXBFTVVVVzNnWDZuRFFQS0tFaTBrM2s5Sm92YzBHSHhwN1dJ?=
 =?utf-8?B?U1h2bzU3ak5vaDI1TjFRQTdXVklQeGZIdUlzZnlCS1B3cDVRK1Jocm05dzcv?=
 =?utf-8?B?M092QkRCR1QvVzBEVTNyeDFaWmNXWEF0UUppREpuM3JnbmdLL0wxN09KY3hz?=
 =?utf-8?B?MXA0UnIxWXdpSDdMaHpBK29NcGljdGM1ZUQ0SCtMcWNKeWM1YXBQYVo5d1Ey?=
 =?utf-8?B?eVBYVHFHM001NWhEeVRUV3BiazgzN1A0UlBoL3lYL29zSytPZEZNUDJMWVI2?=
 =?utf-8?B?ZVhZVGY4bkw0SDJ1NFZ5WDlIcmRXcWttOVMwdUF2Y2ZJWE9wWkpVQ1FxMmZz?=
 =?utf-8?B?NFBQUGZOclVyb09CQy84aU1JaEFXSElUMzFJQmxGSjV6bC9mSnBrQk8yYnN4?=
 =?utf-8?B?djJZaWkxVmprM1BxUERyZVVPSjB4MEVzQjBVNGZsWGU3anhaUTlWRlhvUHZ3?=
 =?utf-8?B?c3pmQjBMYytVcWhPdWRMa2RGNHBocWdKZWJwQjNndmFEQ1FaWnFrUk9panpz?=
 =?utf-8?B?TytXRmR1akRxcmxSWHNzbG5KVVV3VUtrbXhCdExPRXMwcGQ2aVpZK1A3eUZt?=
 =?utf-8?B?UFdHZVl0OFE1b0tJMExMNTU4WnpxTkVwU0tEYVJ1dzNMSzFsbkw3SnZmY1ZV?=
 =?utf-8?B?enFyOEhCMVkzdFA3Y0xkNG9lbE5lMnUrU0srT1U1ZXZDOGx0WFRacjEvb0VO?=
 =?utf-8?B?UGR3RC8vbk1WTndMN01IdGFmNTQ2U2FiUVlyQ0sycGoxeTd6QndIZWo4V05T?=
 =?utf-8?B?M292V2NCWk9iTWdvZW1vemIyaVp1Tys4cTZia0NuZmFrQmZOcjlnVjVWRmVj?=
 =?utf-8?B?NmpITjFTYVdKcU43YmU2YU1vTjdjWnUyb043MW5xYlM2UmJLNGVVMHBVVlY3?=
 =?utf-8?Q?fyLiwh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnpMQTR2MVpSUjlJNjY3OWlDN2tPUUl4L3NDQ0dIZTk2NjNiKzFvd29lS3JB?=
 =?utf-8?B?TERBVFdnUU9EUWhsM1NQQWRabEZyL0xRdWo4Nk01VEtkcm5vTm1SSG9zdHJN?=
 =?utf-8?B?ZDJvT1pSMkdQa0w5cE1yNnNOSW9LQ3NPYUQ3LzZPZzBJc1p4eFcraFVQcjdu?=
 =?utf-8?B?TXArbjJudGIvczgyUEUrc1RDeFdUbXdFaDY3cGhLODlRMEVFUkdud2ZnVXIw?=
 =?utf-8?B?TWVSREk1S2hJOXJpWko5ZDI4a2lLUlQ1V3poOVBwOWlET0lmMmRoQTFuR1NL?=
 =?utf-8?B?NUE3WXdLYjB4WDVsVDV1aEJWK0FhcUNhelljdFdKdXU2WnpwczVNa3lXKzAr?=
 =?utf-8?B?TzBzc2VpSy9LaVpKR0tpeVEwOURBTHBlZlMwMTg3aXVtVjhtTmY0ZldML2pR?=
 =?utf-8?B?SldIbnNoNmN3MVRQNGtLQlpQa0xMOTlKTEtoK2ljc2VIWit5MGZUelBmZkdw?=
 =?utf-8?B?UGlKT1NxcG5BZ3RjQ3E5R01xQXlkSUNkd2tMRWdJRE82SmpwdFE4K1l5bkxQ?=
 =?utf-8?B?cjR4TEF5akNuMFdQRDRWRE91TE5VVG9pVmNYYlRBN1pjSU9sVHBRL09wYlpi?=
 =?utf-8?B?MlBTUHc1dDNVYjRiWDBjb3JTME9FMWtMQnFBbHVLbHdlSWRHcFYxdEZtNkdZ?=
 =?utf-8?B?SkQvU1JURUpDNE4yQmZ3QzIxM0h2TlRGYlBaUDJZWlFyTGM3UEFHanlmSUtP?=
 =?utf-8?B?NjNBMlkxN3RnL1VuL1orM1J3eVJpWThxUktFY2dmZlRIdUVXZHp6ejNhZXEw?=
 =?utf-8?B?M3ZqWG9xK3RObnFkWXJERER6UDRob3l5ZXNKQ05NUXdod1JPQzkyTGt1Zk9B?=
 =?utf-8?B?WXRSUjVSZnVkVkNWREw5MDF2ZHh4dmdDV1JSUUdtN1FLdWhKZXVrWFZmc0c1?=
 =?utf-8?B?QTl5VnExcTJGT3FCd2lFTjdvVEkwS0t6VWlpTmUvRVRxK1lLcEpMY1dIL0RD?=
 =?utf-8?B?ZzFpcTR5MmY3aSt5UFp4Z0lIMzZUTTczWGlzZUZzcXlpTnlsQVY3MVMwQmlr?=
 =?utf-8?B?TCtsSnRRemMwL0V0QjVwckNlZG9qT1QzR0QzTU9MQmJVNE5sOWZJUGJsbnYx?=
 =?utf-8?B?eEVZSzF4d2JWcEdkNDU3LzAvcnBoZkM5cnlzREdaekoyYWZrZDMycXhtcGpn?=
 =?utf-8?B?dUZxSzMyMEJ0NUt1WnpnUDhob0NpWUt6all1U0RlT08zS0tqNU16NGZhZXkr?=
 =?utf-8?B?dDN3Um4yYjh0c2FvVkpIaWVGUDJXR2NWdFpneUQ4SWQwYVpsZVdRQXR0bmhH?=
 =?utf-8?B?cFV5VzdkOFE4QzBXZEh6eFBLNEdjbW9zVXF3NDcybENtdnhGc0ptb0VsMTJ3?=
 =?utf-8?B?TVVjaHZjd2puOUxyWlFibmdzaWtYYnFOMVRmenBUdlRtb3BjVTAyRFBubC8x?=
 =?utf-8?B?bDhKNU1CYlRJeXA2MHYweUNsODdUN25YZEtyQWdIdnk4TXZzb1loR3BDRjI5?=
 =?utf-8?B?MVQ1U3FsZkJtVnBIQ1pXNko4SStZa1o0VlIyQllZNFlDQUMvSWVuYzA5SHVE?=
 =?utf-8?B?NmJIN05kZnZWc3M2WS9RWEhIeFdCeFR1dU9aY3JiUU9tNlBDaDJRWmhweTdZ?=
 =?utf-8?B?Vk54ZTM2WXc5ZDBPT05VNys1NzVDcDRuVkpGeGVvanRBVElCZjlidnNsejAz?=
 =?utf-8?B?OFkvbnNjaEQ3RmpLSXR4YWJOUFRwUXdrUE5XUHdtWG40Y2QyQWpjRFdKaWxQ?=
 =?utf-8?B?SkFRN09sZFBMUEk4bWdBeVdqTFM1em9HclR1SklXa1pHbnNnQm51L0lSbHpE?=
 =?utf-8?B?amNYblRVT3FoOWk0OEdrWDN4YzNzbVFqYlEyc0ErQTZDbW5saWRkcWpmMkZQ?=
 =?utf-8?B?azAwQU41b1JnOXQzdEdVc2lDL21VeWo1SzNHMkM4bHdSZHdOTFUwWEUxa2wr?=
 =?utf-8?B?WnYycDVSOU5FMlVRRTBVVXozRUwzNGlhaCtubWEyL1NpcURNcTJVZUJ3dkxH?=
 =?utf-8?B?TjY1RHVBejh0aXFIYU42YTZ4QWJpNWpSVkI2L2hXaFhlaTFaNHd3Q2Q3UHdr?=
 =?utf-8?B?SWlYNVlmUFlRc29jblRKLzM1ZlRySlgzczZkZTN6b2I2M3NBTTkwWGFEOWlL?=
 =?utf-8?B?YWZ0R1JtSzAzdGdZYVo5TGZuQVA4RDQ5R3hUM2NFQWI4VnZpaCthNHFhWFJh?=
 =?utf-8?B?S3dvdEpYekRBYndjeEEzVVRZMnJ3VFNDK2gzZVpLV3BTVnlYREd5R2ljcDdV?=
 =?utf-8?B?TDRtZmZ4VzZhZm9qMC8yZ0dCbEtEdnBDSVAzb2l2aEN6M3VjanFPY0gxZ2Ju?=
 =?utf-8?B?S3Qwd2g5MURtY0p4S1diSzIwN3BqWG9jTHBja2pURzU1cnJ5VzQwaTNPTmhV?=
 =?utf-8?B?QkhQK1FFU2g4enVBS1RUV1NSb2p6RUxYNGNaZ2hOR2xVdVhKNk9xUFpuRzN1?=
 =?utf-8?Q?HOaZs8VNDAgXozh2uBN/gNh8MvtCB9K9QuTzHrvT3o5IT?=
x-ms-exchange-antispam-messagedata-1: q6+PaowdO0IeBQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B68D0E96AB134849B57D9243003FA24C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c17d81-47df-422a-382d-08de4e5ad28c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 02:08:31.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGluuIBAx+LtAuFYITlf9s1SAQYHy5h9bAlMOHjfOqIbyZrF9xk0f6YZVmPTt9T5/HWTWe7pkIgq3sO2DZbM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

T24gMS81LzI2IDIzOjAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gUmVwbGFjZSBYWFggd2l0
aCB3aGF0IGl0IGFjdHVhbGx5IG1lYW5zLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUg
TW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
