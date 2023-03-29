Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C368C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 03:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjC2DbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 23:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjC2Dal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 23:30:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72D40F0
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 20:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY1bfSSbd/Lzg1OK5exbCQUoFAMmKzzrHpaemH8c+Md0eup2HfrQoCj5Ad4ij7gmtasQphPZtLXnB11Rj29fLl1Tfp0R7JzJgH22RSeFbLdZPM5YjPPHyC3i7J/qUJ3sCJOLKPJwFtd/HK0u2smU5j1zhMVCC9i1492+c1mbNU6FiDbBxE1E99wsxv4feT5cMEeRJ+2p6eluFkmIq8bfQ1Ggru/XCW3ySS5GyuhVTJIBb43jAsCf5cq9Kgmje4gH4a6EhGQtmeIvwXjaxf9Z/5AJOtHv2oYBV34QIjqK/UKNGoouRSAKy1d+NE4r1/3YsYn9BoNVvH4GbogLmu0zAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA3jUqBb3WRuyFKtrmeydOPtBZgAUZDwfgf+QkYX8gY=;
 b=fjqQQK1KaBeAW/xtnIkwjzbmPumnLT8RafXf5UKhJ7Ql8pv6osQNrLFCcGX4yZzB0EVq9kwg5yrceajLCJCIYLcLPr2+P9jk+TqVp/j/+ubFhvWHA43CUTRkIl+uzlJL5EgMgjef2E2XpxyU1uSFzZFsrufXRxjXaIqFgjdVccLVDxOvrX3IA7UDPCYJhjbF13AvIRSj5X4Ij3d6Sh/OXu/EZKHJWYUKaE56aCnAO/HA4BdzueQ360RDzAprUaA/SoRyXjYW8+qTwJOCN8aac+F3yG+4FJjJOCboFKuzktV9wQoo/1JtZPYNEKmn6eGo2kMVbYGQnPZK1cslkvE2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3jUqBb3WRuyFKtrmeydOPtBZgAUZDwfgf+QkYX8gY=;
 b=E0zYmihMZkf5oJKEwH3FzMaBeIJDGlUq7OefYVdAJl+rLYO4J/p7oNAsum3baKbaaSMMnNEfsOfMGAXtllsQJBFksUcHcbt25R2o3B+VifBKWwjVgA2dY+3LXge6jgs35+QHwy4O62rrXe3hIdwyFNOzNmtucf6ij1PR0+YDsUQlhkLHR1VkhLqLElpvQ1o1AY7dmnvs9LLD/sfRM6bhrukQYEJtxLdu7PI5WFmx2pVM33rFfglXHtCWcDwELwuD5/B0DmiZfK5ZOr7nz5ijeLBGr/ZsxgTkX1Cx69TK5T+Ah7x2qE+45DSsPnZRq78WGMtkoGB1iLaZ68g925YSDg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 03:30:17 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::c447:32e5:4322:403a]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::c447:32e5:4322:403a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 03:30:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Thread-Topic: [PATCH blktests v2 0/3] Test different queue counts
Thread-Index: AQHZXKdvRAUG9bQ5KUS8NHUM8XKpWq8QjvaAgACVS4A=
Date:   Wed, 29 Mar 2023 03:30:17 +0000
Message-ID: <6dcf501f-8863-b448-01fa-1252e73a87f5@nvidia.com>
References: <20230322101648.31514-1-dwagner@suse.de>
 <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|MW3PR12MB4537:EE_
