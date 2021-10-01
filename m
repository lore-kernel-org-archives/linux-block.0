Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27403C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 05:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BAA61A56
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 05:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhJAF7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:59:01 -0400
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:35425
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230494AbhJAF7A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 01:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAfBIt2i7bGoIcgVb4zyNA2QeReG4teWpKVetTnqB48Hnf/Weu9N1u8DAqdl/irCcxsy5eHNasHrxhUCMY86lDj7Id8rTioKRLcsDKYK1x7gpdE5g09PJAaLIy3rOYLdP8fZrBYIZlk+HKbkl0KTanBNAUqS/izdD10wUi475Jv2/fHuLOuRefunXhwC2C4DVBlBmWWhqgwB/GY2d/GIYVcF46cY9E2L8R0U09JTZ/Q9TTi9Zb6loXqWRK9gftX3czujFF9C6lEgguFbpvM0AwJhZrWAsUgmdYS+4jLAAykqDdDAGX+sg2MONwc7aNDcCTI4BWQK9Io1Mo6AQDrTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9MRrPweVmG0MErEqMQT3btQ6Ww/Eb3X0DfrWcykZGU=;
 b=oFZi3tjVl0PSEj/7n/yD4MPcCdkH2yDaNn3EEE5VGW5Wx37DNZbaTDBdL0oNpvTk/HIjT0BNwFxbxEeHyifz2/i7wJ2JIH7bavZpWu9q3/aKbvhZmoCufOesR547xabPonIsrnJkk2oZYjlNKhP2k5+IHUGn0aPJcsnsrPZaB7w4101oVxFV5K6SK4sxpO0J+l43WkeQirXqeUBMK6zkkdpgVaZqwUPXJRYDPLURCvYga2oZLqX79f1fwqUdfl+aQbPG1g61ZtW3a581E3O+XeImdtdudVfsr0PihDv+Kduyk2lwQ2uDER01bgpNWyD1ls8DP3YyP571RsjbGIITIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9MRrPweVmG0MErEqMQT3btQ6Ww/Eb3X0DfrWcykZGU=;
 b=RnXceUMAAEMACTTGh4IACwR31caQmE0UMFgcV2cnFWGoqQU5jum8oTLEn7jIp/j9oGwxxqfBzyDPI79om9XeszwyXF/sbTnZEYcGBr5h0k1mwBPxbYrkAFbZTBZZ7utAthScWGQjlfsZo+olRlskNgWr2jh9iK5gqlrdOs6g8+iitvF0wwSEUIFaEdH3i7q5g6kMy7OSIcyK2DxVT4kajZJkvz2jlsWI1YzCcbxrOq+ZwqzrZOOJQilFo36KsbDcz1pyZ82qcn4uznK/yuidZfB1uxPWbzdZ0+8z4eWnGbHDgYp0xWCBlAguiPpR32y4yrMga31riErWT616vXc4Qw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 05:57:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Fri, 1 Oct 2021
 05:57:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 2/5] nvme: apply nvme API to quiesce/unquiesce admin
 queue
Thread-Topic: [PATCH V2 2/5] nvme: apply nvme API to quiesce/unquiesce admin
 queue
