Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654D1922D3
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047984; cv=fail; b=tlxPHBkCB9HGBPBnSkLTtEAo1gLAsv+GOX15uZZqo1EQdUYnQt+UoQfQipYq9kj6GcZIfou1K5DMIHUPdwkvhuMUlDkZ0CjzWGx4qWiN/gmIwCY33blkc7erQO2GRjca2dTfjX5BOtCQ/s4NqcUvqAPnwhMuNM041iY0AFQgbHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047984; c=relaxed/simple;
	bh=PIVuzvSj/hDbxpyvsxtyhUk2/RXaylz8Js8VPDzqw2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIriYKamnLLRKniL92h4q9p77hhEig8uyJ7+x5wUezsyY6CC+/jlqVTpAqt3FavC48bpAbOx0XPLFj1C/edeDpYUal5Fguc+DOrpS2cjdro50awYHb+zXTK8saT4Chaft+3TcpOdXxRZ6FU/NxSu4FbLEmewDq1QdY906/H1OAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ojic2HZs; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ojic2HZs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmymYBD+qHOEfiAbKoDwwnBn7aMT50WdFkJXZ3Fwo+iBrnP9UE1EnPSqnhnmd5AH3mNZ159YiM9pCsHtysAh2vCbqTwZaieNm7ze3rtMTb6KiHlF/JY9jlJod1Cm9q+IKq7Qs8RY1yoTKV6MkeOS9nWS+bKouneXjKP4nBkQNOjvQBLV+lB9cX8aUe3Mt0bvgZ0TDddDbP4FWWp2QNiQWan2Z9K/W5aExP8cPPn9PUw8X2zfblwiVMqw7zZ5VBptvGHL/6w2vdKe3WkFLE9Zdr2uczIzfyFy5Cd4Qjll5W64oNdZjkL0wkuLDRcHcn6hOoYl16zCxFsXWATKxvlFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIVuzvSj/hDbxpyvsxtyhUk2/RXaylz8Js8VPDzqw2k=;
 b=wusMp2gjdDfV6xPuhXxhFImVDVc+3aXr4bvC7vx/HbjwgJKY6Jbzo3w5Q5cRPUKkScF1T11bdGh+0umD+9UFh/hoqcXw3xcj/f3Y5aJ7gfEN/nCrm9wjYKDRHVTXWSzoBxostlbIbyAynZDQEAXRyv/db43Cpb6qrYAriq9nJz0OR6VXVIxgSpT4N5d40T53PCGS9A5YqTZqcpmg8l9SImgB6cpPbavojny/ugxsF1Z9P+dZSCEax2MuYACmT6CWZ9bmv9bRQG0ECY+uTuin1g5+lyFsVTM8W16uRB3MgNWiRM5O8AGZxm3Bl8lSmYrogfFQpLFPJZ9m45+ESXW0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVuzvSj/hDbxpyvsxtyhUk2/RXaylz8Js8VPDzqw2k=;
 b=ojic2HZse+VG6CtF09Set2MhTlpoHLAXs9IWOcP5Garn1SJ0IsqpH6pwpzrdMRKsTesDgInvrv7pCabB+Xt1Pb6fcV/VfghfXk0krlBJKsev6VtkJcwyaKrDjuIpTAd16BfVk94HSsXPoGRJJvGFDgKZFadUWI42WzpdnElSI99r8DhyejHHGliXYxBusOqlEEUH00VQEMUuJ46sO6WXLZRkbh5pRvhtxaOLL8WreTgBpOSBGJkdI5vwgfF/5psFahg3rXwLglNLwI5R82B0C3uvIwHJ4f0LX9K+wkAzMsSI+/MRzrOWzSg82O2gWqrzQR7FFFkcGsPO8s0tsnO3ZQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 04:26:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 04:26:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Keith Busch <kbusch@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests 2/2] nvme: add nvme metadata passthrough test
