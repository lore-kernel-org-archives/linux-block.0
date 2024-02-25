Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F73944F
	for <linux-block@vger.kernel.org>; Sun, 25 Feb 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708847617; cv=fail; b=VBWZEEbzMi4Tq5g4EbIuudcYkcu+Rbi8ZZZcSCE/LNI48LYU44+zlSB86uJmZPRV0RoZL+a7PFT9HQiNcWSnvZ1RlyOVc9QBe6CTgeiwVGz4A3L/09W18+zuqelsxl0RWIS1iKhwN0D4tWXJDdAdXDysndY3GGvxMQhlsbTDOkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708847617; c=relaxed/simple;
	bh=hYJcGIN2a3+a4Bj3643PFlCk8rVYEfSP1c0fr1BXG04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tn64hHLUnxGkbpuMABeOKAaKrYlb8LKomwWnaPdTPV+DI6reWBzyOiD4a8Ny+Lfxfk9Qlr4iLjVC5a4MkpzWZRQdDfkYfLZemX/3oJvcmZH6O2Q2gHcWFYwlBDLMW5e6Yb0gHSelYKmu1zTQt4s26uf85L+QRkgt0PKGJqh2LtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qBj7RdTf; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qBj7RdTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrFMb+y4TWmmm8sgyNvJqK3cOQcKg7hhFo/sVxJNa6SJdrH30iCMAfimuaLJFtPuJEk1Dm8wYS2wsW1RLFBve0zBLD9TQwoWUtBVUIwwTowAlwSQ1admyyvc8KOxgxh3ljz6ckHXLrlDnYP18Ey1XPWxN0e4Aa2qhy9VgtrCLHn2SQ7+ilK8MPF3qSK0B6Y+qbJfoskvy91U6SDYgUVrZ4nnGw1ji4wKAFTHmCmJqeTQxbmYr5s9U/P2RJHQ1Y9qvRD6d5NsYj+ISmwqzkC313P+S4GCc1I3t5aUkmunSGs9ZN5aPtEC8KP2aq31F6r7oRfOWJG8ebFZ7oqt6BzlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYJcGIN2a3+a4Bj3643PFlCk8rVYEfSP1c0fr1BXG04=;
 b=Zs9hNZJpDyj9eAm6mhEaxCsdpbPQ6Nm9OpsPa3NJNCFKpl8qr7GAldb1FJSnJIb8SLALaIZfjGrJl4opNZk8migVCeUUvjkxx1yCZ0X6FLlbk5khnWsQPIOX51rhEmIqsNvXLSfpA4KBjBMwwNwwYpA0EMPXQ9DwW1CAyCQAfVqjl/OL6NjE0V9qAq0ZoMlnm9lQu6mT0a6jMl1+gMUWvKMArUIqyNGAjY9DBMs+5foA1BsaXhK6gRoD2bPbsK988tqcdE09N9AXO+soRQbnznxZUO0OUoqR59DqG2VHjQNcbjdiyhXcppdDfeKdTq3LWQNBksZj39qAUiwcRUR9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYJcGIN2a3+a4Bj3643PFlCk8rVYEfSP1c0fr1BXG04=;
 b=qBj7RdTfIWd1xue5h5dBVEmMFKS5o7CdoPeUplUwYVKWP33KAv9rrL9k4XmDflBp4egYv6s1GuRT3x6WUM19WQbpF0O2hZFn+tPylr73+0fhah4JUUsglgLjrDGgCcSvVePMy5PjwgmqtKE1TCeuIfmpAWYQTQpuhl2L08vf4/N8WU2rLqAw0iJAbz+ayoBIA9xS09FAfjrJP6xqzGUlVRbXay9XS+XuTmIaDAq3K6BIbLOOYB35cOsq5T+gzL7+XhHav9X9aYJkTNAgv2nX/fxMeTWHy4cnKhze9ALmVKxHoOApY+qchHp/xSj4Q8p7A90Xf7zrNPxawmeVZNXK7Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 07:53:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.032; Sun, 25 Feb 2024
 07:53:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "nilay@linux.ibm.com"
	<nilay@linux.ibm.com>
Subject: Re: [PATCHv4 0/4] block: make long running operations killable
Thread-Topic: [PATCHv4 0/4] block: make long running operations killable
Thread-Index: AQHaZnFKuwnlZYL4+EOJ+sI80l7TmbEYTLkAgAAEUgCAAl4CgIAAA4OA
Date: Sun, 25 Feb 2024 07:53:31 +0000
Message-ID: <cbdaac46-8adf-43ef-8faa-2ee58b6484e1@nvidia.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <1a81ef8d-023b-4a87-a71d-a31dddf3106c@nvidia.com>
 <Zdjyrvfy7aELykoS@kbusch-mbp>
 <96f8505a-5fa0-49c6-96fd-30d5b42c0cf7@nvidia.com>
