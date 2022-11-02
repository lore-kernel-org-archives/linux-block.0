Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CAAC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKBBVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:21:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFEF583
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsO1+dunGFzKA/BHNfHaqW66O/SK5wBjMj+aJD+hzRMteSedL8ekLfwFaCzIdtvCABqsm6ZjEXSmG16U1VNtQmDAC38yxwghynI0gXXo7raCM3abGYmr8wN2z+3AUKZAL7odbrFG97XFH6CPJdtX+xo+oad1GMhvOOTZnf5t/qi2zYpMJsIgfV7G1ZOvJjYUPSNDC5aK6dx5+IsHhpBoiLeSVEigGfGnatI15t2vlipGqxajh2B42yYAE/ld1zNsRfwYiFfrUgvIK7ri7DFaSrAQQ3VJ7UP1vrlHZh4niGf1Up5T2H1biylaiCvtjy4gb9YTqug0XUH86M1xkCTcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQcti5C17CpjJZFf/s2NmholaIQfvucpko1iETOiLOo=;
 b=C8S6irXHoDJgnUCJAjz3fO5nxOgp4LB4v3OhnfjUMJrfsVBIe3we5je9O7+YzpCt48K+MvZG15Btqlo2ceZJ/enA7K3WEi8aYx47TSEt/AOofVbpDRBCZoWOObuLqagf1U5/uLDiSqFtqedj2DNNjZScshEjFPAkumfRKzV8g8sU7K7AmqKkcQl//3eJJBwjh3W3s1hl9CCLEq/1eGuqd732hKooxzJvHjG6nph6OEb1Fo/6xPQ1YQ/UTgvGUCSv0PQlu2RaUGAokSTSgNcxswYmopIm75eGEk1tvwXsrZIMdWr3VbN1uSZrpAwZI2ra7n23PgA04wTh8RD/BGOoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQcti5C17CpjJZFf/s2NmholaIQfvucpko1iETOiLOo=;
 b=DcUUaHito2gQW4RyQhtgRORpOHC2HpB3MTxpmKkro0LP6G9Jct2l2QHaJLmjYIxwQD2Qhs9FgBExmZpN2ghK1cXfJUItYDNaFEUweTlZAGQvJlUJYJdkFjh2aesDFy784C/vBCNJxEtTopyJtSQMUWQ9EsAkEcs43CG0XopxiJyorzOR/v5/BH5i7n6a+F3VBiLogdXDzIHlEHtWMQ5U95t6WZCiU3NbYCyymzfh/GT9uNlntYVeTi4vM9R6I2p3DvDvvXzwP1EIptfxKpz38Fxeze8TG277sxeHPCZrtnBM/Oe3srmn3n30duf0orhpMRHp3aJ7GSvVK4ZETE2GoQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:21:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:21:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 05/14] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Thread-Topic: [PATCH 05/14] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Thread-Index: AQHY7gL7rnHdHxfZ2EeS3CNZHn5aIq4q1uoA
