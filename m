Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D99C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 20:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEPUl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPUl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 16:41:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849F102
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 13:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhBeZ3EYvcOQ7EPuChLXSj043AsYSnej8MYHbv9lk9MRkOz0Spx8T3pfLid3nFzjjG+vd76jUqIR2L1zt8EZ/gXkWQXrD1v3THGLZSS/MdXp1DqAZJUsH2Ie+ARF/6aI16CgrGWHBvpjOodK6ZajV9HC3T3gJssDanXWg8LGoflM6hRW8ye3ULEnPZ1KnNmBAULNXp8CcjBYmFioFdrV3V52Oz261vRU9M2+IuB3M/yA7oHDJ3snPP67wD9EbulB5tx6WhLcfQvke2a4z/qOGA7R03V0lhXr8csF+5rEzG9/YUneROT+h1JrSCLQE7ywtr5i5Ve+H/dPI0whSqTPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w7XlM/B8mAV1h7LJELVdgOFzT0ay9pqcyvAGD8ah/U=;
 b=h/WPVGC8ffCDdmApcYxoxcHGZDzqJzsCIxar8Kr+LPZ1uC4xrPyvD/o8HlgxNz5O1AAE0fjtDcZse4o8xluS1xnhStx7jER74WUtAk3YCtcigZle2oIhNDAtFRkXq5wONO1GDaOIxzIM7ncuehuXZEEM6KIPg6HG/a8ExQtLD/yY9CLXJSJpJiP5szxgApvgzajhOcL02c8kJk64ntsLAGAUjVZUlPdsibRlU24MYhjJfNT43r0uzPacFSbu0cXXvkJ7tebGlpMcI5b3blcDiSUdTLQoZ7t7SknSTCj1Z1goGUFX2fUE8FnKOinmbIhxbckjkdpV8g2K03204UoEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w7XlM/B8mAV1h7LJELVdgOFzT0ay9pqcyvAGD8ah/U=;
 b=O6amzNXB+ZQi2OuLsUK37hdbGWgljdvRqeoaWE8Mwd8VLUVxAus53KwxEabT+tsMsIcSHG9TsLAW4sLxF9tGwe65laykz/l//K/WXYFmCwGNxtOrNXgLn4mnKFNGj9gX3ZmKmCnnk0JnH5ZiPZgdwQQD8md4Gn65tn4Nav8eow3i+yjnOJABNpNVFTtFYxYpOhHznA/pIWu8TBQltZFqtFLRfLU3rSCU+rwyhrtsVdzNVU21vox2F/nhdEI8OhBxzROCIKJoDUkr4wIjUYA4qVRMSRdiAZDUOUkawhwmYDX6Ab7wBjuNFH7lwZtvCvEifCy6Cq2eEtdEdU/R7r8RSQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:41:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 20:41:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZhKwGybbeYlqu5kWZNgFLfXlVx69Ws3cAgAAA44CAALB7AIAFBqiAgAB6RwCAAH6RAA==
Date:   Tue, 16 May 2023 20:41:51 +0000
Message-ID: <706d4933-20f8-05b4-110c-30ba39b8a023@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com> <ZF5NssjIVNUU9oIA@infradead.org>
 <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
 <b55b03ca-7967-faac-20c9-5c1ca6dc171b@nvidia.com>
 <2e6864ef-394d-f43e-9175-a4f3da65c755@nvidia.com>
 <20230516130850.GA298930@google.com>
