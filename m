Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40062 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeJRXbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Oct 2018 19:31:46 -0400
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: RE: [PATCH] block: Make write_hints[] big enough
Date: Thu, 18 Oct 2018 15:30:13 +0000
Message-ID: <SN6PR04MB49250FD0D86034147B72DB66FCF80@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1539795081-2394-1-git-send-email-avri.altman@wdc.com>
 <28ec8613-09c2-b82d-48da-7750e8ff144c@kernel.dk>
In-Reply-To: <28ec8613-09c2-b82d-48da-7750e8ff144c@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE4LCAyMDE4IDU6MzggUE0NCj4g
VG86IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3ZGMuY29tPjsgbGludXgtYmxvY2tAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBBdmkgU2hjaGlzbG93c2tpIDxBdmkuU2hjaGlzbG93c2tpQHdkYy5j
b20+OyBBbGV4IExlbWJlcmcNCj4gPEFsZXguTGVtYmVyZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBibG9jazogTWFrZSB3cml0ZV9oaW50c1tdIGJpZyBlbm91Z2gNCj4gDQo+IE9u
IDEwLzE3LzE4IDEwOjUxIEFNLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBKdXN0IHN0dW1ibGVk
IG92ZXIgdGhpcy4NCj4gPiBMb29rcyBsaWtlIHRoZSB3cml0ZSBoaW50cyBhcnJheSBpbiB0aGUg
cmVxdWVzdCBxdWV1ZSBpcyBub3QgYWxsb3R0ZWQNCj4gPiB3aXRoIHRoZSByZXF1aXJlZCBzcGFj
ZSB0byBhY2NvbW1vZGF0ZSBhbGwgdGhlIHdyaXRlIGhpbnQgdHlwZXMuDQo+ID4NCj4gPiBmaXhl
czogZjc5M2RmZDNmMzlhIChibGstbXE6IGV4cG9zZSB3cml0ZSBoaW50cyB0aHJvdWdoIGRlYnVn
ZnMpDQo+IA0KPiBZb3VyIGNvbW1pdCBtZXNzYWdlIGRvZXNuJ3QgcmVhbGx5IGV4cGxhaW4gd2hh
dCB5b3UgdGhpbmsgdGhlIGlzc3VlDQo+IGlzLiBXZSBoYXZlIDQgd3JpdGUgaGludCB0eXBlcywg
d2l0aCBhIGZpZnRoIGJlaW5nICJub25lIi4gV2hlcmUNCj4gYXJlIHdlIGV4Y2VlZGluZyB0aGVz
ZSA1IGhpbnRzPw0KV1JJVEVfTElGRV9FWFRSRU1FID0gUldIX1dSSVRFX0xJRkVfRVhUUkVNRSA9
IDUsDQp3aWxsIGJlIGlnbm9yZWQgYnkgcXVldWVfd3JpdGVfaGludF97c2hvd19zdG9yZX0uDQoN
ClRoYW5rcywNCkF2cmkNCg0KPiANCj4gLS0NCj4gSmVucyBBeGJvZQ0KDQo=
