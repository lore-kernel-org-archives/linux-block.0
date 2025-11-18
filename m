Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E703161B2
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430739; cv=fail; b=QobpbOISUVjBmARcBO9XBBCAIxlMMDHpjGcBpMJKXGOzURuSx/3Hh75dQliGG8pvnysm7Y15MeK861WiNrpK7rMu9zWq8sUTHii2ZQ+8+7mgZ805K7zcBtwQf0oSqN9j1jbpR8VXte/+2ZJIuF2asQdmxaP2cwEG76vElzCHruI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430739; c=relaxed/simple;
	bh=UMdo/hKJLKImm+4epAndnafnz+ZgnQRJy4uvSxUWIVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JH31MSSxyyObK+UG3l2nr4wpIfhHbeA+wvO0ykt+P6tLWWnQYDpnpX1X0qyOcktN4Uoux5W11uKOpxE3YHuURI32eOKXOyA4Vhc8tF31ElFFsLQ1ibij7lyAf8jzgPqWTQ1FHNsT1ZWywsvYdGYWmxTC5lLaLu+W+BGBO3tePOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9oWZAbB; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9oWZAbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8mnCxaKr+sWPfVZrM9iaLTfSDUf3Kp+/TtX/+I62Rzbotw56RXHKFW29V6iw0aHEQkahLoNBVU2Wl6/JNBgzDCJ5yNtRW4JLkdKUH18cCxa+TlzD1So2TUzEUAn2BH4HQKrl8CgMhwuQ+44VfQX5cDzAYFs41JGgwXV7n8ww/qV2Z9tLXhGtOKwNOvB/Zo3/h7CgMEyWHMw8PIxwEXZzEzIEM0KaS4sTDf34NQnb+g0d7nHeff8pJ4A/Jp+H2Dn3k2EMPB5rp/xdjl82j8aqDcvmO1srQ2j6Zh+ZbNV3muV9g5Wh+9e7rFRKrYsnfacsvXY8WSwy66ua6VaJqXisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMdo/hKJLKImm+4epAndnafnz+ZgnQRJy4uvSxUWIVc=;
 b=UHNc4/iumkCyTLOqYl47FHodRSool+IYDlW4JCsBjqV96e+jVeFS9UbGAvkAg2+ymC4pByhaeKhURWNIPurbphFu6f7COR/jOd4Xm2UvQnY7nTjQZEAb6BvL6zj0f85iWl3kp/+Oego51JGm1kvy01GuEIL02tAehWWK4kG356UZIKaBJQ2XhKnoPezWmwOYaXeP5s8caGzwo1LMScBFdexo2FQGhxdBZwBoZXjyLZDeey8wNTZQ2tnJjvXkYr8XyUBWDtdzYuE5F5JQBMzuKF5F0jYmlsS39Cj3tyFJypDrdNrAHIeWZYAhy38rv/oWSyXmkZcZsZfnSt6J/MPMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMdo/hKJLKImm+4epAndnafnz+ZgnQRJy4uvSxUWIVc=;
 b=n9oWZAbBjBYrekuaf2oZmCXOXaa1smFD5pZ0GEIczrpYb6GCMy19aB7R7+M5BHapZ6qDASIi89EP25/+ApVvsfR62H/veUwA9PYWOlzKK3yQgUMkKrD3uU+WqjRUbgI0Jt+AFiRXCJnHrMnmpCkYPI3/ynUbp0FK/Tg2RoKeD/KJOFJfUzC4DCCGE4Qdv+nxeXe8YYjhMt3M/VyYuQcghMv+VJBLUJYODBpgpPI2mMdcBSra0Yw09pjeJZjIYuYEN6rnZKfVwdll6cwhS0hAsS5d0fPd/kbk/82zq5DZEyj4XsaN8RGHEqKnuEZxpTcxlvDZpAlJb/gOKE1uHz4G3A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:52:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:52:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Topic: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Thread-Index: AQHcVqQSWk1ka6Xc10yTpB77BDOaP7T0qwUAgAAfqgCAAAv5gIAC1/2A
Date: Tue, 18 Nov 2025 01:52:15 +0000
Message-ID: <bb2d2b08-7a90-443b-bd3c-cd86212a03d0@nvidia.com>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
 <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
 <bb672149-fb81-489e-8afb-8ffdd8eb7702@kernel.org>
