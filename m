Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2215AF6
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238657; cv=fail; b=YKaPMPgPrRlj63sz+I7+qn34/Wp9pKW00XTuEQi7oz+2BdHT7O3c3YWDpUY0p57zhNTBCaFpyLLbBADko7SuDXFKLRNQXR/JfSdme/nm5j4ya0hnnCT3y/srBKG1Cfmf6cH03u+3oboyYGjIxIenhTi8beAGrGb/FLR5LnF7uVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238657; c=relaxed/simple;
	bh=aTvKXvOGWOJ03ehml+KPJGSoQfLgUH7CN89eOwoSOkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lkc8CYkMt2+KvwSFGgGwCiXtP64OvDTjm3dOBbGPoJoPZqWMPcXHg/aIAQNSH8WQC1pKOjpe6ayzGKfglNNLBNtcAQidr7igeqTsEMDnvF/YAY2nv8+NRewLGNmNo0hbkHk9FUAteTYPJImIiHBVF0u0KWRJn4HJ7mNJvwKw1dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQGR5Zcw; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQGR5Zcw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtzVnOneHXuYbbNtrp1lYowe397nBbuLstDRnEwGwM6qxKLowIKOAYU6qZBrlzCSYXRv9UN5E1hTIzmnVOD7aHMEjcvLJf4pIJVvUQzLGjX/6j1NcjahaDXBGx09RwMRq/gDVr+YuBu3KPLhtLbfxCQMceq3KNBRLdi3tiU/JGMkyvrWTKvePmP4QkSZicFurQ7PM8QbL40XIsG1yAUzncEWbyleAGwf2SbyJgUWorEs0xcct4kYLb3yw3T0kZaLDdSh2qVe9+QtTiXydzipCo9RLfxedvxw31S+pX1H+18lWb7P5uTjog1T55crjmiclgkll4WPtHwC2PWsLB/Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTvKXvOGWOJ03ehml+KPJGSoQfLgUH7CN89eOwoSOkw=;
 b=GLXtymdTMCJ/xvsTpA+Il265/Mh00ofWb6GxH0XoArG/wC+DkBqhfJCRn25XpMiIWPWXlPONmy/dYc52yemYABKMtVNN0Hi9HEG01JfShU18NSH/RFnS4uY7CrvpzmGPhqtW/UvHQfp2EcTUvaqv0FYQtzWTZjhaOAijpIc3OCs0ePrDQWmuCBB9oes18GPCH4I7paYYlMTicOb9T3pKCetj4gU/oVGHUUvq4VNs9qZPwc1N/ZR2t/ZUP3oHd8l8Zrzo5TSJUgpUnJjaJDKwmvRPw/wUlnAM61lxDumNRW9XVbiZccUhLcxnQc9n4rOT8qua6AtHZ86/HZYdcs5XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTvKXvOGWOJ03ehml+KPJGSoQfLgUH7CN89eOwoSOkw=;
 b=XQGR5ZcwL6VhBVddtZpaT5MDIi3IbvuC4ME8XSRXgJxu1RVDhsdKxaIEUH46a250+lcX0MYbAFl48kq/288J7PAXVxuJr4nEor5iuKCg+WcUjJkzcwnxEdN0Pgfw4Ug3HNPRPvc6YzGuK9PV/r24bdavKgCDQowEQdokXrrr0MnoPxjhdt9ynB/O+zdc3BR4z4Z0nh8o++7bSv0HYkgDWLtNc1jKRVAY+ja145qcseMk6JjP1vbewAc1inhHIINbH1DPJHi2HKSH1HTPjCwxh/4ScmNnF58yq9w53mGZVbJTf4uqjQ98kZOUCyO7YVp3NmhI9D7lQwkfQig91ZuKjg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:37:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:37:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "yangerkun@huawei.com" <yangerkun@huawei.com>, "tj@kernel.org"
	<tj@kernel.org>, "saranyamohan@google.com" <saranyamohan@google.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Topic: [PATCH blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Index: AQHaj6MthPQacGq6v0qj0Tv/Bbybq7FqNcSAgAAERgCAAAWDAA==
Date: Tue, 16 Apr 2024 03:37:32 +0000
Message-ID: <cd0422b8-f848-43d3-bcad-6ed6c087f703@nvidia.com>
References: <20240416020042.509291-1-yukuai1@huaweicloud.com>
 <20240416020042.509291-2-yukuai1@huaweicloud.com>
 <c14a95c9-64a6-4929-9213-3f81bf118399@nvidia.com>
 <77c430a9-a533-8214-ea10-3ecde15904b3@huaweicloud.com>
In-Reply-To: <77c430a9-a533-8214-ea10-3ecde15904b3@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB7806:EE_
x-ms-office365-filtering-correlation-id: ad3338e6-1f6a-44d3-f16a-08dc5dc68ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3QL/xnBSwIM7isyL7CjfaiNDoZGmMPfhf/D+jO4MNvNz/k1guYITuIpdJl/3ZvKFPeHFj6Fh9MwNX8LeBOGUmJbBHx5sVnGrP2nX9QyugSYMUzFKV7UWcntO92PbhTHJuUvNbOaVxiBEDd9s8wL3EToKzpsxzF2uMbZFq3ZIr1mGiDCctzJcDrz7msV2HPbqeoUod+UpjPaAXmNC2xtCM0F7sWhI0/1vObV3qPVDNnFZdAJgIsgiXXh+3yHRMzPhZbwbSqv4/PQXN5Wrehi6W72pO/x/NO0xvmHVJHFWEHduWQKNICipdgleu1FfD2nDcTg41TfHFzh9oSuIgy4Bmklh48p4l8WzxGcVgQXoLFoetB/mkqworqCB4pGoFf09rArDML80XUdB7qcGflEDrlcbBBqvVf2XcBnhc2aJNGbEOruef3JO/kFWcmkNEEuEJ0BPRNnwRJg08/iJTwXUz+AITVdbJbRLlSQIMVzhv+LVSefVhK7kG7UVelh25mpnhO58DctSAQ3kQERgIdflMYeB3AfoHjdC7AGni2SsnTAxhN2wkEBjJDRV+DBcPN/cz/H3Qvl503gKPYaJ3z3r4OVbgbD6qC+esJe5ODL9MmAArpms6EmbYWDlDw/+jW4KBCLlIR7gYJ1D0/jPVq2T+H1cAAAXOK0jZfGfVRWrdmNU5aSiIAmJd85gOnDekZQkrl5AbLfPHiesQdluEVycy9hpfGP6/6Dsh1471Y2zgPs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkhYdTFnd1F0TlpidWgxc2F1c3F5NWFpSEF3QXJ2RUZZSnoyUzdONG1hVjI4?=
 =?utf-8?B?bEMzVzYwbk11QkM0dHpkdmtLc1ozZmZhc1ZLbUFlNGZRY2RuWU1RektYdm9m?=
 =?utf-8?B?OFVWUnNVbXJBL0RzWkgzbzF2VjBoWW0wd3VHWUdMVVNzdmpzdGV4a1FvNjFZ?=
 =?utf-8?B?ekZxQ1BxY3BCMG1yU2lsVUF4OHNlR3JUSHdMQ0JlRkU1Tkwyd00zU091ejhI?=
 =?utf-8?B?OWRmNTdPa3lTclp5WDlSbi9tdVJIeE9oY3hMTG1aQW5VRXNiU0duRDZvWlBM?=
 =?utf-8?B?S2hKNldlTUUwdkNsVk0yZ0hqdVgrUTZadXZXTzZ6YlBEd3djUG82T1Q1ODZu?=
 =?utf-8?B?YXhZWFg0bE0ybEQxMVQveDhaa1VIb1dKbnhJaE11elkyRVA5ZTh3MGxZejZE?=
 =?utf-8?B?ejA2U1VMY3BETS8rV2p3Q3czRmo4M0p3N3h5QUhLK1FCV3h3d3FsME5xbVN3?=
 =?utf-8?B?L2RqQjEya2dsS2dZZFdGekcySWpmdG5pWTdQM2xMREJuUWJWaXRiN3hMMHpY?=
 =?utf-8?B?YTNXVzcyakw2K2RsZTFSd01meXRWMTRZMFhqN0hDalNoOEQ0eWJzZDdzL1k1?=
 =?utf-8?B?bnpTQ3BHUXVrM2M1bjVsSHZ0TXQya3NKUnRVSWp1VC9ibFY2NWx5TC9YTVNN?=
 =?utf-8?B?TjcxSVMyaC9weHRFYWpsc2NuNnBONXhnYmw0WGhRbkdiK0dpR0NBcUxDbmJ0?=
 =?utf-8?B?d3NLb2pxQWJjbVdyWVJlRHVWTG1DLzA2Y2RmRHcrQUJTVWx3ZW5WU2hTQmY5?=
 =?utf-8?B?VHFVakxScU5vekUxZi9UVkVaODBvMldxemNidjJBdllTRU9xcUk2Ymh4dVNj?=
 =?utf-8?B?VVlKbDVuV3huYnhwTlFoTnhuSmJKUjcvV1RVQkZGdjJhSk9uNGoyNnV3UnlE?=
 =?utf-8?B?blRTc2phRTg5QVJWMkJ5K1l1NGRrbUZJZFhRYUx1bHVFTi9GTnJCUVdLRDhR?=
 =?utf-8?B?a2l1WmlkSGQzRlFlcVZrUml2bU9XczU3dXFiYll4SkZia0RERWdmazArQjdq?=
 =?utf-8?B?N29zNlRneWtJSVpJbm15YXVyNk8yZUVyVUdTSUVyMkM1NFk2SXFvd1JwRGZm?=
 =?utf-8?B?S2lEdzFPU2RMK0tTWm9ia0QySDdsdHdoU0hpbmxWaEx2VmFVdllYS2lxZDNs?=
 =?utf-8?B?bEgxNHNqVWkyWXMzTmFqWG5VdVRBS3c0NEoxZmpLekw5dEoyZHUydjMxVkxN?=
 =?utf-8?B?c3RSa3dkUE94TytHOFJ3MzZVQzdQV2FMeitSVS82clQxYTdwUEN3cUhIS2R5?=
 =?utf-8?B?SDE4RXFxV0RXY1lFQmtGaTZmUEY2VFZtOVorWGZ0L0xacHNuZWxXdlJMaER4?=
 =?utf-8?B?Y1pYM2JiK3dtdWZSSVowL0RzUFN0MnpBbDZqZ2FyRVJpc1BBdzA4LzdBVVlz?=
 =?utf-8?B?S09yZVI1WG51YTZJdG91THhrWjRuekpHSjlxcHdLWU9PRU01NDNnYmlvR3l2?=
 =?utf-8?B?cHNGS0huUU9rT1NYMUVjT2VJT2o3QmxCcjdwR2hhcEdrdE9nT09qdnZTa3lr?=
 =?utf-8?B?SGh6ZXVnUlRwTUlINEFCaTBPN1h6Vyt5SlZRR29RY2JxVzFLb01SUUF6VE1S?=
 =?utf-8?B?TXlJZHFmTkJuZFVzQ2NmMGF6OTN3VHdtQmRQY2FYS2lRamNWMnZVZDc4TGRD?=
 =?utf-8?B?bEJLNjZnY1FrREs2b0NTM1pReVREclVSaFQ5MFV4MitORjgxNVplRzBFb2tB?=
 =?utf-8?B?Y24vUytucWp3YWx5U0hWWUY3b0dIaWsrMHRYYWVZNmFmdFhPZmpYYU5XcjRu?=
 =?utf-8?B?T2JtNk1QbzJDWXJkTjAwU3RPZ1dIbnJFUDMzZEUxenNOY3RCYW0vRmh0RXQr?=
 =?utf-8?B?MkR6TUx3dzhlQkt0Qk9uUUpZeWI5WUFzM0l5enFUTDd1OVlBcWtFS01oOFJN?=
 =?utf-8?B?VkJPQ2xDZ1U4RnJDMG94MTkrWmFUMkQyWTV6UXNmYjhrT05TUVEra0t2RHFG?=
 =?utf-8?B?c2ZrQVZWV1pJU2gyai9RMVhkU0VhUWpFREw1NnZzOXFXM1MzZ0dWRVdQL05s?=
 =?utf-8?B?MTFPd2ZKZStPMnI3WWFSV0g0U2ZRa1NVSVh0Z0hEUC92TVVGYm9XYmNzVUt1?=
 =?utf-8?B?YWdiUHBZSEw4ZU5jeEdOd0d0LzBaNWYvSVhmbWU0K1VxT1BJdlZaNjJaN0xD?=
 =?utf-8?B?VDNGUnhGR0xIM2VFeGtFTTMxTVlqYnBFR0VpZ3pTV1YxMHMzUytZdGczb3Av?=
 =?utf-8?Q?gdhXy1w9+6Kjd4ForFhA7PkVPtBWvaVNEB+abHsFhm8W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB9F51464792434F9DCF3D5CDBE3CA0A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3338e6-1f6a-44d3-f16a-08dc5dc68ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:37:32.8818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5M4pjIq0Tc2PnJnAB8dDO/sbiGA3NLtWDj4QGCeczRZPhDdL8zeJtDg7u1jgT9NfepadoE6d4aJn+FLhS028ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

T24gNC8xNS8yNCAyMDoxNywgWXUgS3VhaSB3cm90ZToNCj4gSGksDQo+DQo+IOWcqCAyMDI0LzA0
LzE2IDExOjAyLCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4gT24gNC8xNS8yNCAxOTow
MCwgWXUgS3VhaSB3cm90ZToNCj4+PiBGcm9tOiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+
DQo+Pj4NCj4+PiBUZXN0IGJhc2ljIGZ1bmN0aW9uYWxpdHkuDQo+Pj4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqDCoCB0ZXN0
cy90aHJvdGwvMDAxwqDCoMKgwqAgfCA4NCANCj4+PiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+IMKgwqAgdGVzdHMvdGhyb3RsLzAwMS5vdXQgfMKgIDYg
KysrKw0KPj4+IMKgwqAgdGVzdHMvdGhyb3RsL3JjwqDCoMKgwqDCoCB8IDE1ICsrKysrKysrDQo+
Pj4gwqDCoCAzIGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspDQo+Pj4gwqDCoCBjcmVh
dGUgbW9kZSAxMDA3NTUgdGVzdHMvdGhyb3RsLzAwMQ0KPj4+IMKgwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRlc3RzL3Rocm90bC8wMDEub3V0DQo+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvdGhyb3RsL3JjDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGhyb3RsLzAwMSBiL3Rl
c3RzL3Rocm90bC8wMDENCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPj4+IGluZGV4IDAwMDAw
MDAuLjc5ZWNmMDcNCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvdGVzdHMvdGhyb3RsLzAw
MQ0KPj4+IEBAIC0wLDAgKzEsODQgQEANCj4+PiArIyEvYmluL2Jhc2gNCj4+PiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTMuMCsNCj4+PiArIyBDb3B5cmlnaHQgKEMpIDIwMjQgWXUg
S3VhaQ0KPj4+ICsjDQo+Pj4gKyMgVGVzdCBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIGJsay10aHJv
dHRsZQ0KPj4+ICsNCj4+PiArLiB0ZXN0cy90aHJvdGwvcmMNCj4+PiArDQo+Pj4gK0RFU0NSSVBU
SU9OPSJiYXNpYyBmdW5jdGlvbmFsaXR5Ig0KPj4+ICtRVUlDSz0xDQo+Pj4gKw0KPj4+ICtDRz0v
c3lzL2ZzL2Nncm91cA0KPj4+ICtURVNUX0RJUj0kQ0cvYmxrdGVzdHNfdGhyb3RsDQo+Pj4gK2Rl
dm5hbWU9bnVsbGIwDQo+Pj4gK2Rldj0iIg0KPj4+ICsNCj4+PiArc2V0X3VwX3Rlc3QoKSB7DQo+
Pj4gK8KgwqDCoCBpZiAhIF9pbml0X251bGxfYmxrIG5yX2RldmljZXM9MTsgdGhlbg0KPj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMTsNCj4+PiArwqDCoMKgIGZpDQo+Pj4gKw0KPj4+ICvCoMKg
wqAgZGV2PSQoY2F0IC9zeXMvYmxvY2svJGRldm5hbWUvZGV2KQ0KPj4+ICvCoMKgwqAgZWNobyAr
aW8gPiAkQ0cvY2dyb3VwLnN1YnRyZWVfY29udHJvbA0KPj4+ICvCoMKgwqAgbWtkaXIgJFRFU1Rf
RElSDQo+Pj4gKw0KPj4NCj4+IG1vdmUgYWJvdmUgdG8gMyBsaW5lcyB0byByYyB3aXRoIGhlbHBl
ciBpbnN0ZWFkIG9mIHJlcGVhdGluZyB0aGUNCj4+IGNvZGUgZm9yIGV2ZXJ5IHRlc3QgPw0KPg0K
PiBZZXMsIHRoYXQgc291bmRzIGdvb2QsIGp1c3QgdGVzdCAwMDQgaXMgZGlmZmVyZW50Lg0KDQpp
bmRlZWQsIGJ1dCBmb3IgZnV0dXJlIHRlc3RzIHdlIGFyZSBnb2luZyBuZWVkIHRoYXQgYW55d2F5
cyAuLg0KDQo+Pg0KPj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pj4gK2Ns
ZWFuX3VwX3Rlc3QoKSB7DQo+Pj4gK8KgwqDCoCBybWRpciAkVEVTVF9ESVINCj4+PiArwqDCoMKg
IGVjaG8gLWlvID4gJENHL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wNCj4+PiArwqDCoMKgIF9leGl0
X251bGxfYmxrDQo+Pg0KPj4gc2FtZSBoZXJlID8NCj4+DQo+Pj4gK30NCj4+PiArDQo+Pj4gK2Nv
bmZpZ190aHJvdGwoKSB7DQo+Pj4gK8KgwqDCoCBlY2hvICIkZGV2ICQqIiA+ICRURVNUX0RJUi9p
by5tYXgNCj4+PiArfQ0KPj4+ICsNCj4+PiArcmVtb3ZlX2NvbmZpZygpIHsNCj4+PiArwqDCoMKg
IGVjaG8gIiRkZXYgcmJwcz1tYXggd2Jwcz1tYXggcmlvcHM9bWF4IHdpb3BzPW1heCIgPiANCj4+
PiAkVEVTVF9ESVIvaW8ubWF4DQo+Pj4gK30NCj4+PiArDQo+Pg0KPj4gc2FtZSBoZXJlIGZvciBh
Ym92ZSB0d28gaGVscGVyID8NCj4NCj4gWWVzLCBvZiBjb3Vyc2UuDQo+Pg0KPj4+ICt0ZXN0X2lv
KCkgew0KPj4+ICvCoMKgwqAgY29uZmlnX3Rocm90bCAiJDEiDQo+Pj4gKw0KPj4+ICvCoMKgwqAg
ew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzbGVlcCAwLjENCj4+PiArwqDCoMKgwqDCoMKgwqAgc3Rh
cnRfdGltZT0kKGRhdGUgKyVzLiVOKQ0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgWyAi
JDIiID09ICJyZWFkIiBdOyB0aGVuDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGQgaWY9
L2Rldi8kZGV2bmFtZSBvZj0vZGV2L251bGwgYnM9NGsgY291bnQ9MjU2IA0KPj4+IGlmbGFnPWRp
cmVjdCBzdGF0dXM9bm9uZQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBlbGlmIFsgIiQyIiA9PSAid3Jp
dGUiIF07IHRoZW4NCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZCBvZj0vZGV2LyRkZXZu
YW1lIGlmPS9kZXYvemVybyBicz00ayBjb3VudD0yNTYgDQo+Pj4gb2ZsYWc9ZGlyZWN0IHN0YXR1
cz1ub25lDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZpDQo+Pg0KPj4gSXMgdGhlcmUgYSBhbnkgc3Bl
Y2lmaWMgcmVhc29uIHRvIHVzZSBkZCBhbmQgbm90IGZpbyA/DQo+DQo+IE15IHRob3VnaHRzIGlz
IHRoYXQgSSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGUgbnVtYmVyIGFuZCB0aGUgc2l6ZQ0KPiBvZiBJ
TyB0aGF0IEkgZGlzcGF0Y2hlZCwgc28gdGhhdCBJIGNhbiBwcmVkaWN0IHRoZSB0aHJvdHRsZSB0
aW1lLA0KPiBhbmQgd2UgZG9uJ3QgbmVlZCB0byBrZWVwIGlzc3VpbmcgbmV3IElPIGJhc2VkIG9u
IHRpbWUgaGVyZS4NCg0KSSBiZWxpZXZlIHdlIGNhbiBkbyB0aGF0IHdpdGggZmlvIHRvbywgbm8g
PyB0aGUgcmVhc29uIEknbSBhc2tpbmcNCndpdGggZmlvIHdlIGNhbiBzcGVjaWZ5IGlvX2VuZ2lu
ZSBhbmQgSSBiZWxpZXZlIHdlIHNodW9sZA0KYmUgdXNpbmcgaW9fdXJpbmcgaW4gZ2VuZXJhbCA/
IGJ1dCB0aGVuIGZvciBzdWNoIHNtYWxsIEkvT3MgaXQNCm1heSBub3QgbWF0dGVyIHNvIHdlIGNh
biBrZWVwIGl0IGFzIGlzIC4uLiBJJ2xsIGxlYXZlIGl0IHRvIHlvdSAuLg0KDQotY2sNCg0KDQo=
