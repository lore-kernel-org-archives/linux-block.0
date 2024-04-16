Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8D12E4A
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237586; cv=fail; b=UNCihuTxHwKsYxSiYWJ94SXvFHk8MAyge2T2o5csRGUaYWIvslQcaj1KnuQyXaN1+XTTGbbVPCWGnhXnKQx4GH7EwYcq6hA77e9hQv32a4H21vTOJFEk9D7x2Ff2EImCxzzlWuD3bEUdR2jZthu1rw/uxfUljIld2gZAdldVikg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237586; c=relaxed/simple;
	bh=6c9Sb+CybXh5YjYLDUkt6nVOErtDT2klGwUIfLDY/tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvenAQ3HQRJXqiKGKUgISZEtDmIWUtuXA1t1dobCktLDosi6VO9uPbnXcXfbFwo8rgIjCMh1+ss2iBpyKpdhtM/xi7BO8ezSPPnUtB6T0FgXzH1uZEuK43AAFg52NqqCy6W3e36tMBdpdWTe+wD//vAHCPxwCApiO/zKlk4Ra2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvZ5k31z; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvZ5k31z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxbjnzVsGwbjfKU2z2zupX6yaVqxovDLqtkOdbnUNHIS8x0wwH19Yp2Clr8KKAQOmaixwGvNIYcqdkWIJQtsYwEoop6KYI5dpDJY3NO9zAvl7mMIfAol93zHkkZS2AD2IRNYSVvgosHo4voyKfu7GFIZLzl17Kt4SK+KpsxgzJB1ipKt3F2bdCiBMHIcV2F+qRT+A+YDKmGpk0nGbSR8RY2/MdBhZFSZTVyBZks8f7Af16bAQTShI6OuGzAaDhqJE7ZyuVLS7tYPOqtbvL+Vejk3oElawHKiPs5DpMUbSbfAanVEZys6WIFPVgSKBjjjINgItCebVBsP7nSJrmue2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c9Sb+CybXh5YjYLDUkt6nVOErtDT2klGwUIfLDY/tw=;
 b=GRnAxu8zvRpebAtabOqCigHB7LvG0zMZniQHhrjTqzIA1v/Cz7SLKtbus1WrMMrKMFaqEzNIWMr/cVM/ht5dZ9eZN9O+e/vo+2ira9sLCeSB7HUiW4NRsgAkAJblJMOomrWWNCtOzAMwf2udM+lIV3rCn7+ZNuwZM06GxkxTzntQx0VHYgQbRGdVn6a3YOcppcNg6/Bi6BSLcRzmU5bajBks1ZxokfFsxn4SoyezBN2h+8od7lI7qZLZ1MqZdrAcoBkxVfzIkpjjmHfhWf6sQOjuJGOlDwnfF28+BBu6XjVhhr5IR74bjoVu1wdZXnNrxJHUK+KuYM7XqYCxoMQW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c9Sb+CybXh5YjYLDUkt6nVOErtDT2klGwUIfLDY/tw=;
 b=OvZ5k31z24DcGGygVpTYs9FIMrPY/Xyz4c4YZP+UR9uZoylS9ZhhNNv0DDp8bOMdS+l0aDt6rth+kXWzFkTzL/cEICHPKS4bGJZWKe707B7bV7MrVMUzDbF3RhChaUL24F/U3NKtvZCkAMoYwDKQtP5MUSWj00Am/SJOT4u1msNts99TJKUxBPmrtdlTRP7YOSsu23t/1ZM0NMdFieNNcSEphJRI9u98/2tP9JC++UlLAZaL5r6ZQB86JstYBObrM7N9klE+90isfg1uKG/TnnpRrdlGlf4G1LR8+UU1XsaxwEmznJL27WVGVgFv+dwNQ+9Q9BxY5NvzcQhAeYNfdQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:19:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:19:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
Thread-Topic: [bug report] kmemleak observed with blktests nvme/tcp
Thread-Index: AQHaiIP8gj2bs0nzVEOV4pZRtwmxmrFqSM+A
Date: Tue, 16 Apr 2024 03:19:41 +0000
Message-ID: <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
References:
 <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
In-Reply-To:
 <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB9179:EE_