In-Reply-To: <bb672149-fb81-489e-8afb-8ffdd8eb7702@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB999083:EE_
x-ms-office365-filtering-correlation-id: 0e456f25-0c5b-4d7f-d6d6-08de264519bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFNIYm5zb2Y5UTg2ek01Nms2czR1ZlBNUEMrNGY1ekRNaG01eVl0TjFKNENF?=
 =?utf-8?B?STRnak9ob0VOY3RlVGgwR3U0Q1M2Qno4WXoxOStvVnJSM2JHNS9sNDlQOW53?=
 =?utf-8?B?WTROWHBuUStOK1VVbGFsNm1rNTFSN1R4Vyt2T3plOUZDZ01IY0t4QU04M2lh?=
 =?utf-8?B?Yi9PZ0d6Z056dW0veWpSN0ZEc00rTU50Zi9WWldsUE9GUTB5WXJpeHZlcUdS?=
 =?utf-8?B?RDRFRndGWHNsWlRYL0o5cE1hckt0RWMzMWowOXdNcUF6bHh6Z2RuR2NQazBj?=
 =?utf-8?B?OWpGZ3lXTkZtNkhqVXlyNHVhSkFSdmthQjNCVkFvK0w1VllXRXpvWG9GWlds?=
 =?utf-8?B?NUZmeHhlV2xDSjZUb1NxRGg3a1pKUE1ILzV6R1FHMkppVWIyNWd0UGVZeUFV?=
 =?utf-8?B?eExsc0ZWOHRYcEpRS2FaRWpkUDJFb1ZJd21SY1lJRHdGcHhqdGtqRitiWEQ5?=
 =?utf-8?B?RE5udTA5OUlMbFVGSmYvdnJmRy9EMjhxWGhSQkYyQ3lnWGNFT2VrQzBGbVZ5?=
 =?utf-8?B?U1h5aHowNksxN09Za3ovSUpOMEUvWWdDbS9vL2FsSEZnMEEyOVN2MERCdlFJ?=
 =?utf-8?B?d3U2Z09iNGxtNlhGUGJQMGhWaWVrZkIxMjhQK0ZpUEsvdkhLL1FPMmI1Y1I0?=
 =?utf-8?B?NGRhUk94S3pCZEw1eVg4ODVETlNCWkhBK3pJbHorN3VmdGJlendyNXc0MG1Y?=
 =?utf-8?B?cGtzYkRVREU0Rm0vbFowa3Y1UE0vSkpNMGZZU3lTcVRrQ09mOG5sdkVRUzRF?=
 =?utf-8?B?WXAwRHJMMHJuSWJaRGdIampNaytDVWVpKzdGWU9RNHFzeVJmZktpKzk0dkxm?=
 =?utf-8?B?T1RKVzhJMGFLeVJCU0p5dXp5YkVoNWlvOFpxZTdQN1hFU1BiV2p1RHJOTHpT?=
 =?utf-8?B?bWxPUGtHL3RQckRkKzh2Mmo1U1NpanM2NGVNQVpkNmJocitxVFR4NnVNQmVO?=
 =?utf-8?B?aVRFWHFlRHBwYjBCRlE5bUxHY0VhRHN6UXpIVUJVcEZmNHFUNUE3bU1QQkdG?=
 =?utf-8?B?WHBkLzBkczdxS29TUTdMcnBvMnFRdXFDUDJOSXhnYzJrZ21UVStxNlcwdjBG?=
 =?utf-8?B?ekZJRVJkd25IQWl4RnRxWitUWmhYRkdqeXZybk5vWUhWckRuWmtrcGhQcEl4?=
 =?utf-8?B?MHFFT2w4eFg0ZFBsaCtKakUrM1ZaMkxuWmpDaUV1Qnd6RUhsNFJCTW50aktl?=
 =?utf-8?B?ZWI4eU0zcmVUUkpheVp0RjVtRGlram1Jd2Eyd25GVVRMRFBPTFpreUttbE5L?=
 =?utf-8?B?bWtTRFFQV053RCthUVIzN1ZOOXNLZGJZMkIxL0FaUmtkRERCMGkvRTFYQi9U?=
 =?utf-8?B?MDhQYjJNYjA3Y2ZhbU5pcDZxaXZ2Y0F1a3R5M0FQbWNCaTN1cjVjUmc3bkdv?=
 =?utf-8?B?STNuUEFLWFNZbDA5THJTR0FCNjRRSVdHL3U1akY0MVBySGhyMFFCYW1PN001?=
 =?utf-8?B?UTd4VEJDeDhEdTNaU0hibUhJOHJpMExZc0xwRWdiRG5TQnpocGRBb3ljK2F1?=
 =?utf-8?B?ZGVrZURDU3c3VXJ5SEtmVlhYUHRydUxsRkZkSlhidHRjcjlOZi9VczZGSnNu?=
 =?utf-8?B?U3ZYM2FGVHdRbFZyWTk4akxjdzhNQUg1b3BrdVhOQk53cUR4VWczamordnhq?=
 =?utf-8?B?Uk1YTXI5b2RPZzZjdnMxOXlGSEE1ZFpuVE9md1RyaCthcnk5WFdHRmduazZ1?=
 =?utf-8?B?dlJlbElLeEZOYWdDbXFaNFZrbFpDb1VXQUZ3SERrWWs1YmxFdzRYNVpNbVRG?=
 =?utf-8?B?NXd1alhlb1JUVVBVRytlMUlBRGlHSWpiaUdpUG5zQjliaDBINHFpYjVZbm9q?=
 =?utf-8?B?TFZGODFZOEhVR3F4OXErWFNDOTNmSm5KNGs0Vmp0SXUwU2NuMlY2Nll6NEM0?=
 =?utf-8?B?cDYxc3g3aVRoNkgxV3R4d25zUWh1SGtUQ2NYZnVONlA5bjFTZXA4MUduTzNF?=
 =?utf-8?B?M2F0UDNNWDVmWFR5V0xDcDJUTzhoZTVrbUpReDNxU0hDSkJSWXNad3kxTDhD?=
 =?utf-8?B?Z01vUUM0Y3dIQTV5ajViekV6blgvTUFkYlNYQVJmNzN6N2JJSEdOYlJxbUx5?=
 =?utf-8?Q?cjO6Af?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3FBOWM4eGhQMktSeHJQK2taTzFXa0oyRCtaais5VkFJMDBrcGFSbFIzOGJF?=
 =?utf-8?B?Q1pBQm4vL2tKenZKTEF0Yy9oWHp5M01XRjV3VEFQbUM0WVJMb0JFRWN2ejBw?=
 =?utf-8?B?ck5VYkd6bzBnTlJJcTNhZUM1cXRXVGRnMlVGTWQrM3lnbllZcWlnQm1meHpH?=
 =?utf-8?B?dklHNlFYODBLazNPUHJmWWhDMmQvcll5Rnpha3RqM2x6cE8wb0dYbGpQMHRt?=
 =?utf-8?B?VVpHZDRPa05EOXNkbzFYaXlpbVErWWExWjdnZXhPL1J0NkVSRHRYMndEcjBP?=
 =?utf-8?B?K3MrUzdVVVkzMkdyaHhvMXdRREd0TFY0aVJGTXpZd3RWL2ZBNUgwRk54OTY0?=
 =?utf-8?B?eklJdkpjamdCTk14bnpiMGozRHhkbmo5M05Hd2pTWkdHWHlFc3ZDRS9lVGJl?=
 =?utf-8?B?MlBZY0E2ZkpYZGpJV0JNUVczbnR2YU1lRXNZZHVCZ20wV2NNUUs2ZVB3U3ZU?=
 =?utf-8?B?Z2JNSnF3VTRvakNTajNaeDN1TC9GY1Q0S09KcTUrQXQ1Wm5TelJjU291U3lt?=
 =?utf-8?B?VzJsaGdUMHpDVjFxTnlrN2M1SzJuVjdoRVc5bnFDVnhKdTBWVVNjQ0lpVmRx?=
 =?utf-8?B?NkJHaUN5WjNCbHhuVVZnNXRHdWFjbnRLR3ZDai9FOHROTjQyUnZPb2NJdURa?=
 =?utf-8?B?SGZ5SURYRldXRDF6VWRXaGY5S29SWG9ZUmJ1bjM4Qis1RW9ZSWxTYm1YdGp5?=
 =?utf-8?B?emtLZHQ4MEZFUFVySCtFaHViYUx6UHhrZHZNbkpHRXFnL2N3ekN2MGlDWUts?=
 =?utf-8?B?R3FRZ3FSNFFuSGY4aTVlcjFlYnZJSER4cllscnFMTTBoNEFTcXJBZFVvdnRY?=
 =?utf-8?B?ekI2UmxQYXE0YXd2S2ZlY2V2Ykd5ZzdEcW5rWkJPRGtXbnJlL3VjZmRHbEQ2?=
 =?utf-8?B?SXJ6SUY2Zy9nMXhWckpkbkFyOTNhYU1VMkdTQVpCLy81WXBvN1BnbEVlR282?=
 =?utf-8?B?bzcyMFc1YlVuUTNKWThHMzF3Mnp1d2o4bktnSEhKM2NsMWJ6Qk1JT05xMWVM?=
 =?utf-8?B?Rmhpb0pjWG1EME10WDJ6RUtwd1RFbVYzMmVSWUx4ZHVpRnN6S3JhcHEwblQ4?=
 =?utf-8?B?MTVqVTdNMU05VHJHR2hJU1lmRndONWd3TjJCMDdQUS9hTE5UdlRCSHYzUkNJ?=
 =?utf-8?B?TEFEaGdzTHlHOFJiV3VHZkZGRzJOSUYvbk9ZVTRYSThtQ2RPbVFJMURlMDlh?=
 =?utf-8?B?WGpGb2NsYnJmVTIycWZKN0F2cFpRV29JQ0I0RXpRV0ZiVVY1R3Ywa1Vaemto?=
 =?utf-8?B?SmMzcU9YOStwNWZ4LzJHRDk0eXdTMHQ4ZFdIcVduQ2ZpWS9BR0Z2WnlSTHp6?=
 =?utf-8?B?VmVpbnhOSlo3aWp1RHVkeElpcWVGOXlFaVFNei9LcXNqcUNuM2NNVGdMNklO?=
 =?utf-8?B?bDdvUjBZTzFmUWFtcUNncGluMG4wYkFCYTdhMGp3Y3MvSkVpcWpNZzdXYWps?=
 =?utf-8?B?R0lBbzlzeVkzS0Q1MjFkOVVaa1JkcXhjT1U4djJHWXc3Rml2QkxnQ2d2aE4x?=
 =?utf-8?B?Q3dFY21BRjJyRjhVNjBPNGtLakZaN2F5OHJVUVFCK0ZxcUxPVUx4aUtlQVNE?=
 =?utf-8?B?cTlXbTdYR1hVR1BqS2lpd3huVG5ROG9adjJtTm9zcmhsckpuSm51azQ0Q0hI?=
 =?utf-8?B?V2hpRTFXNTFMYmRrWGlSR3NlMVNwTGNqQ3c5Qml4dU5ZdE5EdjBaeG5RWTVP?=
 =?utf-8?B?bmhodEI1TXhESTFXTnYvYTZlWi81a1VzdDNGMGMxVWZpWHB0SjNzZjJNMFFH?=
 =?utf-8?B?bncydTJVTmlxMlpkcnpQNXB3cG10bkFxT0F2SkdXZGNLRXN2bDJ4M2dIZEVW?=
 =?utf-8?B?anIvRWZpcFJWc3dTeFM3bit6RU5STEpNci8xTVAvMmgrVjdaUjI3QXlVOGZi?=
 =?utf-8?B?TGcwN1d0Tjg2TG9SRWhoRG5qUnR4ay83Z0JwMEJzYmRCYVYwWjlqUE1LcEZC?=
 =?utf-8?B?cHEwV2F2dnZrTDFBR1hTa1JDNHNIYVJUamhjV05MalR6aUN2UDYyK0FmRGFp?=
 =?utf-8?B?UjFmd0xnRVFtOG1XamFQRHBtL0FhTEpmZ3VCWGkvSWRXcHNKek04UTlzOGtk?=
 =?utf-8?B?NEMxZWpzN3A4MW5UNWduQ0FvWU9JWC9TSCsxUy96cUQ3YXMxQjIzUng3akk4?=
 =?utf-8?B?ck9LR2hTbEFPVWF0YU1MOHB5WVpRQ0Y3WWtSZmVxUFRKSTArNVZDTTdUVUFh?=
 =?utf-8?Q?Q9jJW3qtbPDl1O1mbzOZjT8fXlt7qV6GhCOCmYUGAWHI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79FCA10FE3A4D4479F734B3DA73C2085@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e456f25-0c5b-4d7f-d6d6-08de264519bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 01:52:15.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeWH8sBD6ets+SU1vAte+f/grXrKGxmH6OGOWGzPcVjK+ab1vti52I/c+oGnHXjP6caQXkjukleYLSzQFEs6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083