In-Reply-To: <96f8505a-5fa0-49c6-96fd-30d5b42c0cf7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6309:EE_
x-ms-office365-filtering-correlation-id: 56161986-e8af-4c94-3e76-08dc35d6dc3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5VZ6XXgRiHQmxWP8JVHyq6snlZQT0jvdsNbrs7VdBAMNIQdFdcAbh8m2On6/ODwJ8ZxAofYlybUk9DHoRE4qaahTzEftkkV3cYSW7amOq/ImbjMvtpaX+YebfHCocOH38emangbkN9BRxTog1JD4ENZUeFG6a2C7DjT3FfhdXvF/Q4f/aa4sp8wlBncxHdpJzEam3qQoaD+J9NaiC7wwJkwkFeyW2xw1SLR48ogVdVsM4tXeZ0D/LQ2xpSGnYaCN2gy3Xpr9rGtaXz2KQa2VAoWpgeM4ergLBrA/3jAQbHt0CsLzZH1iOfYe/3uZgNPkYHnKYqGVNvD/PaPvKLQAWtwyBjRrH3jvT3SsIdLSiq+KZ3UsVGx9zGsfBVTxFcJryjZzwje7slqQJb8uLgYxv+TajyhaYcO4WiTSoQqJobhmfpYsMN/rjqp8y7tPf2+EWiM88tqDC6m3BzaP0RQ1Rn8EusX2RFfwHciAPYFlFpLPn2iYmhNCjEdpwtxTnGZAFh9uL4gDU/BA+8VKriL1VwPAkLJULTznz3OiNQH0bgw+quplgm4VecSJiJYh1Y1dN9x3UkEoLNH9czBWbJziyMAvSdjJywKPs/CUuWM7+msOtZg+UO9MzOyWIA9EGr88
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUFVZ1hXV2lSckxrODVQRWgxNC9ZeWxMUUhybnBxYXlxTWNxcmtVQURxRkdl?=
 =?utf-8?B?SXJDMThSeWZLNmoveWpqTlRhTmF1LzZUanFmWUVpcDZGdW4yc1BhQ3dEM3F6?=
 =?utf-8?B?c0xWY2cxR2RuUVM4Um8xalg1YjBKMDVmUHNyeTViYTE4NDZzOEUzLzd3cW5z?=
 =?utf-8?B?TmFqTE43bE8zSWdaKzhqV3hjVjEycHZrbzk1QW1SdU5ZZjkrYzZtcmgzdFJp?=
 =?utf-8?B?VDQwSzJiQlVPZE9pa3dOQ3NWQmNwUC9XWXBOUU16elBaWEJxUlhrOVlZdUNu?=
 =?utf-8?B?T0NMdEFHbER0N1VwVUpMeE5rT2RrQzVEUjZZSk5nd1JXWlIwNU9MV3Y1QW1U?=
 =?utf-8?B?Qzc5KzdFT2Rkcnp0SndRb05vSHF0RTFrS0dRVFN1a0Yxa2FPRWpaSzZUdm5P?=
 =?utf-8?B?WU43RE9uVkMvcEZ6NFZUV3JRMllkQlVzeGtaVXJwWVd2UXladk5uQUQ2TmE0?=
 =?utf-8?B?Rm1tQnhSTjBHK0IyZ2UzK1pZMzNIZG4rVm9tbHMzM2RwL2RHMWRvZVcvQktk?=
 =?utf-8?B?VUxiZXVXdHRuZ0V1a0VnVElQVk94bmNJUlFxMXRKRE5aS3BtU1pELzdJckFh?=
 =?utf-8?B?dStBNXZrNDhrSEF0cWc3MlZYNFBnWloyTzBHaUwyQlE5VWUyVHdGTDhKeFkr?=
 =?utf-8?B?T3dYQVNDT29LL1JMNlF6Mkh5SENBMmNnYTVYOEw3a1RMRkgrZ2o5T2p2NU5s?=
 =?utf-8?B?Wll3OFdmaW02Z0NGZm9CSDUwRUJVUEFjK1NWTUk5WjFieFZVREFoMnRpMjF6?=
 =?utf-8?B?ME45cWs4a3gxcnpPSzFxSTdlT2ZwV3Y2VGVWWWNSTGt0bFRnYStWbmQzN1RV?=
 =?utf-8?B?THlZVndxUnBGK2p4bEhVYVFUTzFSZ0RqeWM1SE83eWQ0bm5nVFo1WjJtdHAv?=
 =?utf-8?B?U0hhTXJVci8yd2xLZEtaT0RJaG5mQ3Z3YzhHUm0xRTY1SnFyRWNxS0xBamk4?=
 =?utf-8?B?K2ZsZjN5ei9Ud0g2YUxsMGxRZVRVS2g1RTl3QkFaS3dJcU13cTkrT201M041?=
 =?utf-8?B?T01LTnFpWmN0a2RucDdwUUo1U0NQV1crTUZQSmc2cElpYy9JTkhRQ1JydStP?=
 =?utf-8?B?dlIzcnlicS9XOUE1bEQ1bmM4ZEdkYjIyTlYwbXYxbXFhN1JjcVhOYVdwNjho?=
 =?utf-8?B?TmhkMVRQWWVVSG5ScFNGMjUrRXhkeEduKytGam9oTUYwOEpiY1lPVCtCSU5O?=
 =?utf-8?B?aXRmQkdXODNuMXE0OFVYMU9UTTRzM3pwZHRvSUU3L0ZZRGsrT29sZTBncXQ0?=
 =?utf-8?B?eU95M2MrTjEyVWFqTGUwak1rOUZRNHpQcnc3akhKaHFFU2VHNVlDWFliRjZK?=
 =?utf-8?B?dXBYSkc2Vjl4SUJyZUF3RVhxM05hdy9BUjVQWHQyVkREZnJoT0ZaemZtNS9w?=
 =?utf-8?B?S1N1OFpTRisyR05Cd2M4akZCQWV5ZHp3WVdkZk9UekdTZUhFN0l5WTdOdGVy?=
 =?utf-8?B?clgwUmtGWnNrU2w5NklKY2ppYmZJZUp5OWpEcVRMeXI5Q2s5MjRvWFM5WWpC?=
 =?utf-8?B?KysyL1Z5YmVQWXZObUsyOXBVbVUyeGFsaEhMSzdaZlNPNWd3cU9mRVo2Rml0?=
 =?utf-8?B?NFF1UGRYMmZCNHNWSHg4M2J5VFQ4dW12Mnd4SXFmRGErcWFHZkxCVzVkaUph?=
 =?utf-8?B?a1ZnNHNFQnhlQzdMeUI4YXVscXdMTmx3SUNTSGQvcHR0bmpqSXEwYlBFeGx1?=
 =?utf-8?B?Vm14dm5FbWQramtPRktySy9HbjVzeU1iSzVOdHc3U01ZQXJ0UEtMbFFMRzZL?=
 =?utf-8?B?QjN5V1hGNUF0a1FGN0F0YmpGZEdHK3JnZWVBUDF3QU94akxFMUtLZ2ZkSHFE?=
 =?utf-8?B?YmVjWHZheFYwQVlLNU9SOXlDcnZ2TW1TTExsS2R6K2lNcjJBT1FObnhKcWpl?=
 =?utf-8?B?d0d0alQ3anRBd0VubEd6YW9MMUlrNWJlVTE1M0JKeGJTdUFMUkcxdUd0a0Vk?=
 =?utf-8?B?K294ZDE5OG1VQ0x4eDJVOVVTRG5aeGpJeXUvV3NrYTFoWTkwUVdtd3pFblNv?=
 =?utf-8?B?NkZGQkVObXNzY1VEOFR6SVpya0dQRUV4Nk45MlhGcFExejAvbDUyRHJYenlw?=
 =?utf-8?B?WmZnUHgrR2wvU0d3MS9qS1N6bVplc2kyZ2xLT0tRSkdCQ2paT3ZZaWw2MFFs?=
 =?utf-8?B?OXNiOFlXeEJhVEhoQUVuYTJjQXR1STlYcWQ4OGNOT3lZNjN2cnN2bzdRUWdl?=
 =?utf-8?Q?NyTCvDknJ9fgQH1grIohnuWyurgCU1HgtHOzTpnJ4LMd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09F519B644F61A479241D4A2B734AE05@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56161986-e8af-4c94-3e76-08dc35d6dc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2024 07:53:31.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyIQh3F2rqlzU58DFirGiAZkMDoc1uDWEnZ5eKD1Dl2MC5facFmlgfx7eTSrbJDSbDkpigec9SHHxx2tMr7X9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

