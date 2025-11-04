Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BF134AB;
	Tue,  4 Nov 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237741; cv=fail; b=WwCPOx44OoVHIDTkigKeQUuyIBmzVemAOAMOgdufcZ/r0nvv3kXC3bjh2D5MbLPUefgMnkjOqWRCWPsucl5H7V5Bnss4wa7qKjOaznsn1gyEfH/hyzaQ6Ds64c+UuTh7HyAITFFQwHOtZ+lyRA3YRFUxbTrfHZFt+v9BQcwctOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237741; c=relaxed/simple;
	bh=NBHKRjp9YXlv64NJGFfCavg0aEZgXX26tdCmDDFLdgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwZr1kQzl2rmRPTYdWkW43Si/3gc8zApgwQ6yctKK7JlDi5m1gWJcHExjjRBh0C8F64bgUEHZUT3EYtyx0dofp9/vGtgUSCIb4VwrVzp3QxTW73u6Xj7kSruUYPlJpMLNFMwphh28JL1gaVYZjTr/rGtk9RqCweYyZZflGp0Aog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U7Sza4LU; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U7Sza4LU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4MCc2u6Ss+pcz1pMTQTAjPuJACjEryC/JocUPKoBpdHFJsZytgmKPOayOVpQea5julj+m9cy3HfTxiBP/I0hHhCpL4IjuPrJk0fk4D2opFMXdspHoFFLX4lZi1XvZHepPgzolcj1yoWlkHrIkRGnNKuYStOhP9OO/z5dj0l72GP2DDRQGkZby4oXg/GHZ4PfqDMGxHkKbP+JPkAOQIfs5BSgfxuCe8sXzlVFrmoZfnOlDf77gSY9KGZlU+v0oxeEOebRje5q8Jqg7H0LAz1vItHKJaZaUuapD2vg8g4EzncINqjTvkN11EIk/G/gslGZna6jgM350IfckGJoKRUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBHKRjp9YXlv64NJGFfCavg0aEZgXX26tdCmDDFLdgk=;
 b=oV59hheppub8NzUHmjKjOsI/g4XL6CNSHYYiYAU9cdPKdB8brjt31cCZu9i4Coygg8VqTMONZjTtL1rTol54s2HylB6rKZU12MLo+C9xa3IIH2ZpWYeuADZgGIoV8AHC1aJrcYYqXNJKBPJza7pxh1g6xQJmHKsx6NSltXt5a6t4O0or9IWehQVMm6tZ5ih2xSG+QDvbiod5CrALG2J03rqjiWOEMdg560qCnsgvwMEyDWvDhuCZ59l4F1Lbsv3FZYMvWx4XvvNu2g/jWaYy8vDiElaAc0i6fUTSDzcFqT0/LMUF2KrxvNeJSg042YaIGTUJn1WZnNAr1wR77NfoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBHKRjp9YXlv64NJGFfCavg0aEZgXX26tdCmDDFLdgk=;
 b=U7Sza4LUh43MfZ3sUjUHdu2N2w5W+ZDjDKcrLJEUKBDsniDV/nqQ+myYSgErir41YvhKKLwk3ubJHgZBwbiIFVyUk0GR+Fh3mKs5ycPgj/lRfz6gwtWSa22GlYEOmbKUvyPEmPzcsaWxUKk4sjuzy5FcD+emrKKwGh4cmEEi8h8gGJ7PzoGwaGAgENJTc9jxrr7/ovcsycWhD5xzmBQaXeAcEzMPntVQfdE4ANyjV12mKoyMxFyhI2/EUEG3qRT402QaRg6vc74COzd8zxi6VjcDttUhpOSNFPEF0/SNuGYQlySAdncTY0qBaUFag0YWNzkfdvna/WpEsk+vYvumyA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 06:28:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 06:28:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: shechenglong <shechenglong@xfusion.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stone.xulei@xfusion.com" <stone.xulei@xfusion.com>,
	"chenjialong@xfusion.com" <chenjialong@xfusion.com>
