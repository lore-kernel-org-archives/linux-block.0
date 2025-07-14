Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676B22F152
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532593; cv=fail; b=i+pOcnDnlbwB0R59BeWrXwFKXNSkRLkzKMxs8j1l+lZDL77PhdFkoaygPQhvWz+Xn2O5wIOhKi/s1vVmb//vonS0z7M8e+KXqcf7r8mIdcvbu+NgFrEBCLOIs4htmrjZOx6kdpfxAJ863V5Dbjj025KKD36H6R8TvU8zEMJvmcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532593; c=relaxed/simple;
	bh=LrM1k0W9JMOJKdOfBxnWI1U1wz/Pe+3viD6Y67h0lCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqUTKJVjRpndifi0NzIWMriXTvnMh/rUFv+7w6+NoDVfpcyIxUWw0akDNCXKkcc9ZFxdTyWu98p1BxyL8KZfnVqDmAF00+pSa6R2Q6j+4wC1fEAUk2vT/t5KBHo2PyOdng/n1PqUiU4meRBKMQ2c6J5OWh1Nj8Bv2YwtFzMWjaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d95+8DVr; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d95+8DVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKzZnXaybx5mctx69EU3knE7SrfvJg/foUz6ea1+PB+SvRUiu+Yjl/3eFFmKetknLG1uvT+ZpIoQ1eBNt69LN3hxVm7DUWqwqdD/3MVCDnU2919uHmqUupTlisfsHS1Oistz61KS6VGUKZbsgKw8mSHZ+Znol9S1+W7QeQMih36ecOiUC2yIOb/KJ7oocB1ZVLxL6M0bSdICCXsYWt68RMQytwlhlz4hqw/olZSqAIQyIdqpUJRe4G0/bV7D+SMGUoDgUu4GW31rgJ/y3ef2HdQagCxCYY39XVrzBEkINAf2+5qVV3dojnaoRBQ13iRbV9LCOOmG8w3J8VIfsxCu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrM1k0W9JMOJKdOfBxnWI1U1wz/Pe+3viD6Y67h0lCc=;
 b=ILMSAMqRx9MqJmpfJt2ibXNtdCppsx2U+fUXOFwELxyP8pY2ZelHQNeLItr1vkogFLxBbrRtiuwNJVF8IsD4zhNZfXLPSbPXPEcNW55oy2KhcpNT0SvuBY3r0CYGtd1cEFHf3ERb/eIg8Ow3uqnAY++OXgdGUj8phbiCO5E7ygjFr4eExLHnUr+MOm8B02XPeVJt8KwMsHHsMi34bucnE42I+ghp4lYMncS/lYmjAxISqslSk6aCj8HYAUkv175jKWS52MkPIKi3ksbU0NWcrcyF01QIgRBPEbL4CsQxCounmaphP37GFoBNs10dIRT9RZa7NveJp8KF2oMX2vKqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrM1k0W9JMOJKdOfBxnWI1U1wz/Pe+3viD6Y67h0lCc=;
 b=d95+8DVrGeZp7YT/EanJ88WbWTwL7EV2rAHXDUOpB/cKmeaSicHCIPtWQD6eA18siwEmby6OlUa4YLknveCBnWU+IVekpAopYTjac//RnpPx06aMcZRwn/MfgfcTdIDnjO3bW2qcH4udjiWQTWuph7AIrqgnnIPGOY5n9sB3HZJdTtEB4XpZbuy7TutzzdHS+vgk54QnvyWy5KNEuukfWPtTHXTAhvn6lf/G2iQ1WUMeuHC220eHX5tSgogo8VJ+9zai1k4FqpjDLlTk38V+C9rqiOkkIrnxyixdGI766P6NxGAtp6VwyMpIdABR3eNUHXM/4cTde59jNZs8x5Bq1Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:36:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:36:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH v2 2/5] block: split blk_zone_update_request_bio into two
 functions
Thread-Topic: [PATCH v2 2/5] block: split blk_zone_update_request_bio into two
 functions
