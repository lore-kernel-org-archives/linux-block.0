Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0961E009A
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273459; cv=fail; b=rZliKHO9FU7pPM7n5vlWm6uQgDerCBpyYjLB5MGW1ShAiy2pmwb+I0/fA7T80phW4ygqR7PkFY8djGRgHzUdgyEOZ9x6fqInoLn/gf1YmQjb+13tNXPvmXOhMejpXz+gmmqIjrPwjPbVWU/hPU+uIO/aTnnTCoLzG5g/lz8PkPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273459; c=relaxed/simple;
	bh=70sgOpfWOWakcs7lsUji3cGW940FEuiMM0huxOwu3DA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GHiCVkb4TvltCDsSfQiCfrG2+4cCKGMwQEJkd5C3xNCyQn/df4LezN/3cvD/RSYU1QrRb1070FgzKmRGYzRjhmU8eVL/0X8SQ7A6D6ZHLAqTPiah3GKqSXgm8oboxLxxAo0gDl/kyy+8sVdAgPIqc/0y9OAX8Fq8QUoDXNMFAZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fcmE8hzv; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fcmE8hzv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OETC1FuCRyihT4cUZ5q1wkqlDLuG4bwDYjiPRXkttwb1jqswQgvF0R9c7HnOHncRk2xv2BqWyV6ipAKp3AW1cBvK3n0G7X6raOtP3Dg+07LYSb3i6k/mUoN3y1gCw5yp/pM/LPUMZhhiyqT79DzmWbmilLb3sCThPFvNN/J2akgYc2AmAcpg3U0P8IRsm87GykCoFmDJpC8za1aASTAGiDoAh3P978A59QluNGTOR+yo2WY67KZ90iLm2t/qD9jThiGl9IopMSEUMVl+o7IzClECmmjtMK5r8pnpQlij4dUdF0IBFxr4cDYVsswbYcezaD3pZtLyNoAlOww8UijlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70sgOpfWOWakcs7lsUji3cGW940FEuiMM0huxOwu3DA=;
 b=J+u4wYehGBlLGCeaSyao0MFzNkE11rP1zqjlK2h4EUNGYqn9J4/NSc59/CWbgd457jUADUICXK5v1IGct2ntW6JKJVGzf0h6b0MKleqpSH2JyYP6aiBulifDYY3CJFJ/Tjly0BDEyuAX2e5M5LT3QJ0RWJmH/c/aSdmoqjOYkv0oHTBHPa/MVr1iYe+8ETVlzkB2FninVHxaEuoBIm4II6Ps9MCNWX7hrqiXTDWx8jDkQNvdVrbQScG9ZAnLY5Zyoc+uNaX7AP25b4yn9KpBOuxvh2raU19UPS3eIuX191aYJwOHNugfjOrK6dfbvCnCAFd9OAmgU0vuyaP2WLG57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70sgOpfWOWakcs7lsUji3cGW940FEuiMM0huxOwu3DA=;
 b=fcmE8hzvN45SjtN80VSG7yaGZFKrpPJHIZst2h2ZKr8j9CCSFLuQ7/vlcDlq9XrUFbDPguywhjxzEvfz+pfoe83kXidQuGi81d6czJeOAVhMrQbJSHNkgf0AS0SEpwcl/18OWMwwbxhUUrcqYxl+41q78zriBGBTQnHU2hTH+E7fD+QVTcD32/YG9QJnBGcPe8ovFX963pgUUr0Bjd4em6GVuIwIQdRxG2Ew1zvRvkLrLzGkFgJf8eNl9LdsDBcOyU8XWMhiDcQdcpX1amL6yQ6ouZsfTU67lVBO+kfR7/SfUSRJU2KxVLhWZo9h0l9R92S7sCCmZ89oUAeVZdJocw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:30:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:30:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Kundan Kumar
	<kundan.kumar@samsung.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: remove bio_add_zone_append_page
