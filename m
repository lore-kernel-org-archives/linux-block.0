Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DB364EA5
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594207; cv=fail; b=lkoV+G7arTthLCuZT9l8pemdjkX2ZEpyfe/KAX5iIgS158LMSIL+0iDm6+kdz2lLXeZssMAyxDud6lWyzLz1+EX4fsbVEmdXSbZ+41Qd+N/4qFNqUzMwKp8e6Fv35qi8UckYTZB70yjJu+f92tmNjQ5MQlvgDg8t10Qx0BvSCE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594207; c=relaxed/simple;
	bh=rSEJOVEIz/YukkHWEHe0hiHEJIEHmDDTSdykIjsm2uo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4rNMagZZdla21cvbVrcIM9h9Agki8mUMzvJQkQM8se9VJG2hWmuW4H8TicORwZ24iGFLXf3PoP/c/Hl1AsmGGd3CNL/6xTmTGODqaFIDwr8dGjkedezzoUxcCXOfiMI3IPp+amIhh0NjYXeqndSFtgnH8pH/sMXvVDyZ/Y5FKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k//x30Qj; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k//x30Qj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E961INnls5OxGj2eFQYAx7T7JY+RCz7IqzADWlch+t2fMiQRz9ZEAhv9SiBYcADRyrlzki3nYakya+a5ak0WqOyCQgkWVv+iE4QS1APafYOA1RfYHPQ6SyUmgRSFeIC2rUFZF5RxQmb7SZjzEIr2Q6IWKsMf/VUCy3J/amE/cOGLgdMJu/6Zt93jeiu4GnvofPF11BgJvQ1iQEM854BWk5Ss2XIctDUMkAvBu+OCtZ8h/l0Y1ntccQB+wA2gryd+kXtuHf0ztqRmLZ6c8mJ2QAEq9nQjAb6nYNaQzrAZ5AAUg6z0o2id6n9B6rRQNUJutrYK2/8cMB6wOHGLwhqhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSEJOVEIz/YukkHWEHe0hiHEJIEHmDDTSdykIjsm2uo=;
 b=wJQBaDKxZkPs8T/e1joXqLzFoJ8Zyt1p3N9i6aeQcurpQq2KyzQgT64sTeexgJm2HqJU7v9dCRv+CYbg7qHc/LC4upd2hQrum80DcLV+jQYOxNALyETHRlPgOPpbVtwEUKcakK1ejbsIxobTPfxyTFNQ837si6FcXn2H97mmWIOWz8l2utFDcqWxYwg5fWNVr6EMbm0b30mg4EXtU5bAh3njxiz8AJYE49KVjyirT1MhmiKJlIRfR8xTYFaxP8O5/HMUiZF4sSrigGqN5vs5DXHC+DkBTFqA/3x1w2S8kWEP1peEqNsz1vx2vR4uAMB4ZpGk5Q2GbPqvwVZxIMjYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSEJOVEIz/YukkHWEHe0hiHEJIEHmDDTSdykIjsm2uo=;
 b=k//x30Qj/BNJ5m67JFRsi41INmiJiC2yK7xKEJ0yt4GLv0PuTUmK+pznE+0YqQuLets07gCskazE2JPb6/b2TzMWfIX+e0vfisULpYRz3EF8xvd6COhCMcReuvLJpZeO+pE3O7DNnc7fBYsxjtsacOQveT4tOSq+pWxvcoSXezfOd59dosLVT5eAMMFN9aHSQB9bpqnJomsu4b3MdT//his2ZRvOFl9WwTUXvirmBmDVl4RIdMwOWN/ZDweQ8KSO/zwWcAiQx6QpwWlLj030HwpOCBvMc3ZC75KE6BddFaafqAGKxhxS9medzn3rHl6Dt42PlfAae0u4zKX0OJRM9w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Wed, 4 Mar
 2026 03:16:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:16:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use __bio_add_page in bio_copy_kern
