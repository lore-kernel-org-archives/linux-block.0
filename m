Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B88C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066F92080F
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="cwnBjraw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK0TWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:22:21 -0500
Received: from mail-eopbgr800057.outbound.protection.outlook.com ([40.107.80.57]:25446
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfK0TWV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 14:22:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF8lJXiyiFgMpno/flpyMoHN1w8SVpzsrpsY2Qj3SuYXdFUYlRTxTWXTEvntycX9cmblwyqhxPbeVwOjXQkDFk+At4Mn+73MHWy1l5W6E0Jb6sHB4vMnTVWOFu27Yii/CEjS9zYXFceRRCGkpOJdlykHD4fIse4SylqLJ69mF+v+/AZ28xtuO+NtUZxS7gC6uZM4KXhiMhyw3fOQ1ZX5Kbmcyda4B5V0HN1ept4hOBLD4XWjtPtV0efG+s4R94Ou6bOZr27qV1Vwafl97WPRvHftZnu+vCH7jlYuV9VI57o6YoM27K+evCxLkq0iOD51caGkoguCegtcKV7tT8DUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/gaW25E+GpTNTORVhrHTeLMuYkGHmn85IrHVdZNzns=;
 b=e/8Y2u+yEY/Fx1adaxqJSEDLyi0RdgzN8Nt1FHYLugw/9WoprSQt36HoKwuha88AokFx3rXXis8iV+ZV7jn+BAe1wWis1MmIqzk1QJ3qxZNqwAXZKOP060ofSF//4YQHYRi4FpUtDD7GkR1/62oUIeRYl+wmwbvG4FsqEoRTva/DXHt4hs+6+SFi8gYonQUaPuwh2GvBG7dWPGqWrQG30xy2TB5qNcqsfVUw6BgWsAUbgwFtBfe+WZ/7/hFqETCh6NmqDCoN4nfpYfD4W0ocq2JtxFQJ6hdD+PZZCrsTsFRbZV0UNYlOqjXnTtgRSyZo2rnYSWK643jZGQwFDR0ltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/gaW25E+GpTNTORVhrHTeLMuYkGHmn85IrHVdZNzns=;
 b=cwnBjrawrGYAIS3f/HqwY9D5wZ+oLYpkb2ntNy+UVn+qwmnaGv0ZYbOeg9vbWfBtQXn5aE+f2b5W/VTEO0GyEaMmQL8oN1g9tpILQv3f/n04pWVg/uz+iHURif4WG8MPfQWDJf7Pv8b3icFIg+G0zjSL6F1Uu6snmhKEz17Oncg=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB6257.namprd06.prod.outlook.com (20.178.214.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 19:22:18 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::6923:8e28:8cc8:6c99%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 19:22:18 +0000
From:   "Meneghini, John" <John.Meneghini@netapp.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>,
        "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Topic: [PATCH] nvme: Add support for ACRE Command Interrupted status
Thread-Index: AQHVpF6Ymda5HHf+tUmLPGNyVZkab6ednfwAgAAFJgCAAS9bgIAAkQSA//+v5oA=
Date:   Wed, 27 Nov 2019 19:22:18 +0000
Message-ID: <4106A22B-FA00-43A6-A18B-74DB15E8CAAD@netapp.com>
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
 <20191126162412.GA7663@lst.de>
 <AC3DED38-491E-4778-88E0-DEC84031A115@netapp.com>
 <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191127190859.GA2050@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e9f4285-f0f0-46f7-3259-08d7736f1e67
x-ms-traffictypediagnostic: BN8PR06MB6257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB6257ECA262AFD6BE37D1CC8DE4440@BN8PR06MB6257.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(6916009)(6436002)(58126008)(3846002)(107886003)(6116002)(6486002)(6246003)(33656002)(14454004)(54906003)(6512007)(25786009)(36756003)(2906002)(316002)(478600001)(66066001)(256004)(446003)(2616005)(11346002)(64756008)(229853002)(76176011)(305945005)(102836004)(6506007)(53546011)(186003)(71190400001)(71200400001)(26005)(8676002)(81156014)(8936002)(81166006)(66446008)(5660300002)(66556008)(99286004)(4744005)(4326008)(66946007)(66476007)(76116006)(86362001)(91956017)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB6257;H:BN8PR06MB6115.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtVNeER5QfDPBLHlhDP4FZAmBxPqGJcOwW4tyfdsBc41bZHSbm0T7Pr7rsnXaivG7CJIQhN1tQfcDQFgG8nLWEtU/9uFb2skcMPASUe5ImVokRthXch0swDdXf68j1FMdMYZ7Ed6GINoqGvWEExBhVxD2sFy16YVt3OtqYnpH11zUpjVYRLoYZppCoVeLBg45qN7i79e7d2bu+zxSAWaZhLZ8V0/8TKyNcELUCTQLeGd/NLbfN281xw4TzfeI3l3p/IPWrj+1mVGeZW9xSGU5+1uBHxQ9aMVDpgY5BBHrnBneCO5vWwoyGcWKqMWk7C0UNEKi9gzVU5a7UCYoi/NNlFm3v0xGtPk5mk8FvCitPS6UtqE0cSMn97xLPPz+Fg6lZTSFa5qGUMlnH3dkmVawyHH1WWMG/Yut2vpEyk2MZWyEKuwaDTy7T10sc9TYap7
Content-Type: text/plain; charset="utf-8"
Content-ID: <38988DBF72EEC743B7460A1ED1EA5E93@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9f4285-f0f0-46f7-3259-08d7736f1e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 19:22:18.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apY4fB8tyUkk1E2rYbjVs1LiqQKVnivqLO49+8czorXlZW4nq/FcIKo4GRwwu4pTf6fMwcU78IiCE2N38pRpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6257
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjcvMTksIDI6MDkgUE0sICJLZWl0aCBCdXNjaCIgPGtidXNjaEBrZXJuZWwub3JnPiB3
cm90ZToNCiAgICA+PiBJdCB3YXNuJ3QgbXkgaW50ZW50aW9uIHRvIHR1cm4gTlZNRV9TQ19DTURf
SU5URVJSVVBURUQgaW50byBub24tcGF0aCByZWxhdGVkIGVycm9yLg0KICAgID4+IFRoZSBnb2Fs
IHdhcyB0byBtYWtlIHRoZSBjb21tYW5kIHJldHJ5IGFmdGVyIENEUiBvbiB0aGUgc2FtZSBjb250
cm9sbGVyLiAgU28gd2h5DQogICAgPj4gZG9lcyB0aGlzIHBhdGNoIGNoYW5nZSB0aGUgbWVhbmlu
ZyBvZiBCTEtfU1RTX1JFU09VUkNFPw0KICAgIA0KICAgID4gV2hhdCBJIG1lYW50IGJ5IGEgIm5v
bi1wYXRoIGVycm9yIiBpcyB0aGF0IHRob3NlIHR5cGVzIG9mIGVycm9ycyBmb3INCiAgICA+IG52
bWUgZ28gdGhyb3VnaCB0aGUgIm5vcm1hbCIgcmVxdWV1aW5nIHRoYXQgY2hlY2tzIENSRC4gVGhl
IGZhaWxvdmVyDQogICAgPiByZXF1ZXVpbmcgZG9lcyBub3QgY2hlY2sgQ1JELiBCdXQgdGhpbmtp
bmcgYWdhaW4sIEkgZG9uJ3Qgc2VlIHdoeSB0aGUNCiAgICA+IGZhaWxvdmVyIHNpZGUgY2FuJ3Qg
YWxzbyBiZSBDUkQgYXdhcmUuDQoNClllcywgdGhlIGZhaWxvdmVyIHNpZGUgY2FuIGJlIENSRCBh
d2FyZSwgYnV0IEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCBpbiBmYWlsaW5nDQpvdmVyIHRvIGEgZGlm
ZmVyZW50IHBhdGggd2hlbiBDUkQgaXMgc2V0LiAgQXMgeW91IHNhaWQsIHRoaXMgaXNuJ3QgYSBw
YXRoaW5nDQplcnJvci4gIA0KDQpXZSBjYW4gYXJndWUgYWJvdXQgd2hldGhlciB0aGUgY29tbWFu
ZCBpcyByZXRyaWVkIG9uIHRoZSBjdXJyZW50IGNvbnRyb2xsZXINCm9yIGEgZGlmZmVyZW50IGNv
bnRyb2xsZXIsIGJ1dCBDUkQgbXVzdCBiZSBvYnNlcnZlZCBiZWZvcmUgdGhlIGNvbW1hbmQgaXMg
cmV0cmllZC4NCg0KQWdyZWVkPw0KDQovSm9obg0KDQo=
