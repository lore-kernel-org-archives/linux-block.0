Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF01D512
	for <linux-block@vger.kernel.org>; Sun, 25 Feb 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708846862; cv=fail; b=PZyv7liKH5B4tEiwbvJhOymSiMMPtrCXLRPX0HupKUZnz7aTnmqAlcUYJjATtMUsyxTdCutcueqqWDAuFDAZmN6kkWagqAzyF/iZnjo5Bla1wSXdmW32IhwuTS5UfdKUPfpVkNW+5SJR60nxyL1xI0337fkcJ8MRQ8AUuzydPSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708846862; c=relaxed/simple;
	bh=kxLCrA7+ckBgSVibFQ/5ZRQPPMZTHKOPDJIMYaeJJSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0FSWAbhgO0OGHKAf2RhMNT0YQyUB1yu4GZR8eQQLG+fehQpalhoz59rqOw053KZ2dP9YF+oWdeXrKUerj3aXR17KANYRB1Qp2hWkiRArguzWxoHB0BRLBVWLIdbmtB0pEJJTelzOvAwZAO7qJC3z9xTadE08xxteJGWJH2443o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWIklSvy; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWIklSvy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUJM7hz2bNFG+tV9m0rHB0iOCdyAiniTHnymGuy+75MuMYx/luQdyTT7qJLzMXdZoGw2bvZXGgKAyBLK3ysYrmXd4wWLH/pGudCGby6b5/mPk15aFDdVaNemDg2oAdCKJgm4UQ9edt73ojRIbN5zrkPj0bERbCiR3JFIQfp0BNmnZVkpqQzPZori/uzKhX7n0XDlNI3s2vcDRsa/D0oURmoYtQOZmfoQNSb4SZd54yiHO0P8Z9YziZdCfc8vPaLRfCjTagBIgthyi48jLbs1DwFdPtvvT6r8GgzL35znVksEan1/4cQRT1CWb2EFzd9ejJT7lWiIx7guCc47oPZkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxLCrA7+ckBgSVibFQ/5ZRQPPMZTHKOPDJIMYaeJJSI=;
 b=DExSr3tkzgVbVP48mLp4+fTrcSGKxyyt9sJXdG72kdbf9fh18eoXaTm3TNrxzxzUCVp41CLWy7PiDzrpFZlCIgXXCCDoSmkanwXT3KmXf4Qzc6x7Th4N+SM8ge703HwiJg/PiavUZ29K+2KaoyQJjdcpHPYeLJQaPbiHYr5AMFOxRzRA3+d5+KJ5jPCwIosTPui3S3nFCwoygLanGEWjZZCvJz0EE45RO5ViZ1/lNXCKyZPtRzh5qsGiFxcxSxfMSIVh7/AYr2GO9MXjcdUtlbbKNZGiOouEpl9IOLp84kqOOxTmYBeoe1eEo57ZhkbRTGg5GJxbNSzBfGaEkSVBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxLCrA7+ckBgSVibFQ/5ZRQPPMZTHKOPDJIMYaeJJSI=;
 b=mWIklSvyjx3dFTVZqgBvj8TB23DoiihW/JJQp70eulX6wUE+A3ucDdtL0PsaYOhe5CADNNrBhWRpVQ+mGud6DD1k46SvrjVHfJOpPsKygIH8RND6J7UG/sdj7iw7Sn+MiBDJZ7RVSDcFamNDGENw0Kjsf60CUembeP85LXJ1slLS7UytZeHoaxd/NG+CKYDjr4RuFO21CuZUjoG3y5ZMbPSm/L7745bpR/JqJmPTloAVEvDbHA979Of8wAl0daQqPOnV5RELvDDC7RTsWdoGarmFdelvCywyD1LlcZLRaQRSacWO5jHMAnighX7QqrG5iL976L32I6J2QeyDFAnTKw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 07:40:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.032; Sun, 25 Feb 2024
 07:40:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "nilay@linux.ibm.com"
	<nilay@linux.ibm.com>
Subject: Re: [PATCHv4 0/4] block: make long running operations killable
Thread-Topic: [PATCHv4 0/4] block: make long running operations killable
Thread-Index: AQHaZnFKuwnlZYL4+EOJ+sI80l7TmbEYTLkAgAAEUgCAAl4CgA==
Date: Sun, 25 Feb 2024 07:40:57 +0000
Message-ID: <96f8505a-5fa0-49c6-96fd-30d5b42c0cf7@nvidia.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <1a81ef8d-023b-4a87-a71d-a31dddf3106c@nvidia.com>
 <Zdjyrvfy7aELykoS@kbusch-mbp>
