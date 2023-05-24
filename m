Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ABC77B7E
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 03:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjEXDMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 23:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbjEXDM3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 23:12:29 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730B118D
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1684897949; x=1716433949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zWK7rfn557v9/E/TDbNx7C0FbEUoEWwfCzSQwGvWSso=;
  b=EVFhcQo+fvAkE8Di0iS/Zg7MTgqBWGEWNPgSQENlXFWcuzZljvmBxZ8V
   n932KIY1XpIMIrjZyyjqCwSUJTd/ebkc92cT99XSBFPSBdIMNI171GogY
   2+IVJTmYQ1JECgBIqWOugEp9pQdjmqNd3EnuIo4TkmDLkL9mRpSNs/rZj
   qHKAYFu9YYm84F/e6aboaI+hh+tRwmfS8zEvLc9la1ksdNR0jfdEJ49hT
   VCZHYpNXE1RuxECv42QEKMd9bmNZesCyU7ByryUM46p2IBl8Q1qVZttiE
   QJmNUTVRzLaG5HGbvsKKRYiidWAYxyKvLt8JMZOopyu3NDr85cPMUA9C8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="84871976"
X-IronPort-AV: E=Sophos;i="6.00,188,1681138800"; 
   d="scan'208";a="84871976"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 12:12:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRtJj8O91zy5HfS5u9W7gfdULhp9O4B7STdhHwYPXbStbWaAUNx9W5d3Jtdneo9uTRhefgII5iuJtzQIe3TtpQDgjZjoJgeD0UUlBaM0nhpaNRn5zg+S7a2qDgCBq5oJg8ezlrZszo1rCtceTW05FmwyMPpVveQG0Lk1o6scdHtvZxcKRbJ6MGci0Y18A5h1fN4ZCHi9l4/wch8shXim1nywE18n9WIZmgZpP74wqT2oft62DgPFX2OV6FonZwH8k57mVGOKH5iJhShPrLsItV1kXiu9mkIE6p1XC9RsRP+9temoIa4YIA7nIXHq9DtYofFfq9pO/AkysUAM6e+4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWK7rfn557v9/E/TDbNx7C0FbEUoEWwfCzSQwGvWSso=;
 b=k0E0eIUwnd35kORmK/b0Zis8evSIzgL+khyqKMEOb2fH9ctXbSnT4AGngg98oDpjLlMcvAxaGs2cBtOzx7/J8wxN8yF12jck/xGwF9QnKJ5SDAizRXffPqSYdp+YJO4+E8R4DYzPe1YCY6NEZyCrbabl7tCMlCsxiDLVGLnCRIFI1RoFnWLVWVwUWjS/sHjTf6ncXSPQ874oW/lKEAHb5+ddSrcPARJRSGb0JklYw8cA+J2EBGxKTct6zm5COym0tH0UaAIPSQ77VZjRgsJ5waPVxjYlumo7N1wl6J2pBmUfnledXnyPLlhl7PJnA5L4efaBsmogn2t9hjnYBkGISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB8843.jpnprd01.prod.outlook.com (2603:1096:604:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 03:12:21 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 03:12:21 +0000
From:   "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests] common: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZgw1y7RgZnDRyM0uHcXHHUvTGz69THeoAgAAFZYCAAAF6AIAAj/OAgAvDdoCACVzMgA==
Date:   Wed, 24 May 2023 03:12:21 +0000
Message-ID: <06204a56-aa39-7266-e511-fc6ff85e392c@fujitsu.com>
References: <20230510070207.1501-1-yangx.jy@fujitsu.com>
 <9ac0b861-01a0-9dce-3d2c-5ff9e265c994@nvidia.com>
 <1f2061f8-de32-15cc-818b-56ca0024c5da@fujitsu.com>
 <14ca2b51-6ccf-d3f7-c61a-ad2e8c384448@nvidia.com>
 <cpnmpplrcos4mocwilkwqo4sxuoqw2mimb42p65b7pkn6e6yc6@wvxrnmd6b5cx>
 <ecrelgmx2fmya57dsc5i6jvwaybnjiw4olllfujkhhjz7wpnni@vtdrlloshkvi>
In-Reply-To: <ecrelgmx2fmya57dsc5i6jvwaybnjiw4olllfujkhhjz7wpnni@vtdrlloshkvi>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB8843:EE_
x-ms-office365-filtering-correlation-id: 935caaf5-63b9-4f05-25b4-08db5c04b0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKfUi+x9236yotSTiFxcrrXzb/nvBir2dUT8h7JAEtUSO4fTq0w2ouFegOrYLCETqkLCbw4s+N1oCCp0e3s0rrhJxdbFM3R+sNb2Mr2ygpTLkATdTU3G51QI+0pzX5BQOf1VpOWPTQera1cj+yFZtkfIu1mx0dpO0975M+kj5bbKIv7dzTXohh4e3VAUXQ3NTFmNYy6JeO9Z+VFpIXVClhEYEcvzZW2jqjKc4HWdZrgRBjcz6ig/vUlhT/rq7gHyWi45OBCBgSiYJt1c2maywlZyuvDVfi6HCChWGiMw93LmL72fHIBWyFpbQH5xIC16BpXc6f9ikEa0bumcMCdyMnOb1y3SySoNDNaoSMBqiakkwZL/aftwWMicX6UmkaMLKAm+qjZ2YFbSZ9Yc1FitPvVD3UHjmRQyfAwIZ0qFLp1Aq7XSuegdJtRbYf8Ei+4ZcdNQEW4VwK+Obxid8Bg2LqCBFHREy1CiWt6G6DyHOR/BcH6Ybp6qyhOL0UwQXDZTnvV463KcsfBK+4SAhq3nu15tpLV6yE8Do7bszvGUNC8UapX4yej9tO4+JZ7xe9/npzmwBwjEq12F3nGvinKo2xk1+2RJ3L/+iePwXm24rg7QICFcgvlrKblid7aMDVr2BUHdQSlbvoBN/Uh66HdinW6RZ5IN5o6yhcvPLHtovEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(1590799018)(122000001)(186003)(26005)(53546011)(6506007)(6512007)(82960400001)(38100700002)(2616005)(85182001)(36756003)(83380400001)(2906002)(4744005)(6486002)(110136005)(41300700001)(54906003)(316002)(71200400001)(966005)(86362001)(31686004)(478600001)(91956017)(76116006)(66946007)(66446008)(66556008)(66476007)(64756008)(4326008)(38070700005)(31696002)(8936002)(8676002)(5660300002)(1580799015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnkzYUxja1dvbkozV0tFUW11M2NOaFVsOCt0T1NXNFBEVTZWdTJML2paQ1Ny?=
 =?utf-8?B?MU5tY3R5ejZQamJwTzhZckRZamp5eGx2MEZMemcyQjdpQkRBTFVvRlEzaFd5?=
 =?utf-8?B?bmR5RTJrVVUrYUlONDdrNWtUaVZNZFB1MVRjNkRsLytOeUNwUmlKTVljK21h?=
 =?utf-8?B?T1ArVDg5SWs2VEpBaUx2MWtObWw2dFpTTW4yd1hZYUlyMVdHcGswVXdLa2FP?=
 =?utf-8?B?V1ZGL1RkVDB4MmF1RVR5SWJMYm5ibWhJT3NNT2d0SC8zU24wR2NJc3NvbUpm?=
 =?utf-8?B?N2lQNys5bUR1L29tbGxyOUlwd3ZhMHRqZlZaZlR5TTBTODhQRUU0SFErd2cz?=
 =?utf-8?B?dzR0QXZXMjNHdHpueWdjQkRMT3NJUlY1dnpLYUVXQ1dqN3NVOVJuQ1V2V0Ix?=
 =?utf-8?B?NU9vR0Q4SU15M1lkaFYwVlpLcC9uK1lLY2lLRmxDZVQ5MHRUQzNpV0N5WGlH?=
 =?utf-8?B?a016bXYvbTZQUVllRWJ4YmViM3haN3k0M2lya1JRMHhhVFViQzZUUEp0OEFU?=
 =?utf-8?B?c3hpUVZnTUQ4VDh0cnNvVUY0dE9hUkE2bmtqMHNxbXJHRy9vb3Q1L2JVU1Rl?=
 =?utf-8?B?TDR1NXhsUm9nMHllWmc2TTk3dk1raVdRMW9mb2l3UHNRd3d0UFl6b2sxU1Rh?=
 =?utf-8?B?Rk9XWGttek9qcVFyVmgvcHAvRUVRMVVONmIvS2h3NHh2bDRXL0ltSnh6V1dT?=
 =?utf-8?B?eUcvbnVON3ZXanpuL0FLOWN4cFo5b2JuQTg5RFNKdUtBMHZoMHUxTU90Mlpl?=
 =?utf-8?B?N2l3TWpENW5QOTdla3RQcjRVVHlYMkJvL3EyR3BpdnZLNDdnVkJKWFZWcFho?=
 =?utf-8?B?U0xKT2kvTWlRNFZXeS94QzdRd2xYWGIrNCthVUtoR0tvdTlnTW5GTk9SYmpp?=
 =?utf-8?B?MmV6bFJzVlJkNHc4VmRUVEpDaUwvRVlRc0JTZGdrQ0VwT2dMQ21IdzVSMlND?=
 =?utf-8?B?ZVlGNW93ckdNeXA0VnVkbnp3SVFScjdPRTZCKzN5QzFlVkZreFluWmZsVmFN?=
 =?utf-8?B?YitIVHAwS3E5eTBtRWxRc0xmT1M0L2VrUXEwWUEwM2REUE1tOU1pL0FVRTdR?=
 =?utf-8?B?STZ3d1RNNzFwSWt1eXNUd0VCR2xXTG9Wb2pLRGQ4eCtFbkVMc0JEc21SVkM3?=
 =?utf-8?B?SlFNZU1Id1ErREcwenJSSDk1TnZLeUVDV2RRUkdTOHViaU9zK1llYVgrcTBp?=
 =?utf-8?B?UDFGbWFVV21JekdTUmJKbDBRejlXVEtZMGxKSFcwMnhsZTBVUVJua2swS2FG?=
 =?utf-8?B?cDF4STVUTjhabm95N0VCaFRGazcyY1A1cjdLODhtaHJ6WVFHNVdPTzdvczRh?=
 =?utf-8?B?eGNReUtscElDcEJIWHVLL2g1K2lyVkFpV0FsMjB2VUVHNHZydmZjUldMckJn?=
 =?utf-8?B?enpVU0dDenZXSkk4bHVMQnZqaTVmVTJsYjlXdWpGd0pySXEyNEIxeUFublVB?=
 =?utf-8?B?OGE0TmpOd1lFa2FBMm5tNGtPd1FzYUpmM2N6SDgrZXdHTVh5cGh6ei9FQTFx?=
 =?utf-8?B?cmxsOHRhc3lWamsya0hZbXNrU3FVSjZsS3VPQVg2b2tyUzRMdnZOZE9iNnZp?=
 =?utf-8?B?RHc2S215bGxXM1BmQXhiS1c4KzZGVkFLMUlyNHVTbFlzUmxUNUt5SXJsVk1q?=
 =?utf-8?B?TlVLbjlONmFLb0pPVnRvTTROcE5xN0RYZW8rYVFMVGhYVS9vdXRhaXlzbXhG?=
 =?utf-8?B?OTBnZFpVK2licmNHTC9pS0hNUXYrbzZVRGRIK0hzaVpCMWhZUTRwWWx1ekRQ?=
 =?utf-8?B?L0ZjODMzbURDM0N5bGpWRldlMWRISnFBQnJ2VElBcDdmcU5vOU8va3IyRXJk?=
 =?utf-8?B?RGxyeFpHOFR2eUg4V0dFZ0JLSWRydGtzZVovWTk1ZFNIR1k0Vm41a2o1WTVL?=
 =?utf-8?B?SjYzQzN6TjJIbVhVdkphK1UwdnZpSWd2N2ZpK0RoSy9XQnZhYW02S0J0SFoy?=
 =?utf-8?B?d3BpT1Q0b2lDbG9hOFM5aS9MWEdtTGM4dWFuSTJkRWxVN3BGUm9wVFN2Umho?=
 =?utf-8?B?blpLTnV6NFhlVFN4dnZKZWJIY2NoUVFhMFR0cit2enQycVVlcEtCMldHYzk2?=
 =?utf-8?B?YnlKUzI3UG5iOC9SMUxPK1Vuck9hb3FBRHdlaEg0VnhyUEszUG5zbFE4Tm50?=
 =?utf-8?B?a2pvWExPMitPRVBNbHZRVVdZVTV5c3YrWkVyZ1FYVUFHVmpZVGhJQncyVHEw?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C3E061E3331A47AB38483F0476A81D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nfNJk9yL9kRm0zU/4sTSz55fCSdDAZpdP3gttOgsdtAssyPfLrivgKUjt/GzpiavY7ZfPFFnnt06twFLcFa3nM+KMkarFlGdgUyYTMxit2ZC/ckwV3tnU7c355YZgqUooKzJFkH42bE6vp65r8qLbuSh6AlUzknZ2RsN1Gkm20h06Y1FgqpPIt7j3EJ7a+TTpjGZ3y7mY28PNP8mOmGlebkYL9+Bf7oILR/iA5EbjBYRjZEV4YkDmJGtOe60khq1+R/vF1xBrO6q2uWLpCRa5hEt67/lMJGi+6cw3h3jb/KcOyV6d0Dy1MajJq7Qm7mdghGQoMmt0dfLZ2yibV1BmCZX4HwMSFvLScvE0hzMSdzA40rBtoNm7LpQHQhi0tUUi8kEwHv7a7lQG5kAe7NvKnrX2xWQwvI28nuoEu+9Im1knN4RlkpHl2zvxV4sFPOBmQdOaO/prhoHHQ9yJKI1a0wKw+cl9MzUUK6/cvOOc24AnnIULtKn8vjP4U9sI6W9nCUS8qM/cXkndtOTTA7M9RwNWhoZj5xGzu82I/LEvf97WxHCa9b0ZEE6+4IPrdkSXT8gU02EhUhKbe1/Kja532ynSHwSbZMzwapRrraoqePuQr46j9YHh7FWfInCHq89QQzUpNAorsuTt0HeHYsw0zLDcNWHxq6s00HkuN1N3CFtMl4d1J7mMh/nRMEcdDmZzEX9E7m0vwNNAYLp0zNDVgbSMEEL1LwhPMj5TIO7LHjPwVbRCAZbtOBcZXsvMitw91iHszYQqAzudbrtzE3DvuZhDIv+wKsvVFMnhAHwqSu2kKhenUhDCkZtE2WP6DVMFnE6vO0LKpM49R1jxUrAAg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935caaf5-63b9-4f05-25b4-08db5c04b0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 03:12:21.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M57oKXtuleiUZQaamLS2HNkjZ/cszIIETG3QZuuhG6YPgTfRwBuDTsMEzgaiGXtnKAm+K/WIoSmMzC8e2Q5h/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8843
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMy81LzE4IDEyOjEzLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBZZXMsIHRo
ZSBjb25jbHVzaW9uIGF0IExTRk1NIHdhcyB0byByZW1vdmUgbnZtZW9mLW1wIHRlc3QgZ3JvdXAs
IHNpbmNlIGRtLQ0KPiBtdWx0aXBhdGggZm9yIE5WTUUgZGV2aWNlcyBpcyBubyBsb25nZXIgcmVj
b21tZW5kZWQuDQo+IA0KPiBYaWFvLCBjb3VsZCB5b3UgcmVwb3N0IHlvdXIgcGF0Y2ggdG8gY292
ZXIgb25seSBzcnA/DQoNCkhpIEthd2FzYWtpLXNhbiwNCg0KU29ycnksIEkgb3Zlcmxvb2tlZCB0
aGUgY29tbWVudC4gSSBoYXZlIHNlbnQgdGhlIHYyIHBhdGNoLg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtYmxvY2svMjAyMzA1MjQwMzA2NDMuNDA0NTQ2LTEteWFuZ3guanlAZnVqaXRz
dS5jb20vVC8jdQ0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmc=
