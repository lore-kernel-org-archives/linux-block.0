Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2060.outbound.protection.partner.outlook.cn [139.219.17.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13B429CE6
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378103; cv=fail; b=Nz+fIlQ1Jvs4hjUvY6KuSPjQG/8eAyABXU/U8VQMDrMED6Y6VISy9XEnwbPlgNnCa+OBBbRfTMx2n2yRK3B+8y78km1TzAPm+MzeqlqABJI3rsSmSeIqT2+9TNLdbtjp227QRdQAJUbzUh1zyCAs7C/H16kflo0mfhyv+Y4Viq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378103; c=relaxed/simple;
	bh=c/5rDpaW+tMcdhxU5TzauE/EpF6hYhqhlVEKpZsobGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lzx8wAtReOHjDOkZTBmVpvhQNdjBGbRr8d9pD+bgbFGaza0IVx1FbddVwc9fH4l5xHAOg3qDC7E/ItI4o2ssOn4DAwzuy6HdVN5pttssr8iKDy7g1qIYBnQ7cB/IJsbEF5k+dJ9etA7EUsnWRklhDczrNXI4yAjWVBqb0G3o4Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xiaohongshu.com; spf=pass smtp.mailfrom=xiaohongshu.com; dkim=pass (1024-bit key) header.d=xiaohongshu.com header.i=@xiaohongshu.com header.b=QFjdHMbS; arc=fail smtp.client-ip=139.219.17.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xiaohongshu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaohongshu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaohongshu.com header.i=@xiaohongshu.com header.b="QFjdHMbS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esBAqifp+68XA/V2CzOVrtTod0lClrh1UkElcWkHJSQrA5dGsUC+sFK2ijHw+/rup1zJnQ8drs/fEM7J4dPNZgb0wU+JNYdr1cVAjxgSXJXILU/4aLshyw8QdLzPAL8YvEYQg1YuGdrGiit2+UI+/7DxrssREXrohW0zADt+xWNOLoCbrXpD2S9gB+CFyxtKCuGP7gNSkgGJCFCqwJr2ZOo2VPMt7w0krWFfRR2aGy7jVtpZzxQlKMr5d/ccsatQzrXBSHiIMIhUt/5eq5SAKhLfli1dP64//6u9J/S4QUx0wo0Prb+KdBC3HhUcyyCrohkXPr9hguIN+Y/7r9ObNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/5rDpaW+tMcdhxU5TzauE/EpF6hYhqhlVEKpZsobGU=;
 b=ZA3ztiZIT13UNOlvCGwwhdLZTNdKdWT0nZr0jPU1xyL/kyFz9Ghgr6EqPdjp65fAy4OuBL7aeeHdit/5f4YTe/WwrbWJyzZqrvFNd3FB3QrFcq4OTHmZy8paWXcDgb2fMYnidbmZpZstWqJueW7mfJvGJ0xCtGELb5t894Nfed/CHVVaajBRGTDQrcKCimWnemB5V7itKzUw4HFxhVhhCwAuqavfhMmVRyJFBxpDvsIYKABCaeD9diwIWbKhp73QKoJVxe8ijpHD47w06gwwnfUzZxMG8CVBNGwiiBRziU/iJZRm3rJmzVUZjZMoMthR0E2YkPv8644hrBQPP61DfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiaohongshu.com; dmarc=pass action=none
 header.from=xiaohongshu.com; dkim=pass header.d=xiaohongshu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiaohongshu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/5rDpaW+tMcdhxU5TzauE/EpF6hYhqhlVEKpZsobGU=;
 b=QFjdHMbSeLA7lfqawe0J0kCM+poBS9x4K0BAz5IFIlVMbFgPh4ejwmpo+WCe0gjvWmuwwGZgh8gOvogv1qMY1JxVm+uZ5GS2cBgLYGe2gaiy1kmZmLVvXtN7Auv36oa2xUspQBBmk6B55Htciwcu1oaDFktWVKBAk1J4xRaHiEg=
Received: from ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::10) by ZQ4PR01MB1153.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:52:54 +0000
Received: from ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
 ([fe80::5f8a:2bc2:c1c4:37be]) by
 ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn ([fe80::5f8a:2bc2:c1c4:37be%5])
 with mapi id 15.21.0406.007; Mon, 14 Sep 2026 02:52:54 +0000
