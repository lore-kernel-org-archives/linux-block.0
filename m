Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3899207DD
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g8hq9O7B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FR3+kKLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgFRUWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:22:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31754 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFRUWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 16:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592511734; x=1624047734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
  b=g8hq9O7BP+PC8vR1n5GzsD29H8sRSskdSi30mjFhnvfYh1Xx9QRF1FcB
   swIn5OtVbf/VM3K9xaQHLAT8Iuf6uiwLeoLNetXiWchDY8/D0l4XkZ1E9
   Sdg+TzPgRZEkOc/Tf0ROZom5oTnmkeHVNQn83kQUC6L3PWk3sokYFjeH1
   shHOSGXcbBoiXYA5+dWGsy9cHeyspmg7vk8LSpqso4EqIhXxlym6H2Th1
   rWEfaaGx+unNKLIxCcxBmFK6yw77++bnBdZpE0JhcwomWWCFCGf+2sOE8
   NJAxSBHXucibI05Tj/1u8dKT1ELjZwcG1F95LzRS+IIWzyFYdVeGodzcL
   Q==;
IronPort-SDR: 2FW2dneHJ9r7yhCm8onP6k5gkfyHSOYSqJkdm1zgotC6cnfYHEPu8yz1W+PhFTNPioPY6PvdG0
 bgmroU5BGwA0HFlHiYnQ3tX+QnzTMtGxFPnVJzqAh/NwNz7RDuLGif4VsRM2DU3wfbcc+9J5+J
 QtQ3HhzJd7l9imyaLXTyTKTdGSTfAF3e6h+K66EnbGfnaSXreYMa8LdS92peR2gOqWb9KO8q30
 sf6o8KRv0CzSXihIqQ/xm7EALgTmhGAJAqcjbiNmKO/AaGDakfM2w6RPoKeuvW/X5AmuyA0dea
 voA=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="140353968"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:22:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUXHevfCiB2CxcOo+g5K4XVhWfWkW13U2GW8TAmoDZbEq3UokNOB16j9lZDMdOzd5kcc6pRqa0mCZmWbYjEK84RvxsqTKBbbshoYytPocKqPyNfeIypiql3B9fKA1oNHzfCFd7cuDv++1Pvh/csGbE11KLstJqKKjYP03UpxEDMZ8cyqQXAhxQu+Wi+FsorWfP+pqGDmG5oVSuilAWvCjIHufouUV6oodlNU/lmUz3r7chNwVKHS92q02//Swh0XYmimBEzxK95bd6u0kB4O7MZ5gYGUsf1aUZdrC+Wxbw5gWo0DmGaj2TdF7VW2Vy2sra0RIBvsy6n8htW1JN2S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
 b=XM9rR0HgVlyxfSYD3hglOLBaM/P540JNktoWyYFEPwcBOduA4bm+8hSUfw08IsEuC/0Docx5X4+rLjas44/gw+e9UbmTujOoWzLK+tsOLx4ptbG77jWM5YtLu1imigNdI8b/q0xMyp0vV+3/XHeoZanyMryUI7yS2OhR4bD4njmkNgcNd6C2wvD89/ThmvwBTV0BXlKZHX/5KXEiblKhPa7ZR/mV0RssKB9LzlGKam7UjbQhT1FlRV0kM800aOdby735L2MBlKOlgoW11w1z/2LHjv695EltFoZbo32oexpi/zMpzDaG3Sz2UoWn7IeqietBvu85Mc3RQMg6H59wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaY5ERAO0hboIg5hoL0wnfFKNclRMP8Euk9Dltnmuk=;
 b=FR3+kKLheyLdpn3AMRa0hWMMoI1t9CZYpE6ufC2tgcrR7i1No7odpo0SlmblCMZWM+iAXmDUMSpVj7Occ95MBzrAX0pROHIm34/pehzDbAWVH7hguPLKZYBIc4rVMTPRvAzsHhtTFgVvPvo5bGH1rFrGYY2WTMZQIRMuphMWHVI=
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5630.namprd04.prod.outlook.com (2603:10b6:208:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:22:10 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e%4]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:22:10 +0000
From:   Matias Bjorling <Matias.Bjorling@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: RE: [PATCHv2 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCHv2 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWRYBVI7ILHVLNRE6vcred1EbgZ6jexF4AgAAC7NA=
Date:   Thu, 18 Jun 2020 20:22:09 +0000
Message-ID: <MN2PR04MB6223341068C204A8A48C3ECFF19B0@MN2PR04MB6223.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-6-kbusch@kernel.org>
 <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
In-Reply-To: <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [185.50.194.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89f731d9-bf34-47a9-60c3-08d813c54766
x-ms-traffictypediagnostic: MN2PR04MB5630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB563098DFD3EDEE4E73278A99F19B0@MN2PR04MB5630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfnA/G+YX0NRntLJ5OnsLpInGysD2rVFkLoaXBumga4Aibvq4Mj5/5BRjUo8vuyAMZLkGfAiPesAqljibnIUFwy00uOWftVrjtlc62PWMXJhGvXHav2Cy3MhTQuBtR55IslfyV6UBuWxVtmw6smyV/yXn3Ozjv5xxEZrGosR4pjo0vmRbhnseyFnK+DlOnAjfwGybsxjpY6OVxXGTv2/hpr+ocroAwyfAw/NlIDUBiKtBT4e+4AI/hICz5LUopvH0mHaJd0w//xStZSzzMBv7dGQVZOBXK1a5bMW51ErMNGe3e+sqIMAB0Dxo2lqj42x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6223.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(186003)(83380400001)(86362001)(66556008)(66446008)(2906002)(26005)(478600001)(8676002)(64756008)(66476007)(66946007)(8936002)(5660300002)(33656002)(7696005)(52536014)(54906003)(110136005)(71200400001)(9686003)(4326008)(55016002)(76116006)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dzi+A6ykmMDDAgX/Gxt6RLbGbe3Xlvf3mra8vcmx4Si3S27TYH4tBPQ26PM179E0FY2PYsgpdH9p7ND6tfOf3n8YTZsPlLXCLArNUS5/+ZGnmFFOc3Pzb4+oNuRd/m0ZwBBhzmRgunhLCfoWky6XELaDVIylrFSZ1Pyw6uCs72gg1NSwjNYOjThgaAFo1vehSjGskknVPCwQIzjh60bPRB0H5njeNQBkFe94jki1OLoUwzBsTM/pjoDeVRTDhWlLkiieL9802MlhxDZb0/HirfDGK08kBQ46pJUrj0+FtWZ4jREHD7toOW1kXKBPxVz/9GBWLBEtfkGrql/koKqkFY4d9w/7IlG/HeN82lenDFbtMvIuAB6/dF8Er31AgefPaB6TSXRgSG8Dcy1Xw/MJeKoQnKmfA5b5lhimUxWztBI4RoDELr2fsc4cTwRYDx/0JulZ9b7OE8e4/j/7AZi11Ie5Z4PebbN5WlLZbd24d+OGYCfJ9jqwjYsvxUYqdGyc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f731d9-bf34-47a9-60c3-08d813c54766
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:22:09.9372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZN8MDiLDpuuHcjR0KWvoedc3My3TFDJ490oBh4ZqRF9VNRxnYVu9RC2+S9EnjdtVc1Tk3D2Z7uD/ZtZ5m3WJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5630
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2xhdXMgSmVuc2VuIDxp
dHNAaXJyZWxldmFudC5kaz4NCj4gU2VudDogVGh1cnNkYXksIDE4IEp1bmUgMjAyMCAyMS4zNg0K
PiBUbzogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGhjaEBsc3Qu
ZGU7DQo+IHNhZ2lAZ3JpbWJlcmcubWU7IGF4Ym9lQGtlcm5lbC5kazsgTmlrbGFzIENhc3NlbCA8
TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsNCj4gRGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxA
d2RjLmNvbT47IEFqYXkgSm9zaGkNCj4gPEFqYXkuSm9zaGlAd2RjLmNvbT47IEtlaXRoIEJ1c2No
IDxLZWl0aC5CdXNjaEB3ZGMuY29tPjsgTWFydGluIEsgLg0KPiBQZXRlcnNlbiA8bWFydGluLnBl
dGVyc2VuQG9yYWNsZS5jb20+OyBEbWl0cnkgRm9taWNoZXYNCj4gPERtaXRyeS5Gb21pY2hldkB3
ZGMuY29tPjsgQXJhdmluZCBSYW1lc2ggPEFyYXZpbmQuUmFtZXNoQHdkYy5jb20+Ow0KPiBIYW5z
IEhvbG1iZXJnIDxIYW5zLkhvbG1iZXJnQHdkYy5jb20+OyBNYXRpYXMgQmpvcmxpbmcNCj4gPE1h
dGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjIgNS81XSBudm1l
OiBzdXBwb3J0IGZvciB6b25lZCBuYW1lc3BhY2VzDQo+IA0KPiBPbiBKdW4gMTggMDc6NTMsIEtl
aXRoIEJ1c2NoIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC96bnMu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jIG5ldw0KPiA+IGZpbGUgbW9kZSAxMDA2NDQgaW5k
ZXggMDAwMDAwMDAwMDAwLi5kNTdmYmJmZTE1ZTgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMNCj4gPiBAQCAtMCwwICsxLDIzOCBAQA0KPiA+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5
cmlnaHQgKEMpIDIwMjAgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0aW9uIG9yIGl0cyBhZmZpbGlh
dGVzLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCj4gPiArI2luY2x1ZGUgIm52bWUuaCINCj4g
PiArDQo+ID4gK3N0YXRpYyBpbnQgbnZtZV9zZXRfbWF4X2FwcGVuZChzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsKSB7DQo+ID4gKwlzdHJ1Y3QgbnZtZV9jb21tYW5kIGMgPSB7IH07DQo+ID4gKwlzdHJ1
Y3QgbnZtZV9pZF9jdHJsX3pucyAqaWQ7DQo+ID4gKwlpbnQgc3RhdHVzOw0KPiA+ICsNCj4gPiAr
CWlkID0ga3phbGxvYyhzaXplb2YoKmlkKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIWlkKQ0K
PiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCWMuaWRlbnRpZnkub3Bjb2RlID0g
bnZtZV9hZG1pbl9pZGVudGlmeTsNCj4gPiArCWMuaWRlbnRpZnkuY25zID0gTlZNRV9JRF9DTlNf
Q1NfQ1RSTDsNCj4gPiArCWMuaWRlbnRpZnkuY3NpID0gTlZNRV9DU0lfWk5TOw0KPiA+ICsNCj4g
PiArCXN0YXR1cyA9IG52bWVfc3VibWl0X3N5bmNfY21kKGN0cmwtPmFkbWluX3EsICZjLCBpZCwg
c2l6ZW9mKCppZCkpOw0KPiA+ICsJaWYgKHN0YXR1cykgew0KPiA+ICsJCWtmcmVlKGlkKTsNCj4g
PiArCQlyZXR1cm4gc3RhdHVzOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWN0cmwtPm1heF96b25l
X2FwcGVuZCA9IDEgPDwgKGlkLT56YW1kcyArIDMpOw0KPiA+ICsJa2ZyZWUoaWQpOw0KPiA+ICsJ
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK2ludCBudm1lX3VwZGF0ZV96b25lX2luZm8o
c3RydWN0IGdlbmRpc2sgKmRpc2ssIHN0cnVjdCBudm1lX25zICpucywNCj4gPiArCQkJICB1bnNp
Z25lZCBsYmFmKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbnZtZV9lZmZlY3RzX2xvZyAqbG9nID0g
bnMtPmhlYWQtPmVmZmVjdHM7DQo+ID4gKwlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGRpc2st
PnF1ZXVlOw0KPiA+ICsJc3RydWN0IG52bWVfY29tbWFuZCBjID0geyB9Ow0KPiA+ICsJc3RydWN0
IG52bWVfaWRfbnNfem5zICppZDsNCj4gPiArCWludCBzdGF0dXM7DQo+ID4gKw0KPiA+ICsJLyog
RHJpdmVyIHJlcXVpcmVzIHpvbmUgYXBwZW5kIHN1cHBvcnQgKi8NCj4gPiArCWlmICghKGxvZy0+
aW9jc1tudm1lX2NtZF96b25lX2FwcGVuZF0gJg0KPiBOVk1FX0NNRF9FRkZFQ1RTX0NTVVBQKSkN
Cj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+ID4gKwkvKiBMYXppbHkgcXVlcnkgY29u
dHJvbGxlciBhcHBlbmQgbGltaXQgZm9yIHRoZSBmaXJzdCB6b25lZCBuYW1lc3BhY2UgKi8NCj4g
PiArCWlmICghbnMtPmN0cmwtPm1heF96b25lX2FwcGVuZCkgew0KPiA+ICsJCXN0YXR1cyA9IG52
bWVfc2V0X21heF9hcHBlbmQobnMtPmN0cmwpOw0KPiA+ICsJCWlmIChzdGF0dXMpDQo+ID4gKwkJ
CXJldHVybiBzdGF0dXM7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWQgPSBremFsbG9jKHNpemVv
ZigqaWQpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghaWQpDQo+ID4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ID4gKw0KPiA+ICsJYy5pZGVudGlmeS5vcGNvZGUgPSBudm1lX2FkbWluX2lkZW50aWZ5
Ow0KPiA+ICsJYy5pZGVudGlmeS5uc2lkID0gY3B1X3RvX2xlMzIobnMtPmhlYWQtPm5zX2lkKTsN
Cj4gPiArCWMuaWRlbnRpZnkuY25zID0gTlZNRV9JRF9DTlNfQ1NfTlM7DQo+ID4gKwljLmlkZW50
aWZ5LmNzaSA9IE5WTUVfQ1NJX1pOUzsNCj4gPiArDQo+ID4gKwlzdGF0dXMgPSBudm1lX3N1Ym1p
dF9zeW5jX2NtZChucy0+Y3RybC0+YWRtaW5fcSwgJmMsIGlkLA0KPiBzaXplb2YoKmlkKSk7DQo+
ID4gKwlpZiAoc3RhdHVzKQ0KPiA+ICsJCWdvdG8gZnJlZV9kYXRhOw0KPiA+ICsNCj4gPiArCS8q
DQo+ID4gKwkgKiBXZSBjdXJyZW50bHkgZG8gbm90IGhhbmRsZSBkZXZpY2VzIHJlcXVpcmluZyBh
bnkgb2YgdGhlIHpvbmVkDQo+ID4gKwkgKiBvcGVyYXRpb24gY2hhcmFjdGVyaXN0aWNzLg0KPiA+
ICsJICovDQo+ID4gKwlpZiAoaWQtPnpvYykgew0KPiA+ICsJCXN0YXR1cyA9IC1FSU5WQUw7DQo+
ID4gKwkJZ290byBmcmVlX2RhdGE7DQo+ID4gKwl9DQo+IA0KPiBBIGRldl9lcnIoKSBoZXJlIHdv
dWxkIGJlIG5pY2UuIEkgaGFkIHRvIGRpZyBhIGJpdCB0byB0cmFjayBkb3duIHdoeSBteQ0KPiBl
bXVsYXRlZCBkZXZpY2UgZGlkbid0IHNob3cgdXAgOykNCg0KSSd2ZSBzdHVtcGxlZCB1cG9uIHRo
aXMgYSBjb3VwbGUgb2YgdGltZXMgd2hlcmUgbmFtZXNwYWNlcyBkaWQgbm90IHNob3cgdXAgZm9y
IHNvbWUgcmVhc29uLiBJbnN0ZWFkIG9mIGFkZGluZyBpdCBoZXJlLCB3b3VsZCBpdCBtYWtlIHNl
bnNlIHRvIHdyaXRlIGFuIGVycm9yIGhpZ2hlciB1cCB0aGUgY2hhaW4/IEZvciBleGFtcGxlIGFy
b3VuZCB0aGUgbnZtZV9yZXZhbGlkYXRlX2Rpc2sgZnVuY3Rpb24uDQo=