Thread-Topic: [PATCH blktests 2/2] nvme: add nvme metadata passthrough test
Thread-Index: AQHb3mNxTQ/s/feGf0OAjI448dzgurQFMNcA
Date: Mon, 16 Jun 2025 04:26:20 +0000
Message-ID: <574c41ef-10b7-4ad7-bfd6-d15389b71ff2@nvidia.com>
References: <20250616020716.2789576-1-shinichiro.kawasaki@wdc.com>
 <20250616020716.2789576-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250616020716.2789576-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: edc52c5e-b2a7-4afe-adea-08ddac8df1e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ek5KMHgxRWdpeWlRWWpLN3lManp3K2xyTkxOSnBtRjIreWtJTjdhYjBIZlRJ?=
 =?utf-8?B?QnhpNkVlSWZhZnVwZEg5alkwSkZoWTR1TGhpTUFSQ0R1V3drZHlGZXMyRDBO?=
 =?utf-8?B?MVE3UU93ZE9DcTBJTW5jRjFqeDhjbXRzOElUZGZoeGdpN3R1R2VZWWRpOWJy?=
 =?utf-8?B?VWNaU0xWd1RwY2EzVjcyby9YUVY1Z29vWHF5ckZiM1UvTTl0RkY0WFlaMUhO?=
 =?utf-8?B?MXY1VzR1ZjdkVkh1S01pQ0RoN1N6S2lPbmFrWUpOZFcxTnh4QWVON3F5L1BU?=
 =?utf-8?B?b0FUY1lYaGZNNXJ1SXgwbmoxRXJEbWIza0VMR3JBY3V5ZVo3a3U1UkRHMTlT?=
 =?utf-8?B?R0RjTWRsN09GcDRRczIzRVJ5OGhGTG5DaklFcnBwRC82T2pPRDkxYUJMSkJa?=
 =?utf-8?B?QUZaSFgvS2JuSUN0M1ZYMnFiVktFM0Nva0d5TUd5SERjek50Ty9aUjg1ZnB4?=
 =?utf-8?B?YmJucjhPSldUbk5tVkw0bXh4OGNQbnJldDFXR0pXRjlPd2k0YndJUnFmZzRk?=
 =?utf-8?B?bGhseWFNK3VjK3FmZFhxSDdXbXRucE4yMENVUDNnWWtjTWgwQkJaQi84WnRi?=
 =?utf-8?B?cU5DOU5sNDhya2Q4T0FaNEovU0NMUVJyVU1NUlBuZVBxQkU1RHlpWVFrQndM?=
 =?utf-8?B?R1BOVEUzNWxlcTVsWUZtK1JLWGNQR1JRNm42V1ZvKzhmN2VPa3N1Z015Z2hN?=
 =?utf-8?B?MzdzOXhJMkdvT1R3ZUFSa1R4Z3lvWE1vVGNxYk8yRE5GM21lV3NTTldHVkhQ?=
 =?utf-8?B?YTlOM2V2ODhuZG13aFc1aDNRdEdNcG9LaUZtTCt5ZjFvbnJXSVgyZVAzUHU4?=
 =?utf-8?B?bzg0bjdscWhqTWovVFJuQVFoZEZEbzJFYlZXcVRGVGRKVG5kUDg5MEF6MGVh?=
 =?utf-8?B?UkkzbG9rTzFWMEJTbmJIQlRKcnkxQnFDK0FMM3l2U3NYK2NkdUR6RnF6M25M?=
 =?utf-8?B?TTVSQzB0SHNEakk3c3BTVDNYTXZPZzg1K3pjOVFKV0IrWjU2RWZWL0lVU2dm?=
 =?utf-8?B?LzZDSlh1T2VtbTNLTTVuN0ZOVnFzYUYzY20vL2NtM1lIZ3hNK1I4K0pRNEQ4?=
 =?utf-8?B?L1RaT1M1MmRBSm1aTUZ4TDRDMTJld29PeDNGYmhkYTNEem9EdkdTSEpMVWVF?=
 =?utf-8?B?Vlh2VDNhVVFGWisrN0x1cWQ2T2hWMkErc0RFd0UweFF3MStwOU4xcys5c0xr?=
 =?utf-8?B?S3BBR1NKZ1RYSy9ZVGp4aCtJd2xETmpkNk5KblNpK2k1NUxiU05UbXE4NkQ2?=
 =?utf-8?B?Z253UlFwS0RWNlpCY3lDWUpvYmh0WklaYXZsUWlMVjIyOXhhMmJwY1VWK3Q2?=
 =?utf-8?B?NTNmb2wzMEhPWTZ1YlJ5elE4UUZUaVZxN2g4Y01tNFR4bkdVT1NJWHR2ZzQ5?=
 =?utf-8?B?dHNZWDUzTVNWQ1FibnpjUWlsRzNOell3NmpqeHZmL0tIWXZFZzRLd1RBdGxG?=
 =?utf-8?B?MUMwV2QwMWlhUGNlSEpnRSt3eGpzUkFoRWNnNDFqTDUxUFBUaHlBbHZJY2JD?=
 =?utf-8?B?VEU2cklBZXdyQUdQdGdlKzBMNmdZRXg3a2ppeHB6VEJzVlByL1cyRWtQcGlz?=
 =?utf-8?B?cDVKeUlZcmVicHY5bEpuVzZRZjV3N25OZVJ4a09FdTlOVXdlcm4reHlZTHV5?=
 =?utf-8?B?cFAweElRZHY4eWJ2QmVLemJWbk84MWJ2MklJMUl1MGdnT0hHQTdIVFFyZlMx?=
 =?utf-8?B?MHRIeWo3UkVPUTlmdDJiemwxckZBMnBRV0FpNG4xTURzdzJPNjFOWHRtYjBj?=
 =?utf-8?B?TktzVGx1aGkwakZtTzNnS2c3TE9lNklaQWZBRW9Ddko0TG1UM2FoTDJwcnlZ?=
 =?utf-8?B?YWlTdGl4TmIvTGdnNjQ2N0w3THorVkhldkVLQ2J1ai92TVNuL1dOeXZZU0Qx?=
 =?utf-8?B?VEFpVi8zWWNHREJURVVqcnZaMXU1L083enVtY2hlcDZHaCtyWTVLWG9FMHVP?=
 =?utf-8?B?Z0VnSVpjblB1cnBNbkFocGI2aTNkS0doMENmb3plcTM4a2VscE13TWNXRWJw?=
 =?utf-8?Q?k8XmuSLqfOIxmO4T5hSUW5Y0ByprpI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdtQ1ZTdWNwZkdCMFdUOXI4Z1djZzVhL21IVGJUc1RNN1FHSGg4dmJyaVg2?=
 =?utf-8?B?VjA3c3dQaUlIR1VKNVlsMmUwSWpaNzV3d0NOVG56cXk0TEFZWXI4TWs0Y25m?=
 =?utf-8?B?MHhzc0hhMzFUMWJwaGJoVUVIMGkxelBoNHZlUXVEbXZycmZNOUV0S0E0SnRY?=
 =?utf-8?B?bTFRbC9jR2wwTnF0cUpnMnl5Z3QvaHZ3dEFKS013clU0Zk1Ia2hhTVBLNkM1?=
 =?utf-8?B?UEN6YkZwNDF6U2Zydlp0NldjRWlTV0FuV3dyUU1zRzE2UW5PWC9DcEdUUEhp?=
 =?utf-8?B?alpOb2lVVEVLRHp5RFlnSnNpWWthbzhrKy9Rc2Z2S0pjYisxS1E1dFI5SDVS?=
 =?utf-8?B?cDUyb3BIVjAvQXdzT0txbkVQeGw1SUFmUWhLSEQ2dUhkc1N5Y2FYaFViUnl2?=
 =?utf-8?B?YmJLcHJZRnF5L2FKdy94RW83RUFiZmZteGQ1WHdqZ0pJa01BY01uUU9ZQVRo?=
 =?utf-8?B?YjgvZEViS3FyMXlQMkplM0dsb04za1g2TndBRUhiWWZIUy9lTm10UUFOTWdQ?=
 =?utf-8?B?aUpobjg4UHlVV3BzRVhRWnZkc0F2Wm1PL2Q3VTR3bmlNdFk0OHdrT1VJTDNC?=
 =?utf-8?B?ZVJ2czdnTDNHQjBZcXJrRTJ6Zjc0ZjFZa3dFWUdQU0ZmR1ovWUd0T2FSTlRH?=
 =?utf-8?B?QmRVb3k1QWJ6VW9EenIyU1VKRm55Rys2dGd1WkRoSDFONVRWVXA1VlR6c2NL?=
 =?utf-8?B?djk0SzN1Ykg1MzAzejlZYUw1OGk1SFE3TzNLN3J5KzIwbVZrU1pkZHhrcmtq?=
 =?utf-8?B?TDZENnNaOUUzU1BYN1kwV2hINXVLR1ovYUNwOU9EQVhDdlVxM1Ftd0w5dEdO?=
 =?utf-8?B?cnpJNkgwZklmcWtjZjBZOUxwMmg1REYwUVZ0d0RsRll3YWUwSDdqVGU4SkJJ?=
 =?utf-8?B?NmZCN25wRlBFaU5nb0VmNHFRblpCVDFyRjhXRE4xeTR6TGVOWUJhNURnbXpS?=
 =?utf-8?B?K055YkgrakprYWFtc1hOV2J2QVBDTkh0K1dNeDVOYllDR1daSDB1Yk42YU9S?=
 =?utf-8?B?VzNxZWZ2blRIWFViOTF3TUxGbmFIMWdDQThFSjNEQ1VkdzBpRE1sdlFZNVJ5?=
 =?utf-8?B?R3VJUmVQcUJ2R0Z1T1ZRUkdWSG41OXFHejZyaVl4MFE0OXU0UnpKU0FuTGF6?=
 =?utf-8?B?dVZvaXROeER6NjBKTytSaVZaUVRQUFhXeGRBY1ZQSENnLzZjYWZkSFV5QnBk?=
 =?utf-8?B?UXA5THdTeDRJVzdDTWhyNE9KeG1BVEhjakR5NHRrZXh3ZDFsN0JpVDJhMDJn?=
 =?utf-8?B?ckhhNXNISFR1WndXek1jQlJ1SWc2MW9BcmRuWGpCVnlYZDFEL1g3czkvT1Vt?=
 =?utf-8?B?MG94ZlRYelJvVHUxemN3akx5YkptVloxanAreTlnVmFyR0VlRHl1VkFVZWFk?=
 =?utf-8?B?Zng5V2pUam4wK3phaDEzNWpYUUJWbzdsbkZOeGxwTkI0Q2Y4K1F0N3phMWRn?=
 =?utf-8?B?Y2k5cVNkRmNualIxcUN0alJQQWpsTlRwSHZkeFROM3VIa0NSS1ljRVZKeElV?=
 =?utf-8?B?NlhwWlJEaGNDWHpXMDJNNVJ3bytpQjExSDdjV1VrTEFKUzBpMm94R3N0aGNH?=
 =?utf-8?B?MDNGdFh6dU9mZUZtMysybE1zZWZycElwS09LZ0J2cE9iMmxMMjE4ZnBwNTF1?=
 =?utf-8?B?b3RRUlI4dlo4MUE3dVNCdDRRL2gxTmRISjMrR2R2OE1jVXluRlVuTVIrb1Jq?=
 =?utf-8?B?SEVGM3hUU2JTTGxMMEJQMkQrK1IvZEMwdVdZRTl0MzZJdmZpYkg1RVBHNCtj?=
 =?utf-8?B?T0FDb0J3TmsxSjFQR3NvaTlCaWhiRDY3UUx5SDN0WC92bXVVZ1pydURkVDl0?=
 =?utf-8?B?RTV5RXRaMmpZUHdQc1ZiNzQrSzMvcDczWHp3ak54bW9WSGZtZXMydUEwNCt3?=
 =?utf-8?B?RlUzQ3FTSmpxZVhUTVFURmRSNXhNcEovQ29DdVRhdlhudnFod1A5ZFZiQ2ts?=
 =?utf-8?B?L0lBYlVHQlVBcUNuazFhNHFGT2hkQks5YnlXQmlwbUdyTmRCaFRWRlhkRU56?=
 =?utf-8?B?d255cU1vYW9tdGo1akxtSzdROUk1UktONVBkUEZycStOczUvd3N3cnd4bytO?=
 =?utf-8?B?aXMvODExYXlnYzdmbUlsQ3JKd2hqa0FRZFVacGt0Vzg0cjlReVJMd3Z0RDhn?=
 =?utf-8?B?T005N2R2T2tEUDFERDhReUMrYWcvbmRHaWpscTMyV3JxR25zSll1VE93MFoz?=
 =?utf-8?Q?y+/bLDrO5dMFZyGtFsTol3j9e08YQ+x4TFyuVP/qjClg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528E47882CBAA04382963AFAAF0BBE6A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edc52c5e-b2a7-4afe-adea-08ddac8df1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 04:26:20.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEN60QE/IgqElVkPmC+cZRKnNnG7eW0P5UK3rG4qqZamueoy7j7XHbr+WCn7iOVVTINGC/N3/pa0Rm0jbCWWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144

