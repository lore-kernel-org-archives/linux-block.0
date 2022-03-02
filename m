Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB18BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 01:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiCBBsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 20:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiCBBsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 20:48:51 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3C1ADA3
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 17:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSM+rVzf8pNfsdZhLlUhBshhimDcQAQignWIZbeoEus2ANi0qfyd0dpTkcLQKiUtit07UfGB0o1+vWjAled2jnWabGENiapeP6pJHLgHbzOL0dhv8vHcachOdF5rg8zl+VC3fLnHuRcSYlgN4svFfc0GkBZEjDG9OC0CgKotRNI4AEsng7rJ+EK08U5x8/+ZXrA+pM7hl/9etpUjBDFWcDYF1Hy/qciVIa8gfYeIKpJzKdZExO5pT4Hl343ttzG+KQSpuUBCJyyBF/Oa2s0qgDQtVEmv8iF5eOaD/C6ivXz5S1I2jyjzlVu9XzoOfvhUoqFow2gasNU8dJaiZ42ACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbNcXMTWlY6Hk6hMWwZemMySiutyD1Io4w+ku4qDft8=;
 b=FbsDt5kTKvfqm4iOcy36JoBHuU+lpKuTEn71fL8Xm/XD3bClcunmPJ60xAye3ATvELR1vU6sH3aHHnGYX5Kzl7UV9+GjaZ0ysijqzFN8WFHvroIMeMVRnIbBO8rotkfIza918J90UvahN78xaIO5FXwGXRrJ+kJKUsRcwMElzCev2h7LO6Eu1jr+2dBTu3mFowtlBF0GT0f8JEbpI1FlHoyjK8DVQnIIw0h7O5S+EdXdiSAc66IqWrmn4kueIyUnJFWVB/aFwbmFb3cGnGgWJBM5/FXWremvlNYICrVyzqpEg9r+C7mdajBlMAvzgrrcCoNGih1hOEI4i709Dxiyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbNcXMTWlY6Hk6hMWwZemMySiutyD1Io4w+ku4qDft8=;
 b=tSKAk1pHlxu0+4foDIkKChF3NW5pJl2aS+Xw+tJ0T28ALwOg9Srb9vxetzF2bMo7y69i2yUT1rNOMylhREvYafhTQ0dV0v2LGHZ2z8ErkTunytwckI3huawp/0zB0aCAnMQXWIGt+30+USNF8Bc8mxK53SuPI5djfcOqdB0epI+Uc1Jz4Jfm4syXa0BQNhort1UuRYnym3CQmKp3p6yLgaHd6reTFJM4qxHX/wQ5PdCXXmyQH/glumTEYQqm+i540udGIHg767+cPTu8aDQzqHZDY3ZCne4g3GK1yR1HLMMQGZU+NyvxfSKX9xgSNy0MR13GMGf5RTbtnfr4xtZqSw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 01:48:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 01:48:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] blk-mq: kill warning when building
 block/blk-mq-debugfs-zoned.c
Thread-Topic: [PATCH V2] blk-mq: kill warning when building
 block/blk-mq-debugfs-zoned.c