In-Reply-To: <Zdjyrvfy7aELykoS@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: 6263d0c1-a0c2-4c06-fb44-08dc35d51b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RqUc9CmWONmVZnOFC5MOEGzhOkSzB4k1QHE+o9PvYucg+0TLpEg5cxEdyANFS9NICimgioJj6SCXhZpo/2WOVp2YqYZrAiMOqUycZ/iDQrUuElr+Iu+2c/36LZ20DjAySy/cxDgZx/8ShM96ieXPEh6AMGux0ufKE52uZMI0FdeCMSCYY950q/GWWczWlvEjVDs/2FFq9Nbqyh6QR5fwgIdWiLL2iYnBXlQf/MNMiH0SUaJ9Inr3pG8qR1DPRBjkxw4KfFPW/1ckTmUH3IQEkuHj0bKzYDZcpxoeqvbAxtOclMRX/o7HgBBYB5Dql/GmxKj05o5ol959XcIlA172W/63DfWtpLfzGdeco5Gw+2mnoejucWFOYJkizVCI59KQwWteDkY2UWmeoZsiPLkiM5Hw+ZUgcaxwf2ATlWVDUmmTXZoBHH+bIXngYIEU8WWUsAvRRVA1WgRb97P7gM1J4Qe5vDpkLY7pO5QsZLzV3IztzFS2kO0x0gwMfsWVy1yhDJdfI1fcySCgZo62AvmHhgpIt9Mln7d1L/XvXvtPVMDWHStEbzQd+Bux6DKNYXfo3nFdL3W36pwKGKb+VnzSZvg/j+9YGPHeXWxJc68y8vRmZiHqMf6uHZ8Ena91sZsc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUdKd0l5RVY3SnhnZG81Y3M0bXNPYW81TVB3cDVCakpXWjRvQ1U3M1AzVmwv?=
 =?utf-8?B?TFl3U2ZNZjhKb21naDN4dEMwdUhwT3pIa2x1TE1jU2F1T25oKzlvSlF0cVpO?=
 =?utf-8?B?R21CRXVGTnFlWTIwUWN0d3RXSkh5YkljVmc1UTdHTDdVeHJpZjVXM0VjWkh2?=
 =?utf-8?B?cDA5TDd0WG9LaHpNQ0pFc1FlLzNqNWFDa3oyelQ1VkxwbWJkM25rWXB6dVQ0?=
 =?utf-8?B?MzJZM1VmTmFQU1VVVGI1LzBKN2VrWmo3UzhsUkZJbVhDdUh6cHVBd25KSExL?=
 =?utf-8?B?UUY2V0JBUnVlY083NVFSV1ZvZXR6aVpBTmlwcElhZFV1dkg4VkZMQlFXRFpF?=
 =?utf-8?B?K3hJZENsemhrTFhjL2NEY1NkbDRtbGhDcmE0OGxnak5rbitHZHY2OEpWbkdm?=
 =?utf-8?B?cGFuUXQ2YnVqSTZTMStlT240Mm02QlBWTVk4cThzREJXRHhPY21nVDR3bFN6?=
 =?utf-8?B?bWwrNWVjeCtwZXVMZFA0bGplemJBdlY0WUNEb09tYnBUbjZrdnNBU0t0Zit5?=
 =?utf-8?B?bGtjaTd2ckNlVEJBWTJuV2ZRQ3IyK285M0d0WjFVTkhpUDFuRUpEZnd0eTJJ?=
 =?utf-8?B?ckpkWDlxdkU2Rng3S0dyQXlkS1pmTjRRZ1gxMkhRbHM2SFhKZmJGY2hVU0ky?=
 =?utf-8?B?RVlKQTZtSDlZblJNcjNVcEI0QllidXZLVC93Y2lPQ2NVMEltQlN3dDlkQzJq?=
 =?utf-8?B?aFRTMjVFd2d6MzUyRnljbjlsSVhxTjhqcHFpSlZVdkhET0R4ZHoreFcwQ2Jv?=
 =?utf-8?B?dmtXOEloZWpVbmNSMHNxeFhpTnZBTjhEWGJPazhybittcTdacDlGWHpNQ2VW?=
 =?utf-8?B?Sk5ZekJ6RTNTeFhDdmhUb0U4dUJPOWVmRFJTRTk0TTNmeTJJL2hQRldsUE8w?=
 =?utf-8?B?bnlqcm5GaHBObVdtL0hYZ2hSYUlmZFY1R1FJSTlVSGVzSCt4QitScS9SZ3Rl?=
 =?utf-8?B?Nk5OcDBQK3k0c1BYemF4djNOeXlRNHRYZWxrRjZpQ0xlV0dQUzZybkxkdTk4?=
 =?utf-8?B?aUQyYVNSajYwaW44K3dWMWJDTithQ2lmSFpVdWpLZ0Q3WkRjMzZ3aGQ1dWcw?=
 =?utf-8?B?UVpidWJoSllkSktBZ3VBSzRVL0d4dkhYU0puS2VNYWcwQUVRd0dLME5Sa1I0?=
 =?utf-8?B?RzJkMmc3Z2tGRnV5dVpGOWVWR0RkVkdLV3NEMW5YMVgyWk5jbFAvRENWSjI2?=
 =?utf-8?B?U21SVzliUVlHaWVteHY1Z0FEeVltendwK2ZFbGd4cGxWU1I2WGFvMndtSkFD?=
 =?utf-8?B?dTZJbXhBWFZLYVFkY01KVVU0YUZvZ250TTA3VFZublBqZkJ3VDZnTDh5TTVI?=
 =?utf-8?B?V2VjaHZSZzc4aTBFbSt6TTRnb2hsODhubWxtYWdLbXpIbi8wMXl2UUVJd3Vh?=
 =?utf-8?B?VThMamlhVmFEK1loeUlWWmU5QjF2R00xbnhobnJxYW9kNkJxcjdsR3pRcU1E?=
 =?utf-8?B?KzcrdCsyK1hEdHZxWlI4UlJkQzBFaVFLSTVRV0xHR1VSdUl6eU9hWHdXS3h2?=
 =?utf-8?B?RVRCUFMvS3dVM1A0c0R2ZWxFU2s1RGV0aHZIN1N0SG9QeW5UQmFIa3Fnd3Zt?=
 =?utf-8?B?dEhwNytFSCtLSFBIYjV0a3dUckxXQ0hqNUNkWGljTUNjY3A0cHkvclRBa2sx?=
 =?utf-8?B?RHlMUVIxL1NVZ283SmJabHBHc2toU1pWU1AyTzRNWW5aR0dDd0JaTUp0Z0NS?=
 =?utf-8?B?ZTBBOVZ0c0hMRzB2Q2tuY1pCa0VTWUJ2bGtYRyt4NWN4NmdaaFRnZGovQldL?=
 =?utf-8?B?ZzVnenhkL1o5bTVieDhnVHEvZjhodXdZUUlhalpVc2VteVNraUd2Yml4SjlG?=
 =?utf-8?B?ZG14N2dtYVFlYzJlMExGbUlEeWNOS2JmNkM0cG1Gdk9wTTdzYlg4NWl2aElz?=
 =?utf-8?B?VDlNdk9IN0hzM1JRcnp3VzVVbzg1TXlwS0VpOUc0TzhkY2VMcU1POE4yYm1P?=
 =?utf-8?B?amp6TkZ4cGdVSHM5bEhDNkt3QTJEV3MrRWJSWGRzTDRsN1FLanhwdHRUUXlh?=
 =?utf-8?B?azdzMURLM0tpeGFtOEdGL2dBVTNEbTZLMmdaSllRTi9PM1ZaOFVjaExIMWVz?=
 =?utf-8?B?Z2tiT3hTTHVncDRSWDk4SjB3c2RQUTREems4V20vdzRZbDMyV3Z3NjNMVWJL?=
 =?utf-8?B?cnF5OWpiNkRaaFlHVThIcVJrRFRzQ0lIbW1YWldWbUdLVnhIWkhFa1lJRy9Y?=
 =?utf-8?Q?J+UT09mVrus/oqIcy0ZXiXIirOE+0X3lDvGH3n5/camk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EBE7FBBCF860B4887739F90D1669DF5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6263d0c1-a0c2-4c06-fb44-08dc35d51b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2024 07:40:57.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlVy83FRGTj3MHXKzpdXZBGfocfzWlaASZfTaiD0j2addTpdM3IuQBMSnjNLeMrhxpzfMGqRhqT//so+oa9TYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

