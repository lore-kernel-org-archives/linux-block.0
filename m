Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03112F36
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484738; cv=fail; b=GG115TVjfog8Kr96wgojpOJ1057ZTLnGVnBSdwTpLmpeonmQzeowJPKqdKrJXiN6CMz+WKeZIc6obWe/Gt6loO8AiGvbrsauX6c/O12mxTABDwP++bCwb6rwtfxC31xxODoUZJexYvzjZUlBiHAGknyMpc8/R8HxjxqSzOrIpxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484738; c=relaxed/simple;
	bh=zdGcrxU0DLFXv+OfEoJHn7oFFeGm9efz2wZprt4W0+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9iQyiDMK4ym0a8DtCYrIk9ucBWwyMl9vOl3m0Z2kisWF71n047deDzePSign/N+We+o6oSzl/jVY3mo6fMBHVqA7iONyTApqtDBBqe6CVJUkh59jcQ6cVwZESsCqzIZ2wlgCUkjpJQxnjeKsrV79NXd+RTLcQ36SJ6qcTBUr3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pOeOisSH; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pOeOisSH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmkBuTrl54x6CkC0eYy9Cl1BlqW1nUFZuT0/Fp8vKUyVpahU4qeL9XYTYz1g8KgthC5gDrzuTwYA12QF1LVVI4ekQ51SDh8SWBH6O2I58e0t0IN/zyFhmwC2wfs8+thTAVwytuAg3ah/Yot7IDhmoDt4McTq1Cuqhm7YGPiRoaskRKqRG65oY5z1XmlXT2F0S7u76B3vToAedWarnX8AvhfWveWI8cf4vVfMtZdr6rqTv3n866xpNjNQXBBB/Isz0yETIP7B08r8ecIZJf8KZNJnxvaJ6x00sSshVLVoUr0mo2i9TNboHEkXc0u/P1Pp75nB4QBeMbVci+FIKLRfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdGcrxU0DLFXv+OfEoJHn7oFFeGm9efz2wZprt4W0+A=;
 b=VUq2z3L2fafooTQmYxdJeLCHq57WE9yc62NdsaSC2cvmGIFBeq2ztQt8deHJ1OsRd3hixqzBCqTQ1ACDkxiEz2K4TqCd0wWh+Q83Z24MKf1foHiYtuhv6I+aCF0zZtGW/uVTO/+QCzVmO1HZlD5szSF7lBUhrsCwNhSsqhneSAh2L/x7cOurk038njEkOAN9XFSumTsoLUwiBdU1c5JvZ/FSdmkFLh2Uazr0T4RVd0Coi6P5W6wzZ84AFG8IWXW9faErLizEUeN68PhWOut75fKVnyq6NkXFf/lrAmI4Fg9SQ6b82ezR0Nfd+ZSqRtLdWwDk6LC3JZlS1O5EKRjxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdGcrxU0DLFXv+OfEoJHn7oFFeGm9efz2wZprt4W0+A=;
 b=pOeOisSHCwk42suOIzEx8FYNWLJwffwuR8YYCtEsv6BDn0gbWOPFndBQyGuyWklgMFxQARBMsh6tjtwOevVjUJQy2FqSBJFFiZWHvioC2Om7qDzWNH1wCekoCDIBYPvkRvAx0xhH/1FmIDQ2IQebv2R7ODenO7GxMhuNBnGHi9tviGTIHI5Wq92xBx7RdhOZVpaWRYN8yziulyciq9P1fH5M+FsnylkUShKiWmfYsCSWnEPZTJyH/fkE2G+gzDiL+ei8PQbcjOebk/MBOSiNO/wYJVHLb7CDx0gERmPibupUHeJ3TkxqEXkMht3bKlAC8hgsk8blCdo8BSylpXm89w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 03:05:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 03:05:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.org" <axboe@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Thread-Topic: [PATCH] blk-lib: let user kill a zereout process