Thread-Topic: [PATCH 2/2] block: remove bio_add_zone_append_page
Thread-Index: AQHbKotBmkMADGK/BEmVHE4a+yCf+bKe5jAA
Date: Wed, 30 Oct 2024 07:30:49 +0000
Message-ID: <790362cd-dfbb-4ca7-879a-68463156b69a@nvidia.com>
References: <20241030051859.280923-1-hch@lst.de>
 <20241030051859.280923-3-hch@lst.de>
In-Reply-To: <20241030051859.280923-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5948:EE_
x-ms-office365-filtering-correlation-id: 8bce1d41-48fe-4e5c-f185-08dcf8b4c6e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE1iM2hSMDFzVnFOS3V3Q2VhMGFKWlFJK0Z2enBaWlp3Wko1RlFCQ0NPaXdX?=
 =?utf-8?B?ei9DSGd1cENqRHQxVmc4OFFtbjU0RTRmdXozb0xxa2hDZ0llVnNVRy9wVTl5?=
 =?utf-8?B?eDRzRDVBQWoyN011ejhlV3dWQ25hQUxibUZKTm01bEVGT25UOHhCWVFEMEZu?=
 =?utf-8?B?cU81WG9wMktueWhEQ3RvQUVtMnQzZ0JoV3ZTR0dDWlRLcXV3UGViZGlDZ2ov?=
 =?utf-8?B?V2EzN1BXZ3dpL0FWaE5nVGtWSVdlTFVkMkFHUFpacm8xa1ZTSkFHWGxHNGg3?=
 =?utf-8?B?VDVZVEx0bGE1UzVVVGlYQ2Y2S2M5ajJ2Z1N6N3d1WFNNS0lkbFpnb0FZSFBu?=
 =?utf-8?B?MUJyYTZjY21IdklrRTUwYjd1REJYZVVTMGR2dG9KQTZyVlpPeW04Wk9FMDZU?=
 =?utf-8?B?cnRNQnlrWUlIUW80bW5pbVVqMTV0eFRjRDhPb3c2ZVVLTW5lL1ZSOGhQOE45?=
 =?utf-8?B?emVVQ0Fvd2gwTkE4eFN4N3ZBTmJBL0JmR3l3WTRKWVVkMDJmZ2dUM0RnczAv?=
 =?utf-8?B?dDFpZlVwUUlKVDJ0VWxIbnZjcHZlMElpMWNrWUVZcWl6SjBKNVRUcTVSbDB0?=
 =?utf-8?B?cTlzMnlZMm9aQ1lyd3ZwZUFENStIOUdYRDQ5MEp4RlhLRmZPQWNuMTZWOW1D?=
 =?utf-8?B?T3VDc1cxTjhZMXl3aE5QbytwS0FWcXA1K1VHQXNNcUJ2Wm1oaytMeFhjTFdQ?=
 =?utf-8?B?WmVuZVdsbFd4dXJuRWQ3NFRDdUg4Y0hJYyswZStSZVpLSVZETGZJci8wSEJY?=
 =?utf-8?B?Vy9nK3FnVnFmcTZRNGp4TjAxbWF1NVl4RWREQ0hrQVlidDM4TENuSVo4TkEx?=
 =?utf-8?B?bk5lUkZRUGZQUlY5SFVkbUNHRzNxcEFBUGZuSmR3ZGtic1pQM1VSRWRuZXI3?=
 =?utf-8?B?RHd0U3dWRzgremlqSEU1V28xY0xlbWRzbisxS1UzUEdTMDB3TlhYOHF3QzRp?=
 =?utf-8?B?RStvc2FEWFY2WGVvdklacTZzc3FMbDljVW1tM25XdUhhbWJxdTQ1aFdzc0Nt?=
 =?utf-8?B?anlqdkNEWmo0YTRIdDZ0YWorMGhGNWRXVC9pS2EveFBKWi9Kdnd0OVJqUVd6?=
 =?utf-8?B?QXlwT1JVdHYzVi9kNGJ5cjJObEg4OFFTak1pRGUyL1VzWU92SDlCWjZVaFFZ?=
 =?utf-8?B?ZDNsaFk3a2ZoWm5nbGpwNzFvRHhOeDIwQ2lta2VORWZMaFlEZ3VBTldVZHpC?=
 =?utf-8?B?alFJMElGdlZ4cThsQUxRcGdLNGpkZXFQL3ZGWHp3eTVmYVFxODQ3Ulc0akxO?=
 =?utf-8?B?UjEwTkt3VTIyYkRkVHN5ZDVJcVZCUW9jN21vUEVRQXRBUnVyNXFUcTcvSG9u?=
 =?utf-8?B?ZkxuQldUSU5rTlN5TDdPMTZyRWlqdXlyUk9zWGlvMGFUZFJnVnZuK21rNXlx?=
 =?utf-8?B?Qkg3OVBYMlA2ajZsNjJ1akVGTXJDVkNDRU9Zd1pYL1ExVlBWN3dZQ0c4QW9u?=
 =?utf-8?B?aHRjRFhNak5YRUVPbUE4NWM3QkZSSEpTcTl5R2xCRURMRDI2R01vSUVja3Rh?=
 =?utf-8?B?NWRQbjFVV2Z5a1BwS0t1VHhiRmVZOEo4NXYwUTVITEl4M1FUNkoxSFZkOVdn?=
 =?utf-8?B?RUdCS1JnanBEU0lBeFpSalNCOEU2Ti9KOXM3RU5RV2FsS0RzejZqaXBzM0tH?=
 =?utf-8?B?Qy9YK0RjVlRjWjBvLzJlNzFsc2E4cGFGSG9HdXVKMVQvZzE5ZzJicWZPdEVU?=
 =?utf-8?B?OERNK1ZTelNSeC9jN2NFZzFSb0tkUlY3MUVlY1RUS0g3QjZCbDhqWjR2NTBW?=
 =?utf-8?B?b1p6YlZORzBNWWVyUDhHU0F0bzVqUnB6Y0tCSk5zcnhtZzBscklGNGRDQi9j?=
 =?utf-8?Q?ZlABqhL12BnhgUsG4gF7LA5AmWwgAtIbTznq4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHc5NUxZZ2hEL0RXSjdXakVqQ09YZWtJL3RPWlAzVDd5Z0lGS1BOb21LWVcx?=
 =?utf-8?B?UmxHWE9ZUUpUbG0rbHdrNTN4UFFlTkx4cjBvYkhXU01YL1NYM2Z2dWYvaEdQ?=
 =?utf-8?B?aFRjUjVwYnNJZ3I3STNCNnNSY0dHcVZVUXJpSFJxelJ5Y0VlLzFqT2hBVm1w?=
 =?utf-8?B?dWpiN2ltd0N1VWdQK2Y4NGdVRm5rclBuTTFLRE5sRUt5UmJtc2wvcDZZeVJt?=
 =?utf-8?B?cHRJMS96QzU4d2dFQ0dEeDdoUEoreUlnbXZ6eStwM2hLZSszaTAva1I0SkI5?=
 =?utf-8?B?ZzR6N2tMcHZOdDBnSi9jbDE3cU90NW5ZN0FtcDBxd3cyYXFYRTgvR0x2WHQ5?=
 =?utf-8?B?Q3NuWk56UkZTMVlLNWpSTmlhMnF4V29JUFd3Qno3T3luUTZuQVBMRWRyZXFv?=
 =?utf-8?B?Mko0YnJNdXJSYy8zRHgxOUllVlcxOXB4eGpPRytEZ2tMcTU0SGRXT2o1ZExq?=
 =?utf-8?B?L0pLeG5WWWkvQjhCQUIvbzB3TGYyS3JZZWpCR0lwTmN0cm85WDJtL1E0Wkd5?=
 =?utf-8?B?eDcwellEc1FqanNHbnFnZjlTUnF1clN0bll4N2M3SW1GbGJ0M3hpczRnakdD?=
 =?utf-8?B?VzJzc2NPRzdpZVp5RUhlcGkyRDFUYlZDVXRBcUVwdDgzMkFPYTI4NFlJdFR1?=
 =?utf-8?B?eFVZVkpVOS9DR2w2R1FyanczdldZb2N5WHJ3VldqUTNtSk1JM05tZ210RnpY?=
 =?utf-8?B?aTkvTWhjcWhLdXFNdnBqdzByVjZSR1RFQngzMVRHaEFjbjA1dVhQT2lMbk9u?=
 =?utf-8?B?Q2h1TTdkMWNBdXFtTzl1RHFIUTRjMU4xaENrdkFkMzh2THovZkRmUDEwbG1W?=
 =?utf-8?B?blJYcUhaMlhDRXRYTjNON0hpLzljclNPbDVvOEc2VUJlNE9vNTgvRC9ScXBt?=
 =?utf-8?B?dWQ5N2k5elY3ZktsUFBwS1c1VXJESUJLbHdZODhtREdGbE1JeURsek5wZ2pS?=
 =?utf-8?B?eE9IZWJxQnhoTG0wVjZ5NE9GWWJlazJLaTRjYXRVczVvMVUyeGhLRHhkTWdn?=
 =?utf-8?B?Rk0walBvNmVqam1vRFZnZFhOdzRlektmRE1Wa1hBTGxLZzlINVZSREFlMWtH?=
 =?utf-8?B?bzBaTEQyTXI2TlpaRVdTeGdVV0dTN2ZaLzVneTZWSXZxVEVjWnY2SkRlNW0y?=
 =?utf-8?B?NnFUV1lCTHYzbnRhZmVETVVIRTZGRjUwbHpYR1RIRkdWUzhoYklMSmM5RjE1?=
 =?utf-8?B?TE90VXMwcEZyd2R6ZFBCbVYwL21IWDlvWjA2Y1JnVnBKQXhqeVExOHFHYWlm?=
 =?utf-8?B?OXoyN29YSzZHVzh0RG8zWWQ4cDJkcTlGRTdUaHlpcXZ1dHQ0MWhaSU9iSkNI?=
 =?utf-8?B?MWU5ZEI0eXJrUlE1NWE0M0dGMFhQWHc5cDJXanNkVmZRNzNzVUxKdE5zdjlr?=
 =?utf-8?B?UnJYbVJ4SE92a0J0ckttaWRnL1E0bUVoNmxUYWY0Ym9pUGJFZmhKaFV3Vy9P?=
 =?utf-8?B?YVdLNSt0Wm9zbU4wRzROTmR1N1lsTmg2MDZteXdQcjBMdHFsYzZiK3lKMWh3?=
 =?utf-8?B?N2FTZWdhYy9PMjd4c0tmQ2h4MmZ6eFJpWHhBZFZRR1pwK0hacCt4dVBzcmJn?=
 =?utf-8?B?WlVlczg2NzBjYlh6dllNZE1Uam53dXlKS29UK1UwMDZiMTJSVFE1aUp0Q2cy?=
 =?utf-8?B?b28yOXJwTEdHWi9xTGFpVnFKYXRJYWdrTUgvbU0rNGFoVHhDUEM2aXkvU0M2?=
 =?utf-8?B?SloxSFF2dE9RVzRQS1g2NmF1dGhLUllCS1pDa2d4RkhpK3F3M094c0svZ21I?=
 =?utf-8?B?S1RyRmtGZmdubEVjT3R3SXE5VS9MbWt3eWptbG1LS3V6ZG9nWCszTVVDL2tw?=
 =?utf-8?B?MXVaZGNyVGt2ZTMrWnhZT2xHc01DRGkwTlJUZE1qb29GSFFPejBLNU5MRE1h?=
 =?utf-8?B?dEVNM29jNnI0SnlMQmgrejB4WnMrVG13Yjg2Tnh0UzhYVVp1cmJtcDBOd2pZ?=
 =?utf-8?B?djlMOVVpV1JUZkExb1RneE1OTGh1eG5jWEIwKzMxT0J0ZkZoTjFRODhySkFD?=
 =?utf-8?B?Vk9JazQzSEp4b3o4MDUwRWdJKzhHelZnMkl1TlgyT2c4UE1HZ3M5anZpVGxI?=
 =?utf-8?B?SzE5S0l3aWZOMjNrdVFuMmdqS09kTU9scU9LYXpWN21kYUcya0ZKQlMra3RN?=
 =?utf-8?Q?mZlZMibyF1bAnV4cIGahXgrla?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAB8449947E2B2419B658C9EABF9BA17@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce1d41-48fe-4e5c-f185-08dcf8b4c6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:30:49.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KYdvTw6iNSKkJDhAvwzwid4L9NkLsRjtm1jvY/NiYEwp+RnVLq9f65B8Pg4YbLp/iUkkY5Msy0ptUHLV/lpvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