Date:   Wed, 2 Nov 2022 01:21:45 +0000
Message-ID: <8f82d844-381d-32f7-0c41-f551809c120a@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-6-hch@lst.de>
In-Reply-To: <20221101150050.3510-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: 0c62d7d9-ad13-4b9c-33ed-08dabc709b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gCjyCJe/GtzKvNPMvSvyxKsYvDR6soPnh6mlohOiOQ5YLkRfRDwaStGV30cPOeVzMBRtE0nuYVI9cu0Rv3JFB5lJfX/cJGuJFeFfsVQqGAl5wqZNXCXWHOu+NueT77Goq5yPc4Gjxmd7d0JcXL4WMZSnayijMP0L0E/jnusCQWf/Gatj+a0yZ7ZYHyvcyC5FYuzbP8nR91jndTdHB59OxfIEQ650wn6ttC7+YE7GBBXi+R7Yxo4XbKj+IyLTH4SyFzXhk9PhHKINWLKsZbktyEMKYobPLteaWzXni+FIh6Tyeifb6r6o8IXkzP4j9r/o3v/eQkoN6AgC8fYUoR2Ieh5fGKCErwRh9E5k6khqUb3yyQl84kc8a6Zrsf1IegMvQB7oQkzoAdnvBUEX7GTK1qEOV0PkGP1SfbRkzcM6jOypWeOmcX/L+h9oDJxU/5IKs7tMA0r0GVvvuHRAksl5gSCpvDWOmUAmE29Ud4bDhY9svxJPjz72YVavuzXsetZUCFow8etg24K6qcj0+dW4paZ7mGptFcx2C0afdYNtAdpQV6ugctxNRt33e45n1GrOkW1IvIGpL3GX0T84TtG60tkcfa5/dunbEXKuf1iMVfY/QjNTlMLSuP8lSoZX4P9nH++zrynMUEZrtWsx9Niz1gj7Lkz492bwyNf2C+r+u+BlaLIFnXsSa5zGRWwkkS0rUfSWRP1S5ih7WDv5594TYIbkdR5esLBzJ7fUSHgDdydTag/A/Oq1ADfbxMxyt3GudZOwhBuw1YO2BfQPmEE2RqWyrohWDHkXNRkHgnT69NTJh+ao6qPZzaLhKvvqqwre2GyVu7Bj8bsknANz4Po1rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(558084003)(5660300002)(66476007)(38070700005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cis3NTBZVGhmV3ZDL2VidTkxNlU2STNhSktlaVhGVmVmWUNkZmlNa2RMUmtT?=
 =?utf-8?B?S3J6M2JrS2lsRFB3bUs0WS9VZG1yd1RPcURoRE53cTlyeXJtQ3dJV0RFR3Fp?=
 =?utf-8?B?QVV4ZGdtUEtNa1BIMzRqVW5xbTZsZVkvYUwwTE1ZZXphTWlDeEpicjU5Rk1Y?=
 =?utf-8?B?TXlyWUdIYVFmb2MzTlBYQ3VBdmt0dHRQNERnVFdWMU5wdzd6WHlPZHdCS3ZV?=
 =?utf-8?B?a0owV1RwV3k0QmFYRFZaVW41Z2pnM3BYTVg4U0U2Y2liTng1VmJzd3NCbkgv?=
 =?utf-8?B?QWducUdLZnBCMGFtdmpnQ3dzMFp6cGovRWc1QVlDS2dtdm81TXlpYXFBSHor?=
 =?utf-8?B?anRtUVkwZFhmYjVDQThLcElqLzE3TXNlZXNXZHlCZENqWjYvY256RVRlRFRL?=
 =?utf-8?B?MVgwVFFwUmI1N1VhYkRoQWFJR2lSN0FmTkhvYmRyd20yc0J2STZmL255aWJS?=
 =?utf-8?B?THIxVUtWT25NeEJveU1kYmpJdXZEaGRLdXpLbUtFZU1DdVZsSXpTc05nOCtz?=
 =?utf-8?B?TVdKQnRwbU5WRjE1NWk2UW1nZU9Rem1uOTM4cThmUWI2OHBBSkdNdEVhRlZi?=
 =?utf-8?B?ZU85bmp2TjVPWmZSRWp3d2M5ay9FdGdDeVhVUFViVzg4UktXZHZkYWh0TlFX?=
 =?utf-8?B?QlhCd3lSZyt0Mjk5dTFxbGhIdmRmREZZMEwrSmVra3BTWnFzblNJTXBDS1hL?=
 =?utf-8?B?bHYzaXh0VE13V3FZUFFsaHlwak1NdWNCdUFWVmdtc0RnZTM5WWZzNHFrREx6?=
 =?utf-8?B?VGxFeHNiZWh0K1l0SVdTcStjOHZ2dXdnVFhaTlRxNGE2MHFFOHp5Y2N6bWk1?=
 =?utf-8?B?MW83WU9GU3crVit0T3Y2alNBUHBteXZadjd3OXVwd3l2QTQ5ZGs4bG5ZN3Bm?=
 =?utf-8?B?aEJtd1FVSzZqZUVXWXNocTRDdC91ekxSNk5scjBSWGZITkNHejB4VmtxRjd4?=
 =?utf-8?B?WXVzbVRUNk9hTWJqcEFZMW9qVCtJeDJIb0JrL0JySVdCeTlwd1h0a0tRYmd2?=
 =?utf-8?B?QkJ6VjFrcHU5bmJnY3BqR2RRSk9NWjhwc3M5Y2kvdk1iZVlsNk5lMzZWaTJy?=
 =?utf-8?B?aCszQ21pVzdacWtZeDVZSGdKS1B4ZjRsMGtjeWwrMllnOU9yQVRYRVFFdk9J?=
 =?utf-8?B?RC9IOGRjKzZJRE1UVmFVR1hnaTlqL3JheGcwVW9UbUhDN2VVcnBUTnl3Si9v?=
 =?utf-8?B?QTJ6M1hRd1lId3BNOVgzWnhNK1hKcWxCNGw4V1FuUGMvVTh6YUx0UkF5aUla?=
 =?utf-8?B?cmJyd2dwL0tkcXBraEdWU3JJUjlidjQzQk5maVRDaGpvc3BQNkw5a2JjM0hw?=
 =?utf-8?B?bFRRQURmSGJnWU1HV09YckdaOXQzMHM3SzVsNUtmYWxFZ2JuZUVCT0VwdHF6?=
 =?utf-8?B?aW9OMlVUaytXZ2p1d3ZJZWNvRWdMVmJoeVFoem9BNG9QM0FpMlFiMW4wbmNq?=
 =?utf-8?B?SnEveVRJNElobnJQNWk2ZXZpOHA2ZHRtaUtyZTIvRWdFa1RBMU0yb0h2UHlN?=
 =?utf-8?B?a2tRSEliODMvZjF3VmhFZXZVcnAyeDFQTGlkaDY3ZCtyZ0VDSTBKL3pRY2Zy?=
 =?utf-8?B?dG9EcDFsTno4Uy9RSEwwQ3NiUCt1ZnhSa21iY2RXYUpxRldrY3A5MVdwTEwv?=
 =?utf-8?B?c00rZzdYWXNqWDhJVU14bU03UjA2ZWJTN1VQTDViOTJnOTFNQVdGUFN5SEtM?=
 =?utf-8?B?Z1cvcnRiczJwbUhsd3ZpelZ5Z1cranFQUFZYaVpFUkdsempYZ1hVaGxEQXJ5?=
 =?utf-8?B?aVZacFhKenZiV1BlaUR1QldFOCtlT01iTlllbmg5MHUvY3hEZnhNUDZpb1RE?=
 =?utf-8?B?UnMvakVSY0pqcktlODNieS9LTTk2TVVkazNVMnlLTVFuS2NyL1Q5aTZwVHFs?=
 =?utf-8?B?aFFmU1lBS0hBenhkVFZsV3BWNW5vVjRucWtQRTFMRHkwSkhMT1RJMUxIYjRU?=
 =?utf-8?B?MzN4aTJ4VjNRSDIrTVlnZVFEbW1IL3RhQkJyRmFQVktWL2Y5YlRReWNjaW0z?=
 =?utf-8?B?VGlJeDZQVTNHS0ZSM1BRQjlSYXVmZURBUmxhaEl2aUVralN1Y3FXa0pHcEJr?=
 =?utf-8?B?c2ZWMzR0YTBqUTI4Wm1DbTQ3Wk1GRTQxcW9LU0ptUFpHRnJSNEpzOGY5YlZK?=
 =?utf-8?B?aUZ5UjhyK3BqUjhaRHlBQUhTSkxCWldkRHZwaTdaZm9FRFJRWm11bUkzd1BB?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3DA3267A4D6CA4EA7D666D8C5FE8A53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c62d7d9-ad13-4b9c-33ed-08dabc709b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:21:45.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/TEA58PepDC3WMHSJB36zmNH8yR0XRtHz++1jxdk18qNoS7pb80lBLej+7gPYMThCfr30T9wHfVoOobG5a2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEF0IHRoZSBwb2lu
dCB3aGVyZSBuYW1lc3BhY2VzIGFyZSBtYXJrZWQgZGVhZCwgdGhlIGNvbnRyb2xsZXIgaXMgaW4g
YQ0KPiBub24tbGl2ZSBzdGF0ZSBhbmQgd2Ugd29uJ3QgZ2V0IHBhc3MgdGhlIGlkZW50aWZ5IGNv
bW1hbmRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=
