Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F3C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 05:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCBFCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 00:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBFCI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 00:02:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4652B637
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 21:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FszyEJ5bM+29Ap/1f5AHtwIa/e+3dVOgONrm7F0HuJVDDD+EPyxYRZ07+C7sPRvMzFuCKt14N6i4I7CYFJiz2yMijxzBJt8b2eZ4mLEo8GR9AncXf61SAApLKhruCf7rpEAhd48mhFRSi0vOMnvKMtN25Fkrt2nH0YUnjVwUrHZGn66YbABcqM4lrvIOcYsoci3L0TjE40j4Neb0jL15V1bM6hY6LMPwr77aT2/PlMts+wqrx0tEY8MNUBgeOMIuKV0XTRY0PQ8sNscTpX8wA72fSkmkp/d9fIi+0ZcsM/DmOxwHnq+PVwWJvIdfv6x0gGH+KNX662CgsGIIP3E/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGag1rqs7m3iK7nABWuMcpj1UmaShq2e0aLtYWGin0Y=;
 b=Zfm65jJx76ZBJGO3GwjuKXf8juoh8+H2kVK8dLAUXuyAICduAlbHVV0zkYMwVzK3Yzl8L3gjF8jrPO8/dnD9WK50uo6EVe9Lo6nydftvXNJ3/D5RHYFXRVOy8fnCWTrRSOFOl3jbjMyhMyu4ND5J/zJ6zGnoqlbKNbXTWer5mhZLjRZnqTOD4uklRIFkMIYUulYw87tT+Xp3LfF6z3c0S1SBOoy51dMJ7elv+m3/8w/w4GX8fky3QkbGlhdDdVCqh18TNDAgnXqniMXtCaU93PltgrHdz5Wiif9mPSK9YlWBIaUw6EHjN7JP9IpeMChaviCTUErDL1lt0/9WSTkLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGag1rqs7m3iK7nABWuMcpj1UmaShq2e0aLtYWGin0Y=;
 b=uLdo+If+kYxFxLrpEGui+ichUqz/rLwtgH6Z/MgigV87EwmM0k+Bf9yXOvg4pnmy6RhwMEj8rWTFP61AD2Vrg108nc6uSb9OWGHbmjJndqFpzEUb+9FK9zrqmXW45xNUaykzjLO8fIQuIPJ45B5rt6DU03QULRVqNd2rUNj9Xk0qhWRxxepsLMEFAu9rVaC+F4BcpoBonOz0m+aBQCrZWhdcF07r6J4c8MwW3B25+O97le8U8LjjM7AKWw2fXNWoLvXpAl72ihstdBzC1Xn50gYDCvCzm5U9JSzIXaiu0b27Qj1G7wtVDcJB0YTFK4eTJ5IpaU49ix1NncKkHO03pg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 05:02:04 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::386a:2802:5f3c:bfaf]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::386a:2802:5f3c:bfaf%6]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 05:02:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests] src/Makefile: fix number sign handling in macro
