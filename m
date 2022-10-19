Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D3C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJSTSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJSTSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 15:18:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C31D374E
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 12:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elIYAt6xZRECswEbZkpQpCJ12Imu07UoyaPu3/ygzFnJVRFbPM4a5uVVAiJoeaJ+jo2S99Hk+XFbRJroL7s+ONbWbDMHmV9JDC8aGbZmiBHSH22KQb/aTAbSV7RBucIT7mdxGjp0H5xoeJflOArvpwHEqDiml/+V3qJl86u9M4TAKIkcvqLuQF3cQrDgNrl8t9scEPq4nUvXHbLq0Oh+6SN+0+Auh4jdoVZFzjBP3w7wF3YmYwabCIim194JRfAwb+WFpHNZRNh0zoAm6jyXA3PPR5UGNOaZAqouM9OpGs0fo7rIys0Fx2T9T5ofJLpyJwdt2rlT2DRg1sJaAHtq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV0ljB9bvK4jCaNYsDGX/m3nWFifN2uN1zU6Omz/sl4=;
 b=aBjH2zEX9F7gnQOLYDSJrbdgpvuhL+Hl4S5rYXs1fpPg5XFhdqFc//RmXBN3kLv1e+9ZJ0B3JbpZzD5zM2UXUjz8uz7NlC65yoUhv5rTOaNozAmKGcHNYJX96uJTqXdGmqsD6NtNZo0mcd05FSQWocIuPlVWhx2EboznLcTRTjyCXg+Cb8VvyXjiCbjTaeFumSSnp5ZQ0S6TZQ+jAYMj9pbF2yPBj5ehobsBBXRrExjujExE54K5tMugPLTWhVc4KjHg708zo41XlxL7tFyveWeQt4fBEgL2BEJA7Mg940DPr2g8CqfGPBBan42xMaugqq+3ugdc8pgUbpU+0+OuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0ljB9bvK4jCaNYsDGX/m3nWFifN2uN1zU6Omz/sl4=;
 b=qD4C08XBatkX15jTN/wSb6dP0lrzm/dZjJpo0h3FZaHBe0jn5wli9palqNO068vSAbaIIAJe9PyfhpJsa4YyNq43/Bb2GRFTtVv1lRDlb1bRrh61A/p5dccSqYdtu+7IqFdjunqjK/mBMjSpEfFkPShPdooEF2UpTa2s3vAqqTBfplQQA9UyqQoepf25/Wbw1cAyRIF1kIDEyCeJZw379Dak/9cwbCz0LUJnRiij4RFpcUalpMD9ZDbgRBWYTAys1KA2Pwlm8FA2oCl9PLLGbtI5bgOUVd+8YWziBi5ucxpe1WkXlUDFPb2fzCtwNnVCoHguWWU6YpV1pkBBZea/9g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 19:18:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 19:18:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Eric Sandeen <sandeen@sandeen.net>, Yi Zhang <yi.zhang@redhat.com>
CC:     "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l60hl7Fc9KsUGQcUgAzbInn64VPZMAgACG/oCAAFOEAA==
Date:   Wed, 19 Oct 2022 19:18:06 +0000
Message-ID: <d3688d8d-bcf7-9cbf-7c99-74cb1a05a9dc@nvidia.com>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
 <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
