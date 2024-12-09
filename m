Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828E214A83
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728770; cv=fail; b=TlaFx7whSRLtJOSxZ4vQFvYUYcXIZZAPCyj2PNPjNG67LteRBLwVxiWdJurNfcpADLNfkDgfQRC/XdehgZYF6n1QLZx1KwbWf2ipgYJg8vOo+waXMmqmR9utA6yjrNtuwv9wdYhkP0ealV3skMgTYtrLRkSx/Tw16mpg6eyamvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728770; c=relaxed/simple;
	bh=Z/EFDaeWdr393ovi2zpsEL7JHDHDo+vFVG4U+X/kA8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uxvf8rIsTGddxVZgXlSF3hh4eN0NJ+zcSqTb6aXfy0/we4xaL2XDBKlI0A8GCJUEQzYKkFXcK76HuSiydzM33JXGqCz5GHoCYmE3p3ROcUkKrUXHTE6XbeKefL+58qvH1CXlRp8FkBoONMvhe1gDh3VsFp4rIfcLVFz16pwm1Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fjSL411p; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fjSL411p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZK2UbwjD7NipCNYIhfs0rm2XZKKwE+tvHT59GYaKUhVilTkXlmMz3vpvFck6HqN2rNYWhk0hPD+xAc7FZDY9zRSO4ZDSH9fJkMzL/KmiyOK6yq7Trp/+Pp/lDu713TwoLkJtuGWcwDwVU6aBEONZC9YEge7khxBWNiw9yRP/CYytUPY1/9J57RPdGSS25oFHmDqrZ5Xt5C/JRfhYLkmPGxxTUygXk1b2ATUTUyFanH4Ek642WAIqma1etyaIoU/V30YRH6v5w4zoW7yhOyZ6xqHqK7c8m2PJe0KlgGpTXjQTl7CI3eIHfvNMYlMlJOGVLb5qVFdkm7vicpJSW3CYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/EFDaeWdr393ovi2zpsEL7JHDHDo+vFVG4U+X/kA8I=;
 b=VlAPMdtusjjWJjPpTxIsvo4VhnFRPvDr6PM8FjcyfMI+2fURzfjFAYvhKV9NeZZpO4gj0XGl1lbLbmaVTFlHTj8v9xPtK9X1pXKCwjhd2DltZJ0cfh017Um9aPkEt7ekECPqoDsja5f8iE0WsS8JttVdpSB+rvojQex034UF+Rix/rBJIY9RBDccazL2Jx9H7yBiLkGLqlPzRG9N0GQcknJCvF3tu7+7JEmy5SUfKHOvImnOXaq79m6xY2kn5oOYOUG2TR8A4jjoPy7KmXt/igOb/oOYRQwOiJJHLTiZOg/8pqPl5cA15CYLYQ0FHz+2R3jgJq5eR3K6kDdrdGGT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/EFDaeWdr393ovi2zpsEL7JHDHDo+vFVG4U+X/kA8I=;
 b=fjSL411pK+PhHA995vk5R5U0XyQkHTFps0GCmSUDKxdYhsmpc5XocnPFXWll+UBmgSYL7meNpigta4qgt0M04tipdJ9NbOgQtKOvBpZV0rsTEJ2hNTQfuillI9D4qIhuTf1MNp9h5lnavL1Sx9Uwz95sLkBwKuExSMnmzJN2oA34ogiK8sw+gAd/dnHBk+eGYwh6idgKu8sYTtvNMbnZFrjhncyFcP92fHjzYset2c52OsMNtzTaarnhXXconPRyLsi7LdPtKdSMQRTR+uNz9yCHZsDgyNq+ynWpr9woBXt5LJbrDRJ1owLjjzGKeWjCgL7rhGbA16e3+rOAc+Q1ew==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:19:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:19:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 1/5] nvme/rc: introduce remote target support