T24gMi8yNC8yNCAyMzo0MCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAyLzIzLzI0
IDExOjMxLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IE9uIEZyaSwgRmViIDIzLCAyMDI0IGF0IDA3
OjE2OjMwUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+PiBPbiAyLzIzLzI0
IDA3OjU5LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+Pj4gRnJvbTogS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPg0KPj4+Pg0KPj4+PiBDaGFuZ2VzIGZyb20gdjM6DQo+Pj4+DQo+Pj4+IMKg
wqAgQWRkZWQgcmV2aWV3ZWQgYW5kIHRlc3RlZCBieSB0YWdzDQo+Pj4+DQo+Pj4+IMKgwqAgTW9y
ZSBmb3JtYXR0aW5nIGNsZWFudXBzIGluIHBhdGNoIDIgKENocmlzdG9waCkNCj4+Pj4NCj4+Pj4g
wqDCoCBBIG1vcmUgZGVzY3JpcHRpdmUgbmFtZSBmb3IgdGhlIGJpbyBjaGFpbiB3YWl0IGhlbHBl
ciAoQ2hyaXN0b3BoKQ0KPj4+Pg0KPj4+PiDCoMKgIERvbid0IGZhbGxiYWNrIHRvIHRoZSB6ZXJv
IHBhZ2Ugb24gZmF0YWwgc2lnbmFsIGVycm9yIChOaWxheSkNCj4+Pj4NCj4+PiB3ZSBuZWVkIGEg
YmxrdGVzdHMgZm9yIHRoaXMsIGZvciB3aG9sZSBzZXJpZXMgOi0NCj4+IEhvdyB3b3VsZCB5b3Ug
a25vdyBrbm93IGlmIHRoZSBkZXZpY2UgY29tcGxldGVkIHRoZSBvcGVyYXRpb24gYmVmb3JlIHRo
ZQ0KPj4gZmF0YWwgc2lnbmFsIG9yIG5vdD8gVGhpcyBpcyBhIHF1aWNrIHRlc3Qgc2NyaXB0IG9m
ZiB0aGUgdG9wIG9mIG15IGhlYWQsDQo+PiBidXQgd2hldGhlciBvciBub3QgaXQgc2hvd3MgYSBk
aWZmZXJlbmNlIHdpdGggdGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5kcw0KPj4gb24geW91ciBkZXZp
Y2UuDQo+Pg0KPj4gwqDCoCAjIHRpbWUgc2ggLWMgImJsa2Rpc2NhcmQgLXogL2Rldi9udm1lMG4x
ICYgc2xlZXAgMSAmJiBraWxsICUxICYmIA0KPj4gd2FpdCINCj4NCj4gc29tZXRoaW5nIGxpa2Ug
dGhhdCA6LQ0KPg0KPiAjIHJlY29yZCB0aGUgc3RhcnQgdGltZQ0KPiBzdGFydF90aW1lPWdldF90
aW1lX3NlYw0KPg0KPiAjIFVzZSBnaW5vcm1vdXMgdmFsdWUgZm9yIHRoZSBkZXZpY2Ugc2l6ZSB3
aXRob3V0IG1lbWJhY2tlZCBmb3IgbnVsbF9ibGsNCj4gIyBzdWNoIHRoYXQgaXQgd2lsbCBub3Qg
ZmluaXNoIGJlZm9yZSAyMCBtaW4NCj4gbW9kcHJvYmUgLXIgbnVsbF9ibGsNCj4gbW9kcHJvYmUg
bnVsbF9ibGsgZ2I9MjAyNDAwMDAwMCAjIHRoaXMgc2hvdWxkIG5vdCBmaW5pc2ggd2l0aGluIDIw
IG1pbg0KPg0KDQppdCBnb3QgZGVsZXRlZCBmcm9tIHByZXZpb3VzIGVtYWlsIHNvbWVob3cgOi0N
Cg0KIMKgYmxrZGlzY2FyZCAteiAvZGV2L251bGxiMCAmDQoNCj4gIyBraWxsIHRoZSBwcm9jZXNz
DQo+IGtpbGwgLTkgYHBzIGF1eCB8IGdyZXAgYmxrZGlzY2FyZCB8IGdyZXAgLXYgZ3JlcCB8IHRy
IC1zICcgJyAnICcgfCBjdXQgDQo+IC1mIDIgLWQgJyAnYA0KPg0KPiAjIHJlY29yZCB0b3RhbCB0
aW1lDQo+IHRvdGFsX3RpbWU9Z2V0X3RpbWVfc2VjIC0gc3RhcnRfdGltZQ0KPg0KPiAjIG1ha2Ug
c3VyZSBwcm9jZXNzIGRvZXNuJ3QgZXhpc3RzDQo+IHBzIGF1eCB8IGdyZXAgLXYgZ3JlcCB8IGdy
ZXAgYmxrZGlzY2FyZA0KPiBpZiBbICQ/IC1lcSAwXTsgdGhlbg0KPiDCoMKgwqAgZWNobyAiVGVz
dCBmYWlsIg0KPiBmaQ0KPg0KPiAjIG1ha2Ugc3VyZSB0b3RhbF90aW1lIDwgNjAgc2VjDQo+IGlm
IFsgJHRvdGFsX3RpbWUgLWd0IDYwIF07IHRoZW4NCj4gwqDCoMKgIGVjaG8gIkZhaWwiDQo+IGZp
DQo+DQo+IGVjaG8gInN1Y2Nlc3MiDQo+DQo+IFdEWVQgPw0KPg0KPiAtY2sNCj4NCj4NCg0K