Thread-Index: AQHaZD06sUSdY4lj2Ee2Ig44LaIhIrEUHSwA
Date: Wed, 21 Feb 2024 03:05:30 +0000
Message-ID: <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
References: <20240220204127.1937085-1-kbusch@meta.com>
In-Reply-To: <20240220204127.1937085-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8881:EE_
x-ms-office365-filtering-correlation-id: a39d851c-09c4-435d-a89f-08dc3289f684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G7itdN3N2k4mrSExfzZIE3GEMoKdHH9Dh0z8nKi0y6DBpi/r60PLW+foMHmOcb0LP2/DiIIVjt2yB/d5838zOqWEzzXSXnTWzKC4hruliT14OuZzsT7/YBxFDQHTlWE0Koz3eroFW08pF5j2LX/Cw0kB3cRQTrG27fL2evF2FU0jeoJj9HZMbuv+kgnjxT1h0e0tcPRIBPYsKOJeYRRukGddd71k1XENFopFQy723K6JN+2ipbxKHEzCxS09Bknrj/1An41oXIq6p4jLoGJf3jv0eRpXSfqoWLKYc1l+/zIKfrNl74+iETROsLUFKfFuUiCndqe4JX4PTakXLBL6MX0DW3sIS5SPtegQhhosjoGR9WWznHDvGvkANwuWvkapauyPl2QFmSiXT5zwbFOt9uTYQlgTtuM3af+pCjeJhz082b/GX9KFC0+GyU14q7d6rtAXGePg0BLeGc5XoQ8q66NvkJt+UrJbMbx778sPPeoGi25ze1nH9bRIyKgMj42AYogND34jhXbhZDgYVadIjTnP/mKltTzfddmuWz6CCxB8mJIrDcV2CMeLOk+rt1zQ3zVJFBiS2mBtH6bX+LSDz0s7uYgvd+iEJQ/Hp2QRxX67Jf8wmW60m7Pfp+xOB3DO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YktRaHJmaW9ybm1aMGlMcUZLR05URURRQ0JNSTZLQS85Mld0ZG1OcDMzdS9U?=
 =?utf-8?B?NG1xdVFsL0hieHp1SVhrVUFUbUROZDNaZFp4cnVwSGRpc01kYm5EUXg1NzNa?=
 =?utf-8?B?U0h2ZktFRkpyd2VHYUNpLzBhV1VabHhNd3pDSEtQeklrRENPSTR3TXltcEcx?=
 =?utf-8?B?V0Vpb2lrY0RBNVlKcVFjakRud2dNZ21ZUkRjakhscEg2cng2akZHQ3lJT0Zh?=
 =?utf-8?B?VHl1Y2U0WnEvR2cvZUgvdkQ5Rkduc3RlZjB3bm9BdWV3NmJZZno5cGNoaGZu?=
 =?utf-8?B?alRhRHVlSjJmdEdkOEF6MWxhblczTEk3K0JXMHk4Y0hQUzNwQkhLMERtcUhL?=
 =?utf-8?B?aUZKaGUzbHF6TU0wdHZmQ3hiQWE0Yjl3QlZ3dTVTR01iSnNGT3hscmpNUEE5?=
 =?utf-8?B?SGE3M2pDeGxzWDBZWFZRNXNyM2cyLzhqSysxbDBDRjlTRWh5dmJxWCtJamhC?=
 =?utf-8?B?Qys5RGFaNVJpeGlENHNQeDA2dnlrZlEwUlZ3UENmTFJnWjdWb0pmK1FMdkE3?=
 =?utf-8?B?V3Rjd3hRWEwxbmkrQjlUUWE0VzM3aVp0NjJjT2pQR1ZFNmlCYU9rVlJNWk5h?=
 =?utf-8?B?aUQ1QWxsR01WU2k0d2g1RExybWhRRjVyUTFheXE1WUtEV3VrSHlzRkhvYklh?=
 =?utf-8?B?aVN0NVRGRUhUc3BqcCtHUlFxbDU4cGxPc29OMzRVODlsUEZObVNjN0ljcmdO?=
 =?utf-8?B?RytvMXFTby9jN0kwSnJmWVlyMDZlcUFXd21EeWFXdVc1TlJwQ3VkTE45cDhy?=
 =?utf-8?B?UDRhMmMvRVZlbGY1U0ozVlVhMnBMbEV0Q1JkL0NjOUV3VHFpQVNURG9mRi83?=
 =?utf-8?B?N1ZXTCt0eGNmbG1zNFFXMnBYZG1PRU5xaFZyNzlJTFduMlFJWS9jV1ZEM096?=
 =?utf-8?B?dzQ3N1l6Ri9uVjBOVTJYNzFOTlJZNW4xbFdtdGQ4T1F0NllONlY3eCtXdng0?=
 =?utf-8?B?SnJwZWVIQm1US1JRTFd6ZVFVUU5sN0RkenUwT0J4cVIxMkpDWkp6UWlWS2x4?=
 =?utf-8?B?b2VHeDV3WlZOOUJ5ZEJvUnhRYnlZUWhuaFNFM0ZEQlF4cUM2dExyNkovSUFC?=
 =?utf-8?B?amRWUWdVdGZJMnpEYVZ5Q2toMGg1Mm1PdEFkaEpuYmVGaUNVQUwvNzVYOHdJ?=
 =?utf-8?B?aERtS2hWbTFENVFqQ3B2ajh3MUdYTWRhQzg1TkNiSFZhQTdQL3BEVXY4T3Y4?=
 =?utf-8?B?TENGZkFqSmNycXRWSyt1a2Q1bGZNNjZNNXdHbThrUFBUZ3NqcmpyWDNJWG9I?=
 =?utf-8?B?UUU5N2RJZkdRdEFkbm1zWkhMQllTbnpqRDBnY1psSGdXZTd3TWgvS2JORXc1?=
 =?utf-8?B?SXFybDJSMHRQZlhMUG4vdmpXaDlpZDlHRy9aN3Y0S0JMMXZ1aDVIQzliOWU0?=
 =?utf-8?B?aVJMTkZMS3JQeXFvL2dZWGlHd0ZCaHFSb3UydnltVmFXYTRxekY1UUVkT0l1?=
 =?utf-8?B?YytXb2dubUlQS2JneFhySE5HTlFveEVtNHJGZ0tZb3BlWis0bWFHYkJzVHoy?=
 =?utf-8?B?VmU4TDVhWk1aWjFTc3NBQmVKT1RYampMTnp1cHJmRm1nbEpxTGZOdkRaRzZp?=
 =?utf-8?B?aU83clRMTzc1b0R6UUdYaXdyVStHbldqMGdBVmNsQ1NpQklyWUw5Q1JXY1ha?=
 =?utf-8?B?UUNQZGRmVG1rRmVadnpoTGZMVi80SWFnTDNzMWhlVDMrSkNrcjBETFdKYkVF?=
 =?utf-8?B?WEx6WjdkUGtHWTkyTkZhTHE1Y3FhZXd1VmJSNjJKZmxJU20zempvSHZVYUJm?=
 =?utf-8?B?NWswalc1Q3VITXp5WndweWpCcVgrSHRCbVl6enJOellTSjlUQVhpVjVZOXZG?=
 =?utf-8?B?cVRTeWd3eU9QZFowc0ZDTmZyWEMzaWJvWTFCaUI2ZHlFMm41R24yYlovYk44?=
 =?utf-8?B?QTN5MUthaGZaaXowSHBsOVNaVDBiYk9QdkNzcC9zN2FGYjBsQTdQMENRZTVP?=
 =?utf-8?B?MjhkNW1UNkdrRjBPZXczMnhLOVFTN1IvRWNMRXptc0JhVHJsN1JIWDJNZzdp?=
 =?utf-8?B?T0RNVUpXSEN6Zyt3ZkZiNndGTjJ1cElpWUFabytqZXZTRFFaY092WTFrL1lw?=
 =?utf-8?B?OFRVN2JWcncreE8yYllOTWpVWWtZek5sRzNFaFdMMmlKTWg2ZmkyYmk2eGZm?=
 =?utf-8?B?SFR3U1N0c21uRzc4ZW13TldJc3I3ZjFicHUxK1RLalVPRW4xK2xPdVBKL01h?=
 =?utf-8?Q?KgnuIG9kZCibcK6MRQcfTd2At8wNK+BdcFhtcY3KqffE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E151CB3A15A91144BE89628A312A4947@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a39d851c-09c4-435d-a89f-08dc3289f684
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 03:05:30.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCkwCnmLzJInAcWHnlvB75JwkfTevfhKjUMeLQTHYwEhRoBkOFB2XYNs16NrR8XwaL18eIkCZmz0ZaUh9slfIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