Thread-Topic: [PATCH] block: use __bio_add_page in bio_copy_kern
Thread-Index: AQHcq4I+H50WF+IkgUaTJaOn8KUmELWds5+A
Date: Wed, 4 Mar 2026 03:16:41 +0000
Message-ID: <b667aaf2-613e-495d-96ef-1eaa6af921a2@nvidia.com>
References: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
In-Reply-To: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7287:EE_
x-ms-office365-filtering-correlation-id: beb0a5de-458f-47ca-acb0-08de799c7500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 Hk+ldrgkdAKJii5DL/Bw65XBR+BaEchU0KdSYJ5VJzQt11OTentGXJ9QKfa2A3UnUaMtPBMvs7hFnM05hFj2IK2+sFrp7NcKVSyCMkDd6Tm+xSIDFLFzwhtsPqBkgDmJzPlfWPRG0dAr2xkDzkxmFs6sUOfiT5Xj1TurVmq0pE2WWrdjzK/+nKvsBCYBTdLUbPnC06dPjkh+MNe3O6ZwZcbpPX5SRjaXwAWG2p0eHc/gzfsaHzqNwdR4Fn6tHjB+PN7bY2TmN47UXYCtw1q6CufXoJrNom89zbWCZZCmUudtQooSstTSog2+4KYeg4nEC6cKfj2UrNjAJLmXaADSVzBgLPrBk5rf3/RbCYfo1NHQbGC0/3DwX4A0VtddrwYGjbg2h1Fjcnva1SxfkqFc5VXIjqQn24NXCuDBoEQrMQpCYL/o1tRE0A7oPgUffhb5PqP+2GB8BGRfSBYEIsZ0D2qRPQEbp6z3scrqs3six7hzglbJO8cmzxIPmYBPAKFc3vXy/Cl0XknA30sFy8prx26Bcs/IrQgO6BNsNQNBbl/Jh0+7bc4JlHazI3bgjKLn2jU9Yr6bAPlomeWHbB2sRaaQvXKE+kQLByDQ8dfTSF1iQRiE9Z08gC+WrlzgJ8yukLeVQLwhfiDhkJ/1tsBjNHTVQSnyJG8qbjWcBiMipr5AXfv+ns7A5RaYEgDF8VTmGgLSrjg1mg7aeb8eEHfqMLc/vHhb/qiXmBpx3MRwOMm4Xk3XKsFafy/o5lADdw32Nw8i2yPGXn44jDkeFD6rRj7oIDdn2aoY+LjzFfGIxKs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmRBckJ5T1pkWm54Yys0d2dHUnNrVWZhR3d0ZlN1ZlBteFpybENuTXlzQW1O?=
 =?utf-8?B?RlY5RTZNekpXbTR6UURNSk5xbTcyN3R3OU1VYWEvRGQ5d1Y3cFRueHZlT0Ju?=
 =?utf-8?B?OWYrSk5aTmVpb0dkTU1FWHlCVnExa0psOW9Qcy9yTkRKRGJXcG9EN0JGSmh6?=
 =?utf-8?B?SEcwUnEvaWFUcWpnQmRUeWZPY1VTZE42dHFHYUVzVmIzclFxcVJEOG0xYUJw?=
 =?utf-8?B?bFlWamt5ZGYxdkh1NzE0WDM4RS9VaCs0UjBlK1BnL25PdnVXc3JoNWdnWGFx?=
 =?utf-8?B?UTdnMEgwUUtiUDN0aFZBMTA3dGxvdHh3QW5ybzdBakUzMC80Rm1jSVBGYXpl?=
 =?utf-8?B?RVVCVURjNDhtV3JWM2tHRkEyZ1JydmxWSGNFZ21CMU13U0hOZTV4Nm5aR1A1?=
 =?utf-8?B?Wmp2THBHT09KN3NmLzZRRmZ6N2lQVUZhMHBsZURXd2t2aFJscjhQVDhrV2VF?=
 =?utf-8?B?ZnVTSmRPRHIzNzZOWElGNEdkcGxVODNFakZNTFVJT3JFWVI3WlplL2FLM1hV?=
 =?utf-8?B?SFM1YS9vdGhWUXczTnBKNzY3aGV1dFFrK3V1dloxQWJIVUd1ZlVDVytPK1VU?=
 =?utf-8?B?QWlTQXJrV2ZMbEx0TnRSNkJTQUE1TmJpa0ZXSk4xNFBFZ2sxMHVWb2RBSzV5?=
 =?utf-8?B?ZVp5OWdEN1FoMm04dFhvcTdLdXlGNTlrRGdLN2tDYytzVFBjZ094VDF3THgw?=
 =?utf-8?B?QVVDRElvaStJcmN4TDlEakJMRW5hUEJoZlFiaWo0NUFhTlFBQlQ4TEFJWi9Z?=
 =?utf-8?B?NXY4aGRiT0hiLzB0a2Z0ZS82ZTVLVmh4dGNFZUs1enUvRDdoelZNZTVBdVBq?=
 =?utf-8?B?N2FVdU5uWFJqUFFEallENUVLNkdodjc2Z0E0aG1wbHhWd3VzcldFUkFaNlJU?=
 =?utf-8?B?Mjc1MGg1QkdFWk5sSXA5MldTT2RRSk5GOTFhSGZsb0lTYjBEREhVd2FiT2dO?=
 =?utf-8?B?bWFtbEx6OXVkZmgzUkUydjRPTWdmMy9VaXVoQjEwYkk5bWxWakxWTDZLV3Uv?=
 =?utf-8?B?NVl5QXcyOFl3ek1zN2ladW1QZHpTRDFXckE0MmVvL2NiN0hyejRYTzJyMVZC?=
 =?utf-8?B?NUJ3RFAwVXk4Y1Z2SThpNDM2UUoxOFlmRDZsTnIwNEdaYk5IVG9GUWJyTWlL?=
 =?utf-8?B?VVpNOE5aWUdRUys5NVpoMnNHODMxYWZVRjlFMlpLLzdYNFNmYzRXTUs5cXor?=
 =?utf-8?B?aXV3NmZDNXUrTGpNVkI2MUplSFVjUGRKcFVUL2w4bUVMSVNwR2tKc3NoSm05?=
 =?utf-8?B?TkRqSDVyMlhHMlUyeGFXRWR4SHZCbVg0MnJJZnpKTFQxQitKSlFVUDRWTVdF?=
 =?utf-8?B?OHl6UHBQYlJ2dU0ydGphVmppYXk2V3BFVGpYVnY1aWx2K0lkMUUyTC9CRzd3?=
 =?utf-8?B?Z3BWUjcyaUpaVURZbmZqeG44YTdmamZheTFaTmI4UEY4M2d5ZlpSeGx0RGdt?=
 =?utf-8?B?L2VCOXVqRDRnK05vMUxsNzRBZkVFY2s5VkU4YU1KRFFUSU1DQWR1VlpNd3Rw?=
 =?utf-8?B?SVFvOXQzUSticEpXczR1OUR5TjhWbDhYTjNyVTVkaDJUenZuYmZlWHhBUG40?=
 =?utf-8?B?WDV1alFNaVRWZmhRWFhwMVJnUlVvOCsvMU9aeEgrdlhOZHg5RlhlalZUWWVH?=
 =?utf-8?B?U05rYk5LY0ZVWkRKNkJOVm5UWG9ldHVEV3F2anlEVWo3dnI1NDI2V3VJZCtS?=
 =?utf-8?B?N0l5QWRGYXUva2tkazhtc3YzNDBPeWZxUGVrcGl6cXBaTVpSMVRkNUhOYmVj?=
 =?utf-8?B?dWhzc0pseG1qQTB0aDVtVXQ3OTlqaGtpVlVNajErZkE3a1JJR3p4OTRTbGlq?=
 =?utf-8?B?bE13SWthaWtZQmhwVVo0b2JtemtRdXlORXJKYjg1TzEyZlUxSW5VRExjNGtx?=
 =?utf-8?B?T1BvVXJhaTVGbzQ5NGxUQnZHYXFnL0dvRFpHL1cxYUs0T3JFZ0g0LzZjc0Er?=
 =?utf-8?B?b3ZaK0xGcnpPdXp5YjdrOFdpdHZOZVlLMHdtaERuQTI4TTlxOXYrZWlXMDlu?=
 =?utf-8?B?TUV1ZU5PQy9sYlo4cC9JbmhVbVV4VEF6TWN0YWIrcnh4eVlOU1ZwRVdNQ2pw?=
 =?utf-8?B?L1hUek5tVEtWdjVURXRHbFNXTmdpSFZIZ0hlWko5K25PQlhwbnZ4WUwwTFZU?=
 =?utf-8?B?UEtIT1NjVHg2dVpqUFNWUkJHM2V6NWtIT0dkMTFDdmsvR09YLzc4WmNDUDV5?=
 =?utf-8?B?OVlFK1BDaWVza1U2MXRFUTVzUTE4L2p3TE1SbytmZks5ejk2OEtKTjBzM0FI?=
 =?utf-8?B?WnlacFdKMCtuQ0RhVkV5Yzc4OE44MVFTQ2hydHJHaXB3c0h3WUYrWkJ6aVFp?=
 =?utf-8?B?azJtcy9sT0ZRQjR4TTFVR2FlYndJamVxK0w4dE9CUUhkOGdnYkNTUzYrdUpO?=
 =?utf-8?Q?aX7LQWc56c0oar6dPnWetuinrdf3P80iH0rPm7qDUUOaW?=
