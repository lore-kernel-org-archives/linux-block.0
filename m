Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 22:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiFMWsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbiFMWsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 18:48:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D1A31385
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 15:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1uAcCeMHlpQkxQ3K199NjKQlmTlRfJVqOmv94yLHttlBQkwgt9se7YeLLV34OFUmUItK7ppnGR0MZatPED8dXRwzbsfdpo0f+QTCYFdpoDFxPHMVzb8UCPVm6JwSnS7/e/xEF+H5SXjGbavBDgvEAX1eWCRkVyclZ1eL/jalJH1hYtJFCoGyVC62CUJP8ZjlUWNmY42Qw4MlTsGnOKU8vvlMdFdHVIBnt9AE3OlHNnJV1FKsNBtGzyOFhKzFam/oKzjRlg2F2V6FOpgIQEGRNX+kdMw1CidEvtyg51TKanP+8QIy1QHyz6zONZ/nXLX497k0d85XQAitqvnN6w1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ytCAy3O3820fWlDybcwP3JKDi1cM57g2ee5g8990sg=;
 b=D4ut/gvLYw9c6VByolvvunVbXTDp8aqJNwFUmaG78nGUEJx10p3iHgvhS1iJFr9d+6AkMZCnigFyO1SjVi7q0rkaLGruKxB3WfaiNgBysDgdQFuexCtCGc/S4HDi7PS/GnI+kEvtgHweA2Zdg8DQJiPTMBgSQNVf/Vn8R7oktADDHPBmu9rFxYAuRA2wbKX2aUdEUQ9WVjC6/W35BJcnrKUc3vu5Mt6Mq0yvSR6nEdgNKyRO3ay7Wq0/58at9banVQ8wCkME1oiCmNUAST6VvFXK1XV+TkabrGB4WwqACMjEVHoH06LwRWN3RpmySQuOb5WcDCYJNdpFuwVHnDImfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ytCAy3O3820fWlDybcwP3JKDi1cM57g2ee5g8990sg=;
 b=rZ0uUcIEcWKLTsJCUMAoExOBXkHfS8GO3zbf9DuoRrhsNsBt2nDq4xtPIOtk4YJLM9Rp0icAYwmPQ5K3AeEuJq9ErubKsBAccid7+t18ZvqLj/Pugeg8Sire70HzbCqD0c+vzr3lqRI6P2nj/YOAD44sNGAANiw6grS91VGUkcQv0rH/14CVQ3Sr//N9TKOTDi5U72buV7oLdb/ro32YL3+U2KuLZBFik//n57L2Nrx0dst4yuTg9ZAetNZF4A3DMgSeslZqM4iXVHzx75EYSM/XYOQwBT7PF2Qs2Cy5H0HuixYORD/wk+doVGghYgONSrKfHiU2T6Bb8rujNu93xw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1518.namprd12.prod.outlook.com (2603:10b6:301:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:48:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:48:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jan Kara <jack@suse.cz>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Thread-Topic: [PATCH] blktests: Ignore errors from wait(1)
