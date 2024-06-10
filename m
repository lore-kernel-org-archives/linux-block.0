Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C25EDB;
	Mon, 10 Jun 2024 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717987653; cv=fail; b=EMBRRvH9yj1G9daS6E5yetzJcmpYGMCqaaKPk79esJq+XjAnw0Gbw/ZgLIYcr2Vv8ZyqADDTBJqjuHNy2PWVn/vqcstDfar09SBVKbHUKNWKCYqv/Bd4Xqn7k8FoM/8glYUTGFeYGoBDorWqGU11ib4ng2Z4CKBl2i+ukNq8jqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717987653; c=relaxed/simple;
	bh=nc79wmNq0t8aW1RS4qj4FI7emFYjik9m25S2R2uS3Jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBo7S1guLBHpHyrMvp2heN3bdd1jXyQ1y6N8ktkWSevw3m3gdNehpTHtagsRo4H0jl5tMG79DRb3vq/OzxKVqWiyFzoLeJt7vKRPeW5mN0y0UNPzzvafldQq4HCXERqkRJnKP5+rYNC5FIohWEBbfoLStVIVrNT4q/anWmQTERQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pk44npe/; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pk44npe/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKEUO6bonkPdDMCVpi726aIheW+niwe5ccBObi26LyXHVWekjBdwNFiD6KPjqIlbph9FYabsm4KkyRVqTekDFuPQeqnSuozw13tlzGrrmijTI+nlt8JiSwJLhwEEDkrEuBEFKk34nZJG5YaT4WDDw41b5jMA/pdNgawmAPPEjK7m8pmeiXX7uLdsf8jaf6DYUu4a4mQ3sdDFNI5o3bzNy6Nj6qpLsVrdl3ZKKokVOEw01QYIEMcBeaj4CfuOHV0SNxbRN9CDlR4Smw5LUwRFE47FQ4H9O8J3Ywmp703vpTGR4D2SLPBqvq0v5g7ltUmngj7iZA2ttJ8gpj1WvTv0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc79wmNq0t8aW1RS4qj4FI7emFYjik9m25S2R2uS3Jw=;
 b=BGO40LdcnwBEUWhJUwXu5M5SbOqoRs9nioAKCGCdp2Qa1W9iWfgZBVgrrro5eFwtkNmCSAymD0dEc6Ha4nVrgLPM/oIqP9MfOCsR0PmpWXiUCYOePv31Cjfdv0jV50RqsDKEOff2krntIFuUnzUMF3UO54Sn59UDiwzYQKdiT4Q9iplUwQayxqHtjk5GsRkChPGy5pWy2Yq+nXI3LM/bjSgGGWkzrrLm2DFHx/mnU1sCTWIBXnTX97Uzvh6yDtxFoEI+iaylalyQuqXEzRXSK5txBAi4DZdpAKU5GTvfSIA7A41EotmxucHjFSC1ckQkg8JBfW6OrTUD16wHCQ6wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc79wmNq0t8aW1RS4qj4FI7emFYjik9m25S2R2uS3Jw=;
 b=Pk44npe/VJc/poXHNgROL2IG3bpyROXDxQEPw7R/CDDKbyLDjgNr5/bqpheCtqghY7jNClcts6E+E/wrQIv5gAYFMv+Gky294GDnqDVMvPMUHl3U1EANzh7BLcogOp2YgHSwHLYz7WEdPjDS81tJYV2RGnfpUkn63vD9qMJV/jp7iFe0LoP8b9HLv8K2SlxKB2ASoxsubJ5oUEMA6526PX7A27YBFnqlT0NazWsUnbTXKvXhlAI1JLYxSWYCeHNQ0M5W5ZYcn0T/Z8piqFBwVbConavOc9WNCBW4UuqL/CYX4icKWYCBR1EVNfMZIGS00bqzlh7AhDztRRcq90x8TQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 02:47:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 02:47:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Cyril Hrubis <chrubis@suse.cz>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jan Kara
	<jack@suse.cz>
