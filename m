Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772222F152
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532611; cv=fail; b=lU51mo/3FuVzVJeARPC2NxvC37acCwa6UIaP36pH9RIC/JQsoUEGjQ+jZ84Wu3Uh+QUNpoojn+aNnaEvS73nO0wNP6gGIKROg1x8A4yL6tmTtG7bWZYlcNXNDZhcq/SDAcP5ky+LvynJEepsH2kALXj/L30QLlKx+wCvjbR5CCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532611; c=relaxed/simple;
	bh=qzP5uj4Fhl8SnrPrh/5V0HTxIoqMkyuQiPvuWdlo/9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSXHAGs7WWItHdrS5Wl2CrioCM9OZ20uZV80AdGsC+QxTpIoiJ1TSb1Du9a4foT00TOCVmHIduI87KV0msdV2ekKAKn7kYDitGEt/5ZImCJFT4LpKhyDnlwCfsF7P+PLrMcrpNogzm93pV6D08zL0tyP43uO893W3G5G6uEcyTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e6c7UMom; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e6c7UMom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyEEtIv0w2FvfdNh5jT5UCjDKBc9QsT3yjp5SOtyqCXK8EYJx0PB9X1O38Dwxv+YDinZMnBHsSq5MrltvXmgmfhCwXyPvSWHXXbSNteZd3dJLnfzZVBTIaxB8e/af5UeROkxa6/AR2XwUefLI2gMJyH/rAp3GqvpHVhXj66/j3mSxZjXULFfGd0BqeF7akFneuPohW+ulm4oJnd5D64cW5xzyxwy0nR7gcEjt2ynp/SObAVg2UG0RZQGXsloUwWFVs2JalUoysZbof7KFciaJ6O+rHql2s7lijFIaQSjLtNzMe0bqlCTPKdCZWtXRIjbJdDwEtDwqd3/wbjS7h47NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzP5uj4Fhl8SnrPrh/5V0HTxIoqMkyuQiPvuWdlo/9E=;
 b=LiLdmtY9bC7SWlmP+RZoiqc/Wxame7E8/csbe9POOz3mDygPm9BQZ9R4J8oldYngxWZlmq9S1a94TUQv2IGNE990DfebftzC8O7cD9x6qcVyBvVEn2EOllgGzE1iVohFCMyQ7iwwDxvNAU4p8HJBpMeojhgWYsi4iqBZcF81b1UBKUO4I/P+ycyQEpptT9vf5NZo1OgoW+ieIjmPqtjT1NPATk2sqEl78uVtpSSgSe+SBZq2DEiCT9/Q8NPBqNpCDR6xNMThg/MK4vchG5FWIiM3MOHz+X0GyCTt+hrE4z9Bipnr2ZQgBLQTxaJaD8J8DHX80Xe+K4jAG2b3CgsFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzP5uj4Fhl8SnrPrh/5V0HTxIoqMkyuQiPvuWdlo/9E=;
 b=e6c7UMom5Od1QouolYHkuTkTIuQrxZ9Q8eg+i+M048kaujo+tgTNnXmf3zgEWK7vsrVZVW4lH4WYBfq/mdzf95Ss6s22BxbxpJMkzFrm06HFp7hVt+otn3jgZIYEtjWrJY+yJDyMRgacf/2B6IGVYNjDNijdFIvmqqNKg0Oy8oiT+CCGsophyLts6kabvRth1FtpV0ZEh9veRTutNx9v/UYodPvZGrsR0ruTGkqaP9Vr82VtZzj0/wRFI5dTOYGUhhtefi2xm/n2nHYQAJbXlbo0AHxIfUVoUqAKWM9mgonzy+sA3nJRkSME9LRjht4PWg67lzTK5Df2mHEWobEFJA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:36:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:36:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH v2 3/5] block: add tracepoint for
 blk_zone_update_request_bio
Thread-Topic: [PATCH v2 3/5] block: add tracepoint for
 blk_zone_update_request_bio