T24gMi8yMC8yNCAxMjo0MSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gSWYgYSB1c2VyIHJ1bnMgc29tZXRoaW5nIGxpa2Ug
YGJsa2Rpc2NhcmQgLXogL2Rldi9zZGFgLCBhbmQgdGhlIGRldmljZQ0KPiBkb2VzIG5vdCBoYXZl
IGFuIGVmZmljaWVudCB3cml0ZSB6ZXJvIG9mZmxvYWQsIHRoZSBrZXJuZWwgd2lsbCBkaXNwYXRj
aA0KPiBsb25nIGNoYWlucyBvZiBiaW8ncyB1c2luZyB0aGUgWkVST19QQUdFIGZvciB0aGUgZW50
aXJlIGNhcGFjaXR5IG9mIHRoZQ0KPiBkZXZpY2UuIElmIHRoZSBjYXBhY2l0eSBpcyB2ZXJ5IGxh
cmdlLCB0aGlzIHByb2Nlc3MgY291bGQgdGFrZSBhIGxvbmcNCj4gdGltZSBpbiBhbiB1bmludGVy
cnVwdGFibGUgc3RhdGUsIHdoaWNoIHRoZSB1c2VyIG1heSB3YW50IHRvIGFib3J0Lg0KPiBDaGVj
ayBiZXR3ZWVuIGJhdGNoZXMgZm9yIHRoZSB1c2VyJ3MgcmVxdWVzdCB0byBraWxsIHRoZSBwcm9j
ZXNzIHNvIHRoZXkNCj4gZG9uJ3QgbmVlZCB0byB3YWl0IHBvdGVudGlhbGx5IG1hbnkgaG91cnMu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4g
LS0tDQo+ICAgYmxvY2svYmxrLWxpYi5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1saWIuYyBiL2Jsb2NrL2Js
ay1saWIuYw0KPiBpbmRleCBlNTljMzA2OWU4MzUxLi5kNWMzMzRhYTk4ZTBkIDEwMDY0NA0KPiAt
LS0gYS9ibG9jay9ibGstbGliLmMNCj4gKysrIGIvYmxvY2svYmxrLWxpYi5jDQo+IEBAIC0xOTAs
NiArMTkwLDggQEAgc3RhdGljIGludCBfX2Jsa2Rldl9pc3N1ZV96ZXJvX3BhZ2VzKHN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkZXYsDQo+ICAgCQkJCWJyZWFrOw0KPiAgIAkJfQ0KPiAgIAkJY29uZF9y
ZXNjaGVkKCk7DQo+ICsJCWlmIChmYXRhbF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkNCj4gKwkJ
CWJyZWFrOw0KPiAgIAl9DQo+ICAgDQo+ICAgCSpiaW9wID0gYmlvOw0KDQpXZSBhcmUgZXhpdGlu
ZyBiZWZvcmUgY29tcGxldGlvbiBvZiB0aGUgd2hvbGUgSS9PIHJlcXVlc3QsIGRvZXMgaXQgbWFr
ZXMNCnNlbnNlIHRvIHJldHVybiAwID09IHN1Y2Nlc3MgaWYgSS9PIGlzIGludGVycnVwdGVkIGJ5
IHRoZSBzaWduYWwgPw0KdGhhdCBtZWFucyBJL08gbm90IGNvbXBsZXRlZCwgaGVuY2UgaXQgaXMg
YWN0dWFsbHkgYW4gZXJyb3IsIGNhbiB3ZSByZXR1cm4NCnRoZSAtRUlOVFIgd2hlbiB5b3UgYXJl
IGhhbmRsaW5nIG91dHN0YW5kaW5nIHNpZ25hbCA/DQoNCnNvbWV0aGluZyBsaWtlIHRoaXMgdW50
ZXN0ZWQgOi0NCg0KbGludXgtYmxvY2sgKGZvci1uZXh0KSAjIGdpdCBkaWZmDQpkaWZmIC0tZ2l0
IGEvYmxvY2svYmxrLWxpYi5jIGIvYmxvY2svYmxrLWxpYi5jDQppbmRleCBlNTljMzA2OWU4MzUu
LmJmYWRkOWVlY2M2ZSAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Jsay1saWIuYw0KKysrIGIvYmxvY2sv
YmxrLWxpYi5jDQpAQCAtMTcyLDYgKzE3Miw3IEBAIHN0YXRpYyBpbnQgX19ibGtkZXZfaXNzdWVf
emVyb19wYWdlcyhzdHJ1Y3QgDQpibG9ja19kZXZpY2UgKmJkZXYsDQogwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGJpbyAqYmlvID0gKmJpb3A7DQogwqDCoMKgwqDCoMKgwqAgaW50IGJpX3NpemUgPSAw
Ow0KIMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBzejsNCivCoMKgwqDCoMKgwqAgaW50IHJl
dCA9IDA7DQoNCiDCoMKgwqDCoMKgwqDCoCBpZiAoYmRldl9yZWFkX29ubHkoYmRldikpDQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRVBFUk07DQpAQCAtMTkwLDEwICsx
OTEsMTQgQEAgc3RhdGljIGludCBfX2Jsa2Rldl9pc3N1ZV96ZXJvX3BhZ2VzKHN0cnVjdCANCmJs
b2NrX2RldmljZSAqYmRldiwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25kX3Jlc2NoZWQo
KTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChmYXRhbF9zaWduYWxfcGVuZGlu
ZyhjdXJyZW50KSkgew0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IC1FSU5UUjsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCiDCoMKgwqDC
oMKgwqDCoCB9DQoNCiDCoMKgwqDCoMKgwqDCoCAqYmlvcCA9IGJpbzsNCi3CoMKgwqDCoMKgwqAg
cmV0dXJuIDA7DQorwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQogwqB9DQoNCiDCoC8qKg0KDQoN
Ci1jaw0KDQoNCg==
