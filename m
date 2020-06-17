Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F307C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97B6217BA
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 18:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mvECYNZl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BuFAv/5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQSzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:55:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47972 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQSzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 14:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592420114; x=1623956114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3YQ/3UlmHGgwb82jbaCIAl2J9sdRc7nnPF9NwUIelJk=;
  b=mvECYNZlSDk8bxGHKNVK37MQQGucMczlBpXVjkOtpXssv7Fq3MqtFtpL
   YT20AzMiGl5nDZLNnfWs3eRrmqraAWtIRvOalcUwCPauTJYbblssMeebY
   FN8duuTy3yE+YzryZQs58nSZ/OaVrg86XrTJw8cUbOlV3PFZBixezuE8G
   p4OulZBQdCtZCFnCJ9Vj7h7wHQILkOqOzCTOT7H+eZX+hQQvgfEMkTpy+
   17afVulCqtnio5ORceCdDZnLbazA6rPQ3ifwxPyIFnM1K7han/x7Jsgwr
   H/hHLOznaAV8uXFvaznPD5jq8zDjcoOvc7WIKJZKgyP1IuRybgClL9E9y
   w==;
IronPort-SDR: 7jcmWy1mwcg2sqlHnph8AgAl+atDQBYCT1Xz9/J0sS68W9vyrZLCRSOZcg3nE1+TWVs1Q4Jf1r
 N7TUXVZ+ju95MBl/UhyKu2gkobM7w4Mq5j52yqT6lgd8vGkfgxQdxRJI3oSzz4EYQ77qnTrLJq
 3u4Pu14g+rpJRWRXzrXGvfwlk/aY+29V3yiGKQ8C0ZCs4FwKNbE7yFOTmKJIonhNU1pRtzhWZE
 Qb5z0MyhQfPyrGf6sCC7Aj4imKnRe9mphX9j6ocqpau1U8SbxTEAH4AJe3n6cT2DmJvnpMji+P
 ol0=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; 
   d="scan'208";a="249430152"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 02:55:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewL4nStlcZpmmdx9vdBBsliKrE5j8PNPVxq0Tc4CaAYlGir+AGNYJAFzc/KX+fb6nofdiI8J4A3Tsvqhs/SlMFIJa6g9u2uIHyxYbPnr3a376OzeXOmpYCIkC7vMcRiWa0ltqXXZO1oX0Tle/SpMX9b5IC6fZ6qt02mJRuXxGidia0tbV85nLhi1z2+KLsor0/7aiMYJZFXFnK0pWqi0zM+d+iYp+1ewoYaZlo1Gz2qmmI+RioBqADZIhjuguoSz0jKJ3Zi1FUZtUZpiZlN97rVVkvMhcoTWqkG2mPoixKaR5BSOCZTWiPS+TEq9KfLGB9Hf2tm5Ad/mFp8Jku04+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YQ/3UlmHGgwb82jbaCIAl2J9sdRc7nnPF9NwUIelJk=;
 b=Kadov5R8VmayYAXYFetzQAuJxU/8w+Wnus3QhFC2rVjrLKoBqujdebj4pYHgR0dqk0B8gMrcASiWdbc0JGH6nXrFXPhrS7JlFZmk87Kw1CV6uRNji/VMd6stf/hQWD4/RtTN+nzRfJtLD7pzYZznEfn1AYlTJsqa1K2/sXtwawMkbfmZkz5R2m3BlK8Iy25J8idicTyIJW+b0flqpEQ/1n2gBoQES/rtxGcK7FFBfDFsAVD1xLnydXk3CJ4EZ6eG0oxHheO1vC07HxXbJfJkihwnEEW80CdYRaWJaDQURiN9rlA2MnU49KmnJhku7pt1O0TR+ztj09YsF/n8x+2SgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YQ/3UlmHGgwb82jbaCIAl2J9sdRc7nnPF9NwUIelJk=;
 b=BuFAv/5IDvgjCcF0kFgCPqySbOfJbstEdFH9SBaywsuSNqiqseG0D+IduZ690Orxm34nNwvev/uOJvKN02hoAUxjjqK2xD2kzi9DLOYBljUx4zBKAL9kiALtxS6D20oHIx2RDTJJAXuDIa4r8xmm+HaFLnAiE0/E7/tkog5s9eE=