Thread-Index: AQHb9M0fzQOPu/iVK0q94XDjly91PrQyNfIA
Date: Mon, 14 Jul 2025 22:36:44 +0000
Message-ID: <a07245a2-ecce-45ab-af18-104f5a0f16ee@nvidia.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-4-johannes.thumshirn@wdc.com>
In-Reply-To: <20250714143825.3575-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: 0545d48e-cba7-440f-56b3-08ddc326e953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm9YaDc0MnRBSEJnZENtTm5PVE1WRFN6M01MR2FIZDZFZVFNZGxVYjBnVTZE?=
 =?utf-8?B?SUVHVVR1bUhPa29zVFh3TElDVFBLTFIrL2JoTVNlSU96RnhyNUV0QlMzdGdX?=
 =?utf-8?B?RnY2Tk1RbEVRRFVZSTVEd2U1ZFF2OExsM21TeVF3WGJLalpQQk9LeFpjMHRj?=
 =?utf-8?B?ZWlqUUdRNDBwdXpuWTVGZEJRb3g5Q05FazJiR21WQlU4YXlRcWNXbmw1VGsz?=
 =?utf-8?B?YU8xQTY1K2lidUN0dGEwYnk3S3lCdHFkK2hDTmt0bk90Y3psWVBQWGsvSzdN?=
 =?utf-8?B?emJxQkMwbmNlM2h6WTIwZmxLelpKZHBMTFZjMDRKZE1aSTIzbzFMQnVMSWRz?=
 =?utf-8?B?ZVM2QTFKa1U3V1JZTHB5aWdaYk5TRGVXK1AvbFB6R21obXJJeHhhUDZ5Vkx1?=
 =?utf-8?B?ampxcjZoK0NxZVlsTHcwdmFickI3Rkl6QnU2RU8zNFdTZnc1Q2w0OFFORzlK?=
 =?utf-8?B?OWJIZHhOYXBLdG5FUUV6K0YrbHpLdStBR1QxODdRTW55YjZUcnRjajgwRDFW?=
 =?utf-8?B?N0Z4R2FCQ3Z3eTNJcUZOckhlRVAzUVRCWHp4R3RwR0srNWxjYzZoNVlIcUpO?=
 =?utf-8?B?L2lZbkppR0Y1aU0reUNDUWJKU0lVZUNhQzdwTjZtcW10YWVteHJxenA1TnYv?=
 =?utf-8?B?WThpTkxqeHQ3eXlmbHZJb3lxRk8xMFdaVFdzNU4xUVlrdk45QWVEZThaL3Nx?=
 =?utf-8?B?ZXlkVDNadTZERXd0cDl2cTJ4cUxremNxcE9lZ0N5TlljRk1ocGdwK2FTUkVk?=
 =?utf-8?B?NUQ4Mlh5aVpmd3pCQmdzRXZRT3hkQzljTXRuNUNHdXBXdFBVSCtoZWZSVTBj?=
 =?utf-8?B?c1haeHVWOE9ySEx3NnEzR1Y0eEFYK1d2TlU5SEVvM00rNFVHbjBkNjdoVW96?=
 =?utf-8?B?WFFuNjdWU2hXRzlFTTJjOEZ3WXRzZUxqQjg4OU4rVnc2d21YSTBsR00yN3ZH?=
 =?utf-8?B?amNPeWFnR0tLai91a2l2aEV2NTJQUksyRU04aHJLeUhxbFFZak9tczdCdy9o?=
 =?utf-8?B?ekxUc1Z2YkUyUWdqc0RRaVJqeUNoUWpkRkpWajZKZDBNSWJUM25LdE5Wb25w?=
 =?utf-8?B?Zy95bStHNDA4KzAvSDBzL3BGZFVjMzVqdTZ4Y0FTNEErdkJGcUZmdmozS3h3?=
 =?utf-8?B?dTRXdWhrdGVRVHg2VE80TzFpQmxFbUl6TWFZdlNNS2JiK0RnbXdkcjFlMmNu?=
 =?utf-8?B?Q3RNS0doNnZTcmJIbnlza2xmQVFKK01SL3VqMVNLaXV4YVlhSW4rUGRZTXhj?=
 =?utf-8?B?cDF5cHlXTUhqZFZ0dmVBWWRLYlZJTzZjSTlJYXU0VExSbHpsTlo3TG16dnJm?=
 =?utf-8?B?WjBwTTFRc2puUnNxTStJMlUyMmY2dUwvUGx5WGdDMmdGRThHaCtBOTdpVlVI?=
 =?utf-8?B?QzRqM3AyeFdQT2ZHWWNSdkRneW9vdWdVdU03a3hYdUNNSmtDSlFMRXAvZDFx?=
 =?utf-8?B?eGc5SlYxVTNvckNoRjdhQ29tUXU0cGc2N2EyL2NpMXREMHZEaTl3SlJURDlI?=
 =?utf-8?B?Y1NYM0JhWForNU9ISDdJek03UTRibCttc2RPNGowbjdKUGxMMGdFb2xrdlNx?=
 =?utf-8?B?Ni9uNkVteURab1lUWmNOaFl0MjlpZXhIU25jRVBDd09xQ1VVM3Z1TnB2RU8v?=
 =?utf-8?B?V1cxTGRiZ0VvTnNteXM4NU1oMmJHb0RtV1lud1dWdFNqSVh0UnN4M3VPd0xN?=
 =?utf-8?B?ejBFQUFYZWV0bVgrVVJ6M2lITUFldDhBUXJQbWYrMUhMamdxMFhCYkd3TjJr?=
 =?utf-8?B?K3ZZSlZqR3pIcHBOaDYvaGw5Y0ZvWlhVemZXaEVGREVhbEs5ZEpyR09aNVlX?=
 =?utf-8?B?TEovTUFyV2k0aGkxbFdLQWJBREdSV3NxNHQ0SkMvU0MzcGhIRGtaeVVVZWNE?=
 =?utf-8?B?UDdJSStxVXNQbkNLZHFPVkRjN3JBYytQVmMzV3NFNlR1Q3dVcHlWVklKdk83?=
 =?utf-8?B?aTQ1TyttTCtiVjZEOFZmV2haRFp2Rk5HL0U3UXdBZzJZZVI4d29KV3dCcm1y?=
 =?utf-8?B?dTV4OW5aUkRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1oxbkUwUHp2SzB2dWJVMi94ZXZvWFFKQXZMSHkya3J3S3FwQjcwUkJFRnEz?=
 =?utf-8?B?R25naUVIS1R3YldBc3VkNURyUHlDZW5BKzlxVVdtaVFzVUdxcVExRlB6dVdt?=
 =?utf-8?B?czVBWWhwd1UrR3pONG5hS2RMM2UvM0E5MWQzZXBGWVVqdjZNc3orbDJPSXRG?=
 =?utf-8?B?bGxJRzdMOUdzTGxjSU1ld3E2ZEY5aWdpanJRN3hXYytPMC9FQXFDQzMrRXRT?=
 =?utf-8?B?Nk9reUtLbTZoNjZFeEhxRTVRcExMRnNDY1p0Nzg5U2NiTlpOajNQNTZQa3p3?=
 =?utf-8?B?b3cxV3IwNFZrUHJwa2lSYlhPOWVSWEpnT0E5ZVFXbGhWU3BVazV5OU1Lcmta?=
 =?utf-8?B?Vm9OaUFiM2FBRXl0bzYxMlEwWERlSk15V1RpNDZPSHNid0NuWm1NTVNVdU5U?=
 =?utf-8?B?Q0ZlWEZNQm5wQnVOaFZZVkpHWWIvRGZUajEvOURzcG1Pc2dWU2gxMUtMMjBp?=
 =?utf-8?B?SFR6b2JmZnMrb2ZMN1BTTXRSVCtWTThoNG1YN1dzNFNoWE1EL2hNUVpsaURK?=
 =?utf-8?B?SEFLazRaUTJQZ3ZDZ3Erei9pTzZyUlgxNDA1cHJKcWFadVE5K1MrbkRXQUI4?=
 =?utf-8?B?dmowVjYyMzhJWDc3amM1NFdQbDcxSkRDc05uclpubDlHWUxPUVM5SHdFQXBZ?=
 =?utf-8?B?cHdPeWdjaWgrUVJ5SlZnTGdVV01TWm1TRlRBczdxaEIvSG9xUDZZRDJDMFpB?=
 =?utf-8?B?UkdXU3J0L2tSK24yMmpSUStyWGFSenZSVGorNFAxUVVyUlkrM0FLNTV6SjVY?=
 =?utf-8?B?bnFRVkxmd08xa0VXR3RBWEkvZXpzVXJVdjRYc1ZORnFadFRiOTNKUFZFNElF?=
 =?utf-8?B?d2JHZnJEK08yandCMStsQnlWWXlFTHpEYjVnSVBHUUJkeHg0S2M5WkViQ1Zq?=
 =?utf-8?B?ZEZ6RzZ2d3ZLNlhwT1lNblJJTnFlL3hiRWNlOTBYNTBzL21lL2NNVngzNncx?=
 =?utf-8?B?NDhFVmJYOWFEd053SHlDMC9vek1mK0l1aDRnZzVaaStSVUxueFVXN0publJY?=
 =?utf-8?B?UVdtT2xMTzFJWmprUlhwNjZFQnJGZHc0R25GTjAvV3JVaC9iYWRVM2g1U0Va?=
 =?utf-8?B?aHo3RThialEvV2RDUk02NWlieHk4aDhZdlY5ZWNkKzEweTRRYkR4eVZOUXUz?=
 =?utf-8?B?N2w2TGM1S0VGcnZTb3Y1ZEwybk9TNkNUZE9HdjNOQ05neUFPVTcrNUdkb2k2?=
 =?utf-8?B?RXEvV3pIeEJQUDYvalJyRFFuMTVjQVJDYTBDQmpXNHVyWS9abkRNUDUyd3dW?=
 =?utf-8?B?Tlg0YmtWUnBSM0RCeVNpWHZ4dTd2VU52OGpMbG9IT3daYmVqSE9RcHRzZEVV?=
 =?utf-8?B?bzVMdGJVQUI2cVc2MHhnNkM4NmNGMXMzT05EQS9qM3l5RDQwK2pzRlhzZ3N1?=
 =?utf-8?B?MC9QREdqVkNsMDNPSkdUbW9PY2g5MjVvYVJTR2Y4UW1NK3UzZTR5OXMzYmRh?=
 =?utf-8?B?QU1VV1BaSHQ0bVF3NjQ0aWkwdE1ZcWxKMFk3RC9sdDFtU1pkdUlYT0FqWEQy?=
 =?utf-8?B?ZldmWDJ6bEhKN09CYkt5MnZnTjhZQTNXdWs2ZWh4ZzZ6c29zVEswSU1ZeUtK?=
 =?utf-8?B?aFhBNTlTaXVVQWtKOGtjMTN5Vm5iVFFuVnpWSC96M05OQVp6Zi9HZ2VxekpD?=
 =?utf-8?B?WnVBZXZSRUR3L2pqZXdVR09Fb2xtdkxEQ2FzU2tIRWtJOEJ0bTlhS2NaU3gv?=
 =?utf-8?B?dzk4RnNMVStKdTBCQitqejVJeHZyN29XRUNyLzRsNitmUjBqZnNiM1NzbHQx?=
 =?utf-8?B?UG0xTHVERXhWNGF3NGhnb0hmRmVMUXdkaXdhNDUxT0gxVVJzV1FaMTFvRGJm?=
 =?utf-8?B?Y3JLaytqT2FGMUNubndtZWZTVlZEejhuM2IwcHkwTjlLckxPQ2JjN29QRWIv?=
 =?utf-8?B?QjVmMTRtdVN5eEF6MC8yTGFDSEVycHRtMUs5bTVIQ0RCMTJPTmhuVFgyTExn?=
 =?utf-8?B?bDZrQWZaZUt6TStYN3hDc045ZmlLdmlPVVkxN3NKK0Q0Y0RRcXNWV1hhR1BG?=
 =?utf-8?B?L0gwMTNoSzlwT0FicWM4eUkzWU9URkN1eHZFMStaNnJHY1F5a0dRZ0FZejkw?=
 =?utf-8?B?d2xEOU9qTkREUGN2cDhyUXhENnFSU1AvaGsrRjJWbGRrcUFza0cyNVRJT2Qr?=
 =?utf-8?B?aFQ3Y21YMEhzZ1h0NnJqeXBSMG14OExIMWdTWER5djZubW9SNmREbytyc0xR?=
 =?utf-8?Q?ZuvX0JEQ1nA+LnfgLQxGL3168sQWJtOWYEXHeLLqiMZm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67E49DA65941F242BB641AB1F477C600@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545d48e-cba7-440f-56b3-08ddc326e953
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:36:44.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o33cDkp5BkabDZpOzNXHXuKjUhruyl8geQQcGKKWqgVKIawq6sdbaUwGhPEJrLWuI3dSpAoxHt/vZU9XVOSjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

T24gNy8xNC8yNSAwNzozOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgYSB0cmFj
ZXBvaW50IGluIGJsa196b25lX3VwZGF0ZV9yZXF1ZXN0X2JpbygpIHRvIHRyYWNlIHRoZSBiaW8g
c2VjdG9yDQo+IHVwZGF0ZSBvbiBaT05FIEFQUEVORCBjb21wbGV0aW9ucy4NCj4NCj4gQW4gZXhh
bXBsZSBmb3IgdGhpcyB0cmFjZXBvaW50IGlzIGFzIGZvbGxvd3M6DQo+DQo+IDxpZGxlPi0wIFsw
MDFdIGQuaDEuICAzODEuNzQ2NDQ0OiBibGtfem9uZV91cGRhdGVfcmVxdWVzdF9iaW86IDI1OSw1
IFpBUyAxMzEwNzIgKCkgMTA0ODgzMiArIDI1NiBub25lLDAsMCBbc3dhcHBlci8xXQ0KPg0KPiBS
ZXZpZXdlZC1ieTogRGFtaWVuIExlIE1vYWw8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=
