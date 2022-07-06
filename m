Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA8EC43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 00:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiGFASz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 20:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFASx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 20:18:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDFA13F43
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 17:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnKFKA01BtfJhXGupavdPfdvWQkzhFv+NQzAXT5a3kzVpLuvzf8Z+GqUcxQ5TcETE4R572sRggcWSMbJXocrUfS7bdPbkiMH+mpKazwN8mM3TsYHJF4wGXdrs+8sQk/jJqddwpY4hXmc8gq51poUViXinfrTm5Rg3dkiYJSAfZqZ00zmPyA1Hm6Fk9sMCCE9VOpgIU726p7SivembP6HHafuxvIEug8QjPNHw7VrblvClVrbxiP7p5T8tM3hVqH42VoHh/Mu0bhuqF+qL61MgMKNkX8gRxH4LcL6t1K047nDIZqzEHxup5POcN+6N8kCn7y5oU9TVALZdO44RzPong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NJPHNjbuS4YHECuExnAWgaTFhtaq2L+9xkzEcclwCE=;
 b=DRlRCFxed0Wd9EjJh1PZu4nbJcOH1fYO5WEAncZxysHlSY27hH2enEeX2faSSd67RbxeDiq5Rdk5KudG9vic5JAzx2p0vkRLIARCCv0n268TJFft+iobMmGFCcdOwVwX/e9ML+hUlrYmYbkYafAtptaMV3/4Rg/pDsqoPMCt58LsbIgUt/rifR+j2+Gl+ErEx3wS9hcCAxldLN3jEE0RMji8BS9wKT/KuTV1RxHcoS8FdB8w5dCKYCmME0lPlGlBmE2tX8QMZCuWQn+yFGAtOUX5ZkPQYGP7ZflqDnjzYG63hS57L+KxjXPzb7PpXmf6CG8b4mPbCgAvnk6XHB9tqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NJPHNjbuS4YHECuExnAWgaTFhtaq2L+9xkzEcclwCE=;
 b=kZ/BPvTckUVWMojriyVQX0m4jj6aU0owIPB0vXS/vzQWov9j3EOhMgKAlimt7BSc8k8uoYyVJzHwHsz2Vmemyu2+kRefnwrgzskGpGWgpKDpLEBmek7pdZ5K+PVAHa8FO8DaXqnMyM9qJj0KQLXi/lK1WWQqmUWq4ZGv91nPjaf6BXF+WA5/F7HJ+HaPs4E7FBC/MOz2Z6/5JtvRtJeebmNXkkqivFOvPxor+FINK9wF7u3bwc8Ce+Ycn9jWQpepYDBs8hY7joXPmdyXD1ApTGHlpeSLMKtBn00UjXQXOhLEApVowsxtM+iy18rlVvDZVtm/LDZcqQ5hvAE1eWuPkw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB3955.namprd12.prod.outlook.com (2603:10b6:a03:1a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 00:18:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 00:18:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Topic: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Index: AQHYkLHhWi96nRM220ym2nSsyPysrK1weooA
Date:   Wed, 6 Jul 2022 00:18:51 +0000
Message-ID: <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
References: <20220705205632.1720-1-alan.adamson@oracle.com>
In-Reply-To: <20220705205632.1720-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bb93906-2ee8-495e-b899-08da5ee51a7c
x-ms-traffictypediagnostic: BY5PR12MB3955:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RWyUegwma4Kuqmn76iykPy9pKhbJoyMlLUb6nZ73WA3CK1/2429W9O5r1dhTmlsiU4vLkGjbMHB5nqPAa4MUsYDCqV61hfDmY22amYQAEUz7ozr2Ko7cCmw4zDh0vBrlzAADyd73n3pRU2rummGPSiMxBO0Fvh8h2pyJLpcOZiuOfJDgM7idVn4QUi9Gvf/yxVmirhxxYB5ehTZ6ruDE0OmYhbsEFJCiI6ktSYHZPOpDIKZVpAQXiLFBXoAWsTCI4Xhwsp9lpenDxAZkz6ZQQdQiC6aa2EC2jYcHg4ILl7SuTQmcx106m9QsnwBeQ31mygWEU4hFMnmNODld3i1lslErEV/X194BNtqAnBFxL5zjMcc1BvWRtc1fYzYjSls45ssupJ2bEHs+998PgxR+EdtBKgiP2YGCfvavOgQkG1mj90BTUN2GVuTALWHS9Hz3dsb9EUNbiqBIucDrzzDa4mhoSYakCdqgHo6vygXAZc44BRbrgHnrXUaOxETE2ZI3zngxyETimZj3JRpV6WXE6KEqmdUWsKSrSULCKwXYcK7DNtLuA4z9haU5QoFK8IqmoTJoUnIc+lohUH0UU09qsHDhkTuV5vsYAwVcLMoFD1JEuJj1AqEtXZvlCBe+esHJ4xhHT6DKY9l2uYtvcuV8vjPWUZ+pDkqv0jpjyXfhIFOBFdWW6tzrwzIpnMkSL4qNAFpMxq4P17VtYioLmJuaFbvkZJnQtNkjlDn/Qn5Hhvma4K9pCP/mHnxsiQ9HtMgS9s+u9Z7I1yywQdHPixw7im3XtoSOLFSPnN6tEzpNWRlVpmVKFJV3pE3MM6Bqh4jij1pVqXLqgNEepY8/3cGJ2q+xQIEpTDO2CA7zKASQrQZ3xjbf9uCrvlBbiA2UXgg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(91956017)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(478600001)(31696002)(86362001)(6486002)(4744005)(8936002)(5660300002)(38070700005)(122000001)(6512007)(38100700002)(2906002)(41300700001)(2616005)(53546011)(6506007)(54906003)(6916009)(31686004)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VWYXg0Y2ZTa1pZeVpFeHJTZnBOUG1SNDBLazlLdGZRYzl1Tk5KVnU4VWYy?=
 =?utf-8?B?ZGJHVUF3aXNFRHBGa2c1VlE0VHE1OWJ5UWYzWVJXTlcvYmd3cGdXSUtXemkw?=
 =?utf-8?B?WDNjcCtZMnphdzRLWHAwdUR6RnZGMHltL3dPbDdZcmFLRTNKRlZycU1SQUd1?=
 =?utf-8?B?VUM1eFR0VmlrVGtuL3lFYkMrdkRZMjZ5TXZzcy94bk1zNGJ2S2tERUN1a1o4?=
 =?utf-8?B?cW9QeWlxdjN3eEJrZG90SjZLNVNOVkxZaEMybXFKUHNOK3QyWVRiaXppUzVQ?=
 =?utf-8?B?YlNzY0tPbE5IY3hrbzYvTHhLME5DOTh0RmRUbHZ0aHdRZW4rRUU0Z0lHbDVC?=
 =?utf-8?B?RDRKc28rT1BHK2k3c0JaV1ZBeFArWVRZRDNsRXZKdWJDN0NUNVQwUmFoT01k?=
 =?utf-8?B?QlM2cGFoQ1NpWkRlK2RtdnFXS0hIYWNBMmh3dEZET0N3ZnNZM2VyTk5Wb1NS?=
 =?utf-8?B?MFpNcmJQSEZxL0toN0o5M3VuNklnVHFlVVN0cFloSVkxZ2tFMDcyVDJ1VGZj?=
 =?utf-8?B?b2JmcGYyVnRqWUMwbU50dThEeVgyYi94bExnTHdIY0JjaStPb3FlZk9VaHM4?=
 =?utf-8?B?S0tBNGg4KzZzaVltY202bU9WZThndTZvNDE3cmVpYVc4Wkk2YXZSL1R0VXJK?=
 =?utf-8?B?Miszc3JaaG92UmJ3M3lCWVk1M0RVelRYMkw1TXVqUFA2NXZERlhQdDRuaXho?=
 =?utf-8?B?M1J2LzRKeCtLTDYxRDhuVk5MNHRYMmRVQkpjWDRHNEpnWFhFR3FzNGRpUVhN?=
 =?utf-8?B?aEVZRDl0TjhHT3o1dEtYSklVL3JWTjd2eEZXSkh0dXFvUW9DMW1KV0JMdk12?=
 =?utf-8?B?MG85eUdGOUZONjY5dTdIWTltTWdsWHpiWnBkYmRBa2NBUjREQ0g3R213aDBp?=
 =?utf-8?B?Q3hOQ3k5NklzNW9vUVloRDV5Q1JHdVcwQWlORmJsNjRPd0xpa3FRUEFRMGxC?=
 =?utf-8?B?dXE0TkRpVUZnMlhheDZHa3R3TnU4a2pDOUpJNll2cklCQmNDWm1XSFdVdmpo?=
 =?utf-8?B?clRrdDhhOTZjUGZLdm8xSW9CVHE3dk9ObHcyTk52b3lpdndSeFkxazdRK0Jj?=
 =?utf-8?B?bU9ac0J4U0NQSGhBWWdSeG4vMkdrajZzblhlVGRFQ2VpSTRuNmhUU1JoSzBJ?=
 =?utf-8?B?M1lGUncvODhLWXFhQjZ1VndYeENhdkJJYmNTbkhXTmxBcEtKRkM5Z25LWWZL?=
 =?utf-8?B?ZHE4cktFQkF1WCtrbGY5WFoyR1hsampFRGtrSm1GclROZkhQanArS01oK1ZI?=
 =?utf-8?B?YzVZT3lzSVFUeE9zSFhQbnBJaTd0Sk5SV1Vkd2tVMHNRWGRiMTJDME4reG8r?=
 =?utf-8?B?Vmh3TUpKbzg0Rm01MW11cTl6SVVWa3FMTGJKNFp0UU5GVDEvWGhwcW5lK2ZF?=
 =?utf-8?B?ZVQ0eHgzTHY5MEg0bFF0d04vODVVd25vSnNrdkpvWWQrT0R6MWs5cVE3RTh5?=
 =?utf-8?B?RVc2aVBRZUtOZi9HN0pLSXBuNDlpeHBFbi92NS9TSGd2TTQ0WGZqUnprem13?=
 =?utf-8?B?dDBSS2UxQTZrRmpyRUJXb0g3S0NMeTN4Rm5zc3JjbHhQR2dybXpFbm1pbVRr?=
 =?utf-8?B?MlNxcldMaElsVnNSMFJkZURhSW01YkRseGU0QTlMR01ETjdpREdZZ2Z1T1Jn?=
 =?utf-8?B?bXlvaVN2Q2tXK2hBRGkwWjlFNjNaQVpPRHdLbTVyd0Rub05UR1ZNb01mV05U?=
 =?utf-8?B?bkFZV2pDR1ZtMGsxemJIZ3o4RlZVMTZ2dnVjOHk5QWpVSElIdW9RL0pxbllO?=
 =?utf-8?B?UDlCQzJ6bzIvclg1UG5uaEdsanNIZHMyR2xLVytCMXA3UndsUHRsY3hKTWwv?=
 =?utf-8?B?dlN4aDZuWWY4dVJlRkhxeUptMVMvL1M2d0MzWWdadXh6WGdKUTRidlFlend0?=
 =?utf-8?B?MWcrOVdtVUhGQ1FvRWhtRmhjdk56UWZoaGNEWHZVWFhZSDNIWHowT1VtdFRF?=
 =?utf-8?B?MDBKNGpsaVRpRW1waEQ3cFgzUmZFZnhkUDFGRW9pZ3ZNanBWbGMrT0JTOXRo?=
 =?utf-8?B?bWQ5S2NKL1hTOHdnNE5rMXd0eldsV1dBNW5FejZpSHhibnJ0N3ovbGtKZHBq?=
 =?utf-8?B?blkvV1hSUUpjSkw1QXcwcW5saFNyRnB6LzZoL3ZYTkZtNFg2SGx0d3dLVnNF?=
 =?utf-8?B?OWM5U0IxNXBPU25GOE5lWlVXZEJVV09FZ0x2NzhTVWphVUIwZDkzbzdjczVW?=
 =?utf-8?Q?KqtZ7u7bQACMUW/cl50cJUvDjCvCWsxbPhYZ1fsBRvwo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <413BE2E7FB25D8418FA1275E488E13B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb93906-2ee8-495e-b899-08da5ee51a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 00:18:51.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUOB2UigXtql3mvZOBq5q3fWz1ArirWcNp+paEmpfbXVK4OBdlk2tXxDP7UecmSUNkz675sylDlDor+CAZfOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3955
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy81LzIyIDEzOjU2LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IFRoaXMgYWxsb3dzIHRvIGNv
bm5lY3QgdG8gcGFzc3RocnUgdGFyZ2V0cyB3aGVuIHRoZSBjbGllbnQgYW5kIHRhcmdldA0KPiBh
cmUgb24gdGhlIHNhbWUgaG9zdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYW4gQWRhbXNvbiA8
YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL252bWUvcmMgfCAzICsr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYw0KPiBpbmRleCA0YmViYmM3NjJjYmIuLjVl
NTBlNjlmYjNmMCAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvbnZtZS9yYw0KPiArKysgYi90ZXN0cy9u
dm1lL3JjDQo+IEBAIC0zMDMsNiArMzAzLDkgQEAgX2NyZWF0ZV9udm1ldF9wYXNzdGhydSgpIHsN
Cj4gICANCj4gICAJX3Rlc3RfZGV2X252bWVfY3RybCA+ICIke3Bhc3N0aHJ1X3BhdGh9L2Rldmlj
ZV9wYXRoIg0KPiAgIAllY2hvIDEgPiAiJHtwYXNzdGhydV9wYXRofS9lbmFibGUiDQo+ICsJaWYg
WyAtZiAiJHtwYXNzdGhydV9wYXRofS9jbGVhcl9pZHMiIF07IHRoZW4NCj4gKwkJZWNobyAxID4g
IiR7cGFzc3RocnVfcGF0aH0vY2xlYXJfaWRzIg0KPiArCWZpDQo+ICAgfQ0KPiAgIA0KPiAgIF9y
ZW1vdmVfbnZtZXRfcGFzc2h0cnUoKSB7DQoNCndpdGhvdXQgbG9va2luZyBpbnRvIHRoZSBjb2Rl
LCBqdXN0IHdvbmRlcmluZyB3aGV0aGVyIHdlIG5lZWQNCmFuIGV4cGxpY2l0IGNoZWNrIHRvIGVu
c3VyZSB0aGF0IGJvdGggaG9zdCBhbmQgdGFyZ2V0IG9uIHRoZQ0Kc2FtZSBtYWNoaW5lIHNvbWV0
aGluZyBsaWtlIGNoZWNraW5nIG52bWVfdHJ0eXBlPWxvb3AgPw0KDQotY2sNCg0KDQo=
