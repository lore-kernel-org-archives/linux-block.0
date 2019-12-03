Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB4DC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2584206EC
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="0YOY4rV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLCRiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:38:08 -0500
Received: from mail-eopbgr690083.outbound.protection.outlook.com ([40.107.69.83]:10822
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfLCRiH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 12:38:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVTb6rI9HqNSnUAD6L59dynYftL/w2azysXAFJ5/yxL2Twdb7+nJHGgZ9V7Wsr3WnNF7KVm0gW9A4zcTroxHsSBTvhorY4D4g4FpRu8BfLq5FwQWApEUqcQtwWhPx2syTpbbx3IQ53dXdyFOmk2nCVoyW53TwBTZ4UDThsVhNArv2U14YIgcWPKmAknS87wUGFAl1Jey9TBkUz/DFHktkZ8TGHELkQUK9iZhqR8YbItZ0sVPLpnbg5kXEOIKgzp10YWiofvv4ekiY4rNApY9HZFefhMU8oTXyaP6vYzozSYxcIhtiQwHt7Djrq557HGvtXOaC29lm1RHI3+U59lvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTyXryH3PbBnaQthmc1K0J/ISiMHOOLBzdVPUYPh0P8=;
 b=dPkJ3LECHVpkaWbgzvnAuSecmK6sWP3l77Tv4MqvM7/pfgojTh/PoLTfmHW/ix+TPdWf5xhnhUIhrPpDsIcEwAXHm6CsoRvmVLoJjXXInKT8pHk4+SvlT6asyobhsDykxQ1nwmH4IwnYuD/I3ap9HhEMyelNdgUUw2LNC++ap2cU3zIiZVXQDrPmtZ+2KQATrBgtYZ6FljrwROh4vdh6np3UFrnOAHXA2KPftw9bVc7QOkWk6mUzMhdFjAZdDh/Qwj0ntDi3eOM4hGMXo93m5qWhscTwzRijGFIl7KyQ5ZItZN0gL+Jy1IddZ0T3UdvPj1good+fVwj8ykVT9o/9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTyXryH3PbBnaQthmc1K0J/ISiMHOOLBzdVPUYPh0P8=;
 b=0YOY4rV4jjZA2kGpZ/EgQz5ORIYfg+3hvNiaZVwXV2+Y0UAz22vpR3xsp/i67dIYmytdXOQnWrLrElGNwimBXW6OPR8KnUaNtPIGn+HtVaF2nfQcVGPQro9/rU5t51I5h1jwvm9nldEMwsR/tKh94a5jw91Pp2G2K3mi2Ok4D6w=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5650.namprd06.prod.outlook.com (20.178.212.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 3 Dec 2019 17:38:05 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 17:38:04 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>,
        Keith Busch <kbusch@kernel.org>
CC:     "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpVats5+vHBHUUEmIVsgThSKMw6eoYlUA
Date:   Tue, 3 Dec 2019 17:38:04 +0000
Message-ID: <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
In-Reply-To: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2788564-7e85-4c9d-7ccd-08d778178d81
x-ms-traffictypediagnostic: BN8PR06MB5650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB56508DCFAE1AEF044D0607CDE4420@BN8PR06MB5650.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(7736002)(99286004)(25786009)(71200400001)(478600001)(6486002)(6436002)(102836004)(76176011)(58126008)(26005)(66446008)(66556008)(66476007)(305945005)(66946007)(33656002)(64756008)(91956017)(107886003)(76116006)(55236004)(6506007)(6512007)(110136005)(316002)(5660300002)(36756003)(81166006)(256004)(186003)(3846002)(11346002)(229853002)(446003)(14444005)(71190400001)(8936002)(2906002)(86362001)(8676002)(6116002)(14454004)(4326008)(81156014)(2501003)(2616005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5650;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUGFqXeh5viImj52iVLkIVhKxboq4Qt5uJrONPK56VzR1okmnumtLH/xqZbSALGE//tpk3KtBw4/6TXJpxdGbZLOamIPnH59LwIVKoKC93Wd60GXuYfB3r4TywSJusxmJCR4uzthcNJk1jhmeog1gVespwPjTzv952mx0+IM3xRF1Y16SIS2JBPbBibGe4+BXYs0sNzkbuSFeyCnwr6k4ocTDhPBfTo2AzknLEF3KIKKQFXBjcLCWSzNInTz4k9dhyFxXvqsALmnz2RlxGbiB4cgf7G5pUC7u3WkzRzfhRC94zQZUAF5ufEArGbqUYCLTUkaYNq88c5tZIbTMM5lx1Ik8LI6R98kBEIHxpTDt1sr87xuIOj9d8RouEqoc/lFbK0LYlw2ktz85g9LAf3jkUtS5Y108l4qKj8+7/XCrGaj2ca3awghQvYNRz7lMRm4
Content-Type: text/plain; charset="utf-8"
Content-ID: <3075DA79B048FE41A27942FA7A574EF0@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2788564-7e85-4c9d-7ccd-08d778178d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 17:38:04.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+yPca6z7yAaVUUVmh1OwsriIONwolrNlQbthF3Lm/vYNpiiNByuiZ1pKTtTo1FiWgW9qUPiQnC8stM1rxhepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5650
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhpcyBpcyBhbiB1cGRhdGUgdG8gc2F5IHRoYXQgSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBhbmQg
aXQgd29ya3MgYXMgZXhwZWN0ZWQuIA0KDQpXaGVuIHRoZSBjb250cm9sbGVyIHJldHVybnMgYSBD
b21tYW5kIEludGVycnVwdGVkIHN0YXR1cyB0aGUgcmVxdWVzdCBpcyBhdm9pZHMgbnZtZV9mYWls
b3Zlcl9yZXEoKQ0KYW5kIGdvZXMgZG93biB0aGUgbnZtZV9yZXRyeV9yZXEoKSBwYXRoIHdoZXJl
IHRoZSBDUkQgaXMgaW1wbGVtZW50ZWQgYW5kIHRoZSBjb21tYW5kIGlzIA0KcmV0cmllZCBhZnRl
ciBhIGRlbGF5Lg0KDQpJZiB0aGUgY29udHJvbGxlcnMgcmV0dXJucyBDb21tYW5kIEludGVycnVw
dGVkIHRvbyBtYW55IHRpbWVzLCBhbmQgbnZtZV9yZXEocmVxKS0+cmV0cmllcw0KcnVucyBkb3du
LCB0aGlzIHJlc3VsdHMgaW4gYSBkZXZpY2UgcmVzb3VyY2UgZXJyb3IgcmV0dXJuZWQgdG8gdGhl
IGJsb2NrIGxheWVyLiAgQnV0IEkgdGhpbmsgd2UnbGwNCmhhdmUgdGhpcyBwcm9ibGVtIHdpdGgg
YW55IGVycm9yLiAgDQoNCltUdWUgRGVjICAzIDA4OjE4OjMzIDIwMTldIHByaW50X3JlcV9lcnJv
cjogZGV2aWNlIHJlc291cmNlIGVycm9yLCBkZXYgbnZtZTBjMG4xLCBzZWN0b3IgNDYxMDA0OA0K
W1R1ZSBEZWMgIDMgMDg6MTg6MzMgMjAxOV0gcHJpbnRfcmVxX2Vycm9yOiBkZXZpY2UgcmVzb3Vy
Y2UgZXJyb3IsIGRldiBudm1lMGMwbjEsIHNlY3RvciA3MTEyNzA0DQoNClRoZSBhbHRlcm5hdGl2
ZSBpcyB0byBzdG9wIGluY3JlbWVudGluZyBudm1lX3JlcShyZXEpLT5yZXRyaWVzIGluIG52bWVf
cmV0cnlfcmVxKCkgd2hlbiBDUkQgaXMgc2V0Lg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQppbmRleCAyNGRjOWVkMWEx
MWIuLmVjOTc5NDY5OGEyMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0K
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQpAQCAtMjU4LDggKzI1OCw4IEBAIHN0YXRp
YyB2b2lkIG52bWVfcmV0cnlfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQogICAgICAgIGNyZCA9
IChudm1lX3JlcShyZXEpLT5zdGF0dXMgJiBOVk1FX1NDX0NSRCkgPj4gMTE7DQogICAgICAgIGlm
IChucyAmJiBjcmQpDQogICAgICAgICAgICAgICAgZGVsYXkgPSBucy0+Y3RybC0+Y3JkdFtjcmQg
LSAxXSAqIDEwMDsNCi0NCi0gICAgICAgbnZtZV9yZXEocmVxKS0+cmV0cmllcysrOw0KKyAgICAg
ICBlbHNlDQorICAgICAgICAgICAgICAgbnZtZV9yZXEocmVxKS0+cmV0cmllcysrOw0KICAgICAg
ICBibGtfbXFfcmVxdWV1ZV9yZXF1ZXN0KHJlcSwgZmFsc2UpOw0KICAgICAgICBibGtfbXFfZGVs
YXlfa2lja19yZXF1ZXVlX2xpc3QocmVxLT5xLCBkZWxheSk7DQogfQ0KDQpUaG91Z2h0cz8NCg0K
L0pvaG4NCg0K77u/T24gMTEvMjcvMTksIDI6MTIgUE0sICJNZW5lZ2hpbmksIEpvaG4iIDxKb2hu
Lk1lbmVnaGluaUBuZXRhcHAuY29tPiB3cm90ZToNCg0KICAgIEZyb206IEpvaG4gTWVuZWdoaW5p
IDxqb2hubUBuZXRhcHAuY29tPg0KDQogICAgIC0gRml4ZXMgYnVnIGluIG52bWVfY29tcGxldGVf
cnEgbG9naWMgaW50cm9kdWNlZCBieQ0KICAgICAgIEVuaGFuY2VkIENvbW1hbmQgUmV0cnkgY29k
ZS4gQWNjb3JkaW5nIHRvIFRQLTQwMzMNCiAgICAgICB3aGVuIEFDUkUgaXMgZW5hYmxlZCB0aGUg
aG9zdCBuZWVkcyB0byBzdXBwb3J0DQogICAgICAgdGhlIENvbW1hbmQgSW50ZXJydXB0ZWQgc3Rh
dHVzLg0KICAgICAtIFRoZSBjdXJyZW50IGNvZGUgaW50ZXJwcmV0cyBDb21tYW5kIEludGVycnVw
dGVkIHN0YXR1cw0KICAgICAgIGFzIGEgQkxLX1NUU19JT0VSUi4gVGhpcyByZXN1bHRzIGluIGEg
Y29udHJvbGxlciByZXNldA0KICAgICAgIHdoZW4gUkVRX05WTUVfTVBBVEggaXMgc2V0OyBpbiBu
dm1lX2ZhaWxvdmVyX3JlcS4NCiAgICANCiAgICBGaXhlczogNDljZDg0YjZmOGI2NzdlICgibnZt
ZTogaW1wbGVtZW50IEVuaGFuY2VkIENvbW1hbmQgUmV0cnkiKQ0KICAgIFNpZ25lZC1vZmYtYnk6
IEpvaG4gTWVuZWdoaW5pIDxqb2hubUBuZXRhcHAuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KICAgIC0tLQ0KICAgICBkcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMgIHwgMiArKw0KICAgICBpbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIHwgMSAr
DQogICAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQogICAgDQogICAgZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KICAgIGluZGV4IDk2OTY0MDRhNjE4Mi4uMjRkYzllZDFhMTFiIDEwMDY0NA0KICAgIC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KICAgICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYw0KICAgIEBAIC0yMzAsNiArMjMwLDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX2Vy
cm9yX3N0YXR1cyh1MTYgc3RhdHVzKQ0KICAgICAgICAgICAgICAgICAgICByZXR1cm4gQkxLX1NU
U19ORVhVUzsNCiAgICAgICAgICAgIGNhc2UgTlZNRV9TQ19IT1NUX1BBVEhfRVJST1I6DQogICAg
ICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX1RSQU5TUE9SVDsNCiAgICArICAgICAgIGNh
c2UgTlZNRV9TQ19DTURfSU5URVJSVVBURUQ6DQogICAgKyAgICAgICAgICAgICAgIHJldHVybiBC
TEtfU1RTX0RFVl9SRVNPVVJDRTsNCiAgICAgICAgICAgIGRlZmF1bHQ6DQogICAgICAgICAgICAg
ICAgICAgIHJldHVybiBCTEtfU1RTX0lPRVJSOw0KICAgICAgICAgICAgfQ0KICAgIGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMu
aA0KICAgIGluZGV4IGQ2ODhiOTZkMWQ2My4uNmVmZWU4ZjFiOTFiIDEwMDY0NA0KICAgIC0tLSBh
L2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgNCiAgICArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa190
eXBlcy5oDQogICAgQEAgLTg0LDYgKzg0LDcgQEAgc3RhdGljIGlubGluZSBib29sIGJsa19wYXRo
X2Vycm9yKGJsa19zdGF0dXNfdCBlcnJvcikNCiAgICAgICAgICAgIGNhc2UgQkxLX1NUU19ORVhV
UzoNCiAgICAgICAgICAgIGNhc2UgQkxLX1NUU19NRURJVU06DQogICAgICAgICAgICBjYXNlIEJM
S19TVFNfUFJPVEVDVElPTjoNCiAgICArICAgICAgIGNhc2UgQkxLX1NUU19ERVZfUkVTT1VSQ0U6
DQogICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCiAgICAgICAgICAgIH0NCiAgICAg
DQogICAgLS0gDQogICAgMi4yMS4wDQogICAgDQoNCg==