Thread-Index: AQHYf1XAEAYM8410bECfhVCFN0sjpK1N8K8A
Date:   Mon, 13 Jun 2022 22:48:20 +0000
Message-ID: <0b0ec2ce-9d96-2324-c10c-ad2b0c6d688e@nvidia.com>
References: <20220613151721.18664-1-jack@suse.cz>
In-Reply-To: <20220613151721.18664-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7b32b84-2d51-46a4-4c03-08da4d8ed066
x-ms-traffictypediagnostic: MWHPR12MB1518:EE_
x-microsoft-antispam-prvs: <MWHPR12MB151844B7C7E007CCBAD0166EA3AB9@MWHPR12MB1518.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WpAsRMnTL5gis9RvPB7f2HtkIxHuRzo2T5VqhgUMGMdjFZ6QUoqnSreF1fHifHPeG+MaoAn2GFWrEEq1J+1G4160Yx0Q6b2ATwNTFcymbKDLhy09X7PjG94OvohQCkfqDopr1MhNNhb5sZbZA9lU4g4+2nTBikgdfGZNZueJSuloaj+PrK/XAQqxzHIXRZaPOIXg04azqnYqu2cgwzsAllaQqEH2Z13vo/D8VC0AD+PPZdJn86Iyqu70PeQ8rLoaXkXLgbNX6SCP02dMhpThKNrxAgDJkjhzVzt0Zdj/6lE9F8gIOfnrO87zdljYXPFOtMsVsy8/g9PzE1sWCM2cxXnzCgEOkHjCr2oPCOXQ4arsuYVrgjZG6dp+PcjVUEtPKplXEFFw617oqXC+cuiDYPa1NsxGOtkuIiGWcPoOh0I8d5Nz9bDdmSE8qMPF6KTlT+TKUq1zNbrqC+XHQsVHSM2N9XWvC2rM33VA2c/bd8fEFko2ZVP6QtG7UBekWeekqc7jgG4VnyOmYmLeVSdbDGG6fCiJ6LEGDJaF0R4IZiO+dUIg3cUze3c2h8FSJ9FfY/JwproAO8+f/Iqwwq+KqdLastFso7/hyGTnrYc+BiSolrFGGUc4f8l2VvgVvWsPWBkHTiashSRhYAE9eWb0EzQk3xTeD6eST7BLNG6a9EjNLslca+7kvi4FiNtYocsfTxlOEALeXSsP/JTF7SFLlxderIcrWVP/R7tYZPjj/qHJpj6hqy3fiEjooKBqvuBWe7vl5xXb0CC7KyKb1ZAAMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66556008)(64756008)(8676002)(66446008)(66946007)(4326008)(186003)(66476007)(71200400001)(91956017)(76116006)(38070700005)(5660300002)(54906003)(2616005)(6506007)(53546011)(36756003)(6916009)(8936002)(31686004)(38100700002)(6512007)(86362001)(4744005)(2906002)(6486002)(316002)(31696002)(508600001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VERFZllDcGlvK1UvREIzU2t1TlVhNkNKTE9rcjRJOW02ZkxXZVFPZHZQT1lP?=
 =?utf-8?B?REpiajRFU1lLM3lreEdVWmJTanNXWnBoMlVwMGd6aHQydlZOakZqR3JzcEx6?=
 =?utf-8?B?aWZlbE5oVkJmUWlxSWxTcjdqZEtTWU9PcWgvTHE1VkZlQUFVeUltYUd1Mk9N?=
 =?utf-8?B?SlhNdk1aK1MvT0hDMHBVUFZMYXNNUFhOM04xTGh4dXNxV3dDT3doT0JkR1Nm?=
 =?utf-8?B?cUhlZXhDaDhaTk1GMFJFOVl0WjRwT2Q0S0VPc1FmWFdpc2hRY3hlSE1XSEFi?=
 =?utf-8?B?TVpFSDBVd3dLUmFzTEp4Q3VxK3R6QmNodTNUVDdNemJ0MU9VdTlOZ2VnN0Rp?=
 =?utf-8?B?dzg4SVlETzNLRnh5bUlFSlpPaDZCTE9VMTBqdStQSnRXYWZFOHp0TWxSMGxN?=
 =?utf-8?B?c0ZQa09jNDdyL3NFK0RmMC91ZUlydUdRajVFczVkdGg4SEhzS0pOQ1ZiWmZM?=
 =?utf-8?B?WGJjNnZCUnhNYjVDa3FtL1oyVk52eGt5aVV0bFVnRmdFTWgxNFdERnJiL0RE?=
 =?utf-8?B?RkZZaFZqclBuRGhETUROc0JSV1ZFZDZHNWF5SjBKOWR5d2phbTNCT0x4M3po?=
 =?utf-8?B?TXY0UkJ2SzRCWUViQjhGb0t3QmFEZWNRQ3lONkJRTTZyRjBPUWZ0SGNsQ0I3?=
 =?utf-8?B?YlV6M3NXSGdVUEpSRnZ0VFZjaVBydTBSaEhnaEE4VFB3VCtKNHpBZnVLQVVG?=
 =?utf-8?B?N2I5aHdUMzdETVMwVlNWSmRidG5LSjlxZGxRV2IzcUhEMmRDcG1hUUZ2TTFy?=
 =?utf-8?B?aFU2czRlaVpvb0RTMnVaR1EzT1Z4MHl1aGFLNXRnN1lIL1NVV1BML3hjbEYz?=
 =?utf-8?B?K3gyeEg3bGxhQ2xGL2RrYk5ENWdZSVE3M0xDTHNPQVhrZTlRZ2ppVXpyS0NK?=
 =?utf-8?B?My9lMnJaL3Q2dFlBMVZCSUpaalNHRXZCbzg4K1lKbHB1Q2FQQnl6bmdEZ3Ja?=
 =?utf-8?B?Z0xvVDgrUkloZk43MTdJWVBtMENTKzFwekNHVnROK3dCSURDOGRhelduNk50?=
 =?utf-8?B?TlE5VjkrL1RFbkNvb3Z6c2J0MGZJMEZkVmc4a2MwU3VvSnZ6L3oxcEpIYUt1?=
 =?utf-8?B?OXp3akd2enR6c1hOcFU4TDFsOUN2cmk2bHFpUkRaN1RFNE81emdqOUgxcmpn?=
 =?utf-8?B?Zkg2V2JrbGlCYVpIZHZTcjFoUEJBUVMvc2RGdjJqV25yelpObzlTVmp0aDJ1?=
 =?utf-8?B?T21VVE5aRFIweGoyVyt1S25FM29WUkZKK0g4cDB5bXBSS2tKclkweEZxMkVU?=
 =?utf-8?B?Q2ZFMDkvQUtxRHg4MTFFRDJiQnV3dktlNGI3K2pmOTRQOEw5blFmbDl0K1hY?=
 =?utf-8?B?QzlvSWgrQ3RmZTN0WURiVFhEQXBYOG50dURnaWxJZ2pZT3pIZjAxekdEaUw0?=
 =?utf-8?B?N0tHU3FSMTFQQUQ2ZW00MnVSdzJZR3ErQUV4VmpreDVuMC9jVDVuZDVSYnJy?=
 =?utf-8?B?TFhpeXM2dEJDQU5tWDUrWVo1VUtFNXYrdWZFaG5NOTM0eXZEcE9YN2hlT0Ja?=
 =?utf-8?B?bFZCS2VPOTlSU2w3d0V4bXdvN3dmVFB3VDVwcmF0V1pncnlOcFVNVVlTTWNB?=
 =?utf-8?B?MUVCb0xFOGtObzA5ZTZkUTZ4a3haYVJSdmFCbXg0YS95a1l2YWU1OURrNVRB?=
 =?utf-8?B?NU50bFkvQlNIWjBDeno4WGtkeVc0dnQwWUJFeGROZ1VrOThzcHBSNUZjTHg5?=
 =?utf-8?B?ampROGw2SGxGVExkc0VOZm0rckFmNTU0eDFqR3cvSlhRdHFqUGtmd3RzUzla?=
 =?utf-8?B?QXFrUmZLUG44M2FhR0dUa3N3azJQVXhRY0IwZ0t3K1N4UWFZcWxGT3hTbzBx?=
 =?utf-8?B?ODhDYmF0S0ZMWTh1Y1ZOSW9uR3lSc3E5QlZqanlZT2ZTY1BSZVd1NmhlWnpP?=
 =?utf-8?B?cXI0cnh5cGEyakNUOExESnlmYmttMHg4Z1ljLzZuc3VmQVhrK0tRZW9xNHpm?=
 =?utf-8?B?MjI0WkprRmNWZEppTGFucU5aS3l1cFYzM1I4aG9sV01MeExOdElUVjY0dGtp?=
 =?utf-8?B?OW9QM1hCSU84b3pzMHNQSkhFVWRNUFpkUjhiSU0xY0c3MjZiRnR0UE02ODJt?=
 =?utf-8?B?YS83NHkzMVE5aWtORjVNWitBckpDWVdkeGRmV3FQUUtlZE50Z0U5cGhZc2Qw?=
 =?utf-8?B?aXgwZnZtOEdQRVdOZ1I0Z1pmZlNRaEkrU1pYN2FJSWNHSjdEZTRzWXFSWmcr?=
 =?utf-8?B?V2NxQ0Q4am5nSFlzY1RRTFpFeXlCUGpONVNhZ0hoU2NLTDc1Um1ibUZwSlg5?=
 =?utf-8?B?Rlh4SzhuVHdRS0dvRmNRRGN3aFJ5dkxacTRvQy9MRzl3WEJIS0E3Q1NlWndh?=
 =?utf-8?B?MkcvZFhNODA0TURMWjJMeXhBYnVhZUlGSjFrUGdJNzhpdzBaR3RFcDFENGRi?=
 =?utf-8?Q?tR6BOJTTeApx2QWVDEP3FGBxmkqo4yHuj7QBTzvvUU/9m?=
x-ms-exchange-antispam-messagedata-1: SWeExVWDFEIwnw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4909A3E307E614395CDD5B41CB6B1F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b32b84-2d51-46a4-4c03-08da4d8ed066
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 22:48:20.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPuEF/u+QVQKuKx8F2nr2DiqcGxlMzXfLLXsk4dSEZEA+9zRx9nMB//5ShN3UvUjSQK/PChdcfxHV3JNn9RoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1518
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8xMy8yMiAwODoxNywgSmFuIEthcmEgd3JvdGU6DQo+IE11bHRpcGxlIGJsa3Rlc3RzIHVz
ZSB3YWl0KDEpIHRvIHdhaXQgZm9yIGJhY2tncm91bmQgdGFza3MuIEhvd2V2ZXIgaW4NCj4gc29t
ZSBjYXNlcyB0YXNrcyBjYW4gZXhpdCBiZWZvcmUgd2FpdCgxKSBpcyBjYWxsZWQgYW5kIGluIHRo
YXQgY2FzZQ0KPiB3YWl0KDEpIGNvbXBsYWlucyB3aGljaCBicmVha3MgZXhwZWN0ZWQgb3V0cHV0
LiBNYWtlIHN1cmUgd2UgaWdub3JlDQo+IG91dHB1dCBmcm9tIHdhaXQoMSkgdG8gYXZvaWQgdGhp
cyBicmVha2FnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
DQoNClBsZWFzZSBub3RlIHRoYXQgU2hpbmljaGlybyAoQ0MnZCBoZXJlKSBpcyBhIG5ldyBibGt0
ZXN0cw0KbWFpbnRhaW5lciBhbmQgbm90IE9tYXIuDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