Received: from MN2PR04MB6223.namprd04.prod.outlook.com (2603:10b6:208:db::14)
 by MN2PR04MB5805.namprd04.prod.outlook.com (2603:10b6:208:39::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 18:55:11 +0000
Received: from MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e]) by MN2PR04MB6223.namprd04.prod.outlook.com
 ([fe80::899f:1d14:ad80:400e%4]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 18:55:10 +0000
From:   Matias Bjorling <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: RE: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22nWIvFisdy3k6SEN4VUPnblajbDpYAgAFgiQCAAHUTAIAANo8AgAAIo4CAAAFeQA==
Date:   Wed, 17 Jun 2020 18:55:10 +0000
Message-ID: <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
In-Reply-To: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [185.50.194.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 147c2c33-b45b-4a87-0a4d-08d812eff632
x-ms-traffictypediagnostic: MN2PR04MB5805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58050EC0A9AFDE43F208F4AFF19A0@MN2PR04MB5805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoRH6wcFnq2+ZTlwc9P0c7RQQbrQG+idUQCMNMQZbXycxGkvh5ttlZgyRwnEep+P/fjaFoJVPVKMC0+3i49EAWTDFlQ+UVe9V5FIZacIS916bCovYPTAXPuLkRyT8jVKG6ZQ0U6JgkPQDrSLU/bUghAThFV1NmJDm3fLmGfy1oVJ7PTlWzxkyf5WxDTdIuyxOE3svqcrHbXxejr2gLGlmLBK4m/FidOI7Ndw7QkstMpOLulxVgLdej3kZpGnFyDoJ+4Jy/GpZxn8GPUkQtRkWZm4h/Lv0QHJ2gMsJV3IwdQVSiADgQF6FyV2bJyhf0yDOSCVdqdI8WIyoi3lEojfBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6223.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(52536014)(71200400001)(6506007)(53546011)(316002)(33656002)(54906003)(110136005)(26005)(7696005)(186003)(86362001)(478600001)(76116006)(64756008)(66556008)(66476007)(2906002)(8936002)(8676002)(66446008)(4326008)(9686003)(66574015)(83380400001)(66946007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s+7+2Fkm4yTLL8St9RGXdGya6IKe+B61+AAMZ4P8PUCFtWa6DNlo4l7cCVNa3P/KA6m2FQV2rEp1vQjfzGtkaTF/0yW0WAGldqRFliodobTVmzRWSvmLIMebgyEadoEboyl93N+W2kITt8c5+1uLdjbHXL4VvRIWbSIDlRjSalrWkgfc1OSxalZFzsIDfFPN4dUbzL81dkKDkvxKJbVdDO/mxJ0IUeSohj98tPdgOTwqPfe8JNQEoMI8e2cRsDXhszqCrRk/GM9N0WyL1MKnoHP0IRZojvWH6Zdf+j/n4YlAh5u3kBzYzgSXBruhLuILxRvqrWUZ6JbEGZejyPYVP4ks/7DdMCCs4vIoWWdw4opV45ap/EU4TGc55zooZJFXlu3dzruYOPIaHz8SRQR48vQ5mx6KkNwlwba2ODmZx49Rp/MePldiOgccY2TicGd+eoZ/RhOtSoFiQpDGNlZvwUESbWOn5TYCf45oSAe0Z5EG/Fe2dIEdWiSolQMQ268x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c2c33-b45b-4a87-0a4d-08d812eff632
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 18:55:10.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agxvMjQBxbi9x6V3Qm8bbUMirbkAs+vqtgtcPwIHDyebOHIoyVDCazHEYelxGp7e0jNUHzKJGsalchl2uLwC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5805
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXZpZXIgR29uesOhbGV6IDxq
YXZpZXJAamF2aWdvbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMTcgSnVuZSAyMDIwIDIwLjI5
DQo+IFRvOiBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdodG52bS5pbz4NCj4gQ2M6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgS2VpdGggQnVzY2ggPEtlaXRoLkJ1c2NoQHdkYy5jb20+
Ow0KPiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWJsb2NrQHZnZXIua2Vy
bmVsLm9yZzsgRGFtaWVuIExlIE1vYWwNCj4gPERhbWllbi5MZU1vYWxAd2RjLmNvbT47IE1hdGlh
cyBCam9ybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+Ow0KPiBTYWdpIEdyaW1iZXJnIDxz
YWdpQGdyaW1iZXJnLm1lPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsgSGFucw0KPiBI
b2xtYmVyZyA8SGFucy5Ib2xtYmVyZ0B3ZGMuY29tPjsgRG1pdHJ5IEZvbWljaGV2DQo+IDxEbWl0
cnkuRm9taWNoZXZAd2RjLmNvbT47IEFqYXkgSm9zaGkgPEFqYXkuSm9zaGlAd2RjLmNvbT47IEFy
YXZpbmQNCj4gUmFtZXNoIDxBcmF2aW5kLlJhbWVzaEB3ZGMuY29tPjsgTmlrbGFzIENhc3NlbA0K
PiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgSnVkeSBCcm9jayA8anVkeS5icm9ja0BzYW1zdW5n
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzVdIG52bWU6IHN1cHBvcnQgZm9yIHpvbmVk
IG5hbWVzcGFjZXMNCj4gDQo+IE9uIDE3LjA2LjIwMjAgMTk6NTcsIE1hdGlhcyBCasO4cmxpbmcg
d3JvdGU6DQo+ID5PbiAxNy8wNi8yMDIwIDE2LjQyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0K
PiA+Pk9uIDE3LjA2LjIwMjAgMDk6NDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+Pj5P
biBUdWUsIEp1biAxNiwgMjAyMCBhdCAxMjo0MTo0MlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6
IHdyb3RlOg0KPiA+Pj4+T24gMTYuMDYuMjAyMCAwODozNCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+
ID4+Pj4+QWRkIHN1cHBvcnQgZm9yIE5WTSBFeHByZXNzIFpvbmVkIE5hbWVzcGFjZXMgKFpOUykg
Q29tbWFuZCBTZXQNCj4gPj4+Pj5kZWZpbmVkIGluIE5WTSBFeHByZXNzIFRQNDA1My4gWm9uZWQg
bmFtZXNwYWNlcyBhcmUgZGlzY292ZXJlZA0KPiA+Pj4+PmJhc2VkIG9uIHRoZWlyIENvbW1hbmQg
U2V0IElkZW50aWZpZXIgcmVwb3J0ZWQgaW4gdGhlIG5hbWVzcGFjZXMNCj4gPj4+Pj5OYW1lc3Bh
Y2UgSWRlbnRpZmljYXRpb24gRGVzY3JpcHRvciBsaXN0LiBBIHN1Y2Nlc3NmdWxseSBkaXNjb3Zl
cmVkDQo+ID4+Pj4+Wm9uZWQgTmFtZXNwYWNlIHdpbGwgYmUgcmVnaXN0ZXJlZCB3aXRoIHRoZSBi
bG9jayBsYXllciBhcyBhIGhvc3QNCj4gPj4+Pj5tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZSB3
aXRoIFpvbmUgQXBwZW5kIGNvbW1hbmQgc3VwcG9ydC4gQQ0KPiA+Pj4+Pm5hbWVzcGFjZSB0aGF0
IGRvZXMgbm90IHN1cHBvcnQgYXBwZW5kIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4N
Cj4gPj4+Pg0KPiA+Pj4+V2h5IGFyZSB3ZSBlbmZvcmNpbmcgdGhlIGFwcGVuZCBjb21tYW5kPyBB
cHBlbmQgaXMgb3B0aW9uYWwgb24gdGhlDQo+ID4+Pj5jdXJyZW50IFpOUyBzcGVjaWZpY2F0aW9u
LCBzbyB3ZSBzaG91bGQgbm90IG1ha2UgdGhpcyBtYW5kYXRvcnkgaW4NCj4gPj4+PnRoZSBpbXBs
ZW1lbnRhdGlvbi4gU2VlIHNwZWNpZmljcyBiZWxvdy4NCj4gPj4+DQo+ID4+PkJlY2F1c2UgQXBw
ZW5kIGlzIHRoZSB3YXkgdG8gZ28gYW5kIHdlJ3ZlIG1vdmVkIHRoZSBMaW51eCB6b25lZCBibG9j
aw0KPiA+Pj5JL08gc3RhY2sgdG8gcmVxdWlyZWQgaXQsIGFzIHNob3VsZCBoYXZlIGJlZW4gb2J2
aW91cyB0byBhbnlvbmUNCj4gPj4+Zm9sbG93aW5nIGxpbnV4LWJsb2NrIGluIHRoZSBsYXN0IGZl
dyBtb250aHMuwqAgSSBhbHNvIGhhdmUgdG8gc2F5IEknbQ0KPiA+Pj5yZWFsbHkgdGlyZWQgb2Yg
dGhlIHN0dXBpZCBwb2xpdGljcyB0aGEgeW91ciBjb21wYW55IHN0YXJ0ZWQgaW4gdGhlDQo+ID4+
Pk5WTWUgd29ya2luZyBncm91cCwgYW5kIHdpbGwgc2F5IHRoYXQgdGhlc2UgZG8gbm90IG1hdHRl
ciBmb3IgTGludXgNCj4gPj4+ZGV2ZWxvcG1lbnQgYXQgYWxsLsKgIElmIHlvdSB0aGluayBpdCBp
cyB3b3J0aHdoaWxlIHRvIHN1cHBvcnQgZGV2aWNlcw0KPiA+Pj53aXRob3V0IFpvbmUgQXBwZW5k
IHlvdSBjYW4gY29udHJpYnV0ZSBzdXBwb3J0IGZvciB0aGVtIG9uIHRvcCBvZg0KPiA+Pj50aGlz
IHNlcmllcyBieSBwb3J0aW5nIHRoZSBTQ1NJIFpvbmUgQXBwZW5kIEVtdWxhdGlvbiBjb2RlIHRv
IE5WTWUuDQo+ID4+Pg0KPiA+Pj5BbmQgSSdtIG5vdCBldmVuIGdvaW5nIHRvIHJlYWQgdGhlIHJl
c3Qgb2YgdGhpcyB0aHJlYWQgYXMgSSdtIG9uIGENCj4gPj4+dmFjYXRpb24gdGhhdCBJIGJhZGx5
IG5lZWRlZCBiZWNhdXNlIG9mIHRoZSBTYW1zdW5nIFRXRyBidWxsc2hpdC4NCj4gPj4NCj4gPj5N
eSBpbnRlbnRpb24gaXMgdG8gc3VwcG9ydCBzb21lIFNhbXN1bmcgWk5TIGRldmljZXMgdGhhdCB3
aWxsIG5vdA0KPiA+PmVuYWJsZSBhcHBlbmQuIEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgYW4gdW5y
ZWFzb25hYmxlIHRoaW5nIHRvIGRvLiBIb3cNCj4gPj4vIHdoeSBhcHBlbmQgZW5kZWQgdXAgYmVp
bmcgYW4gb3B0aW9uYWwgZmVhdHVyZSBpbiB0aGUgWk5TIFRQIGlzDQo+ID4+b3J0aG9nb25hbCB0
byB0aGlzIGNvbnZlcnNhdGlvbi4gQnVsbHNoaXQgb3Igbm90LCBpdCBlbmRzIHVwIG9uDQo+ID4+
ZGV2aWNlcyB0aGF0IHdlIHdvdWxkIGxpa2UgdG8gc3VwcG9ydCBvbmUgd2F5IG9yIGFub3RoZXIu
DQo+ID4NCj4gPkkgZG8gbm90IGJlbGlldmUgYW55IG9mIHVzIGhhdmUgc2FpZCB0aGF0IGl0IGlz
IHVucmVhc29uYWJsZSB0bw0KPiA+c3VwcG9ydC4gV2UndmUgb25seSBhc2tlZCB0aGF0IHlvdSBt
YWtlIHRoZSBwYXRjaGVzIGZvciBpdC4NCj4gPg0KPiA+QWxsIG9mIHVzIGhhdmUgY29tbXVuaWNh
dGVkIHdoeSBab25lIEFwcGVuZCBpcyBhIGdyZWF0IGFkZGl0aW9uIHRvIHRoZQ0KPiA+TGludXgg
a2VybmVsLiBBbHNvLCBhcyBDaHJpc3RvcGggcG9pbnRzIG91dCwgdGhpcyBoYXMgbm90IGJlZW4g
YSBzZWNyZXQNCj4gPmZvciB0aGUgcGFzdCBjb3VwbGUgb2YgbW9udGhzLCBhbmQgYXMgTWFydGlu
IHBvaW50ZWQgb3V0LCBoYXZlIGJlZW4gYQ0KPiA+d2FudGVkIGZlYXR1cmUgZm9yIHRoZSBwYXN0
IGRlY2FkZSBpbiB0aGUgTGludXggY29tbXVuaXR5Lg0KPiANCj4gPg0KPiA+SSBkbyB3YW50IHRv
IHBvbGl0ZWx5IHBvaW50IG91dCwgdGhhdCB5b3UndmUgZ290IGEgdmVyeSBjbGVhciBzaWduYWwN
Cj4gPmZyb20gdGhlIGtleSBzdG9yYWdlIG1haW50YWluZXJzLiBFYWNoIG9mIHRoZW0gaXMgcGFy
dCBvZiB0aGUgcGxhbmV0J3MNCj4gPmJlc3Qgb2YgdGhlIGJlc3QgYW5kIG1vc3Qgd2VsbC1yZXNw
ZWN0ZWQgc29mdHdhcmUgZGV2ZWxvcGVycywgdGhhdA0KPiA+bGl0ZXJhbGx5IGhhdmUgYnVpbHQg
dGhlIHN0b3JhZ2Ugc3RhY2sgdGhhdCBtb3N0IG9mIHRoZSB3b3JsZCBkZXBlbmRzDQo+ID5vbi4g
VGhlIHN0b3JhZ2Ugc3RhY2sgdGhhdCByZWNlbnRseSBzZW50IG1hbm5lZCByb2NrZXRzIGludG8g
c3BhY2UuDQo+ID5UaGV5IGVhY2ggdW5hbmltb3VzbHkgc2FpZCB0aGF0IHRoZSBab25lIEFwcGVu
ZCBjb21tYW5kIGlzIHRoZSByaWdodA0KPiA+YXBwcm9hY2ggZm9yIHRoZSBMaW51eCBrZXJuZWwg
dG8gcmVkdWNlIHRoZSBvdmVyaGVhZCBvZiBJL08gdHJhY2tpbmcNCj4gPmZvciB6b25lZCBibG9j
ayBkZXZpY2VzLiBJdCBtYXkgYmUgd29ydGggYnJpbmdpbmcgdGhpcyBpbmZvcm1hdGlvbiB0bw0K
PiA+eW91ciBlbmdpbmVlcmluZyBvcmdhbml6YXRpb24sIGFuZCBhbHNvIHBvdGVudGlhbGx5IGNv
bnNpZGVyIFpvbmUNCj4gPkFwcGVuZCBzdXBwb3J0IGZvciBkZXZpY2VzIHRoYXQgeW91IGludGVu
ZCB0byB1c2VkIHdpdGggdGhlIExpbnV4DQo+ID5rZXJuZWwgc3RvcmFnZSBzdGFjay4NCj4gDQo+
IEkgdW5kZXJzdGFuZCBhbmQgSSBoYXZlIG5ldmVyIHNhaWQgdGhlIG9wcG9zaXRlLg0KPg0KPiBB
cHBlbmQgaXMgYSBncmVhdCBhZGRpdGlvbiB0aGF0DQoNCk9uZSBtYXkgaGF2ZSBpbnRlcnByZXRl
ZCB5b3VyIFNEQyBFTUVBIHRhbGsgdGhlIG9wcG9zaXRlLiBJdCB3YXMgbm90IHZlcnkgbmV1dHJh
bCB0b3dhcmRzIFpvbmUgQXBwZW5kLCBidXQgdGhhdCBpcyBvZiBjYXVzZSBvbmUgb2YgaXRzIGxl
YXN0IHByb2JsZW1zLiBCdXQgSSBhbSBoYXBweSB0byBoZWFyIHRoYXQgeW91J3ZlIGNoYW5nZWQg
eW91ciBvcGluaW9uLg0KDQo+IHdlIGFsc28gaGF2ZSBiZWVuIHdvcmtpbmcgb24gZm9yIHNldmVy
YWwgbW9udGhzIChzZWUgcGF0Y2hlcyBhZGRpdGlvbnMgZnJvbQ0KPiB0b2RheSkuIFdlIGp1c3Qg
aGF2ZSBhIGNvdXBsZSBvZiB1c2UgY2FzZXMgd2hlcmUgYXBwZW5kIGlzIG5vdCByZXF1aXJlZCBh
bmQgSQ0KPiB3b3VsZCBsaWtlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZXkgYXJlIHN1cHBvcnRlZC4N
Cj4gDQo+IEF0IHRoZSBlbmQgb2YgdGhlIGRheSwgdGhlIG9ubHkgdGhpbmcgSSBoYXZlIGRpc2Fn
cmVlZCBvbiBpcyB0aGF0IHRoZSBOVk1lDQo+IGRyaXZlciByZWplY3RzIFpOUyBTU0RzIHRoYXQg
ZG8gbm90IHN1cHBvcnQgYXBwZW5kLCBhcyBvcHBvc2VkIHRvIGRvaW5nIHRoaXMNCj4gaW5zdGVh
ZCB3aGVuIGFuIGluLWtlcm5lbCB1c2VyIHdhbnRzIHRvIHV0aWxpemUgdGhlIGRyaXZlIChlLmcu
LCBmb3JtYXR0aW5nIGEgRlMNCj4gd2l0aCB6b25lZCBzdXBwb3J0KSBUaGlzIHdvdWxkIGFsbG93
IF90b2RheV8NCj4gaW9jdGwoKSBwYXNzdGhydSB0byB3b3JrIGZvciBub3JtYWwgd3JpdGVzLg0K
PiANCj4gSSBzdGlsbCBiZWxpZXZlIHRoZSBhYm92ZSB3b3VsZCBiZSBhIG1vcmUgaW5jbHVzaXZl
IHNvbHV0aW9uIHdpdGggdGhlIGN1cnJlbnQgWk5TDQo+IHNwZWNpZmljYXRpb24sIGJ1dCBJIGNh
biBzZWUgdGhhdCB0aGUgZ2VuZXJhbCBjb25zZW5zdXMgaXMgZGlmZmVyZW50Lg0KDQpUaGUgY29t
bWVudCBmcm9tIHRoZSBjb21tdW5pdHksIGluY2x1ZGluZyBtZSwgaXMgdGhhdCB0aGVyZSBpcyBh
IGdlbmVyYWwgcmVxdWlyZW1lbnQgZm9yIFpvbmUgQXBwZW5kIGNvbW1hbmQgd2hlbiB1dGlsaXpp
bmcgWm9uZWQgc3RvcmFnZSBkZXZpY2VzLiBUaGlzIGlzIHNpbWlsYXIgdG8gaW1wbGVtZW50IGFu
IEFQSSB0aGF0IG9uZSB3YW50cyB0byBzdXBwb3J0LiBJdCBpcyBub3QgYSBnZW5lcmFsIGNvbnNl
bnN1cyBvciBvcGluaW9uLiBJdCBpcyBoYXJkIGZhY3RzIGFuZCBob3cgdGhlIExpbnV4IGtlcm5l
bCBzb3VyY2UgY29kZSBpcyBpbXBsZW1lbnRlZCBhdCB0aGlzIHBvaW50LiBPbmUgbXVzdCBpbXBs
ZW1lbnQgc3VwcG9ydCBmb3IgWk5TIFNTRHMgdGhhdCBkbyBub3QgZXhwb3NlIHRoZSBab25lIEFw
cGVuZCBjb21tYW5kIG5hdGl2ZWx5LiBQZXJpb2QuIA0KDQo+IA0KPiBTbyB3ZSB3aWxsIGdvIGJh
Y2ssIGFwcGx5IHRoZSBmZWVkYmFjayB0aGF0IHdlIGdvdCBhbmQgcmV0dXJuIHdpdGggYW4NCj4g
YXBwcm9hY2ggdGhhdCBiZXR0ZXIgZml0cyB0aGUgZWNvc3lzdGVtLg0KPiANCj4gPg0KPiA+QW5v
dGhlciBhcHByb2FjaCwgaXMgdG8gdXNlIFNQREssIGFuZCBieXBhc3MgdGhlIExpbnV4IGtlcm5l
bC4gVGhpcw0KPiA+bWlnaHQgZXZlbiBiZSBhbiBhZHZhbnRhZ2UsIHlvdXIgY3VzdG9tZXJzIGRv
ZXMgbm90IGhhdmUgdG8gd2FpdCBvbiB0aGUNCj4gPkxpbnV4IGRpc3RyaWJ1dGlvbiBiZWluZyBy
ZWxlYXNlZCB3aXRoIGEgbG9uZyB0ZXJtIHJlbGVhc2UsIGJlZm9yZSB0aGV5DQo+ID5jYW4gZXZl
biBnZXQgc3RhcnRlZCBhbmQgZGVwbG95IGluIHZvbHVtZS4gSS5lLiwgdGhleSB3aWxsIGFjdHVh
bGx5IGdldA0KPiA+ZmFzdGVyIHRvIG1hcmtldCwgYW5kIHlvdXIgY29tcGFueSB3aWxsIGJlIGFi
bGUgdG8gc2VsbCBtb3JlIGRyaXZlcy4NCj4gDQo+IEkgdGhpbmsgSSB3aWxsIHJlZnJhaW4gZnJv
bSBkaXNjdXNzaW5nIG91ciBidXNpbmVzcyBzdHJhdGVneSBvbiBhbiBvcGVuIG1haWxpbmcNCj4g
bGlzdC4gQXBwcmVjaWF0ZSB0aGUgZmVlZGJhY2sgdGhvdWdoLiBWZXJ5IGluc2lnaHRmdWwuDQoN
CkkgYW0gbm90IGFza2luZyBmb3IgeW91IHRvIGRpc2N1c3MgeW91ciBidXNpbmVzcyBzdHJhdGVn
eSBvbiB0aGUgbWFpbGluZyBsaXN0LiBNeSBjb21tZW50IHdhcyB0byBnaXZlIHlvdSBnZW51aW5l
bHkgYWR2aXNlIHRoYXQgbWF5IHNhdmUgYSBsb3Qgb2Ygd29yaywgYW5kIG1pZ2h0IGV2ZW4gZ2V0
IGJldHRlciByZXN1bHRzLiANCg0KPiANCj4gVGhhbmtzLA0KPiBKYXZpZXINCg==