T24gMTEvMTUvMjUgMjI6MjYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAxMS8xNi8yNSAx
NDo0MywgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gMTEvMTUvMjUgMTk6NTAsIERh
bWllbiBMZSBNb2FsIHdyb3RlOg0KPj4+IE9uIDExLzE2LzI1IDExOjUyLCBDaGFpdGFueWEgS3Vs
a2Fybmkgd3JvdGU6DQo+Pj4+ICAgICA2LiBMb29wIGRyaXZlcjoNCj4+Pj4gICAgICBsb29wX3F1
ZXVlX3JxKCkNCj4+Pj4gICAgICAgbG9fcndfYWlvKCkNCj4+Pj4gICAgICAgIGttYWxsb2NfYXJy
YXkoLi4uLCBHRlBfTk9JTykgPC0tIEJMT0NLUyAoUkVRX05PV0FJVCB2aW9sYXRpb24pDQo+Pj4+
ICAgICAgICAgLT4gU2hvdWxkIHVzZSBHRlBfTk9XQUlUIHdoZW4gcnEtPmNtZF9mbGFncyAmIFJF
UV9OT1dBSVQNCj4+PiBTYW1lIGNvbW1lbnQgYXMgZm9yIHpsb29wLiBSZS1yZWFkIHRoZSBjb2Rl
IGFuZCBzZWUgdGhhdCBsb29wX3F1ZXVlX3JxKCkgY2FsbHMNCj4+PiBsb29wX3F1ZXVlX3dvcmso
KS4gVGhhdCBmdW5jdGlvbiBoYXMgYSBtZW1vcnkgYWxsb2NhdGlvbiB0aGF0IGlzIGFscmVhZHkg
bWFya2VkDQo+Pj4gd2l0aCBHRlBfTk9XQUlULCBhbmQgdGhhdCB0aGlzIGZ1bmN0aW9uIGRvZXMg
bm90IGRpcmVjdGx5IGV4ZWN1dGUgbG9fcndfYWlvKCkgYXMNCj4+PiB0aGF0IGlzIGRvbmUgZnJv
bSBsb29wX3dvcmtmbigpLCBpbiB0aGUgd29yayBpdGVtIGNvbnRleHQuDQo+Pj4gU28gYWdhaW4s
IG5vIGJsb2NraW5nIHZpb2xhdGlvbiB0aGF0IEkgY2FuIHNlZSBoZXJlLg0KPj4+IEFzIGZhciBh
cyBJIGNhbiB0ZWxsLCB0aGlzIHBhdGNoIGlzIG5vdCBuZWVkZWQuDQo+Pj4NCj4+IFRoYW5rcyBm
b3IgcG9pbnRpbmcgdGhhdCBvdXQuIFNpbmNlIFJFUV9OT1dBSVQgaXMgbm90IHZhbGlkIGluIHRo
ZQ0KPj4gd29ya3F1ZXVlLCB0aGVuIFJFUV9OT1dBSVQgZmxhZyBuZWVkcyB0byBiZSBjbGVhcmVk
IGJlZm9yZQ0KPj4gaGFuZGluZyBpdCBvdmVyIHRvIHdvcmtxdWV1ZSA/IGlzIHRoYXQgdGhlIHJp
Z2h0IGludGVycHJldGF0aW9uPw0KPiBOby4gdGhlIHF1ZXVlX3JxIGNvbnRleHQgZG9lcyBub3Qg
YmxvY2ssIHNvIFJFUV9OT1dBSVQgaXMgYmVpbmcgcmVzcGVjdGVkLiBJIGRvDQo+IG5vdCBzZWUg
YW55IGlzc3VlIHdpdGggaXQuIFJFUV9OT1dBSVQgc2ltcGx5IG1lYW5zIHRoYXQgLT5xdWV1ZV9y
cSgpIHNob3VsZCBub3QNCj4gYmxvY2suIEl0IGRvZXMgbm90IG1lYW4gdGhhdCB0aGUgSU8gc2hv
dWxkL3dpbGwgYmUgY29tcGxldGVkIGluc3RhbnRhbmVvdXNseS4uLg0KPg0KPiBEaWQgeW91IGJ5
IGFueSBjaGFuY2UgdHJpZ2dlciBhIHdhcm5pbmcgb3Igc29tZXRoaW5nID8gSWYgeWVzLCB3YWh0
IGlzIHRoZQ0KPiByZXByb2R1Y2VyID8NCg0Kc29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCB5ZXMg
SSdtIHJlbW90ZWx5IGRlYnVnZ2luZyB0aGUgbG9vcCBkZXZpY2Ugb24NCmEgcGh5c2ljYWwgbWFj
aGluZSwgZG9uJ3QgaGF2ZSBhbnkgYWNjZXNzIHRvIGdldCB0aGUgdHJhY2Ugb3IgcmVwcm9kdWNl
ci4NCldoaWxlIGV4YW1pbmluZyB0aGUgcmVxdWVzdCBmbGFncyBJIGVuY291bnRlcmVkIHRoaXMs
IHdoZXJlIHJlcSBpcyBzdGlsbA0KbWFya2VkIFJFUV9OT1dBSVQgYW5kIGl0J3Mgbm90IGhvbm9y
ZWQuDQoNCi1jaw0KDQoNCg==
