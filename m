Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B7C43217
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 12:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiEUM2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiEUM2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 08:28:20 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 05:28:17 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F64E84A2A
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653136097; x=1684672097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SHUGNS08liLCzNAz/R5xuiRPKHL4xnvekksT/80QXZU=;
  b=bBwGqepBTdgyfBwPnfLysvNeOei/rka62Zvo94WhZ+P52yz+P8m2bgBc
   i3Kz20vxEMUVzwwRkA7Uq2OOsIlmnnzdb0WzzWk4yb90Hk5teilaxDgwo
   2rPEwC6XFZSbpwAs4dLgdxskjX4O02NBBmUHdUaprxtt1kMu2t6iUjAYH
   fuf+PsBrc4z6sGTf5L6IFAJtas4q/m6Mg2McJAua4f2btiBWIhCQ+mmuS
   W/1qM0UK6Zj2B6yixrOC8iX68UzIIXDOKuSzIHC5lq+8O6L+PW9l5xM+Q
   Ve5bFEVmPRw3+ZPEbP1XMmyeyU/kgwhnJ8mRm6NXH8eYARCO5gLeYVJaQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="56385785"
X-IronPort-AV: E=Sophos;i="5.91,242,1647270000"; 
   d="scan'208";a="56385785"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 21:27:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpTDLp7nasnqlbkaav7eA52/OUUyvzp3rOA9ZP76Ykv0+OxCwHjwAng97wLLAnJGz1Avc+754UCx1LllstLRuR4V7z9MbQ5doJRFuW3LS4pkiKA3i1wk/JkM8XHoWntguraFr91PV8heP3jPC6b1tjfalow4xG7DAv0VQS3ilfCqWjEbDYkhwjwR6rPHtJ9EEhKiLh1p+PJtFYE8wbeBgx18zS4jkV06KA8LaKbW1XkMB3QdeDl1K2HWt7RlSG9ULnnoIugMhWC9naAuqojDYNQvUY/yTU8Wd73FZtv2o2cqfzwgkfBeSRPwobdfgY/x0oF1/iInZICBWnk2kemPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHUGNS08liLCzNAz/R5xuiRPKHL4xnvekksT/80QXZU=;
 b=Q1fsdOoqCZQrZpn/IjsVDeLeBjFSNGPJutwokY7tWh+R8fn/RcVEDgT6SIkIpPmnQnUzeeVfxdu7g6JoIiVf5MhG5776/em9sXoV3iSkZr91SqWkf7v2+3lp1Bl8FZJiqCyA8MNDj5MvV17nIPkge0BsEJwLzfuNywMEumzxTQ9fX6iRfsvWWqCR27lygBPQ8e/T8ZKR4/w1vE86+QEUYTrr+57fZD2yIn+PsFRwvfqatrZZYUHcuFbM5VHJRrReZs0BnrPyLgBfZFS01PoJFWkJiMZnx5SV5wVFAjOYbxJMmeY7HClC9Zr9Fabk205bnwf1yBNRasnPm5X9BGugug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHUGNS08liLCzNAz/R5xuiRPKHL4xnvekksT/80QXZU=;
 b=BBPlV3AKk4vdvRQt3ymHTp5G68ryoDUqYOdq0EVddH7W/gauJCnWFK9znzFvJBzTONYsNrczAgT+yB9doh6UfznRvvGxKleufef6mftnPGWfbWprwwC1YImVlP2/L0AT/Seh3H5zooGvVFBx4RD+fDj/hnLxa/b2uf0E4+mmYkI=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB8724.jpnprd01.prod.outlook.com (2603:1096:400:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Sat, 21 May
 2022 12:27:06 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930%8]) with mapi id 15.20.5273.017; Sat, 21 May 2022
 12:27:06 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Thread-Topic: [PATCH blktests] nvmeof-mp/001: Set expected count properly
