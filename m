Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C584C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33DF206F0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="nlXWBSZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfK0RRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:17:43 -0500
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:60672
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbfK0RRm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 12:17:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJRxdnpLHQ/yrIqIY/oQrVhg7ZIszH+/yINQP3zOEfa8YRrgTQXko4FqBiEw0JUVuii/P5TfFGpP0HElfMAVCLBP09nqwm7ZDIh9/bcfJP5+fDAtekjRnMG62fQtBqEYz10xGbMK+w4zrYGo0pwp0J6976hFVOUracXhU4Ei1S41lpJ21SGP6FRNDZL+akiQ14AVecbyngKa/ngal80R3RW2dMH4YOcGIHKhORouc9LHt8E9O8caHCSSccBxfauMRqGUIK7IaADV028OZDprD6yf6Ff69obi+DpXPLk34NqpDz+C4l1iHiBmF8dneK+4yoM6D5F0813XOqsocapUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLY/O4bRqda86JlCUwIaakfQjvrWOgtj5xau4jwvjZs=;
 b=KgzBi1MWH6n5rTpBIhHaJEH9Dk97gC51mYqJZ/p/HomXago05WkwqEJHxuvCtH5vA8c6Fl9T7UwFkKflePbOBUlq0mwKwXf6laxLbjy3qAfJ6O1ACmrS9J7QwJx9FzpWKA5YvnOdLYyV4LV876QQL5SUBUBVHrWgO0N515taixceSbfYDFRHwcNkpIuxTHOKeqXFbq65zLJM2Mv5FYlPulwSeKP6wVGOAAE+c29MV2X/FSXY72mYr28ueKfKB7791ZZLVkeywmHwz05X0Ypq/EsLAyBAWBUaU2vrbPLNVvfEdgM2VeHU9s4EhoM21jyAyP0qusiSdE6A/9DmX2Wolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLY/O4bRqda86JlCUwIaakfQjvrWOgtj5xau4jwvjZs=;
 b=nlXWBSZUMj785FViGHFEZyUddPHFKZcCZBS9j0901OAQGEhnJngB/khrANeph59vY4kpLqDeZ7VGrYEtfEjPdETMAEjKRpJkqYzqnGNTmjotMjE+enZAaRX5ba2DZOMv3zKfdLG90oQIyRrL19oEQHArdtwRw3XDd8IefR7sXx8=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5682.namprd06.prod.outlook.com (20.179.136.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 17:17:40 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 17:17:40 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Meneghini, John" <John.Meneghini@netapp.com>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAHegCAAUsegA==
Date:   Wed, 27 Nov 2019 17:17:40 +0000
Message-ID: <FDC2072C-CC27-444F-8CCA-863E932666FC@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
In-Reply-To: <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3db49191-7b3b-4bd4-d80a-08d7735db52e
x-ms-traffictypediagnostic: BN8PR06MB5682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB568248A45E9DDA73878CA09EE4440@BN8PR06MB5682.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(66446008)(14454004)(66476007)(26005)(66946007)(91956017)(8676002)(76116006)(478600001)(58126008)(81166006)(8936002)(71190400001)(66066001)(76176011)(6506007)(33656002)(2616005)(64756008)(256004)(71200400001)(14444005)(7736002)(229853002)(53546011)(305945005)(66556008)(11346002)(446003)(25786009)(99286004)(2906002)(102836004)(186003)(6486002)(3846002)(6436002)(54906003)(110136005)(6246003)(86362001)(316002)(36756003)(107886003)(5660300002)(6116002)(4326008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5682;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y01+ytJ6ciT5jZAemeMBLs+vCbOK+4OHy0vm7daYG7R1qfcsdhIVp+dWr3Qu6wKvz0ZVdDWgPOoJf9K1nUBjV16e7qI94I/J2Rp36eOgDv9jTOzj8ayGwLBJV0DyXKYmUPuZIB8/XPtzBWTHRSUNvUDPlpQ7fr4XDsMpysQr5d46cl+fbW6jprlOUG0iNNEu9GGSfc/dwoBsKkuR54vTv1Ssr+gZo/UdrFYGeUhC4FxLdDP95tY39mGgXxoK/pdBFHpSHgCGK+XmPZxTx1iUIm0nG93KlGFDH1OkQ/I1jGFbf+omuKyAUqhH/Hm9Jy66jjKjjcgW0gTx3F/JWUpV12/fk2QisJSx+bEEz7DPbC6uJlm5f4oArF4cn8DPMmmYQ0vHw22SFI4hv3MfxcIw9aKlXKG0EP8f7rxpzb9lp25yKc6NeUYi34bPlGiIhy6b
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC2CB1CCF146DB48B1AA8254B3B758C4@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db49191-7b3b-4bd4-d80a-08d7735db52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 17:17:40.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFYWYS119xsf7lCaomPrUQaHrh2u4mTptPTw7r6zjjjx4Ffy1QzlKmt4vlcBnxzlq3oaBuGW8LwfMmJxwJCDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5682
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjYvMTksIDExOjMyIEFNLCAiSGFubmVzIFJlaW5lY2tlIiA8aGFyZUBzdXNlLmRlPiB3
cm90ZToNCiAgICBPbiAxMS8yNi8xOSA1OjA1IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToNCiAgICA+
IFtjYydpbmcgbGludXgtYmxvY2ssIEplbnNdDQogICAgPg0KICAgID4gT24gVHVlLCBOb3YgMjYs
IDIwMTkgYXQgMDI6MzY6NTBQTSArMDEwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KICAgID4+
IFRoaXMgcGF0Y2ggZml4ZXMgYSBidWcgaW4gbnZtZV9jb21wbGV0ZV9ycSBsb2dpYyBpbnRyb2R1
Y2VkIGJ5DQogICAgPj4gRW5oYW5jZWQgQ29tbWFuZCBSZXRyeSBjb2RlLiBBY2NvcmRpbmcgdG8g
VFAtNDAzMyB0aGUgY29udHJvbGxlcg0KICAgID4+IG9ubHkgc2V0cyBDRFIgd2hlbiB0aGUgQ29t
bWFuZCBJbnRlcnJ1cHRlZCBzdGF0dXMgaXMgcmV0dXJuZWQuDQogICAgPj4gVGhlIGN1cnJlbnQg
Y29kZSBpbnRlcnByZXRzIENvbW1hbmQgSW50ZXJydXB0ZWQgc3RhdHVzIGFzIGENCiAgICA+PiBC
TEtfU1RTX0lPRVJSLCB3aGljaCByZXN1bHRzIGluIGEgY29udHJvbGxlciByZXNldCBpZg0KICAg
ID4+IFJFUV9OVk1FX01QQVRIIGlzIHNldC4NCiAgICA+DQogICAgPiBJIHNlZSB0aGF0IENvbW1h
bmQgSW50ZXJydXB0ZWQgc3RhdHVzIHJlcXVpcmVzIEFDUkUgZW5hYmxlZCwgYnV0IEkgZG9uJ3QN
CiAgICA+IHNlZSB0aGUgVFAgc2F5aW5nIHRoYXQgdGhlIENRRSBDUkQgZmllbGRzIGFyZSB1c2Vk
IG9ubHkgd2l0aCB0aGF0IHN0YXR1cw0KICAgID4gY29kZS4gSSdtIHByZXR0eSBzdXJlIEkndmUg
c2VlbiBpdCB1c2VkIGZvciBOYW1lc3BhY2UgTm90IFJlYWR5IHN0YXR1cw0KICAgID4gYXMgd2Vs
bC4gVGhhdCB3b3VsZCBhbHNvIGZhaWwgTVBBVEggZm9yIHRoZSBzYW1lIHJlYXNvbiBhcyB0aGlz
IG5ldw0KICAgID4gc3RhdHVzLi4uDQogICAgPg0KDQogICAgPiBObywgdHJ1ZSwgQ1JEIGlzIG5v
dCBkaXJlY3RseSByZWxhdGVkIHRvICdjb21tYW5kIGludGVycnVwdGVkJy4NCiAgICA+IEFjY29y
ZGluZyB0byB0aGUgcG93ZXJzIHRoYXQgYmUgQ1JEIGV2YWx1YXRpb24gaXMgZGVwZW5kaW5nIG9u
IHRoZSBBQ1JFDQogICAgPiBzZXR0aW5nIChhbmQgaGVuY2Ugc2hvdWxkIGJlIGV2YWx1YXRlZCB3
aGVuZXZlciBhIGNvbW1hbmQgbmVlZHMgdG8gYmUNCiAgICA+IHJldHJpZWQpLCBidXQgJ2NvbW1h
bmQgaW50ZXJydXB0ZWQnIHdpbGwgb25seSBiZSByZXR1cm5lZCBpZiBBQ1JFIGlzDQogICAgPiBl
bmFibGVkLg0KDQpZZXMsIHdlIGhhZCBhIGxvbmcgZGViYXRlIGFib3V0IHRoaXMgd2l0aCBGcmVk
LiAgQ1JEIGRvZXMgbm90IHJlcXVpcmUgdGhlIENvbW1hbmQNCkludGVycnVwdGVkIHN0YXR1cywg
YnV0IENvbW1hbmQgSW50ZXJydXB0ZWQgcmVxdWlyZXMgQ1JELg0KDQogICA+IENvbnNlcXVlbnRs
eSwgd2hlbmV2ZXIgeW91IGdldCBhICdjb21tYW5kIGludGVycnVwdGVkJyB5b3UgbmVlZCB0byBj
aGVjaw0KICAgPiB0aGUgQ1JEIHNldHRpbmcgdG8gZmlndXJlIG91dCB0aGUgZGVsYXkuDQoNCldo
ZW5ldmVyIF9hbnlfIENRRSBzZXRzIENSRCBhbmQgY2xlYXJzIEROUiB0aGUgaG9zdCBpcyByZXF1
aXJlZCB0byBpbXBsZW1lbnQNCnRoZSBkZWxheS4gIFRoZSByZXF1aXJlbWVudCBpcyBvbiB0aGUg
Y29udHJvbGxlciB0byBhbHdheXMgc2V0IENSRCB3aGVuIENvbW1hbmQNCkludGVycnVwdGVkIHN0
YXR1cyBpcyByZXR1cm5lZC4NCg0KQWxzbywgdGhlIGhvc3QgaXMgcmVxdWlyZWQgdG8gaGFuZGxl
IENvbW1hbmQgSW50ZXJydXB0ZWQgaWYgaXQgZW5hYmxlcyBBQ1JFLg0KDQpCdXQgdGhlbiB0aGF0
J3MgdGhlIGJ1Zy4uLi4NCg0KICAgID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCiAgICA+PiBpbmRleCAxMDhmNjBiNDY4
MDQuLjc1MmE0MGRhZjJiMyAxMDA2NDQNCiAgICA+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMNCiAgICA+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCiAgICA+PiBAQCAt
MjAxLDYgKzIwMSw4IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9lcnJvcl9zdGF0dXModTE2
IHN0YXR1cykNCiAgICA+PiAgICAgIHN3aXRjaCAoc3RhdHVzICYgMHg3ZmYpIHsNCiAgICA+PiAg
ICAgIGNhc2UgTlZNRV9TQ19TVUNDRVNTOg0KICAgID4+ICAgICAgICAgICAgICByZXR1cm4gQkxL
X1NUU19PSzsNCiAgICA+PiArICAgIGNhc2UgTlZNRV9TQ19DT01NQU5EX0lOVEVSUlVQVEVEOg0K
ICAgID4+ICsgICAgICAgICAgICByZXR1cm4gQkxLX1NUU19SRVNPVVJDRTsNCiAgICA+PiAgICAg
IGNhc2UgTlZNRV9TQ19DQVBfRVhDRUVERUQ6DQogICAgPj4gICAgICAgICAgICAgIHJldHVybiBC
TEtfU1RTX05PU1BDOw0KICAgID4+ICAgICAgY2FzZSBOVk1FX1NDX0xCQV9SQU5HRToNCiAgICA+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgv
YmxrX3R5cGVzLmgNCiAgICA+PiBpbmRleCBkNjg4Yjk2ZDFkNjMuLjNhMGQ4NDUyODMyNSAxMDA2
NDQNCiAgICA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oDQogICAgPj4gKysrIGIv
aW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaA0KICAgID4+IEBAIC04NCw2ICs4NCw3IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCBibGtfcGF0aF9lcnJvcihibGtfc3RhdHVzX3QgZXJyb3IpDQogICAgPj4g
ICAgICBjYXNlIEJMS19TVFNfTkVYVVM6DQogICAgPj4gICAgICBjYXNlIEJMS19TVFNfTUVESVVN
Og0KICAgID4+ICAgICAgY2FzZSBCTEtfU1RTX1BST1RFQ1RJT046DQogICAgPj4gKyAgICBjYXNl
IEJMS19TVFNfUkVTT1VSQ0U6DQogICAgPj4gICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCiAg
ICA+PiAgICAgIH0NCiAgICA+DQogICAgPiBJIGFncmVlIHdlIG5lZWQgdG8gbWFrZSB0aGlzIHN0
YXR1cyBhIG5vbi1wYXRoIGVycm9yLCBidXQgd2UgYXQgbGVhc3QNCiAgICA+IG5lZWQgYW4gQWNr
IGZyb20gSmVucyBvciBoYXZlIHRoaXMgcGF0Y2ggZ28gdGhyb3VnaCBsaW51eC1ibG9jayBpZiB3
ZSdyZQ0KICAgID4gY2hhbmdpbmcgQkxLX1NUU19SRVNPVVJDRSB0byBtZWFuIGEgbm9uLXBhdGgg
ZXJyb3IuDQogICAgPg0KICAgID4gQWx0ZXJuYXRpdmVseSB3ZSBjYW4gZGVmaW5lIGEgbmV3IHJl
dHVybiB2YWx1ZSwgaWYgd2Ugc2hvdWxkbid0IHJlLXVzZQ0KICAgID4gZXhpc3Rpbmcgb25lcy4g
RWl0aGVyIHdheSBJJ20gZmluZSB3aXRoLg0KICANCkl0IHNlZW1zIHRvIG1lIHRoYXQgdGhlIGJs
b2NrIGxheWVyIGlzIG5ldmVyIGdvaW5nIHRvIHNlZSBCTEtfU1RTX1JFU09VUkNFIHVubGVzcyAN
Cm52bWVfcmVxKHJlcSktPnJldHJpZXMgcnVuIG91dC4uLiBhbmQgYXQgdGhhdCBwb2ludCBpdCBk
b2Vzbid0IG1hdHRlciwgZG9lcyBpdD8NCg0KV2hhdCdzIHRoZSByZXN1bHQgaWYgdGhlIGNvbnRy
b2xsZXIgcmV0dXJucyBDb21tYW5kIEludGVycnVwdGVkIHN0YXR1cw0KZm9yIHRoZSBzYW1lIHJl
cXVlc3QgcmVwZWF0ZWRseSBhbmQgd2UgcmV0dXJuaW5nIEJMS19TVFNfUkVTT1VSQ0UNCmFmdGVy
IG52bWVfbWF4X3JldHJpZXM/DQoNCi9Kb2huDQogDQoNCg==
