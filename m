Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F13EC636D4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBOVVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBOVVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 16:21:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751433A099
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 13:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv37Gm9VpOVs8x0XPF7xsWrYTu9p3CNU18zTk9sducgO4238I8bsL7ef5yP97ry/GvgeopOWzyLtUbWeBf5dUTk6Ffn4NBdjJ38cgpBAerHm7TzrsnN9zj9/ehDx3J++xgMkPGo6Jdl7HOpgWCFZSsZrKIyvKty4gvZ6kp1hT+xGU3XBlJ/NWUPXjNHG1Oy4n6dCBF7qJSoeWR0CxIQZ1dDWvFI5LGjrIVpTJjnBkv5W9jlFb3F4sqADpa/urxN6gz3FHGFRBRHjARQspAce3fK6kIwodTReqmRHKWrRneG6lMGkMPKVgpb4fquePkylqwIicO4bLLOpthEVQE9XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wukHQWTyvHVTUv0Mn4pwOyZxizKWP8YB9kizPbtd2Kw=;
 b=nfxeXAqvDWf0r2pkSH2k3q0LW4nGiX00vEgYT8Mao1+kdq0JmgzL9VpDf8Hpp6TAGn5YAylJKOOJ38P1vC/uxaaAbp9xI5BAUEzXbOui9aX7peMwxvkq2gMaRxbzaWcrd796Ruh3qJ/UKl0kPIAXBgrKFS3iprnkOXn/62lTxSFOWpjbz7T0kNQRY/8C7WbmFyonlKbRdDcVpDbLxyFCzkwO6uCxqM3t6YHTkzK51/LUnqoOt9QDllI2guudATSMj+r4dQ7mnQQgeFZnMcA0zRGkEqkoc8VJ4jVbA6UypN82DIjB91auKeAs8SF7irmDpaHmKJyJ9bB0iXf4sbGCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wukHQWTyvHVTUv0Mn4pwOyZxizKWP8YB9kizPbtd2Kw=;
 b=OtQyWlrZ8EHaxN0Qzw44XLLfqL60Qy8jCgLCiPOWSgVL39tml5NaUzIpOxwkXzeBqlv56RHOqGMv5LkIsUckzu8hhnI1ru14tIV3NjDSR5PfJ892Ep4EA1x5T8KbpYl023EyJgQnhyBuhiryPDxA9WLiCgrrs5A38p+dsCtaMSD4PePMfPUZyrNwFsezIoz8OYlfIk97WnAD5yDfH9cuetmbBb5k5vnnSvud6DmqNss+8OnhFAviZrL6e8qd9KTP3cdMs0QbFB/ty+WyFhv2mFB8DqT71krIP7Y60nsGNH5geKL6sq4W686j6rRsCFgjDUiP4dIpgdbgka5WQfk4GQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 21:20:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 21:20:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Saurav Kashyap <skashyap@marvell.com>
Subject: Re: [PATCH] block: bio-integrity: Copy flags when
 bio_integrity_payload is cloned
Thread-Topic: [PATCH] block: bio-integrity: Copy flags when
 bio_integrity_payload is cloned