In-Reply-To: <20230516130850.GA298930@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4503:EE_
x-ms-office365-filtering-correlation-id: 4bb0e140-29fe-4f62-6499-08db564dfa92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byt93j8kNjysl6Q3CcC1ZGwJGF/NTFtJDl+ehHeGFg774hEw9F85euJYjWR/DSLvmpVbUBGZbSHRMy6HWjHnWjxfKkemqPrKrWxCwDfZpkH7HSx3+7qDu8INTEhe8dwnPx8o/m+tIQWRV7emqEBApPhvImpEDOn8ctoGtY9USGnBAyz5GX2NYOyfQDAgDN2Spv4o0gZObDmkTkSBuoEioi/IWPBNS7xHpOdyAeky/Ouejyuk6MmpcOjoWInTKC3DHJ7OdCbX3d1pcwNuk9e404Ke3zaTQrVaGTkrMIHkM+lgGBM5rp6J7iocxbxaVAPthq8gYF1tGbOhsUh40VwC94JzfryC0iZc+aekdtuNuqpAltsIRe1urkmrixmPEd0q901yziJ5PzwBq///s6K0Nl6XoYME42Vn+Ea4nZ8pnytMSpqBOT3o2LLEUNu0YG6pXN6wl+Jcxg3U6JENWkc+/JoDhXZov1aQQc57UEVzhRNHEJdiNgw4msP/whyrqcOjAssAneiOrAHp1pf1PienMovn//StfYqSDpwV14D+pMKRKlcnifQ+aNq2tjCXTE5XyZw2NbAQBlBzBaGHczXMl2aQ5p2YKuU+VNkMJyT9OxrDuqgmdpB2UTroGsv8SGsbl6OXy1bgFFj1Km5ULWp0RPostnhcALEXftEDT1qmoXS7zkJ23JHtY0LvCIT9Kaxn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(31686004)(6916009)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(478600001)(66556008)(316002)(91956017)(54906003)(31696002)(86362001)(36756003)(38070700005)(83380400001)(2616005)(6506007)(6512007)(53546011)(186003)(6486002)(2906002)(41300700001)(5660300002)(8676002)(71200400001)(8936002)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0w0NVFOSnk0anVBc0YwcG5tNlNhQ1JaQTg4NnBGYXc3blJHOXhXVXAvbU1V?=
 =?utf-8?B?d2w5MUVyNjF4UGRxSHJLNEJ1bkJkMnhxUTVkbU4vSmJLRG1sZ05aekJWSWp0?=
 =?utf-8?B?VHBTZ2dvQ3NmdzNXRUdtRittcGdiWVVZQXlaZEJUeDA1ZDYzWER4cEdNUzVy?=
 =?utf-8?B?VkhOSytTKzlJcGY5UU5QR1FnMi9oOHZCd2o3SUJtZlEzdjd1aWNkUDZqNk11?=
 =?utf-8?B?MnhLMnFDbjBwbldXMUdFeW14Y2x0QVdLYXY2ZjVVYnFnbGFGVWQvaXN1NGZW?=
 =?utf-8?B?TFo0QlBEZ0xhRDFTbjdGVXRIOEhKMzZMWkl3YUFpeWpaOFVMbTRXajRydm91?=
 =?utf-8?B?T3BCREg3eVhqcHJIeGJ1UnVLMmlnNitxMWFiZmN6a3JTaVBwSitPOXZ6dDly?=
 =?utf-8?B?cmF1S09JUmVDVUZUa29Jclc3NXZlS1pQTmJTSmZvMko1b1NTSXp1M0I2enVn?=
 =?utf-8?B?SW4wZUF0YThGWUZKZzF2QUZSYUFHdzhBUU45M1hTenRJNkhtclZNWDVESjdR?=
 =?utf-8?B?dDdtL3dacWNnZFVneEdHalVYMEh4MXl5SmRCOTFCREt4UldOU3lFRTBLd09x?=
 =?utf-8?B?OCtGdWhHSkFDaGlER1g2VnljN1BlbDlPMDIvd0RsUk14c0UxanVGcnIvK0J5?=
 =?utf-8?B?Mkp5b1l3N0hvRGxhaytNWWhzQThVTTVNL1B0czB3MEVIeE9uSGhvcSszRmZk?=
 =?utf-8?B?L3dTQUIzVHpoc1oxTFZkbnRUa2hvdzJobmVMNVlMVWVucHVLUWk2K3JWU2Ry?=
 =?utf-8?B?aTVtSVNnTG1La0NRbUp6QmNFY21TcUd5WGhaSmc3TVNNbG5BNFhXMGJrUWNI?=
 =?utf-8?B?eHcveGtJa25jM1VVWm1ydk83MGpWYjdPVE1SV1ROR01aT2JjRWx4K1AyYSsv?=
 =?utf-8?B?c3g1SjFVZ1ozVThTSWdlaHJob0ZWTVJwd0Z1MmhFT1FlY25Rc2M0WVhnSExs?=
 =?utf-8?B?ZG5SUmtQdklzUEtoak45aFpBeTRFZlJxTUM1UWhUbUJ0TVpSbW9UdFhvUTE1?=
 =?utf-8?B?LzhZVXdXMFVMNkg2c0FWSVRBemNYbmorU2tseHpaTFZCemJLRktNTzlQZk5v?=
 =?utf-8?B?UUJaYnFncDJKK1BLNmF0eUxtN1djT3dSeVJuMzBjTVRlbmV2Slp3Nm5aakJx?=
 =?utf-8?B?VWdRL09Zd0RSVzVLOThpVEt2YnRyZXRrUHJ2R01pZ2xUZTg3RjBqbGJlWTJQ?=
 =?utf-8?B?VXRZRlc4QU5oaCs2bFVEcEFBRnhJamxydlo2SVRyOTNvU2FpcGl3eFphV2Rt?=
 =?utf-8?B?RW15MnJiR3VocHNSWTAvRlNwZitqNzJmN1l2Zjk5OTc5OEJQWWVzVk1nZXU4?=
 =?utf-8?B?b25PR3hjK1F1d2ZlbHpKa0o1QTlOekxLR2wrZXl6SjRpM3JtNEthZ2RnY3Ra?=
 =?utf-8?B?V3kwV0xOampQSFpzcFo1TTdsNU5nK2RFVUdnL3p2SGMwbEI1elZmNEorTmZF?=
 =?utf-8?B?TlhxeG5kRktDekVOSGQ3NG1VYUcwKzVmbjdJdXlrR2VCa0hiVFJOckUvT25W?=
 =?utf-8?B?NllCeUlEaFozY1R6OXp2ZnkvMWRuSFFJQTFQTGlCQy9HK3ZkelRmbkFUZTJZ?=
 =?utf-8?B?RDVOWjdQNmVWVzNYL3h4dWZIczJXVGpSQU01cFdpcHdWSzBPK1JOSjhGNEhK?=
 =?utf-8?B?ekowNFJGV0llZ1IxTWRnK0c0UTdOSUJsZldZT0NYdHlzMXVhM3lnazNtdjZN?=
 =?utf-8?B?dklzTVdwUXJ4WXZ3Vk41NVdDaFl4OWUrL2dtUnBpcmZXajlVUHY4VHYrTHN4?=
 =?utf-8?B?RGJiTUNkcTNmRUpsUnV4c3ovM0E0Ryt4a2ZxdENQMGFTOWNVb0NROHc2c1BM?=
 =?utf-8?B?UEpkSTQ5VDlQT3M4Vy95OU5pL2Q1ek5lUzBEZGRESFpMbGsyOUpmS0Fham5S?=
 =?utf-8?B?emZueDNjUDZWdjczb1FPczBLSUZqKzRTZHhjYzJXcnV1Vm84YndHeVVxUjg3?=
 =?utf-8?B?RS9yWU9UL0cvdGp2WG9rT3V3MWFBZXNUYTd3Y0hKUXRwd3RkSEZHRWVqaXhS?=
 =?utf-8?B?NmFlSmlJOG9uanNyR1lXWVZZQWhSa2pNOS9Tdnp6UktNTjJsdjNqVnBaUzZk?=
 =?utf-8?B?NWxld2pRdnhPWHF2WCt3NmExK3dwclBmK1JRbzZtWDdJOEtLTlA2ZGJJQklz?=
 =?utf-8?B?WHh6blovNFduL1JJUStZL3dEMmFteGxxS3BNV2tvTzdKTlVqcVo4WjIzblFs?=
 =?utf-8?Q?9BQnnDT2/4SEtAb9plifVcOIjS3IBvVQj19CixbZWbQJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3CE72D001EC354F9BBAFB958703C3AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb0e140-29fe-4f62-6499-08db564dfa92
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 20:41:51.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9h4LkKFVjyTOGpAIHGzivTBew7gYhKn9sDKz7ZywKyKQNMrX27BFtQKP5hIQObkgjcQKxkkSnoWpjrm7uBBPww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xNi8yMyAwNjowOCwgU2VyZ2V5IFNlbm96aGF0c2t5IHdyb3RlOg0KPiBPbiAoMjMvMDUv
MTYgMDU6NTEpLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBSZW1vdmVkIG1vZHBhcmFt
IHYyIGlzIHJlYWR5IHRvIHNlbmQsIGJ1dCBJJ3ZlIGZld8KgIGNvbmNlcm5zIGVuYWJsaW5nDQo+
PiBub3dhaXQgdW5jb25kaXRpb25hbGx5IGZvciB6cmFtIDotDQo+Pg0KPj4gICBGcm9tIGJyZCBk
YXRhIFsxXSBhbmQgenJhbSBkYXRhIFsyXSBmcm9tIG15IHNldHVwIDotDQo+Pg0KPj4gICDCoMKg
wqDCoMKgwqDCoCBJT1BzwqAgKG9sZC0+bmV3KSDCoMKgIHwgc3lzIGNwdSUgKG9sZC0+bmV3KQ0K
Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
IGJyZMKgIHwgMS41eCAoMzkxOSAtPiA1ODc0KSB8IDN4ICgyOSAtPiA4NykNCj4+IHpyYW0gfCAx
LjA5eCAoIDI5IC0+IMKgIDg3KSB8IDl4ICgxMSAtPiA5NykNCj4+DQo+PiBicmQ6LQ0KPj4gSU9Q
cyBpbmNyZWFzZWQgYnnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH4xLjXCoCB0aW1lcyAo
NTAlIHVwKQ0KPj4gc3lzIENQVSBwZXJjZW50YWdlIGluY3JlYXNlZCBieSB+My4wwqAgdGltZXMg
KDIwMCUgdXApDQo+Pg0KPj4genJhbTotDQo+PiBJT1BzIGluY3JlYXNlZCBiecKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfjEuMDkgdGltZXMgKMKgIDklIHVwKQ0KPj4gc3lzIENQVSBwZXJj
ZW50YWdlIGluY3JlYXNlZCBieSB+OC44MSB0aW1lcyAoNzgxJSB1cCkNCj4+DQo+PiBUaGlzIGNv
bXBhcmlzb24gY2xlYXJseSBkZW1vbnN0cmF0ZXMgdGhhdCB6cmFtIGV4cGVyaWVuY2VzIGEgbXVj
aCBtb3JlDQo+PiBzdWJzdGFudGlhbCBDUFUgbG9hZCByZWxhdGl2ZSB0byB0aGUgaW5jcmVhc2Ug
aW4gSU9QcyBjb21wYXJlZCB0byBicmQuDQo+PiBTdWNoIGEgc2lnbmlmaWNhbnQgZGlmZmVyZW5j
ZSBtaWdodCBzdWdnZXN0IGEgcG90ZW50aWFsIENQVSByZWdyZXNzaW9uDQo+PiBpbiB6cmFtID8N
Cj4+DQo+PiBFc3BlY2lhbGx5IGZvciB6cmFtLCBpZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCBleHBl
Y3RpbmcgdGhpcyBoaWdoIGNwdQ0KPj4gdXNhZ2UgdGhlbiB0aGV5IHdlJ2xsIGdldCByZWdyZXNz
aW9uIHJlcG9ydHMgd2l0aCBkZWZhdWx0IG5vd2FpdA0KPj4gYXBwcm9hY2guIEhvdyBhYm91dCB3
ZSBhdm9pZCBzb21ldGhpbmcgbGlrZSB0aGlzIHdpdGggb25lIG9mIHRoZQ0KPj4gZm9sbG93aW5n
IG9wdGlvbnMgPw0KPiBXZWxsLCB6cmFtIHBlcmZvcm1zIGRlY29tcHJlc3Npb24vY29tcHJlc3Np
b24gb24gdGhlIENQVSAocGVyLUNQVQ0KPiBjcnlwdG8gc3RyZWFtcykgZm9yIGVhY2ggSU8gb3Bl
cmF0aW9uLCBzbyB6cmFtIElPIGlzIENQVSBpbnRlbnNpdmUuDQoNCmFuZCB0aGF0IGlzIGV4YWN0
bHkgSSd2ZSByYWlzZWQgdGhpcyBpc3N1ZSwgYXJlIHlvdSBva2F5IHdpdGggdGhhdCA/DQpJJ2xs
IHNlbmQgVjIgd2l0aCBub3dhaXQgZW5hYmxlZCBieSBkZWZhdWx0IC4uDQoNCi1jaw0KDQoNCg==
