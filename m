Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 06:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGSGqi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiGSGqh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 02:46:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DD2611E
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 23:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYBC1s1gK+5NDqxs5THLqWqJt1vNKBfgyRKUgSXiKZ6eFlGshmGSdZlOQHUDO3tS9Q7fGRukWYF4PLg9nnYjwMLnz9mUvL8MFfC3hLmdqexEzcw6AU5rnUHksDMf2wR4eyLmtbSYHFh9U0wSPNKf8+VK1vx0UVDoYhJR5ipHlr3bDt3NnbiVDsmI+4nRrbjIXpRiAOydsTcD2aiaaAsEHfCzQWt5Uza2U9+hGkWrXEHHAI1aJYK/ofic7jLsRhO6NzP1SDmXnQrPES1whOI3gXaopIGxKrSfECHoi7BQDoH/xhetX+gDwe543H1eEbtWWdH08FVKULTK8mqJTJsiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaqPyCeHY/8WeqTEOzhK+ySGuTb/rgOhJEE8hIgFZEA=;
 b=RXV+O+O1jBiR7YHVwUiLH0DdeqyBl3aUiM4pYwXtngaSxoVKNzEjvmVijq/GKh10vCEhVXPB7vgOX61796jqaqegB7Ue/aLSujMd4WokEklq+26XA4t7P95vDWZrAsDHo1Ug8S4lDcXBLmBoxXfbJGlZqT2JElEQMXThp1StlYmNWSgF18dAx6V4OeLDDFuMtcerNrp+Veji7uUWHB1n20bEoOeLi6ZO/NE7BX6aiNkocuFfbXwMTDKY1zy22gI8PkmMZeT23+i++MWglqNNF2jvxy3faLIHaBxxvkaqtjlrIHXkswHLlRc7eB3nEr/Aw6QU5z3ei/KWiOkAKzcqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaqPyCeHY/8WeqTEOzhK+ySGuTb/rgOhJEE8hIgFZEA=;
 b=Y85LvPFcvhRh6kS/QPq8HH4psV/PUcd8PVgYmt2Onz5svHuh29T9SD9s17lqWz9s/ta7CWbfY7IfMru8S0q2LkeP46hiJlFF1oYT4LqMZ7TQAwVu22gep0OkM7Su912TtrCCRXXyrWuQ6CR77z71c+ep1zE9UcVHIYsYmX3PCzt+28M9f6qyvuxykoWCiBwgZP8jEy9zO58LWO8HFrYE26lYkzE8bc6AqtR5EYstSF2+4ijycvxEUFQNx/XVoMU3XTMXwMfZYtCALfaUNm8M4qsfsHNMxZYtbV9MdcL8KYbNOmZikBlJ4zoJdllhlDHqc+BoeXThMUfL+7r8qTYu8Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 06:46:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 06:46:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] new: fix test case addition to new test group