Thread-Index: AQHZQWF9kRrMAGpF/UuqbP70/OV12K7Qg/YA
Date:   Wed, 15 Feb 2023 21:20:44 +0000
Message-ID: <45b9231f-442d-b1e5-6c80-e8725beaf62d@nvidia.com>
References: <20230215171801.21062-1-martin.petersen@oracle.com>
In-Reply-To: <20230215171801.21062-1-martin.petersen@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4256:EE_
x-ms-office365-filtering-correlation-id: df209b57-7de7-4781-d39a-08db0f9a7fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjpy3TQ5+VP3LSkS7rNR8zoCPhoDgq95Qu8ZWgnWJIgkFTsRRdFpZliKm//RtihwEIltIp+lV4o2EMIcMaOLbH8mFekAx28YCCs79Gh3VRoeyEbMR/mlCsnixSisuvxgg2F7U10+LNOKTTKePwYPgAeSFq/SLiivITxsH39sGp8Fnhes+zjCf2El7GNupzrEelSYiCROmIHJIn6AknoJwcJsiv6RzVtrwUiq9tg4CpaCRYXzKidsGI1E3x4AUWUff2qZIwXHNiOTY+ZJrapZaLnKij4QHpDSSsxsrGjUJer+7Wwy4pLjEH73uAK4QzjtT/dS3CeXzihFXFzQtNssq5Op6kybOA70GowEtbqaK0ClrIqaAE8p6MZE7RqUnzahl5j9JLxxU7pIZANtkDBeEpj1Ntx9pAiBo5g7iB05bEbpnOlGBPes0mfnmc3TjSpNmx1epdJGcP89ckYMYvsPzrrjF4RwigMVbm7ZhmysatMBOGMmt2M+6js7Bpgme1vlVgp3O6uoAvhoKIp3sdWfl+m1X09GkcUS4tdlXZt+lztdlzEOirHkQ25RrB8kilSDdsPwFFwJNWRhfF2hK2z7YLbDwcsiRDuQWdFBKlF1eRGrySIuAJGJne8vGkkI9463vwLBLKa9qDj4SyZPMMmRC99UZbrzmnuJMzP/abovg1rLVczLhOQqyPnhWgLtce8ywUzwd68Oc+/OCumsZI0uQjYi7EJAkcgSMWMZCLOrL2cufAjYWslGRXJtTXR+ZapuKz6NQoTQGOtRCpKqyexdCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(110136005)(83380400001)(478600001)(6486002)(71200400001)(2616005)(6506007)(53546011)(36756003)(186003)(6512007)(41300700001)(38100700002)(5660300002)(86362001)(38070700005)(4744005)(31696002)(31686004)(8936002)(316002)(66476007)(66946007)(64756008)(66556008)(2906002)(66446008)(4326008)(8676002)(91956017)(76116006)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFdzdXRRQUJHYldpSVBYUzV0WklZVkdqd1pXZWN1RE5hbmZ6Z3JNSmxiVm1U?=
 =?utf-8?B?R3pnSEJhZEJRZFI0eDNQeTNhZjVaWWhCcTh3NDY3eHltOHhCWnlKRnZNejJm?=
 =?utf-8?B?TlRJKzh1RUhKOVFMWHVRUGk2S0ovSWFpakJwUmN6RFlzQjNwNjdIWldHM25x?=
 =?utf-8?B?b1psbGFtUEdUZ2tCVFpzcmJ5aE0xT2pNYXErczVmcmtKTWhKUHJxcHY4R3FK?=
 =?utf-8?B?dmlHd2I5aGxhOXo0Skd3YUMzYUdDd09OODI3V1BFYmpuT2xOMTh1NDFOQy8y?=
 =?utf-8?B?NWhBV1NRZ2J6Rm9sc2x1ZGpBYkRJRlBoVVoxNnBaaVIyZ1Jqd0E2MWhDaGto?=
 =?utf-8?B?NWYxWGIrY2c2OXpkWlZ6b2tHSG5tQzZySTJhSUlFV0lVMTdXcFU5Q3lONFVz?=
 =?utf-8?B?ai9Wcml4RklCYWxuVStSd2dxNnQybmE3NGJCdzlBbWVzektQTjEwMGN6Kzh3?=
 =?utf-8?B?aUhTNGRYMks4UVd6QWxMYjhjaG9QUlF4U1dwdGZYS0oyZ3JTdUgvQzczQ0JN?=
 =?utf-8?B?WVNlaWFOaDFodkVSdjYxaUhod3R6aTY2c0IrUWZLNVgrbS9veVRsdzVIMHBJ?=
 =?utf-8?B?ei9nbTNNUHZwaGthZjArN3ZNVmZWVmFmcWlHL0tqUlM5OUtQMnA2RUxYMzF0?=
 =?utf-8?B?TDJaOEF4YjFqTXZ5dFBCWDZGNGloMEZrMzZHTWxmRmVvaVZ3UDFFSDhZeVdx?=
 =?utf-8?B?LzFTcjRnd05OWTBzUE55WHZ0S2g3WGZnSXNTc3YzUkpIaEs4QlV3M2RWbjVp?=
 =?utf-8?B?L1pKa0tNWlR4TjJyd2JQZU1raUh0N0Z0eU1ESFE3eGZFelJnU01HZ21yQTVH?=
 =?utf-8?B?NFB0QWFIRU15aWlIVStwbGZEMTg5dE5sbUdVSXlpNnY4aW16KzZKVDJQSTlU?=
 =?utf-8?B?eFdxS1ovWVU4eUJnYmp2MDY3T09JU2wxdGg0RWt0WmZGTHM4UXpZRU9nc0h1?=
 =?utf-8?B?VFQ0UFl4c3hGZEI1a0RUdWU5SWVRdkZYY0wzOWZBR2ErZEQyZ1NLYTZ3KzdE?=
 =?utf-8?B?N0luZDVucWZFcXlxeHBrbGJOaVY4VU1XK004STZmd1hDUUtLMm02dnZZZ3pr?=
 =?utf-8?B?NTg0R3pUbVBHWnRIVjVsVG5ydTB1R1ZRTU5Xb0lOTWRBOWxjY2FrYnVNcldD?=
 =?utf-8?B?aGZJQWFrV3d1RHVnVkNlTHhiWTVTMGdFUHRzd1pucURLcnhkVDBxSTBXcEE3?=
 =?utf-8?B?bys0d2ViaWpKUWxQQ3NvTHhLQmZZSTIwaGd1N1JJQnJObWpHakVqZnc5REhU?=
 =?utf-8?B?OFh4ODFkR2ZFNkx5TTg5WEVrbXlncXc1djBGOG0xSGdTZWVMNmIvbk1jNXI3?=
 =?utf-8?B?d3AxajJaQUtKVFRoTk5jV3RUbDdxZ3h0MDlrRmlqVWljeHBGeVJWM1M2aVN4?=
 =?utf-8?B?aCtDd3dyUmdiZmRxUzJpcnlCR2NiN1pCUExmemlETnN4QnRSbW9WcFlyUWhB?=
 =?utf-8?B?TXBwYnNtZWFiZE5aZGFmZmY1K0hPblBPRFZZK1JKRzgrbjQ2MXZSVVAvT2RY?=
 =?utf-8?B?VjJvcDgwM3U1bk8rb2Fmd0JOZFpXQVBOTTFScVBESG5NSm41MFFibm1WWWMx?=
 =?utf-8?B?NEpqU1BONTRiOUkweDRIVDJJL01CK0U2L0kzZ2g4MU02cG5nV3dlSDFWQ2xz?=
 =?utf-8?B?WGVXdWJyQnlCY0U0VTBBdUxVWnZjdGxsdjF6VGpkem5MbzBzaGdlSTVPSkZ1?=
 =?utf-8?B?WUdZS3h4WTRjVVlCdThtV0lYUkw1cnVJZTVOc1R1K3lOYUhucGY1OG1rcjEy?=
 =?utf-8?B?NVk3d1REZ3JOUUZrbDFsL3RUbkhYc2MxOHB0ckRpVm5NcGJ2OExoVVpzS0gv?=
 =?utf-8?B?RmZyRGdDdGw3aHdhbzIyZFNWZ1dPMGRIZzFnM0FpdGNycDNZaDUrc29mZHd4?=
 =?utf-8?B?M2VYTVlrOVN5VDdlMmllMjNVWEhGWE5wcnJzZUV4SkpYWUE3czNUaHo4Q09X?=
 =?utf-8?B?TXNUZXdCV00velU5UDdTVjMxaWVZK2xZOVhDc0ljVHhaaW55SEFPZFZwREEv?=
 =?utf-8?B?ZUVMbklLQWRpNzJDUjFpZ2RHVGxxdXRNMklWeDVvSG9TWXN5clkzbC9nUXlX?=
 =?utf-8?B?M2ZoeGE4SitJM0NkUkVQbXMyM1BVM2NVNUNITGtnRVpoQVplYnRiY2F3ZVV3?=
 =?utf-8?B?MWlnQW1zR3BneW1KSG9PMkljbndXOUNIMThmQ1BKRThJY2xEdHovYmsrVmxF?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0353CF3615AA58448B6245718B063D62@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df209b57-7de7-4781-d39a-08db0f9a7fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 21:20:44.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXTIJCO2M9UcRiPc4BEX34ndwifJ56ngFXILV3AgAbrwbmLFIo+j9tNfsDKTm/dGWKUI9Nrp2dbS9XW/BxOGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMyAwOToxOCwgTWFydGluIEsuIFBldGVyc2VuIHdyb3RlOg0KPiBNYWtlIHN1cmUg