Thread-Topic: [PATCH blktests] src/Makefile: fix number sign handling in macro
Thread-Index: AQHZTBRC3q2R1fsAkUuw1+4X8kOZPq7m8BoA
Date:   Thu, 2 Mar 2023 05:02:04 +0000
Message-ID: <82baea2d-0fa6-53a4-fd97-7378b2d41833@nvidia.com>
References: <20230301080301.2410060-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230301080301.2410060-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|DS0PR12MB8442:EE_
x-ms-office365-filtering-correlation-id: 90a9a38e-c9aa-47af-58c2-08db1adb43ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vM85Ega11huFEFqSd/VZz1xg/aVYT4SJ5Eh2/83FdgHjD+zeTZ0RBgyWOMwfJEyEkvzL2W4YtlwTkbtNG6uJl8wblf53PusUs6nHA28AMgaEYok9N4+P2R64WZbvgx/3C/Uxsq9hBw43ZgECHe15yzLTqFh18+iqAbL5U4It+8LvBl3V/gN8idoS1KDQSLYLJRlyk8ggYrEJ5aS6T7Qnm9nUcU/QDfQbdh+mJ32ICEi3P5iD3So3bf71n0bDBCKbsvYT0NnsLQMBYuSr5haUGPvEx+Bn4gmjWzH2rN4jcwi7mccZA9Rwh/TfggRBZzBC22eb7ZAQ/Oav38oExazoQ0vmPLpLtNj6240WU2X5r0tgq1yinQQOgrOEAwXtvUE+byHx9gaTDBcEQ/sfA2ydFxj7VD0sj29aHV4ZdR7KNraoDc6vSygHY++iEZAVo/xYIQ25aNPyUB5mbFlGA1XtJuuJVZRKogzmmCm7ojncIA8qBCCsgPv6OTQpuz2e9+0htyMq2xQuGP8wTb0kgdkNV6YcIzigEKCZRY8rnWkL7gHWvISfl5Huf3nsto1LbTJ6Rnu0AhDi/CiplreswznVBGmi1iYsSpWX7rhPgBfrHVXYpo104MUOGw/nAcezmcgOr4G5cBYgx8qIPad2c0zThKAOM0ULUmSTCLEZo1KA9vcT/oHR+CR+aoWvQ2zp6eDrCGhDC+yfbIsnHQxnIuE7IPXF0oJmjXk8JWtoDEzjUZyoh9KLhTIDQl66MFrfuqnxPzjVJGIXO47BlLauMpaLlX1Tc0Qf+HqSEbKUD0+9y/OL4xoCIRM00yy7BdnDk322ZoRIllMEgNwBYcoNWVom3LIgCKjseyPlDV8jDXbnPFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(122000001)(38100700002)(4326008)(38070700005)(31696002)(36756003)(86362001)(4744005)(2906002)(66446008)(66946007)(66556008)(64756008)(5660300002)(66476007)(41300700001)(8676002)(8936002)(76116006)(53546011)(6506007)(2616005)(6512007)(83380400001)(186003)(110136005)(91956017)(316002)(478600001)(31686004)(54906003)(966005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTJsZ211N0ZGUlBJcVZEbmdwblYvUVZsT3dacmFsb2wveCt3Q1o5bEVCUDlm?=
 =?utf-8?B?b3lsRHhSYVpaL3ZHYlVnTFB3OEpiUzVDT2ZmK1EyYmFEOE9scHJhNkd5bmdB?=
 =?utf-8?B?ZjZPUS94QUU4SGxpMi9ldEgzeHVTR1pXNnNmbWp0MHpkTi9OenB2bXNKTEp0?=
 =?utf-8?B?b2oxcmRmTVRuWGsvM0pkRzNJaytUNVVnM1VnYjQveWhtSEY1dkN2TkJJamhU?=
 =?utf-8?B?M09rWTlMb1lLWTV5QSttSVdSYWsybWY3S1paZTZ1S3dvT3RVR3RIK082L1E1?=
 =?utf-8?B?aVlWZ0pFWmhtSGlWOHpDSUtZbHFRNDdvclg5UTNvL3cwZi9iODZaSG1mRE1I?=
 =?utf-8?B?RTI5SjYzS1pmTFA5K2ptVXB2K28ybkt1NEl6US82VUJhMFhXbUZsRGhnbXpI?=
 =?utf-8?B?Witzc3BiK1NVTyszVjhhazI4UW9RampRNXMrNlRRc3NIaWE5ODFWY1BpTU1R?=
 =?utf-8?B?NTdIeE1ITXFkb3NiMG0vRy9HWnFrcFRjaWhOdDgrKzNrRSs4YXd4V0ZFbkhL?=
 =?utf-8?B?VFZ1eHJ0ekJNa09jVmU5YnA2UkhHakRrWDlNSHpvRzFvWnU5VzE1VGZ5NStv?=
 =?utf-8?B?bU1vUDdzQ1crNHZNVFlHT2Fta1RsNGFVa0JGSWxPSTA3MG9sL3RqNXcvbFlm?=
 =?utf-8?B?aEM1Uk9BWGVFN3B6Q3NUSFljZ2tCV2M5MmwxMG4yWG5YUW5GaEJqOVEwOTVR?=
 =?utf-8?B?ZWpuZmd1SDlFM2tLTEt2L2RCb1FnWjhSK2c1Q2hmWWRBakErZmJVSGZ2cThs?=
 =?utf-8?B?ZFNpOTlPK1NPclNjVEtrb0xtdmExNFh2U1hQd0ZyZFFQOU5yU2hRODdueXQ3?=
 =?utf-8?B?dUY1elg4S09reEZNdko3aStvMk9aQ0dXWi9TOTFnc3RjYmVlMEU1ZDl0eTRO?=
 =?utf-8?B?WitqWGN0M0ZjME55R3NUOWRIay9wWnlmbVlnOG1qZlNLVmRVQ2Yya2k4Uk1t?=
 =?utf-8?B?MGtpUUs5SVI0NDJ0S0RER1hhcVM3aElmcnM2SkVKaVNxVEpsME01dFloclV1?=
 =?utf-8?B?R0RjSm5MbUdLS203Qmt6K0JjL3N0bUtEcFVhekd3M1k4TG1qSmdINHJtalUz?=
 =?utf-8?B?SUxmdDFkSy9aRFVzMHZQampPaUZMREtVV080cHFFZ3N6S29ScGlzd1BsWU51?=
 =?utf-8?B?QmdpdXFRSkFyWmNLTHpVY0p1OWE1VG9WNWRKL0RIbWN5TjEvY2xHVXdMUUti?=
 =?utf-8?B?Sko5SjFoMVU5Ny9paXc0eVdBVUkzYU5CYXZpLytTUFVhOFJpOUp0UVFlUGNl?=
 =?utf-8?B?Q2lNQytZSi9ZR0dETEU5VTdSdGEyNjJQMWZwOFR1M2JEdlhIdlgrODNiQWRY?=
 =?utf-8?B?N2h6WE5kNHRWYmdjY3VOYTI5RVhpMll1TDRYVFBGT1YvejdqRlZMWXFOTzVz?=
 =?utf-8?B?ejN3cGx5M2FPbVlHS0ZFTE5mZlpBTFhBS3VzUWVUZ2g5VGkrTVQ3MGovUU44?=
 =?utf-8?B?ZFlScXFRR3hxdUIwMFJwaENZakFHLzllcTdjSllBQ1lSb01vYjdyRERITlAx?=
 =?utf-8?B?MU0zSUh6V0VrRUhGZnRTRVJTWXZBQmJnU1lpYkhET0IzckJhSFpuUnlpQzlx?=
 =?utf-8?B?T0F0NTQrM0xRSnFwVmJ1UmYwa1BKR0Noa3E0UXBQclFWbHhBZVlTbmo1L2lT?=
 =?utf-8?B?dlkyMkd4MW4xNVRHTC8zdUNQNnNKelFwdXM4a1FTRktnZVRTc2JBaitWTm43?=
 =?utf-8?B?ZG1RQVdxS1dsZEZRMUR0R1A5MnlvNUE3MXBDK0FmVUtXcGlDbzc2ZlcrNndw?=
 =?utf-8?B?Um9kNWZlcHRrNzBBTnhKZ01lVmhCOSs2c1pCZHJyN0JGU0FIb0t2cWg2REQ2?=
 =?utf-8?B?aEVEbmN6N3p2TVdCbERISUZRVDZWa0tGbnhpTUpyUXJ3TGpjNHcreU5iV0N1?=
 =?utf-8?B?MytiaTh4aFY3L1l3dThvSG8zS1ZGcXpzZlhLaFV4emhtTGhZZzNYY2hUaHI3?=
 =?utf-8?B?TldmQzY2RnVxWkdlSzIxbnJuRHhJUktTaTh0TFp5Z2ptbUk1dmlyTk0zSHpD?=
 =?utf-8?B?Wmt0TUQzclpPczNYSzJDeUlneGFyK2FJTURGZUxKZ0FhMGwyME5HWWZzc0Zx?=
 =?utf-8?B?dk9GL3ZWcU80WU9yUG4wNXRpL3ZjTnZaYStJUDBhSmFNYU9WekpZTzVJQUwy?=
 =?utf-8?B?UWFQbENXOWlVQjNjYU1CNUIxbjFWZllSNlZScm9LNWM1bXZZc1huS1ZpdnBk?=
 =?utf-8?Q?dhtsNepgaYCp7/SnHf3WTON/nwU4hotq4TqqjNNtzjSg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3ACD1DC39452D4B98AB131751D2A9DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9a38e-c9aa-47af-58c2-08db1adb43ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 05:02:04.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ql4GTc1N8sd4DEZ4J2SlOY3ukdU57vjq3v0nOkfBaxElPWAA1+sG1u6w4//055PleZB0eTuROF+jsiBqNcjItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8xLzIwMjMgMTI6MDMgQU0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBHTlUg
bWFrZSB2ZXJzaW9uIDQuMyBpbnRyb2R1Y2VkIGEgYmFja3dhcmQtaW5jb21wYXRpYmxlIGNoYW5n
ZS4gVGhlDQo+IG51bWJlciBzaWduICcjJyBub3cgc2hvdWxkIG5vdCBoYXZlIHByZWNlZGluZyBi
YWNrc2xhc2ggaW4gYSBtYWNybyBbMV0uDQo+IFRvIG1ha2UgbWFjcm9zIHdpdGggbnVtYmVyIHNp
Z25zIHdvcmsgcmVnYXJkbGVzcyBvZiBtYWtlIHZlcnNpb25zLA0KPiBhc3NpZ24gdGhlIG51bWJl
ciBzaWduIHRvIGEgdmFyaWFibGUuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVz
LzgxMDA3MS8NCj4gDQo+IFJlcG9ydGVkLWJ5OiBaaXlhbmcgWmhhbmcgPFppeWFuZ1poYW5nQGxp
bnV4LmFsaWJhYmEuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1i
bG9jay9jZmNjYzg5NS01YTliLWY0NWItNTg1MS03NGM5NDIxOWQ3NDNAbGludXguYWxpYmFiYS5j
b20vDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KPiBUaGlzIHBhdGNoIGNhbiBiZSBhcHBsaWVkIG9uIHRv
cCBvZiBNaW5nIExlaSdzIHNlcmllcyBmb3IgbWluaXVibGsgWzJdLg0KPiANCj4gWzJdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjMwMjI0MTI0NTAyLjE3MjAyNzgtMS1t
aW5nLmxlaUByZWRoYXQuY29tLw0KDQoNCkxvb2tzIGdvb2QuIEkndmUgcmV2aWV3ZWQgTWluZydz
IHVibGsgc2VyaWVzLCBmZWVsIGZyZWUgdG8gYWRkIHRoaXMgb25lDQp0b28uDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
