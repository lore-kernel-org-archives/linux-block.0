Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 02:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiCJCD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCJCDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 21:03:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2564369D6
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 18:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1TUB4v/HeV6XssWzfhH9bRY8CssnHJ8ihxM3uAjY6Gpg5ORKm/XjmDmYNAtJPQQx8PjV0qUcY6T9ebTmIGsM/xu9chXFdo0i6OVXYOe6IrZnRbMU/Ie6Sy2fAC26qsXGhv3GTSoxHYWiAArDpLVgtBpaT4FLZD//TNvs6Q50sIGktAGMfiqmJ5j7qq6z54AnVLGgJzw3yc9sSRv9fqFcFJLf45Etee/AEqzFrhvzXfrElIeLrwcGudN0ndXAzinzUBp1ZOM1LjrUnTed810ssWCFmOEHqaAhRyZg207rAMf1Ic2zS1KG1RGPzYgiCKRTUIq4DHzG973aS7dN083NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at8qA9/gIzRoAZNwa546sL503PBanpCnI0AbR4oP9FQ=;
 b=EKXXZLawtSpaLuTUKXFvsw6TwfmKrh98eAhHUOkWhnlZzglfdLY8rLjtWmI4Jpoy9CHScCwgU2RIQ8wIZYZobfXITBe2rl09kz7iJabBEbJY4Sp2a1cOup4O8RXcnFdMS374jzZsuN9JNeT4p/SSq+Qkg5uUBgp/mFld/vZA7xA/wEKrMN3RlFPEGxhbR8GvpBpo6BeaJO+/Hm2zQP6GC91BIaGtpCVfOiymLLqC8KStKj3Vg6XfGyfDbbM/MLfukSgR3HvfZeOMhdBGwXGy5K3Y8OR9RhtJwJv4wX1NNNKmiu6H2hs2t30QILLBfPVKq8HtBl+Mu8SJmYQRhKE/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at8qA9/gIzRoAZNwa546sL503PBanpCnI0AbR4oP9FQ=;
 b=CUAjLpi1K4W2XCri7sRmLjn2XkLSDmHj6yLHdvopRxMG9vEGFSRnlalyBv9One7D9uXd2iAJuhLDDlOAFtcvmJ//IapI/fQ1W40UvXJ3e6j3YWgMVa0r09ZhrNcJogtRIecShjJkCmBcM+mxByh3uEJMXaEF7ZsJcKCiCXjy+bSl/emj/4L3KxeJ+HroRZ8NXT1/sppzUfc0E7/GFDoIw9rj0wawbKPE4hU8G1mCpb8bJpVL94tbac9eeIkG9Aaf4HCdw5nAMfa/kuiwMdO4Hs+ObDeS0mEhFederpPoOdGJA2sUTtKekf39v/mmM+IR55Jg3hOzswDXAayQcXAatQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 02:02:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 02:02:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Topic: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Thread-Index: AQHYNAFuVF+H/2N9n0qCSm+TSOS4bay3tZsAgAAm5wCAAAFdgA==
Date:   Thu, 10 Mar 2022 02:02:49 +0000
Message-ID: <bcf0efa6-6fa0-5e81-64f4-b78a07e4dd65@nvidia.com>
References: <20220309220222.20931-1-kch@nvidia.com>
 <20220309220222.20931-2-kch@nvidia.com>
 <1dd210d4-a3d7-30d4-341a-d7b308679008@opensource.wdc.com>
 <78d45c05-2e9d-47e8-89db-331553acd433@nvidia.com>