Thread-Topic: [PATCH blktests v5 1/5] nvme/rc: introduce remote target support
Thread-Index: AQHbR+X7k18jx/jDD0iVm++09H3ZW7LdhY6A
Date: Mon, 9 Dec 2024 07:19:26 +0000
Message-ID: <68812a75-e3be-4b25-9732-e221661dbdf7@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-2-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-2-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: b254809e-dc1c-437a-075c-08dd1821d02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SllEaGZnVVkyZEFXRVliMHVNcDdJeUZPWXl3bmc3WGRNR1dOTmd4UmtYM0pR?=
 =?utf-8?B?WHRBelFISXRTMEZLdHRzOFkwYVcvdmZ3Q1N6eHk5VTNzMkhVZU9yRkxVa1c2?=
 =?utf-8?B?Wm0wdDFvc2dybUxkUUtCVEdieGpVVU1KQnV2bDJPamNxSk1jMzRzQnczVXZx?=
 =?utf-8?B?RjF4d0piQW5IbE5ySnN3eHdrMmtaOGdHYkNoRUllelhLbkRyb1BRL0VWY1BI?=
 =?utf-8?B?WlhYVHdzcjNmMFplazZrUFR6T0pIUk5ESHdUOThOMkhwYktnWEtDQytlZXV1?=
 =?utf-8?B?Nkw3N2IvdXdMZDhqQURJWjgwcTJQdzMvTXRTSEdTMW1pMmgwakZjMkx2emto?=
 =?utf-8?B?TFdxM0VwVmh6U1duVmViMDVKZ2hERWZuMjVOV0hFOWVPbCs5SDlDQWtNakdM?=
 =?utf-8?B?amNjWVUwM0QxcldERjB3QTlySUVSQ1VxNERZOUhIU25vY25JS2F2TVlDM1dQ?=
 =?utf-8?B?bFNralRPVml4NS9Gbks0YS8zYWd3aXJ3eTVxWjJOWjY0M3AyUjlrVXd6OWI0?=
 =?utf-8?B?KzhDZy9PR0Nzc0NVeTZMSkZWaHNaU0VDQWhZOHlsRjE5WmJqbXZKaFVQZFhE?=
 =?utf-8?B?clJ4eFVtYk5ER0d1TmJheUFCbzZ6WlRJazNQU21MeExLZWIxbkpMdForZEgz?=
 =?utf-8?B?bjlVYzhvNGpockxZOENuSWF0QlQvcHNqaXZEYm5OYTljbzVibWNVVDkzaFVp?=
 =?utf-8?B?M09pbXA3a0V3SE1LQ2FaV3RaVm51Qi9Xbjdwbi9ZVEQwZGtOYk0xbnNQeWlN?=
 =?utf-8?B?YnZWaEtlYkJJNHFqMmNydmRzYWx1djFoYkN1aVFmaXlXL05OWExiZENoMkRy?=
 =?utf-8?B?QllWNEFQNFpobnR2cUJwS3FPZjJ2cGphbXYzRUdHcjhXYWtVK3F0VWRuSktv?=
 =?utf-8?B?N1ZaeC9JWXNadlRUNXRKSE14WEhUM2ZybS9qaitBY2tZSktTWGhPMkgvMFJ1?=
 =?utf-8?B?TkN0N2RVelVGY3g1bUhYQ1FtQTBlUmVGd2U1K25UV2Q2SVB3aFBKcEtIZk9z?=
 =?utf-8?B?UUdTT3VFTlJoMjVYMWhEQWpxSXltNEsxL21CWnpVUG1aZTRwcld6aXRVeVR1?=
 =?utf-8?B?WWlrbWszblJic0MvT3Z4cEFucDkxWXNFbUM4N2xvZ1pXc05ab1Q0K001RHF5?=
 =?utf-8?B?Tk5mZ053QUVTblpic1FHWUsvUHRjc2p3Nm1oeStkQmhMM2IwZXJwZGk4aFpm?=
 =?utf-8?B?S2tmSmZwRnBRR3c2WVZsRmhxVmV1bitvbzlKQkxmNExvOWRQNkVwZmpJcE5M?=
 =?utf-8?B?TStpaVpZeGs4MFVPSlNWaWplSE5Gb2w4SFlVZ0M5RVA1MGtVRUdVdi9SSzVu?=
 =?utf-8?B?cEI1RlBNeWd5MEdsdmJTODdlS0M2Lzhza1M0anVqOFBWKzNHQ0t5T2NGSEZh?=
 =?utf-8?B?akZHMHhLNzRmQjdRWDMybG1uRDZIL2d3SEdlczV1eXJzUlpCaXJnTUFEMzQy?=
 =?utf-8?B?cVRCTU1CSDQwbjREc3Fvc2ZINkl1ZHdFdVpTN2EwZnRvb1Vza054ZFMxdktm?=
 =?utf-8?B?eHZzd3k2am5vQ3ZIZmp2Z05VWFhuRnJST2IvT043L0JMaFN0dmppazVXakZF?=
 =?utf-8?B?cXZYeEE0Qm5kRjlJK0FMazRjbVJLK2EwZHR6UUlvNWNFZWs1dGpPWVA0cVlk?=
 =?utf-8?B?N2szMWpiSW53MExOVnh6MGdOcXVibDhSTjlUaEpaZkJ1TEkrdUtsZjVxVmh5?=
 =?utf-8?B?V1VaWDJsQWZ1bU1zRXAzV1lIdlZ5N3hTa1RtdXVmU2tmMW4xNU85aHM1bXV6?=
 =?utf-8?B?NnpTME4zdG85K09rNG5LdnByenZRUjUyRUxRTXZ3K2l1TkVYeFVxOHVhRnVO?=
 =?utf-8?B?UXZHTnQvS1JHdmhaY1ZmaXRNTS9BQnJ2NTd3L242VEJYZmxaOXZqeEdncFVV?=
 =?utf-8?B?THV1TTdVS3dsamt0dUVSdGZCZVRVMVBKK01EMEdSVnB6Zmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3FZZnBpT0s4dXhYcWJsZjNjSE5WeEVPQmxyZzdiMXBDWm9qZS9jQUx0TkpV?=
 =?utf-8?B?L0ZKVlN0enhSZlpTclVZV084S0NmVjJ1dE5DMnRSZXZ5MGZMUS9Qek5wclZl?=
 =?utf-8?B?Nm5WeThUU2ErM1NhbncxdVlzL0QvTDBSWTJVa1NCeHREVkc4cmxtZVdVTkY2?=
 =?utf-8?B?NTdGSEphcVZsVnl5M1RVNmFuVkZITSs2L3NFTEUrVFVVUkdlVEM0anIyNDhN?=
 =?utf-8?B?dkFhSDdDZzl6eDcrNUhldTNndzNrTi9DeWtYMnVPaHBsZndqVmh1Y1dDaXBz?=
 =?utf-8?B?SXZjbTE1L3I1cy9oUVdFb1l6SW03OVNTOUxNMERVRDZKQmV1WThhZGt3TE9D?=
 =?utf-8?B?b08ydzBFMFJLSmIxSXQxd0ZqVTN3aVV5NnluNDFMS0RuNTJWUDErQ3FqYmVU?=
 =?utf-8?B?Vm1nUjh5YkV0U1F5eUN6RzNZT2ZTSlJaeDg2RTVjcmQvRTYyTVpxRzZ0Z2kz?=
 =?utf-8?B?VEZDeGlvMmkzQ0RxNVR1OWZlR2oraWc3bDRIeTlvenVMRnRvdlFYOXlmZW5M?=
 =?utf-8?B?aGZLVENyS0RtOEM0ZEt5SEl4NlFQbng5WWJDSm9idDREV2ZYYjR5RGs0a2Iz?=
 =?utf-8?B?SERHTFVjaXJTNmpaQll4QTRLcmVxbmtTcU4zeXFGMGEyTU0xa21Bb1V0c3Zx?=
 =?utf-8?B?ZVBXdjZydkhKSlBuSkFXWjVadVU3SExsenArbG1NWUkzQWNJYUR6MG5KYnNE?=
 =?utf-8?B?S1llVGFGR0IxUU14R1VoMFhxNDA5TUo2YW1UaWZoOURaNzBqODlySUYwSFFy?=
 =?utf-8?B?Snp0V09SdjdPaXJQaHg4QisreUtHS1dUMWFMMWQzT0FLM0p1cE1OYkZDMkw2?=
 =?utf-8?B?UUZjNkphdkROZ3VrU2RLWTNWWWZxYU11UFdhSkFzeU55dWcyY2NKRTZwVTR1?=
 =?utf-8?B?ME90VWloNEgxbGRDR09PZGQ5TEIxazhMNjN4WGpMMzh1TUpMY2xIam04dmVV?=
 =?utf-8?B?Ny9KcVhjNjJlQTVoRFptNVRCRE1GdzU4QlI3aW45aXdwbTNnWU81L0xweW9q?=
 =?utf-8?B?VGM3QWlSQnQwVlA4SHJBMkJLYUcxOXcrcStEZDQ3TTRlcU9zNGRvb2FMMEpR?=
 =?utf-8?B?eXNwbFZ3aEpOSlFTVGxHRUFzQkJoY0dpVUdaRjU2b2xHR3FCR3E1Wk1hZGdq?=
 =?utf-8?B?cHJNMkVMTG15NnJBTjJWT0RTTnRzekplV3lwNkNGVncwUitGb0RkbXZaM3ds?=
 =?utf-8?B?cEhwL0sxUHFOd2xiQXowOEFsSzVrcjRKL2FMT3RTQzJVVlE1NEhNVlNzZ0R2?=
 =?utf-8?B?RjAvVWp1NTN2b0I0TFRoTWRZcUpaWjRtalArM2FwYTJ4OHpydVU3S3VaQnR6?=
 =?utf-8?B?WXZ0L3cvaXR0bmp3ZFVEZFVuOWFxQ2V1WWlXb0MycnYzRlVKaHpmam1BR2Fl?=
 =?utf-8?B?SjhSRXhMWmNXcUt6SFdEOElweFlIZGdkaVZDZGNSekNUNW92M1dHRGVhS3Ji?=
 =?utf-8?B?OU1JMHNDZWFaYkVJd200M2tNdkJVaWtuVmpCeUNsZ2FhdENWd0dPcmk1RGpJ?=
 =?utf-8?B?Lzh3cHRxZVBwcFZjVUwyTXdaZUN5M2dIOXdtdFdqZDBPNndvd09iUlJHcyth?=
 =?utf-8?B?bWhxWnQ3U2xpV0NBdjdIdldjT1V3RXVQWU9BKzg1STVVTmw3QXNubzdCNjdF?=
 =?utf-8?B?V0kraDR2SE1VVENFMEc3NEZ6VlNXb2hmN2g4NUxyNUd2ZVcvOEkxSFlwZFdW?=
 =?utf-8?B?R3pEa3hkbTVadi9SMkMrUGJhS00xSXBLaVgvQ2NhMGtBOWZOSjFCcGVHc2hk?=
 =?utf-8?B?WitQT2VnbFh2MWZseStVc3JwcGtVWWNha0VXMEExaGRmS0J4SjhDRW9HcEll?=
 =?utf-8?B?VER2L3crUEZhV283VG1haXUzdWkrdCtaRDh3UlJodVNxRk1NS3JiOTNqZkdy?=
 =?utf-8?B?YTBDclZsK2hGRDJXQjI0UHR2b0JGTnBZRUtWRzNwbVJmeEI4N0p1WU4velVB?=
 =?utf-8?B?UWNUbnNJY2ZEazFqOHdveUdsTVh6cWpJSkNDakZzczdtN2Q3MkRMOFEvMG9i?=
 =?utf-8?B?WklJMEhxaE5vanBvekxZYzB1Rk4rWS96SGR5N0l6Zm0xcytXVXRkRkw3YUR3?=
 =?utf-8?B?SGltakNQckx5MTZtR0VOTGR0MVhvUFhzWmxoSzc5Sjg1MTlrSVJtQkVxa1Jj?=
 =?utf-8?B?a0pEaUNSQW9kMzREN0xnM1J5Q3NDLzNKeGRGWDBoUUsrZkRNd2h6ZHlFVjJz?=
 =?utf-8?Q?Fx0ydQ+BWOsUJVB5NsH3H1MD8lsj8Z+kZOEBzMnx4Q+q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <767DB0B88D88DC45B00E34658966E51A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b254809e-dc1c-437a-075c-08dd1821d02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:19:26.1463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //udsOD1/HfqY+AEPKIghK0hcaCsBg8OmRmUfi+MzweysnLWFRisjjGMN3eCUNJn2rgNU+I1cqcjA9o1ZiCvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

