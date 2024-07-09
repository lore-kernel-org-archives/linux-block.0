Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E21EA80;
	Tue,  9 Jul 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486484; cv=fail; b=bBRw52XDJ1CQKDxq5NVPAd2UC5ExijvmRG0KKT9TXhvrEegDJZwKcgWMZ6BKKvjqbweNuTdDTM9RhS+9jtJQXSVL3iJBgSSkE4E3US+dxFMR74mfaZnnwEIVbPiivoSgo9d4r8IYSbaEJCs2hBt2kRcz/nt2YRKejI81nXnF4Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486484; c=relaxed/simple;
	bh=IVAEc/U5J+0hMc7a/RpHwtjfFlB6q+S4F2VOLD1IRZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BCtMYKLME4tZdDR1mEZiWGjw4PYw4zQnVbW76mFRWUgvfDNeRueFvK+mLe1o/yZp2+Ztp0MJIDtfwZvQ2GZnnbrl9rDrUn5qHObjPQbpHS4D0SwPfzxBW0VyQuGaHcoxFjxCzwqCp435/ta4V7MPLo7tiy0b3rLH0OKo1x9eX3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GA81R3od; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GA81R3od"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvOIdcU4F6SsiBdIKRI682zR5wIyz4x8smxtzgHt3Sca7ujaSI7+qeo7zkDM5B+in0FiB2QIGz41qQQ6Ka90MhXec9BxECpR2JXiHTbG77vjjCbBiIoFIykJkUQ9DMESdmxAYn0YsWnKYBLNrVXOaDOIp5GVvwiMafpW8Jt9ZUPoMJBPJjA+WScYUhGsxAoyHAP4264XuwMz4ZQEs4+Zalz2Dok7wc88g26PgkyjpMteuuUKcDNTl12Yp0wYClHRiADijICYSjRKOtkmRVddt3qWP4RtqC64s3hISUxNzBAFv5q7WIcDhEYrDi9VnnTNJ1rfE9GKXVLULE129NKYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVAEc/U5J+0hMc7a/RpHwtjfFlB6q+S4F2VOLD1IRZE=;
 b=jMhPYf3M/Kv/dcSzqeFpqGBz3UUs3Rx7rBDB3kzssOZDfFlnqxTkq2gkTp5FiOrC8g6lf3PJj/eKi7jgq2GPM+ftvexqtr67XCVuAvslI4EaIm16XPBvC4HYB/L5bkfOqapRyoa3pDzZG9//FP+FHKGDIYgyVg4PzGZJx9JBX2K6Zf6wWSapNXScQP3XQHOBVS0Maf0+k1QVqAUKWaPWUvFKIurmN41Gk+UK9dEa48EM2HHxBvcXbyjQt5CkW3EQ4Se/GLLbzn7IziIdsAZxmy6DFV4ZGi1i3hy3RrLkC0DHUp9hxU5ttrI/dU4jtZU9dA/ldl2DD287fHjP3BOWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVAEc/U5J+0hMc7a/RpHwtjfFlB6q+S4F2VOLD1IRZE=;
 b=GA81R3odMntOCBhJlDlfDAsS2ZdGkY5g8mhFApodX2XOTApKduQ3FLTvuozlWBsx++zOrfXV7pz5Xkf0SvWtEOAa3DTPI/8UIx05EZ5Z+nZ0WnPA88W7sZu8xVQUfZmiC756Qiq1gEEQenQyHJS6RR0ZlniRVp1/KhjTN31TmhLaW1z3OYd7kxP76Tlg1S3/voon+ibyUdaB9ch1aCmRCk2ex/6QUOJLgd/lXqNZ6++rNmNdQAmRNszQbXNfE/jNyEcmBUWRAnRfTD2DlrzsP58bICW3gojoq4wUPR74evo+v0VWOVkt+F6m0XHpwGAsDZYhgAvJjPcZM5lkiRDM+g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 00:54:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 00:54:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Md. Haris Iqbal"
	<haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/rnbd: Constify struct kobj_type
Thread-Topic: [PATCH] block/rnbd: Constify struct kobj_type
Thread-Index: AQHa0Wcu6kuiHL7hm0C79mwCTRBsFbHtkliA
Date: Tue, 9 Jul 2024 00:54:39 +0000
Message-ID: <22818675-77dd-4a51-93b5-dd9f61265211@nvidia.com>
References:
 <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
In-Reply-To:
 <e3d454173ffad30726c9351810d3aa7b75122711.1720462252.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8753:EE_