In-Reply-To: <78d45c05-2e9d-47e8-89db-331553acd433@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c622e92f-7fd9-49d3-e830-08da023a145f
x-ms-traffictypediagnostic: MN2PR12MB3949:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3949B0BD40EF238DF8BF7248A30B9@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+zGweGML8n9Ke0toT5680c+MMdw7tf0B/8ByQqawTfG+AmTuLeVHrcmuZ1YMuNb0Iw9v2pJs9Et5ujN3zN6PKvbqVfCp5z7rxSB+s2p9Ywp6X7seV6P35w4LBLuoZunq9CEqRrlXTkQSCKTvfji2qmbM3IWA6aM5pX/b3Xi0LdXreJkJLLqbP4HlpowaiadGHSSSRCk84L7FBubTJx2ykdljhWdWFQC8D+IsvAh958OknY6KrQlLKh6l9ex4Li+Y9Fp62iCfDskHvJB5FD3stOUBRMqXMWk+Ugisnv/K/aj1Haxau3aZIZdGSGHu4S3czgy7rGOIjU2glwjhb4XF890cpHC0bjdgnpdQECQ5r6ehmSwAwdVcgEO2+eZKvqjqn8UPykSYwncKBz1T2H6txjceh7+XzgySIO+Tc+8I3DcfU/0g7bTbi1L+pv6MvGtQbkDWlqSk/RS+IJGz+UXWeBFKeQCdGtXz4dS3VxjIfeEOEPKMQthKb3G5nPrSBAnvjj7dKIlNLdGbmWitudkFp1jBfV14vOdnnsCaCoQ/3D5D4afEfUUIW2yRbRbgm9Dzwei97SD7mSxcWPGIxXhb+9Ij7eaSxjWXdZpRgrRVXmxoE8Zu2YPeIxMcoUbQWqwwlBeZAbTWXDAalwNYTRcKxFa84X31qbEehTSj1OXS65U6aJhpBQO6MT5d99MaMnfpo+jZl7lokZs4aKJbf7Hr+xBEyIqADKnO9kcnwEl64jp9vEvoKZ34a/3Xa63Ozoxyc6dM4UaOk2sF/wxwbIkKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(38100700002)(8936002)(316002)(86362001)(31696002)(2616005)(186003)(38070700005)(54906003)(2906002)(83380400001)(36756003)(53546011)(6512007)(6506007)(71200400001)(8676002)(4326008)(66556008)(91956017)(76116006)(31686004)(64756008)(66446008)(66476007)(66946007)(122000001)(5660300002)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS91bWRraFB0U1dIUnQxM2ZjVVVQamh4Szg3WGVCZDBVZU1sTE8zNmRPUkRC?=
 =?utf-8?B?OThrVk03aUNWYUFEUHRhWGhzaHdOVEFkbVZGa0hhOFNHMm9GZTB1UVc3c2o2?=
 =?utf-8?B?empGeSszVFg1SXZxcjNYWVZHdDBTUkpwUjVDM3N1UlRSTnB6YVF2WXA1cUUw?=
 =?utf-8?B?ZW9VQVRlT1NtMHR4WmVVUkd6ZUIrVWVrYkxMaS90R0R2dFd6MW9CTisycEFG?=
 =?utf-8?B?SzMwaHQxb0hyS1JkcHBINDc5MktiT0Q2WlByaCtycUpIV2tjbnlkWloremdK?=
 =?utf-8?B?TWdTVkhXRzdteEVMbVNwZ2drM2FvWVVmWCtNU3piU0JFM3EwZEJHbExwOUlt?=
 =?utf-8?B?RXJMY1ZOSi9SY2hXeW9MQWNhK0FhZjRHWXR1VTJiMjl5VGtoWFRDTUYxZ0Rh?=
 =?utf-8?B?M0tsS0VpY3BlWWFlK3FQcHE2bXVwaG9jeTNpekp5MTA0WFdMUDhpWkZvZ0hZ?=
 =?utf-8?B?bVl2MTM2OXkyeXV1U1R6dER3dGtybXVrTVlTWmgvck5aU3NIVG9FbkJPUnVt?=
 =?utf-8?B?M3J4bmFKcyszWnNUVmZ0c1FXWFQrU3FIbkI1cEFUVjlqeDRWUlJ0KzN3b0Fo?=
 =?utf-8?B?QjdvbVo4NlBVMVd4REE4anEvTi81SGpBb2tCSEJIMWpQMGZHampibzlRVkRs?=
 =?utf-8?B?Z1FPdkN5MkppN01oZ1hHNWVWWTE0Y1FvM0pJUGFRM2tobmhDNk84WjJTa0s4?=
 =?utf-8?B?L0o3bkNQN09DQmlVbHJQc2xXUUhnU3h6RnFaTUkxVkFsOHBFWEJXdENZMWYz?=
 =?utf-8?B?TlVXTlFnN2ZBWEw4aGNIYjdLd2VFOVExREQ1WjMwVk9Lb2dVUlptTURBcjZI?=
 =?utf-8?B?OE5HU2RSd2Z3MUJyZmNldTFuRW1qWDVyZ3k0WTJlZ3owUzNJc2xZc0NXUVI5?=
 =?utf-8?B?L2U5a3JTUTFSUlNHcWFQT1RjN3hSZFBJZWx2T3NjbW1xZy8wVkEvN3J2N2Vm?=
 =?utf-8?B?ci8zd0NPNEwwdTFqd3EwODJKdVNacmdRTkZLdkRPdW9TSlBHbGQvL0RidlpZ?=
 =?utf-8?B?UWc4TUhCdXFySyt2UzgzL21jWlhzMnV5OXF0R1hjZkIvelF5Z254OUlHZGov?=
 =?utf-8?B?cktHeHB3cFBpa1hJbHNzdER5MURvdVJtanJoa1R4WVZpcHliZjFyRFp5dmtJ?=
 =?utf-8?B?L29MeGJOVzRTVS9HcyttdEV1bHEwK3pzTzVRdkJDdERHSVBJYmV2aXZJS2th?=
 =?utf-8?B?d1I0SVc5UEt6MkhtQVJQclg2dTRvR1JDeHpJUmlMenBVNGRZc1pDWnZ1Q2xJ?=
 =?utf-8?B?U21jZ3JWYjZucWRROXhKa2pkSGhDM2ZXTk5nVFBXMTN3TVdxTExZSmNzUzhq?=
 =?utf-8?B?a2dlRFRFd1lXVjZJRkt1M2hoS3ZXL0QvZktOaldtcFZMMDFJdHc2dDVIOWVV?=
 =?utf-8?B?ZjhTaUh6TWRMcWlHV2ZjVDdncGtrbzk1M0tGMFNOMkVhY3VDYW0rWHg1ejh5?=
 =?utf-8?B?Y2VkY2p1RnJ0VUZNb3N3VUpxMzN1TVVRMnlSb2xaNEptcm5pb1hiNkliVjk2?=
 =?utf-8?B?SEhsV29vWTc1Qm9BTVp4VzFrbkp2YWpkWmNUUU44ZVJHQXE3clJNZDhySDVz?=
 =?utf-8?B?cVBTUWN2ZlRVVlJ0bWE3ZEs2TzlhZkdkRmw5WDI5ZU5UcUIzWFZRNS9Va2hS?=
 =?utf-8?B?NVBrZG5CR3o0RzVZSkFUeUZudkF4Q091S0VZbUxHb1VqL2VReGx6bnBNU2Y0?=
 =?utf-8?B?UXo0bDNBb3FNdlhPSlU3S1B3N201ZmlVdU9OWkllL0dPaWErTjVzeXAzeEY3?=
 =?utf-8?B?SnY4NEMxbVhvaHBCemp5THlEUXVsazdDYlhqanRqd01ma3pxNVhiN0dhYVhZ?=
 =?utf-8?B?QmlwamFHV0JnOFFqY3lOQzRqMlEyek80T0NFYmxoMTlLS3lGQVo5dFRXOWZZ?=
 =?utf-8?B?QWtRZEpGMzM4MWRUTEYvQlV3eDBzcU5BYytUekVpN0RYTWM3aW81THkrZnZh?=
 =?utf-8?B?ZWx1TXdOMSsxZ3pObnEvdnRDS2hsSlJmcGZsTjhZY1Q4MVlBeEYrVnZRY1RH?=
 =?utf-8?B?SWpmZkpHVHVrVVEvNUZjbFZjdFdwQ0xqcGJ0K2s4cGtIZHIvakRSVVk2L3ov?=
 =?utf-8?B?SHc2N01UVjhJdnJSWDMxQW9zVjVPVEFNZHNMK1E4YWtIVWVDMkpIa3pTWE10?=
 =?utf-8?B?MDNBZzhmM0tDdXBvUllaRUtvT0VWTHJkVmVPa1dzTG1rVzI2ZDlRR3hJMFFM?=
 =?utf-8?B?NWZNTjJsTVdkejREaXNyblpZSmpud0ZEYXRPMGc1QjI0UzZ3WU5nODk3dWZh?=
 =?utf-8?B?NDQvS3M0Vk9sQitaT1ZNbUVoaFhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE6AD49511031043A1FE5945D7FEC090@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c622e92f-7fd9-49d3-e830-08da023a145f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 02:02:49.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxiUwTS8FVtzGNHXWE/GdiI7+qAyVA63/8BLZnDmSz3ZODgI4oRuVmjG7W4kMwCopkSBeO8vPFXfN5aJ5vyjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy85LzIyIDE3OjU3LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDMvOS8yMiAx
NTozOCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+PiBPbiAzLzEwLzIyIDA3OjAyLCBDaGFpdGFu
eWEgS3Vsa2Fybmkgd3JvdGU6DQo+IA0KPiBbLi5dDQo+IA0KPj4+IEBAIC0yMDQ0LDcgKzIwNDQs
NyBAQCBzdGF0aWMgaW50IG51bGxfYWRkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYpDQo+
Pj4gwqDCoMKgwqDCoCBibGtfcXVldWVfZmxhZ19jbGVhcihRVUVVRV9GTEFHX0FERF9SQU5ET00s
IG51bGxiLT5xKTsNCj4+PiDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmxvY2spOw0KPj4+IC3CoMKg
wqAgbnVsbGItPmluZGV4ID0gaWRhX3NpbXBsZV9nZXQoJm51bGxiX2luZGV4ZXMsIDAsIDAsIEdG
UF9LRVJORUwpOw0KPj4+ICvCoMKgwqAgbnVsbGItPmluZGV4ID0gaWRhX2FsbG9jKCZudWxsYl9p
bmRleGVzLCBHRlBfS0VSTkVMKTsNCj4+DQo+PiBEbyB3ZSBuZWVkIGVycm9yIGNoZWNrIGhlcmUg
PyBOb3QgZW50aXJlbHkgc3VyZSBpZiBpZGFfZnJlZSgpIHRvbGVyYXRlcw0KPj4gYmVpbmcgcGFz
c2VkIGEgZmFpbGVkIGlkYV9hbGxvYygpIG51bGxiX2luZGV4ZXMuLi4gQSBxdWljayBsb29rIGF0
DQo+PiBpZGFfZnJlZSgpIGRvZXMgbm90IHNob3cgYW55dGhpbmcgb2J2aW91cywgc28gaXQgbWF5
IGJlIHdvcnRoIGNoZWNraW5nDQo+PiBpbiBkZXRhaWwuDQo+Pg0KPiANCj4gR29vZCBwb2ludCwg
YnV0IG9yaWdpbmFsIGNvZGUgZG9lc24ndCBoYXZlIGVycm9yIGNoZWNraW5nLCB0aGlzIHBhdGNo
DQo+IGV2ZW50dWFsbHkgZW5kcyB1cCBjYWxsaW5nIHNhbWUgZnVuY3Rpb24gd2hhdCBvcmlnaW5h
bCBjb2RlIHdhcyBkb2luZy4NCj4gDQo+IFNpbmNlIHRoaXMgaXMganVzdCBhIHJlcGxhY2VtZW50
IHBhdGNoIHNob3VsZCB3ZSBhZGQgYSAybmQgcGF0Y2ggb24gdGhlDQo+IHRvcCBvZiB0aGlzIGZv
ciBlcnJvciBoYW5kbGluZyA/IG9yIHlvdSBwcmVmZXIgdG8gaGF2ZSBpdCBpbiB0aGUgc2FtZQ0K
PiBvbmUgPw0KPiANCj4gLWNrDQo+IA0KDQpBbHNvIG51bGxiLT5pbmRleCBpcyBkZWZpbmVkIGFz
IHVuc2lnbmVkIGludCBbMV0gc28gaW4gb3JkZXIgdG8gYWRkDQplcnJvciBoYW5kbGluZyB3ZSBu
ZWVkIHRvIGNoYW5nZSB0aGUgdHlwZSBvZiB2YXJpYWJsZSwgc28gSSB0aGluayBpdA0KbWFrZXMg
dG8gbWFrZSBpdCBhIHNlcGFyYXRlIHBhdGNoIHRoYW4gcmVtb3ZpbmcgZGVwcmVjYXRlZCBBUEks
IGxtay4NCg0KLWNrDQoNClsxXQ0KMTA5IHN0cnVjdCBudWxsYiB7DQoxMTAgICAgICAgICBzdHJ1
Y3QgbnVsbGJfZGV2aWNlICpkZXY7DQoxMTEgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7
DQoqMTEyICAgICAgICAgdW5zaWduZWQgaW50IGluZGV4OyoNCjExMyAgICAgICAgIHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxOw0KMTE0ICAgICAgICAgc3RydWN0IGdlbmRpc2sgKmRpc2s7DQoxMTUg
ICAgICAgICBzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnRhZ19zZXQ7DQoxMTYgICAgICAgICBzdHJ1
Y3QgYmxrX21xX3RhZ19zZXQgX190YWdfc2V0Ow0KMTE3ICAgICAgICAgdW5zaWduZWQgaW50IHF1
ZXVlX2RlcHRoOw0KMTE4ICAgICAgICAgYXRvbWljX2xvbmdfdCBjdXJfYnl0ZXM7DQoxMTkgICAg
ICAgICBzdHJ1Y3QgaHJ0aW1lciBid190aW1lcjsNCjEyMCAgICAgICAgIHVuc2lnbmVkIGxvbmcg
Y2FjaGVfZmx1c2hfcG9zOw0KMTIxICAgICAgICAgc3BpbmxvY2tfdCBsb2NrOw0KMTIyDQoxMjMg
ICAgICAgICBzdHJ1Y3QgbnVsbGJfcXVldWUgKnF1ZXVlczsNCjEyNCAgICAgICAgIHVuc2lnbmVk
IGludCBucl9xdWV1ZXM7DQoxMjUgICAgICAgICBjaGFyIGRpc2tfbmFtZVtESVNLX05BTUVfTEVO
XTsNCjEyNiB9Ow0KMTI3DQoxMjggYmxrX3N0YXR1c190IG51bGxfaGFuZGxlX2Rpc2NhcmQoc3Ry
dWN0IG51bGxiX2RldmljZSAqZGV2LCBzZWN0b3JfdCANCnNlY3RvciwNCjEyOSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzZWN0b3JfdCBucl9zZWN0b3JzKTsNCg0KDQoNCg==