T24gNi8xNS8yNSAxOTowNywgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEZyb206IEtl
aXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBHZXQgbW9yZSBjb3ZlcmFnZSBvbiBu
dm1lIG1ldGFkYXRhIHBhc3N0aHJvdWdoLiBTcGVjaWZpY2FsbHkgaW4gdGhpcw0KPiB0ZXN0LCBy
ZWFkLW9ubHkgbWV0YWRhdGEgaXMgdGFyZ2V0ZWQgYXMgdGhpcyBoYWQgYmVlbiBhIGdhcCBpbiBw
cmV2aW91cw0KPiB0ZXN0IGNvdmVyYWdlZC4NCj4NCj4gTGluazpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1ibG9jay8yMDI1MDYwMzE4NDc1Mi4xMTg1Njc2LTEtY3NhbmRlckBwdXJlc3Rv
cmFnZS5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3Jn
Pg0KPiBbU2hpbidpY2hpcm86IGFkZGVkIHRlc3QgZGV2aWNlIHJlcXVpcmVtZW50IGNoZWNrcyBh
bmQgLmdpdGlnbm9yZSBsaW5lXQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2Fr
aTxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQoNClRoYW5rcyBhIGxvdCBLZWl0aCBmb3Ig
c3VibWl0dGluZyB0aGUgdGVzdCwgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
