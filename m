Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD74366055
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683387; cv=fail; b=kTUdGqIPADTJF6lsEFZpLMNn3mrO9ijaESv9jArysCSx/ljI8OA413c58QrPZTl97PNJuJCxMDTrkkxAY6qY7Rm8u0tPCAogkBJiH2cZRE4YDHkUL54QIgWX7lDV2w/5PUAsd6lmSpxgX1a6fPokPv3zPm5hzj7MUFYZq8VSsjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683387; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuhtXczVMcHwm26nN+z3OgFQPIEu4VCkl33kGsQMzjqQVKir+VJ6GCaMKIobmocY+D/iY5l0fk20MpOiaAtAg1l2J7YLpKKGUr4rD+hdUZ2EKtrpyAaYbanzMT56Dry271Aw5sP630JmbHA3aOLemaU8iDImUgz1LZm+T/3CFpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuyWLosm; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RuyWLosm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqVuXVnkxNm0rEJvBze26XmwxrAMEXErp1exjX3rheBYdrVJyqdV5KhHwpCJWPcqrIChDvLb33VgAH6xIusytafTliFGfaILKkHJinltrNndClhWsxMH35LPepMCNFbz5NmXjcqpkdt/iDBIBo2vgp1nPSbDOs+3PJb9AA2l4ds/RKK35epTsswNBf4xlubLWcPcc4u7Cq+sb8AIESiHSoAg2qtCIcU2SZ/jUtPwDHOfdRmbJeFoKfnqVCT4nG4OIxkx2l6XiEboZPHTzO345eds+DS6xDuvQCzcdp/kn9XEjEfyYTuSwICO/aSq8d/G0RDqihmrOqt6osW0mH5rGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=JBpB2QO/23zJv/YusTcRwSY5+ExjSkZGVMi0imVefzBkTTihZ+WkS/atbeuMnQBW8JHcetzdfP1UgsQ4G84NzuAnBw/63jAEf3PnRjuS2rxtTMzg5TYzhuCx+OdN656EB70s1kVj5LmtR61+dkLdH+2GZQtX0MzE6UhkgtHAK3SV5nT57veYzcmtqtZWZqCVp6aCfxuUfmr5fuXaBeZvMgpZTcz1dzPsOoz54kMArFx8v3ipharRPhsbuTRms/DynB1N9xlEQAIKF/8UnvbFNNsQXUE4JXc377hokDTsnwHmEom9xxZXMe1Xg214ed4zmuspvz9/KKbVaaqw8f+aHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=RuyWLosmpVN8DjuIc6JS4ck2oX0YogjwAgJF5ttLJSoe3UdXoIpJ6OAJPg/agIK4c7O4DTEfLKNdD8gnp5OeEql0JZt0s5M0XWuDVnTs2Ytm+L71MIpNjCbgA05jhjwkyig2LlDTMxA5kZAy4PlsfF0duKj740ZL8rdVGYFJVyUp3O9w1uqj22od4TYe09HCVfFO8b3OVC0hL6UzrxI3zSv6IXbpoF3IBSnwb1EbPESUXLdkW37P4trbDWO3j3Pu6Vfbqpsw/4kp7+/ZVeydhVCBVWhjNiADFrUwUUPWsg5fj0maYZamVUIlZK97pYJqrvf5YTp8CIZvdh7rtLOuqQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:16:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:16:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v7 11/14] block/blk-mq-debugfs: Improve lock context
 annotations
Thread-Topic: [PATCH v7 11/14] block/blk-mq-debugfs: Improve lock context
 annotations