Thread-Index: AQHXtfqq6WK0J5FOZECF4SfNauzRTqu9pmoA
Date:   Fri, 1 Oct 2021 05:57:16 +0000
Message-ID: <4106f95b-7280-c468-d23f-4e01efe02f39@nvidia.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-3-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27fc56be-0fc3-435f-1cb4-08d984a05289
x-ms-traffictypediagnostic: MWHPR1201MB0093:
x-microsoft-antispam-prvs: <MWHPR1201MB0093BD9E48675D374749140DA3AB9@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlkP5wkqBL05DfwkqksH7rFqSML1tjmfLG8JkBKoqGOd4OZrMj2fh9m8kEwAau5PkLjRKhbT4+peRPhTHdu2sLZJHOl4m+mh2NEZl6WiCbr14+OAgHkCcCJ6d/w0FXQTmAccqWrx9jMAwmKUdRO8RNcj/Ep4E8SdZf0UXs41p9TztwpgbxFDnmb+KOl2Hp1oWBU7svl8cDRT6KIJTNIyG+Ec6qNK3l098cg0FtRn0vCA55AE/gZ33RXGoIcUUzQ4fL3ifOsGC2K65VMUcZsjvT2OggwsV9vFZt2ii31xtImtWnt7ABqvceWYUBtbWn+MlOFvQwRYQMK3QtgkAXTwSpu8rxVL5fF+Ru+XiGA9BmaLi4a6jh/fl8+uTp/SECpy6gfttYIvgSxF6FRTw9zHWjH1J72ZHbk7mJQlUgSNAwYIOCLcS06mxTb4tYgePVP0i7nDLSmqQ0nu9diUVSvRCgQoxyNcdRTzWtXl7P56RGcNRm7oZ5Y6MyQe37pt7xvEZ8uPdtMjH1/484epIB9K1x4Bqb7DlQlCCqR/E1KF+3o8R62/EOfLiDDkj49RpQrnDHUWy2updPUeN4k/05vJnNm84Uncm/0kSlZDg+5ARAzF1JqLa1f4srzGLUmwWrbkC6Pmju74Cr6dLAxYM2rQsFuwbydLnGo6SZu3SXMiYJTzygm/LcpcXg6deXItwDZ743zhPQ89wdzT5aK1sT/7ZyBHZ+KBMV/YRNQ/lER83K2SYlF7cRRy0bolzntI6vMyPsH3O24AbxG+xHE/iT49tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8936002)(6506007)(66946007)(6486002)(110136005)(31686004)(64756008)(66446008)(66556008)(508600001)(66476007)(53546011)(122000001)(38070700005)(6512007)(38100700002)(558084003)(76116006)(91956017)(316002)(71200400001)(26005)(5660300002)(8676002)(83380400001)(2616005)(186003)(86362001)(31696002)(2906002)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUxZc0F3V0dzVnpUNXhObUFKQ1pwZ1d5cUtCS1BwVThHMlZ5YXlBaXZOeGFZ?=
 =?utf-8?B?TlA2dUVmNTR2dlMxNnN2a3RCeHE3MjdwZ1hiVjJDVXF0M0Y4S1F5N25iUlli?=
 =?utf-8?B?aHByMVlFamc0dzRnek5rR2l2ajdlN0lGbHprMEpLYzdXaFM0SkttNlc5WGdB?=
 =?utf-8?B?Sm9rSVFsdXV4K0FNQndnVDFCMHZhbitVUERzcnNodFhoU1llZ2h4Z3hEUlhO?=
 =?utf-8?B?UEROc0tFZjRoa0UrZHlHYXJtNWpBbVd3NlRDZzhNQjdtdEVrK2lYUnArbWYw?=
 =?utf-8?B?dXFBWUZpSDI2dWxzQzhLbEl3TzBULzZjTFBEam51NC81cmdwTStrQ1lWVDJL?=
 =?utf-8?B?bHZIUUtWd2YvMlpDeXh3VzRuTXdFUUExNmJlRWVXQVBTMmYvV0lkdXdZVG0v?=
 =?utf-8?B?SmtxSTZQNHJEMkl1L3lhV1FpSGdVaEZuTGpPVFF2aGlaRVNCQW53WEEyQkdN?=
 =?utf-8?B?OHZITjdmMHJmQ1VnZ0xmVFRSSWpyZy82bzF6bCs4TmVndzZyak9JZllIcEpu?=
 =?utf-8?B?MGRGNWdiUHRBUG1PWHhpR1dZWEVJTC9lQmNtUUdHTjFPdE1CaVprNHRucnd4?=
 =?utf-8?B?RldvOFFVaFlEUzhtZllzei9KNVpteDNFeXowQ2NvWmowaWVOTE5BNWloQ3o2?=
 =?utf-8?B?a01GZ3Q4ZWVXSDB6VitWRlVKVVBIbCtMVlhmbW9sWHl5em1vaWNvOGcyejZ6?=
 =?utf-8?B?WFVVVEJRK3dMVzBlYWQzK2o3UkZmaG44SklZNFNFUXBwN1dkZWF1NG5oRmlv?=
 =?utf-8?B?ZUdZemxrcXBhNG85M21VN2ZqYkx6ajJ6LzZoYU5MNEc4UlRrUmJZUlFabHht?=
 =?utf-8?B?VEQxWHAvYThwOVZpdGJ5S2tZaTliK1MvK0hPbVNZTXVxeXBuQ3JnM3BIbjk4?=
 =?utf-8?B?dEE3bjQyR09RRGFOM1FWemYySGJtRHRWWnplN05vZzZDOSs5YnJPSHNwQ01Z?=
 =?utf-8?B?N2YvZVhzbVhyNXZZQURPZ1R2dkhKRXBsV3ZCLzkwa1lzcUR1cWY1cEx1N2xq?=
 =?utf-8?B?MkNtT0hPUk5LUFJ3L21wVmZQSEhzekY5ZGdybDdCZjdJTlllMG1DbVJ5UWZx?=
 =?utf-8?B?T0xaODZod1BhUVYwMlZBUXQ5RjFuMCtvU2I5NDBWK0JtUjJKWGNRcExxczUx?=
 =?utf-8?B?V3N2cmV4L3lEa0FCQ1cxb3dXTkN2bjU3ekpsLzF3enlBT0RaWnFnTnd6WERs?=
 =?utf-8?B?dytMWkNXaVNwckZsRW4ydld6RjNJVjhsMXRRSGNmTmQxVEp1MUhUb0NvcEcz?=
 =?utf-8?B?QXAvT20vTTB1dGpxNmdVWW83MlpiZkUvVVJBTW5SSDJLclluVHc0aTA1OTIv?=
 =?utf-8?B?eXJHQ3REVEJIWTFpU2w1SVVDNGhtTUNSTFBzVTBKc0t2NkdlYkJ5aXYrNVZu?=
 =?utf-8?B?TFUrd3hsR084dkJ3TGhTM0J3OTIvc1dCQnpvRmRON2hhQzlVblpKNHJtY0tU?=
 =?utf-8?B?VndZQ2g3T2FkdlI3N1VIdzNvTTVMMEFqMVhRWW5WelA4U1BoZzNHUlBNUVB0?=
 =?utf-8?B?K1ZaZzdKZkpHTHZlZWw4SjBtYjBaWUlRRWhsbGxlKytSRkRtblhkUzg4aVhy?=
 =?utf-8?B?WklseHBKSXRoNFI1elNwTk1VaTREUGVTSzhuRzkva2JNZDcrRm9QM3IzZnRX?=
 =?utf-8?B?dlpHUXZ2UTB3MjllZWFNbVEzVzlHaGJnS1lMNlFQWFJwQ2Q4dmNWSXRkbjBS?=
 =?utf-8?B?UHpONXYxQ3NDazNHdEFXVVhYajhzajVFbVRMVTI3dkg3eVV3aVVxWFBucmta?=
 =?utf-8?Q?tR1vWXsYW2gMvlLhVc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6BDCA49836C20449E20042D780BFB2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc56be-0fc3-435f-1cb4-08d984a05289
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 05:57:16.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/ZbpKEoQW5ctVgxChECPy0DaBSVgmMeyblVRtN3t7nKmDBibCIU64nzmMFgTbdjLbGIjVy0wu2W/X2HvfQ3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS8zMC8yMDIxIDU6NTYgQU0sIE1pbmcgTGVpIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEFwcGx5
IHRoZSBhZGRlZCB0d28gQVBJcyB0byBxdWllc2NlL3VucXVpZXNjZSBhZG1pbiBxdWV1ZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPg0KPg0KDQpQ
cm9iYWJseSBtZXJnZSBwcmV2aW91cyBwYXRjaCB3aXRoIHRoaXMgb25lID8NCg0KDQo=
