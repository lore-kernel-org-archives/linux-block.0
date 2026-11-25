Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647698;
	b=gdMRHfBaC2k/ufpS0wALY7ppVJHQYIkOrcuH0VKegOED5BjH8T4nuea/ED1dVpXjnK6W
	 0PhVrWz1q++l5gLDDxuneT/T7KWSxBuXBGpEXZsaACxAqOVtsEF7NX9aG3Rm0ojxtNqyw
	 svB0Ex5WTJIdypYyM8opl8qaDn1EwV6LW2p7/uMQ+1Ok1lR+2qBcjQ8yIrhKPo6p1PTxA
	 wPasoretsdNNRVGB5iZFFIutm7JqoJEcY+SBpxzLCQ2X/BsaZdlhqqdikM2QVY+fPgG/v
	 825c2aRPCTXcP3FL9KMOYOrJp8aJhWYxEPwJwS3toi4IMOf6LNZEbTXEc8yPszsHaRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647698;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LRLwJ5pBg4QSMJmHUQfWmtNquVxKb2l63TNrK7AW0Uo=;
	b=k+ul8841+fn2f1z1bB5qKkyNEXEYVazT8LlOspSXDx7mXPQJxMItdkdnCjayA0TbIfmM
	 dZKrgIXHBBsF33IqofG6gcvZ2mFsZw/b7atJQLVdyRCKN//r3+UCeRl3HXihjDBJ2dv7K
	 Zj0xX/7g2ZAVRE8fPPLl7ZbOi8h2N2zN/rxKtf0aCIx0sLmXutZekUhVr5+/eAgZR/6BE
	 uKi1jupL95C67kMvmQs2Ta1GqFdUGpMSS1vubANg3QA8XAWC13DGIjjnsZxvUCSfJuGyY
	 q2OK1bQrh4nvqw9pzkta/ui/WJtVWKXjc6FPB6MRYWNzTSeZoLL/aICc+IphIan/8Hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bVyPjzZw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.21
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B27606A331
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B27606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bVyPjzZw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8JsjEU/arwoyn5q7wbT2xlF5Y1Nywv3gyWx9q0fBfQNHhQSDt+dv6LT+zJ9EZqpNNPeK3VPo22c0hE6eli74PcZPfo2G2H6Q44BWTKEt9AGYDgkszOQDK2Q2bW9DW21+OF/sJwrfrK8WR9tPlhgWFZV9myYqDm7AskEUpY6wzE8M3/SmJz2PqNXF7dNtpcFTZ/imnfKpSu4IdYLnUyWBEhX2sV0Yta4ranS90mdBVOGUVcRx+MsSGssZZI+hOhUmCSDhNQ1sBrzA/VMsbiwDAqiu5rz0u5YwTP3/kqUQuvt39EXpUGwBK3lD58gZT/WrhfDeY56wxYlxbYxc2Yatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRLwJ5pBg4QSMJmHUQfWmtNquVxKb2l63TNrK7AW0Uo=;
 b=bXZx+ozgmTL+O/Zjb+RU81fMa+PsM/e9HQz0gARhTBZSgPfHN5x3B6GcFYT3OHMOY9E70eVxdumzPwb0Y3LHZ4ANpmcobx10ls2XSTqSL0k0tfiY/LniRWjlH1T28CEQAl3MbzyZzLFwkRoXNYTb3r9eC2D/d0yPws5x0fp5nmeMs51aYwxuxADUW2qBrZ65RIpvpQ72BUwKIsyGGzRY/82qe6HZgzvBJYrO9K036eaR5HIlRVomIbhuWD3Kwxvyp9Bi9OWVNUp+BQ0UCR4/cOZvB73uO9p/WG0IjUb5B4995A+Zj/2acVj2XUXYsLEGqaPH7nJM1yjYd7emhMmuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRLwJ5pBg4QSMJmHUQfWmtNquVxKb2l63TNrK7AW0Uo=;
 b=bVyPjzZwLwOwiA+n3fNoTGfMEGMks7drLX/irpfCPnb1lraBtAWxIG2Ui9NmQqYIMgHjh1MHCbWJzUpBZMIaEKygc8o7HmCPqWp9piCD6ZTf7ntBEl5XVic+xBaETZ7WZtV9udCc6WUtBv6kmJwSJk9PF65XmxJB3aYASP7jKVL6c2eP436bybrRysywe7T5MG9O3Tkkby4T9NmrJT1Hdk79Win4gImYL1HCuoFj0CAWdJkqU06vskJyuZjo6oXYX8rkTPK7VdZZLitsAvlRvF2m+vkeDErmyuOCJOoupVfY+fMtv7PCiV9hyznRpDCNnqrv/+TOu+pGPnSq7Hij/A==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:01:31 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:01:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] blktrace: check ioprio output of ftrace blk tracer