Thread-Index: AQHYLc1Vss2QihEqLkWTQ59R79euOKyrU4OA
Date:   Wed, 2 Mar 2022 01:48:05 +0000
Message-ID: <0f74e62e-445f-575c-bb30-437d08bf1846@nvidia.com>
References: <20220302003431.1253287-1-ming.lei@redhat.com>
In-Reply-To: <20220302003431.1253287-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6183ea29-c109-4345-5b81-08d9fbeeb1e9
x-ms-traffictypediagnostic: MWHPR12MB1214:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1214F1AF8A4AA4B2FDAF3AA6A3039@MWHPR12MB1214.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5eQrAdqoMrOE/xChoGVYXKBwhl686ma3ktCPYSmEm0zmzoKn0KvIE2rnE/XF6eVSOCYYDg1MhHdpwsvtW/Mz7qd+iMVl5dylqbDWp5huEA6MJcUZ9HBanJRzn7gXA2gLtD7MzSCwrYkEXSrg1fMKIfC+XP3ysRvS2CRG6qIHaSOXcMZBHR7cPqLnd8aC5exROHx0L3Brq+XG8XxoEoJCW7wdGXqbw0opWi22nVZG9lGSjQV5uWv2H0XfGyPOyZ9AyPKSmGkzChKNPi27QKUZuQ/f7PBFr/GWhwpu9iAWg0jxkfMpd6NygP2D3dqU8uAWK9d+zOWw+VfMSVilow1bI9A6/KQolDTzYh6txRjyMg8h02c8oKxMeRuR9PaAmZORVn/8C/lpIMt4X2OZDsvK9N6YmaoA0rzN1wK9d8M/8NdSjz1WcPZuFX1kkrLa75YMlrEhyOLljvBpZmRslqt85ToCizrJh61OZrn6jhth8uTLTrH8z39Lf5LTWUHd2fnDTwtkMvtKSiQZXtxag1zEXtuav/1VCWl12RuuPCnIGCmb1O5tiMSwJGpmApyqKO4EPqB9QcUej2DUniFOqudSPaidRRrJWnwO5s8Brc4vX8jbhnNvjwHcPRJoaJPwDq2awqHpCiFjrfkYR6sL7MwVujwAHH1l8pRdGksj/scRuJhL8hzMuniUajAYLbw+Ov8kLZKhI0lOMvpTF0VzeJhwutUDntfXPeNtNCImXIPoJEgBAF7Of6yQstVgI45V2KzHEmAKIR8OG8bnRY+xXk8zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(91956017)(508600001)(6486002)(54906003)(6916009)(66556008)(66446008)(64756008)(8676002)(4326008)(66946007)(71200400001)(31686004)(6506007)(76116006)(66476007)(31696002)(316002)(53546011)(38070700005)(8936002)(36756003)(6512007)(83380400001)(122000001)(4744005)(38100700002)(5660300002)(2906002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVc5Y25Ec0tGc2k3T3pkc1VkOTRicmRVVkFVdjFoYUlsTHRSWURqV1ZzMUNU?=
 =?utf-8?B?b1ZzZDBieUFLcVQ3QVBmMXY1QlFtQWdhdU5ZWVhUdXdhdURkOHhiZ0pTSVlq?=
 =?utf-8?B?Yi9rMVdha2NxdVYvbG83SVpMTEdJK0hYM0pJcjJ2RTBQelBNZzlNSlRveFQv?=
 =?utf-8?B?UFNoWFNXMUpsako3SzNSZ2FUM1lVbGJLRCtJMW5CVGFHOS9uOTdMWkk2VWFV?=
 =?utf-8?B?Z0ozTnJ4NW5jRHBia0ptcStyN1pkWTFHaVRWMEltWWs0VFdjSm01NGtSWUpp?=
 =?utf-8?B?VFFpcUlOZUQ2VzNDZEt6TDMyakpBQzdtdm15ZVJPQXVyUjBEMm9QQVFiait6?=
 =?utf-8?B?TWxqdmpKdWNuSE5idjZEZFNSZW1ydkczdjZMYnNURnVFWXJpMWRha2x6cHBh?=
 =?utf-8?B?SWtVdGVGQXdvUHNUK3I3QzNCbWRVL3d3Y2ZPSzBYWTAvNDI1c2k3ZExnbWFY?=
 =?utf-8?B?VExJbitSRnN0a0krS3hlcW0zRU5GejlvNGFNNS9KcEJyRnltSjVjOVliM25o?=
 =?utf-8?B?azhPMUtYRGhYQlFIMXRWbHArc3FSajVXUlFyMkZNRzM2K0pJaVZ1N1RkK2tn?=
 =?utf-8?B?dGhBaXNuaXZ4VW9VZTdhTFptdXVQZzluQUpBQ2FNSDVhWjl2RUlieWJOMlh1?=
 =?utf-8?B?MDM0Z3JCN3N6NkloUlVFbVZaeDN5dmZoYjN2aHUyNWN3b2NZaGF3QTcyWTlT?=
 =?utf-8?B?THpvenFHWEEvN3VWeFZCTnpBRjlDTHNoYVlVNW11cjhPUGlWbXpPdnpkd0lO?=
 =?utf-8?B?N3ZHcGVEYWdVWFIxWU1xb1owaUN5WE92OEk3eUJQVTVtZkRTMzdCNVFlczBX?=
 =?utf-8?B?Um94Wlh2NGZtQjB1WGh4Vk1Ebmx3YzlYM3RQQXFRWk1DNFNVR3BEVEFheVVY?=
 =?utf-8?B?dHNtcFV4YVU1NkFITk04alJVak5aU3FKUHpsbUt6T3pUdjFIMEVZakJGMGlk?=
 =?utf-8?B?cGJ2Tkt0dE5uVDRxaFVGSWJhblRWUzliMlBYb1ZwVGU5SDY1U2JIY204Umh4?=
 =?utf-8?B?cFBjOFVOQjh2NXBzbFVpWHhWb2ZGOGk4RHBIelZ4RXV1RGxLNU80VXhERzBI?=
 =?utf-8?B?K2NSMlFQMkxKQUZ6QWZjdHpHK2J3UGxNK0dZTm12Z243cGhES0VHdStZMEhu?=
 =?utf-8?B?eVhkN3ozQlQwci9CZ0JhcWFEeXVTVi9lMnNQRXREblhZTmk4Y2pPY2IvaERh?=
 =?utf-8?B?QUxvZ3hTOGY4UTRDVmtDSTQ1MzNNZnlKN2kvSndDQW51alhid2tYMndRckRo?=
 =?utf-8?B?NTZuRlZCRTEzc0t3S25JejRYNk9lZ2pTcklYM2ZIREFFVXZRYkxlM014WVQz?=
 =?utf-8?B?Y1MyUm5WR0JVZUFaM2pVREM3SGZqTGdKL2NVWC84SE0zb1JxU205aXdZVHRz?=
 =?utf-8?B?QmZMU3hUT2tjeUhab3pxOFFJZW9pVHdOTHB2ejNYOG1tWEhjMDIxVXVicU11?=
 =?utf-8?B?SWpUWWpneXFoeGxaRTc4ZDV6R0t3T1hhbGMrSG1BdnJIQmZudHNMdEhLY2VK?=
 =?utf-8?B?R3VxbzcwdkU4QUo2ekJRajQ4czhVRHlLNHV1WFM1cGRTNWNwTlZGRGNhSnl3?=
 =?utf-8?B?OVV6dUhteXNYYThsZExsd2puOTBwcXpmRzVDUVRxSDFUM1hKdUdKRTQrMHBl?=
 =?utf-8?B?OWI2bGh2SmpldmgxQWFPa1VDSi9sTTk0Qm9rL054TlRMWkovWFFSZktTMm1X?=
 =?utf-8?B?NklLTWZuNWsrNE5IdmQrODMrTTQ0QUF6NUlReExBdjF5L0dXekVjWTBad0JE?=
 =?utf-8?B?WTZmcTVVN1BrSHZRUDZiSFgyVnhNSXR0V3FMeXV5d3IxQ25MY2lwdnduanhm?=
 =?utf-8?B?cFQxT0tLWDVNbkMrRTFJY3loTmZZYzRSWUFpM0U3TUQvU3dmNWtqc1g5dVg4?=
 =?utf-8?B?TzVFYS9nSkNNa3orcUR5WXRCU3Y2ZExGTFFKaW1jWDB5NHc2eXBuUWs5M0ph?=
 =?utf-8?B?OFRlbVd4czZJRUk4S3NzaHNCSVZGRFVLRFgrSC9EVXJSMVJMUEtRK2VyZ1BZ?=
 =?utf-8?B?YmNzZzdneFQ3SGlqSjFIR2YydklBZGVhR2xCdDFPMmtZaW1xV2dFN2FFZlFq?=
 =?utf-8?B?OW5adDMxUkcrQTFPdXBSaW9uTlMrUEppT0Rmd2g1QWF0bFU5eWYyaWdpYncv?=
 =?utf-8?B?RFJ6K0tTODdiNkZGYTN0VlVRNysxSlhEVldLMyt3L1B0eE4zYnF0ZU5ZaWlW?=
 =?utf-8?Q?zc5ZPH4IaFo9Z9EgaGLCHb4+wi1fRGitkmaAHV5TIwk/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EBA97D36146114ABBA15425567C177D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6183ea29-c109-4345-5b81-08d9fbeeb1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 01:48:05.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Od5O9MhdrthS675nDOsnAfEs7elsrEtf9IuckBi2Cb6eaMYV+t7DOLgQ0SqAV+CkLq2hOg20cVhDlRWbimp7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xLzIyIDQ6MzQgUE0sIE1pbmcgTGVpIHdyb3RlOg0KPiBGaXggdGhlIGZvbGxvd2luZyB3
YXJuaW5nIHdoZW4gYnVpbGRpbmcgYmxvY2svYmxrLW1xLWRlYnVnZnMtem9uZWQuYzoNCj4gDQo+
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBibG9jay9ibGstbXEtZGVidWdmcy16b25lZC5jOjc6DQo+
IGJsb2NrL2Jsay1tcS1kZWJ1Z2ZzLmg6MjQ6MTQ6IHdhcm5pbmc6IOKAmHN0cnVjdCBibGtfbXFf
aHdfY3R44oCZIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdCB3aWxsIG5vdCBiZSB2aXNp
YmxlIG91dHNpZGUgb2YgdGhpcyBkZWZpbml0aW9uIG9yIGRlY2xhcmF0aW9uDQo+ICAgICAyNCB8
ICAgICAgIHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KTsNCj4gICAgICAgIHwgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn4NCj4gDQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4NCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4gLS0tDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=
