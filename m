Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5459C001DB
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 02:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHICEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHICEx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 22:04:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6281BCE
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 19:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hoi4zcQKNSgW0QKWD+EVJEeLJWhfHmRqW9vNq6DJydtQaBvbA5JxPtT1XHoIVfYwQ3HigOAb8xTnBsxLmu3tXks5wWV88UW3V/1S9lA/r20T/cR4vQAX8eAKNtFX5D8no05xv/wqO7BJY1N7j1uF0riiVkN+6hPX2V5NjP1BlYc9a3zaUvpCM+BcVFO+Yk3+yCbleUdmCKf/MNBQ5XoyF8UeY4Pt+nWCGDFPjBLpFS37We9DeG27NDskFHYEK5uJVmiKqp16P8Bj/yQodMVdUlVvjCtRjWVHmi0hGwChLlY7mOME4D6GCMFjU7wdXKn6A4XE8oSDr9ZVjQj64/g1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K76Ru7Q/dTzWJ7EfIEZ84Fjc1tfRRlrORjeUQAAEOi8=;
 b=Rklzjckle6DG1AnfQQKzCdpedqNnzugjVXn9laS19tZ9tUdT0sN7h95sYW17NY5UgGpD1GCeImIDA15qYqfGcEPHaQfgvYclxW8kwskZhMk14L9ovnr7yPJUVo+/MnCyBh6GkpnXgI0AWh1Se+cDROzKKfwa9eWYaFqvXUJaymaVl2Ga5O4OEgwBrDcVVuQ8+dm5uuGaE+Vm+SU4cOOsKJMsx4hDkEKTtvJJ+/BqjA+BgqZoT1z6/ml7SpralzwibfTs6Gj21hm5en5pvgQWkfyXgeEfURM91RZ3cYJQXlpp0Ld6YyXg8Ssbpb+vJC+tW3sjn/diDw6D8XweBL8WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K76Ru7Q/dTzWJ7EfIEZ84Fjc1tfRRlrORjeUQAAEOi8=;
 b=DILySkLldnj2Lux6GeRqsf/nFDPgO30QZyyun2l8qqu6RGsUDUSvY0odIxzaPOGnYVMypBU1rf3ovClTatyW0rV8gIYTx2PIB76An0XLA7ySiHtdyJxA3BmTig8YP8tWIf2QeMPy13NfwyJK6W/JIkqkbg2NqVLwA0fIy2BOr+xB66hwGPS5f+x5hxp8DuiYU2zNPFKRi9IqlcD8FNswvr2Tu3d9AR+j9dAmxZoOrH++flcs5abIsAZgV14fu5po7rj56wyyyc0mUWYFPmNZNHtghh3AMqHb94elSt50IZ0atdrgwIMJAdjIFbEC1WZK7QJUWHUiEVbLeCeh1zvWGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:04:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:04:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Thread-Topic: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Thread-Index: AQHZyiHRmxcHON8nMEys4gVjpcj1f6/hN32A