Subject: Re: [PATCH] block: fix typos in comments and strings in blk-core.c
Thread-Topic: [PATCH] block: fix typos in comments and strings in blk-core.c
Thread-Index: AQHcTVNVFt3mnTT5jkCj1pKt38J597TiDfEA
Date: Tue, 4 Nov 2025 06:28:56 +0000
Message-ID: <52ff3b28-8b7a-4f13-b3fc-7d7b44ede168@nvidia.com>
References: <20251104062113.1929-1-shechenglong@xfusion.com>
In-Reply-To: <20251104062113.1929-1-shechenglong@xfusion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8893:EE_
x-ms-office365-filtering-correlation-id: 3be904bd-4eda-4379-a6fe-08de1b6b6eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDFQUUdkSXZLL3l5eHpmc1BDRHFBL1FmSWl0RElQQ0tPNnJla2toMGhHK3pG?=
 =?utf-8?B?RUhXeDB2WlFUZjdmdDBVenJTOWNVYzl0ZkZOb09YK1hQM1FETGtZOE5xMnNF?=
 =?utf-8?B?Q3ZzekVWcktLbGVXUDJaUUpadGE0dklkSHFUQ2NIaGJITjFIT09wWGNOdHBB?=
 =?utf-8?B?L1BoMy9ncDVZODJIUzMzaVRLaVdsNUNFS2tZQ250cDZNRGg0YytUM1d0cno0?=
 =?utf-8?B?aTltelpDSTkxZGhISmxGcEFWakpoMFpMeDhndWFCd0dVSFNvZFc2VEt2U3h5?=
 =?utf-8?B?U01FMFV5YjhTTDBFYWhsNUtWZW4zV2FtcHRVMkhoOG9BMHNmZXNnazVQVkMx?=
 =?utf-8?B?NXh0eU8xRUY3eUx0cS9sbzAzSGg2WVZHOWNHVDU5N3NhNElLN2pNbHRPNFVO?=
 =?utf-8?B?NDJ0UGVPVTdQaUY2ZnEzeUtRL2xJbU1WRzBYWktrRis3T3FaN1BEVlZIM25o?=
 =?utf-8?B?MmtlUXlzayt1NU9uMHBURC92a1hZNzQ5NDdFdi9yS2VUTkRKeGZ2MEd5YmhJ?=
 =?utf-8?B?OGdZZEpTSkVyVmxtUjRVN3VBZi84QllTa1VYbStCbVU0UkVObXUyNWxCYXd6?=
 =?utf-8?B?VDcxYXpHYk1ZcDlNNlk4V21Cb1I4enlJeTMyYVdkQ1ZDcHFkNE9veHpES3Jy?=
 =?utf-8?B?NDVGT3RlYjlVb0pjZGlTTDI2WXJMbXIxb1c5Tzc4VVRlSHIwM2wvcTltRWZI?=
 =?utf-8?B?Mi9EaVJ6Q2hIZTFuMy9sN1RTRlBzWEVaOFY1VTc1aGlSR2sybFlIUjJBZkMr?=
 =?utf-8?B?SU94QTRCWFVQckhQeDNuMWEyK1FGRE9SUnFKbHhIQUt3N0JXWnIzdDA2ZU9y?=
 =?utf-8?B?TEE4ZVVpYm1BKyt3T1pmUHZwYWZNS3NoeEI4bXB5eUNQOU1WcTV0NzUvUWd0?=
 =?utf-8?B?eGlMWW5pWCsyT0hKM0hEelo4ZFRRc2p0NVgvdWIvNHNUN2orY3BNeVJOOXBF?=
 =?utf-8?B?cE56anFyblE5eTQ2Sk1VOGF3Kzc2bXMzUWREeXVYZTVVWFdsYzVaRTk5Zlpt?=
 =?utf-8?B?NDhvYnlGNGhOZWZacjB6alRmYytKU1VSMkJreDJXUmFwaFprOHd0N1ROaFhl?=
 =?utf-8?B?NGUrbnRRWGFLOE9Bd0c1Z1laL3k4TEpyRmw5ek9VQ2dmdUE2b2dFQkNJM3dN?=
 =?utf-8?B?YWI4bEtxc3BhbisyaC90SEJOL2U3MTNhMzVuMHJ1MkRlN2xEeFJNSE1pTitE?=
 =?utf-8?B?YnlUSWM1VFhSL3I0V2k3WmpsZzdVdXZzWmx6S084M0NZTGlDTVhYYmRWZmRj?=
 =?utf-8?B?Vkd5dlh1MWh3bVQ0MEFvclc1Z29GRFhqWkJkcE85QjF6MHFCRGh2cFlNWlpT?=
 =?utf-8?B?TThVTjNPUEJ6YU12YVA4R1M3Zi9iOXVHT3Qzc1AzczduNWVXTUV4SU9KRTdG?=
 =?utf-8?B?OXIrSXpjSUVwZ0QrT2xRTUZhSUphSmlRQnRuTWVvTXpLK2ltRXplV2VYcnJm?=
 =?utf-8?B?VzF3SmtDaW4xbm5lcnRBZXl3OFI4YTg0YXJpMEFCcXFXN2VtUXBjbHVwUk9u?=
 =?utf-8?B?bW5BaDBuSFBQSHp2d1FYRVUxOVBTYUhyaWRWMDA1YzBlZEEwMFhqWno1M0hX?=
 =?utf-8?B?Nlh5ZCtqV3NZREZqM3g5STNPOE9KN2NTdXU4SlJsZEF0ajNReDE4K2Yxa0Vn?=
 =?utf-8?B?UE5TWjhHYlc1YVp2a0lmKy9qQzFKSmtKcnpGMTNLS2w1azBZdGZjQ1V4cktK?=
 =?utf-8?B?dFd1QUp4MFdFSzF3RTRyTFRYL2VrZ1c5dC90MFhUNlNkdzI3NzB1bkdGWWhv?=
 =?utf-8?B?QVRFNHNHbFVXRWczNlhGSjZHZ2l6UlNLUVlyaHBYUkV6NUQ0MzgxTVdLejVZ?=
 =?utf-8?B?QkFHaTNKYUJnQzB6UUNhSTI1Q2hac08xTUdDUGwzVThGejNjTEJjQUdqWE5i?=
 =?utf-8?B?RVZoM0JtNU1xc0hSaE5Cak1pUGM3YytEQjlnVVd0dUFtV29WSCtOQU9NdkNQ?=
 =?utf-8?B?Sk82Z0FRZnBrc1JOSHNNQ01HT0lGYW5FZWNrZmxESzI4RlZwK05QZXNqTmtm?=
 =?utf-8?B?MnhBQmRkTm05OU5ENnFLUG4wTnkwZmtOOEs0ejRhMDF0c0gyTTR5Qk5xOXFK?=
 =?utf-8?Q?AwIlz5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlpRMUF4bWlQY3psNk1CTUNNQTBUWDM4WEp3OHBOU2Jwa2YxSkNLVE90ZS9k?=
 =?utf-8?B?TDhsdS9GMlBFYWJpeXNqMEN4RCtObG1sQ2dDWlBYYWVmUmdWTnBQSDg0cUlW?=
 =?utf-8?B?alJmdWRtelYxbHNiZTk3d1VDREU5eEVwQzBHaGFsT25CM3ErcTNHRnJKSnJY?=
 =?utf-8?B?UkNRWkphSjlxaTJ4bElybERJVVNjcitLR1VMTDJuLzZKQ3ZkL1BSVEc1T0pu?=
 =?utf-8?B?VVlDRTkyRFV4TmRSV080aWwwanM5bjlDRFU2OEd6a1V4RWxiaVd5eEpib2pP?=
 =?utf-8?B?QzVvcDlxUWU3TXV5OXpmZG5ienBWNEpPbnRNOWFmNnFtQkJGU3dXV01OYTYr?=
 =?utf-8?B?bHQrSW1USURzT2ZmbkJOSy9xV0ZNMThZSkxsbC9uajlFRWQyakhjU05YN2Ry?=
 =?utf-8?B?djFRSXlHa3AwdG52Qlg0TnBuZm83N0hVUzhkaHZjVnZNR0JzTzl4NGNYUEEy?=
 =?utf-8?B?anNoTlZxVXF0K2VnbHVMTGZuRllDMXNIdjBUZHVxZUg1QUpZQ0xzYTFia2M2?=
 =?utf-8?B?d0Y3ZStoL3RQUU9RSHAxVDVUR0ZGTmlmNnlFNThxZDNhdkFYQWdUVUlYNUpl?=
 =?utf-8?B?Z1hONUdCN0d3bHpwd2Rab1cyRVJOWHljbXk4Sm4yd2JjelRVSi92ZGJCOUJX?=
 =?utf-8?B?ZFdYVW81a2JmTHU3eU1FVkhoWDhVc2tjS3Fra3Z0L2pvdGowYTFnYmlxSDlU?=
 =?utf-8?B?bEdhSFhWVUhXMVBrMFZxc1ZNbW5VWFVnbnhtNzhSMUx5SndBWHZsam8zbmZH?=
 =?utf-8?B?aEcvOWVkVURueE9MaU1PMUdBMnZZZzNuS204T09WYTh2bXNZM081bkF6Y1RB?=
 =?utf-8?B?VmZ4RWRrL0pnZ1M5M0xlZGdueVI2eTd0aDdEdWlpa1ZwczhtSDlXT0g0K1R5?=
 =?utf-8?B?cllxLzJjcEdxalNRRlN1U0xzcDkrSWNhdVFBaWJsb0xjNmY5bkRPR3EvY2VU?=
 =?utf-8?B?dGVQQzlNSS9XU240TzNpd3dkTjh0NEV1U0xzOFEzNzBPYzF1NzdDTjZGSklm?=
 =?utf-8?B?ZE45dTdIenRoeWR4czliU1pDdkpiUGVCNHBaRWx4RHg5ODc5MVY2b2wvTkZC?=
 =?utf-8?B?NVhlZnFJTzczZzdIUGM1dDhQOHRMRW1CbVlEbEVnYUxzUFhVM3Jmd1JkSEh0?=
 =?utf-8?B?RjVZTGIvbFE5NkdNeEFTWXE1UW9FN3dIT0hLYTFPSWlFb3hkeEUvMjFPSUxq?=
 =?utf-8?B?U1pyQzgxajhkV21HNnpxbm03RW5LWGd1cS9YSDZyOUdOSURQNUZLenNHMVNu?=
 =?utf-8?B?UHlMQkx3QlphZWdBTks1ZXJJZUhKNFlvSUpxMVhEWWJJY2doMEpWUDBmZHNO?=
 =?utf-8?B?cU1CNTg2RjN5TnhiTktuOTQ0elVOMGZQNUtRVW9oa2o0WnpCcmVzb0xDWlpu?=
 =?utf-8?B?UmNtZUJ1T3RzUFNwY3dCRHFpNDJWV1lhaEhWY0p2dFBpbERKeHlSRmtNc0xW?=
 =?utf-8?B?RWVESEM0Z09lZ3VPV0lkdFB6TkduWkIveVNLanhqSEVKZTA1MXNnVFE0R2Zv?=
 =?utf-8?B?S2ladFc5Z0p6aVFBOWRsaXc2d3llLzhMYVNxR1Z1VFlwZ2NtZWRacVJobERv?=
 =?utf-8?B?ekVudDRrOVF0d0NVNm1zL0dBbGFpSHFwTytZb1BnY2VtZmtYaE9jL1VKQnkv?=
 =?utf-8?B?c0hGSzR4K1hUNklWendVODVzdXhQRVRDd0xPcG1mcjg2Vkg5azZpTjVjYVJM?=
 =?utf-8?B?bSszN0NkQXlKYTV6VHhnbjdtU2NyNFZrbkhqRVd3M09oRWVCMGZIdG9tT0pN?=
 =?utf-8?B?ZVkwZ2xYc0gzZ1FtUFIwY3ZNSFp1OVhuRkc5SjZacGVTeTVOSTRNOXBHMTZK?=
 =?utf-8?B?LzNVZytqNDBEMXhaSnlCWEw4RllTT202MkpXS0xROW50MzlUdmVNcElwK255?=
 =?utf-8?B?TlFOaDQ4UjJ4ZWpra1l3NGo4WFNEdTVnZDMwQ3BGcjBZdWdGVXMzdlVXUW1m?=
 =?utf-8?B?c3pIZmdlYmNHTVZHVmNBNFVEYlBTaGxYRXFwajdXbWcwUSs1U09nWHBPUmVS?=
 =?utf-8?B?MDBTejJMOCtkZHJ4Y2Y2Tys0T0VyaFl3UXRqY1QyNGNkYzExL3RkbjJZaE9s?=
 =?utf-8?B?T0hlNXducElrMnpIRlgzaXdtb2IvVUNHZFVRREVqTE1kOWNMSVNSTFZBRHla?=
 =?utf-8?B?T2ttWEFGZVNvOWgzVEtTZmg4L0Ryay8wVnB3TVVKaHhTbFp5SjFqRjBKQ2hK?=
 =?utf-8?Q?AQLWjvC+cIzFsEMkGKevpfZcHgQMRq25xr6qgRkdf0TY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A24DB5C110084349B5A77D174DB67801@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be904bd-4eda-4379-a6fe-08de1b6b6eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 06:28:56.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfBRtXHcUbdEGaByP/MxLmlUIxZZB5tgztVo/KTuxXasQ+v2tM51bfhZnddvp6in7YX4dfsWZyriDlbxzMN01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

T24gMTEvMy8yNSAyMjoyMSwgc2hlY2hlbmdsb25nIHdyb3RlOg0KPiBUaGlzIHBhdGNoIGZpeGVz
IG11bHRpcGxlIHNwZWxsaW5nIG1pc3Rha2VzIGluIGNvbW1lbnRzIGFuZCBkb2N1bWVudGF0aW9u
DQo+IGluIHRoZSBmaWxlIGJsb2NrL2Jsay1jb3JlLmMuDQo+DQo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlcyBpbnRlbmRlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogc2hlY2hlbmdsb25nPHNoZWNoZW5n
bG9uZ0B4ZnVzaW9uLmNvbT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