In-Reply-To: <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4191:EE_
x-ms-office365-filtering-correlation-id: cecc430f-068a-431d-3815-08dab206a71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kuNpyc1LCuvCUZ1bYklHnlFRT0U0u5D7Cy6ZEjyjYkKwqFLpIHZaW3JAyPOaiihi46EQhuhw13tRJ0xTMNcLqS15GpCyghJ1eU45O+vIOI6jiahW81ddRM9GsD2A+oKmYDikj1jRoc/bj031BUBajBkBlfZLeLi/dTFOXDMfJJW9UJQxndu+Fz3hu8SIr8uWTd+7ywRWhQ3iLtvZONSgn93nPLNmH2unCisNj/+qroA41gBsqy+fbk8Qp6SALECNTh/yH4eyWu3tbujw1DTvNeKkK8oe4Y5dBq3pHTefu7CqOYZgx6INtBKUagncLhTkY0BTkbA4J9drMi3cIyKs2QXLjYe+ebHP4DAdKgfbtAk3Ee6I+4MwZQFB0zpT+ze+6stgBD0rSeyr0UwSs9Vu4MBwlKUNRRc3SPTXmwMtY2LK8RWhMyTazQ0Qhg18+VLtveozImQjkLNgZgaRMM2emqCGiO5K2ojFIKcJpEuueLtSkmmEcgilBRLTUlcpNyPirra/Tk0cAF0uMy7erzDSO2hnSaDYL9t1/JTQQX1UepiSOW82nzpwTKvE8LRV08jeonUZh33mCs00wi/KxHPbhOz6HRW/nS3P82ezgL7e/62FIE6dUKWam+Kl0esJ/SqsWp787uwwBPd0bw6mzZC97iv/cpBXw6x5y/p4AiWriFg03Roo2UrPXU/iyiH5JHjonjaJRML94r65uIHJ94OQ8V+1cNJnM4J+MpjtX+gRgbZFiAXPmJF/9OK5zcnIQvpjA19vI3TijFpqsoNI2XyLOOy4/w9rmJyChTf2RHhiCJIBkSgT/AxQosy34NEEwKPSq9ox4NsHMWF9W2Of550nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(4744005)(6512007)(6506007)(41300700001)(86362001)(83380400001)(31696002)(54906003)(53546011)(36756003)(110136005)(8676002)(66446008)(64756008)(66476007)(4326008)(76116006)(66946007)(66556008)(8936002)(5660300002)(91956017)(316002)(31686004)(6486002)(38100700002)(2616005)(71200400001)(2906002)(186003)(122000001)(478600001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1BJeDJ2b2Nsc2dvZnFkaG1YcXJUMEhXV29jVk83djZ5VWhYeXl2MnN1aTht?=
 =?utf-8?B?eGtqWWRzUU5NczNHNXhETXF0ejMxbWhOMWtwemswK3VaWnNKQzZibVlrZThY?=
 =?utf-8?B?djlwTGpzOXIvOTM3ZDVpRkU2aGxEZEZ5cWNRcXJWQzg4SkNSUXF0ZWVoWnRu?=
 =?utf-8?B?V2txc2RuTUNUS3ZQYy9Ic1Q4RFBSYWxzalQ5U20yajJnTloxeGMzdGh4SjNh?=
 =?utf-8?B?c0M5anY2eVUrMWh3eDFWZ1BRQlVkSGRXSHNocXR4c2NDM3lMRlU0OFFHbzZa?=
 =?utf-8?B?VXpYVkdFQ1F6VFFmdXdJZHRMZ21RbU1Lb0NlbVNUNDVwdGI1b0xPcEVhUHBJ?=
 =?utf-8?B?bDZaQnV1WkR2YS96VUU3SmFMbTZFcVdFWmZ4OTlMMngvT1NpT3hSeTZhc2cy?=
 =?utf-8?B?dUtnOVZZNitrYWlsN3R3cWRPZVJSSW1JUU56YnhYQk1LcHdlZXoxQW9pTnZs?=
 =?utf-8?B?WFhjRG9vWkVHS0xBdjdMSVJ2Rk5jOG5DZEVFTC9RL2xFR2YvenVCdEgvN0xC?=
 =?utf-8?B?U2NOVVdwcTd5MjcvT3VwK0Q1eUhkMk15WFJOaVRkMXQrY0h1QjZ0QUlGUHZz?=
 =?utf-8?B?bGRDd0lVbDBxc3Z3VVdTNTMxVUVBOGo5WnFzSXU3ZkNUV1RLOWtzZzIra08r?=
 =?utf-8?B?dit3VXdJZkt1ZElvSWVORVZFVElZUi9jMitUNGFsRzRBT3FqRXFzWG05KzNB?=
 =?utf-8?B?aTA4dElBVDZaZGh1QVlma3FIRmZXYlRDNmVUNTRNYit2QjhiYmdPZ3U4K0dm?=
 =?utf-8?B?ZVFqdEl4cE9UOVk5Z3BzalFKTkZkbmx3TThXL3BoREltYk5sclRydHVDd1oy?=
 =?utf-8?B?aWZqQzVWVFB3VklRNTRPVG9qZldROTRQNXRLWVJTNHExUmZZVW8xTkFqbTFQ?=
 =?utf-8?B?elFuaEdqOFBtOUtOcXFVVFBkaWQ0ajY1bjkzdkVMZ3JaRzlLdVl5YTlQN0NU?=
 =?utf-8?B?WERFTG9na1VSYVNnRVZ3YTY0SWxDSjRTYzRQYnhtRTI0R21GQ0Nod244dTRF?=
 =?utf-8?B?bjZKTUNnZnZNaDl4bXpiNkdKZjZrOGVodm15WC9uWEJ3Y3VYYnB6dDlzREJH?=
 =?utf-8?B?ZTl6RzFIODFka29PK1A2TWRXOTZKUHlXZ3hYS3hOYmtSR0lXeDRBQmJzZVk2?=
 =?utf-8?B?b3IwVWJnNENOb25odXF1SDFmbXd6a1FFalRSU0J0Q3RNMFk5Wm1ULzdZb1gx?=
 =?utf-8?B?SDJkV1RHNGNxRzUxNUNBcmRmNEZLYVF0UGdmNCtyTExjNjYrYzB0WUI4a1JC?=
 =?utf-8?B?cVdGWDN3OXp3clJKMkd1VFB0MUpveUVpL0VoK3ZZbHlvSlhXTjZtZ3l6dGth?=
 =?utf-8?B?ZnZjREVNSTdOenF0dEVLbzFEaml2SENzbzlkN01PQ2ZxVmxtc3FHQ3BKOFZR?=
 =?utf-8?B?ZlVKdXk2dTJkQmFITnJWdm1GM3gxOVF6M1NDdXhuUGkybmtGdWVqd1dKaDVB?=
 =?utf-8?B?NDdDVExjbVJDSDZpVnZ1d20wK2p0MiswQnhtLzBrRFJTaUl4MlV3KytkdzMx?=
 =?utf-8?B?bk83U0xGVUlWTWp1eEZvTGFuNnVEWi81WXFPR1VpV25kbG1MUzBUQmV5NTVO?=
 =?utf-8?B?OWVsV0VWTGcydHM1eDFwQnArSjMzbXNlWmFUbTVnTnJJeGhOWHMzR3lBZUEr?=
 =?utf-8?B?Nm9HNytWYUtwMlNINzQ4TzhoMHhtOHhZM0s3TWZUYXUzTjdsVGhFMExrR2lW?=
 =?utf-8?B?aUVWNm9kY3A0blRCZW56ZW01dVc5WjlwSit0elVkM0RYWW53VXU3bzRRbkhr?=
 =?utf-8?B?c0lpVjJ5NU1QYTFFSW1IZGtkZWdZMmxNQzlqbXZubDRRTnNXUW9xYnJlUFN0?=
 =?utf-8?B?bTJUaUpwWFVkWTFhdS9reExUR3pKV1RlNm1yYkRyRWJ6d3JvWG9Id01wTjkw?=
 =?utf-8?B?Q2pwSlBiVU1hQkJsd0UxNElCV0tObGpoMGxCd0w0ZXVxQ1BhYjJhWm1NUmJF?=
 =?utf-8?B?bjFIMzBjNUIxampieFlMQ01JTDZwMTBCeFpGTkgrRk03bCt6UWRIR3UrYkRN?=
 =?utf-8?B?VVN4d29hV3RLNlYrRHVRa1pyTlhpYkt6aEcybE1ZL2RoVHFKMUVWeTV4Sndh?=
 =?utf-8?B?dWVRdTJIUHlKQ2VXTWFiaEVxVzdGNmNKcXpvTHoxMmgxTG5xUEZsT1pnMWVw?=
 =?utf-8?B?cjVvZ3lRUk1RYUpKSFJLR2kzaVF4a2RwdmZuYkNZeUdpY1Zma1hEYUxYeXJN?=
 =?utf-8?Q?jGgxPsCv1PBnzJsg/b/AzUhITKENJbDo202PQaJp8/Lu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7AE43566ED1A141B4F2E7F47DF23BA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecc430f-068a-431d-3815-08dab206a71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 19:18:06.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdV1XYG3DIWVCcHOww5O7JigE6AKar8hhfUHJWrtyacpwJsiVio89kk9P0fTgZVHslryN1zcyURuMGrWQuBZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTkvMjIgMDc6MTksIEVyaWMgU2FuZGVlbiB3cm90ZToNCj4gT24gMTAvMTkvMjIgMTox
NiBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gT24gMTAvMTgvMjIgMjI6MTIsIFlp
IFpoYW5nIHdyb3RlOg0KPj4+IFRoZSBuZXcgbWluaW11bSBzaXplIGZvciB0aGUgeGZzIGxvZyBp
cyA2NE1CIHdoaWNoIGludHJvdWRjZWQgZnJvbQ0KPj4+IHhmc3Byb2dzIHY1LjE5LjAsIGxldCdz
IGlnbm9yZSBpdCwgb3IgbnZtZS8wMTMgd2lsbCBiZSBmYWlsZWQgYXQ6DQo+Pj4NCj4+DQo+PiBp
bnN0ZWFkIG9mIHJlbW92aW5nIGl0IHNldCB0byA2NE1CID8NCj4gDQo+IFdoYXQgaXMgdGhlIGFk
dmFudGFnZSBvZiBoYXJkLWNvZGluZyBhbnkgbG9nIHNpemU/IEJ5IGRvaW5nIHNvIHlvdSBhcmUN
Cj4gb3ZlcnJpZGluZyBta2ZzJ3Mgb3duIGJlc3QtcHJhY3RpY2UgaGV1cmlzdGljcywgYW5kIHlv
dSBtaWdodCBydW4gaW50bw0KPiBvdGhlciBmYWlsdXJlcyBpbiB0aGUgZnV0dXJlLg0KPiANCj4g
SXMgdGhlcmUgYSByZWFzb24gdG8gbm90IGp1c3QgdXNlIHRoZSBkZWZhdWx0cz8NCj4gDQoNCkkg
dGhpbmsgdGhlIHBvaW50IGhlcmUgdG8gdXNlIHRoZSBtaW5pbWFsIFhGUyBzZXR1cC4NCg0KRG9l
cyBkZWZhdWx0IHNpemUgaXMgbWluaW1hbCA/IG9yIGF0IGxlYXN0IHdlIHNob3VsZCBkb2N1bWVu
dA0Kd2hhdCB0aGUgc2l6ZSBpdCBpcy4NCg0KLWNrDQoNCg==