Subject: Re: [PATCH] loop: Disable fallocate() zero and discard if not
 supported
Thread-Topic: [PATCH] loop: Disable fallocate() zero and discard if not
 supported
Thread-Index: AQHauLtqQllFxZ2rQUi2KDjIvdVlkLG9W8QAgALz1oA=
Date: Mon, 10 Jun 2024 02:47:28 +0000
Message-ID: <4726b305-0d26-42c6-aa25-820e662f3ea9@nvidia.com>
References: <20240607091555.2504-1-chrubis@suse.cz>
 <ZmPvNu-YijbtJkeR@infradead.org>
In-Reply-To: <ZmPvNu-YijbtJkeR@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4356:EE_
x-ms-office365-filtering-correlation-id: 21267a68-fde1-4c2c-d7ef-08dc88f7ab31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1lsTXJncW1jUmpuRXRhRThONk45T1dCSzIyNWdzRjRBNEFiUVAvNHNRRHV0?=
 =?utf-8?B?cXB1WGZDZ0VXMDZvUWpGejBUMmV3N0s5TXhWVVlNNUNWWk9IcWZNZCtzYTQv?=
 =?utf-8?B?enJYZVhRdlhHMnVJVWZVVnhCYTdyTVp4T082T0tURGRGcXhTU2tPKzJRbGF0?=
 =?utf-8?B?TU4zd2pvcjMxcCtsL1cyOEw2enVOejR4NXh3ZEVGZ09URWd5R2Y1R0R1VmZH?=
 =?utf-8?B?Tmpqc2ZrN1Q3c3hDa3JjSmZiQmZZMmM4ckJTeklESWp5UW1IZ2lycllGanN6?=
 =?utf-8?B?WEVBYnI5eTR5V0Fjdm9DQ1lRRkViN2gzMGUrdGRkWGt2TGtpTFZqa2x2RzE1?=
 =?utf-8?B?dkpRT2VJOWlGRlFvK1VSMCs5VG5nTzh5c1J5Q3BYQk42cEJRak02cTB0aUJu?=
 =?utf-8?B?RkNVb1kyK0hhSFFpcmJjR3JsN1lFWUN6UjJuejhPU1hodXl5OERCeE1zMUlW?=
 =?utf-8?B?VVR2ckplTERaT1ppeFFRNzVhR3MycHpwT0ZybDhPTmRTVCtCMTFPY0RsekJ0?=
 =?utf-8?B?VGcycHpodW14OE5QR1VvTFF3ZTJrVk4vMTNzOVZTa1lhWml4aXBRTk1OZStR?=
 =?utf-8?B?OTMwRUcxa2V3L25LZFV4UUFBd05qc3JKaXlXbFlBYTN1ZnRsN0NXUDcyRGxS?=
 =?utf-8?B?S0FBUmtLYXNNbm1uRjN6dUxuUGU1ZmdheFduTHZRRkxXUFFSTXNNMUc0cG5J?=
 =?utf-8?B?M01ncE5GaldiWjRKa0RhRmhoc2w1OSt3dXVXQkozWUd6SmF1RVUxL1lJUk04?=
 =?utf-8?B?ZWt3M0t6REkvampkcUpvbG1HOTM2c2dvNytXakpEeW5NZEphZFVISDZVYS80?=
 =?utf-8?B?d2lGRWtKQUExcVgwS1hrU256cFExNU9OU1ZvWTdSK2VVM2lQUFFpUTBBYmpI?=
 =?utf-8?B?YnA1Rlo4THcyMnFyVDFrd2crdmVCcnc5emFUSTltRHcwWDhEOUZ3QSs0eW01?=
 =?utf-8?B?KzFmeStQNTV1Y1FISWdEWU1MYzVxNmp2bGVndE42UjVxSUYrWmpWMFlMajhx?=
 =?utf-8?B?K1NhWXZlY2h6dS9qWll0K1d6UnFFS2xJQnVKQ3F5Y0JhODlLU1FLUXJBcTVI?=
 =?utf-8?B?eU9PR3B1RTlLV3VDOTI0QkViZUhHZWUzNVR2b3hqdEI5bWFndk5CeVZ5NVpT?=
 =?utf-8?B?dmNjWXpMVnVYaU5LbzQ4cFhiUmVGTC9oMlcvSk1sTzJieG9aV1E2WWVaT3ZY?=
 =?utf-8?B?RjJ1b1poYWljVldIamVpcjkxL0hzS0puM1FQSFVGM240ejFRM3JDZWFGd2Yx?=
 =?utf-8?B?NmV3cmJrUlpRRDRUV2ozZXRxN0JyUEhxcms5eXNUOW03UEg3clJ2b3hsZ3JC?=
 =?utf-8?B?QXRuZEU5dFhJdnhjSlJMK29wMGc4VzZrekxlTmNnRDFLYlMyby9ORWpJbkZ6?=
 =?utf-8?B?K2d0QXNka09VTDRGcjFwK1RqYW05S0tFbS9Wa0xObUhmcTZaaWcrci9VOFhD?=
 =?utf-8?B?ZlVyT1J5cXB3ZzU1NjFJVElCUllyL2RRU01LTnNnU1dIU0t6V3hFNFptNGxJ?=
 =?utf-8?B?SnhlN2N5SEg5RHVzblYvWkNMb3Z1b1dIR2hKM3lkNjRXaDVCOTZIelVERUxP?=
 =?utf-8?B?cjYrVS9pUEQrdkhsT3d4Z1FDelNuUytzQUIrcHNiRXBHZEJ3U25ZeGNuRzlv?=
 =?utf-8?B?UDNud0NiUjR3VHRHdTB4Sm5yd0d5NllUS2EzZC9nMnBLWXJtV3ZOSGVrbTRE?=
 =?utf-8?B?MHhaVnd5L1Q5ZFlLZWdYMklZVjRrclFrUjMwa0FyUVlVNmI3MUJsUWFXSmdh?=
 =?utf-8?B?dGgvcVBLQWZybkJJMThmR0k1b3pyak9kdytEbDBHaGZVazhwRmJmbjhLYnFV?=
 =?utf-8?Q?rnfBB4BHy/uGRdNzjsttiYylkee1gjmleuQfQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnlUdk9ndmZzVUpMbUE2RTV2V1VtbE04ZzlJY0dxY0o0a2FoOXF0UVE4L1NR?=
 =?utf-8?B?ZG83L2dSRVU5anpqTUkybGVER0R2YnY1R0hncXRET2tRdnFwVEpGSnZOeVIr?=
 =?utf-8?B?L3hWNFh1RHM3VlJqRW4wZXVXRDFoazlXbGdiUk5FSnVVbU5IaytpRHBsSG0z?=
 =?utf-8?B?dHBhbWNyVzNBMlBpOFdvS3hjRzQ4T09rTjE0bVpPNWtNL3NCaUFOMnpLR2cz?=
 =?utf-8?B?bThvNGNQZHlGbUhNRk5WVlV4ZXBZSW96SWwrd0dxanVTOGtlQXQySm10ampa?=
 =?utf-8?B?MmMxNVFCbWhIYTM0NzJuRVpSaVpOWlUzMDZyV0owMmpjMDBML0Y5TDFFcGwv?=
 =?utf-8?B?UnlpdU1UYis4Vk1FeE5VeDB1bEdaamg3Q1dtMG5RdGI1MU11aitKSDJRMERq?=
 =?utf-8?B?YXV6b2ZYV0xaRGZROFN0NklncjkxR1Q3NDNrazZjbmNGdTRCb3ZEdEZNLzcv?=
 =?utf-8?B?alN5dUtHdGNkVllyVisvRmpyNU8zZXZpSUtIcjNOMHl0Y2JUYUZmUXpibGJP?=
 =?utf-8?B?bFVWVGpaNGpmRjI3NWNLSythM3Z2dE1ab1ZGejBvNGF2NTNjNU03RjU2Wk5Z?=
 =?utf-8?B?VWd0MVkxd0Y2TnBSM0ZaRUxaclgycTJJNFBjL3crVW93VEZBYTkyU1QvYlNM?=
 =?utf-8?B?Mjd0Sk1CMG9QN2U5dTlyUE5QYktHdHZmU1BGUERRcjNpWmJyTHBOWmZrZmZC?=
 =?utf-8?B?STBNSkptZEFlQk1la2hQWWRoUExkSDJadUVWWGxKa0xMSy9aeW1idktUK3pX?=
 =?utf-8?B?ZDYycUZYcWI5dlNOa3I4TisvdlF6Y3ZCUUxCcXFHMzk3ckc0ZjhpdUdsSHVi?=
 =?utf-8?B?aUtRNU04OG5UbDFoa3U3Mk1oNkl4cHN0Qy9mT3JiQXhQSGZBUkZFcVVOT2kz?=
 =?utf-8?B?ZkEyQVRyTStwT2FrRmVURFJtbGtxTDcwZEY3SFJ1akZVcitYVU53ZHhsNW1H?=
 =?utf-8?B?YjRxZzRwb29GS1NHNzZacjgzaTlkNFVheHJSTkYrRlFORHBLVUU2L3RRS0ps?=
 =?utf-8?B?a1k5SXBBK2Z2YUlwTDlTYmI0eVY3R2xhQk1MWWF4a0FOUkh4bjR4bFpUbVBy?=
 =?utf-8?B?WkdxRTZvTHNzdk14SGFoRTNQYXNzQXZCbkFGZk9zL3FjWjVuNlplMTJOTU9z?=
 =?utf-8?B?OUhsR2RBM0c3eEpsaHJ3SjBNOUU4MFpoZGovMHF6eHV6SXJ2citLRkkvQllL?=
 =?utf-8?B?RENUengyQlE4aHlnblVyL29BZFV3V3hnWnh3Qll5d1ZhOU5sNXY3UmRQaTJ5?=
 =?utf-8?B?V2xsTVREZmZzODJOb1h3eFQ0YjhZWTVZMURib2pJOHhjQUNhTjBtMzBWZnoz?=
 =?utf-8?B?Zk1nbTFuMG5JUFpUNkhsRjMrRElVSFQ2UjBiZzVtdjZKTkI4aGlON01DcVBR?=
 =?utf-8?B?VnJuTm81dnNZMnM4ZUV4Q3dhdVh3UjZLaElIYVA4Ni9ZbWdySkRnVzE3YjZT?=
 =?utf-8?B?NEs0SDJrVEN2QW8vS01wa0xIZ0xLcit3Z1NDRFVHS0hKZm9yVGc0L3EzT3V4?=
 =?utf-8?B?Q0pGMjJpVWt6Yy85Zk1LYXIrTUNtQ0ZDN3JhaGYrVGtDLzlqVVc2WGlnMXRK?=
 =?utf-8?B?d243aTZXNDhrdWtnakNqVzN5b21lY0VtaDQ3SDM0YjVZV1M2cFdyZ1dCNitr?=
 =?utf-8?B?cEpOdHUyOFhqTExPaXMxb1hjbDdTZVd0bW1icVVNc0dyamMxSVFJbkxxV0ZE?=
 =?utf-8?B?RjdHZk15VXB1aWdEQXpOdnMrejlrcU94WTkrNXFnUHRLKzJGeWhoSkZ2Qk1U?=
 =?utf-8?B?a2ZscGNCdUhBVEZJMlI4dWM3MStzQWM0MnQ2d28wS0JTVzVZNHJ2WktUK3hL?=
 =?utf-8?B?cUxkMVFmWGkzekZoQTkyc3FaZDkvTkZSTGh0KzNEcUF4RkVXTG9XNUd2Lysz?=
 =?utf-8?B?eWJ4NDBoR1cwcUo0Y2UybE83ZFdnN0ROLzFGRjY3RWZCV29ZNi9zYloyc1Zn?=
 =?utf-8?B?eHEyV2U1b29jVmVDb3RkOFdVaUVuMmNsTy9SRE9yTTFNZE5JRS96dEYwbXI5?=
 =?utf-8?B?UU9QZmZhVFg2b1pyTENjVGdicThYb3EydmpMQUp5Y1l5MWVGUHlSc1RNMXRH?=
 =?utf-8?B?SHBGL2tJWEZDa0lXVlJHWU8xaXQrL0VJNzR1V08zMERJdmY1dWRVdk51bWZX?=
 =?utf-8?B?ZnZ0OG9UMjMzQnhPdUprSVRCVy9CamhBUlAvQnBYNE1JcVJnUnlielVYakpy?=
 =?utf-8?Q?dAvBFUEXPkBadC5f+pv/zrcHxe5QHKET66QuRb82iQwm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18539C32669D3C4F9BF49C817D3885C1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21267a68-fde1-4c2c-d7ef-08dc88f7ab31
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 02:47:28.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tbcc87eccZU/jXs4XWRFtxwWqK+nP68V3cf7VvbMYTZcReCa86Aun6cKs37HJcXlbXYZvXEZzoy/lWVmWJG9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

