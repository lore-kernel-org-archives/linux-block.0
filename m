Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1A0C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE72081B
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="NOn5O2md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfLDOsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:48:05 -0500
Received: from mail-eopbgr820054.outbound.protection.outlook.com ([40.107.82.54]:48083
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbfLDOsE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Dec 2019 09:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAWiw3o1hJh0XL6DPzTOTNGkZHqswWbTATrp/fuU4SGlk+IFa8QktzC7uGq0idNaLjJeAAUMXN8moNPmbiUmqhcRQYwBv7vPD7IkVIb1dB5VLg+wN/eywktFEpPz8deNdv57lkzeFAxmj30jY7+McRdhDBbAJbv0BDzcSCtUgOdupGly+TpGCi6F69XM0H1Ldzpdcg9q8m1A2aYqhxp8ZaPrKi19UZxgoBgK4sOeO2tyeuzpCHGNxERzc8wJMR2LjNK7xlMoyD4MfqqDb8N3cqsNmSxOvAPYHKwjuN21vdzXf96oDnD9D6pSh91az3/S2bE8OEBy1LVJolxrY+9cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suY5JfKDKMNNqzfeFCKtW9zdjzWwfcRDWVvuUITb/zs=;
 b=jf3aOy8Iv57Ve43J+jDeayOUpz1nORnt5vwlqfkkl2b/vjSmWLKyJ0inCBDqzO0boPONrvfAdGltFA56uD1nNFR/ovCM1MrBws9zibozF4AJXT8i+iqMXQwpnpo8VmvrEmusQ2XdNLokEP5Tzen0SYy0ddiozYOFBxg/ODRRUT6doxy5t2+hCHQd5CTYDENeqLBFqULJUj93ULhW7zIDQCTxMpkmeLovQEu2JCfuj69oEnFqRSKsKJrZvzreD240+G/rLU/I3F67wqq43qe8XJAKI4FFj8B0Qoi0rjz38QeXHG1X2hyhmHM96N3nHUe4/vg1ixCPp/dHNCDEbagGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suY5JfKDKMNNqzfeFCKtW9zdjzWwfcRDWVvuUITb/zs=;
 b=NOn5O2mdAzYIY1bicxz4QrNqk9CIx61PfRHI7RrUVaSlNjIUvDCOZ14lmvZslVhlp1pEJMSZv7R4NXj9Xut/2PInl2H3eAJdzhNfpPzUibGc54bMc3yXNySHfqDxz+iqVRCmbxez7Fn1PPUO0D+KkZSoQdOpSyKn7KKhJJKcwXo=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5475.namprd06.prod.outlook.com (20.178.209.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 14:48:00 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 14:48:00 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>
CC:     Hannes Reinecke <hare@suse.de>,
        "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpVats5+vHBHUUEmIVsgThSKMw6eoYlUAgACMT4CAARNyAP//ww+A
Date:   Wed, 4 Dec 2019 14:48:00 +0000
Message-ID: <8FAB1EDA-3B06-43A8-92BC-E0840593E144@netapp.com>
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
 <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
 <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
 <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
In-Reply-To: <04835a2e-1769-36c9-63b8-173f247c862b@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf1833b-5fee-4d73-c6c3-08d778c8f58e
x-ms-traffictypediagnostic: BN8PR06MB5475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB5475F16852169B0C27625827E45D0@BN8PR06MB5475.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(4326008)(107886003)(66946007)(3846002)(229853002)(478600001)(6246003)(6116002)(33656002)(76116006)(6512007)(2501003)(14454004)(6436002)(6486002)(6636002)(66446008)(64756008)(110136005)(54906003)(316002)(66556008)(58126008)(25786009)(66476007)(14444005)(305945005)(86362001)(36756003)(99286004)(5660300002)(53546011)(7736002)(2906002)(102836004)(6506007)(186003)(26005)(2616005)(71190400001)(71200400001)(8936002)(11346002)(81156014)(81166006)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5475;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxxAzaOghv5rKzy6yM5yYsn0IvFQ9h30s9qCDCC2UvwEVEiuj8aJFD8Ny9xq4nCNkPQNpMLAGZ+V4dCgNDf8GotEdybEChsWFN6hkTQcZHofklfi8ige8qQZ+d/5rvWwebBGICGj2DLeTPcAAflg3CR1aNBg6c0OkKrlVTJ0rU5kjVwi2THdTWMt2j54TApTDAm0yD3pPqHWve/TIF9RaZTyW12TnF9CmjkW4BJAiCWHlQ8YqoyejDz9av7tTUWTw4PT/0WW2hPsxjO5E9tiGDusMdbtn05dUrkb5CvFc9RY1C/G0ePdNm3VkRM6lxaXxl7vEr6o0CvFEjKnM4fbBCZ95h8XplNXXy+wI/4Nqktlz9UeUypYuY/Pc5pr53sYvcK5rHhHyojIsDGqmGV7QtGseK9J51DumtU33UZ1ql3ZuOuj9ki0QEtsSUuDkX1u
Content-Type: text/plain; charset="utf-8"
Content-ID: <6804DC86BD225D46A4563AF55F704A03@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf1833b-5fee-4d73-c6c3-08d778c8f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 14:48:00.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uoMN2fGcY+SNwidL67Ik4bzRYViCgMYzVGNPkLp3PAAYBpbB06ymxBNJtfA8dLa+Qqfnnb1HaGfu4X3xaVv6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5475
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ICAgIE9uIDEyLzMvMTkgMTA6MDAgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KICAgID4+IElmIHRo
ZSBjb250cm9sbGVycyByZXR1cm5zIENvbW1hbmQgSW50ZXJydXB0ZWQgdG9vIG1hbnkgdGltZXMs
IGFuZCBudm1lX3JlcShyZXEpLT5yZXRyaWVzDQogICAgPj4gcnVucyBkb3duLCB0aGlzIHJlc3Vs
dHMgaW4gYSBkZXZpY2UgcmVzb3VyY2UgZXJyb3IgcmV0dXJuZWQgdG8gdGhlIGJsb2NrIGxheWVy
LiAgQnV0IEkgdGhpbmsgd2UnbGwNCiAgICA+PiBoYXZlIHRoaXMgcHJvYmxlbSB3aXRoIGFueSBl
cnJvci4NCiAgICA+DQogICAgPiBXaHkgaXMgdGhlIGNvbnRyb2xsZXIgcmV0dXJuaW5nIHRoZSBz
YW1lIGVycm9yIHNvIG1hbnkgdGltZXM/IEFyZSB3ZQ0KICAgID4gbm90IHdhaXRpbmcgdGhlIHJl
cXVlc3RlZCBkZWxheSB0aW1lZD8gSWYgc28sIHRoZSBjb250cm9sbGVyIHRvbGQgdXMNCiAgICA+
IHJldHJ5aW5nIHNob3VsZCBiZSBzdWNjZXNzZnVsLg0KDQpZZXMsIHRoaXMgYSBwcm9ibGVtIG9u
IHRoZSBjb250cm9sbGVyLi4uIGJ1dCBJIG9ubHkgZGlkIHRoaXMgdG8gdGVzdCB0aGUgcGF0aG9s
b2dpY2FsIGNhc2UuDQpJIHRoaW5rIHdlIGNhbiBhbGwgYWdyZWUgdGhhdCBpZiB0aGUgY29udHJv
bGxlciBpcyBnb2luZyB0byBjb250aW51YWxseSByZXR1cm4gQ29tbWFuZA0KSW50ZXJydXB0ZWQs
IHRoZSBjb250cm9sbGVyIGlzIGJyb2tlbi4NCg0KICAgID4gSXQgaXMgcG9zc2libGUgd2Uga2lj
ayB0aGUgcmVxdWV1ZSBsaXN0IGVhcmx5IGlmIG9uZSBjb21tYW5kIGVycm9yDQogICAgPiBoYXMg
YSB2YWxpZCBDUkQsIGJ1dCBhIHN1YnNlcXVlbnQgcmV0cnlhYmxlIGNvbW1hbmQgZG9lcyBub3Qu
IElzIHRoYXQNCiAgICA+IHdoYXQncyBoYXBwZW5pbmc/DQoNClllcywgYXMgSGFubmVzIHNhaWQs
IGluIHRoZSBjdXJyZW50IGNvZGU6IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIGlzIG5vdA0KaGFu
ZGxlZCBpbiBudm1lX2Vycm9yX3N0YXR1cygpIHNvIGl0J3MgdHJhbnNsYXRlZCBhczoNCg0KICAg
ICAgICBkZWZhdWx0Og0KICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX0lPRVJSOw0KIA0K
VGhpcyB3b3JrcyBmaW5lIHdpdGggYSBzaW5nbGUgY29udHJvbGxlciwgIGJ1dCB3aGVuIFJFUV9O
Vk1FX01QQVRIDQppcyBzZXQgdGhlIGNvZGUgZ29lcyBkb3duIHRoZSBudm1lX2ZhaWxvdmVyX3Jl
cSgpIHBhdGgsIHdoaWNoDQpkb2Vzbid0IGhhbmRsZSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBl
aXRoZXIsIGFuZCB3ZSBlbmQgdXANCndpdGg6DQoNCiAgICAgICBkZWZhdWx0Og0KICAgICAgICAg
ICAgICAgIC8qDQogICAgICAgICAgICAgICAgICogUmVzZXQgdGhlIGNvbnRyb2xsZXIgZm9yIGFu
eSBub24tQU5BIGVycm9yIGFzIHdlIGRvbid0IGtub3cNCiAgICAgICAgICAgICAgICAgKiB3aGF0
IGNhdXNlZCB0aGUgZXJyb3IuDQogICAgICAgICAgICAgICAgICovDQogICAgICAgICAgICAgICAg
bnZtZV9yZXNldF9jdHJsKG5zLT5jdHJsKTsNCiAgICAgICAgICAgICAgICBicmVhazsNCiAgICAg
ICAgIH0NCiAgICANClNvLCB0aGUgZmlyc3QgdGltZSBhIGNvbnRyb2xsZXIgd2l0aCBSRVFfTlZN
RV9NUEFUSCBlbmFibGVkIHJldHVybnMNCk5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIGl0IGdldHMg
YSBjb250cm9sbGVyIHJlc2V0Lg0KICAgIA0KICAgID4gSSdtIGp1c3QgY29uY2VybmVkIGJlY2F1
c2UgaWYgd2UganVzdCBza2lwIGNvdW50aW5nIHRoZSByZXRyeSwgYSBicm9rZW4NCiAgICA+IGRl
dmljZSBjb3VsZCBoYXZlIHRoZSBkcml2ZXIgcmV0cnkgdGhlIHNhbWUgY29tbWFuZCBpbmRlZmlu
aXRlbHksIHdoaWNoDQogICAgPiBvZnRlbiBsZWF2ZXMgYSB0YXNrIGluIGFuIHVuaW50ZXJydXB0
aWJsZSBzbGVlcCBzdGF0ZSBmb3JldmVyLg0KDQpObywgSSdtIG5vdCByZWNvbW1lbmRpbmcgdGhh
dCB3ZSBza2lwIHJldHJpZXMuICBNeSBkaWZmIHdhcyBub3QgYSBwYXJ0DQpvZiB0aGlzIHBhdGNo
LiAgSSBhZ3JlZSB0aGF0IGl0J3Mgbm90IHNhZmUgdG8gc2tpcCByZXRyeSBjb3VudGluZy4NCg0K
ICAgID4+ICAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQogICAgPj4gICAgIGluZGV4IDk2OTY0MDRhNjE4Mi4uMjRkYzll
ZDFhMTFiIDEwMDY0NA0KICAgID4+ICAgICAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMN
CiAgICA+PiAgICAgKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQogICAgPj4gICAgIEBA
IC0yMzAsNiArMjMwLDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX2Vycm9yX3N0YXR1cyh1
MTYgc3RhdHVzKQ0KICAgID4+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEJMS19TVFNfTkVY
VVM7DQogICAgPj4gICAgICAgICAgICAgY2FzZSBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUjoNCiAg
ICA+PiAgICAgICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX1RSQU5TUE9SVDsNCiAgICA+
PiAgICAgKyAgICAgICBjYXNlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEOg0KICAgID4+ICAgICAr
ICAgICAgICAgICAgICAgcmV0dXJuIEJMS19TVFNfREVWX1JFU09VUkNFOw0KICAgID4NCiAgICA+
IEp1c3QgZm9yIHRoZSBzYWtlIG9mIGtlZXBpbmcgdGhpcyBjaGFuZ2UgaXNsb3RlZCB0byBudm1l
LCBwZXJoYXBzIHVzZSBhbg0KICAgID4gZXhpc3RpbmcgYmxrX3N0YXR1c190IHZhbHVlIHRoYXQg
YWxyZWFkeSBtYXBzIHRvIG5vdCBwYXRoIGVycm9yLCBsaWtlDQogICAgPiBCTEtfU1RTX1RBUkdF
VC4NCg0KSSBjYW4gbWFrZSB0aGF0IGNoYW5nZS4uLiBidXQgSSB0aGluayBCTEtfU1RTX0RFVl9S
RVNPVVJDRSBtaWdodA0KYmUsIHNlbWFudGljYWxseSwgYSBiZXR0ZXIgY2hvaWNlLg0KDQpbQkxL
X1NUU19UQVJHRVRdICAgICAgICA9IHsgLUVSRU1PVEVJTywgImNyaXRpY2FsIHRhcmdldCIgfSwN
CltCTEtfU1RTX0RFVl9SRVNPVVJDRV0gID0geyAtRUJVU1ksICAgICAiZGV2aWNlIHJlc291cmNl
IiB9LA0KDQpUaGUgb25lIHVzZSBjYXNlIHdlIGhhdmUgZm9yIE5WTUVfU0NfQ01EX0lOVEVSUlVQ
VEVEIGluIHRoZSBMaW51eCBOVk1lLW9GIHRhcmdldA0KaXMgYSByZXNvdXJjZSBhbGxvY2F0aW9u
IGZhaWx1cmUgKGUuZy4gRU5PTUVNKS4gIEkgdGhpbmsgSGFubmVzIGNhbWUgYWNyb3NzIHRoaXMg
b25jZSANCndoaWxlIGhlIHdhcyBwcm90b3R5cGluZyB0aGUgQU5BIGNvZGUgaW4gdGhlIExpbnV4
IE5WTWUtb0YgdGFyZ2V0Lg0KDQpBbm90aGVyIHBvdGVudGlhbCB1c2UgY2FzZSBpbiB0aGUgY29u
dHJvbGxlciBtaWdodCBiZSBkZWFkbG9jayBhdm9pZGFuY2UuDQoNCkkgd2FzIGV4cGVyaW1lbnRp
bmcgd2l0aCBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBpbiBteSBjb250cm9sbGVyIGFzIGEgDQpR
T1MgbWVjaGFuaXNtLi4uLiBidXQgSSBkb24ndCB0aGluayBOVk1FX1NDX0NNRF9JTlRFUlJVUFRF
RCAvQ1JEIGlzIHdlbGwgc3VpdGVkDQpmb3IgdGhhdCB1c2UgY2FzZS4gIFRoaXMgdGhhdCdzIGhv
dyBJIGNyZWF0ZWQgdGhlIHBhdGhvbG9naWNhbCBlcnJvciBjYXNlIGluIG15IHRlc3QuDQoNCkVp
dGhlciB3YXksIEkgZG9uJ3QgdGhpbmsgdGhhdCBydW5uaW5nIG91dCBvZiByZXRyaWVzIHdoZW4g
TlZNRV9TQ19DTURfSU5URVJSVVBURUQNCklzIHJldHVybmVkIGEgY3JpdGljYWwgdGFyZ2V0IGVy
cm9yLiBNb3Jlb3ZlciwgaXQgYXBwZWFycyBCTEtfU1RTX1RBUkdFVCBpcywgZXZlcnl3aGVyZSwN
CnJlbGF0ZWQgdG8gc29tZSBraW5kIG9mIExCQSByYW5nZSBlcnJvci4NCg0KL0pvaG4NCg0K