x-ms-office365-filtering-correlation-id: 95f73424-e242-4e4e-d354-08dc5dc40e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vzIWiTp3PBY9KqQ4rRAN2HR7k8BzLtkWv9Ko1Wk2ERFKwcttN5NAr0yxEeNWOL/hY4MwULj99nKZxx9rKZgxw935c03XyY5cw1cg7Nx99RnM4MB/OELgyZKLFh64XBCcMEg/13JnKi2RxBu6tf3JiHQlL5iGNifl4aSox6WBPqBzDDDjfon8ELYeg3U8UW+Nmg68+rSn+EEnDJOQOCb29f9en9K5xuQm5lBINlsXm7YGeuGYCFcShvBB+dNMKA52SzoRhrOoCTurrEMRi/xEzYg79kHF7+is+m8KWTDYYqOrh4aSxFMzYoC48ST0AvT7YXrVyuj67IeZMAIbGFuB21ZqGWpNcqYPgYEWAFGmirmiMsPl6774NWWliBMc0k9TwXnCpMnP3hrKjITsklPvbvdtuSKlFr6JifCjvYCF4LCTGy3LgfVPfKFAtMg3xIYk2Y9UGhsEpYQHBAvnwkJth3zn3k7v6WLWnd42CIcfZol5dB7yoOYB10R7UqGQ0HmLBAgLGcJR1UoWxfGvZdkREVBX1atIa1Uc6QSIW8HygjGG7MHJDs7PTpd1vmLc9SAZv4p+MhWIKwHgY+BMlRgqI198pGfK8IB7t5PHX28Ca6gCTjmuXSPXOJrQKTIVR9wJqy7d/wrXr4rPCVFBHgBtc2C8MsZZzJsPvhB/uw0VEVfzQOwRzHiEJRrPW5t6lYBfyWk/Jhq7D/I/hJ2vCaKKRA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW9sak9vOUpFSDBLYURkeUZsRXBSdy82aG1wd2VZN3JRbTMyMUtGaUhBelNT?=
 =?utf-8?B?cmViUzd4N294ZFBHWXdYNlVJeGZEWHNIMlozaVBVSUozQmJ6amg2a0ZNUWJC?=
 =?utf-8?B?YlpkTHNrRHFJbmV2WmFjdVpwTHViTnJROEdjdWpwVGE3VlAzSktaRjk5citH?=
 =?utf-8?B?a2ZIWGdXbWtLWTVaekpmbXlid0J5NXFEQThXcy8xUTN4TGNSWEgvMWJKZ216?=
 =?utf-8?B?dGFEUThtbmtGNzh6STh2dVUyQVkrWkM3YUdWN2hUcHpicE1MV1V5ZDhmaG91?=
 =?utf-8?B?R1pMZHVtTzZIczM3MFd5Q3laSlJFakRGejBmOVZKNEJnVThtOTh4ZW9BVjBR?=
 =?utf-8?B?ajdJWkFtSUNacEY1T0tYQW5RMy9XSnQrVFlVUFZzUXRWY1JEUXlaL05mb0lt?=
 =?utf-8?B?TXpDWTJ3TkloUlBzc1R6d3dlZWtrSFJ3a2JDdkQvd2hPSkhBaHhwR2tGTE5z?=
 =?utf-8?B?TFJHU20wb1crWlcrUzVJNUZTZzk0eVpVZ1A2alhuYjZrcGRzN2xBeHo1VDFv?=
 =?utf-8?B?MFpFSk5mbWd0bUh6bFBTdmZIWWRCbnA3Vzh3WXA4T1gyTE1jbFIvdld0M2hO?=
 =?utf-8?B?OU9UMGp4NUFONkFWZ1pwSXZodVk1YVJQTXJYamcyTGU5a1M0NnIwM1FyeFJj?=
 =?utf-8?B?eThtWEY0NngzV0hkRUxTN3o1dlFPYlBSL1UrREp0VXlVTmpzMnVIdUN5K3N5?=
 =?utf-8?B?L21XR2c0WG51RE1xSVcwQmxZUFZCRjhPNkt2U3BLTWNHOWk1OUcvRFNFZWhW?=
 =?utf-8?B?RkZwcXhBRTFRaXhIZG5aOWthZWcrMlZEb0p3Umh1VWxGMHNTWmtyamFadDEy?=
 =?utf-8?B?NWx4SWJTeWduS2tnOFZvWlE5MTdYWGVRcGsyQWRyOXFIQ3JtaVZsTE1lL2hx?=
 =?utf-8?B?RllUQ2twUDRLaWUwNjg5TUY4bXoyYTkyZG1qd1VJSHJ4S1h6SUdWR3NRS0t6?=
 =?utf-8?B?YnNQVENYUkNTM2NqSDluUXdyaVByTnhhQ3MwNVZSOE1lUFFRcGZiSlovTTFp?=
 =?utf-8?B?c1lQTjlIQkNvbTduWFFlb0MzTyt0ZHNUVEhMelRRY0k3M05PTDVmVm1CUi9E?=
 =?utf-8?B?eGdJQ1RwZGlObzUrUVplTk1HblBPeUtCYjQrUHN1bW1qUldrNUNuSi80VzN6?=
 =?utf-8?B?Ujgwems1TVFqSERFS0p5bHh2RlF0bXBTbmRsNTQ0RFBkS2UzWFFTM0dMNEpV?=
 =?utf-8?B?UGZMVzVQTmpVVFR3ZCsyaFN4SXQ3MVhWeHFVOXlsN2ZRQlFwYVpjUTBVTVBt?=
 =?utf-8?B?TlpQZ2k5eFR2QjZJYUFQL25ZNENUQlh3WTZKWUFocjV6MTRZK1pZNE1yZ3BE?=
 =?utf-8?B?T1JiNVdrbEZOdHRTMEFZbDBERlJ5VTg5eVMzVHdZalNrU1cxMk1Kb0h1elVC?=
 =?utf-8?B?R0s4bmorNkhNcUlBYS9iZU1DdnZqUHJoN1d4VkcvQ1RaOWtkM2RmWmRYYnMz?=
 =?utf-8?B?VFJiekJEUGJSaElTeFR2SmNrNk5aL3hsY3o4eHlCdjRnRS9rOVA0dE05UTNU?=
 =?utf-8?B?ZE16MDB6bXVHTzlwa2hlaEhzYXdwMTNFcmhnbUsxVHNjVVRWd1p5ZWhTSlNC?=
 =?utf-8?B?dGJkd0xReEZ5enRuNTFPZzNPV3E3d1NyZkk1UFRXa09IUGVGZjc0QzZaM25r?=
 =?utf-8?B?ZzVYdzBGcmsyUnZIOWFDVDY5ZDB5WFRTUFBqZVBielVUMDdVQm9YbkcrU3hY?=
 =?utf-8?B?YTdZVGZuNytsTVVKNHlpUEo4Q2VhZXNuajMrTUx0bzJkbzRvTFZ0aTFOWnk3?=
 =?utf-8?B?dlB6OTBWcDZON1Z4djJIVjFCRzNYV1o2eko5Z2VNaitCdWNaNnlHcDlGSEEy?=
 =?utf-8?B?bC8vVjZEdklja3piYUVWZlhTSnY5UjRJbGJrZ2Z2ZG9VMGh5Z1NnSjVGQTZ1?=
 =?utf-8?B?ckNxeGFHM09oeXFJL25BWk81OWFhU0t5SFFFQVhGYlkxVUlycTU0UWNxT0lV?=
 =?utf-8?B?cHZEMm4ySjZnbG9sU3FtQ0JKaFN6NkY3S1pLUGF3K3pYV2pNRksrdWFYNnVn?=
 =?utf-8?B?TlI5YjNpUGJhQ2lVai9LMjlXRE9xc1ovelZyRlpBSFRNZ0YvQWNSQVM1N1Vp?=
 =?utf-8?B?Wm14eG82VEhBNWVCeVo4UnQwbzlORVlWSWs0NmRZRm04STJmVmIxUUQ2ZUh4?=
 =?utf-8?B?aXJrNHROZG5jMHJIN21ZeDg0akhhN3dicmk3S2Y3dGh0WkJlVS95cmVicG5i?=
 =?utf-8?Q?1+bszKw5RXWeHA/4bcDcxdOTMj3Ho3Yt2EKFmMTtGSGs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <125D4F3DD7A4EA41850848EE2953AC92@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f73424-e242-4e4e-d354-08dc5dc40e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:19:41.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAqcKaYippNFvpKnEOrHbXwvpX3isoLF+EbfWRfcd/c7nwpUruyZbI4912Cgf5JoeHAeypTUIMhtj8a/lbvP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

