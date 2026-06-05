Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0463B42EB
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683310; cv=fail; b=R+CtZ3OSpzqqT3yGAuszpTjquV0b8tzZh/S2hGRwxjkTsv6meYX6LTVlBjnhQ5zSFVMBheZhAxPoOqwuUqxHFphJ3z2k5DDb9rjm5gi6tRd3Miqs8dUR0nIJJaT7I+HUlUTVTXKruNr8Ly0Klq43PTl1ghdWsLHL7g4yhOaeWx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683310; c=relaxed/simple;
	bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LamQzPHlVxSgKcjA3MtWtAbbrCgD3ofVndWRLdmPiR179MxQp8BgBifHvFkOHFW6GTbYGUDZ+W1rWLOxIzCQw6I4ZyUZOnWloc7DoqA45RA2KFRO97UrHL9Hn5MEpU+IUxncyU8/A7jXuc4dhlEjt/F0req1MvdPBgjZGTuRS8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1cN3ZA9; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1cN3ZA9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOfIUR6bh6BtqHHD1gD49dLYxm/2ZpMETNrr1f+rexlcJ7XnzLl2/10ufF2j4zStT6TF237Ju++WyGxnI+5fJzw+vxCFv+hDiZgtvJ1qiHuGrUsXO6wNL5sX7uea0/1KzMNhmttvWiw1T+qFRG9556Z149JsKtWrNtuTwRjBLre/3X1SSL3gedPaLJ3nrEZTI5LcwR+qm84FUP+NFHQjHjZyjvpIECSVdZ6Yr7GbVa1e3MAYCyLIGwcirXCI/xQizDUzJh2i/2I4S6DT6HEg2UiellnF4LmYWdNSJ1CxXmOFpB6xqHMzRLlLQhw+QSQF4Xl9t9df3jv3SpIqjJPh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=k5vccVT4zP4o+hcMqk2/GzE1keGecCHtaq1MIDYvynOOeNjOZ4TZ1/4bICod+eBolA1M0o/YblVppshXlcVilVlxCFRiQz+m0ld0sk0EYWXpczyieEWcpWd6suRVIvhhyX4oMdndXYIcxon6q+pPSTIaLm2JNEOH/KA8J1862PO/6P7eP7RhlkUuNQmholqAMw4fVN8WXOsCEPkpQlbBWhCFwOUn2zrS53nZug1qMxp3xENtsXUNVgWuTfRdqgUq2S5sYyaEn20k81/Q6iD9FDtqRhTuo+260gi5Z7NLDiuy1vfksrWWSyUgRuXQx9oDJHLqZYb/MMjBgqu0T+24cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=o1cN3ZA9Uzvi9RGGHcMferwMDMfuPRiKJ0f5QHeBuCAPRkX+t5tBXrgdeGHx/yK+O6t1NsC+cIkIHVvhNZZ67ehmSLDPnhcwEK0pSZ5+FWBbsuvW+30/Ys7Jfwq2LmE845d82r5u0fXrTpY55ix5lrJSZPlG5GpEM6N1q8p7L3PFt3925QMia/OEQU1FdLiUVNz3Cwl8jWvlotdiadxlqztStrU8obb89uYZr74RuDh3RxmE4SVrQMJd33SVqaOxbM2ocMfphfILKN2LqjrPjDOx2XegZA5jYR3QTeNvW2e7D+a7lsbB1z0vWwaW6uT88l1MlwSQqImwHW5rRr5WtQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:15:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:15:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>