T24gMTIvNi8yNCAwNTo1MSwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IEZyb206IERhbmllbCBX
YWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4NCj4gTW9zdCBvZiB0aGUgTlZNRWVvRiB0ZXN0cyBh
cmUgZXhlcmNpc2luZyB0aGUgaG9zdCBjb2RlIG9mIHRoZSBudm1lDQo+IHN1YnN5c3RlbS4gVGhl
cmUgaXMgbm8gcmVhbCByZWFzb24gbm90IHRvIHJ1biB0aGVzZSBhZ2FpbnN0IGFuIGFyYml0cmFy
eQ0KPiB0YXJnZXQuIFdlIGp1c3QgaGF2ZSB0byBza2lwIHRoZSBzb2Z0IHRhcmdldCBzZXR1cCBh
bmQgbWFrZSBpdCBwb3NzaWJsZQ0KPiB0byBzZXR1cCBhIHJlbW90ZSB0YXJnZXQuDQo+DQo+IEJl
Y2F1c2UgYWxsIHRlc3RzIHVzZSBub3cgdGhlIGNvbW1vbiBzZXR1cC9jbGVhbnVwIGhlbHBlcnMg
d2UganVzdCBuZWVkDQo+IHRvIGludGVyY2VwdCB0aGlzIGNhbGwgYW5kIGZvcndhcmQgaXQgdG8g
YW4gZXh0ZXJuYWwgY29tcG9uZW50Lg0KPg0KPiBBcyB3ZSBhbHJlYWR5IGhhdmUgdmFyaW91cyBu
dm1lIHZhcmlhYmxlcyB0byBzZXR1cCB0aGUgdGFyZ2V0IHdoaWNoIHdlDQo+IHNob3VsZCBhbGxv
dyB0byBvdmVyd3JpdGUuIEFsc28gaW50cm9kdWNlIGEgTlZNRV9UQVJHRVRfQ09OVFJPTCB2YXJp
YWJsZQ0KPiB3aGljaCBwb2ludHMgdG8gYSBzY3JpcHQgd2hpY2ggZ2V0cyBleGVjdXRlZCB3aGVu
ZXZlciBhIHRhcmdldHMgbmVlZHMgdG8NCj4gYmUgY3JlYXRlZC9kZXN0cm95ZWQuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gU2lnbmVkLW9m
Zi1ieTogQXVyZWxpZW4gQXB0ZWwgPGFhcHRlbEBudmlkaWEuY29tPg0KPiAtLS0NCj4gICANCg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg==