Thread-Topic: [PATCH blktests] new: fix test case addition to new test group
Thread-Index: AQHYmyOtOqd7kbPuaE6ZYkXSidXJD62FQEoA
Date:   Tue, 19 Jul 2022 06:46:34 +0000
Message-ID: <40eb1d9d-3325-3a8b-4cac-bfd92146688e@nvidia.com>
References: <20220719031036.1395823-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220719031036.1395823-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c8d5cb3-8dd5-4104-3404-08da69526c16
x-ms-traffictypediagnostic: DM4PR12MB6182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pZ4xUNT2LMerP3f2OepBHPtkd1sDlbQ6rKHC9kxMBXNRcanuiDA50GMLW7KUzPx9y84PAGaNB/jgUPdHg4xS9/ylF2WXvb6q5g1Wnqkm5ZdoNL3Z3fghiRqmxuUe1yU0DYIirFpz+/k/bZjoW24eA4CDUX/bULLxYYkCMg66C3QBxITRRGI7gVQY4/DA+4icLUYFlK4CVMwAdH5WXA5XM2Kd9MI1gmGCFYzeOGqiCiAW6BlbW1NoYc2PYqeBIPvzsOJjC7jN9ezm24m6Bde4FSE6cRRUqCQCx4asfkNIPKjSHoiMjMAfIRnOBXREhyFMroqWeZyRdtbi0z/Hr3DXCF0anDsKPy03Wa6gEZc+2dBi691wwCNHPyQqT6M6QFntZGAzb+3WkJrdTeuEtYmlA9D+gF/MFIdBwB50Ay0YUEBjTn7dHYa96Z1LK8HgJFwZ3VJsAKD2nPP0qPvxwbdon+z96ouNB23jsqwC/ESn/cmtBwAIRjorLeISHqy9FWQ8kruwpHBEddK6f8ck3E+41PTTO/ymo/BUeQBYBj0E/UMt0jYaUzyhdB+kT7k7kCpeztiLurz2REoEw+p8bM4D71gjVoi2GMF6uE7oza5I8QWQmUkEXqfdyOYDmuCyFX3JYaL2eowJoUZjFIPSW1iO1QyYEB72Wwu9NH61a6DrVkWjPjnPPi/yY+aOkmzNBwUpfSn/8ctgynwI86w6CIEavs90F0xaKIipI7xrUk79MkELYkJBIGpWI7mpx+NI3VUeJ/gyb6Hoh5VJW0dFhIqhFBkirkUaJzgyPUmlNuSPxa3k31Cg1mrXxsp0xEFX0TQVrwkorkOzQ/GzHejbrE3qoBGVZfDPMWMx/DOb903b1HUvD1CvbADHBWYoQm4XaAd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(38070700005)(86362001)(31696002)(122000001)(6486002)(4744005)(38100700002)(478600001)(8936002)(41300700001)(5660300002)(316002)(54906003)(66946007)(6916009)(8676002)(4326008)(66556008)(66446008)(71200400001)(91956017)(64756008)(76116006)(186003)(2906002)(83380400001)(66476007)(6506007)(36756003)(2616005)(6512007)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVXQmVBcERnbE9YQ1kyaWJYVzdVQ2lhdUUxNVhUNWFoWjF5RW9odVFDeFlF?=
 =?utf-8?B?eDJGNGVlcER2VWRlczEwbTY3bHk1cytHUkVwY1hwLzdmTVU4cFJvaGxnYmta?=
 =?utf-8?B?U0ZxK21yWGxzOEJHWGpYaGtCQU1mOHpzN3NyOTE4SFBlSWkrSldaM2dpQWVy?=
 =?utf-8?B?RkF4dzhPOTErdUh5OHQwME9DU1hsQ2ZYNVlCVmZVY2poL2VHNHRCVTRZTTc5?=
 =?utf-8?B?Z0JhMGw5c1NCVEg3Z3FCaXhqelpsZE42YVg5Q00vUm5XNXdUQTM2WHY5VUFC?=
 =?utf-8?B?VmZCLzdicTRKTGRCaEdKdmZINlBOUVIrSEo3cW9UNG02VFkxVDJweTVVUkpz?=
 =?utf-8?B?cVJXdTNMaFIvL0Q0WWU3QWZ4WDR1YitQZTZJeCtkNXJ5U0JvdUp5MEhpOG5Q?=
 =?utf-8?B?NnkyaVBBQ3ExR0g2Vm1YdEZPYmluNFo2NjJMbWJZNEZjckU5WDg2cHNZUHNM?=
 =?utf-8?B?NlNXZ29PK3hnTUFUYnpDMno2VmwwWkxYa1Fwc3NaOUNhVGVRTWt2TVNRYXl5?=
 =?utf-8?B?dGQxU0Y5N3pPMGI4N1UrU2NML3lLMWxFUk5UT05rVm1xV1pHNHVDdjVKdmI5?=
 =?utf-8?B?ckNKbUxWVHI5cExqZG5tTlJ1YzRVNDFiU0xkLzRja29xM3RiUGRTWWM2TSt0?=
 =?utf-8?B?R2xCOFU2NFBEeGExU29IcmhCeGU5LzBFRlMzQklzVktTeXFLMDRIbjhMM21G?=
 =?utf-8?B?TnNrejcwUE1qRUpOT01tbmlTM2FaV09NMFNzYTVGb09BL2tzYlpPZnlTcXVm?=
 =?utf-8?B?d09GK1ZpdDJKbTJQbDJ1TEFPMFdiSjF0dmZhaUc0U0d6VVNwbG95Zk8xQm1T?=
 =?utf-8?B?UTZ3UmtreHlZUVJMVmFqT2xhTFl0YXJBeTRrekU2VjhmRE9kWFgzVGYwREFl?=
 =?utf-8?B?ajJQem5BWXJqWkNXcnVFcHQwVzZSUVNPTXJpU0xPZlJvUDRtaDJ1b0hoaFc0?=
 =?utf-8?B?R29oMWJ0RkZwSXo0ekxEZ0VwUmYwdVV3bkpLbFhPVWlXS1NFd0lreUVCdW1G?=
 =?utf-8?B?LzlEWno5c2w3Zk4vSEFNLzhBVmtDSk5HNTFGNWhnRThvdkJEM0dzQ3o4a2Z6?=
 =?utf-8?B?WWYwdGtYZXZNT1NSdVVMMkdiREhmME8xVXhoYWM1UWhRQzJqbnZWWXdhQUlL?=
 =?utf-8?B?SWhqQmxuK1dFZ2d6ZWFvWFE3ek14eHVadWdZRTNwS2ZaWnBnaW51WE41VmFB?=
 =?utf-8?B?TnFHQnR3R1ZIT0pUS0d6RTNWNEo2UjJEN1UwNmNXNk9WL0U0bHJFQmZkY2FK?=
 =?utf-8?B?UWRtTmpWME9RNEpvQjFoNmhOZFBpQXJoV0VjYml1dkdPN3pLWmZ4TGxLK0pX?=
 =?utf-8?B?a0pFK2V5OU4rbEliSUtoa1hVaTNUUGZzMXVjbi96bkx0TktBREdZbFExUVla?=
 =?utf-8?B?TEF5Y2tzMWtDb2FueUdxMG11UVpXVFd5Q1poN3o3ay8vUkdSbCtGL2QrdVJH?=
 =?utf-8?B?US8waE13NWsyV2ZpVWVESWRSZmVsWU1qclhaODZzSUxEbk5EaVJYSy9XOWpj?=
 =?utf-8?B?VjVNTlAyQ2I2dGJmckNFZWZHVC82T2pqZk5LL0pkMnVmb1pIL09ORmhOUDBq?=
 =?utf-8?B?K0dZSDZDTEtNT2Roc0w3czNFZDV0aG5OaWh3MWRZZGVBQzk1dDM2Z2o3UmJO?=
 =?utf-8?B?SzZSUFpyL1JHN2Z5aGFMWTdEWC82VlBzUVY5K1lZMmplcjBkMmduVzNCRitC?=
 =?utf-8?B?ZGtlR2Y2U05nZ1NDaXp1Mm9qTUt2eGpkRC9XME5ucGRNS3hTV20vUWI3Q2Zm?=
 =?utf-8?B?ZGc5dmEzSlB5ZVM2aTkyRWJkNWkvcUZQNHZsUTMzdG05dURaQ2xBRXk5Q3FR?=
 =?utf-8?B?d1BjZXJTaEtYa2M1NEV6ditPUmRvbWdEaWQwTFg3VGZ5clorTnRKdHZMU2dQ?=
 =?utf-8?B?QUpVSVVPQ2ozSllGSW9GS1F4TWdjcytybzJFUDN1a1M0RTZtcG5ES0d1bnJ0?=
 =?utf-8?B?QzdLUEhOTTY2a1l4dzNuTHFXbWpCSTFseEs3a2EyaFcwZHVtS3A2MzMzM1dG?=
 =?utf-8?B?azBQZW1MTHdlM2k4bzhwOWc3NEJScTVjNkhncU1YVGpyVzBUQzNjcFJiby9p?=
 =?utf-8?B?c3VBUDY1VFNXSzRLYklkQkdFaENNN0ZJRGpIY1lzbE05S3BuY3RNL2FGejRT?=
 =?utf-8?B?UWY5MUFVVmZyT0Nqa21iYW9GdmFyR3J5NzVWZ1BqeTYydjBBUWkvRnBSRVlJ?=
 =?utf-8?Q?tpR5TJU/ZOPVX+UfB2R4VvU/+QdWE8ZG+FXrPSd/qw62?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A368C424CCD58499CCC0803DBD736F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8d5cb3-8dd5-4104-3404-08da69526c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 06:46:34.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMWL4u2Olltdk7bDNCdFL1OXKZWidML3jg74BX7FBU+RN7JWGBGoYFVUi1+V1gxq6/PKBCt2RWCmK9QPL9L9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8xOC8yMiAyMDoxMCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSAibmV3
