Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FED3C493
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508810; cv=fail; b=P25apGsx86Yr6eMwiLjamhhDub7KkhHAZCVqXe+AFhSG8/4MlhJxqeofjT073NlCWpQrMKje+H9VXixFeMbUXiz/EGguIGmxrQSA1FIX2VggzQA6TkZNp6U1hX7LAXijbjTsoz24VLqoQqm0JH6RyWcbF2XY1zq83RWSHZuB3wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508810; c=relaxed/simple;
	bh=4FZ8u0hIzgv+Vr1mMChkZ7AFyzRnJbkq8uDlTrpQ5rI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpV6c6c63HD5MN4sHUB9dIhB8F/wtGlcu+SEiBrOtDb/wTen+jD+uO7CF/LDGs8yjOi/nOBb2K7/iGsm6qGNFEI6g0s7Rd8xwrdEl+Ncz3GI+069QapsfIrgC1blQRd8qrNCoJWB1dXR0EVF/y0RbzBoF0M6t6WkXGiP0qYmJdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHhE5+r2; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHhE5+r2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBI4ktmKWAa3LQmUuB2JZi4xzQlIH8XMEVKrfUwg8OHggbSgwRUhXq2JpA6/RAVPFYGYrdn7fFU0xgiJI515stBrlQoIsA8KMV39VS8n2UMDDGZ2ErNlcpTOmDXpHrnMuuZcPnH3xrQ1tkWsg+i/mo6g0LsLCuRldFt/z2ZMqvByOBgeOzc3chhEEhZXI+ij+LM7I2L5PmH+f9l6KZRhDXNdC+QVfqWsiq2fFsQwRnyAZng1dQnZBE4+D8ypqxx53hNB5q0WjonLqQMsrJDsUZP8JIBIj9xjXT7xGLXV37WfhB+xHBaa/TJgg4b+NsKwZ4rL4cT/RgGgIr6tvOgdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FZ8u0hIzgv+Vr1mMChkZ7AFyzRnJbkq8uDlTrpQ5rI=;
 b=KPViZaKKU6sLX4PDQVX3JEZFbrmYm5cU8WXq43k00nlC09wlrBiMwCahxfuIn8V/nymOsURiXVhsR7Qp4hB/Cdjump8OTaczTbJ8IDUB9Us/8Pi2KwTN7YRzosqHcx/GMmq+Ow6l5lIxDjUTv5iYzLkiMoWr6p759tpsSJYbjx5Sv1SuZBz+nytQMREruMT/NGC13fojRGPQHQW4zfFwDiJX5O655GceRfxQ9cJWSV0OvPqURiVQpuipWsdCjKbfbt4B1g7vqcHuqwjq1Ziba8iJTiCH2WH9iXJBf1uz/7MJnYy6u+0aYcOsK0h6fmk2nZRE9wXyASgJ+rLqDl892Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FZ8u0hIzgv+Vr1mMChkZ7AFyzRnJbkq8uDlTrpQ5rI=;
 b=rHhE5+r2oYclRXRSsXyON6NqH3hOdupaM+dXEDXb9E5Prhxf4Qll/2GqtIqNrf2IxDWnmxh3/Lb1GnfcKe709wb4dUVQ/TEfYmnkxoD5sVWIW3mjP/DmjL7H2qCG98gIjRv4Xsp1KYzolrjgA1f/MjRUR5w3rK9aVRoFy5Ez+WzJJ9rGUKpMNvHcGgjAFUelYhkEp9bV/zox/G0jIRvrxwR8ID2lRb4bzlEakMUHZJ5kL7lfzEbz5ur0jKHO5e1sMZlYh7GC0ltFxUYN9rZAujltwMX33WGkDbNvnL4XK6HGRAgcZA2MAJvVIB4UqjQLZGAl5iNvDBKz6q8MxUazzw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 09:46:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 09:46:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "axboe@kernel.org" <axboe@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Keith Busch
	<kbusch@meta.com>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Thread-Topic: [PATCH] blk-lib: let user kill a zereout process