x-ms-office365-filtering-correlation-id: 4fb68a3a-142e-4422-d285-08dc9fb1b647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXF6TGd1a2xJajN3RGQ2TEl6UGR2U3J2bWFQZkVpRFVjRXRVeXllbVdWL25j?=
 =?utf-8?B?NnFMVTdrNXJEcXRRTVF4Q01ERzZaZmk3bzFuVHRRcEdXS25EanpRWTA2ZmZD?=
 =?utf-8?B?SEV1NDB5bHoyVG1RUCtFaG9ldlhFRFBFLyszS2ZTQVkwQkUrL2hjdnIrM3dN?=
 =?utf-8?B?NHlGejU0UGsyVTJCOERDSG9xSHdWcnVLanZXZjc2eWovaXArRnlrTDBkOFhS?=
 =?utf-8?B?VXA1bkZQTFhpWVZWOGU4SnJ0aWVJWWM0b0dhSkRuWjE5Q3ZzK3o1YWt6OWRL?=
 =?utf-8?B?Znd3NVhIUVNzY1hIMXJkU0owaWRIbXFlUVFacllQelk3bmhvWHBIbTYvZHBX?=
 =?utf-8?B?VytkQThmVVJ5MWMwUU1JU0VJNldwTzJvRXAzWFptZ1NWUk41dFlIZTAyYlhy?=
 =?utf-8?B?Rmt2Ukp3cWpqWmV1UlEwMk9PK1RINDdCQXpoUkVIbXNLVzEvS0E3Nk51UVNQ?=
 =?utf-8?B?bVJIZUwvWEhCQUROUmFxQzRHeGNGdE5wdEdTUGhUam5veFVFZTZTbUZCV0Zj?=
 =?utf-8?B?dEI4SXZhYmFUNDVnNW42MnF1TXlnWjhrVUo5NmFMRWg5Ynl1dDZFSUM5Y1hy?=
 =?utf-8?B?eVRKUlNvQzFnUEFscEU2NGFmQlUzczluaGZJYjNCNHJVb085UWdQL3h1c1A0?=
 =?utf-8?B?UVozR1M2bVVVSTd6Q0JTYjJlNHRSUEMyQ0trcXptNVJYclk2OGNxWERtZFN6?=
 =?utf-8?B?cStEbFZDQXhxT3JUU0QrUElLalVXcmFjWGoyODBQUlc3MDFXSWNWZGJaODE4?=
 =?utf-8?B?MWpBeU41Mm12ODJ1em5OSGRmQW83ajNubGhzUU5nM041MFJLaHNNRkNTejc2?=
 =?utf-8?B?SEdubGhnWlhYK1NXRzRGMUtyeEduYW9ZaWp2UGxwZnpwNUN4bU5QMEVGSnp4?=
 =?utf-8?B?Ky8zK0VRUjZXRGdtbTR0Q1MxUjRuekpHL3BHN3JzN0lHcXV1ZG9jMXFvZ3py?=
 =?utf-8?B?cC9mTGduZlVYRVQ5bE5JNThCcHJadEVQaFVtZ0EzbXUvaktRVGIyMTJkNFpS?=
 =?utf-8?B?VkJxQkFjNmtzSVI3L0NOVWg3RkxFYXZOS0RyWlY3MGdzQzV6VEJSamVjZ0dq?=
 =?utf-8?B?UmRKQVVpTUNsQndHUHRLZjh5SVVVcXdvc2RPTlNzMXJNa1ZGVnNaekNZbkIv?=
 =?utf-8?B?ZW40VERtejNnWHR0OUora21ONGZFVW4vM05xTWJ4TVFFYkQxUitGTXppcWFV?=
 =?utf-8?B?eS9uSFUzNlkvajNVRDdEVjQzMm15eldab0llNHFsQXpjdHBrVGlsMGR2ZGVY?=
 =?utf-8?B?RGdpaHFGdnJlNXJpUDNadnNrQVB3ZUozdDFjd255ajdSWGNIOWZuVHhaaVhJ?=
 =?utf-8?B?VFBJSUV5eG1HK0RpanBmSjc2a3RlUmV5V2xTdjBGRFR5SERFZXdyWXQ4L2Ns?=
 =?utf-8?B?T01pSkZUYWlnSHo1SlNMNDYyRUExZ2xHZlNXK3RVNzJGVGluZzZNWVFnc2dD?=
 =?utf-8?B?QzVLUmxQOEcrdE5qZFM0eHlSckdTb05ENHV2Z25Daks4VkI3REVCZ3RuakFI?=
 =?utf-8?B?QnE3cGpsRGkzcDNvblZXMzJkVEgvdnpYTHNQcVhEWU8rSTBURUlsRGl3WEVh?=
 =?utf-8?B?R21scmMvdk93M01xM2NKbzBTbFlPYnNiaWRaNktvSW84aDdOTFRVRVhqeWEz?=
 =?utf-8?B?a0VhUEI0M1loWThuWkZIL0ppK3dWSnMzZkJlWkZwbTl2VXgrUUN2dFFwM2NI?=
 =?utf-8?B?WHdYdkJjR3lONlFKZEFVMjJUY0hRMC8vcS80SGlkZVl6VUo5WUJ3YVpsYXE5?=
 =?utf-8?B?SCtoeWhhZkQxVnJTb2ZZdlRHdTB4YjdFR2NWSTM3L0Z3UGU4anJYTVZRQzBL?=
 =?utf-8?B?amt4VlRHK3JjVTN4TW1ZbEY5UEpVOUh3RVB2WVdDZGJoVmo1eTFlUmV5MUJq?=
 =?utf-8?B?QjZORnFEYWRsSXNMa1NhYkhhN2lHOFdSNlNqMFh2SkliMkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVUzQXNJejltQkFlQUlkMUZiVEQ3bWY3TTJ3UGxBVnQ3bU5FRUlrK3BKV1l3?=
 =?utf-8?B?TUt5UmNoZTlRSUk3K1QvM1hUSGhlYTZJVXFlUy9ueXZlODZYRDVpQm0zOFpu?=
 =?utf-8?B?THF5RGs5b0VGclIrTFRXZUxkZE8zQXR2aE1uZXVkUVZ4QkplQW1qYTQzSm1J?=
 =?utf-8?B?RmkrbHN1bGphbjhuYndVUmpPcmhZeWpHbnhzZUg0RlB6YU9LbWtZMzlMTFNQ?=
 =?utf-8?B?d3hQQ3lzMDJrdUl6ZnpxNitHamNBUlhuYUZ1Wk8vcFZrM1h4OE1yV0xiZ2VF?=
 =?utf-8?B?bEZmcGFuYnlJWXpZZTNiOVg5MnhqS2ZGa0NYaHI0c0dnbnhNaUxEWXJwcFlU?=
 =?utf-8?B?c05KMjRpMWJuSGE5di9EbXV2R0tHNkR6VDN4K0ZqQldrTEVwM2hBUE9zS0pF?=
 =?utf-8?B?eklyS3diSHB2cXFRcXFlbVA1S3FUYkRvMk1pcjR3OXdFSGthUEtQalFibHFH?=
 =?utf-8?B?QUFFT0ZCRlFZTVhqSnpuWXozUEFrc1ZvZlhXMGxubkg1WVZLMm82N1JaRUU2?=
 =?utf-8?B?MTBaNWVMTzN3LzliUjllckdSU1lTUUFJajlHR210TTRHZm92cFhqZWIvZWVu?=
 =?utf-8?B?OFNWVnlqZWdPUncrczNPNUhORDU0OXF4R3pZamxRdmtkbjBCWnJLMnhnRHJt?=
 =?utf-8?B?Zm16RlByUVViaUt3V0lodnBqd2dCZFU4UExJaU9URVR4cTZuWG9rMFpqSEZ3?=
 =?utf-8?B?QlBLaGk2eTk2Z2ExVEpwbDdDRGx1WmdiN1g1QWdBdmF5eVQ0V0hpSUFoLzdv?=
 =?utf-8?B?VnUxd3dJTDdOYTlQY1dOUnVGNFl2ank4Tm9JbjhoRCtsWVlmcGVVZUVzQ1ZE?=
 =?utf-8?B?V1I1bGUrNzgvNGZPY0tldkFRWlBzcUJCemxKekttbWRBY2xaRGxyTk9PdGU0?=
 =?utf-8?B?cGNLZHYxcHlLd213UUllRlVzcHJLNEJSYmQxRi92SjNBRTc1dTB5K2ZEUlV3?=
 =?utf-8?B?dFJHY1pSaUxDSWdnZ1FpTHhXQjdJb2U2QWkrZ3JFTFFsNmJmejQrdkNFdkRD?=
 =?utf-8?B?WGh4ZnB5MFN2Z0Fua1ZhUWQ3bThLMmdvcFRxUTZJNG84ZE1kYkVNNGVWMnFI?=
 =?utf-8?B?UGZqeDlvSStJOGprZ0t1eWlRZ3JWMlB0SFQwYm5TRkpJTUdjdk9ESmZiejFN?=
 =?utf-8?B?MTFIR1NJR0RHTzc0dExPRXUxNVlJREhzZGFjNDdoNjhQajl5bW4xYitpK05q?=
 =?utf-8?B?RXAzVktFUktTRWJuTE1rK2ZZSGNZS1ZlelRmVnRRaVRDc1JTTXhlSXFmNW9s?=
 =?utf-8?B?U2dRTUFpSy90UkJhYWIyMGNLMzRIRW1lQ00zQzVGL3NWdXZJZDh6T1ZnSUor?=
 =?utf-8?B?S1hRbEFzTUlzOEh1Mjg3a1JBcVplYUJWYmZ1N3NJbFZFZW5nOWhVVUFheUtT?=
 =?utf-8?B?OHVCMnZMaE5XNWM5U1BEc295QkNpbldPQkNxeEUwVC9lMHdNcHB4S3FtWmxn?=
 =?utf-8?B?VXJzampmdVRONDBDb2xaM0tRcXMzSk16RFNnYXQxMDBEUnV0a3VWazd5Nm5B?=
 =?utf-8?B?eTBSanVaUHU3MnpYUFRZWFU1RUx1Uzh3eVJBVzd0eXRwR1c5NSthVUtyL1h5?=
 =?utf-8?B?ZkRQenV6WG5rVGVYNVVWMUVvR0lmajRTUTN3OHZ1VDVadFpBWmJpbTQ4alg2?=
 =?utf-8?B?TDNaTkV0SVppTU1tMFR4cGxmYldUOWpPSHpQbkJhbDJ2OFc5bzRzcEw3bS8y?=
 =?utf-8?B?emhBR0dJeEU3WkZNbXJwVWthOGYzK3pOT3pDeEtTN2JMK3AxbE9xMW9abUlU?=
 =?utf-8?B?VW42TTA3YW85bUp0Y091Z0NOTksyV2hwT1ZKcVczNHRYMk5hdEJPSkZ2Tkt0?=
 =?utf-8?B?TkNobGh0Z29tK1MyajV6VUdVYjFXN1EzNVM2eld1djJNZEhnczQ1VDJvUkxx?=
 =?utf-8?B?ZFdnb3hsMi9yQzJ3cVkwM3gzalJybitiUkZMcXJ0WEVyenBQdnd6U1pUenQ4?=
 =?utf-8?B?dnZnMFFadlNJNERYdDNUZFBIc09EQTBuSUd2KzM3QVlDZnVRYnlzY3ZuY0pH?=
 =?utf-8?B?bHN2ZjIzZmJ6dHVLVUpCV0VqR3dMMWN5dTlDMjAra3JyTDNFNFFZM3lqU1pJ?=
 =?utf-8?B?WlJuZ2dVU013SFJ1K1V2Vk9oRmdoWEx3alVzOVYwTWtRYXQ5ZnVNWmFuTnp6?=
 =?utf-8?B?elYrTmI4ajI4NFpxNkZjYWJtODBMZWlzK3pTTHRZQys2QytTZ0doSGMvWmVu?=
 =?utf-8?Q?/JmQAf0s5sdgByCN3u8NgyLSOgrfJXSXySmdDxsz7HUr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C674064CC469468BF1B2C6E64CB4C4@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb68a3a-142e-4422-d285-08dc9fb1b647
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 00:54:39.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZjIc735U1WJb4Eu73cSmNgqZo4UC0vy+r9O/QH9UapArP1PgEIfJM0sBHVUuoliHYsmSuHSWIwhJqCQwmZ4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

