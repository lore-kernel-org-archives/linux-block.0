Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4EFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiDRWSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiDRWSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:18:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5729C9C
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwzVkwcyxBU23Mr1ZLkPLccjLnY6J0Lf69C97I9miLWK84kyZElnAXEEZwMWNnTvvGAyghjXeKBMvWJJmsEwGw+n42x4a7IVWw/mbP00GhbZlOK0kpscCQWHoZu+KcK9DUBmwEpfkUEhsCEZffUMOn/ISTvr4zlAfR1oB/tkLSaU0p86BS5RLrCmiU7OTJ8wjbpvDdJncOwROD1G3ldvbVKZRt/o9VS0lbaPVIwkdot3yvblU5FQ6O0G/aGoLhVa4GVZ/oxWPoUD8xmLZkTEM2fUVBCH3h9r4mgVnqgrkJXc6A8NUBLpGcNEnKVMVdpIuUU9uMNpXaUMnTawMOZUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88o1aQ2YQxQGtyobJfZrGXDOM/16dS/A4Glzfw6b05s=;
 b=EQW5nLBptTPPmVBK0cwP6wy2adwTSgoshTbJQlKEtGH0MWjjZPJZ0UxDsMMEXXPsYAc+SS76Ak4QUQo+QiZBVGIIgMP/7KkYzPJF22P5MNNzoxk6a90T7Jjp5SEornSpGeOibHHXmPszqIziUMpfMoQ6fKU6k21Y9aY+9DeBXfKR906mt1SFjXQEVTkRbyNetXHDSViIcqAKlgcTNm3KPT2tgDLk8IYvjR2i0JeWummAcWJHIhQki48QG1sAcNXzQnwY+VYa1e50AnMwHFLDdFALaK9agobxitiz5AR3UXxen7qe98M5O8QoWwyQmBoNN/5Q39fv9zIcWOsJoFgcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88o1aQ2YQxQGtyobJfZrGXDOM/16dS/A4Glzfw6b05s=;
 b=oZ0LraAugfmYnMaA3+CTrU/ldkdMUvfsN3uSF/LJTFbwEfxPjn/z1piwoxYz7g4dsYUcNd0p9i5Zl3FXxcA9bVnOXfAy9iyfFj6ekz1+wZ/WIz5gyMcdWzsLqzGLmyEmvYlbWgsjsbBa8d5YPDX+wHGXVB/pZROeUBYM597l/75L3UEqBwbJsmBjpu7dlQTPdq5rX4VL3p0drsW0Xa5pf1jLWQwOYY0Zi1tBbmTm8ep05Xx2SLlykbS2KwlNT/zwYpd69YqM0LRfVF7WoY6J9868qNcqfwSUfi/wCWsXN021yz6p9eWd159rxSM67FGUzg3hNuVXcdqvxps6v15Rfg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 22:15:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:15:27 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: Nullblk configfs oddities
Thread-Topic: Nullblk configfs oddities
Thread-Index: AQHYU2ydI4s+Wsq5v0O87IRvshUvLqz2NtQAgAACNwCAAAO3AA==
Date:   Mon, 18 Apr 2022 22:15:27 +0000
Message-ID: <0e405b48-4ca1-5821-a289-fa683f7e5ce0@nvidia.com>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
 <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <CAEzrpqeHrrqqn7056Le8nmf+VbUugxXV2QjZeQTraW1dwJHviA@mail.gmail.com>