Thread-Index: AQHb9M0b5l3EIGCL+0O03PVsrtTG6rQyNd6A
Date: Mon, 14 Jul 2025 22:36:28 +0000
Message-ID: <c862dc46-13db-47d0-acf5-495115c305aa@nvidia.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20250714143825.3575-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: 193b1bc1-7e09-406a-5453-08ddc326df8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnpzVVI2MXBGc3VEVWF5RXRDa1JYUkNhTDhMemprYUpWSDBTbWsycWgxazVa?=
 =?utf-8?B?ay9tK1RMTU5iT2xYSFROQ2g4LzZvazJXbGk5Ky9TZ3puaE40emJneHA4OGhF?=
 =?utf-8?B?SUJQa3V0ejVvMG1aQThhSWpJYWxScmNzNm4vY3F4YkhJZTJRbElGYm9TaWpj?=
 =?utf-8?B?MENDT0xxQUxOTE1wNHhnSHp2WDV6TER6Ymh0cFpoQXVVSXdXQ0trU3JUKzNo?=
 =?utf-8?B?L001bHdJa0p1a1B1TmN0VmtkK3h6akEwWmQ5aHR6SUVneFdRWEtBUytCaDhB?=
 =?utf-8?B?WDZVakZnck8yQUd4SnZac2dKN2s3YnowMERHSHRpSEtDK0VzMWlIbkorTHZ0?=
 =?utf-8?B?UGluL0wvbHFNY25peHVYUnYzTENRaDdZWE0rWXlWcXFoRzRZeWZMUzYxVnMv?=
 =?utf-8?B?MjQ4bC9TYXV2WmlLSjVLT1g0WWljR3JZbEhRaDJtSE4wKy9GVWNGZTEwZEk5?=
 =?utf-8?B?bFhuczlPR3Y1dGxGcTkyZmdVR2E0TUdndGdDMmFOV0dLUVpYVHlXRmlacWZI?=
 =?utf-8?B?SWV4eno3SzFEdVEwMHRTeCtvSG5aYjRWekZoT21DQURFOStnWWgrNy9BL2tq?=
 =?utf-8?B?WjF5eFk3VVgwa242Y2w1YlNjdStweUR4S1hUVVdPeERWdXk0RHFvVFVacWls?=
 =?utf-8?B?UGNaZUl6clVST3hVZHpDU256ckRDNDA1TmI3MEIyT1FQY0gvZEw1VVVGWUIx?=
 =?utf-8?B?QXdkblIvRXkvVGR6MFVaRmMwRjFiUkZVcUFYN1hJdnhjWEhZbUNZbHRIUDkz?=
 =?utf-8?B?Q0RMNUNSalMrNkFFaUlsWXVnVzErYUsvYkNoci9xdDViN2tBaXA4OTN6RHZr?=
 =?utf-8?B?bmVya2lQVXVGSFpzMzdvemRsMjM4ZDhHME53RnlaL3djRDBZU2JkaWhJcG5B?=
 =?utf-8?B?ZDJhbHpzaTh2Y0kzNlpVc20xMTczeGhMbE9XZCtlbGlaVTkzdmlwUkFnTFph?=
 =?utf-8?B?dUZzeUlDZUYyNW9XanY0UUVmcmI0U1RxQUlpVVBGRWxxNFhEVkpmNXVVQ2oy?=
 =?utf-8?B?Tm8zcTdwMEoxaGxreU84WFRSZ2FDMzNXNlZjTnpBdjd4Wmt4blZKQWVOK2Vh?=
 =?utf-8?B?SnFHL1plY3d2aDVmcERCNENhMWJicG5uUnNYeFVOT1lSL3pZMER6SUdEWjQ3?=
 =?utf-8?B?aXgwQ3Z4Tyt0N1hkamFNWkM2ZVF6YU1rTWhpei9pN3hBL0JvVGxVMEJIaFRM?=
 =?utf-8?B?ejNPNDhoU3h3NStYWGh1VlhySlJ5QTVaRStjQjI0SmJKalZSWlVTTE1qRzlC?=
 =?utf-8?B?YStPRHZyWjVBS3h5TTI3ZWE4QUNsSUJ1ckNCZGk2dlZFRHVFbVhLaDc3NE9p?=
 =?utf-8?B?M01sNWY2VWRyV0RzRndRaW4rUXZjU0xLc2N0cnhvdVhveHhJT1VodVpGT0wy?=
 =?utf-8?B?S2lybmdaSXNURnFwL0VHUmpzblZ5VjdramNxOG5XK1ZGRFZPZTZ6Y2hMeVE5?=
 =?utf-8?B?YnRlQmF4Z1YwU1JCdzNnQlBKdlRsYkZlUVVPN3VEUnFZbEVBUHM5T0Q2UTRX?=
 =?utf-8?B?ZmZSaUxKU2RxejZiWUlnMFhEa0NUU1I2QVV1Q1Y2OUFyMUswQWJEMkZXOUlO?=
 =?utf-8?B?Ri9CcXBwNXlLRVJOSTc4NWJZYmdWTnBvWTNRTzBQOS9FVTBNeUdaSW9QS3oy?=
 =?utf-8?B?YnIvSGphKzVlY0FQaHpUS1crdG9JUzN5TDVESFdPbUhSMUJLRkhYTXZ2eXVD?=
 =?utf-8?B?N0gydkFEYlllRnFwcmd3YUhIL0Z6MWFjaGlwUVZuZWNweVJGUm92ckN2T2Yy?=
 =?utf-8?B?c20rZjdpZW5NZmRyNDFsSzBtS2tGZlRxMjVrOFZEYWFpSCtmUEdEZzNvOWNU?=
 =?utf-8?B?ZmhlSkgxSU9qaHZmRVdnVkgrN3BqWjFWdytHZG5JM1BhNUpCMVYwTm9OaUVV?=
 =?utf-8?B?VnhsUldaaFMzamZjNy8rbzlkVXQrS3JwNCsrMzdJRDBoTVJvTmlGeXpRL1po?=
 =?utf-8?B?azU3aFZKZUhHTGpkS05SMUVFTVpXVWZHYkpNQkdiQXlUV2ZSQlV2UnZpMWNM?=
 =?utf-8?B?VnU3eTZ6d1l3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkhPSlkyaFBleW5NaWpXaGJvTUc2d2QxU3NjMU9ReVhsYU5ZT3dKQzEvRlN3?=
 =?utf-8?B?MmVVUG5GYUhzZEZNbnVSZVBDbkVueEVNSm5uc2JuckRPV2hsdEc1V09VeW4w?=
 =?utf-8?B?b0doWmlneG5YZGd5dmMvYVZrcnJWY2FxRForRzY1bzlNYmVKOWZ3czVRdFN2?=
 =?utf-8?B?OThxdy9hM2tvQkVqbS9hWm5xb0dFcHM1VjcwcjFvajV3cURrOHlPOG45dnBk?=
 =?utf-8?B?RzAxSG8vc3gvS2xqT2g4VU9iWThDYmFuY0ZudDl2c3U4ZitlTU1iUm9qa3p4?=
 =?utf-8?B?d1h3aWsxMSt0M3J0RHBmMG9BTGZXdEtlY2tlK0k0RFRzbFJyWXNEa2p6N1hm?=
 =?utf-8?B?TmdUT3pnWlpiN1cxVzhJOWgvR2grMnlQV280NGp5ZHo5T2JUTEpHcEV0dDhh?=
 =?utf-8?B?QkVqb2p4SndJa2cwWGlLdkpEb2d2UnRaN202cjZINEYzbTFldVFRSGt3SUVT?=
 =?utf-8?B?YTRsSVRhR0Z0SDJybmpsNDAvTkwyaVhuQmp0Sld0QkRTQ0dFR0pGbW5VWXdX?=
 =?utf-8?B?a29DMzcxU3ZvRFpqdk5tWUFZQURzYmkwRE9NVGxWTHhSYWVJTnNTYmtaYytX?=
 =?utf-8?B?MU9Benl0YmQrbmZvVFcrSUZrNHNrbWYvc0JGb3JuZTFadkN2V3BEZUVnTUls?=
 =?utf-8?B?Q2hDak5NOWxoU29yTWhrbEd5M011WTJRQWdkaWdST0JoMHI2RWxFdnpHajFE?=
 =?utf-8?B?RlZZNnNaYXNUQ0lGQ25DZTJZMml3Z1E4K2VLVXpUV3J2UkhOQjVwYzFWdjZV?=
 =?utf-8?B?cWVMcG9KRXAwdEJsaXdkWERVUE5CNzVMd2lscVVYejFJU2d0aU9mUmZXY2Ft?=
 =?utf-8?B?TUM0TW5ERVZTMHIvMGRVcjhOT1ZkR2o1WWtBT3Z4UEVOQWJvQUYxZmlQTzJa?=
 =?utf-8?B?Nkd4d2s3RHhxRjA5c3dsakFQb0YvZVpkRGtpSU1NUmp4QnNKUGxHT0o2STN2?=
 =?utf-8?B?V0dFdlVKS0NoNmg4R1UxNmJJZ2JieXVTNFpOYUE1cUtsaktpdUUwZ3hYT1By?=
 =?utf-8?B?SWdmVWNUWll0ZVNHMjF5ZzlsM09UbnQxL0tpYVA0UUlTSEw1MjhlRXR3ME9r?=
 =?utf-8?B?Rit2ZzVpTEpqVGs0Q2cycW9KaTB2dlVaWTI5QkIydXcrM3FtTWYrRDFhbkta?=
 =?utf-8?B?cGZIR2hzVkthR0xkOGdDRWFLQzJBeVlWMkc5Rml0eW9CN011OVhVZHZCc283?=
 =?utf-8?B?dFhhUnhaTGorVVRQSW5Yb0RlTTBzQ095TFQxVjdvNVU0dDg3UDUyU0VlV2hy?=
 =?utf-8?B?OW1WSmtCWHN2K1JnV28zQlZMQjB0N0ZHcGJuQnd1VDZHaVZTaFV3ZEdJR1h5?=
 =?utf-8?B?MHk2R3ZremY5NHFTQ0w2YkFFRk5zSkhoSUIraUlTZ3VXOE5rRTBUMzRzL28r?=
 =?utf-8?B?SElZeTk0VmVUYkw1b3BHaWlwcWVxWlBCanJXcE5BamJhekVyNkNpaXJvdEtj?=
 =?utf-8?B?eFhOV2RwdnMwUEtiRlhLVTF4cDJ1YjRsQUFHc2d1aktwVkxHcjMyY2w0T3pJ?=
 =?utf-8?B?ZFM1c25VWjNnNFluMzFzREhtUC81cUgzSk1uRVQ1bVFIVEhacnhZaWhiNElY?=
 =?utf-8?B?clA1c3JNNmQzaGdJL0xaNWltQUlkVHkyVFBreHBEckRhTVBHbUNxazRNUmpS?=
 =?utf-8?B?RDNmQ2FwcC9MKzFza2lwdFFGUFVCQjE3OUtidTMwbjIrTXVZQmdJam5FQ0lP?=
 =?utf-8?B?NzN3eXYyKzhRd1NnSDZyZ3ZLZzhlSVE3d1IrTC9iUmJVUzV1QjRENHRwbmMw?=
 =?utf-8?B?K0JEaUV2U1ZoZlMwMlVtSkgrNlNqdXgzK0djV3R1NklucU96cjk4QzBsdjdU?=
 =?utf-8?B?c0xGNWxWcnQwQTgzUDF3cGxKS2ZBNWRkYi84RFlEeDE0UGxSUnZjb0hMOWdz?=
 =?utf-8?B?K2tyZkZNM0Q0S3NrY1NJc01kbks1L0JyVVlzZk1QM1J4cld2NFdKTmRkL3dq?=
 =?utf-8?B?cmNLWnk2ellxTEdwS1dEbEtpSWhNK2Y0T0RBOUNpeWE2WjBuT2NyQW9oQklC?=
 =?utf-8?B?WG5DVXpHcDNvWEJEVFJuUk1HSFlTQnpsdzdMNVpLWG9EVm1naDVnaitmMmZk?=
 =?utf-8?B?UTVyQll5TEdPTlYrWXhlR0xZbEZxbTZHMWZ6YmpUY0ZHRDllcVowZlg4NXBi?=
 =?utf-8?B?R2JQUWxWZk55MXpVY1phOEtzQUwxMWhUT1JpQUZESENhdVQ3SDhZRjk3MWZB?=
 =?utf-8?Q?uFZpRQohQ6KUUeBdS+E8wGez55oa00MGioYeesb8JxW5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3299A14E1B295E44BF11AB9C8A65709A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 193b1bc1-7e09-406a-5453-08ddc326df8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:36:28.2410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quelji74wgmRn305HHNGVqou6r+iXyiWxLBWqz+T4Qu5hN8uQuluxnU5EsMViT7kUXzxUunggZToefJE6lAMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