T24gNy84LzIwMjQgMTE6MTEgQU0sIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4gJ3N0cnVj
dCBrb2JqX3R5cGUnIGlzIG5vdCBtb2RpZmllZCBpbiB0aGlzIGRyaXZlci4gSXQgaXMgb25seSB1
c2VkIHdpdGgNCj4ga29iamVjdF9pbml0X2FuZF9hZGQoKSB3aGljaCB0YWtlcyBhICJjb25zdCBz
dHJ1Y3Qga29ial90eXBlICoiIHBhcmFtZXRlci4NCj4gDQo+IENvbnN0aWZ5aW5nIHRoaXMgc3Ry
dWN0dXJlIG1vdmVzIHNvbWUgZGF0YSB0byBhIHJlYWQtb25seSBzZWN0aW9uLCBzbw0KPiBpbmNy
ZWFzZSBvdmVyYWxsIHNlY3VyaXR5Lg0KPiANCj4gT24gYSB4ODZfNjQsIHdpdGggYWxsbW9kY29u
ZmlnLCBhcyBhbiBleGFtcGxlOg0KPiBCZWZvcmU6DQo+ID09PT09PQ0KPiAgICAgdGV4dAkgICBk
YXRhCSAgICBic3MJICAgIGRlYwkgICAgaGV4CWZpbGVuYW1lDQo+ICAgICA0MDgyCSAgICA3OTIJ
ICAgICAgOAkgICA0ODgyCSAgIDEzMTIJZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtc3J2LXN5c2Zz
Lm8NCj4gDQo+IEFmdGVyOg0KPiA9PT09PQ0KPiAgICAgdGV4dAkgICBkYXRhCSAgICBic3MJICAg
IGRlYwkgICAgaGV4CWZpbGVuYW1lDQo+ICAgICA0MjEwCSAgICA2NzIJICAgICAgOAkgICA0ODkw
CSAgIDEzMWEJZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtc3J2LXN5c2ZzLm8NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5m
cj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