In-Reply-To: <CAEzrpqeHrrqqn7056Le8nmf+VbUugxXV2QjZeQTraW1dwJHviA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed9b8379-4d65-4de9-4e51-08da2188f129
x-ms-traffictypediagnostic: DM6PR12MB4170:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4170D6AD5F6CEF45D198C022A3F39@DM6PR12MB4170.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pck7+H4VQ36fwauBQ1nmLujlmAP7RM/jDVrcYpkyy28//gXYiiV+0gMatCvd0k7uphPQEzO8azIpQdmbhx04XeFTU9b4Zyl2D7Xtg6JtClpwGFYEc4R1b58TTZGuEIB3yJ8gy2+wfwDcp7FWh83cAFruQzbVTD2YTpnS0KBCxewTf+2HMarjLgaWToGd+IVuab/9M2H5cXwTg7HNzW7FuyHLioYwlfiUKVtWD1WxUYL3Z/tHZuPaSODn6dDPUQN7uorMQcNlh4pnJ5RZlM1LAzaWHv29f5OzJ/3V4m6yGPoN1xPhVwuePb7aCOXxjRHb4rL0ty2DOJQJY0+cfxzZrb+FVy9Nhljyj/Vs0FKsaPnX+cJG2vj0bpDOsH0j03SGtr0D5OOEASIXkoHt6w1IO58GqmdXY3EOJ4IttWG55XkB3A27/WkaixzAfJVupJ5r0RKj8Vct9Nt4ib4eFQlQQT2diUSAk28nEq1UNA6GWjpcVR+cNq59x2XwToya3UsQzv9y+yyqhzcwbQ9LYDWz8eIa74lAR4Ko1wq+rtflJ39/RYrw8ELakg5locKehMRYg7Y2kkV4l8Q1m4VShW2qAKQ2sNlYm1RTxPEPrC8M2LKEGDalI+XRCS8R7mqn/YoAJRACWXLoiTrgLYbUo0lCc33w5tx4hdjtMMoRVoKfcyajFJDgSQ2gxV441NHdM4peQQLA9gJJNvwu8EilFVQXGCuKgmcL/21bRFVr2RQkP5jlnPR+VbJB4zfk3RMLkigQ1clw6umhmcjKCLtr0tlTRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(76116006)(2906002)(8936002)(6506007)(6486002)(38070700005)(6916009)(316002)(508600001)(4326008)(66446008)(64756008)(66476007)(86362001)(31696002)(38100700002)(122000001)(186003)(31686004)(91956017)(8676002)(66946007)(6512007)(83380400001)(36756003)(5660300002)(3480700007)(2616005)(71200400001)(54906003)(7116003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3FxS2VOVmRkcWNBblhiRkFVTEZoZFBVVHJtcVpvNWI2d0g4bTNUOUNTd1ZX?=
 =?utf-8?B?bjc1NEJRbk45dnhmVlN4M3JQV3lsb1dIZ2VISlZsWG1vbVQzc0FmTkQ1VmNa?=
 =?utf-8?B?eGh6cjZ0TGV2dGNvU29FTzZGcGY3dVFlOG5HaFBnaW04elRxVXo1aVdHOEdE?=
 =?utf-8?B?c2xqWTY4RmlsUi9odlU4U2plWXhYNkZpT3FYQnNnNmx6eUNjcW5kZ2UzdGtl?=
 =?utf-8?B?SXZEclRDdE5sTmZ3eFRFZTFSSFE4QjM1NjZWNXJNMU9ESllVYkVoRUpyY3Zn?=
 =?utf-8?B?QU9LUnhveWlhTFZ5c3RKUUxXdDhqOFVtcFRyaEJDejAzYzc4OGc3SjF1Z0Ry?=
 =?utf-8?B?a2JTa1BxWm8rWllKdFNDNDJxNzAxMWJaQThaY2VWeFJLR0FpNjJUODFFZDZY?=
 =?utf-8?B?bkdBcVBmZTc0a2pYY2Nta3A3N2lnYWJmVkRYNi90cStNVmFVZnJBQlBGRmNK?=
 =?utf-8?B?MjRxN3pNTTFndm92OVNrUVQyWVlOMjd3UmMrOVdTcFB3YTJHb2xBVnc5OXdM?=
 =?utf-8?B?WlI1SUprWlVBT0lWN3FTWU5xQUtWeFd6WWdTeWtqME9SbitxSUg4SFdmR0Ey?=
 =?utf-8?B?QW45dmxRQWdLUzBXcW5DZDRxOGozbVA2ZDlyUmYyNm4zTmxNQ09IaC9Ia3Rp?=
 =?utf-8?B?cmNta2plNWZoMWtxNzRudmRNeVNKWTlid0hwMEVPdkQ4UzlDOHJ0UGdiRU92?=
 =?utf-8?B?YXhYL2FIdXNMMUVldmp4T1N5M09FQXBXeVN4cndGbW9BbnZ5NitPVzRGS09S?=
 =?utf-8?B?NDBPNzV2dFgrRlV3cTFyYWRiV202T3NPQ0VPYTcrakxQV1R2UU11Mk9tVVVN?=
 =?utf-8?B?NE9LWUFoblo4aHc2MUpRMW5UVVllcWJFRnp2QnRraDZQUmhqSWUrV0ZFUldJ?=
 =?utf-8?B?YzBlckdEUUFhbWp6UjFtVVVCdktoS0hRUHhSTmwxMTVENkJHZnV4aVM1OXdy?=
 =?utf-8?B?bktFT1pSNVpqd1IyRlZNQUlQYU43VFVkUEJ5M1M1aEt0OFY0UUd5ckNYaEFs?=
 =?utf-8?B?UzhBR1p1SXpGSGpkUWlVeTRJY1FZWmJZbm1NVEYvZE9nSjFrYWVMNi8rbG1m?=
 =?utf-8?B?VVdjRmREdkNNQU12WlMvRjhwNk9CVlBndVBMUUFsQXg3amZQSzJzZU1ZM04r?=
 =?utf-8?B?VUZHYXVlajRKU3R3Qlc0YXVQTzVrQ0k5UjZnMm5yTThydUNnVUsyQ0V6R1FF?=
 =?utf-8?B?SUpOYWdMSE8vS3dtelBJNDNaQ1RKMGxJV2RZUG5ZZUEyMHVnL042eTJ2eVcy?=
 =?utf-8?B?NUlLbTJMelY1U01PaXZWamVHRURLbTBBYTBVbHgwbDU0S0xLMUJLaGZrY0Q5?=
 =?utf-8?B?M2Urc3RJZ1dCaTJrcUhKUUV2bFhFYTkyanJ4SWxSS1VTSSs4Y1N5TWV1bWhR?=
 =?utf-8?B?cUJ6cnhDOXpzVG1TN3YvUFJjMnBHVkVuNEVybmZIWXU4bXQzbmJoZ3VXVk9o?=
 =?utf-8?B?a1N1L1JNVW1hdTJqUmhvNnR2MlNlekk2OEpaYms5bmZqKzhjZVRsL0QyaUN2?=
 =?utf-8?B?SjJXQmRBelhsVTJxak5mV2gxNDkvMXdsYTA2d0lYZG1kcW9mWUYrV0lnZThp?=
 =?utf-8?B?d2tvL0xkZGFpU2k2Q2JETTVXQU5LNldQQmxPeWVtbytWMTNkWkM4UEdrSks4?=
 =?utf-8?B?SW14QnZyUUpoUnpWM1JmTFdSY2tRRzFBZ3ZyMnk1bXV2SHVEc1ZINWtnSUpj?=
 =?utf-8?B?UWdPalJyMitvc2NTdGgrUStzWDBtNHUyc1J6QWZZRm4rSDVhaVJlZ3FhdHZR?=
 =?utf-8?B?b215ZGtwSWpwOHMrQUFTZmxpKzZmekNaZ1kwZUpldjZMVzFpbWxibFVzQVBJ?=
 =?utf-8?B?ZXdOMHBjRjcrQXRvVUFneXdzNUMyUy83UHRzUmt1S1hNRjlRQ0RZYThLOWNv?=
 =?utf-8?B?K2YvWFd0SGFtTFlUMCtSb0owZkVwNUlpQW9GL0thVzE1YzdaMkdIbENub0VP?=
 =?utf-8?B?SGxsRVVIazlyYjRJUis3NWQ4aHQvb1EyVmRGUmNaRlpjOWFSUjA1STlKdDNK?=
 =?utf-8?B?bmx4Z2V6SEFzR0UzZE9iRzRtcy9ZVmtvWHlqOXJYRHZQb1JiY3RkOTYwU0Ro?=
 =?utf-8?B?VFZtd2RMeUQ0WWZIYlZEQ2FvU2o2R1cyZEd6MXhieXJTY3MzMTB2djJXcGNX?=
 =?utf-8?B?T1RBUG9QbEtMcjhOR1QweEU4cGwwZkgreHdRQnJKV3o0TjRMN1F2ZnRpejBq?=
 =?utf-8?B?cGFjK1lYMjN5ZDlpU0JVTTExcE4rSXNGYnltR3dseUNJYkhRY2QzOEdUaXlk?=
 =?utf-8?B?dlRhRE1zdldNd1hGd0RTN3FtbU85dkJCSC80YXJnZk5SM1V2SkVtQmJJMHQy?=
 =?utf-8?B?M1RkL1R5UWdxaGw4Z0N3UTdOVmVOdXZxVTZzc1NFUnIxbWQ4Qm9vYUlRY0s4?=
 =?utf-8?Q?8cgcD4QhPcDVQXHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B918A044962349A690F3BB33091DEA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9b8379-4d65-4de9-4e51-08da2188f129
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 22:15:27.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIiAdVXNhXS7TMGczIiEal6QGqcflBOwSoNDFyiID0pDnicczy0KWQTxd9UEs7Vp48mcn6YyRrG08hGEs42Srw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gd2hlbiB5b3UgbG9hZCBtb2R1bGUgd2l0aCBkZWZhdWx0IG1vZHVsZSBwYXJhbWV0ZXIgaXQg
d2lsbCBjcmVhdGUgYQ0KPj4gZGVmYXVsdCBkZXZpY2Ugd2l0aCBubyBtZW1vcnkgYmFja2VkIG1v
ZGUsIHRoYXQgd2lsbCBub3QgYmUgdmlzaWJsZSBpbg0KPj4gdGhlIGNvbmZpZ2ZzLg0KPj4NCj4+
IFNvIHlvdSBuZWVkIHRvIGxvYWQgdGhlIG1vZHVsZSB3aXRoIG5yX2RldmljZXM9MCB0aGF0IHdp
bGwgcHJldmVudCB0aGUNCj4+IG51bGxfYmxrIHRvIGNyZWF0ZSB0aGUgZGVmYXVsdCBkZXZpY2Ug
d2hpY2ggaXMgbm90IG1lbW9yeSBiYWNrZWQgYW5kIG5vdA0KPj4gcHJlc2VudCBpbiB0aGUgY29u
ZmlnZnM6LQ0KPj4NCj4gDQo+IFl1cCBJIGtub3cgd2hhdCBpdCdzIGRvaW5nLCBJJ20gcmFpc2lu
ZyB0aGlzIGFzIGl0J3Mgd2VpcmQgYW5kIHRvb2sgbWUNCj4gYSBiaXQgdG8gd29yayBvdXQgd2hh
dCB3YXMgaGFwcGVuaW5nLCBhbmQgaXQgYW5ub3llZCBtZS4gIEl0J3Mgbm90DQo+IGFueXRoaW5n
IEkgY2FuJ3Qgd29yayBhcm91bmQsIGJ1dCB0aGUgVVgga2luZGEgc3Vja3MuICBUaGFua3MsDQo+
IA0KPiBKb3NlZg0KDQpobW1tLCBob3cgYWJvdXQgYSBmb2xsb3dpbmcgcGF0Y2gsIHRoaXMgd2ls
bCBjcmVhdGUgbWVtb3J5IGJhY2tlZA0KZGVmYXVsdCBkZXZpY2VzIGF0IHRoZSB0aW1lIG9mIGxv
YWRpbmcgdGhlIG1vZHVsZSA/DQoNCiMgZ2l0IGRpZmYNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Js
b2NrL251bGxfYmxrL21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQppbmRl
eCBjNDQxYTQ5NzIwNjQuLmQ0NWMyZjNmNTY5MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmxvY2sv
bnVsbF9ibGsvbWFpbi5jDQorKysgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYw0KQEAg
LTE0OCw3ICsxNDgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbV9vcHMgDQpu
dWxsX3F1ZXVlX21vZGVfcGFyYW1fb3BzID0gew0KICBkZXZpY2VfcGFyYW1fY2IocXVldWVfbW9k
ZSwgJm51bGxfcXVldWVfbW9kZV9wYXJhbV9vcHMsICZnX3F1ZXVlX21vZGUsIA0KMDQ0NCk7DQog
IE1PRFVMRV9QQVJNX0RFU0MocXVldWVfbW9kZSwgIkJsb2NrIGludGVyZmFjZSB0byB1c2UgDQoo
MD1iaW8sMT1ycSwyPW11bHRpcXVldWUpIik7DQoNCi1zdGF0aWMgaW50IGdfZ2IgPSAyNTA7DQor
c3RhdGljIGludCBnX2diID0gMTsNCiAgbW9kdWxlX3BhcmFtX25hbWVkKGdiLCBnX2diLCBpbnQs
IDA0NDQpOw0KICBNT0RVTEVfUEFSTV9ERVNDKGdiLCAiU2l6ZSBpbiBHQiIpOw0KDQpAQCAtMTY4
LDYgKzE2OCwxMCBAQCBzdGF0aWMgYm9vbCBnX2Jsb2NraW5nOw0KICBtb2R1bGVfcGFyYW1fbmFt
ZWQoYmxvY2tpbmcsIGdfYmxvY2tpbmcsIGJvb2wsIDA0NDQpOw0KICBNT0RVTEVfUEFSTV9ERVND
KGJsb2NraW5nLCAiUmVnaXN0ZXIgYXMgYSBibG9ja2luZyBibGstbXEgZHJpdmVyIGRldmljZSIp
Ow0KDQorc3RhdGljIGJvb2wgZ19tZW1vcnlfYmFja2VkOw0KK21vZHVsZV9wYXJhbV9uYW1lZCht
ZW1vcnlfYmFja2VkLCBnX21lbW9yeV9iYWNrZWQsIGJvb2wsIDA0NDQpOw0KK01PRFVMRV9QQVJN
X0RFU0MobWVtb3J5X2JhY2tlZCwgIm1lbW9yeSBiYWNrZWQgZGV2aWNlLCBkZWZhdWx0OmZhbHNl
Iik7DQorDQogIHN0YXRpYyBib29sIHNoYXJlZF90YWdzOw0KICBtb2R1bGVfcGFyYW0oc2hhcmVk
X3RhZ3MsIGJvb2wsIDA0NDQpOw0KICBNT0RVTEVfUEFSTV9ERVNDKHNoYXJlZF90YWdzLCAiU2hh
cmUgdGFnIHNldCBiZXR3ZWVuIGRldmljZXMgZm9yIGJsay1tcSIpOw0KQEAgLTY1Nyw2ICs2NjEs
OCBAQCBzdGF0aWMgc3RydWN0IG51bGxiX2RldmljZSAqbnVsbF9hbGxvY19kZXYodm9pZCkNCiAg
ICAgICAgIGRldi0+em9uZV9tYXhfb3BlbiA9IGdfem9uZV9tYXhfb3BlbjsNCiAgICAgICAgIGRl
di0+em9uZV9tYXhfYWN0aXZlID0gZ196b25lX21heF9hY3RpdmU7DQogICAgICAgICBkZXYtPnZp
cnRfYm91bmRhcnkgPSBnX3ZpcnRfYm91bmRhcnk7DQorICAgICAgIGRldi0+bWVtb3J5X2JhY2tl
ZCA9IGdfbWVtb3J5X2JhY2tlZDsNCisNCiAgICAgICAgIHJldHVybiBkZXY7DQogIH0NCg0KDQpU
aGlzIHBhc3NlZCB0aGUgZmlvIHZlcmlmaWNhdGlvbiB0ZXN0IHdoZW4gbG9hZGVkIHdpdGggbmV3
bHkgYWRkZWQgDQptb2R1bGUgcGFyYW1ldGVyIG1lbW9yeV9iYWNrZWQ9MTotDQoNCisgbW9kcHJv
YmUgLXIgbnVsbF9ibGsNCisgbW9kcHJvYmUgbnVsbF9ibGsNCisgdHJlZSBjb25maWcvDQpjb25m
aWcvDQrilJTilIDilIAgbnVsbGINCiAgICAg4pSU4pSA4pSAIGZlYXR1cmVzDQoNCjEgZGlyZWN0
b3J5LCAxIGZpbGUNCisgbHNibGsNCisgZ3JlcCBudWxsDQpudWxsYjAgIDI1MDowICAgIDAgICAg
MUcgIDAgZGlzaw0KKyBmaW8gZmlvL3ZlcmlmeS5maW8gLS1maWxlbmFtZT0vZGV2L251bGxiMCAt
LW91dHB1dD0vdG1wL2Zpby5sb2cNCnZlcmlmeTogYmFkIGhlYWRlciBvZmZzZXQgNjY4OTE3NzYw
LCB3YW50ZWQgMCBhdCBmaWxlIC9kZXYvbnVsbGIwIG9mZnNldCANCjAsIGxlbmd0aCA0MDk2IChy
ZXF1ZXN0ZWQgYmxvY2s6IG9mZnNldD0wLCBsZW5ndGg9NDA5NikNCnZlcmlmeTogYmFkIGhlYWRl
ciBvZmZzZXQgNzQ2MTM5NjQ4LCB3YW50ZWQgNDA5NiBhdCBmaWxlIC9kZXYvbnVsbGIwIA0Kb2Zm
c2V0IDQwOTYsIGxlbmd0aCA0MDk2IChyZXF1ZXN0ZWQgYmxvY2s6IG9mZnNldD00MDk2LCBsZW5n
dGg9NDA5NikNCnZlcmlmeTogYmFkIGhlYWRlciBvZmZzZXQgNzA1NjkxNjQ4LCB3YW50ZWQgODE5
MiBhdCBmaWxlIC9kZXYvbnVsbGIwIA0Kb2Zmc2V0IDgxOTIsIGxlbmd0aCA0MDk2IChyZXF1ZXN0
ZWQgYmxvY2s6IG9mZnNldD04MTkyLCBsZW5ndGg9NDA5NikNCnZlcmlmeTogYmFkIGhlYWRlciBv
ZmZzZXQgMzYzOTE3MzEyLCB3YW50ZWQgMTIyODggYXQgZmlsZSAvZGV2L251bGxiMCANCm9mZnNl
dCAxMjI4OCwgbGVuZ3RoIDQwOTYgKHJlcXVlc3RlZCBibG9jazogb2Zmc2V0PTEyMjg4LCBsZW5n
dGg9NDA5NikNCisgZ3JlcCBlcnI9IC90bXAvZmlvLmxvZw0Kd3JpdGUtYW5kLXZlcmlmeTogKGdy
b3VwaWQ9MCwgam9icz0xKTogZXJyPTg0IChmaWxlOmlvX3UuYzoyMTQxLCANCmZ1bmM9aW9fdV9x
dWV1ZWRfY29tcGxldGUsIGVycm9yPUludmFsaWQgb3IgaW5jb21wbGV0ZSBtdWx0aWJ5dGUgb3Ig
d2lkZSANCmNoYXJhY3Rlcik6IHBpZD0yMTAxNTogTW9uIEFwciAxOCAxNToxNDozNiAyMDIyDQor
IG1vZHByb2JlIC1yIG51bGxfYmxrDQorIG1vZHByb2JlIC1yIG51bGxfYmxrDQorIG1vZHByb2Jl
IG51bGxfYmxrIG1lbW9yeV9iYWNrZWQ9MQ0KKyB0cmVlIGNvbmZpZy8NCmNvbmZpZy8NCuKUlOKU
gOKUgCBudWxsYg0KICAgICDilJTilIDilIAgZmVhdHVyZXMNCg0KMSBkaXJlY3RvcnksIDEgZmls
ZQ0KKyBsc2Jsaw0KKyBncmVwIG51bGwNCm51bGxiMCAgMjUwOjAgICAgMCAgICAxRyAgMCBkaXNr
DQorIGZpbyBmaW8vdmVyaWZ5LmZpbyAtLWZpbGVuYW1lPS9kZXYvbnVsbGIwIC0tb3V0cHV0PS90
bXAvZmlvLmxvZw0KKyBncmVwIGVycj0gL3RtcC9maW8ubG9nDQp3cml0ZS1hbmQtdmVyaWZ5OiAo
Z3JvdXBpZD0wLCBqb2JzPTEpOiBlcnI9IDA6IHBpZD0yMTAyNTogTW9uIEFwciAxOCANCjE1OjE0
OjM4IDIwMjINCisgbW9kcHJvYmUgLXIgbnVsbF9ibGsNCg0KDQotY2sNCg==
