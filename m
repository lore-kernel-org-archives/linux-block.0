Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF3C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 09:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349724AbiCPJ1x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 05:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351465AbiCPJ1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 05:27:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA1E6540B
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 02:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzCTPFfn21Ua1GXlQKa716N8Qqrc8F8yMDxV0Gba9G9EJ8NbBv26Jg4BCQBXDOflXfTLiie+L/4vk94XiQSetBMvZX3f49vB8MGbKMQLtjYA3LBFGLseeA4tTIal0OOSFG7L5orGE7tmmgNuhZBcOVgeC/Hi+HACbdUIMGN/v9k0OHhFmyKdbDch8u5yuC93DzGq12eXPa4+nqe2uxmHgEbytFRfxyxJKNHbg97YiqQ5Ybsq71pmgflwRYyoxXwA8BWsmYOwhEc9uo4Uu52ae++8EbcXsoOgERqPzel8VGNKYWT4zmyLl5Pxh27lFkRU6CND2d3FYFc/rjTVQnJf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M18XAa8WBf/ZNrEOv2wDdKR1N67qkzHssSWagdb4ZMQ=;
 b=RYsALhZqtDUMGhy8CnjIOn7ya9KvfjefY6yLF8oiIQGEoLqY6Vp7SU44EBA+Hdl5XvaqDD/3ggbmHIt/SG2hZjkSjB5fKGwAjF0fLcIHuUztvMlYhFQZu1CUuXDpCshY+nFr9yEVl/kQrg9somiVSufwkVd9vmcKb2HHgswvYOzzoeictSP7c1bSYntcL3dtDXR7+9AkTpo5YDK3B6o7hQIqG0fSFoZv+y2isaAesmFZKBJBWzY1gizQpiNJPXCsV35Z8lvYYHtj8xL7qNnHMH3GpzVDhzjBU7BYdji/+WhrrUKD+ep+QQF+iMHmVSuVjCjDOZgn1aXRaC9ZIJXPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M18XAa8WBf/ZNrEOv2wDdKR1N67qkzHssSWagdb4ZMQ=;
 b=GgiHSQ/SbNJj6vr/E4LU0mceQUg/xj8rYViSzMsF6LVT7H1QRhwwxQFoFBi0bqdu1JPMU5IqhqRX/CUBXJLroXAO7fgAU7VlNgUvzzhmZrNmnrwIj7wFdcZEXupTY9emhSvlDvi6+Gl2eEqTIteGTOojFCHjowndCebXbXf76IXOxoa/ZaAq3QzNH+02rq4Lf15XCZW83lGstv0N8ZKVnJpHzCXfcBTXZW4L5jfole6JvvyfGTKyP9HIr2e1WalE8JcIUWyh3sletpMcCKeaE55tJdYqfT65q/5jkKPTHw+KjKqPG4s+qmTQOjOdAKz3h08XlOvj7HegnA2LDOBWfA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR1201MB0114.namprd12.prod.outlook.com (2603:10b6:405:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:26:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 09:26:36 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/8] loop: initialize the worker tracking fields once