Thread-Index: AQHaZD06sUSdY4lj2Ee2Ig44LaIhIrEUfGqAgAAQ3oA=
Date: Wed, 21 Feb 2024 09:46:46 +0000
Message-ID: <b089797f-04ba-4e0f-a763-231f1938b740@nvidia.com>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <1599adf2-3099-457d-a194-3be0057d344e@linux.ibm.com>
In-Reply-To: <1599adf2-3099-457d-a194-3be0057d344e@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5748:EE_
x-ms-office365-filtering-correlation-id: 8b0858ca-702e-4f30-0c8b-08dc32c2049a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +mIsnk3iZvw9CB3Pyx6xuT0Bi+lZT/vgUHF07xgmf+CflFRUwSVs03aiC/lg2rL98clVYcFW6eEsqmqqjuhhgW1O/CtCG/ed587yAn1I1MVwvGF8J7BQS6ms4v2QyHC9kNXSHKjl2VKcD6m+yzUH5jOwESQ/9f5OCDtcXbLlx0Orw9eNT88olnMj6KA3g8dC1fj0vuuVyKxJDwB4Q8SSrrUKJs/aq4gfK+npo+/a80DwR80bz4Ky0flCCzZBO46ah3jnyzIyYXXwaFvWJsai5W4o3H7vM/K4GSXiuFWwRigzquRYTRTPy5XZKbkhvGp9j+G5eM8GgyV5JFEBcPmq/DjEdxEwLAHFHnijf2fSalbvE310unbS4mcENDHe8y66na19HifI4NbMHTZrEKQYChVx9eJJbIZBD9c2d9CuOTmRdhWGokZDrWQnx1tYZyzIInUOr/4Xhawyb/9bFdy3Ft9WvCCHgbA2okVje0B1U0Z+TicDA2wgUyFPJP9sJFF+cq51vyHu+z6bNgKEfB2ns5vjmiRZNzbkAXFOR722fU/jXmA3uYjvybAbr2H8lbxhJJqOB1gWtYk2Uhutcn4DRvPc+Tem5BlArauCpNUZAuXBBO8GaCcSyycvBSX1EKxD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUl3MzNIN3o5QWlzdHVUODdDK21pb1BENTJRdDhuczJsMjJ0Tzc0UEd2QnVt?=
 =?utf-8?B?UlZRaTBWOTdlcXkzQzVTT3pQTFNjT1llbmRZZXRYWDN4bVcyUnJkemhxWXdV?=
 =?utf-8?B?S1BtUzRiWjkvMVYvMThZN1JLTWhlWjB6bk80WTFEa2FZUkNhbWlzU1RQR2V1?=
 =?utf-8?B?cW9SVjh1bUpZdnRaekJObU56VlBCMXc1V2owQVdzbXVwZldJeW5IeFZTenpK?=
 =?utf-8?B?Ri8zeVVoYlRzRXAvd0JrRlhpbDh1azVjT09aNGlFNjFTTHRueFM3RGRDVnQ4?=
 =?utf-8?B?c05leC9hUDJWWndmZnJxdllKWUpjWEZtaW5ja1dNMDdWdDFHMCtMdmxENkV6?=
 =?utf-8?B?N0lLQ1ZOV1F1dm1UcFRwZ0VDWHNNaXR0Y21scGFHLzhaT3E5NDh0OUpSMnhM?=
 =?utf-8?B?eEF5TExHVVFrUHpuVDN4bFlSU2ZVVXhpK2xmc1FIRnAxRjhhK3ZGNDFBR2V6?=
 =?utf-8?B?bVpGbElBOWFQUmRzK09nZFVBUUpzL2M1SnVVNnQ2L0M5azRLTmFib0t4VE9q?=
 =?utf-8?B?VGcweTU3RjhlTkFqSi9YQ3Zacm5iOGUwOXJYanowRWpPN3J3dlRzWThHSWF6?=
 =?utf-8?B?M2FHbzRkVFAyU2JmZlJjaE1HdTVVMUJmY1VhQkxockl3eWdqWFpXTnRPRTU0?=
 =?utf-8?B?blpDSUxGUkJkVjc2azdQYmpRNE1pNTJsWjVpbHBTMSszeDYveDJXV3A1NkpL?=
 =?utf-8?B?WWVuaVQ2SHFoVjdNVjRuVmprTmhicWhYc3dab0dDMHlPSm9HZE1EM3p2dXVP?=
 =?utf-8?B?TFdNV00wZGxSQVNnQkFlUEtMNDdobVVqVTVaTkhROXcvRWh1Z2dPWUxtVFhx?=
 =?utf-8?B?UGVvektYc1RXcFhRdm96QVYyYkVqUCsxRWhmYXNnQUV1ZnhvOE8yUSt5Q2l1?=
 =?utf-8?B?K3JwSkJ5dkdFa0Z2a1NlWEtNMTB5TTY5SExHb2s0bzVrOWY2RlRMNk9tVy8r?=
 =?utf-8?B?R3E2T3FPcmdZcWtqTmgzOUZtRTN1dHdsWWhLanozVmxFSXpPcnJwNjM4Zktm?=
 =?utf-8?B?MnZaUlVvazlCQjI3Q1VyNVhmU0pmNXBjdGFHUjBkaFBtM2N6UWdubzhyZnVn?=
 =?utf-8?B?MjJyOEVtU3R0SkdmNnBzeTNydUZVUFJIL2d0R1BiWmV0QnBUelFjV1RmNVhz?=
 =?utf-8?B?cXhwb2IrTDhNUXJDdFFxU09LNEpwT2FFR0YrME9CSmt3ZHovdTdCR2gxQUs4?=
 =?utf-8?B?M0hucFYwakhHK25jZzREd2JSaFM5K2R1VDF6Q29adldkVXhVdkwvTlhXYU5j?=
 =?utf-8?B?L2NmL1J6aEVUSi9HZzRSc0kwY2czUnBKeEJzTVZjUHhGejVveFJZdGJsajQr?=
 =?utf-8?B?TkNTdGZ0NHc4Mm5vZWtDOEdQcHMwWG1FYU9JU1hqcDRsdmtSTzI0ZWdLZUIw?=
 =?utf-8?B?QWZxcDJ2cGRRblk0R2N1c2hRVVBuWno5a3ZSNVV0OGZ5bjZPSFg0WXNUbmps?=
 =?utf-8?B?a09nMi82U25LZnNlQitRY05VSFFRc1FJWkJHY3ZPNDBSM2RuL1dYUE9FdVRq?=
 =?utf-8?B?aWROeXhrdXRFb1RvR01rU3VlUVU5QU1LYWM4UTd1VXVXbUNLeHhXU2tVTkdZ?=
 =?utf-8?B?eVhJR29LalJLZC8xWmN3clRNQ0FWek9wcXZ4Z0tRUi9rak15MXpwc0ZCTWZs?=
 =?utf-8?B?cUZOVzVuL2lUK0dVTml6ZEozRENGR3A4dk9OYU4xVHAwaXZBME5BWnZCbmxK?=
 =?utf-8?B?UnZvSm9ianZZaVh0QkNRa29UU0VtSDMwY2M5VFU2UGpRS2dnVjAxVWZOeFgz?=
 =?utf-8?B?VGZiME9kZWdZV1V0RlRzRVJNV0UvYVB5UkIzcm14UDNzWGZMUCt5czdiZG1r?=
 =?utf-8?B?Zm5TVXA5UzhucVFsMHV6MURaaithQUFWYWRyaHpMUnl5OE8vTG9yK2I1SE10?=
 =?utf-8?B?MnpKZEtXYUZybGxObmhzOHNzYytjdXVRYWVIellyVHR0TkluclVVNjBxanNi?=
 =?utf-8?B?Y2hMcXNiWDhEY1k5TFpBaHRERy96dDNxMGJ6Q1hrQUNDb2dhaTRiMXNlRWpq?=
 =?utf-8?B?bEhLRUJ5NFBlcTYzc3VVVXc0R2xLaW50M1AxdFY3Tm5BUWtUc3BVWDBrOGFv?=
 =?utf-8?B?dklLQmxKSlNzbVNlbXNvRTFSRVMydnA2NkRBaHBmQUxwdlhmNmhPdE9XbHY0?=
 =?utf-8?B?WllrQVZDbWpGalE0cVk3N2hlU0ZuQkxubUhCbXlxbmpNVEZJYWYyUlNqSWJR?=
 =?utf-8?Q?u7uoXsekFfGSA/LLZagoVsSrOzOu5ieyrhUKyiEfB8ht?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1763EE3A5B0D3B4C88DCBACB38EA70C8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0858ca-702e-4f30-0c8b-08dc32c2049a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:46:46.1644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtU4Bm8bU923yxaRGBCJLKxmrVazJRC7faSjiq6EkhpMFDUmZUIFf3xFvWOl7HayNPiLbeYmxVxDx8gjcs2ZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