T24gMi8yMy8yNCAxMTozMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIEZyaSwgRmViIDIzLCAy
MDI0IGF0IDA3OjE2OjMwUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IE9u
IDIvMjMvMjQgMDc6NTksIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+Pg0KPj4+IENoYW5nZXMgZnJvbSB2MzoNCj4+Pg0KPj4+
ICAgIEFkZGVkIHJldmlld2VkIGFuZCB0ZXN0ZWQgYnkgdGFncw0KPj4+DQo+Pj4gICAgTW9yZSBm
b3JtYXR0aW5nIGNsZWFudXBzIGluIHBhdGNoIDIgKENocmlzdG9waCkNCj4+Pg0KPj4+ICAgIEEg
bW9yZSBkZXNjcmlwdGl2ZSBuYW1lIGZvciB0aGUgYmlvIGNoYWluIHdhaXQgaGVscGVyIChDaHJp
c3RvcGgpDQo+Pj4NCj4+PiAgICBEb24ndCBmYWxsYmFjayB0byB0aGUgemVybyBwYWdlIG9uIGZh
dGFsIHNpZ25hbCBlcnJvciAoTmlsYXkpDQo+Pj4NCj4+IHdlIG5lZWQgYSBibGt0ZXN0cyBmb3Ig
dGhpcywgZm9yIHdob2xlIHNlcmllcyA6LQ0KPiBIb3cgd291bGQgeW91IGtub3cga25vdyBpZiB0
aGUgZGV2aWNlIGNvbXBsZXRlZCB0aGUgb3BlcmF0aW9uIGJlZm9yZSB0aGUNCj4gZmF0YWwgc2ln
bmFsIG9yIG5vdD8gVGhpcyBpcyBhIHF1aWNrIHRlc3Qgc2NyaXB0IG9mZiB0aGUgdG9wIG9mIG15
IGhlYWQsDQo+IGJ1dCB3aGV0aGVyIG9yIG5vdCBpdCBzaG93cyBhIGRpZmZlcmVuY2Ugd2l0aCB0
aGlzIHBhdGNoIHNlcmllcyBkZXBlbmRzDQo+IG9uIHlvdXIgZGV2aWNlLg0KPg0KPiAgICAjIHRp
bWUgc2ggLWMgImJsa2Rpc2NhcmQgLXogL2Rldi9udm1lMG4xICYgc2xlZXAgMSAmJiBraWxsICUx
ICYmIHdhaXQiDQoNCnNvbWV0aGluZyBsaWtlIHRoYXQgOi0NCg0KIyByZWNvcmQgdGhlIHN0YXJ0
IHRpbWUNCnN0YXJ0X3RpbWU9Z2V0X3RpbWVfc2VjDQoNCiMgVXNlIGdpbm9ybW91cyB2YWx1ZSBm
b3IgdGhlIGRldmljZSBzaXplIHdpdGhvdXQgbWVtYmFja2VkIGZvciBudWxsX2Jsaw0KIyBzdWNo
IHRoYXQgaXQgd2lsbCBub3QgZmluaXNoIGJlZm9yZSAyMCBtaW4NCm1vZHByb2JlIC1yIG51bGxf
YmxrDQptb2Rwcm9iZSBudWxsX2JsayBnYj0yMDI0MDAwMDAwICMgdGhpcyBzaG91bGQgbm90IGZp
bmlzaCB3aXRoaW4gMjAgbWluDQoNCiMga2lsbCB0aGUgcHJvY2Vzcw0Ka2lsbCAtOSBgcHMgYXV4
IHwgZ3JlcCBibGtkaXNjYXJkIHwgZ3JlcCAtdiBncmVwIHwgdHIgLXMgJyAnICcgJyB8IGN1dCAN
Ci1mIDIgLWQgJyAnYA0KDQojIHJlY29yZCB0b3RhbCB0aW1lDQp0b3RhbF90aW1lPWdldF90aW1l
X3NlYyAtIHN0YXJ0X3RpbWUNCg0KIyBtYWtlIHN1cmUgcHJvY2VzcyBkb2Vzbid0IGV4aXN0cw0K
cHMgYXV4IHwgZ3JlcCAtdiBncmVwIHwgZ3JlcCBibGtkaXNjYXJkDQppZiBbICQ/IC1lcSAwXTsg
dGhlbg0KIMKgwqDCoCBlY2hvICJUZXN0IGZhaWwiDQpmaQ0KDQojIG1ha2Ugc3VyZSB0b3RhbF90
aW1lIDwgNjAgc2VjDQppZiBbICR0b3RhbF90aW1lIC1ndCA2MCBdOyB0aGVuDQogwqDCoMKgIGVj
aG8gIkZhaWwiDQpmaQ0KDQplY2hvICJzdWNjZXNzIg0KDQpXRFlUID8NCg0KLWNrDQoNCg0K
