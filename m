Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2104.outbound.protection.outlook.com [40.107.236.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E915688D
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183274; cv=fail; b=N/8Zy0s/FZXQRIy1rL8xLaWPZ+jro7A33QJzltEV+9dONaxaHEnyLfCpLXYuacAx/NuEK6DGIZ1QVMY/HxoIQQZbxOImiXkm6b26embOTvDwt4a1p1YzMuarXzMTk4dTRTvqa1cjA867wS9TBl3moiXFgZlWfToxknBRLwn1JTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183274; c=relaxed/simple;
	bh=yf+rayQDMMsfBuhrf81d6opqOskMTzKYoCI4fRZBf8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHhNST429mq04NQTfKHjIzzBjeZ6tleyctgQ+umPum2JfVfAY0FASaztvCTf9KA4NShkgH6CLdmujOuLOZcnF1SLKmay1QRe87XjpVlY+yD1KBAqQLHAyE8ZnVTgZyo9kLxNhaaUPq1BLntczX9Y9TQO3Fw0tghnT1sjBs115dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/WDWAR9; arc=fail smtp.client-ip=40.107.236.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/WDWAR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJapUjjWGAoCQ9WRie861CEv65NFHW5XjE2qZ4j/xSxF2bLujgtpIzjTIu9fZNWMTEpIoS7nsJLn3utpdP/XytcO+zABTSnL1xRpwWAgjS0Dw2eKtJF6wPuJdw9sgM//a8ora91aEwEd0yyhlKjdIPLeSZfvhKFYIu/1tG+5lu8x6j3Uuno0Fo7zHAM3vCLxdUtG1U22qPhPkatZPuJQOtPrkaObXVKH65MpMDb3ObB05/H0+0b80YayWKML/fGEgFqDGslH843nVK+B7DyiDne3HHY8R1+YPlRVbbmun8BBpqxJCOlnUQx0VA2CTjVeoQE8v/nPGYhrwvbRshK95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf+rayQDMMsfBuhrf81d6opqOskMTzKYoCI4fRZBf8o=;
 b=JAmsTAWLilLLKsQzptvp8Vt8Ku0YCIycxTFsVrdE1F0aQ5muGnZRI3J5R4yHzccUz7TZyrqeBPcRes2u8HqPCN5raHEyLvj66HVZFeeoDhKuQwQ6/BAHDZH+9SKFsRAw1nEEF6G0TXgF7RSUxJ8xJGfwxHRWoeRa1oaCc4+zkqz2OKXaB2XqlWmngvI3jttzlS2n6LGuxDcULwrIGFB8ZikVqVbqnzB0ntbsqN+mm2Oa9GA5hYGEOOElCYEwjcvAn1deeFVjbuboARlVVYGymNQTzDJ41U6fxKjnosQlAkrfSyUU4A/A25JsBXaCRsBcU6rnRjoMIZIxEuCDu+C5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf+rayQDMMsfBuhrf81d6opqOskMTzKYoCI4fRZBf8o=;
 b=W/WDWAR9H7lpIGE4BmOx+KuJ7e8EwWGUxKINshyru8FKQiPacFPFLOAPkXTln0mI27LW+iQFBBO8gXd1wVyahvVpQzTw3o66SENjbzXMTrQbQFtm9wJXFUfvrWiqAhioHJggfFEmSaqKgUB+A9gpGU2bQ42bQu0Gb6463dgMs4DhIK++dSF4xAIQgB9Zlnz1HNV8+BEgmXFWYT7MoErTBnS0yvKoYXK61pM1YjLHxn8YQTahEIkCFbuRco9Wqf3OHXMz4zcZeVMdqzHh5EFIf83cpaKvf7T2igCiq+pBxLhF0JDO8FsDkZuc/+hEj5XTBLHy+sANvHPAPfb8fSlC6w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 22:27:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 22:27:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Topic: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Index: AQHahOUCNelU9FCOvkKppFZwzQhLY7FV/DkAgABEnwCAAOGuAA==
Date: Wed, 3 Apr 2024 22:27:48 +0000
Message-ID: <5aa4ebdd-5800-4701-9a80-c737b2760ec8@nvidia.com>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
In-Reply-To: <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6684:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HpaXgVSazJGaSemGjaIToTszqUvxJ8l0j5RFCUVLL4rhG7BmFzXGiRSPKzOAez/jtI6TeB7HSnNXkimeh5wvYkZvObfHWzTVO4iZrpepG8AsFzmt7AlhN7g1altdW29Ux6MHx6tjjPO8w5fGrFrA64R7CLfYvBIx4o3JCmB8/jb1G8m5hJHxyzzLYpd3q1XG0PUGpGBEhZn5QTBtPKsB5Y2eQHQCqfIR69regBF9BKRcJlCCSGj1LNkEpDwByU++9+2Rc1rAQMfu+fuzNsuqp/eaHKwk9zyB+BbuTgO+QRrvY6QVcJtkX+PMdRX0fhA2R9NggCWcULBqvQ4w57My2C4S3XuTDQpHa7YrWJvzUqmibmZkUbTNbiPxeylUfg/DV8eOabji+Em6Oyp6vHVWgjun5w7RHkqXXs9bAcCTJqDhOWesDDawvSCSm4d863jy1FyEkqEAJAXh+MEi7Qt9sJzLH0ImCJ9FqdmnrfyiYvnO+9xubnmB+gfeIHQLFU7WarLjlOzO3MZ3lKIrSOY6THEau6Z9GayiLHx0VoRjQKb7KJYnsWxun99+bMDjmF6cPBhBCMaXEt3MuB680h+6tnrsDdebWwwaOPtmTS3rm9zFtzRjhXd5crrxqSud9BuVW84EXeCzUHSsfGnq22cDL7ezLadSem8STvEKGpVKUXE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkJNbmlZK0ZPWFNjWDJUZUpjeEhWdUdSVUpBQTYxMW9md1RicmZMTkdMNmxi?=
 =?utf-8?B?a2dWc0pOTnUwSW9hSHcyWldtQmJyc3hHcnRXZVdnUWQ3QlhEd3hVSlpZQ1hD?=
 =?utf-8?B?S3pFOE9jZi9aZUk4Z0Y3SUFZNVNiQmVNcVNJNkFDMU5Ja1ZiYkxGRERkbFlH?=
 =?utf-8?B?M2M1SDVWZVJOR2hKcXd2eGhwYm9GMG4xT01xZkdNZ1N4ZEwwUDVsd0dBcHZr?=
 =?utf-8?B?QTJnY0hZNWNPMGZFcEk0RGhPbkZBOFlxTGcvMjIyVzV0c2FNMFZhTG15MC9J?=
 =?utf-8?B?WHBqRFdVMUZ6YzhralZvUXd2NjNySjBTVnR1cFdTQ1pQYWJUOHNoM2cxR1ho?=
 =?utf-8?B?c0ZYYmJ6T1V0QkVIVTE4VmwvWERRLzFlT0ZCcU9QNlA0YlVJY05RT0lOZHdP?=
 =?utf-8?B?VUlKNDM1OTE0N2Z1cG1peXJ6YjkydXoybndzdmxDcU8zZ3BsTDRCU0ZZcmlN?=
 =?utf-8?B?SnE2WHgwRDZqZzZlVWhBcTBNaXZXN3JpZkxsVjZlakorZGZ5STNXdGNzUXln?=
 =?utf-8?B?Vm9PREVVa3B0NWZCSFBLc2tpZmRTM2VYMGtjclpBK3Z1ZWxVQ3BVWTZjWW1t?=
 =?utf-8?B?blJ2ek54ZXp3Q0ZmdElWb09UNzMrRGNhUkFJS0dDeGJEOFF5TGNtZ0ZjVG52?=
 =?utf-8?B?QUJOZUloeVM0S05pOTBSZHRUeVFQYW9qYTRvWkJ4TXhWTXlNZExRQzlReDNz?=
 =?utf-8?B?Z2ZrSmowTDJnTGZQRlp2eEU2RU02OUViM1UzQWpheEVTbS9GMXdTZzRLUWFZ?=
 =?utf-8?B?NzhGcHhpblpGVEw5d2FuSHhVTDZRYmZRZmRsU0pDTjd2Q1Mvb09jek9GUHpl?=
 =?utf-8?B?bno1VDFUbjNyUWM4ZVVnWTVJTzNuTjFxV2srRVdaMmJtRWZ1U2d0TDEzazZR?=
 =?utf-8?B?YjY5K2UxY0VDY2R1OWVOeWxUQWErMG9QYWxBVlk0M2dydzd6NHZLM3ZnbUJM?=
 =?utf-8?B?ZkR4MWhOa1p6RTU3ekNZVVRPbXlHMXpobFMzZHRNRGdxckhRUUp1TEhzVVZz?=
 =?utf-8?B?NWwwTHQwZ1BUMjVBTFdvL01VNzc4ZVBpQmRlK3l2YlNVcGRENVNwblE3akNq?=
 =?utf-8?B?dXJmQ1RvcHFHNm80S002NWl1d09iSjVybS91WTU4dXI2MWM4Rm92YUxDYUNG?=
 =?utf-8?B?SkZFWmhxWko1amtFYVpQQ2ovRDBjY2dyMEZoQkRYUmtlNkIwbFRWb0ptNWdZ?=
 =?utf-8?B?b1hSTVlHN2ptd1REZG5qYWVQUDc0WnYwQ1RJSVpnclVmRTdPT2dXcXNoc3ZS?=
 =?utf-8?B?RENSTlVzUVZhZkhYbHRwNTF5WFNSNVVUQVIvRnBCcnNIK3dLb3BQbDExa2lD?=
 =?utf-8?B?UVNpcmFXeVV6UkNTYXkrY2hIWklMK3ltOEwxYXRlS3FETGg1Y2hOZ29ocG10?=
 =?utf-8?B?Tlk5NThzRzlPKy9WMW1VU2g1QXhIcFZSNzdZNW1zTWoxSHpXUjBoc1ZjZ2RE?=
 =?utf-8?B?NEc0ZE1INHhwYUwyS3UyL0RPNTcxUXVlSS95U1hqZFZERWpISWYxeGtOMUcv?=
 =?utf-8?B?UlFpbVIwQWkvajYybzllMGdTVS9Nd0hOMXc2cjkrb0hiU0dQTzB4K1M2V0kr?=
 =?utf-8?B?RW4reFBoZDROYnJSZVIraThkMXkxWTg0ZVFUSW83eFV6c3pJdkV4dzVRM1l6?=
 =?utf-8?B?YUVDd2hDL0E0ZElCYjJmUjhLbmQ2Z0RGWHRPZGJmdEE3aFgwOHZ6SkdEN0FE?=
 =?utf-8?B?Y0s4OUdLNnFLaEVXcnpTdXpoL281OW5uMWh6OEUxUGRxU0x0OWs3RU1uKy9t?=
 =?utf-8?B?UFUrUSt2bmZOS3hWNVRXdzJrWUlPMFJuTWIvM2N5VTRPcVVsMHBSTDNQYnNX?=
 =?utf-8?B?ZTZORHFreE1yMkF2NjBEWGtFMSs1TGRVdHd2RmU0anFrQzhLRTdIN0NjWjBM?=
 =?utf-8?B?UVVneFdDV2ZnL2ZjbGFMa254S0xnbmY0elZ2dy9iVUlIZURFeHlJN0xmYXFG?=
 =?utf-8?B?TkVCOVdVQ0RUS3QwMFE3blJpQnJGWEg5cFo5WHI0Z3VtZ2VuMTZ4RlBYcWNi?=
 =?utf-8?B?eVJVTkZ0K1N1WWhvZFR0NStFd1o2TkpvRlI0MVFlMEh1dW8wMHpmYUdTQXJs?=
 =?utf-8?B?V1JrUUltaSthcW8vRHRyYzF1d2JncXhDRUNuK1FaV3RqZVpzQzUwOHZITXAv?=
 =?utf-8?B?Q0U2K1cybkFWOHlRN3dQWmRVZnRSUVJRdVpWTnpjc0JmbEFHVlE1NFRIL3JC?=
 =?utf-8?Q?Z5iYS3yBG43xavcByVJiVfx0mvXARcOvMDN12Qjnex5Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <352C643175D7E64982CE92896DCCAB58@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 333c4bcd-7210-4684-de41-08dc542d4b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 22:27:48.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rufnpvlr+8536TfE1m21ogXJ/Z8A3shDC6nTfIs+SeoXtalGMPbL9l9QDKbndNZSQh3HnC/7f5pdfAzLov0gAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

U2hpbmljaGlyby9EYW5pZWwsDQoNCk9uIDQvMy8yNCAwMjowMCwgRGFuaWVsIFdhZ25lciB3cm90
ZToNCj4gSGkgU2hpbmljaGlybywNCj4NCj4gT24gV2VkLCBBcHIgMDMsIDIwMjQgYXQgMDQ6NTQ6
MjhBTSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+IE9uIHRoZSBvdGhlciBo
YW5kLCBJIHNlZSB0aGF0IHRoZSBzZXJpZXMgaGFzIGEgY291cGxlIG9mIGRyYXdiYWNrczoNCj4+
DQo+PiAxKSBXaGVuIGJsa3Rlc3RzIHVzZXJzIHJ1biB3aXRoIHRoZSBkZWZhdWx0IGtub2Igb25s
eSwgdGhlIHRlc3QgY292ZXJhZ2Ugd2lsbCBiZQ0KPj4gICAgIHNtYWxsZXIuIFRvIGtlZXAgdGhl
IGN1cnJlbnQgdGVzdCBjb3ZlcmFnZSwgdGhlIHVzZXJzIG5lZWQgdG8gcnVuIHRoZSBjaGVjaw0K
Pj4gICAgIHNjcmlwdCB0d2ljZTogbnZtZXRfYmxrZGV2X3R5cGU9ZmlsZSBhbmQgbnZtZXRfYmxr
ZGV2X3R5cGU9ZGV2aWNlLiBTb21lIHVzZXJzDQo+PiAgICAgbWF5IG5vdCBkbyBpdCBhbmQgbG9z
ZSB0aGUgdGVzdCBjb3ZlcmFnZS4gQW5kIHNvbWUgdXNlcnMsIGUuZy4sIENLSSBwcm9qZWN0LA0K
Pj4gICAgIG5lZWQgdG8gYWRqdXN0IHRoZWlyIHNjcmlwdCBmb3IgdGhpcyBjaGFuZ2UuDQoNCnJl
ZHVjaW5nIGNvZGUgaXMgYWx3YXlzIGVuY291cmFnZWQsIGJ1dCBwbGVhc2UgZG9uJ3QgY2hhbmdl
IHRoZSB0ZXN0IA0KY292ZXJhZ2UgYW5kDQptYWtlIHVzZXIgYWRkIGFkZGl0aW9uYWwgc3RlcHMg
dG8gcnVuIHRoZSB0ZXN0cywgSU9XIC4vY2hlY2sgbnZtZSBzaG91bGQgDQpydW4gYWxsDQp0aGUg
dGVzdHMgY2FzZSBieSBkZWZhdWx0IGFzIGl0IGRvc2UgdG9kYXksIHRoaXMgd2lsbCBrZWVwIHlv
dXIgY2hhbmdlcyANCmJhY2t3YXJkDQpjb21wYXRpYmxlIC4uDQoNCkkgYmVsaWV2ZSB0aGF0IGlz
IG5vdCB0b28gaGFyZCB0byBhY2hpZXZlID8NCg0KLWNrDQoNCg0K