T24gMi8yMS8yNCAwMDo0NiwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPg0KPiBPbiAyLzIxLzI0IDAy
OjExLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+IEZyb206IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz4NCj4+DQo+PiBJZiBhIHVzZXIgcnVucyBzb21ldGhpbmcgbGlrZSBgYmxrZGlzY2Fy
ZCAteiAvZGV2L3NkYWAsIGFuZCB0aGUgZGV2aWNlDQo+PiBkb2VzIG5vdCBoYXZlIGFuIGVmZmlj
aWVudCB3cml0ZSB6ZXJvIG9mZmxvYWQsIHRoZSBrZXJuZWwgd2lsbCBkaXNwYXRjaA0KPj4gbG9u
ZyBjaGFpbnMgb2YgYmlvJ3MgdXNpbmcgdGhlIFpFUk9fUEFHRSBmb3IgdGhlIGVudGlyZSBjYXBh
Y2l0eSBvZiB0aGUNCj4+IGRldmljZS4gSWYgdGhlIGNhcGFjaXR5IGlzIHZlcnkgbGFyZ2UsIHRo
aXMgcHJvY2VzcyBjb3VsZCB0YWtlIGEgbG9uZw0KPj4gdGltZSBpbiBhbiB1bmludGVycnVwdGFi
bGUgc3RhdGUsIHdoaWNoIHRoZSB1c2VyIG1heSB3YW50IHRvIGFib3J0Lg0KPj4gQ2hlY2sgYmV0
d2VlbiBiYXRjaGVzIGZvciB0aGUgdXNlcidzIHJlcXVlc3QgdG8ga2lsbCB0aGUgcHJvY2VzcyBz
byB0aGV5DQo+PiBkb24ndCBuZWVkIHRvIHdhaXQgcG90ZW50aWFsbHkgbWFueSBob3Vycy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+PiAt
LS0NCj4+ICAgYmxvY2svYmxrLWxpYi5jIHwgMiArKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1saWIuYyBiL2Jsb2Nr
L2Jsay1saWIuYw0KPj4gaW5kZXggZTU5YzMwNjllODM1MS4uZDVjMzM0YWE5OGUwZCAxMDA2NDQN
Cj4+IC0tLSBhL2Jsb2NrL2Jsay1saWIuYw0KPj4gKysrIGIvYmxvY2svYmxrLWxpYi5jDQo+PiBA
QCAtMTkwLDYgKzE5MCw4IEBAIHN0YXRpYyBpbnQgX19ibGtkZXZfaXNzdWVfemVyb19wYWdlcyhz
dHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LA0KPj4gICAJCQkJYnJlYWs7DQo+PiAgIAkJfQ0KPj4g
ICAJCWNvbmRfcmVzY2hlZCgpOw0KPj4gKwkJaWYgKGZhdGFsX3NpZ25hbF9wZW5kaW5nKGN1cnJl
bnQpKQ0KPj4gKwkJCWJyZWFrOw0KPj4gICAJfQ0KPj4gICANCj4+ICAgCSpiaW9wID0gYmlvOw0K
PiBJIGhhdmUgYW4gTlZNZSBkZXZpY2Ugd2hpY2ggc3VwcG9ydHMgd3JpdGUgb2ZmbG9hZC4gVGhl
IHRvdGFsIHNpemUgb2YgdGhpcyBkaXNrIGlzIH4xLjUgVEIuDQo+IFdoZW4gSSB0cmllZCB6ZXJv
IG91dCB0aGUgd2hvbGUgTlZNZSBkcml2ZSBpdCB0b29rIG1vcmUgdGhhbiAxMCBtaW51dGVzLiBQ
bGVhc2Ugc2VlIGJlbG93Og0KPg0KPiAjIGNhdCAvc3lzL2Jsb2NrL252bWUwbjEvcXVldWUvd3Jp
dGVfemVyb2VzX21heF9ieXRlcw0KPiA4Mzg4NjA4DQo+DQo+ICMgbnZtZSBpZC1ucyAvZGV2L252
bWUwbjEgLUgNCj4gTlZNRSBJZGVudGlmeSBOYW1lc3BhY2UgMToNCj4gbnN6ZSAgICA6IDB4MTc0
OWE5NTYNCj4gbmNhcCAgICA6IDB4MTc0OWE5NTYNCj4gbnVzZSAgICA6IDB4MTc0OWE5NTYNCj4g
PHNuaXA+DQo+IG52bWNhcCAgOiAxNjAwMzIxMzE0ODE2DQo+IDxzbmlwPg0KPiBMQkEgRm9ybWF0
ICAwIDogTWV0YWRhdGEgU2l6ZTogMCAgIGJ5dGVzIC0gRGF0YSBTaXplOiA0MDk2IGJ5dGVzIC0g
UmVsYXRpdmUgUGVyZm9ybWFuY2U6IDAgQmVzdCAoaW4gdXNlKQ0KPiA8c25pcD4NCj4NCj4gIyB0
aW1lIGJsa2Rpc2NhcmQgLXogL2Rldi9udm1lMG4xDQo+DQo+IHJlYWwJMTBtMjcuNTE0cw0KPiB1
c2VyCTBtMC4wMDBzDQo+IHN5cwkwbTAuMzY5cw0KPg0KPiBTbyBzaG91bGRuJ3Qgd2UgbmVlZCB0
byBhZGQgdGhlIHNhbWUgY29kZSAoYWxsb3dpbmcgdXNlciB0byBraWxsIHRoZSBwcm9jZXNzKSB1
bmRlcg0KPiBfX2Jsa2Rldl9pc3N1ZV93cml0ZV96ZXJvZXMoKT8gSSB0aGluayBldmVuIHRob3Vn
aCBhIGRyaXZlIHN1cHBvcnRzICJ3cml0ZSB6ZXJvIG9mZmxvYWQiLCBpZg0KPiBkcml2ZSBoYXMg
YSB2ZXJ5IGxhcmdlIGNhcGFjaXR5IHRoZW4gaXQgd291bGQgdGFrZSB1cCBhIGxvdCBvZiB0aW1l
IHRvIHplcm8gb3V0IHRoZSBjb21wbGV0ZSBkcml2ZS4NCj4gWWVzIHRoZSB0aW1lIHJlcXVpcmVk
IG1heSBub3QgYmUgaW4gaG91cnMgaW4gdGhpcyBjYXNlIGJ1dCBpdCBjb3VsZCBiZSBpbiB0ZW5z
IG9mIG1pbnV0ZXMgZGVwZW5kaW5nDQo+IG9uIHRoZSBkcml2ZSBjYXBhY2l0eS4NCj4NCj4gVGhh
bmtzLA0KPiAtLU5pbGF5DQo+DQo+DQoNCnRoaXMgaXMgbG9uZyBzdGFuZGluZyBwcm9ibGVtIHdp
dGggZGlzY2FyZCBhbmQgd3JpdGUtemVyb2VzLCBpZiB3ZSBhcmUgDQpnb2luZyB0aGlzIHJvdXRl
DQp0aGVuIHdlIG1pZ2h0IGFzIHdlbGwgbWFrZSB0aGlzIGNoYW5nZSBmb3IgcmVzdCBvZiB0aGUg
Y2FsbGVycyBpbiANCmJsay1saWIuYyAuLg0KDQotY2sNCg0KDQo=