Thread-Topic: [PATCH 2/8] loop: initialize the worker tracking fields once
Thread-Index: AQHYORI2hH7IZN9sXEyd/mWvHC9XQ6zBvbkA
Date:   Wed, 16 Mar 2022 09:26:36 +0000
Message-ID: <f3cfa161-70fc-d0e1-5c71-21e447b9ff3e@nvidia.com>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-3-hch@lst.de>
In-Reply-To: <20220316084519.2850118-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f999545d-dc36-4119-5094-08da072f118d
x-ms-traffictypediagnostic: BN6PR1201MB0114:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0114733DB704D0C0610CD534A3119@BN6PR1201MB0114.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6v7QBN3zBDlUDQztA4oJ/+swnLXEy3uybQnMq3rJUo7nc0rwOsg2Xxbv+eitpsNME9groBLRoxa+obj2YF8ZFrRoQM+DOLl6PeBxsPld5jFxXIwS8F2gMBKezNmToOaMqTtD2y0JvuZl7MKiATQDaaW5YIYp0f1IkU/5UXZsHk8LQPCqREY94DnPsYy3rUnFMoqxjUe0bXkDMyTkXI2nfC4avtahCs3ZKiDWYqc9CToii1v2p4OFxo+ypIujzEmDQGkemuw3fy68My0B39YGfrA41ufwmv28dOfdTezWMG+yrmWHdaBfGBGCyOiABahstp7grx3w2D3JuZU5v6TV+qOzNFfCZMNGoERK1fRGMuMYVmKC8frH0ii9vHKE/ZeAaaxjKadyR9l2nzuGAIjEAHtfnR50mYIz8T+LavOE/iaLdrzsbdJtg4twWKvEa/4F/FM+ovPciZoMSNyJfIfd6KOOq0L1fZb06tnSCTyjeV4PrW6fX+8wVrBWURzvBQv9YcBAW0wruogmpZwpVFyIYdtSKpN7t9Mh1QEw9seQ0FCOQ9bPn2h+4bhl9kiZwaFAdjKYbxDdtlIkAQ0/wieRtz6T9rE3w6Q3uhEpWlVHMh3y/09/FS7Be2zOZD6V0Ytue+RWMdgqIGs1voGJ+x1igBPkHGeNku2CU+9IEqDHs54KIM3UMQkHv1WswrtMd8OiA2CrN7GFbT+JxBkDshzgL5+65zQE2/UsyF7/AAnY51csv+PdHiQU9tFDB7lMJuB4CwfWMCWy58uDMYgmo5yAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(71200400001)(38070700005)(38100700002)(86362001)(66446008)(66556008)(76116006)(8676002)(66476007)(64756008)(91956017)(4326008)(66946007)(31696002)(110136005)(54906003)(316002)(2616005)(6506007)(186003)(122000001)(6512007)(53546011)(31686004)(5660300002)(8936002)(4744005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajh1U0ZJaThrUzdWek1URlNweS9reFR4dEpzZFNISU5oYzZLK1lCNnptQk9u?=
 =?utf-8?B?U0FnZFJxZGEvTDNCUzJCS3VUV3NVMkdQWWFiZ281MHJsSTU5aEFIeW5kaFRo?=
 =?utf-8?B?eHlWVzRZMW1QMk1uV01sVlVTVFcwTzVNNVZFTXE1VWdRM0pSS0NsOURGNVNC?=
 =?utf-8?B?Z2VZWkU5MjVsb296WjA5U2NJamV0Q1hpL2E2dnZkb0p6L2ZvMUtMVU5zRldj?=
 =?utf-8?B?L2E2SEJ0QVJuUENaRUk0UDJ3RFBJbXk2SmVuU2JDb052VXpEeTkyempNTWVz?=
 =?utf-8?B?TXdyTUlQL2tuRmxQcUNEQ0w1UHBkSnU3dDA1dG1uUFNRbDQxODM3NGJua0ZS?=
 =?utf-8?B?MWtGMmVMWHd5Vld0cVRLamFSQnU4SnhMS3Q4OVByQVhwV3NrcVVlVWJZQzFp?=
 =?utf-8?B?dlVRMUZYSk1LN2VROEZpN0lFaWxXdmx4Yng3SEhDTVZjeDhHT2pwQWZLeVZl?=
 =?utf-8?B?K0Q3YjVCdjRqRmZGS3BkMFVWSjRJRXVtcmY0TTVCSm9oeUVaUVUveXNCWjB6?=
 =?utf-8?B?b0Z3WUtyaGx2UXVyYWkxb05CdFdwbTBEcklzdkpWYkVnRVl2cVQxQU9saDFV?=
 =?utf-8?B?L1dScndwWEJ1TlgzVkVUU0tmdnBNL0NINFVhZGQwaXN5Y1ZaeVlSWThDdFhh?=
 =?utf-8?B?eXlpYTh3ZFlJNzMxczdKM2FxQ1hQU2cxWkxtR2hodWZjeDdxeG1CZVNZdTRR?=
 =?utf-8?B?V3d2eFdsVjEyTzdLblhWVmtsNDhTeTRWV2JsdmpSTFlvMERVZldGMDlYdTRR?=
 =?utf-8?B?NUt5SWE2K294UFd3TE50c1Jrd0ZqWTVUUU4zRG1vVm85R2h6bFdEUGhMbmg0?=
 =?utf-8?B?Y1JmdVlLR0hkdWFrN05QYml1MTVxaUYyeVRtZ2pIakdXWFAweWxNdnphWDVo?=
 =?utf-8?B?KzhoQkpyQ3ZUOEpVYy80ZUZmMzA1by92eGJNejAxaEFCK3ZFcDhiWGdxRUpV?=
 =?utf-8?B?Vnpmb0o0YjhhUkRCaEk0aWtuTXpZMTBBWHEzUi9ZYmcyN2s0ODlmRWZVR2py?=
 =?utf-8?B?dzhKUVczTG1HenRYb0lzYmNRMFNFUXVPcTgyZGFtSHR5ODdQSk81a3ZTdEI1?=
 =?utf-8?B?bzVvZ2xodzFvM3hzODVRTGZFVm8zSk5pc1BnM21mOWtUeEZMNGNkNzA5eWh5?=
 =?utf-8?B?YVNQVE5aNGhyUUNGOGJ4VzkxWmRKU2NYaTd2Yi9TcFNOMllsc1Q2WmVXY2NX?=
 =?utf-8?B?V0ozbEVGWkpmTXRER0UrdERDYlM1dlZKNnpFczlOZm4xTnI0MDFsRE1qSDVx?=
 =?utf-8?B?ZVFyRFNVbnp1MllQeHJjaDZiak1kTDFOb2lHK2J5NS9UL3RVbFdGWnpFdWZ4?=
 =?utf-8?B?WXdFQmlpa3hUMExZdElHNW53bFFPREJZVlhqNjNId2ZmQWVWR051TENrYkkx?=
 =?utf-8?B?ZDJpYUlNOEtFWTd2T0svc1NDSzRSamRiamVXQjFJdVVrelRuQUdLTVJ5ZTJv?=
 =?utf-8?B?UHVnZWRzMTJZcmtnOWY0eUt0TDMzbnpiVmlQa1I5QUJFc0pIRURnVHdzR2xC?=
 =?utf-8?B?KzhQYU5CYXdoNjRQa2tEUytTSnJpaXpKV05GVjd4WnZOem9VdTRMaC9yeENk?=
 =?utf-8?B?Q2tFZ1JhTE1za1lIamc3RDdIMmoxL2NSWmE3Yjd2bWJFQjZWN2VzNnRPRUQ0?=
 =?utf-8?B?ZjErR3BtNVhGREZxNEZNY0JVTkpqcnoxTFVoUmZnaGlGS0EwWFFMY0oyNFE1?=
 =?utf-8?B?clluM1greWMzQzlRbkVxWGt3SHJxd0RpRExSNGsrNUZCRzYwQ0Y5dWJiN2I0?=
 =?utf-8?B?MG10YjdlaW9rZllvRlphWUFFa0JHUkdyUlhuWWVYN0RiWTVkUnNUeU5LaXYr?=
 =?utf-8?B?YytFNml1bEpYME1ZZWlaRktNRFN1UWxZMjFoNFRsMXJEMk1QbFUrUVd5aTlw?=
 =?utf-8?B?SzJ2aW9CcHp5OHVaRmYrQnJxc3NIQ1RyU0Vxb203NGxIME5uSU1lZXVDSG9v?=
 =?utf-8?B?cEQ0UTVQblhxOWhIc0tJU1Uzcng0MmVOak9wYkpDWnNBM0V4MmNWNmpDZ3dU?=
 =?utf-8?B?NldWWFhtMmw3OStQWXZ5VndUTTFNYWluRXlYd3hEelpBSG1EQlAvdkRPS3or?=
 =?utf-8?Q?/SsG4T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704F145A502E774E91152F8901679E92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f999545d-dc36-4119-5094-08da072f118d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 09:26:36.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xV9mcfrrpHmeUYHo6TYrml4/By4E5G79MiewTr5DzVclrEnUrMWNRqIlt0US2DQ3PchEAjsntMEhxQrddSgVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xNi8yMiAwMTo0NSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXJlIGlzIG5v
IG5lZWQgdG8gcmVpbml0aWFsaXplIGlkbGVfd29ya2VyX2xpc3QsIHdvcmtlcl90cmVlIGFuZCB0
aW1lcg0KPiBldmVyeSB0aW1lIGEgbG9vcCBkZXZpY2UgaXMgY29uZmlndXJlZC4gIEp1c3QgaW5p
dGlhbGl6ZSB0aGVtIG9uY2UgYXQNCj4gYWxsb2NhdGlvbiB0aW1lLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKYW4g
S2FyYSA8amFja0BzdXNlLmN6Pg0KPiBUZXN0ZWQtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25n
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