Thread-Index: AQHYammfWMvIUQy1tki/9oxSBV7UQ60nhZEAgAHBwoA=
Date:   Sat, 21 May 2022 12:27:06 +0000
Message-ID: <e96ad655-4546-423f-4584-84d0764d45ea@fujitsu.com>
References: <20220518034443.46803-1-yangx.jy@fujitsu.com>
 <20220520093717.gecy5qngf6l3xpm3@shindev>
In-Reply-To: <20220520093717.gecy5qngf6l3xpm3@shindev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1792bcbd-4274-4051-08ca-08da3b2537ed
x-ms-traffictypediagnostic: TYCPR01MB8724:EE_
x-microsoft-antispam-prvs: <TYCPR01MB87243BBE2713798DB489669083D29@TYCPR01MB8724.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qMkUPrZlZ9XSZ32v6+4zCW57ShEQgd9n+eKiRR+8W5JnQ1uL2yuqfA25fQ2Utju2pPb0Id7Tlm6+hb5JtOSRh/kH42vdHuNDYBciFLbZnHjkpu7A/kl4KLURPgZtuGHJ3HMdudaIxG9Gq0vhZ504RWw3AZTyIWteuq3P8fdArGdgCQoMFz7oJBL9nWc5NdnYeuTcbfae0bpO7q9VjvY2LxxMPeUOXUO1LaFZoRp5EQbDs0qjHnrtuLrIPvED7AqSjpQhH6R7/5salAPy1TCt7W8Efinoe6h7nQn3JBXfVSUPqr+c6b5l4FRVmCdJVGuylcgyitU9Yf7lGIlqBD43adhd73DrZ7/+et+OR0ptM6gbYc3PzIV2c8Navj8NgXp4G5Ycx+PrI32T6qOViwWtSSIi5JyvdszuWbeYve72nq4vhJPWWGmH/hMZZZt3uFGMIu+q6T4qniLlapKHJe+ePKiIyTvANWknWzH46flWvK2oG6Yp8CxrQFXDK0uGLyDJCwZfb3yAJQC4qq0ZB3EWtW9FXoML/4IVSrSfYrbmz4LC69nBSvAO4EwCrZ+0m3WYIaRGi6EdxcvLqjiI0LGkIzHP45zzUp2BXFtCUbyPHFS7f3X1us6SkwuxHOU0uSgh/hSUNvSVFikVn0H7TbirKp0FvIMzx7he1VCl6WEJZVY/ZIJ7nymUCS2GpZsuyA5ZS3de1KHm0OqYb/Qg0M3PG9Uz4gS7C7iYMdC01eukVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(71200400001)(66446008)(82960400001)(36756003)(91956017)(85182001)(31686004)(8936002)(4326008)(64756008)(76116006)(66946007)(66556008)(66476007)(54906003)(6916009)(8676002)(2906002)(38100700002)(508600001)(4744005)(38070700005)(86362001)(31696002)(6506007)(316002)(186003)(2616005)(122000001)(6512007)(53546011)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akhla0hxM0FDbnBuU1VDb3VqZjEzdll5MFoxKzI2dFRuRU9iclc5NlpSU2Rq?=
 =?utf-8?B?V1NXTXBqcS9nSndJZEEzcG9YVVZycElyeUhoWmN6NjhRd3VnM0lCTkdqeW03?=
 =?utf-8?B?a2lhaXdGNXJob25GVG9RTy81bWNSeU1oaWhMUkFzR2ZNZDVCakJyQUdLUStP?=
 =?utf-8?B?YnF6eHNyUExJL3o3UkZXbWVwOGk4UnQwbkx5Q1Z4dDdCWGNDOUhjLy9KRDRx?=
 =?utf-8?B?LzBBSlg0NWdaM0lxaDNPUXdINTRXM3BIL0QveVdjbERWMmp0K2puWG1IYTN2?=
 =?utf-8?B?K0d2YkFKSTBhWXJQayt0TjZyVExMU0J2TllwRlA1UW02cndObnFMWDUwNDdD?=
 =?utf-8?B?SmRicGhDV3prR01xb1U0NnRVR1Q4Sk04cTMxSVA3Q01oYytNSjkzL3hSMkxy?=
 =?utf-8?B?VzhudFF3elV6NVNLOVVHSjNVMjZZVk9iVlFHMW5ZYTB4cjdSKytzUm1BeUNF?=
 =?utf-8?B?NmpYZ283eHdHQnd2TkNZNWlrekQ4SW9hL2sva3hSSDZ1VzBzZW9JUHlucWgz?=
 =?utf-8?B?KzhXemhZQWExYlNXd3NzcFV1RlpNUHN1L0J3dWVYSWlWdWUvUFRLbHRSWmRa?=
 =?utf-8?B?SktPbEhWUVg4bXh6eGpHeVdTQ25YMy8yTTVPaDM3bTBoelBEbFQ5TW5XTDJU?=
 =?utf-8?B?aDhDeTV2KzNLZS93RDd4QXVvUktrdVVrcEhXZnZhbUpTVzFnZG44WnNZbUcv?=
 =?utf-8?B?eHgwRHlJejI3dWtteVlESm9la1lOVTNWUE9IY2hjMjdZUjA3Z0FycE8yaWZZ?=
 =?utf-8?B?Um1Qd1FWYUwyVnRxRUpaOHpJRmVabEk2V0VTNStSY3hxUEZGVHgzOFdVNmlY?=
 =?utf-8?B?ZTNuUHJ4NDB4cjZRV1pkM0YveDFIYk5KVkEwWWMzVnNZc0N3RGIyM0xPUmZt?=
 =?utf-8?B?Y0Z2UlhaUHhtcFhGOGJUZEZQSVlPR2xvMVFINkpZTGdMSEVkQmFNTUtyVUNu?=
 =?utf-8?B?R3VVRjBja0d6b2lDcHpKbVk5QStJT2w5K2hNRGtNRGNVRnJiVVlGb0ZYcktP?=
 =?utf-8?B?ZC9HakVENGxucm9DQXhLK3VsaTdvcXZldGVSTFpDQnlUd2tid3gwYy9sMyt6?=
 =?utf-8?B?S2FrRmswTWJWUVVKQ0FraUI5akNHY3dQZk9KbFVaN3lGakdNdEtQREhOUDkz?=
 =?utf-8?B?Qi9ualVkTnE3clBRN3AyUmY4Z0djRHAvcllVWHpzbHRXc1duTWhHenM3OGNs?=
 =?utf-8?B?YVpRWUJ4NXljanVJbG0vL1VtUkkzTGJJUUs5bzE1QllMMFk0N3lNOWJUUlZW?=
 =?utf-8?B?M0MxZytYa2U5WEZyS3Q5UVd6R3RyYTNsbGMzekoyN0wvYXUyRExYdytDQm04?=
 =?utf-8?B?K1FBSG9pa09tMitldzhpN3J2TTc4TXAyYW1oY1B6RlBOb3ZwZzV0Ym4vYmhK?=
 =?utf-8?B?UXdVNlc4UUJUWHJqOVdRTjdqNTQ2QmZqNjhSV3ZkQ1VXOU5tZWNLVEY1U0Z5?=
 =?utf-8?B?V3NGWG85UXJscW5LTzA4b3hBYmlrQ2MvVGZ0VTRNYkY0VUM1dUxGOVk5UWcx?=
 =?utf-8?B?ZXVWeE1hYkIyYUxrdXl4b1ZwL014UkhTblgrLzR5aGFiZzhDWlpJYzFsRTgx?=
 =?utf-8?B?M0gvVy9xeTdrR3VLMDdaZW1DQmNDMU5wLzllM29OVkNxeVVJRUsvRHdiTGZF?=
 =?utf-8?B?d1RJTGdGWGRSQWdlRGR3U1RmRFVHaEZhWndXdm04dnVqMEJPcGhOOVF1c1BU?=
 =?utf-8?B?NnJqekpEUWQ0MkkxZlJ1ZzJxaTRmRm9DMmJYYTU4THJGTGJUaEhJVnp3c21M?=
 =?utf-8?B?akFJcWFYSE84dHFRNWc0bk1CT2JyQTIwcnlaYnN6MjlIbTZLb3FQaEtidWVM?=
 =?utf-8?B?K2NGSzIrT2RRVnl2eVZiMWp6b0ptOUpWeEtlMDJCS05QRlZ1akpGdk5IcEhq?=
 =?utf-8?B?WTUxNWJTK2F6b1p2WUJqNlJ2WFVvakRqMEZsUlBCVVhXVTU5K2NkUnRPVUNx?=
 =?utf-8?B?S3plbDRnSWFCRWk0N3FJMFE2U0t2a3pSeFkvSWlTM3NiVk5KVkMzMFJYQUs1?=
 =?utf-8?B?cm05MEZSU2s4cGJBeEF0cVM1WjdsNnlaUDJQV3ZBRVlXSmk1UmhOQ3BOcnQx?=
 =?utf-8?B?YXRRTmpsb2Z6NS9MSHhBSjhJNW9uRW5xL0VNWW5JWHd2aCtWdEU1eWZUMUJT?=
 =?utf-8?B?UzlNSHBTamNXd28vLzhlZStoNnNkTFhBNGlNbnA5cG1lKzNVcVlFWitId2tG?=
 =?utf-8?B?dVhSNWdQRFc1dWNBanRpRWlMZVFnTlhlRFcvWGRWR0R4aWpaeGNydFFZUXJC?=
 =?utf-8?B?dUJyaUNBUTBHVXJGenhqN0FjYVhkamhSdmZlaExqWlZia2JuL3RuT1dsOUlV?=
 =?utf-8?B?SVBqelN3WWJiRjdpcGs3bUpndUxvTi9wOFNsMjB5a056M3NPNW1nR2VQaTRE?=
 =?utf-8?Q?1+RuYbizFZ62G8H8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F46D7D2523FD3840931247A031FBCA2B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792bcbd-4274-4051-08ca-08da3b2537ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 12:27:06.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUOvPKLU67pBllRb6CEQ5J+kRSZxd+sLmhuaWh4qN1Be40gBjsGnPKWi62IypBdm9vUyCWqfho1eelC13tVvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8724
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjAyMi81LzIwIDE3OjM3LCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUgY2hh
bmdlIGxvb2tzIGdvb2QgZm9yIG1lIG90aGVyIHRoYW4gYSBuaXQ6IGFmdGVyIGFwcGx5aW5nIHRo
aXMgcGF0Y2gsDQo+IHNoZWxsY2hlY2sgY29tcGxhaW5zOg0KPiANCj4gJCBtYWtlIGNoZWNrDQo+
IHNoZWxsY2hlY2sgLXggLWUgU0MyMTE5IC1mIGdjYyBjaGVjayBuZXcgY29tbW9uLyogXA0KPiAg
ICAgICAgICB0ZXN0cy8qL3JjIHRlc3RzLyovWzAtOV0qWzAtOV0NCj4gdGVzdHMvbnZtZW9mLW1w
LzAwMTozMDoyMDogbm90ZTogRG91YmxlIHF1b3RlIHRvIHByZXZlbnQgZ2xvYmJpbmcgYW5kIHdv
cmQgc3BsaXR0aW5nLiBbU0MyMDg2XQ0KPiB0ZXN0cy9udm1lb2YtbXAvMDAxOjM0OjE5OiBub3Rl
OiBEb3VibGUgcXVvdGUgdG8gcHJldmVudCBnbG9iYmluZyBhbmQgd29yZCBzcGxpdHRpbmcuIFtT
QzIwODZdDQo+IA0KPiBBcyB0aGUgY29tbWl0IGNoYW5nZXMgdmFsdWUgb2YgdGhlIHZhcmlhYmxl
ICRleHBlY3RlZCwgaXRzIHJlZmVyZW5jZXMgbmVlZA0KPiBkb3VibGUgcXVvdGVzOg0KDQpIaSBT
aGluaWNoaXJvLA0KDQpHb29kIGNhdGNoLiBJIHdpbGwgZml4IGl0IGFzIHlvdSBzdWdnZXN0ZWQu
DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw==