From: =?utf-8?B?6L+q5Y2XKOmprOaMr+WFiCk=?= <mazhenxian@xiaohongshu.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Christoph Hellwig <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "mzx199711@gmail.com" <mzx199711@gmail.com>
Subject:
 =?utf-8?B?UmU6IDzlpJbpg6jpgq7ku7Y+W1BBVENIIHYyIDAvMl0gYmxvY2s6IGF2b2lk?=
 =?utf-8?Q?_redundant_flushes_for_O=5FDSYNC_direct_writes?=
Thread-Topic:
 =?utf-8?B?POWklumDqOmCruS7tj5bUEFUQ0ggdjIgMC8yXSBibG9jazogYXZvaWQgcmVk?=
 =?utf-8?Q?undant_flushes_for_O=5FDSYNC_direct_writes?=
Thread-Index: AQHdLJVyrQ9WpaeVbk2biFDXFTw9AbbNjw+A
Date: Mon, 14 Sep 2026 02:52:54 +0000
Message-ID: <A64CDD09-0DE5-4D39-A3E6-DD4F7192E5E1@xiaohongshu.com>
References: <20260812130335.60354-1-mzx199711@gmail.com>
 <cover.1786782832.git.mzx199711@gmail.com>
In-Reply-To: <cover.1786782832.git.mzx199711@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiaohongshu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1268:EE_|ZQ4PR01MB1153:EE_
x-ms-office365-filtering-correlation-id: d96fa062-c297-41f4-7fe5-08df120b4643
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|42112799006|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info:
 ZS1spTqtSmpia/+jhnZjLwDT6eddJXSyrfZzAJjM45MTNc8Ll9gcW+DO0f1t/TE+xlv6JItzEx7Hl0DO4EHQ5xLtUpzs9CCamxSacx3KkcLUDhJ3Y/Qta0Tdr1KPGuYjtDPWZV0cNhKYbMNEiEhOfsDzvLP8mE8uCQFLkWQKjwFsoXdrnidvHaKUe/gKIlZWEY8IT8SCQH7s+yzE514ezRGwvHLROoTGMdjcBSkX4jNP1tyeK8eKuoEZtrI+EDNzqBa81x3+EWCG+lHz4P/GqBpS9oi6T7TAmr/8ZmfEyrYFHa9EqJQTBSkqTpRbbVofTALEY7Yp37Nyuw/qlTttZTKNoxX2xE/7xZ7veveHzlry1swICaHM89gXIJotk5JA+xwMwJzPszOmM+rrTngDDaZlkFuq1W4oyylJpYkmT6LXjoLLYsPShaIVsK099QTd8RQzjvgwN1oYRCgbDo1GC3jTh7Xglg+qshdteLE73bRfFMBXQbGi9Qj+UTEsTDTME5qo+bAtanN92ZnJy8QcgeC3FVb7U562DVbx5m3aqgDVtZzRpWVEX4/jnGysBR13
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(42112799006)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzRsMytEVytrMzR6QlI0SEpsWTV3RXU4QlFHVzg5MWNQRm5BRFB0RDFSVStm?=
 =?utf-8?B?U3VvdnZycWVIRmwwcVZJaFMvdVg2RDNsUjdqMVprMWdFditFOTh0ZWV3Y2RW?=
 =?utf-8?B?V0ZDR0xFL1dYQXJteldTUjJXZ0dNSGpndi94aldsTTBSM3NoQ2ZqbWYwWFc2?=
 =?utf-8?B?aHRobXRmejNHSC9CMVRPbWdoeTIvbXduUnhtRzAreVlwcmVaQ2tuV253RHZO?=
 =?utf-8?B?RjV4Zk8zaGZFRGRjSnhteHg3MVNaL2xwT2VOYVRJTXU5WHRXMnY5OXQ1QVlJ?=
 =?utf-8?B?dzllUm5FY1ZSNk92WDh1bU1lRkExREk1Ri9seGs3RW1ycVhZdHdId3F2N09L?=
 =?utf-8?B?QWMzUkpvLy9yRjRuSDdZRDViSVpBWWUxRmltV2JtZnVkTVJ0eGdXZjFEUWx4?=
 =?utf-8?B?ekF2dk1GelNUOTBNLzBmZzY0WFlXWlIzWjhhYUYwSWhXV3ZlRVpOTUN6S0h0?=
 =?utf-8?B?anRqR3o0aUkwSWdqMnRuMm82aFIwL0RBWmpJUjVKbGtmZGZwQVZLWXZlNS9W?=
 =?utf-8?B?NzhTZU1qWDV2WTBGdWovMENIUjEzQlZneTFSc2Ftc0NJbFNveWU2K253Sll1?=
 =?utf-8?B?akdEM25MNHc3allWdXpxeG5kbjg3cFpOa0pOaWhGS2FHWENvdHVoTDFZZGw0?=
 =?utf-8?B?dC85TXRKZlpFOFlnVHNMRjR5MDIraitjaFl6VFF1bGU1S1RTUUNYTUV5dTNk?=
 =?utf-8?B?QitMdU9ydGRWVm5qNDF6bzhLbWFLZURyemswVndaVFNvZmtiT2EyTkxOYXly?=
 =?utf-8?B?NGt5SjRFQW5TZmRTVEpKYWJtT0lYaWN4RlMvV1BPWUo3dzU0U2NmeThxSzBx?=
 =?utf-8?B?MW4vaE5EYXoraWlwZ1E2ZVhnRjM0SmhtL3UzdjN6N0xZTkU3NDJIVUIrTnA4?=
 =?utf-8?B?Y3RJa0JWMTVWemd2bVpUUE11RWppalhLWSs5NUpDM3ZnQ1F1Yk1zbDdQQkFO?=
 =?utf-8?B?NGNUeHNIeGFOV1U1cVphR2dtdUpEVktZU285OW5FdGxYSmd5VStQTGd1ZXFn?=
 =?utf-8?B?QUVzaUsyN1NCR05RZFdtcUhUZ3FVb3F1b2NDaXN5NkpRTlBYNUdNSFp5TU0z?=
 =?utf-8?B?c01BSVFDRVJuMDh3aEEwRm5XSVVyZ094T0dNTExPUlBJRDI5MnMyS1l1WURH?=
 =?utf-8?B?UDYwUG8va04xanFLM2JTczZjQXUzdzRYc0NvZ043Q3ZuOGR6UXNaQWZ4N0VG?=
 =?utf-8?B?M3VDVGxVN1huU3hwSGpmNnduYU5raUJUWTJDUWhuN3pDS2Rxa24rSkduLy8x?=
 =?utf-8?B?MDFiSDlJSTd6ekM4S1JGM1VHRmlSSVNSSTNmWS9KbEt2cFhXcytsRnk5Njc1?=
 =?utf-8?B?MCtsZ1J6R3U4OVI0NzJZREk2NXpnc01nYmsrY2QrS1g1QjJDckIvdjB4WWNl?=
 =?utf-8?B?U1BnbnBXV3NKSjJRa1ZvYk9OUGduQmk5VGh3eFpXYms1YTRDV2MyaG5FV2xk?=
 =?utf-8?B?bXFUdjBMMGtwS00rY3dHVmZhc3c1SCtWNkk4Wk5lcFEyUk5DZGduT3BOaGJn?=
 =?utf-8?B?M05FVWlUNERBT0hwVTc2dHBYNnFEZzFwdHBacS9DV3pvM0o3R3NKdGxGVTN0?=
 =?utf-8?B?S0wrOERoNDYzRlRHSnBTdUI3Ry9kZVY4Q2RSZWhHN1NyWnAwaGpFbkpWa0pl?=
 =?utf-8?B?YTlnZStlb3A2TE1xYVFSYXpuY1Nsd1lFNGw4NG5aQzdVbndZZnJhZlN4V0ZG?=
 =?utf-8?B?bGZlZjZVRUlYYlB0Si9nemd3Tkptenp6cFc2eDBUcytLUlZJQ2JsK3loVUxk?=
 =?utf-8?B?WWVtRlBjSFd4RlNweFdxSlVoYitoWTM5NE13R2gwOTY4VnY4YmpTRkpSRXRN?=
 =?utf-8?B?NWZPbDhnSGd0Z2RjcG1PM0xjR2ZQbjNVd2tzSzN4SVR3QUIzcXdvSjJNU2p0?=
 =?utf-8?B?MVRRbmQrd1E0U21FMk9nVGRJeld2cTN1Q0tsV2I1UVR3VllvdGU0T1FXeVNo?=
 =?utf-8?B?UnJLc3dXOUwycjlScEcydkE1bGhVT0UwaUN3ckF0TmxQdjNFZUtSN3BVcUlK?=
 =?utf-8?B?UXdiMnhWdWd0cmgzRFNMSzBkZkIxODlyTjRmdmNEa0dmZnVndjFGQ0RzbHg5?=
 =?utf-8?B?cXZNUlRyc291RDg0bnJBOU5sTTVtUnF1RXJTQWI5b1d0NG1qOXFaTTM4MnBj?=
 =?utf-8?B?aFhiaUtmRTkxTDY1SGpDdmduTkhsbjJUVk8xZHFqZ0tueTRMSDlDUytoMTRw?=
 =?utf-8?B?RnBCQlQ3RmJvN09aZkQ3ZFhtaVZIMldtcy9PbEZxTDFYWm1hR1JXclR6M1BW?=
 =?utf-8?B?NlFXUVFtYWcxU1NZWm50WjAyYjh6eC81eXNyZTNQQ3hXS2tsTm9ZeEF3YzRi?=
 =?utf-8?B?WjBCYmlhUTZ1UnlqZlNVSUxGR0tTK2F0b0EzajdRMTNBZVE5RHZVZlF2RW40?=
 =?utf-8?Q?MS1FF6yX5fEjLqrY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C21A3E2564204A96A802B2C33369F7@CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: xiaohongshu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d96fa062-c297-41f4-7fe5-08df120b4643
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 02:52:54.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aba30157-ad44-4a7e-8444-62a12bc39d9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd724MOq+/5tkNADBh01vjPXgAJ24snhZkKXHJrn3NG28Hf9xdqw/IY05KtOmrL6OKYKjbTQ4cL1p75cm3CYzFCMKNKQkWoIOohnp5PJ/Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1153