K2xpbnV4LW52bWUgbGlzdCBmb3IgYXdhcmVuZXNzIC4uLg0KDQotY2sNCg0KDQpPbiA0LzYvMjQg
MTc6MzgsIFlpIFpoYW5nIHdyb3RlOg0KPiBIZWxsbw0KPg0KPiBJIGZvdW5kIHRoZSBrbWVtbGVh
ayBpc3N1ZSBhZnRlciBibGt0ZXN0cyBudm1lL3RjcCB0ZXN0cyBvbiB0aGUgbGF0ZXN0DQo+IGxp
bnV4LWJsb2NrL2Zvci1uZXh0LCBwbGVhc2UgaGVscCBjaGVjayBpdCBhbmQgbGV0IG1lIGtub3cg
aWYgeW91IG5lZWQNCj4gYW55IGluZm8vdGVzdGluZyBmb3IgaXQsIHRoYW5rcy4NCg0KaXQgd2ls
bCBoZWxwIG90aGVycyB0byBzcGVjaWZ5IHdoaWNoIHRlc3RjYXNlIHlvdSBhcmUgdXNpbmcgLi4u
DQoNCj4gIyBkbWVzZyB8IGdyZXAga21lbWxlYWsNCj4gWyAyNTgwLjU3MjQ2N10ga21lbWxlYWs6
IDkyIG5ldyBzdXNwZWN0ZWQgbWVtb3J5IGxlYWtzIChzZWUNCj4gL3N5cy9rZXJuZWwvZGVidWcv
a21lbWxlYWspDQo+DQo+ICMgY2F0IGttZW1sZWFrLmxvZw0KPiB1bnJlZmVyZW5jZWQgb2JqZWN0
IDB4ZmZmZjg4ODVhMWFiZTc0MCAoc2l6ZSAzMik6DQo+ICAgIGNvbW0gImt3b3JrZXIvNDA6MUgi
LCBwaWQgNzk5LCBqaWZmaWVzIDQyOTYwNjI5ODYNCj4gICAgaGV4IGR1bXAgKGZpcnN0IDMyIGJ5
dGVzKToNCj4gICAgICBjMiA0YSA0YSAwNCAwMCBlYSBmZiBmZiAwMCAwMCAwMCAwMCAwMCAxMCAw
MCAwMCAgLkpKLi4uLi4uLi4uLi4uLg0KPiAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uDQo+ICAgIGJhY2t0cmFjZSAo
Y3JjIDYzMjhlYWRlKToNCj4gICAgICBbPGZmZmZmZmZmYTdmMjY1N2M+XSBfX2ttYWxsb2MrMHgz
N2MvMHg0ODANCj4gICAgICBbPGZmZmZmZmZmYTg2YTliMWY+XSBzZ2xfYWxsb2Nfb3JkZXIrMHg3
Zi8weDM2MA0KPiAgICAgIFs8ZmZmZmZmZmZjMjYxZjZjNT5dIGxvX3JlYWRfc2ltcGxlKzB4MWQ1
LzB4NWIwIFtsb29wXQ0KPiAgICAgIFs8ZmZmZmZmZmZjMjYyODdlZj5dIDB4ZmZmZmZmZmZjMjYy
ODdlZg0KPiAgICAgIFs8ZmZmZmZmZmZjMjYyYTJjND5dIDB4ZmZmZmZmZmZjMjYyYTJjNA0KPiAg
ICAgIFs8ZmZmZmZmZmZjMjYyYTg4MT5dIDB4ZmZmZmZmZmZjMjYyYTg4MQ0KPiAgICAgIFs8ZmZm
ZmZmZmZhNzZhZGYzYz5dIHByb2Nlc3Nfb25lX3dvcmsrMHg4OWMvMHgxOWYwDQo+ICAgICAgWzxm
ZmZmZmZmZmE3NmIwODEzPl0gd29ya2VyX3RocmVhZCsweDU4My8weGQyMA0KPiAgICAgIFs8ZmZm
ZmZmZmZhNzZjZTJhMz5dIGt0aHJlYWQrMHgyZjMvMHgzZTANCj4gICAgICBbPGZmZmZmZmZmYTc0
YTgwNGQ+XSByZXRfZnJvbV9mb3JrKzB4MmQvMHg3MA0KPiAgICAgIFs8ZmZmZmZmZmZhNzQwNmU0
YT5dIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4
ZmZmZjg4YThiMDM2NDdjMCAoc2l6ZSAxNik6DQo+ICAgIGNvbW0gImt3b3JrZXIvNDA6MUgiLCBw
aWQgNzk5LCBqaWZmaWVzIDQyOTYwNjI5ODYNCj4gICAgaGV4IGR1bXAgKGZpcnN0IDE2IGJ5dGVz
KToNCj4gICAgICBjMCA0YSA0YSAwNCAwMCBlYSBmZiBmZiAwMCAxMCAwMCAwMCAwMCAwMCAwMCAw
MCAgLkpKLi4uLi4uLi4uLi4uLg0KPiAgICBiYWNrdHJhY2UgKGNyYyA4NjBjZTYyYik6DQo+ICAg
ICAgWzxmZmZmZmZmZmE3ZjI2NTdjPl0gX19rbWFsbG9jKzB4MzdjLzB4NDgwDQo+ICAgICAgWzxm
ZmZmZmZmZmMyNjFmODA1Pl0gbG9fcmVhZF9zaW1wbGUrMHgzMTUvMHg1YjAgW2xvb3BdDQo+ICAg
ICAgWzxmZmZmZmZmZmMyNjI4N2VmPl0gMHhmZmZmZmZmZmMyNjI4N2VmDQo+ICAgICAgWzxmZmZm
ZmZmZmMyNjJhMmM0Pl0gMHhmZmZmZmZmZmMyNjJhMmM0DQo+ICAgICAgWzxmZmZmZmZmZmMyNjJh
ODgxPl0gMHhmZmZmZmZmZmMyNjJhODgxDQo+ICAgICAgWzxmZmZmZmZmZmE3NmFkZjNjPl0gcHJv
Y2Vzc19vbmVfd29yaysweDg5Yy8weDE5ZjANCj4gICAgICBbPGZmZmZmZmZmYTc2YjA4MTM+XSB3
b3JrZXJfdGhyZWFkKzB4NTgzLzB4ZDIwDQo+ICAgICAgWzxmZmZmZmZmZmE3NmNlMmEzPl0ga3Ro
cmVhZCsweDJmMy8weDNlMA0KPiAgICAgIFs8ZmZmZmZmZmZhNzRhODA0ZD5dIHJldF9mcm9tX2Zv
cmsrMHgyZC8weDcwDQo+ICAgICAgWzxmZmZmZmZmZmE3NDA2ZTRhPl0gcmV0X2Zyb21fZm9ya19h
c20rMHgxYS8weDMwDQo+DQo+IChnZGIpIGwgKihsb19yZWFkX3NpbXBsZSsweDFkNSkNCj4gMHg2
NmM1IGlzIGluIGxvX3JlYWRfc2ltcGxlIChkcml2ZXJzL2Jsb2NrL2xvb3AuYzoyODQpLg0KPiAy
Nzkgc3RydWN0IGJpb192ZWMgYnZlYzsNCj4gMjgwIHN0cnVjdCByZXFfaXRlcmF0b3IgaXRlcjsN
Cj4gMjgxIHN0cnVjdCBpb3ZfaXRlciBpOw0KPiAyODIgc3NpemVfdCBsZW47DQo+IDI4Mw0KPiAy
ODQgcnFfZm9yX2VhY2hfc2VnbWVudChidmVjLCBycSwgaXRlcikgew0KPiAyODUgaW92X2l0ZXJf
YnZlYygmaSwgSVRFUl9ERVNULCAmYnZlYywgMSwgYnZlYy5idl9sZW4pOw0KPiAyODYgbGVuID0g
dmZzX2l0ZXJfcmVhZChsby0+bG9fYmFja2luZ19maWxlLCAmaSwgJnBvcywgMCk7DQo+IDI4NyBp
ZiAobGVuIDwgMCkNCj4gMjg4IHJldHVybiBsZW47DQo+IChnZGIpIGwgKihsb19yZWFkX3NpbXBs
ZSsweDMxNSkNCj4gMHg2ODA1IGlzIGluIGxvX3JlYWRfc2ltcGxlICguL2luY2x1ZGUvbGludXgv
YmlvLmg6MTIwKS4NCj4gMTE1IGl0ZXItPmJpX3NlY3RvciArPSBieXRlcyA+PiA5Ow0KPiAxMTYN
Cj4gMTE3IGlmIChiaW9fbm9fYWR2YW5jZV9pdGVyKGJpbykpDQo+IDExOCBpdGVyLT5iaV9zaXpl
IC09IGJ5dGVzOw0KPiAxMTkgZWxzZQ0KPiAxMjAgYnZlY19pdGVyX2FkdmFuY2Vfc2luZ2xlKGJp
by0+YmlfaW9fdmVjLCBpdGVyLCBieXRlcyk7DQo+IDEyMSB9DQo+IDEyMg0KPiAxMjMgdm9pZCBf
X2Jpb19hZHZhbmNlKHN0cnVjdCBiaW8gKiwgdW5zaWduZWQgYnl0ZXMpOw0KPiAxMjQNCj4NCj4N
Cg0KLWNrDQoNCg0K