Thread-Index: AQHc9RXM0mvp6/To+EuFOGE3g9mWmrYwRKcA
Date: Fri, 5 Jun 2026 18:16:23 +0000
Message-ID: <7387c6e4-d02a-4bc0-99a2-ba4cb9d9713c@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <f58fe220ff98f9dfddfed4573f40005c773b7fb7.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <f58fe220ff98f9dfddfed4573f40005c773b7fb7.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: e16831d4-ba27-46f1-b7e2-08dec32e8ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 CjIzNKn8ZbXw4F2uKuBE9FOLCtP1RnaDZAJiXmWZnl+CyEdkqRoK2PcpovuWDmN6GloVPtOurH9+JGM0fqiMa/WYPk4Y+SVJUEa5XDlbikFaY9/avw1W6Zir3d8e5WTbOUKItvI58q1qrw62BusJkdmluMw266WzQfC8SMjim9WC7RGhXeND6G1G+eNUTJWbWG+9uVP6KhAMUxBfi8VB+EHvF3SXRSrvi6ATcHEW6SY7mtTtcOCmzCeDnXKTJ7KA9u13qTXno/qWUmaQ0h5UaSOAtGqnx3k6q1g+rLSu4GM9vIN+kGTNlAXWvYDJTev7G2Nv7vwYJWQrcvlVgsqzsBXjmOHYhoOXDDhTneIeuHesppyphJgYAyzQQkZOfEoqEQfI90kBr9CoGwit/SonUojRTiouhe6DsOb41DfaPySx3d3RYhcWgSP+3pBkovTqEJ9kqmaZ0f3HQKq1gUMyTrWxE9ra/pfxPhpSLojREkh0t9fGC5/Zzn2tSSKAuSPqkewxqL2L1SbS7NaOBOee/cP7QyqOmG3HKVcftLh9OSEU1HDKBF77Zg5l45uttkR/GwEzBPFMNlaemlRy3MonbbZmyKRDZeTBz9iN/JJIECyjoBPQIswQ4GonTDAIsHdLqxFouGFXXyr/D0MHiSYOYvOcZPKXRVbXmJItgRUcpMrlZ7yZ0EAKjVvdqena4sy2XLoUmWQ363IXe1AW8ia7JtKrK1MlAcj96OFXcZ7z9lFshpW3QR1gIt9OUB9E7D9W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWpBdTdOb1RYbCtiTGoyKzZEaGZUWTE1dVJVNnBNRm9tRDdxT3Ixd25lNXg0?=
 =?utf-8?B?bjR5bUt6QUk0cEoveFZaNTlpVjJKRVFaY2ZJTys3ZnBwM2NQckRqdnJ0c3d4?=
 =?utf-8?B?L2o5TkppcGlkV3owR0Q3ZXVEeGR4SnA5SUdNY2NnZ2hpRkhyb2R5Q1MwSy9T?=
 =?utf-8?B?Ly95bmdhZjg0UzlpZTd4cDFKVmNlUlh2aHcwNGpWWGFzMGZsN2I0K1dod1JK?=
 =?utf-8?B?ZFNNSFZCbnB3TWE1TGJ2SDNuc2tDb0ZzeFZqTURpQlEwYldOMnVpRDEwZEZZ?=
 =?utf-8?B?U2JTUTlLdkg1d2Q4ZzF6Z2VKOW0xM0ZTWXVQcEpnWEs5b1cydENHUENJWWFR?=
 =?utf-8?B?OXJFQVpUTnJkUFBZb2VHdnlDbE9kcmVnUytJRlRmMmVEMzEwTmFTbHRqTE9a?=
 =?utf-8?B?eWtWRDVNeXZvdzhOZWFjdlVyN3gyVFU3UGxWa0dKU3gyams3VXgxSGErcFdC?=
 =?utf-8?B?M25mRnZNYm11dTl4MkJRY0dBeDYxRmNOWU03aDFaakJJR0JNT3RyRkNWODJO?=
 =?utf-8?B?N1NvSWt0Q1pNdWY4NGNjcXBza0RHdWdyNVpmb2E3MWdRR1c1dXNiaUVnQVpp?=
 =?utf-8?B?VFhNdk1BMTNyUXJsZU9hQVZUTG9XQS9sSHF4YzNDWlJCekQ5K1FrSUVyMDZJ?=
 =?utf-8?B?TWtnZ3UwdWZicHZiTCtOMXZ3bjZSTm5FRDZqUEVnb0toU1NoaWswcThFcnZY?=
 =?utf-8?B?NVJaY09TbmNFRUMwR3M3MnRtakZSVERKcER5VE9NVHZOY0U2S3dJMkUwRW02?=
 =?utf-8?B?cWlRTXRQcmxrQXFzU1lKZ0VyVk1FUTVGS0tpQnJWYVlpTHNWbk5sc0JQckkr?=
 =?utf-8?B?Q09FTXJiQ3F5VHFsMEhDbzlzUHNZU3pocFpIYkQzSnN2a25uOGprczQ5LytT?=
 =?utf-8?B?UHhKWjJxbjBoWXErR1JLNkViYllnVHR4M2Q3U3dIL04vQ05lVXpZZy8yV3dk?=
 =?utf-8?B?OVhjNVhNV2R4ZE9WdGJBUzdabkdManNQRjUycUJPd0VLNXUxcEUxcENPV09G?=
 =?utf-8?B?aFVaMGlaQVZXNkxndTV6MncwNTMzVkdEbjVKVHNCYmpvMFYzVlV5YXpzQkVM?=
 =?utf-8?B?djk3VlNCbWFDQUFPOW9ZSzVvVmgwN1JWNnhXeTd3U1VweUtoVEZyZXJ6czhl?=
 =?utf-8?B?ZjNWTlNnL3JoUjk4d1VUUUNFZXR3WHZ2OE85bkZIK1pBL3dXdzZSczFncDQr?=
 =?utf-8?B?ZU9Sc05OKzlrUjVxZHRRVDdFS2JlTVhHWW54amlyOExoN2NMc0hyMXVTMVUv?=
 =?utf-8?B?SjZFZTBLM2NTdTBmRVp0aGI1a1U0MG1vZSsxTDZPM0JSSmw2RVFjcjRnYm1k?=
 =?utf-8?B?SGtDOVIzRHk5WXprR0dyYTRlNy9WYlRoMm5qWm5qRjhqR2tUUzBiajV0Ylc4?=
 =?utf-8?B?Z1lXU2VFcWkzNCtTMERRbG1Yc1hCMGJtbXZ3WHpoazcyVmJPS0gycktjM2pn?=
 =?utf-8?B?eVZOaHBaZGtiLzdlWXR6bUg5QU85UENtVnlYdzNMQ2UvekovYURFZFQrZTNr?=
 =?utf-8?B?MlQ4WGlhTkgxalFpYU1EWFYyd3hNV1dQWXdUZTRldEpMaW5SUWtvMWtxWmVX?=
 =?utf-8?B?cWNGem5jWmRybUwvU3piNm5qTGFWUU1QeDdHc3VBK3ZXVWRhNFI2VEFMa1Jj?=
 =?utf-8?B?TnJtcWZDNVBCaWZnaG1hZitTMTJQcStFMWFKLzkwenU4RjV4eGpNd1hmVklY?=
 =?utf-8?B?TVlYT0FjL215dmhtTWMrWUtCWjZHK1phTHBuT3ZCYmNEYUVrVUJFcll5WDc3?=
 =?utf-8?B?MCsvM2o3Q1lmWFBBT1pnTUNzVmpQaURQRE12VTQvQXRkY3QzcUFNV09VckZ3?=
 =?utf-8?B?YXh0Z0RDVDUvakI2dWd3cjlhZFQycVZUWG1sQnphWFRCdVBTazBCRytkbzVm?=
 =?utf-8?B?OXRTSWNmeEEzaEc3U3FYeGVVR1BRN2tJbGNOQ0ZkMEFwbmxFb1ovUnRpVVFI?=
 =?utf-8?B?SGlQeFhaZ3F4eTJnZVJ3b2hJTStqek1VVmw1bU1BeWJBYm5nZkxwSkllcXJi?=
 =?utf-8?B?a3JDb1hrS1g3L1lqVENibFlkRjJ2SkdvMWxqZlkzNXp2S1VvMWdCcFRPV3BT?=
 =?utf-8?B?aHZuYzkxRWhFTjA2bmJBYkV6SHZSRmN0L1BuNlQrbmdxMzJrZXFIWmVSSGFL?=
 =?utf-8?B?cGRMUmFzdU04dUo1S2ZKaTlMaE0zZ2tKa25JZ2R4eEZjZUpiRXpvbkJ1eEsx?=
 =?utf-8?B?WEdrYUpSdlNOdWJxenQrMEpFbHB6TlkwaFJMUVQ1KytrN0JTQUo3eEJnOEc0?=
 =?utf-8?B?c0E4WlN6bk00STY3OXBwQ0FNdXdjdXp6N0pXcDRuL2ZadUloYU1hNi9JNG0v?=
 =?utf-8?B?UFVpbFhpZDMwVVZrNXNPOS9IS2x5YXhid3pkU2pHUnFXbVRtUSs1YW5yVXNw?=
 =?utf-8?Q?PJiVKua1GnoIbemOEnrvBB19q0Vt9M2AVAV8phX7qEVAE?=
x-ms-exchange-antispam-messagedata-1: Nm8IzF8R+4JZRQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4DD980D3C0381458EAD8108057A58B9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e16831d4-ba27-46f1-b7e2-08dec32e8ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:16:23.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNT1rip/BzoQcyOgqCquV4RiFmTA47w7repdFkYYxowYVyGotG8xI1k+o+lZNY5bCgao1iUBK54xo7JHzce1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