Thread-Topic: [PATCH 4/5] blktrace: check ioprio output of ftrace blk tracer
Thread-Index: AQHdfBrMXydxB8RE0U2D16iQgEkv2bc/aZoA
Date: Wed, 25 Nov 2026 23:01:30 +0000
Message-ID: <40b00feb-1b59-4baa-92cb-75b4df14a911@nvidia.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
 <20261124135016.153657-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124135016.153657-5-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|PH7PR12MB5877:EE_
x-ms-office365-filtering-correlation-id: d6757744-ec21-409b-9160-08df4b480b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|261102123227099003|10067099003|261022113327099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|3023799007;
x-microsoft-antispam-message-info:
 QMP41/qePK943xwkjSCo8PNuJPbWUMMYk9GAmxzZ/iTqUFPHAWVQ1t0B26iqxpVEzpMHhasT8tSIf691DSA4BzeP+AT8FQJQJkDv6+JFtN7RvbhzJOTWJt9ozAMdK1bXMMTTMGsvYGlbV2IGE1dDF71sR9rE2ewvzXF0rlEIWCCpkBMqWUg2+tbNZJYwnH8ZT9Ve0VthHjV5a6HBmAqvTC9qVqIysD4zyifCa2GCBcP/KimXftP2f+aD+ABYZd/hkVQ/b9mfxhelgfUWmQZPIxqgqoR4Bv72prNynt2uZS+tIRGGlYyzlsNB9sRcTUXbsI7xmZNzhu0NZmba9JDIFuAM39GQFxmBtEO426y1har8QmxE8u3IFC6snSgjrWRqlrRCt3LDjLQCORUGx0HUOK7dpKylqdFa7wOjrcIBGubJT9k/AKEmCHjhtlUnsLJN9nrkMRCcqB+VCK/lXL7le9RpusNkMuVubtSv4Y+JBIWv9y+UJDgIqRt2maGTKV0arO6irqN1akrnmap8Qe6TSPoXxDRxSiRQAASBtUH9giurBU7IGSN3X63tfPPKHQGsiSBTPGj/BpJUuy02tMX0iVIj1aQwDBxbupxI76eeilAkdjlMrD3Tg5w2NMCLzljZ1gltNLM1KDNxLrluhdWS5G4FYinB7goF29ClVhmoZGrfSv50y/iuNtX0Y/4pmO2H1FVe+pBjex7hOwLPgeM2DGwxXnXf6Cf120hExpYtpvw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(261102123227099003)(10067099003)(261022113327099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk93Y3cwcUxEUXZlOURseStjbXhnVDdMZ3RZV0xLY25HWUs4a3k5U3NlckVN?=
 =?utf-8?B?TWJQd3dsbENuU2lLOFlOZUFIRDZsNWIwOTVUMDl5eFhXaVByN3ZEK3BGMjRq?=
 =?utf-8?B?U0ljbFQ2K1NqY1kwb0FMemovNzRZa3JGWFQvcGU2L005Z2hRVzF6UW1lWENK?=
 =?utf-8?B?KzVtb2F0WjNTZ0dnTHRiQ3dGYlFldjFtTlF2RlQwRnpvK2wrSXlTd25rSkJN?=
 =?utf-8?B?ZURrRzZkY2RMYWYvUjhPek5DWDU4SjZrRkgzaFZFQkxFMW9CT3FTMmxLWWZT?=
 =?utf-8?B?UDg4MG55ZFdKOGFDRVFqL1NOYVpUdTc0TEdqQjRTMmkzN1NnWjZyQkxDVU1I?=
 =?utf-8?B?VFNoZUJlbVpiNlQxMTJBOERURGF5M05Yb0V0VCs3YWhFb0ZEeTJHSHc4cGVy?=
 =?utf-8?B?VFRySUFLN1JQQUpFbG9SRVo5Zk9OUlo3YnhkdTQ1Unc3V3k1ZlV4TVl4VkNh?=
 =?utf-8?B?YWNjYmNaVlhCVWcrN0p1ZWdLdkt3QUplMGdYeGZCYzVLVDhCWFFoYUcyaTBu?=
 =?utf-8?B?M0lLdzFxSXVUdkhtNlVtdTdsU1AzK085aElCeURRYzEwa3RyTWYrYnhNeWta?=
 =?utf-8?B?SVMrMUJuNVZSdUtaMTFZVDB3Y2l4ZHVFT0NjS2VKTzNjV2dvQ0lCR0tESDJk?=
 =?utf-8?B?N3ZTQmEyamNVbklPVzdpRy81bFBoTGxDdUwzNVJUYkw3NmhWeEM2ais0c29F?=
 =?utf-8?B?S2IvOGRGT1FrSW0xS0MzRFprWCtYeGRmN0hLbHF0TE1kSklkaWlnZUR6eU1j?=
 =?utf-8?B?OVJNWGxOUjJ5c0V2VWxJbW9mMVk4M0NFRVVBQUJteHJxTlRaMjZVdkovOFRm?=
 =?utf-8?B?U3QxSWhWVy9CblNiVmp0Y0FWeHNQQXU1UmNrUHROaUY4bVpvaU9KeVArRXdH?=
 =?utf-8?B?Y1JwSXM2NmVrdm52TWtYTzFIR0pTS1JaZ3FnejBheUtreCs4L3hDL2JqRXpW?=
 =?utf-8?B?K21OWXZLR1l5UStJTkl0VVRyMmdWcEswV2ZqY3o4a1VNS2VpNjhTQUJzVFZO?=
 =?utf-8?B?K2RYbnBEcVlod0VXQWpXdGh3RmV1UVdLRkRoVStjWkJaVk5kVFZSUVNXQXI3?=
 =?utf-8?B?bUI1SzhhNkFzbk9KcGZrWVNDNnpoemd1dmZRWEQ5eXpSeWJrRUVlMlNFNlZJ?=
 =?utf-8?B?L2E1Y2hhazRtV0RMdmM3UVczVWVPSzlwNEo5aGpMTUVEWkcrYXZiNElqUjhL?=
 =?utf-8?B?clIzWkFsYUNVQStBR0JFRzkycm5pOC9kRlF4RGdHTm95OERMekI3K2pOaXhU?=
 =?utf-8?B?QkZqbUducVBKOHErbElSWDJYZXRUMVNSWTJOdWV4K1lPVU0rajEydjR3ODl4?=
 =?utf-8?B?SkpjZVVoMitjb0RVanpEVktxbUxocTBNMzcyS05hS2NBL2tsY0k5dGR1RXdB?=
 =?utf-8?B?bEU0WjMxYktxM1hBd0hjY2YzcU5qMUZ4LysvdGVqcVIrOFQxUWEwWUx5Umpo?=
 =?utf-8?B?NUVWcGJBb0RLRXhaS2EvR1FaQTJPQzkyd1hadG9qbnpzelgxaWdBZVhhWS9S?=
 =?utf-8?B?S282NmJKUDJKaHBkV1hVUGZUeWZMaHoyVTF1bDRyRVRtN3FMNlV0bDV3eS9J?=
 =?utf-8?B?U3pQMVB1bFQ2cFRKcjBCN0c1WnZoeEI3M1Q5M3BFYUMrZU0vdjlzcStmRTJw?=
 =?utf-8?B?Sk00d0gycmxtK2Y4SXVMakdvN0wwL3FoQnV0OHd5aG9jZHFrNnNPT1ZwY1hC?=
 =?utf-8?B?dFFHeFdCSjliRE5FN296QnBzRFdsR0J5ZjRiaktpYjM3ZCt0Rkt5M29MazVn?=
 =?utf-8?B?eENacXpJQndFNkZJa2lQSFd6STJYK2h0K0hRQTJNRU4rcTBnNEpJbDV2RXdZ?=
 =?utf-8?B?TTgvSTdIY3VnSGVsU0hQMDVEcFNhVktBdldzZFprZitMelRmdmo1SEpkSDFJ?=
 =?utf-8?B?dHUzVExXcnk1cmpWOUlYLytVUGV2R0ViWlUzYUJrZkFKL3NhcktiUnNZOW5v?=
 =?utf-8?B?Wlk5M3QvY3VZSmVQMVhtMnlrT1JrcFoxczR1M0FqTWdlMjR3VTlZM05IM2N3?=
 =?utf-8?B?aXhHMWF2Y0xOTkFCUjdheEVpV2ZLQ3piKzFoaXhuUjN4U3huaHh3OHY1KzBD?=
 =?utf-8?B?Y2hUT1Ywcm9JVjFvTm15N3IrZUdoQWhSK0taNFFzTGs1czBXZlo5T1BnNDls?=
 =?utf-8?B?eWVaN0FjR2JTNU9MK2NyZUhUamZBTERBQzBGLy92NVFUME1NR0cwZ1ByRDVP?=
 =?utf-8?B?T3FkV3k5YlJZZzB0aHhtTjFaNUFLUDRmcldiK25mcGR4RCtETjFoRVQxNm5Q?=
 =?utf-8?B?a25xNDloNzY3TTFabEFYNW9lYXNnUXVKRDNWcDFXQllqTnhOd3dMMHhsSklG?=
 =?utf-8?B?U250ZWhmam44SUdlQ2VITmNKVWxqeU1Kd1ZGMXFuQU1uUE1neng0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15947F16097A504C9755F29BBF7065BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6757744-ec21-409b-9160-08df4b480b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:01:30.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2QioH4pqP1lut0pML1wMYe4RIIBXWERZw/GuUIEDVTJzfZYqB78WNKtVNq8CwLEEAIl2akIkaMOtmOYPgMVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

T24gMTEvMjQvMjYgNTo1MCBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDaGVjayB0
aGUgSS9PIHByaW9yaXR5IG91dHB1dCBvZiB0aGUgZnRyYWNlIGJsayB0cmFjZXIuIFdpdGggdGhl
DQo+IGJsa19pb3ByaW8gdHJhY2VyIG9wdGlvbiBzZXQsIGV2ZW50cyBjYXJyeSB0aGUgImNsYXNz
LGhpbnQsbGV2ZWwiIHRva2VuDQo+IGFmdGVyIHRoZSBSV0JTIGNvbHVtbi4gV2l0aG91dCBpdCB0
aGUgb3V0cHV0IG11c3QgYmUgdW5jaGFuZ2VkLiBJbg0KPiBuZWl0aGVyIGNhc2UgbWF5IHRoZSB0
cmFjZSBjb250YWluICJVbmtub3duIGFjdGlvbiIgZW50cmllcywgd2hpY2ggd291bGQNCj4gc2hv
dyB0aGF0IHRoZSBfX0JMS19UQV9JT1BSSU8gYWN0aW9uIGZsYWcgaXMgbm90IG1hc2tlZCB3aGVu
IGRlY29kaW5nDQo+IGFjdGlvbnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1z
aGlybjxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
