Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C1AC432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EF820674
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="E0F9z2o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0PaC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:30:02 -0500
Received: from mail-eopbgr800042.outbound.protection.outlook.com ([40.107.80.42]:8632
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfK0PaC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 10:30:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKxhQGulIJRhw0VI0MvuIyUu441Z6cprHxWJFBjp3GsMrXHylODiSBrt9Q2nfWLZdTTWOGz1SOpC7DD3n80Yo4e4BexpR8MaaIHvRAbDshoZ4yXlUrHwwJ9z7O/uNBdHUN9BUEKETUlteEXcks9XycRdrt25keWKOdTYdGdoIfTMHsDjFcIB6MlksZdtIaqx5BfAwF5xfSH/Lluxe11G5BP53zPlg0/aEhrTrczMNyIcHu8EqrqXXaUsVbkl1s6sWzvZo1dL9apQjq9hdsVddpbZF2E8T2mWko/kuw5eY45qryHvVpCbLtjpGKnMcUABsOjOeOVwX/4TeLDTeblYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNkkFxrQF+k+Te5lCW7E4stWVg2n+dap1ZTOYiCkQ08=;
 b=YxQjQqCTSFrQJz+BjlgFwIi++hXgTGNEGDHCTLo6fM+JGEyqcGHUpIHVlVocNBH7xLd40IncRgfu8XiKQHCt3IWB2/MMAuisrV/1PmWttjYY5YYia4H/FdEkP8VXnGMO/wa9VoVJwfA6CEesz8q9hMcuOcRLSjD+MfMnD2dlHo2la9SOAsbnmM65iejFNGpPAzvoc3YKi7bitfyhbdU5eDWFFM5ll1c71HDxPhQKemwuaK7L4/6IErn1JehuC4ZsL4dB9yS5a3BsXuLY0qqAFIEEaai+VxpFmauqt9HYI73ihG0O8vme8HlnWYMtR49CR/bgyYTFPJxqFSp6GQ+GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNkkFxrQF+k+Te5lCW7E4stWVg2n+dap1ZTOYiCkQ08=;
 b=E0F9z2o/FIjrycG21TXsbsgjEadvf/Qdo3VQteOHF5A87sSpvpHw2YVbCDlCo6EXVYtobDAXWavxnHheEY5V+tyyE/S2UJMjYgzj/nQ82/iocAVuysFYJnECrWCPEE6+k6PSC+e9Fp1XU6s6in5KtIuq5UunWhq2AtpLFittNLQ=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB6004.namprd06.prod.outlook.com (20.179.140.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 27 Nov 2019 15:29:58 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 15:29:58 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Meneghini, John" <John.Meneghini@netapp.com>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAFJgCAAS9bgA==
Date:   Wed, 27 Nov 2019 15:29:58 +0000
Message-ID: <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
In-Reply-To: <20191126162412.GA7663@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fc8be42-bb30-49a9-ef67-08d7734ea976
x-ms-traffictypediagnostic: BN8PR06MB6004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB600461F376D3C54D6A8C8671E4440@BN8PR06MB6004.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(91956017)(66946007)(76116006)(229853002)(64756008)(6486002)(66476007)(66556008)(66446008)(99286004)(107886003)(5660300002)(71190400001)(14454004)(54906003)(305945005)(25786009)(36756003)(256004)(71200400001)(7736002)(478600001)(11346002)(2616005)(2906002)(8936002)(33656002)(4326008)(66066001)(81166006)(8676002)(81156014)(6512007)(76176011)(316002)(6246003)(58126008)(86362001)(26005)(186003)(102836004)(53546011)(6506007)(6116002)(446003)(110136005)(6436002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB6004;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWGhqT3oB5jDSYSFDdNL0I6i8iWLTyY8aTkjSyVFPqcfQLTo88XgEzZZbKPrFMdoYyrema82R7pvQbFlc/Mxr5w+yTexamyotq+kBubAynz+ytK0g9pNVeCQEwDzZ6oJybTVPi76Onin1mqYL05Zi/QFEeH6KL0q9d4KiFKNYT/ZqH7mbend+PhSRMnaLiNWin+2nV2/A6OaAjYDJ938cL0SqXXZ/Jjge7sHYW6zSwEfhrb0zsZNmnKxE7AMPiciG08mKcodGp63i8tALNXhw7Mj8ajxsX2OWw1z3KZ8r1IFgijcG3CMIPQ0w3WxW89aXKFdg+xGFmy4DtXHbT/O+oTb2Rl8YDerrVT33u1LFqGeKYeXydLUvVbPtqaiZanPiTtC0THu8bCNi03J3Z4dLpFjp9ZwnFmY2LvKNwfAdPBTYjghz/egjpb4K4SH/+b5
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D91EFFC9A1964980F7712D0E3B47AB@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc8be42-bb30-49a9-ef67-08d7734ea976
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 15:29:58.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0kHBruvpVU1RQ0PlO6zX42Wt4JfCodg9w7Ma74lnOsx2oK2mvGcFJxyspeAnjeS3ErWFzaglB8UlOFWN9OCcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6004
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjYvMTksIDExOjI0IEFNLCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAbHN0LmRlPiB3
cm90ZToNCg0KICAgIE9uIFdlZCwgTm92IDI3LCAyMDE5IGF0IDAxOjA1OjQ2QU0gKzA5MDAsIEtl
aXRoIEJ1c2NoIHdyb3RlOg0KICAgID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5o
DQogICAgPiA+IEBAIC04NCw2ICs4NCw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBibGtfcGF0aF9l
cnJvcihibGtfc3RhdHVzX3QgZXJyb3IpDQogICAgPiA+ICAgICBjYXNlIEJMS19TVFNfTkVYVVM6
DQogICAgPiA+ICAgICBjYXNlIEJMS19TVFNfTUVESVVNOg0KICAgID4gPiAgICAgY2FzZSBCTEtf
U1RTX1BST1RFQ1RJT046DQogICAgPiA+ICsgICBjYXNlIEJMS19TVFNfUkVTT1VSQ0U6DQogICAg
PiA+ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCiAgICA+ID4gICAgIH0NCiAgICA+DQogICAg
PiBJIGFncmVlIHdlIG5lZWQgdG8gbWFrZSB0aGlzIHN0YXR1cyBhIG5vbi1wYXRoIGVycm9yLCBi
dXQgd2UgYXQgbGVhc3QNCiAgICA+IG5lZWQgYW4gQWNrIGZyb20gSmVucyBvciBoYXZlIHRoaXMg
cGF0Y2ggZ28gdGhyb3VnaCBsaW51eC1ibG9jayBpZiB3ZSdyZQ0KICAgID4gY2hhbmdpbmcgQkxL
X1NUU19SRVNPVVJDRSB0byBtZWFuIGEgbm9uLXBhdGggZXJyb3IuDQogDQogICA+Pj4gbW9zdCBy
ZXNvdXJjZSBlcnJvcnMgYXJlIHBlci1wYXRoLCBzbyBibGluZGx5IGNoYW5naW5nIHRoaXMgaXMg
d3JvbmcuDQogICAgDQogID4+PiBUaGF0J3Mgd2h5IEkgcmVhbGx5IGp1c3Qgd2FudGVkIHRvIGRl
Y29kZSB0aGUgbnZtZSBzdGF0dXMgY29kZXMgaW5zaWRlDQogID4+PiAgbnZtZSBpbnN0ZWFkIG9m
IGdvaW5nIHRocm91Z2ggYSBibG9jayBsYXllciBtYXBwaW5nLCBhcyB0aGF0IGlzIGp1c3QNCiAg
Pj4+IGJvdW5kIHRvIGxvc2Ugc29tZSBpbmZvcm1hdGlvbi4NCiAgICANCkl0IHdhc24ndCBteSBp
bnRlbnRpb24gdG8gdHVybiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBpbnRvIG5vbi1wYXRoIHJl
bGF0ZWQgZXJyb3IuDQpUaGUgZ29hbCB3YXMgdG8gbWFrZSB0aGUgY29tbWFuZCByZXRyeSBhZnRl
ciBDRFIgb24gdGhlIHNhbWUgY29udHJvbGxlci4gIFNvIHdoeSANCmRvZXMgdGhpcyBwYXRjaCBj
aGFuZ2UgdGhlIG1lYW5pbmcgb2YgQkxLX1NUU19SRVNPVVJDRT8NCg0KL0pvaG4NCg0K