x-ms-exchange-antispam-messagedata-1: 7o6OipEx/O6yIg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D19D57C0876974698D2DAEA0C6D4F4C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0a5de-458f-47ca-acb0-08de799c7500
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 03:16:41.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFT8hdTVoZ86QcEsJLHbpnkLyc9OFcM/Uv7fi12/piEE8CGf80qu/CaxsNFyGHpZbrH9BuRtpW5QNYr11g7V4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

T24gMy8zLzI2IDE4OjUzLCBZYW5nIFhpdXdlaSB3cm90ZToNCj4gU2luY2UgdGhlIGJpbyBpcyBh
bGxvY2F0ZWQgd2l0aCB0aGUgZXhhY3QgbnVtYmVyIG9mIHBhZ2VzIG5lZWRlZCB2aWENCj4gYmxr
X3JxX21hcF9iaW9fYWxsb2MoKSwgYW5kIHRoZSBsb29wIGl0ZXJhdGVzIGV4YWN0bHkgdGhhdCBt
YW55IHRpbWVzLA0KPiBiaW9fYWRkX3BhZ2UoKSBjYW5ub3QgZmFpbCBkdWUgdG8gaW5zdWZmaWNp
ZW50IHNwYWNlLiAgU3dpdGNoIHRvDQo+IF9fYmlvX2FkZF9wYWdlKCkgYW5kIHJlbW92ZSB0aGUg
ZGVhZCBlcnJvciBoYW5kbGluZyBjb2RlLg0KPg0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdG9waCBI
ZWxsd2lnPGhjaEBpbmZyYWRlYWQub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFhpdXdlaTx5
YW5neGl1d2VpQGt5bGlub3MuY24+DQoNCiItLS0iIGFyZSBtaXNzaW5nIGhlcmUgc29tZXRoaW5n
IGRvZXNuJ3QgbG9vayByaWdodCBwbGVhc2UgY2hlY2suDQoNCj4gZGlmZiAtLWdpdCBhL2Jsb2Nr
L2Jsay1tYXAuYyBiL2Jsb2NrL2Jsay1tYXAuYw0KPiBpbmRleCA1M2JkZDEwMGFhNGIuLjc2ODU0
OWYxOWY5NyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1hcC5jDQo+ICsrKyBiL2Jsb2NrL2Js
ay1tYXAuYw0KDQoNCndpdGggdGhhdCBwYXRjaCBmb3JtYXR0aW5nIGZpeGVkLCBsb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K