T24gNy8xNC8yNSAwNzozOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBibGtfem9uZV91
cGRhdGVfcmVxdWVzdF9iaW8oKSBkb2VzIHR3byB0aGluZ3MuIEZpcnN0IGl0IGNoZWNrcyBpZiB0
aGUNCj4gcmVxdWVzdCB0byBiZSBjb21wbGV0ZWQgd2FzIHdyaXR0ZW4gdmlhIFpPTkUgQVBQRU5E
IGFuZCBpZiB5ZXMgaXQgdGhlbg0KPiB1cGRhdGVzIHRoZSBzZWN0b3IgdG8gdGhlIG9uZSB0aGF0
IHRoZSBkYXRhIHdhcyB3cml0dGVuIHRvLg0KPg0KPiBUaGlzIGlzIHNtYWxsIGVub3VnaCB0byBi
ZSBhbiBpbmxpbmUgZnVuY3Rpb24uIEJ1dCB1cGNvbWluZyBjaGFuZ2VzIGFkZGluZw0KPiBhIHRy
YWNlcG9pbnQgZG9uJ3Qgd29yayBpZiB0aGUgZnVuY3Rpb24gaXMgaW5saW5lZC4NCj4NCj4gU3Bs
aXQgdGhlIGZ1bmN0aW9uIGludG8gdHdvLCB0aGUgZmlyc3QgaXMgYmxrX3JlcV9iaW9faXNfem9u
ZV9hcHBlbmQoKQ0KPiBjaGVja2luZyBpZiB0aGUgc2VjdG9yIG5lZWRzIHRvIGJlIHVwZGF0ZWQu
IFRoaXMgY2FuIHN0aWxsIGJlIGFuIGlubGluZQ0KPiBmdW5jdGlvbi4gVGhlIHNlY29uZCBpcyBi
bGtfem9uZV9hcHBlbmRfdXBkYXRlX3JlcXVlc3RfYmlvKCkgZG9pbmcgdGhlDQo+IHNlY3RvciB1
cGRhdGUuDQo+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbDxkbGVtb2FsQGtlcm5lbC5v
cmc+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hp
cm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