IiBzY3JpcHQgYWRkcyBzY3JpcHQgZmlsZXMgZm9yIGEgbmV3IHRlc3QgY2FzZSB0byB0aGUgc3Bl
Y2lmaWVkDQo+IHRlc3QgZ3JvdXAuIEhvd2V2ZXIsIHRoaXMgZmlsZSBhZGRpdGlvbiBmYWlscyB3
aGVuIHRoZSB1c2VyIHNwZWNpZmllcw0KPiBub24tZXhpc3RpbmcgbmV3IHRlc3QgZ3JvdXAgbmFt
ZSBhcyB0aGUgdGFyZ2V0IHRlc3QgZ3JvdXAuIFRoZSBmYWlsdXJlDQo+IGhhcHBlbnMgYmVjYXVz
ZSB0aGUgIm5ldyIgc2NyaXB0IGFzc3VtZXMgdGhlIHRhcmdldCB0ZXN0IGdyb3VwIGRpcmVjdG9y
eQ0KPiBoYXMgYXQgbGVhc3Qgb25lIHRlc3QgY2FzZSwgYnV0IHRoaXMgaXMgbm90IHRydWUgd2hl
biBhIG5ldyBncm91cCBpcw0KPiBjcmVhdGVkLiBGaXggdGhpcyBieSBjaGVja2luZyB0aGUgZXhp
c3RlbmNlIG9mIHRoZSB0ZXN0IGNhc2VzIGluIHRoZQ0KPiB0YXJnZXQgdGVzdCBncm91cC4NCj4g
DQo+IEZpeGVzOiBiMWUyOWU3NzU4NzIgKCJDcmVhdGUgdGVzdCBuYW1lIGZyb20gbW9zdCByZWNl
bnRseSB1c2VkIHRlc3QgbnVtYmVyIikNCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3
YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=
