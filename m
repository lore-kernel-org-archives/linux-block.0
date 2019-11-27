Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3125C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD6B20835
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="0z3PHV2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0TNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:13:40 -0500
Received: from mail-eopbgr680067.outbound.protection.outlook.com ([40.107.68.67]:54950
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0TNj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 14:13:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOimJvZljI+uw+7tFUsPH4NkKhoVBufiNYSORkTj/s08GczVXBAz/LUWEMc1h81b63xzMUXOgnr4JKnv+mXr1f1v3380Aw/tPvfD+bRfxQQhRSt/wfdXFOR4J6g62p1Eu71zN5zbBsnXd7lTuxpoap+AcJijwmdru9KEzH+UQF+vqKXwisdZPnHdhjY4BTDLGZJq2WtCUyaxdioosJK1+tyiWJM+r/Jb/rQng6m5i1WPHlulo7rY41r6HpgNwBkCMQx3j4dMSmaRNdJen6gOt5eJvF60in5m/UT8nF/I4wszqolz792/DLAMXe8Q/StJenVjbi6AvBCfrWzLhExpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEBI15DE24BQ2lOplKHq9yPRcTYKuOgfRyeIp/C9cBU=;
 b=aCUutohYzU0TZ137EzNR9TfpQkB4A9Yv5QosGQjCSXq+fgPNvigDPhHtP3hMc4LdtRzvbnJC2Psu1I3/0cJbBONO9mRpy0LjNbfyW9VoGPUkOO578cBR/ObG+15NLmktGd9dSXdU6XjgB8YhW2OpXce5PShP2uHjraFzrNt+kr5Zpmoe8G+5nIC0+wCysVbgKpaXh3h/SE+lSO4QlGCQftdGJee9xgtTI7GXnsVDL8pq2R5DDf62e9B7GYabDyOXeD1nqDSOn/wcL5kQIOd8W0drrxF067ZbG8Q208ozW8eo7XYpEUIzcYBAooO62EDUnzL/f+4J/hAu9zm5t+2Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEBI15DE24BQ2lOplKHq9yPRcTYKuOgfRyeIp/C9cBU=;
 b=0z3PHV2PLbllw9sZvZlEuUvC9OoTThiGZcH40eD8Jtp9tFghv5C9pNhrPJqW6GPoI7mxz0WKsMHMlzlDtD+MblquSPFq/Y9YAQPIFGWi5xk6PFM/oscqxEWkEgcafIxLMNmiVyfT6JDQfcf6ej/+QTguxW3tMAwUp5CMYZ45Pj0=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5682.namprd06.prod.outlook.com (20.179.136.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 19:12:58 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 19:12:57 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>,
        Keith Busch <kbusch@kernel.org>
CC:     "Meneghini, John" <John.Meneghini@netapp.com>
Subject: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpVats5+vHBHUUEmIVsgThSKMww==
Date:   Wed, 27 Nov 2019 19:12:57 +0000
Message-ID: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d337d9f2-7abd-4093-8b25-08d7736dd053
x-ms-traffictypediagnostic: BN8PR06MB5682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB56823D8DA93D230E5D67A164E4440@BN8PR06MB5682.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(2906002)(81156014)(66946007)(66476007)(14454004)(26005)(91956017)(8676002)(76116006)(478600001)(66446008)(58126008)(81166006)(8936002)(71190400001)(66066001)(6506007)(33656002)(2616005)(256004)(64756008)(71200400001)(14444005)(7736002)(53546011)(305945005)(4001150100001)(66556008)(25786009)(99286004)(6512007)(102836004)(186003)(6486002)(3846002)(6436002)(110136005)(86362001)(316002)(36756003)(107886003)(2501003)(5660300002)(6116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5682;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gheyYDLBqEvbsvY5QY3nAdv7jApm2EygTK9OXsd6TG+KrZ88WzsYTlG2j8rncPSBdRF8BveLO+iF5jXNYkfXD4SUL1XILe+oGihUuKyTw73N07Q/KhGxnsgwrbz8IpWCFu1JArbfI4zO10cMupFsWx54LBX7S8VnHbgw7busgnE30yjn4lLmRtISu57DZJYPzAux0xEacQnKYJ4RRwO8P5G5Pda2naRC/e5zai1JcYFTvRRrZcubZAZqAHJQBDMZjLgjNmRdqxPZKfGvlEmNeWHlK15MdcMyqrE4DPm3XnkcDHjsUNIXDSwAK5kV/vpHePammu1jFvCDSV+xnpEFkwkqz+Un0nJcR2jJLBHAwxLjR+Yq1UysEYT0B2lSNs48Rg2nkKmYwx9O8NArzYEo722z0Z3yFbj4VPol5WERLA4nkLcFd4s7MHsZnMAtnnZv
Content-Type: text/plain; charset="utf-8"
Content-ID: <61B8879C90BF41458AE19054FA55DE1D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d337d9f2-7abd-4093-8b25-08d7736dd053
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 19:12:57.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaHyLOuZ0C5rUzMBLCYHhmXV9bBdmeQ2SN2SBoli9W+tDpGd6U05ovhU+9NlVIyZivuifZ9a3lY7siin3wabmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5682
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SeKAmXZlIHJlYmFzZWQgdGhpcyBwYXRjaCBvbnRvIG52bWUtNS41IGFuZCByZW1vdmVkIHRoZSBO
Vk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBkZWZpbml0aW9uLg0KDQpqb2hubUBqb2hubS1tYWMtMTpu
dm1lKGZpeF9hY3JlKSA+IGdpdCBsb2dsIC0yIA0KKiBiNzdlNWJiZDg4NDcgMjAxOS0xMS0yNyAg
KEhFQUQgLT4gZml4X2FjcmUpIG52bWU6IEFkZCBzdXBwb3J0IGZvciBBQ1JFIENvbW1hbmQgSW50
ZXJydXB0ZWQgc3RhdHVzIFsgSm9obiBNZW5lZ2hpbmkgLyBqb2hubUBuZXRhcHAuY29tIF0NCiog
NmM2YWEyZjI2YzY4IDIwMTktMTEtMjIgIChvcmlnaW4vbnZtZS01LjUsIG52bWUtNS41KSBudm1l
OiBod21vbjogYWRkIHF1aXJrIHRvIGF2b2lkIGNoYW5naW5nIHRlbXBlcmF0dXJlIHRocmVzaG9s
ZCBbIEtlaXRoIEJ1c2NoIC8gYWtpbm9idS5taXRhQGdtYWlsLmNvbSBdDQoNCkFuZCBJJ3ZlIHJl
cGxhY2VkIEJMS19TVFNfUkVTT1VSQ0Ugd2l0aCBCTEtfU1RTX0RFVl9SRVNPVVJDRS4gIFRoaXMg
c2hvdWxkIG1ha2UgaXQgY2xlYXIgdG8gdGhlIGJsb2NrIGxheWVyIHRoYXQgdGhpcyBpcyBub3Qg
YSBrZXJuZWwgcmVzb3VyY2UgcHJvYmxlbSwNCmJ1dCBhIGRldmljZSByZXNvdXJjZSBwcm9ibGVt
LiAgQnV0IHRoZSBibG9jayBsYXllciBzaG91bGQgb25seSBzZWUgdGhpcyBlcnJvciB3aGVuIHRo
ZSBjb250cm9sbGVyIHJ1bnMgb3V0IG9mIHJlcXVlc3QgcmV0cmllcy4NCg0Kam9obm1Aam9obm0t
bWFjLTE6bnZtZShmaXhfYWNyZSkgPiBjYXQgMDAwMS1udm1lLUFkZC1zdXBwb3J0LWZvci1BQ1JF
LUNvbW1hbmQtSW50ZXJydXB0ZWQtc3RhdHVzLnBhdGNoDQpGcm9tIDhjZmYxOGZlMmY1MjQ3N2Jm
YTY5M2VlODlkMzc0ZTY4OWE0N2E3OWYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBK
b2huIE1lbmVnaGluaSA8am9obm1AbmV0YXBwLmNvbT4NCkRhdGU6IFdlZCwgMjcgTm92IDIwMTkg
MTM6Mjc6MzUgLTA1MDANClN1YmplY3Q6IFtQQVRDSF0gbnZtZTogQWRkIHN1cHBvcnQgZm9yIEFD
UkUgQ29tbWFuZCBJbnRlcnJ1cHRlZCBzdGF0dXMNCg0KIC0gRml4ZXMgYnVnIGluIG52bWVfY29t
cGxldGVfcnEgbG9naWMgaW50cm9kdWNlZCBieQ0KICAgRW5oYW5jZWQgQ29tbWFuZCBSZXRyeSBj
b2RlLiBBY2NvcmRpbmcgdG8gVFAtNDAzMw0KICAgd2hlbiBBQ1JFIGlzIGVuYWJsZWQgdGhlIGhv
c3QgbmVlZHMgdG8gc3VwcG9ydA0KICAgdGhlIENvbW1hbmQgSW50ZXJydXB0ZWQgc3RhdHVzLg0K
IC0gVGhlIGN1cnJlbnQgY29kZSBpbnRlcnByZXRzIENvbW1hbmQgSW50ZXJydXB0ZWQgc3RhdHVz
DQogICBhcyBhIEJMS19TVFNfSU9FUlIuIFRoaXMgcmVzdWx0cyBpbiBhIGNvbnRyb2xsZXIgcmVz
ZXQNCiAgIHdoZW4gUkVRX05WTUVfTVBBVEggaXMgc2V0OyBpbiBudm1lX2ZhaWxvdmVyX3JlcS4N
Cg0KRml4ZXM6IDQ5Y2Q4NGI2ZjhiNjc3ZSAoIm52bWU6IGltcGxlbWVudCBFbmhhbmNlZCBDb21t
YW5kIFJldHJ5IikNClNpZ25lZC1vZmYtYnk6IEpvaG4gTWVuZWdoaW5pIDxqb2hubUBuZXRhcHAu
Y29tPg0KU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQotLS0N
CiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgIHwgMiArKw0KIGluY2x1ZGUvbGludXgvYmxrX3R5
cGVzLmggfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
DQppbmRleCA5Njk2NDA0YTYxODIuLjI0ZGM5ZWQxYTExYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQpAQCAtMjMw
LDYgKzIzMCw4IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9lcnJvcl9zdGF0dXModTE2IHN0
YXR1cykNCiAgICAgICAgICAgICAgICByZXR1cm4gQkxLX1NUU19ORVhVUzsNCiAgICAgICAgY2Fz
ZSBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUjoNCiAgICAgICAgICAgICAgICByZXR1cm4gQkxLX1NU
U19UUkFOU1BPUlQ7DQorICAgICAgIGNhc2UgTlZNRV9TQ19DTURfSU5URVJSVVBURUQ6DQorICAg
ICAgICAgICAgICAgcmV0dXJuIEJMS19TVFNfREVWX1JFU09VUkNFOw0KICAgICAgICBkZWZhdWx0
Og0KICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX0lPRVJSOw0KICAgICAgICB9DQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvYmxrX3R5
cGVzLmgNCmluZGV4IGQ2ODhiOTZkMWQ2My4uNmVmZWU4ZjFiOTFiIDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS9saW51eC9ibGtfdHlwZXMuaA0KKysrIGIvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaA0K
QEAgLTg0LDYgKzg0LDcgQEAgc3RhdGljIGlubGluZSBib29sIGJsa19wYXRoX2Vycm9yKGJsa19z
dGF0dXNfdCBlcnJvcikNCiAgICAgICAgY2FzZSBCTEtfU1RTX05FWFVTOg0KICAgICAgICBjYXNl
IEJMS19TVFNfTUVESVVNOg0KICAgICAgICBjYXNlIEJMS19TVFNfUFJPVEVDVElPTjoNCisgICAg
ICAgY2FzZSBCTEtfU1RTX0RFVl9SRVNPVVJDRToNCiAgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQogICAgICAgIH0NCiANCi0tIA0KMi4yMS4wDQoNCg0K
