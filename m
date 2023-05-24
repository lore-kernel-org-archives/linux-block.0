Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34008C77B7E
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 03:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjEXDUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 23:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjEXDUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 23:20:34 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 20:20:31 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DA18E
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 20:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1684898432; x=1716434432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SGkuV5QGb0AOWwxrJOloGBdY7FsvLAtIm95cgb78J7k=;
  b=ZTyv/53v+Tdy4lT4sROINIgNdv7DiRNQKSmbFNPIbz7JPYPCiMHO52Tr
   gf6eHSo9TbZQoHsl+Vcxh6YJsHnFS9fNg7kYjI59v5d4rWXOBNl8yMt94
   qux/5hG7l2oOn5uOtmCllKsm6J3YC1Kmk2dliRsOHlpxDmHGgcSaohS2K
   CsoqsXlROgm6qHtvmFWLPRZI0AS5nv1DZ7BzETOwhiMvvU/FI8OY+FqhW
   Lxp7ocbmGNbNLKnSrRpqdELAvdFTq+ERgsh2fn/eR6I4YXXewiUU4VGs8
   0hKeW6fDUL1ng8xfFfP2cTSX3uxrOXYjZfMBUwC3aO8RZaYPDzn3JjEPX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="84871772"
X-IronPort-AV: E=Sophos;i="6.00,188,1681138800"; 
   d="scan'208";a="84871772"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 12:19:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hECR2KsWfSIl/LlXHKdTOek3eiYZEOLxb60y6EL6cruI68xVEodx6f94WZtb/q5DEdASFE7vrcCnG/73n1sUcJFpgd/fipbX/X7bj+4EFRagPYzFd1XF9cp5J32La75gFJrhERqUHBvepx5zVGoHIPVb8WnnBRNCaJI1aa3yLEME+GcqAQGbKtcJQSk2t+0DNZQfqMtpyIrsJk6ncVfivvJe1agN3GoEiyQj7koKFBEVvX2eXrc1uG4XiGxHJuafxk/xwtKgTNJKAJUpLIUockfxFjF1Jr1UtubPjw1OPdWvEbZQqJq60LnJAlaqOklV/GiRJ3+BaGETTrA5YlGvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGkuV5QGb0AOWwxrJOloGBdY7FsvLAtIm95cgb78J7k=;
 b=GSDh8/zfyr35BADtyLJfIXS6xkVFLpcxk6Px0XFI3/gHyyqMaQYi0Yy873CZAo3JjBJZQr7NcGDyWN2jjsEmGffoWYRkb9t7rPe8F/CHVrm3mbOnmQotU6WWwl8qCs7bchDxEHtyvisSxpB0SjwbdTIZ90NsigU+N6GpWM6xdSvV38Yt/bRLdpmC5U6LvRMrXthoH0HvtO+NLmZwVacwSpgj5gdUWZuyr5MDQVhGistrR3sp0IGVkYSXPo4hkMD4RrPmzzKPhS3hPR3y0qMsqjGNw9QLLU0krqVH+nfhYnsLw+CDTvQ3Xep3BWxv9fFZBIXHoSJ6ikwfdRgU6sJQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB8634.jpnprd01.prod.outlook.com (2603:1096:604:19c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 24 May
 2023 03:19:21 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::a883:7aee:71d:b4a1%3]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 03:19:21 +0000
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
Thread-Index: AQHZgw1y7RgZnDRyM0uHcXHHUvTGz69THeoAgAAFZYCAAAF6AIAAj/OAgAvDdoCACV7BgA==
Date:   Wed, 24 May 2023 03:19:21 +0000
Message-ID: <0a5149cd-1d8b-2968-c790-196671bfc157@fujitsu.com>
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
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB8634:EE_
x-ms-office365-filtering-correlation-id: f3399ee1-0f35-40b5-a5df-08db5c05aadb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBaM5sCkF5yD2jlYI9SoKyQhrgz1spSlOmM5k5cTenpHDQ9tsTMSfWbViY5QTwpT5PME8DrPPMWsv8apTCtkXt6LJ3BB7r+BcYZmNJLdGNMj5OfOanJJs7dHsaH4R0q2YaIgbSrIkzCa/0xFwuTldEFpMMG8Xlx0ohzA+/5r8Mjz238QyoSXsPFkqhRbwxaNJjP7llIxxTUxrou2NPs//qLd5ziXLSeIitUAOIW+yugdI5H2b/Su4SbW+TKgsvG4rFlRLgMepnmGL8GeDlmo69J4V4y2EGHvQrtcCVIFfGSwCRbDiWcpajQgWVYTn9ETN3WVtxfvXnIqod+egw54pZqghbVjywHvR2+f9TbtCpLrszeIiDBPCQif+fjN9JYU21jFBVkKjts54QHG1aIHP8ipZXmy7Oi4MQHNKtY+riBg0serJXyJ4h5X32yJIYWF1ByWO0Tr6iF3jgLOq+4gHlgtCGi0vOLRURYTQYWMr3Bkh+iV3IR7sfWLI6ujQdoFR5LrVuglOJW/sCcG6Z5I7nLa9IVInXefqomnTiJZJGVxxWUA3zqJRc7F/IechtjXVtW6QnIgXzuV1QdN+yB+x+rk0sqV7Qs8Gdi9hgMjqt5lq0d7UA7WeKFyyMZuZvNHhOQ0tuN8dsop2L8gvYr4FsEj0rB42bd5rR2IlTifovs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(1590799018)(1580799015)(5660300002)(54906003)(110136005)(8676002)(8936002)(4326008)(316002)(6512007)(6506007)(36756003)(186003)(122000001)(26005)(76116006)(91956017)(66946007)(64756008)(66556008)(41300700001)(66446008)(66476007)(38070700005)(53546011)(71200400001)(85182001)(31696002)(966005)(6486002)(83380400001)(82960400001)(31686004)(86362001)(38100700002)(2616005)(478600001)(4744005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1ZsQkVYL2p4MXJyT3FNenJzdG5hTkxteTM3czFheGszVDFyRVRYaTVvM05F?=
 =?utf-8?B?Z3p5eUJGdS9ac1hHVnJSRkU3aEZnTE1Ka1NNQzZ2Q0k1K1lyWTFpbVdYb3Rk?=
 =?utf-8?B?Mk9wS0JoVm9XZXJYVXR6SXI3c1VyUE5NaGlmRHh3dWRaSVM5cUFOcnVRZ0xG?=
 =?utf-8?B?ZnViV1hlSUw0RFlRRStXYTZ0eG0zN2RmNUZENGtxSFc3bXFXU3ZWMUYxUGpp?=
 =?utf-8?B?UjdxK0E1S1VROWJHdVd0cnd6OTdyNjd0ZDBSZFZTTG94RUtRQXBVZjhuTSsy?=
 =?utf-8?B?d0xIdlpUR0oyN0tBaVdEN3RtelJGNWVCc0ttbStwa3d6VU4rMnJ5ckNodlc1?=
 =?utf-8?B?RjlOSUVWK1ZqUEh5OXlmTG05cVNDbndSeDlTZ053VGplaW1uL3VJcG5RUVI4?=
 =?utf-8?B?TXZYc1hIOGI4d0pCQzFDTTNCU1FxWGIxclVqRUNCbUs4VElBNllXUXpvWlln?=
 =?utf-8?B?d1pMSGs0TTlzNisvZEt1YnhnYWhNWmdWSlhqZ1hhVGM2amUzM1pTc3pHd29l?=
 =?utf-8?B?MmFQZ0pyTlhXTWp5TnZlOEJXVlM1OFJ0dkpmZFJyOWJPOEs4T1VuMUhHRmNa?=
 =?utf-8?B?MkxSMzFSNHhwSUczdkFPT1VXc2haMm10c0JSQnF1QTU2Q1h5eDB0U3cwSFpW?=
 =?utf-8?B?RnNGdEhoOEZ6THNKNDQvYUN2aHEreVdzRnQxejQ4S1pmemoxRFVDaWNwU1Zz?=
 =?utf-8?B?TWo3VXpzL3VGVnB1Vmd5VExlT2V4TGhabUdtc3RLSWxkS1BOdWFRZTZkQlRa?=
 =?utf-8?B?b2NFeFQ2ZEU5SXdvckxMVmJhcHJUOHJkVjlWZ3F0WkJkZWp0cWRqc095bGln?=
 =?utf-8?B?OVN1R0JGa2tZaWY4ekNhUHk3Q2tHVnZhSDVIWEM3dVVqVml4N3RrT2kwcVNp?=
 =?utf-8?B?NXFjWW56cWVqNUlPbGZlYzQyNnhvSHVoblQ1QkhNUG82R1hsNnczczhxaUlq?=
 =?utf-8?B?T0V0Yk1nL3czc3pSSWE4Y2V2THZVVTZlQkFHMlM0bWlyLzNxRUo4Y0g0YUpK?=
 =?utf-8?B?NGo4bjBvODFKekxKQ2ErSExsWjgvSkRralg2aDVFODk5UXM5eDI2cHE3VVpi?=
 =?utf-8?B?MEZMY1RaQWxteDVYNEJ6SmJNOUZPSXBFRkxtblZvTWN5SVk3TERpeHhMY2Vn?=
 =?utf-8?B?WW9qQk5TUkZuM2RvT1lvVVMrcmNVNDM4OWoxYXpSZXhSRC9GTVBLOHJsUUZm?=
 =?utf-8?B?NUx2UEdxZ0ltNnM2ZFNnWng4dmtMRWZsa2Q0SzNwQ3ltUk95QlB1UTBHRVZw?=
 =?utf-8?B?YU1wT0ZXSnpkNEU5UGVqSlV3SDMwVE9HK1NESmxyM0pPOUVxVW5ra1B0ci9v?=
 =?utf-8?B?b0w0Mkc2WU45Y1pkZGplQnZ4QXhZZlFybUFLR1BqMUsyOCt4c2prTEJrVnZO?=
 =?utf-8?B?bTdQRlpCd2l4NFF6Q0NDRDlNM3B1L3hnZk9ZaFI4YWJUdWluY0kwRTdISWlN?=
 =?utf-8?B?WlA4UWZGb3M1NWtnOG1Iam5GcWxxcjZOL1VUaXpKYTlGZnJyalU0TW91YzF0?=
 =?utf-8?B?WkN6NlFlRU1lVTRaeFFSUzlQSlhDcWtYblVJRDJHR0JlUUordHd5N2ZsZEFu?=
 =?utf-8?B?K2NweTl0Wms2MWEyUjhPR0lBdU1taFVESHo3WXAzKythalk5VWgxWGt3bGlP?=
 =?utf-8?B?eFlrUy9DNGhldmQ2WUhUN1h1TzhkbTJKWVE2VW9wc3lBcWtTc1VGczR0V1NC?=
 =?utf-8?B?aks2ZWZ5eTlQZWFiTTZwK0syZHRGYTVXekF4VnoxdG4xTzljTzRibUVrYXQy?=
 =?utf-8?B?UWh4bG02Nm1YZk9jL1BPL0g3alZmRGl5SGZXZ0JoallxZTJTKzZENkZja1Fo?=
 =?utf-8?B?dTdwZCsvbHNYTjJna0pvNXFOTldEb25oR2VFWFNZampPU3hRVjhRTHRUVkt5?=
 =?utf-8?B?SHpzNDV3YmNpdHEzbWlHSFVoM2drQUtwcE5nWk1mUmpCV3llRVFkdHhKQThM?=
 =?utf-8?B?NERWL1hnc2g5U3cxb2JJVHM4eno4cVU5OWhoWHZIaGdKV2Y5RjJkTVNxOXBv?=
 =?utf-8?B?TjBlWE9DaGViTVZqOGpKNUF5WHg3cCtjcE5DcVJyRXA3UkRCakRaM2JtOThh?=
 =?utf-8?B?NjhYZ3RPNDM0K0YrM3dLS1ZEeWkyRXN5OGh6ZTh4Mkx3ZnBrYUVWT1AyZ0pr?=
 =?utf-8?B?VHFZTW5Tc0I3YzZkRWVxdk9IdjRYN3BzQk5URXRDUG1Xb215RzFNNzZSNjlm?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28B35C48998BF244B2E90FD32ACE2DDF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ai8cFu+WJvkMkA1EulUZWpAkmGI6YIf8fGnne+TytnpZ508L1LgyzmXaBNlXfiMydKAqscQrQBo1LHAYw001ww1xoEVKR8wGm1RSL47fgn59hZv18lLO1iuGiOZV6hro+Ft3ZJ71+BT3Djz2hhCJryeMYwR0RkHVnqa5MHYJ7MVT3SBh680cqHSl26fzb1eRwfYk0rYP5l0r7iFm/od3NTcfXwCSl0R+NI/HyuxKOl6T9JyKTgAbrAmMvUKfutVaucUyFXU7NVmbfAXiLCMD21WK8HqebLcEuxwvIPczoyYRQt6dSXmp9m/ok/mBP6VvOcVPOoYUmOQmGLd4EwL8U42baWwA0uGH/28c0+tfGtzv4IlTmMWYXE5m90R3sLQlI2/GrpOsH60c5FVoLxQKUsGzUEgGZ+UQboMV41truaOmxNBpMahPDHvazZ7VixFnVR9PHQZqH+mGYpDcuvsLEngnmJe34K6QAb37Z5QKU4l9PgWXHz32wK8P1Le4ma7p5lkYjBX4bwNX6Di5Xml4+GTlizYlO1TLmIB30Bn9iTjPlg/t5buAvw0eOKkR2P1m33C4LN5T3KhVvFiPmAh51wK0VQ3lju3q4qXUDmtXoUjxwlTPb7FSwUDXUtO4oYpRC52gd8j1dvKj/lmPU5cjoxfz9DHgz9MNkGrCDJaE4wWL4uM9qS+M9M9E8/JTZLRSjBBPPTL0jr+cy2d+NcNT9A9vMavBS03KOlUA0ZQJMiL0sIgSp6tZt/53S57AfCj2ofjpemKP0cNx7cr3by7QJxYOHSWnD4all/5rBxjIIcuhawSzEctiagzmDPplg1mhMDbYvDlmkW3q4f6tDKF0Fg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3399ee1-0f35-40b5-a5df-08db5c05aadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 03:19:21.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwYeA1AUfwXQ3VpJnBl6Xmm46gwVYaiD/8xOy3EwyfXeiEZjR/IGqjlUaROMhKqiccGLHxeZGp3/ifn0E4AycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8634
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMy81LzE4IDEyOjEzLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBZZXMsIHRo
ZSBjb25jbHVzaW9uIGF0IExTRk1NIHdhcyB0byByZW1vdmUgbnZtZW9mLW1wIHRlc3QgZ3JvdXAs
IHNpbmNlIGRtLQ0KPiBtdWx0aXBhdGggZm9yIE5WTUUgZGV2aWNlcyBpcyBubyBsb25nZXIgcmVj
b21tZW5kZWQuDQo+IA0KPiBYaWFvLCBjb3VsZCB5b3UgcmVwb3N0IHlvdXIgcGF0Y2ggdG8gY292
ZXIgb25seSBzcnA/DQoNCkhpIEthd2FzYWtpLXNhbiwNCg0KU29ycnksIEkgb3Zlcmxvb2tlZCB0
aGUgY29tbWVudC4gSSBoYXZlIHNlbnQgdjIgcGF0Y2guDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1ibG9jay8yMDIzMDUyNDAzMDY0My40MDQ1NDYtMS15YW5neC5qeUBmdWppdHN1LmNv
bS9ULyN1DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw==