dG8gY29weSB0aGUgZmxhZ3Mgd2hlbiBhIGJpb19pbnRlZ3JpdHlfcGF5bG9hZCBpcyBjbG9uZWQu
DQo+IE90aGVyd2lzZSBwZXItSS9PIHByb3BlcnRpZXMgc3VjaCBhcyBJUCBjaGVja3N1bSBmbGFn
IHdpbGwgbm90IGJlDQo+IHBhc3NlZCBkb3duIHRvIHRoZSBIQkEgZHJpdmVyLiBTaW5jZSB0aGUg
aW50ZWdyaXR5IGJ1ZmZlciBpcyBvd25lZCBieQ0KPiB0aGUgb3JpZ2luYWwgYmlvLCB0aGUgQklQ
X0JMT0NLX0lOVEVHUklUWSBmbGFnIG5lZWRzIHRvIGJlIG1hc2tlZCBvZmYNCj4gdG8gYXZvaWQg
YSBkb3VibGUgZnJlZSBpbiB0aGUgY29tcGxldGlvbiBwYXRoLg0KPiANCj4gRml4ZXM6IGFhZTdk
ZjUwMTkwYSAoImJsb2NrOiBJbnRlZ3JpdHkgY2hlY2tzdW0gZmxhZyIpDQo+IEZpeGVzOiBiMWYw
MTM4ODU3NGMgKCJibG9jazogUmVsb2NhdGUgYmlvIGludGVncml0eSBmbGFncyIpDQo+IFJlcG9y
dGVkLWJ5OiBTYXVyYXYgS2FzaHlhcCA8c2thc2h5YXBAbWFydmVsbC5jb20+DQo+IFRlc3RlZC1i
eTogU2F1cmF2IEthc2h5YXAgPHNrYXNoeWFwQG1hcnZlbGwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiAtLS0N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQo=
