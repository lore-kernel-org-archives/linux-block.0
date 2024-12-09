Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DE215045
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728788; cv=fail; b=TACVylrNzZn0/7Yfp2yjlwNcsLdfePbkn3+3h2Eh+ngacCbiyAix3gzZ0kP580Tn5EMe9ZjT9HH7sVoAyLackY296v6Bg2mT8EjeW0ua1P6CGmqK9CY4Yqc2c+f/t/h1wyFr3WiT1LMpONRLhZds91I5LSaAqiWtE87RRSAbIds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728788; c=relaxed/simple;
	bh=5M3vyhJWyveCAA8FQX6nw6r2ARcMXmqtyZokVHTooSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hfwu6TfhZOc3VoPCQnk17hLFQtEEAQS/V3IsGSQ+CehILWitSz3S8b0uyRVEXnkwvYUoeG5ZvHNYxArPO1oz7DRadgKmekgcNqB/9G7QPCXd2bWHyMbpDFAe+oK6+rx37/5hoViY7EZzajM7JxaBFxTYMQBF98cZnJb2U705UZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcmOnXMS; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcmOnXMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPXUqxIg1eFDnTt8lr3Ek+ni21z0A6efLa9iAtkNiVN6jEJwx/Cg7wiEBn6ax43TeKadzX8nxHqWYUEEpV78uM5Oyw3GDGuDUCqynPQktCI5tMIOF8yVg6NbBTadVah6WhCmI6R+Daym9eUpYtM77eIB1FByMTBA5v2sMtE7Lqa+UR48ch9RDw18RvxB+k+IABSbduoINdsic9cZfZ+vr2/BSGMPntgJMbTULzHVV0C9OoAAUsnbnJmCgCDT0LacB0/ZKnkOXYW+vlcj3PJPUkZLKuggi/73iDPQ7U8RsPFX6xDft/N3TTIFDe158nbhqYCOV1J3Wp3e+ylW3xuhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M3vyhJWyveCAA8FQX6nw6r2ARcMXmqtyZokVHTooSE=;
 b=brjNA9sVMTkhqL96UW8ecbSfMa6dU+nfPSGlfHeYpHgvtYbiF/ELUCJQLZdUqN/PqEhZalWwBqKg/bQpRWq3OsY21Xe2JuvFWzB/+dBwOpqYqk2BnY9vr2ow08c4ppaPlLjtD2yISkn3Auk9JQ00N7HKqlS9LaXoSfRhRADzhiZNytpLMh9HP1cjsNeTcp9WeHzphaOi1ihRXwNMnB5do6u9A0RCnX7egXUT/EQer6nCCAz8f4AmN319VLE1VcxYa4Fdy5wFJC8grzqcuk3YAniH43if+EmDX1ccJc50BT/j0JQbNRnG3jQi4ONmr+vK4tuahgOrSpR5L9BQ58Ji3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M3vyhJWyveCAA8FQX6nw6r2ARcMXmqtyZokVHTooSE=;
 b=tcmOnXMSFSCIMFnRBj/KMgi2YplY8IarjPU1LDVY9ezS9r2DzXrQ3UvkcRBZuMOGA9Rh4C2AjZW/jFmzF3Y7QFNnpORGXLEBu9tYiTUCs66p1nQfleYjauyQm6fVsOvnw5zf4c+6Yj3ggbSbIfb0aEp2IGiumA84cFa8m23qDwAL42yIppI3KxUgHPN5GUSmun5qGJHa7oujClQlJsnQGnBBrhw1hBuAlaFnXCIuUzwvZr61hJhN2xwPb18ULb6MhbTGQUqIZ+/2FsLetQjAiJ7/syeGaAQEulWe5e5HBpe7MzJIEwbzcSU9O84jAaJvNHGTam3tRKAwo3jhG5fb4w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:19:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:19:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 2/5] common/nvme: add digest options to
 __nvme_connect_subsys()
Thread-Topic: [PATCH blktests v5 2/5] common/nvme: add digest options to
 __nvme_connect_subsys()