SGkgSmVucywNCg0KR2VudGxlIHBpbmcsIGJvdGggcGF0Y2hlcyBoYXZlIGJlZW4gcmV2aWV3ZWQg
YnkgQ2hyaXN0b3BoIEhlbGx3aWcuDQoNCkhhcHB5IHRvIHJlYmFzZSBpZiB0aGF0IGhlbHBzLg0K
DQpUaGFua3MsDQpaaGVueGlhbg0KDQo+IDIwMjblubQ45pyIMTXml6UgMTc6MDbvvIxaaGVueGlh
biBNYSA8bXp4MTk5NzExQGdtYWlsLmNvbT4g5YaZ6YGT77yaDQo+DQo+IFRoaXMgc2VyaWVzIHJl
bW92ZXMgcmVkdW5kYW50IGNhY2hlIGZsdXNoZXMgb24gdGhlIE9fRElSRUNUIHwgT19EU1lOQw0K
PiB3cml0ZSBwYXRoIHRvIGEgYmxvY2sgZGV2aWNlLCBmb2xsb3dpbmcgQ2hyaXN0b3BoJ3MgcmV2
aWV3IG9mIHYxLg0KPg0KPiAgUGF0Y2ggMSBza2lwcyBnZW5lcmljX3dyaXRlX3N5bmMoKSB3aGVu
IHRoZSBkaXJlY3Qgd3JpdGUgd2FzIGFscmVhZHkNCj4gIG1hZGUgZHVyYWJsZSBieSBSRVFfRlVB
Lg0KPg0KPiAgUGF0Y2ggMiBzdG9wcyBzZXR0aW5nIFJFUV9GVUEgb24gc3luY2hyb25vdXMgT19E
U1lOQyBkaXJlY3Qgd3JpdGVzIHRvDQo+ICBkZXZpY2VzIHdpdGhvdXQgRlVBIHN1cHBvcnQsIHJl
bHlpbmcgb24gZ2VuZXJpY193cml0ZV9zeW5jKCkgaW5zdGVhZA0KPiAgYW5kIGF2b2lkaW5nIHBl
ci1iaW8gUE9TVEZMVVNIIGVtdWxhdGlvbi4gIEFzeW5jaHJvbm91cyB3cml0ZXMga2VlcA0KPiAg
UkVRX0ZVQSwgc2luY2UgdGhleSBjYW5ub3QgZmFsbCBiYWNrIHRvIGdlbmVyaWNfd3JpdGVfc3lu
YygpLg0KPg0KPiBDaGFuZ2VzIHNpbmNlIHYxDQo+IFtodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1ibG9jay8yMDI2MDgxMjEzMDMzNS42MDM1NC0xLW16eDE5OTcxMUBnbWFpbC5jb20vXToN
Cj4NCj4gIC0gU3BsaXQgaW50byB0d28gcGF0Y2hlcyBwZXIgQ2hyaXN0b3BoJ3Mgc3VnZ2VzdGlv
bi4NCj4gIC0gUGF0Y2ggMSB0cmFja3MgbmVlZF9zeW5jIChkZWZhdWx0IGZhbHNlKSBpbnN0ZWFk
IG9mIGRpb19mdWFfZG9uZS4NCj4gIC0gQWRkZWQgUGF0Y2ggMiBmb3IgdGhlIG5vLUZVQSBjYXNl
OyBhc3luY2hyb25vdXMgc3VibWl0dGVycyBzdGF5IGF0DQo+ICAgIHBhcml0eSB3aXRoIG1haW5s
aW5lLg0KPg0KPiBUZXN0ZWQgb24gTGludXggNy4yLjAtcmM3IHdpdGggYSBTZWFnYXRlIFNUMjAw
MDBOTTAwN0QgKGZ1YT0xKSwgNCBLaUINCj4gT19EU1lOQyBkaXJlY3Qgd3JpdGVzLCBtYWlubGlu
ZSB2cyB0aGlzIHNlcmllczoNCj4NCj4gIFNlcXVlbnRpYWw6IDExOS43IC0+IDc0OTcuMCBJT1BT
DQo+ICBSYW5kb206ICAgICAxNTYuMSAtPiAgNjY2LjQgSU9QUw0KPg0KPiBPbiBhIGxvb3AgZGV2
aWNlIHdpdGhvdXQgRlVBIHRoZXJlIHdhcyBubyByZWdyZXNzaW9uLCBhbmQgYXN5bmMNCj4gT19E
U1lOQyBkaXJlY3Qgd3JpdGVzIHdlcmUgdmVyaWZpZWQgZHVyYWJsZSB3aXRoIGZpbyB2ZXJpZnk9
Y3JjMzJjDQo+ICgyNjIxNDQgSU9zLCBubyBlcnJvcnMpLg0KPg0KPiBaaGVueGlhbiBNYSAoMik6
DQo+ICBibG9jazogc2tpcCByZWR1bmRhbnQgZmx1c2ggZm9yIE9fRFNZTkMgZGlyZWN0IHdyaXRl
cw0KPiAgYmxvY2s6IG9ubHkgdXNlIFJFUV9GVUEgZm9yIGRpcmVjdCB3cml0ZXMgaWYgdGhlIGRl
dmljZSBzdXBwb3J0cyBpdA0KPg0KPiBibG9jay9mb3BzLmMgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjQzLjUNCj4NCg0KDQrmnKzpgq7ku7bl
j4rlhbbpmYTku7blkKvmnInlsI/nuqLkuablhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDk
uo7lj5HpgIHnu5nku6XkuIrmlLbku7bkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bk
urrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jl
iIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/j
gILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7k
u7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIENClRoaXMgZW1haWwgc2hvdWxk
IGJlIGFjY2Vzc2libGUgb25seSB0byB0aGUgcmVjaXBpZW50cyBhbmQgZ3JvdXBzIG1lbnRpb25l
ZCBhYm92ZSBmb3IgdGhlIHByaXZpbGVnZWQgYW5kIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBp
biBpdCBjb25jZXJuaW5nIFhpYW9ob25nc2h1LiBUaGUgdXRpbGl6YXRpb24gb2YgYW55IGluZm9y
bWF0aW9uIGluIGl0IChpbmNsdWRlcyBidXQgaXMgbm90IGxpbWl0ZWQgdG8gbGVhaywgY29weSwg
b3IgdHJhbnNmZXIgcGFydHMgb2Ygb3IgdGhlIHdob2xlIGVtYWlsIGNvbnRlbnQpIGJ5IGFueW9u
ZSBvdXRzaWRlIHRoZSBwZXJtaXR0ZWQgZ3JvdXAgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2Vp
dmUgaXQgYnkgbWlzdGFrZSwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIGNhbGwg
b3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0aGUgbWVzc2FnZS4gVGhhbmsgeW91Lg0K