Subject: Re: [PATCH v7 05/14] block/cgroup: Improve lock context annotations
Thread-Topic: [PATCH v7 05/14] block/cgroup: Improve lock context annotations
Thread-Index: AQHc9RVqVjCQTITq60+/DiQu4Kn03rYwREyA
Date: Fri, 5 Jun 2026 18:15:06 +0000
Message-ID: <2fc5cfcf-c277-4603-add5-faee336d5ffc@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <58ddd6e2b960bdfa03d0007984386bc0ba351391.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <58ddd6e2b960bdfa03d0007984386bc0ba351391.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: b1a8fcd5-8d82-46fe-504c-08dec32e5eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 vn3tPxFANJWkWsn3S8oc4zMaZEvFowaNQmZ4wmnQOVzsVfylilF1Y8UJ2nyhtIxKDRU1C2P9jb3fFN8TdguMhpcx5KVgzSllkFtKKJc4fywDHnaubXuuW64iOW26zmEw/zecv8joMshT6Q6cUoDzyw/gWKSF4BkwtQ9Idh6/7Qz2BSYO1+ykZVj7sCh/ETUVsY187AjWr3ArD3n4jjkFI5FdZM1DsiJtUjueqYzWULfWa5qQ9uIGKOx9RL0zQ6Es9si9O1AE1c/HHkBr6PRL4RxrnxL0ebbIvoghGmtO8z8V4IFplkBfZAOmLgGbp8I/nJp/0zo5zYMyxe/eI71wgW8x8ff0ITAb2emY+emcDn+TecUgyQwRffumrwrVNvzfMaO3ZbPmKNa7SVwCkFqfW08aJ6QjQeP67rgZzTdU0+8NHXCTNFXOoSfRsPc6BGxJB4rmcLYqrY4VT0stYdkGioMmuFnHp2zouJbq8p/sOPB5OQN5YUaBv3oue7sZO73OwqAXf0ntHzRZIQKMvBsoaWLC1DWzThuwZYG7mwZ+mS4qszJGsiUyMEMxtV1a8udPpLV/kkYg3Ije9PtLhznOSDBPuesFExjO0pOT61ez07/VRvvgJZ0zr0ROkDTjRKMex/B3i82NCE7mkbEHF3fdjXu7R5pwm9V0WmFag454V2J9MI6+H4tbVvFSnJPQfH5KFQkOXXc4o+KgtczSl/N+46SIy2YNXf3c5E9WU/4i/cYSucmC9m1OQLoxnSwmaa08
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzhobUhLSGU5U0wveXN5UExoQy9oVWZXOE02SDBISkNpeTE1d1FLSTZpU3lV?=
 =?utf-8?B?UXhMeHpJWUNZQ3VMR0RZeHB2MGRnWm05bzlLRkthQzVCU3VtcWVuV1pic2lr?=
 =?utf-8?B?cHJ5K2UxeTQyYTRPUTBoOVg1Z283QUIxWUllcGFoZUd3UGVoVy9MWW1oV3dz?=
 =?utf-8?B?NUpXTUV0NnBQelZpaEI2UjVPK210V3Q4L0gyZERZMzlYOFplWGhwS2hwNUF0?=
 =?utf-8?B?aDdacExWNUl6QUpDV2ZhQ1lzajZuVEpFdlZLUUI2aDhOSGl0VUVucXBDNThM?=
 =?utf-8?B?R2UxNVRUWkhRZmU4UnkwVGdGbjlmaGN1dWJmY21PSnB2Wm5lQ1RRdWYra09z?=
 =?utf-8?B?YTQyN3NPcDVXUmVGaEZJU2NKWjMyTGJGaTRIWGdaTlhJMnNORjVlSzZCREwz?=
 =?utf-8?B?SmFoZXZselZ5M3oyc1oxbnZZejhWL0F3OERUWE55emtKM1pwbmRFYXFDbzNW?=
 =?utf-8?B?cGVCZU9kRHUwZktUVjNtRFlOSFlrc3JYNDdlckZIUUFkQWYyT0ttQWQ5UTJK?=
 =?utf-8?B?cEJrMFFqWVI4bnl4U2lQYktyRm45Qmhoa01YejNiVVlyZUZZb0M5bjJ2UVZj?=
 =?utf-8?B?TEw0RUtPOVB2ZHR6d2JxWnBjTmNYdXhRT1RtZWdhNjFVSmcvaTNoM01VVFhB?=
 =?utf-8?B?OFhnK0RKcmZ1NGVUcWtDN2R1TE96VEtvN0huWVdyMEZ6M1E4MGFmWUwyU3g3?=
 =?utf-8?B?aGlacGIxMFhkRWZkV0I5VVo4ZEUySmcxVHc3aDdEVGFHUldEMVdCMXQxM28w?=
 =?utf-8?B?a3VBZXlzWEZxZWpzUllwc09tOTVLdnFKM204TDhkcTNlSHpKNzhXZTRHZkdr?=
 =?utf-8?B?eFFaTkVLQVpVUnNmQ2tQaWFCb21jZlMvWTdieGR2MFgyVjR0Yk5wVU1OV2Zw?=
 =?utf-8?B?RzVCSGozUURTU2xEbFdJVWJzVFlhdVBFWmFhbWZoZ05rSGJiYTc4eXUvaDRl?=
 =?utf-8?B?dCtzUXRoNmxna244RHVVcWJIazB4M2hFSm5UZ1lmRTdZRngvSkhjejlrelVm?=
 =?utf-8?B?SmVNc0x4UEVVNno1cmY3NTM3ZU0yMWZlLzZWNUlRZU5ZWkprZkV2OStBMnMw?=
 =?utf-8?B?TVU1SmkzWHB4elA3aXpJZ05jcTNSMy9zeXV0Zy80SjlhQkNjZHF6VW5IYmNE?=
 =?utf-8?B?b0YzV0xpbDgxR1pCamg1NnBKRktnTHV1TWdBUVRZcjFkSHF5bVVjcFFvRHJq?=
 =?utf-8?B?NmViR0xyZkNXQWZxS2xNRU5wd3Z4Mk4vK1Z4V2E1eXFpVnBRQkg4Sm9yaStw?=
 =?utf-8?B?UEQ1RGtESS9Xb0Y5dzBzWDBsUGhlVmNjdUNZYVYzemxYNkIyaEtLYzdMVG1W?=
 =?utf-8?B?b0VIWVZYRERJUUxqYWhjTkZqZFNYVGVCT2cxb3hlQldtWmdZTUhJZDM1eEdS?=
 =?utf-8?B?K0RDUis3VTJnVjg3TktCRUgzam9ZZWFZbVFZKzlsWk42SDgwQzd4eWhzQkoz?=
 =?utf-8?B?cjMyVS81cXhSdHllNVQzUU9qVzR1YUhGM1h4V2VIS1VWRnlYVWhSM2tLbDZT?=
 =?utf-8?B?TXplVVlWUSthNkpiSGl5WUFmaE9RdDdXQ0hQeGNmVUJmL2NmQVREZy9Sb2lz?=
 =?utf-8?B?MWZGc1ZVMis5NWRCK2dGb3R5TFo4b2tGblZwVWlhZThZKzVEL0tqRjlZNEhn?=
 =?utf-8?B?VE10THFEcldyelZ2NXlaUDVEMlZvY0FrK3pwdGxpR3J6bDYrQzZRZzhlZ1c3?=
 =?utf-8?B?SkQ5UnRtc1dJbERwOGV0VDV4WDB0QWdvWTJCcDhycUpla0RxSjhFdVZYNmlN?=
 =?utf-8?B?VkwyZjUrQ2NIYWRCK0NVRXg2RGRueUxuSlAzWlROejdlbXVsWWExblVvOWZO?=
 =?utf-8?B?Mkt3NDArZ1NoU2NHK2JMVUwxQ2IvSjM5anp4RnNJSEpGODRQUTNkQjFmNjVm?=
 =?utf-8?B?NTV0Lzgrd2FKV1dJSWtXNXN4Ym55d1dEbWszSklRTkozaFVOYXVZSWJOQ2di?=
 =?utf-8?B?M0ZLSGQ3YXhlbnp2amN5anhiSDlBSUZhUkE3bkdzYWM4K0RBYm95NktnaDMx?=
 =?utf-8?B?Z3lIUnVia0tzKzAyek1sTUt0VDlDOGVENkFaUEFMODBmb2JBMXEvN0tSTWg3?=
 =?utf-8?B?T1ZoR3RoazRkSkFMaFFpWFR6SC8zVXVwTCtEbUkwa1NmVzRmMVRxeWlpWUYr?=
 =?utf-8?B?elBwdXdvUkFmU3dRU0NzVVlwK3pXNzNzOGJRYnJYMG96K1U5SVZlMEUrajNZ?=
 =?utf-8?B?TFQvMUoreGpIaG4xTTVBUzZVck0zSmMrY3lFbG11TEJXK0N2RUZ1U081ZzdT?=
 =?utf-8?B?SlNueGpvRzBsK0h2dTF1eE9oSXFLV3lVM2g1N2hnMERGRENJSlNkZXFuMjgw?=
 =?utf-8?B?eUlEN3IwK1NwN1ZOMlJ5WWtBdHJVZXFQb1RpR3hRZlNCT1BmeWdONXc5RDRJ?=
 =?utf-8?Q?EGor//fuHvIfN6MSbpCExJmBBgNRHgIUIMXcW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD596F2E7DD0CE408E6A9D011509E97C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8fcd5-8d82-46fe-504c-08dec32e5eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:15:06.0421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLR0uD2aXBOFApROywxBISdpMp8Xo6zefBLeVe7GFXqNBnMfjhdMrE0pR75f/Dx/0y7IIuAkUVs2PDX1GCRsdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