Thread-Index: AQHbR+X96mPPQYfv2kKl/yko5Pmj67LdhaOA
Date: Mon, 9 Dec 2024 07:19:44 +0000
Message-ID: <dd7a12ad-f8ab-4b02-8baa-27a43603a32c@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-3-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-3-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: 7d045f00-9002-42d9-67e0-08dd1821daeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnN2RDE2YWQrQnJ5NG1UaWlIM0piODRuWFJEUDFMNXFqLzFPV1JZUVdsZVdT?=
 =?utf-8?B?dis1cVV5UkNleUhyeXJLaEFWMHU4aXM2V2kyV3ZKeisxRXVzN1hQZDMwSUk1?=
 =?utf-8?B?dUhGdFJhSXFiRVQ3YUtUUVJjNTRFUjRDaXBUd3B0RFVMdzhrc0NFWEh1K241?=
 =?utf-8?B?am5nR2FKdUJkdmk0cW1uWlNsbmlCUEV3WVpTb1hkMFY1VytrNzhZcjhwdjFt?=
 =?utf-8?B?SE1hb2pxNEZlSjNxSzhaNHE1Yk4vZ00rbXVUazFJZEF2ay9pMkhKWkwyM21i?=
 =?utf-8?B?aWRSc3Y0dlVPTTdoSjgyTnhYSDdYVnBmL1FBWkZSNW9tTWo0VzQvM2FyUHYw?=
 =?utf-8?B?d0lJUktxb0x4bVdBaEJDTC9lMyt6Q2czTENVNTlBd3BycG5Oa0I1RDd4dnBh?=
 =?utf-8?B?Rm81UTd3Wlp0eEp6YlZPeVNOcUhlakJrN3oyS0dlcUExUjN2NDdsVE5uSkRQ?=
 =?utf-8?B?MkJwNm04di9scFBkUzBGRHlKMWhWT1J2cy9jY21HOGtOemRPSlpMN01Sc3ZL?=
 =?utf-8?B?STdoTXUxTUJmWkdFRkQvSnlZZzUwOG1xdzRqb1dLeVVlclRYQ0RZd0xKSFZD?=
 =?utf-8?B?TVFqdkZrMUIxN2RwM1pndVFINE4zOHlaZWFSclYzdUdGaFkzMWRTcTA0amlD?=
 =?utf-8?B?NnhrNEhENnhkWHpaeSs2LzFaV1dHVHBmYWVMNGw2ZmQzV2dhSFYzeGZ3aDU0?=
 =?utf-8?B?dVp5NGdnVkRNMi9IVkxsRVJycGVCUnpuS3FvV1dkRWs5ZFZNektaTm5SWDNG?=
 =?utf-8?B?Um1NV2htcHVINllwWHVLL2FLUC9Hajh6MG5HQWFZdjBQQjRMYzRCMjYzR2U3?=
 =?utf-8?B?eFdFeXRDa0lrcFZkRmhKM1Q3UVdsS1N6U09Xa3VncG1CS0NsZWVPQTlwRERs?=
 =?utf-8?B?c2lwUmdZOGhULy9lL09QZkJKTGdDUFRwdU80aWVKTEliZU9PV1RNa0NpQnRG?=
 =?utf-8?B?Nnlka0ozSjZ4eXVPV3FodTJoY0hXMms1WnFVVTF6YzJQc1NVeTlWTnV1YUNM?=
 =?utf-8?B?K1J6Z0VQUTFmelBKZTM2WnJWTDNieFVpVFBlTkU0dDdFamVGUHN0SEMzWXlw?=
 =?utf-8?B?aUJ0UFk4WkZDUTBQSUlSYkFvSDJEc2k0cG9TcjMvdkdwTFVOYTBCL2dLbnBi?=
 =?utf-8?B?RllKZ2xJSkJ6WkFDYzhhRnNWQ3VTVXBXWUdqKzdRRGNJRk5sWGZ5OGJKdE5a?=
 =?utf-8?B?U2tFaHdsRHYrUG50SWNlRGJrRGhxRyswTWNLUzdsQk8vY2VSdlE0V2tWenJ1?=
 =?utf-8?B?a2hxVjVMNTdVRkRWOE5sQ2Y5VGtwQ2EzeW5COWtmZ3VZNWpNVGI1MFpFR1Rh?=
 =?utf-8?B?ZWRrb0F6OHI1OCt4Wm84UzZlUktqemJqZVdEajkxQWIzR2d2YWNuVmoyTkxu?=
 =?utf-8?B?aDJJQktUckR0U0diQzNjWVJPWWkxS0txQ2kwS1lxUy9hUnQwbFRMQlA4Zzl4?=
 =?utf-8?B?MUlqQ29URldpczRrWEhWdlo2cFZYaHRRcDA5eU5RaXlPOGxESHpFN0RrOW5u?=
 =?utf-8?B?bG85dkszeVE0em1qOGxpZmFydzMxakYvY28vaUI0WkVkaUt2ZVNpd0ZBS3hS?=
 =?utf-8?B?akh2THdzK24vMVNJVFZYSWkvTmoxbEkvWVcrRkR2T2FoNWZzaFc2d0tZdjRj?=
 =?utf-8?B?QUVOUG92YVQrcXNQTDAyQllpNi9FVU9xaTllMkExTnFnbEFyUjQ1cU1obUNp?=
 =?utf-8?B?eU9HcDczVFBXakp2WTh1Q3RTYVhJWlRscVFSd3A5ZmZ0REU5eGc4S2grZTE1?=
 =?utf-8?B?OHBTZjllblNrNVdHOEhVU3dGTzRub1ljNHJkamFFZ1hldlpPWkJSSGQ3OWd5?=
 =?utf-8?B?T3BIeE1Rb3lSeklSZEI4U05RZVRnZFpkMUNBY1ZzQXZzWTA5anAraGdONDNK?=
 =?utf-8?B?QkRmNTB4OXdJL01LOWplY2lMdlZOQUx0Si9MZklRb1R0cVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0hpMnZBU1FWQnpuV2Rrd21vcHQrRnpCeXlKYmREUnBaY2xyUi9RSmN3U1JS?=
 =?utf-8?B?bTZmSzV0cGk0Mk5pTVVRYmN0TjVwVnE0emJna3F2N0hFSUFFcUpVVUR1U3RS?=
 =?utf-8?B?SU1ZczlOSmZad1dja2wvWGZ4Wk9RdDlUL2FLWXdxaUZjUnNGUzUxNjU2WnJR?=
 =?utf-8?B?UWZnWnl3RVBPWDVXY2V3Yi8zcVQyZ1hUVFMveEo2enE0NGhsZ1FKM0h6RGtp?=
 =?utf-8?B?aFpNNEltOFJDam5jd0ltOVVYem9aMVg1TVN4ZnpmdkIxUUpSSndCRkZ4bmJ0?=
 =?utf-8?B?TkM3b05uOXdQM1hMR0QyWG5LU2VBU1ZDZVR1QjBucmh0SjZsSVFkdkY1b3lP?=
 =?utf-8?B?Q0xDQU5ETHdzcDJTeFQ3SmJpUzFGRVRZSzlYbTcvSVBqL2Y0TUdTY1Q2Wkh2?=
 =?utf-8?B?ckE4RWNxOFgxNU5PdXJXRitSZjlkUzZ4Yzg5QTVVMHhrQ1A0Y21vMlFQOWRR?=
 =?utf-8?B?cU4wYitmQ05iYnFnWUVsTnl2K3REVXFzanpiTDdxcUJockR1RHZUc1RpaDk3?=
 =?utf-8?B?d2xJb2hMa0lyRitkOU5SNnZvR1QwR3NuZkVXSmVnYnpwMUgxSXlrVjZ3ZFNz?=
 =?utf-8?B?MDQ2NHFSdXRvTHNXaGk3TVErdDJMM29YVWhhdGEwaFJiWDJUdzM4bGx0WXhw?=
 =?utf-8?B?SVdwNWlPa2xlTEZFTUJ5Z0RnWElsNUZISWNJaW83ODRSbEpnMkZ4NXQva3lO?=
 =?utf-8?B?OTlkbldBNVpTaWRYeHNkNHRCTFhZR05JUXFDUlo3cnhGb0FwSUZDa1NHWWZB?=
 =?utf-8?B?bFFJQzJTYkR1VlQ3aWZEdzBxVStuYXJZaGJvV1dPMjgyNm5LRDVEdkZXQVor?=
 =?utf-8?B?Z0RiUDJmYXBETVR4dmt2M1ZPUzNYMFZ3eXA0cnVHUXdPcVo1TDNZNEt3enp6?=
 =?utf-8?B?SHdkRkVZRnkyeGNPcEpFTUFsZjhvK3ZjYkxISkRLS25CQ1U3U0p0UkVkcGZt?=
 =?utf-8?B?MVJDQXd0RDhnckkyVEFpbWFrTm5nVmVMYVpHaTN4UkRtR3RjbUdBVTYwNjFI?=
 =?utf-8?B?R3lQcDh0K1ZKNmVxaUpVQ242UDF1TU13c3JkNmg0UzlxMXkwQjdTM3JvZG1s?=
 =?utf-8?B?WWpmMUlGcHRFLzlEbXBQbmtCQXhxS09Qc0pXbGtTSzU4RkNla2RPRnhpaGNE?=
 =?utf-8?B?Wmx4MmQ2MlJGODBKUWxwTGlybVB0UHFKWmJteUwwOXFoMFpYV1BSMExZTjJN?=
 =?utf-8?B?NE1iRjlhVEc5bllITFpKL2d4Ky9kQnp0NHFodlJCWlhaM3ZBV2NDY05SRkNE?=
 =?utf-8?B?dzk4MHBUa083MldUSTRnakpqcEZhQ3FMR3lDdGpXZGIzdEtGNXZZcEVxUlRN?=
 =?utf-8?B?R0QyZkh2MEJSc0NFbWkrT0VCbDhPR1VVN0l5YldtaS8vOFJmYzF3RDk2RkdE?=
 =?utf-8?B?RUliSHdiUnJvQ1pLWUdzWlI0QXZrd0NOVk5qNHFKS0ZQZ2tabDhGYmQwNnh5?=
 =?utf-8?B?OTlXekRvNUZENnBHdXM3UnMrN21iSEIxUFdNOXN1NUs1d3ZrZDQ0RmlWUk1Q?=
 =?utf-8?B?eEtVZnA5elJUMzE3b0JoQU5YTkpHNUs5WFgzZnFibXZPNmRlYmpLN2l1ZmZN?=
 =?utf-8?B?K2ZBT1pzS0orMmdmOHBNaXRrcHEyTDZlRmVwQ1h5ZmlZMjd5WDJ2aE5TaHli?=
 =?utf-8?B?R0V2R05yeVJmNFF6M016cDRmY2h3SHRGdWZSc0hFaWQ4cWxCMGlmZCtWZjhU?=
 =?utf-8?B?bXNveUFra1IxbDYrZGVWNU84QkdnU1RaR205QVdROXk2UmJuRFlnWnpCRWRm?=
 =?utf-8?B?RlVIL3JPZys3QjVWekVobms1RVBNZFg4VXV3TnN0ZXpDYWZjZkttVGduZUU2?=
 =?utf-8?B?RHUvTDIzRFZCY044WTJDZ2UrNjFYbEJMeXBQNkNoMCt5K0MwODVHdVpmeGxS?=
 =?utf-8?B?WEFpd3ZrdFpXWjJZRmdrcFZsY3UwZWN4dlFlUDQramtRbmZoZHRXbCtFR2pE?=
 =?utf-8?B?WGFxZkxKWHpzM3JiYmVTZXNKN2F3czFBWVhYSDJiZkRCb0xHcWF2V25UdGZY?=
 =?utf-8?B?b256YWJVdDhrZFFiK1BOQ3ZxN2QzbWJJMmM0ZXpuMTJBU1ZRVVY0aDNlam5E?=
 =?utf-8?B?d21uZndxN3JTNVJkM1UwVGlMVTk3YjNDRHlNNUlxYmxkSU1PV0xTL1lMa0RK?=
 =?utf-8?B?dmhRd1BmekxFdzF4bUc1UnBGTFNuN0d6K0c1d1BkWXQ0R3hPWTIwYlpvMk5M?=
 =?utf-8?Q?KTo9owUb58B3rFI3NMFiQcY58qhnHFMa6N9tUeNzANAi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBC15B95F2E06F41AB96DA83F9B2E42F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d045f00-9002-42d9-67e0-08dd1821daeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:19:44.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EX5y+L3lzVr73pcbhxO2FPDOTIpB+//RhHoDExLyT/CnkSqLzihe3vydod4t3BWOYwT6hpiwrGHFy2h1/CP5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

T24gMTIvNi8yNCAwNTo1MSwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IFRoaXMgY29tbWl0IGxl
dHMgdGVzdHMgY29ubmVjdCBudm1lIHN1YnN5c3RlbXMgd2l0aCBkYXRhIGFuZCBoZWFkZXINCj4g
ZGlnZXN0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBdXJlbGllbiBBcHRlbDxhYXB0ZWxAbnZpZGlh
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBXYWduZXI8ZHdhZ25lckBzdXNlLmRlPg0KPiAt
LS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