x-ms-office365-filtering-correlation-id: 1117e7c0-5e11-43a4-312d-08db3005eab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGRJe8BzDKwHzT4LyRmp01pQToczHq+s4DzpvgrCViR3IR++HPRkfOeHM7ifMfxE9YYipDUrEFDfKQ65T8Bb5C+JVOSB9tlpTOiKj/VuMOavh/zM4iJtaosMCPvBLn07m1KI2uaNZSqJ8tFVxGFz/wVMWiry7UZLTM5dkV4zzORKdQ9foo/mqBvf0iiAfFtgI8jil1jgmctHxkUVuVKYNMy13tmamJHTPRXjoe+esYbfebPJS9/hkprP0xYeTR2ozY+v4efC5b6VFaUpRlaq31M8Xgp3Ufx/1Rj3GFraotRktZslKotERyPJ0gFUDhUOtnHn2m8aovn6CfLGMwdj72kUyb+94Pp2mdf/rxwaPjWbEYnaTuohUpNhJkDKC6sDVmyFL9cautI2z0sGJIFnbENfYfRojv1TjAUXirdpII8haSUZ3rjvsbrRth+MWnB0MFMl9WO7kBd6AXnNXxZlnsTQcxcHCu6nxpO+/TK/59hOYQMn3++oFFG4crmfWxf1YUrvSOKUskTIG+kBKJBsB9CjYJS5cJ9LGf/PN9O9IrK7FssgE6Ug9mBiz7ZublI5PhvFEyL7KoT6ogswAiW+Y60PVJzHnVC6/50vVqMs09/WiNxpQqTiy7Leur7WapWFRIPEgmHCvqDgjgkUjvpFB/9VFZmluWf30GOnan9CtmNPRZOMDfARU/a0oxOWkRYV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(5660300002)(41300700001)(122000001)(8936002)(38100700002)(86362001)(31696002)(36756003)(38070700005)(6486002)(71200400001)(6512007)(6506007)(53546011)(478600001)(2616005)(31686004)(186003)(26005)(8676002)(4326008)(91956017)(66556008)(66476007)(66946007)(66446008)(64756008)(76116006)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU1FY3ZaY01LNDdhSlBRRjc5TkpzRG1CQS9xd0hFRkNYMFNYOHNiQzB4WWNt?=
 =?utf-8?B?T0xqZWZGNk1qRVp3cEtqVisrbGNnZ3ZkMGJzSEtCMFRVakUyZEJJaWYvRXNy?=
 =?utf-8?B?eVBDQ0xzdmsrR0xxdDBvSlBHeUR6WlY3YWZQRkNRYmdRQTk5bVBTRWNBOVE3?=
 =?utf-8?B?RjhNUVU0YzIzNDArNkUrRG1NM0tYQzcvVzVlRGRuZFN6b1NwVG1qUHMva25y?=
 =?utf-8?B?d0ZmTjkveDM5U3FpajVxY3RsaXpXYW9vZlRhandHaGF3anZrS2dpRlNVMitj?=
 =?utf-8?B?U1A2NW94QWFtck9jemlIY2hyaTYrN0xPWjdRMi9wMG5RV2ZJWXdrTzlmaEpj?=
 =?utf-8?B?OXc0c0xQV2VuWE1MbEUwVHNGM0pYYmY3c0U4RkQ5NXI1RFVyS3JmbDkyWVZu?=
 =?utf-8?B?VkFyOXRua28wMDhuRU9IUWloRXE5MzRRODJuMnI5UEdHS1djdWpJMVpnZlho?=
 =?utf-8?B?Nm9oMElWL2dzd2drNFRNR242dTd0VG16NEJ6Q2tJdjN4a1BkMzZNWHJMU3pz?=
 =?utf-8?B?elVDanN3eVZDZXhRQlZaR1JYN2MvQy9jWEZDRTdlQU5CcWZlUEdTMng3eTF3?=
 =?utf-8?B?M0VCRzBJdUFveXV4NVc4UldwUVc0THdJTHZZR3BSemYzbW9XVlZxdlB4U3ov?=
 =?utf-8?B?eW5JbHJRd1dSM1FWdkdkWXJmVHRTYmI5OHhjbnp4N3RaenkrSlZjemUwM1RO?=
 =?utf-8?B?TFNpbFhhTG1iZStvYjdzQlhjYlBiNDhEdHZFdHJVU0gwY0dXT2dJb1J3N1Jx?=
 =?utf-8?B?c2Q1NVFyWi9WOTNBRXhXQXh6aGlzMjBlZE04VkRNbkM3ZFlIZjJVWTBNTHBj?=
 =?utf-8?B?TjBITVpBVDh4UnA4cWJCZXZsR0Q1aUo1bjJ4Tk9MejA2aitCRTM3VXd1ZGpH?=
 =?utf-8?B?WVgyeml2TFIxTGdONDM3bFVNdDhWMFZVL01XWXJoREtXaVh4RDg5dElENXNQ?=
 =?utf-8?B?Ly9YYW04a1VTOXNreURHa3VtOXNjZzNoRW9UcmViL2FpQVIyZ2Q5blFMWUxm?=
 =?utf-8?B?TlRjWitGcHo3OHhta0FIM1I2OHV4eVE1d01DUmh0VHBGQTMrWXA3NVlwbXp4?=
 =?utf-8?B?bGwvTXVBNW5VTnRVU2ZpYkJDdHZtSDIrWVBqeG44LytNcUtSbkh2bmlQbjQv?=
 =?utf-8?B?TldNZEFtSThNcXRaTGx4ZGJLaWNPSGFGZHlVWnF6ZlNXaHk4bUJDYmNmQ3dD?=
 =?utf-8?B?cy9KamloQmFHRVV5UG1wQ1VPRGs5MkpvRFBQTjB3NC9ZNTMwSnZFUnBhb3h0?=
 =?utf-8?B?TzF0M2xjVFpsQVd0OUFRYnJQVURObThKMVVZR0lhMzR4Sk01eVFBZzNWZGxi?=
 =?utf-8?B?cnFLTzZOeER2aWNaQ0Q1WmFTNEVzSlpYL0RSK0VmTGFKVmZRSUlZOUFxendn?=
 =?utf-8?B?UVNna3MxdjVyeGhpZGZYVDRuQ3hndVNjcWN0eUtUM2o4ZkVlUGZDRzRDQTJw?=
 =?utf-8?B?aXVNNTV5Zk1zM3NTQVhsWm90SXhwdmpTc01WNldwaW5oQmQ4S1V6Y2M2ODlO?=
 =?utf-8?B?Z1UxU2FHRytJQTd2LzlnMHhzSGhhVHd3YSt0RjNwK2EwWFY1c3VkN0xkeXI3?=
 =?utf-8?B?OHV6MVF3OC9jb3dCK0VGTEhwNXhjaGZUY0M1c0dwM05OeXBiZWxjdVJTcXZR?=
 =?utf-8?B?RStrdzVsM2F6VE9NdXEzRnVhaFpnSEUxZW5pSUp5TmVWWGxpRzltUW01cC9z?=
 =?utf-8?B?Vy9jNGhmWTlEQnFORVE4eHlxUXVsT2FoSk82MzhUbWI0Wjd4am1FNklqSVRo?=
 =?utf-8?B?V0haVVBDcUJUOVBjcDhveFFBYkhUSktra2o4dE1iUU5CcUZ3Ky9BQWF5U2Nn?=
 =?utf-8?B?eWkvT2Zjdk03VW1TYldCZlA2M01uY2ovUTdZUDRXK0QzN0hvZDMvVFVsSm9Y?=
 =?utf-8?B?eTRLNDYxZTgwZjlFbi9xbmE3MzllZlpFcjVSb2VFUlZSUVdIcE11QWhxaE15?=
 =?utf-8?B?eGR4NDNlMmxsVksybGVNTnRZMDIva1dlREkxbDJod1JpbWFnaWFFOUsySGo4?=
 =?utf-8?B?TFM5bTcvYWkvMTEwOW1KajcyQ1BHY2tEL0srS2Z2TWVGUzAwYlFoZjF4VFV3?=
 =?utf-8?B?d2I1Q0wxNFM3SHl4dTU1aTl1aG5RWlRZa3UrZ2JydnkvbUZJTi84VDFwL3ZR?=
 =?utf-8?Q?wOEjUuH2i11Wm2yoqXblC0jui?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8EE5BCB6DB8744A3F6F6768DB6BBBB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1117e7c0-5e11-43a4-312d-08db3005eab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 03:30:17.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BVWGPy7Gg9yJVUsd8DjoToRDQynhkjj30sTFb4u+QhXY0VAiXYf2HHO+7XFFNaXePaxtPSCJaW67o3wBPhuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yOC8yMyAxMTozNSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgTWFyIDIyLCAy
MDIzIGF0IDExOjE2OjQ1QU0gKzAxMDAsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+PiBTZXR1cCBk
aWZmZXJlbnQgcXVldWVzLCBlLmcuIHJlYWQgYW5kIHBvbGwgcXVldWVzLg0KPiBJZiB5b3Ugd2Fu
dGVkIHRvIGFkZCBhIHNpbWlsYXIgdGVzdCBmb3IgcGNpLCB5b3UgZG8gaXQgYnkgZWNobydpbmcg
dGhlIGRlc2lyZWQNCj4gb3B0aW9ucyB0bzoNCj4NCj4gICAgL3N5cy9tb2R1bGVzL252bWUvcGFy
YW1ldGVycy97cG9sbF9xdWV1ZXMsd3JpdGVfcXVldWVzfQ0KPg0KPiBUaGVuIGRvIGFuICdudm1l
IHJlc2V0JyBvbiB0aGUgdGFyZ2V0IG52bWUgcGNpIGRldmljZS4NCj4NCj4gSSdsbCBqdXN0IG5v
dGUgdGhhdCBzdWNoIGEgdGVzdCB3aWxsIGN1cnJlbnRseSBmYWlsLCBhbmQgZml4aW5nIHRoYXQg
ZG9lc24ndA0KPiBsb29rIGxpa2UgZnVuLiA6KQ0KDQp0aGVuIHdlIHNob3VsZCBkZWZpbml0ZWx5
IGFkZCBpdCA7KSBoYSBoYS4NCg0KSSB3YXMgYWN0dWFsbHkgd29uZGVyaW5nIGFib3V0IHBjaSBi
YXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiBvbiB0aGlzIHRocmVhZA0Kd2FzIG1haW5seSBmb2N1c2Vk
IG9uIHRjcCBhbmQgcmRhbSwgdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiBLZWl0aC4NCg0KLWNr
DQoNCg0K