Date:   Wed, 9 Aug 2023 02:04:49 +0000
Message-ID: <db79624d-6606-ca77-ea5d-88bfd6885e30@nvidia.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-2-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 0fb5f5b0-9af3-4b13-ebc2-08db987d0365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smlp4uxdsDI+kOFfmMTlOhsq95tHSsP9N0qNBsg6XzvtIRAN9y15JT7U3fU5hgsSSjrV02YMGxquNzcKy2aWxaZcUFzuJKxVuzMQpiJUn31jpJi5oA8Az1mLrjloJ99cP9FwlmyrhOKkNLj/ZdcSxw3H61e67uvQCTKlL/2Q2kFZEIaEdPk/mTF13nCD6RGoCkJatGXOSMUDeuH3QWosU5P4PEnjVe/MmaFvgcu4YLTxsiF7p5suOtsNNlzBzPoWg9QQwO+ibKQ+9QE4CQ27XqzBpLE6wC+Msjk2W24B++eSvpvt5NCLyHm0qFzVcPbc56Vg3dKXQxuoE1lcwrtX7RxB7oBmY+yIo1oISyH8yKR+O+Bv/0fnzRD69EPGCYEKF12QC9q0RFRmgmb8PiSvN9N9aRVbq5NWWrWwNe1eH1vc5dJnLzEIcuuYeGawSLB/Cm3PW0YMMTDjGVuWgj3CP0rcANmvAoWNCW2YqF1eniDcA7PTXcAHMgZcsxqiYHTuEE+0q9ZSBDf79RPCOalPGap0OHYc5mrzqnJ3GM87zxKxfKJe51GUglN99JQL7E0K3zm4ZbEA19SYStr3WaROUMgDakmrpzunRzedWa8EcYCB68YbNwTf+uIl9Lvr+1Yd5dN5suRdPigJgTM6MmfXxxIKSw2wG4N21lc0B8EGh43kcuKh3qq/TWmyjVL+L507
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(1800799006)(186006)(451199021)(8936002)(53546011)(26005)(6506007)(8676002)(38070700005)(5660300002)(558084003)(66446008)(64756008)(66476007)(66556008)(122000001)(66946007)(478600001)(38100700002)(36756003)(110136005)(91956017)(76116006)(6486002)(6512007)(316002)(41300700001)(71200400001)(2616005)(31696002)(31686004)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1BUL1RsaW54MWlxeVRpYXRuM3g3MlRyUHdNQzFJZDBPdTc0ak93M1NoUCs5?=
 =?utf-8?B?MTZVWHpvMHFoeGR6Z0hjU1FtWmJDaTE4eXVNczZEam55aDVrQ0pOUWhsSnBl?=
 =?utf-8?B?cUJjeDFZMUxGeFNmQnk1Y2s3SUEwc3A1b2lsNjk3em1SNmx4eFVrMXZ4enln?=
 =?utf-8?B?ckdFK2xBclUrZ2xxZ0lPNHQ5TEVJR0hxU1FjNXhIVnhNZ2NvK01pMENnK1Zu?=
 =?utf-8?B?YUdFTFhyc0YrdUNmblNVYUM5WHM0S015OTFYSGgzVGNselNmSTR5YUZFRGRO?=
 =?utf-8?B?NzZwUmNEYW9Sbk9XQ1JuY2lGMDVDRWlib2lDbUtNL1IvV292NkpLL1czU010?=
 =?utf-8?B?RU9keVdwRTNicG4wYnd3TDRQdU10UkJua1hlcy9Kb253M1c5UnU4eHJKZ3Ry?=
 =?utf-8?B?bXI2eDdLcmYvd0JSdXI4S3pqN1d0cmlJcS9ScFdBS25taFRFMnY2RWNPTmVu?=
 =?utf-8?B?TGpOOW9jUmJWR01rOFdCZmNPSHRHQ2JURVVRVlNDd0lsb0dMaDYwajN1S05w?=
 =?utf-8?B?c1lTaVRFZHhpTDdudFF0bzlkTk9TUjZKVWI4SkJMcnZFc0EzUCtQSzVzMk9O?=
 =?utf-8?B?ajg2dkxXRnJzdHM2OGdHZFlhN3MzV0VmWHRGdEg0d1Izamg0MnptMFlXRlJV?=
 =?utf-8?B?anc2TWY3b0VTUWZOVU9KYW1xMU83K3R2WUE4M1R3dTdTbUJLRUh5ZHpBUW5m?=
 =?utf-8?B?QWEyUXZsM1IrbmhFaUpaUjhheE1IMFhXb0x3UThjQW9TM0xIdkNnaVEwZnp4?=
 =?utf-8?B?Q0p1bnZhbzU5MlB6SG9BMUVkOHVlNy92dDlNMVVRbkQ1alZTbFlFcWhvS0g3?=
 =?utf-8?B?aFFkVVFsS2J5anpWbjk1VDlheDRxbTREQ1ZLQkp2ZXZYdURVU1JmVzdRRFJF?=
 =?utf-8?B?Rzh5bmtONUJQS0VPaWlRbGswQmdQQjA1RXFwd0NHM0JZY1p4b1BXUzVVWVVF?=
 =?utf-8?B?Q0JFZHNrQmNYS3k4RlBzbzFsOHVRT2VGaDV3TW9ib1l1K2dsUnMzbDU5bWFy?=
 =?utf-8?B?MWt4Ky9mYmxLakNzWGN5NGtqMHVjcVVSbXhKRkdlOEkzZU9yRWxFTmt6Y0ZU?=
 =?utf-8?B?TmFhem5uSm1KY2JXdUJkTjdVV1pXeHRZK1drTktkUDN3a0NIOWVIZi81U0tk?=
 =?utf-8?B?ZGt3MWNvQ2lvMTc3WEsvTW40MnFFRDkrbEE0cE80SzJMRFBSOXhVcExPMHcw?=
 =?utf-8?B?eDYzVUVyM1ZYS29FMW9RR3hQZXBGcEJLdUVqSFd3NWE3N1pyUm52OWZrMUVZ?=
 =?utf-8?B?NTMxWjB1ZU9nVWUvVVYvcXR2ODg3MG5EcDNMc3RreGVYT2JqNjNnbjl2dXRl?=
 =?utf-8?B?YmpNMmt0aDduNkVDMFVtRVYxei96eDg2NHpDeVV3WWZmS0VZQXdhRFBqS1Zn?=
 =?utf-8?B?VDlGd2RpY21BdlQ2ZithT2pqZCt5WEM4VXNYaFIzcFB3TXMyNGZ6a3YxVmZu?=
 =?utf-8?B?SmEwcys0R09GdzRrVmNBZ2NRbGZZNEZ3VkZBZDVRd3VHRXJPaHl5L3JlR3Uw?=
 =?utf-8?B?TytETXVmcGRCNmZNaEZQelBiK1NjaEFTWU9aa0xYdG4wbDhWKzJwZVJLc2pS?=
 =?utf-8?B?Y2NtSW0vZHFaMUpIWVNqdHZEZ2hmMWZNbHk2b0Z0aU5mbXhTNmIrMTM0OEhC?=
 =?utf-8?B?NmI4RTJRVE9FZnJXcHFnKzRxTUlqem9JeDZyck9BcVRhc2VXaFFieG1LM3Z1?=
 =?utf-8?B?WnhOVFlhSlFNMm0rb1JuRWxGVW9yT082ejAxNk5XdnFsdEVuaFpGb0dDdEU2?=
 =?utf-8?B?TXYyYTM4cGJTTmlrLy93Y3VnbkFENTRTaW0vREtUN2EzbVZYRkJGRkx3VW1l?=
 =?utf-8?B?T1VnOVdjK1BhWmptRGNDZTh6K1g2M08rSlVqbGRxeUZENUdqd0NlV2k3a201?=
 =?utf-8?B?OFN2bXgweWxvQ0pJKzNRNE1jUGVJSmY1a1NwSzNsbnkydTBkd1dxRmp3R3NR?=
 =?utf-8?B?WURmRjYvL2k5WC95NEhzMkpLSndRSEREYXFlSStEZ2hNTTNieUpzaEREdFlG?=
 =?utf-8?B?TUVOekpodzZyL1JHV3N1bjd2eTJPUFNESFlUM0JNN25Ld011SlV4M3FUMktZ?=
 =?utf-8?B?Z0tXK1N6UmdwMTU2ZTg3OXdYbmNIQ05HdG1FQXUwSkEvcm5hWHlIM24zcXo2?=
 =?utf-8?Q?ITJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3453B5657F8644DB9F79FEB112F3165@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb5f5b0-9af3-4b13-ebc2-08db987d0365
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:04:49.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfTQRedE6nm/mb+deHLogKYVLA4Z+C45iV0wOBVkHoNa3HPSfgUt6v+9lQ17E2XkJiDJ/Dyp9B6AXbcs0A/raw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC84LzIwMjMgNjo1NiBBTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFJlcGxhY2Ugb2Nj
dXJlbmNlcyBvZiAiUEFHRV9TSElGVCAtIDkiIGluIGJsay1zZXR0aW5ncy5jIHdpdGggdGhlDQo+
IGNsZWFuZXIgUEFHRV9TRUNUT1JTX1NISUZUIG1hY3JvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