T24gNi83LzIwMjQgMTA6NDIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmks
IEp1biAwNywgMjAyNCBhdCAxMToxNTo1NUFNICswMjAwLCBDeXJpbCBIcnViaXMgd3JvdGU6DQo+
PiBJZiBmYWxsY2F0ZSBpcyBpbXBsZW1lbnRlZCBidXQgemVybyBhbmQgZGlzY2FyZCBvcGVyYXRp
b25zIGFyZSBub3QNCj4+IHN1cHBvcnRlZCBieSB0aGUgZmlsZXN5c3RlbSB0aGUgYmFja2luZyBm
aWxlIGlzIG9uIHdlIGNvbnRpbnVlIHRvIGZpbGwNCj4+IGRtZXNnIHdpdGggZXJyb3JzIGZyb20g
dGhlIGJsa19tcV9lbmRfcmVxdWVzdCgpIHNpbmNlIGVhY2ggdGltZSB3ZSBjYWxsDQo+PiBmYWxs
b2NhdGUoKSBvbiB0aGUgbG9vcCBkZXZpY2UgdGhlIEVPUE5PVFNVUFAgZXJyb3IgZnJvbSBsb19m
YWxsb2NhdGUoKQ0KPj4gZW5kcyB1cCBwcm9wYWdhdGVkIGludG8gdGhlIGJsb2NrIGxheWVyLiBJ
biB0aGUgZW5kIHN5c2NhbGwgc3VjY2VlZHMNCj4+IHNpbmNlIHRoZSBibGtkZXZfaXNzdWVfemVy
b291dCgpIGZhbGxzIGJhY2sgdG8gd3JpdGluZyB6ZXJvZXMgd2hpY2gNCj4+IG1ha2VzIHRoZSBl
cnJvcnMgZXZlbiBtb3JlIG1pc2xlYWRpbmcgYW5kIGNvbmZ1c2luZy4NCj4+DQo+PiBIb3cgdG8g
cmVwcm9kdWNlOg0KPj4NCj4+IDEuIG1ha2Ugc3VyZSAvdG1wIGlzIG1vdW50ZWQgYXMgdG1wZnMN
Cj4+IDIuIGRkIGlmPS9kZXYvemVybyBvZj0vdG1wL2Rpc2suaW1nIGJzPTFNIGNvdW50PTEwMA0K
Pj4gMy4gbG9zZXR1cCAvZGV2L2xvb3AwIC90bXAvZGlzay5pbWcNCj4+IDQuIG1rZnMuZXh0MiAv
ZGV2L2xvb3AwDQo+PiA1LiBkbWVzZyB8dGFpbA0KPiBDYW4geW91IHdpcmUgdGhpcyB1cCBmb3Ig
YmxrdGVzdHM/DQoNClBsZWFzZSBDQyBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPiBhbmQgbWUgd2hlbg0KeW91IGRvIHRoYXQgLi4NCg0KLWNrDQoNCg0K