T24gMTAvMjkvMjQgMjI6MTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGlzIGlzIG9u
bHkgdXNlZCBieSB0aGUgbnZtZXQgem5zIHBhc3N0aHJvdWdoIGNvZGUsIHdoaWNoIGNhbiB0cml2
aWFsbHkNCj4ganVzdCB1c2UgYmlvX2FkZF9wY19wYWdlIGFuZCBkbyB0aGUgc2FuaXR5IGNoZWNr
IGZvciB0aGUgbWF4IHpvbmUgYXBwZW5kDQo+IGxpbWl0IGl0c2VsZi4NCj4NCj4gQWxsIGZ1dHVy
ZSB6b25lZCBmaWxlIHN5c3RlbXMgc2hvdWxkIGZvbGxvdyB0aGUgYnRyZnMgbGVhZCBhbmQgbGV0
IHRoZQ0KPiB1cHBlciBsYXllcnMgZmlsbCB1cCBiaW9zIHVubGltaXRlZCBieSBoYXJkd2FyZSBj
b25zdHJhaW50cyBhbmQgc3BsaXQNCj4gdGhlbSB0byB0aGUgbGltaXRzIGluIHRoZSBJL08gc3Vi
bWlzc2lvbiBoYW5kbGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICAgYmxvY2svYmlvLmMgICAgICAgICAgICAgICB8IDMzIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQv
em5zLmMgfCAyMSArKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBpbmNsdWRlL2xpbnV4L2Jpby5o
ICAgICAgIHwgIDIgLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQz
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmlvLmMgYi9ibG9jay9iaW8u
Yw0KPiBpbmRleCA2YTYwZDYyYTUyOWQuLmRhY2ViMGE1YzFkNyAxMDA2NDQNCj4gLS0tIGEvYmxv
Y2svYmlvLmMNCj4gKysrIGIvYmxvY2svYmlvLmMNCj4gQEAgLTEwNjQsMzkgKzEwNjQsNiBAQCBp
bnQgYmlvX2FkZF9wY19wYWdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgYmlvICpi
aW8sDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0woYmlvX2FkZF9wY19wYWdlKTsNCj4gICANCj4g
LS8qKg0KPiAtICogYmlvX2FkZF96b25lX2FwcGVuZF9wYWdlIC0gYXR0ZW1wdCB0byBhZGQgcGFn
ZSB0byB6b25lLWFwcGVuZCBiaW8NCj4gLSAqIEBiaW86IGRlc3RpbmF0aW9uIGJpbw0KPiAtICog
QHBhZ2U6IHBhZ2UgdG8gYWRkDQo+IC0gKiBAbGVuOiB2ZWMgZW50cnkgbGVuZ3RoDQo+IC0gKiBA
b2Zmc2V0OiB2ZWMgZW50cnkgb2Zmc2V0DQo+IC0gKg0KPiAtICogQXR0ZW1wdCB0byBhZGQgYSBw
YWdlIHRvIHRoZSBiaW9fdmVjIG1hcGxpc3Qgb2YgYSBiaW8gdGhhdCB3aWxsIGJlIHN1Ym1pdHRl
ZA0KPiAtICogZm9yIGEgem9uZS1hcHBlbmQgcmVxdWVzdC4gVGhpcyBjYW4gZmFpbCBmb3IgYSBu
dW1iZXIgb2YgcmVhc29ucywgc3VjaCBhcyB0aGUNCj4gLSAqIGJpbyBiZWluZyBmdWxsIG9yIHRo
ZSB0YXJnZXQgYmxvY2sgZGV2aWNlIGlzIG5vdCBhIHpvbmVkIGJsb2NrIGRldmljZSBvcg0KPiAt
ICogb3RoZXIgbGltaXRhdGlvbnMgb2YgdGhlIHRhcmdldCBibG9jayBkZXZpY2UuIFRoZSB0YXJn
ZXQgYmxvY2sgZGV2aWNlIG11c3QNCj4gLSAqIGFsbG93IGJpbydzIHVwIHRvIFBBR0VfU0laRSwg
c28gaXQgaXMgYWx3YXlzIHBvc3NpYmxlIHRvIGFkZCBhIHNpbmdsZSBwYWdlDQo+IC0gKiB0byBh
biBlbXB0eSBiaW8uDQo+IC0gKg0KPiAtICogUmV0dXJuczogbnVtYmVyIG9mIGJ5dGVzIGFkZGVk
IHRvIHRoZSBiaW8sIG9yIDAgaW4gY2FzZSBvZiBhIGZhaWx1cmUuDQo+IC0gKi8NCj4gLWludCBi
aW9fYWRkX3pvbmVfYXBwZW5kX3BhZ2Uoc3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QgcGFnZSAqcGFn
ZSwNCj4gLQkJCSAgICAgdW5zaWduZWQgaW50IGxlbiwgdW5zaWduZWQgaW50IG9mZnNldCkNCj4g
LXsNCj4gLQlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1ZXVlKGJpby0+Ymlf
YmRldik7DQo+IC0JYm9vbCBzYW1lX3BhZ2UgPSBmYWxzZTsNCj4gLQ0KPiAtCWlmIChXQVJOX09O
X09OQ0UoYmlvX29wKGJpbykgIT0gUkVRX09QX1pPTkVfQVBQRU5EKSkNCj4gLQkJcmV0dXJuIDA7
DQo+IC0NCj4gLQlpZiAoV0FSTl9PTl9PTkNFKCFiZGV2X2lzX3pvbmVkKGJpby0+YmlfYmRldikp
KQ0KPiAtCQlyZXR1cm4gMDsNCj4gLQ0KPiAtCXJldHVybiBiaW9fYWRkX2h3X3BhZ2UocSwgYmlv
LCBwYWdlLCBsZW4sIG9mZnNldCwNCj4gLQkJCSAgICAgICBxdWV1ZV9tYXhfem9uZV9hcHBlbmRf
c2VjdG9ycyhxKSwgJnNhbWVfcGFnZSk7DQo+IC19DQo+IC1FWFBPUlRfU1lNQk9MX0dQTChiaW9f
YWRkX3pvbmVfYXBwZW5kX3BhZ2UpOw0KPiAtDQo+ICAgLyoqDQo+ICAgICogX19iaW9fYWRkX3Bh
Z2UgLSBhZGQgcGFnZShzKSB0byBhIGJpbyBpbiBhIG5ldyBzZWdtZW50DQo+ICAgICogQGJpbzog
ZGVzdGluYXRpb24gYmlvDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3pucy5j
IGIvZHJpdmVycy9udm1lL3RhcmdldC96bnMuYw0KPiBpbmRleCBhZjllMTNiZTc2NzguLjNhZWYz
NWIwNTExMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC96bnMuYw0KPiArKysg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L3pucy5jDQo+IEBAIC01MzcsNiArNTM3LDcgQEAgdm9pZCBu
dm1ldF9iZGV2X2V4ZWN1dGVfem9uZV9hcHBlbmQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiAg
IAl1MTYgc3RhdHVzID0gTlZNRV9TQ19TVUNDRVNTOw0KPiAgIAl1bnNpZ25lZCBpbnQgdG90YWxf
bGVuID0gMDsNCj4gICAJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsNCj4gKwl1MzIgZGF0YV9sZW4g
PSBudm1ldF9yd19kYXRhX2xlbihyZXEpOw0KPiAgIAlzdHJ1Y3QgYmlvICpiaW87DQo+ICAgCWlu
dCBzZ19jbnQ7DQo+ICAgDQo+IEBAIC01NDQsNiArNTQ1LDEzIEBAIHZvaWQgbnZtZXRfYmRldl9l
eGVjdXRlX3pvbmVfYXBwZW5kKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4gICAJaWYgKCFudm1l
dF9jaGVja190cmFuc2Zlcl9sZW4ocmVxLCBudm1ldF9yd19kYXRhX2xlbihyZXEpKSkNCj4gICAJ
CXJldHVybjsNCj4gICANCj4gKwlpZiAoZGF0YV9sZW4gPg0KPiArCSAgICBiZGV2X21heF96b25l
X2FwcGVuZF9zZWN0b3JzKHJlcS0+bnMtPmJkZXYpIDw8IFNFQ1RPUl9TSElGVCkgew0KPiArCQly
ZXEtPmVycm9yX2xvYyA9IG9mZnNldG9mKHN0cnVjdCBudm1lX3J3X2NvbW1hbmQsIGxlbmd0aCk7
DQo+ICsJCXN0YXR1cyA9IE5WTUVfU0NfSU5WQUxJRF9GSUVMRCB8IE5WTUVfU1RBVFVTX0ROUjsN
Cj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICAgCWlmICghcmVxLT5zZ19jbnQpIHsNCj4g
ICAJCW52bWV0X3JlcV9jb21wbGV0ZShyZXEsIDApOw0KPiAgIAkJcmV0dXJuOw0KPiBAQCAtNTc2
LDIwICs1ODQsMTcgQEAgdm9pZCBudm1ldF9iZGV2X2V4ZWN1dGVfem9uZV9hcHBlbmQoc3RydWN0
IG52bWV0X3JlcSAqcmVxKQ0KPiAgIAkJYmlvLT5iaV9vcGYgfD0gUkVRX0ZVQTsNCj4gICANCj4g
ICAJZm9yX2VhY2hfc2cocmVxLT5zZywgc2csIHJlcS0+c2dfY250LCBzZ19jbnQpIHsNCj4gLQkJ
c3RydWN0IHBhZ2UgKnAgPSBzZ19wYWdlKHNnKTsNCj4gLQkJdW5zaWduZWQgaW50IGwgPSBzZy0+
bGVuZ3RoOw0KPiAtCQl1bnNpZ25lZCBpbnQgbyA9IHNnLT5vZmZzZXQ7DQo+IC0JCXVuc2lnbmVk
IGludCByZXQ7DQo+ICsJCXVuc2lnbmVkIGludCBsZW4gPSBzZy0+bGVuZ3RoOw0KPiAgIA0KPiAt
CQlyZXQgPSBiaW9fYWRkX3pvbmVfYXBwZW5kX3BhZ2UoYmlvLCBwLCBsLCBvKTsNCj4gLQkJaWYg
KHJldCAhPSBzZy0+bGVuZ3RoKSB7DQo+ICsJCWlmIChiaW9fYWRkX3BjX3BhZ2UoYmRldl9nZXRf
cXVldWUoYmlvLT5iaV9iZGV2KSwgYmlvLA0KPiArCQkJCXNnX3BhZ2Uoc2cpLCBsZW4sIHNnLT5v
ZmZzZXQpICE9IGxlbikgew0KDQpiaW9fYWRkX3BjX3BhZ2UoKSBjb21tZW50IDotIFRoaXMgc2hv
dWxkIG9ubHkgYmUgdXNlZCBieSBwYXNzdGhyb3VnaA0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJpb3MuDQoNClNvcnJ5IEkgZGlkbid0
IHVuZGVyc3RhbmQgdXNlIG9mIHBhc3N0aHJ1IGJpbyBpbnRlcmZhY2UgaGVyZS4NCg0KIEZyb20g
aG9zdC9udm1lLmg6bnZtZV9yZXFfb3AoKToNCg0KUkVRX09QX0RSVl9PVVQvUkVRX09QX0RSVl9J
TiBhcmUgdGhlIHBhc3N0aHJ1IHJlcXVlc3RzLCBhbmQNCm52bWVfcmVxX29wKCkgaXMgdXNlZCBp
biBudm1ldF9wYXNzdGhydV9leGVjdXRlX2NtZCgpIHRvIG1hcCB0aGUNCmluY29taW5nIG52bWUg
cGFzc3RocnUgY29tbWFuZCBpbnRvIGJsb2NrIGxheWVyIHBhc3N0aHJ1IHJlcXVlc3QNCmkuZS7C
oCBSRVFfT1BfRFJWX0lOIG9yIFJFUV9PUF9EUlZfT1VUOi0NCm52bWUvdGFyZ2V0L3Bhc3N0aHJ1
LmMgOi0NCjMxOcKgwqDCoMKgwqDCoMKgwqAgcnEgPSBibGtfbXFfYWxsb2NfcmVxdWVzdChxLCBu
dm1lX3JlcV9vcChyZXEtPmNtZCksIDApOw0KDQoNCkluIG52bWV0X2JkZXZfZXhlY3V0ZV96b25l
X2FwcGVuZCgpIGJpby0+Ymlfb3BmIHNldCB0bw0Kb3BmIGxvY2FsIHZhciB0aGF0IGlzIGluaXRp
YWxpemVkIGF0IHRoZSBzdGFydCBvZiB0aGUgZnVuY3Rpb24gdG8gOi0NCg0KY29uc3QgYmxrX29w
Zl90IG9wZiA9IFJFUV9PUF9aT05FX0FQUEVORCB8IFJFUV9TWU5DIHwgUkVRX0lETEU7DQoNCkhl
bmNlIHRoaXMgaXMgbm90IGEgcGFzc3RocnUgcmVxdWVzdCBidXQgem9uZSBhcHBlbmQgcmVxdWVz
dCA/DQoNCmlmIHRoYXQgaXMgdHJ1ZSBzaG91bGQgd2UganVzdCB1c2UgdGhlIGJpb19hZGRfaHdf
cGFnZSgpID8gc2luY2UNCmJpb19hZGRfcGNfcGFnZSgpIGlzIGEgc2ltcGxlIHdyYXBwZXIgb3Zl
ciBiaW9fYWRkX2h3X3BhZ2UoKSB3aXRob3V0DQp0aGUgYWRkaXRpb25hbCBjaGVja3MgcHJlc2Vu
dCBpbiBiaW9fYWRkX3pvbmVfYXBwZW5kX3BhZ2UoKSA/DQoNCnVubGVzcyBmb3Igc29tZSByZWFz
b24gSSBmYWlsZWQgdG8gdW5kZXJzdGFuZCBSRVFfT1BfWk9ORV9BUFBFTkQNCmlzIGNhdGVnb3Jp
emVkIGhlcmUgYXMgYSBwYXNzdGhydSByZXF1ZXN0LCB0aGVuIHNvcnJ5IGZvciB3YXN0aW5nDQp5
b3VyIHRpbWUgLi4uDQoNCi1jaw0KDQoNCg==
