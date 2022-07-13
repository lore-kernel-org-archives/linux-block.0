Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C939BC43334
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 12:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiGMMIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiGMMIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 08:08:38 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 05:08:34 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA15F07
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657714115; x=1689250115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xaNyPFbD797U3LBq8H/7z3xvAwJUmfcPczfpDlVmWIY=;
  b=ZTMlgqI0Y6V9qM8/rQgNqMjT5f2UA8dDgUOF6EOuPmZVR5e76bNsuzyD
   /UWEg/svepSB5H5rDL8r2Wo0EYWtCU9/EobfsDvwP0cf4gUgPAh7MJX/x
   TUamT4/EriH/PiIwFC+otVP5FSRZuOxS0AgL4fDXWkMXLPZQvU8lFGga8
   l8x4hHNOfEdFI3EQIhlC1LxJOPiXyzXHBoqFum5gMXssFa64TVkqul6HX
   94l3Nu/CTm/X6JkL1Gq/rPo7tx2cSb2PMwKd9S5vdDmbvwV3qwwnIXkrI
   4p9lO3o5SO9loNHLhiM9iCDL7IqZ7R9hFcLaYCT9SY4U6/5moyZT389W2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="60246937"
X-IronPort-AV: E=Sophos;i="5.92,267,1650898800"; 
   d="scan'208";a="60246937"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 21:07:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlEgwqDoLj7fAy3AstmlYvrvbjRL7uuUZaZ6GQbgNgcAjnwrE0lij8buMsuo0fprTqdQaFkac0OymJacJo1YOM1vLcbcyqZ4UYI1wATVwQNVnfhW+FG4/Q91NAVvrLmCRKjlXwUyWH1HHMFM5Dd7QUQk+A7FEYSta3qHa0EgDm1GTyPHrhWFSvP4mUqpScLAOyp3vu15kNKIHKCtVtbsyXrIoXf/oBVmq+oRu3IAeWsosRIf8tht28Cw6/obxJb2nuezDBDw0UYz2EKkb0kDHADZvJTVHnptKXjp+jk7JLtMrNI7zSJtRSJuFGaMo7z2z3cvNfVNQxmSWIjvsdU18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaNyPFbD797U3LBq8H/7z3xvAwJUmfcPczfpDlVmWIY=;
 b=A8kZhj/9Y9xm2GKL5nsvMS6istpvpPLroydZ/i1Pu471wXS3Mi7ocX7HG9h7S0/MD8RqdZPEFlIPM/tKZCe1drcqrJ1hhnJifjIBS+OI5b8QhsVmZvk+uut899XJWbEdw66AKkKvwhnKp8DzvoMhdSDmLA+A9u1P2v/cpalNBzof2CP0WbL4TRiH0noe+jUJ+5L3SSXC3HNtrx9OxW6g0/f8QsD2h77O/EHZE8Y8mFDETbuI3rAb7EoBPOVP6DB+82AX1UCyd506Hch4n/dbIEZa1cvDKVHTJ08/tM29YlEOJVMK9YF9hv8Rtso5a3AGJp+NSL1dMURpct6nzLZPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaNyPFbD797U3LBq8H/7z3xvAwJUmfcPczfpDlVmWIY=;
 b=FOmyyih3PSd6ikRzk0CF/I6jpPMAXGN4P78nwH6D7E3u/S6F33VmYv4IRi1bO4ScAZa5vFiky5sCt23radiGgfXQ0zeUKGDL5pCadciPbzJ+70grmC5drlN8dgawn4sb1ahFaE0QhxmfY3G1gN5xyvriO2Mw66JS25Bx2cE7jMc=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB10372.jpnprd01.prod.outlook.com (2603:1096:604:1f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 12:07:23 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 12:07:23 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] common, tests: Support printing multiple skip
 reasons
Thread-Topic: [PATCH blktests v2] common, tests: Support printing multiple
 skip reasons
Thread-Index: AQHYlchYp+hJb/1IDEaA2XEJcTS1ha18HsaAgAAX3oA=
Date:   Wed, 13 Jul 2022 12:07:23 +0000
Message-ID: <c10aaeeb-c074-6e05-e8b1-b9744c6bac59@fujitsu.com>
References: <20220712082810.1868224-1-lizhijian@fujitsu.com>
 <20220713104155.m57oodbmwhemjre6@shindev>
In-Reply-To: <20220713104155.m57oodbmwhemjre6@shindev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31045558-1457-41f3-d764-08da64c83e9d
x-ms-traffictypediagnostic: OS3PR01MB10372:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BF0nQSCZR+7pxV3NI6KJXi4P5ty3r8bQ/2jKEa1VTFyUIYKWO9wzarpFbYm2ukKY/itj49UQhrMAOBYzXdumGK4zNUNWB9tecJz5Vg1uGhZrHSXj41W0lPKxYhHb+tjaGDKld/uGa/fA9/KwWvZlaAcE6NLlT5NsM7WqzrSQMAsogCZD7Nnap8EE5ZNUKkWkTojOFS/79TFKvt0zaR8JgjhtPrt/xUA7weNLZG+ZsgD1rH+Gz/U8cnzUp1dOicU7XeACSc6lPbvBGeQqLvczTaJZLPZB2C0GW7Hbn/tbGhMsTVZ2wsYW0JvSvg2de9AkGuN0MSKF1EZmoAW8T7NCqeiqdecbxQvYEh29Lh5/GNkmD8v2fShqdqvychjgrZix/C0pEUV40o+ztKjI301DmHl9zGHdfuLnM6F/OaQjWP0ULgTWBXNYWNtNd8uEYkhvDzqD2y/1Xyy478VdGfhPGy/yHZeR9L+LPH6idQbXmIAimNqVqlKzHTReL5B+IrCtODkAnZ2Uel9zC87Cq+NlSjfwUn2Da2IYcbCTgfPXZnpGtvAfBwwfTcPCVZsbmkkyFxn1GvZa2AXo5WS66IGOrmiptpkjJk97vfp4yAr3HyOgYPenKUYGAGYYhVh4YZ3U4pxtnR+V4+OPJLf+heQ9ctGzXQHelMQQhU8YJ5AAXa1t4uhpZR2wD84yfqqNbY0i5fKe6J1hyxVbaoqmClER0+j/zWfboR0njKj0BTRdiCDKzdimovC383HXz43UEVFZ70bPrQHk4OjLz5Vrrs+y901k2hqFp2moxKYNbA+3Xh1K22GqpzbqFgvdj7JC4m16TZpB8FTqLCzRl9w45QBFw2GIR7+nk2jaYMnD+Gs9BdUaTzYMTO0lVmsntkFpepy1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6506007)(26005)(41300700001)(6512007)(122000001)(478600001)(38070700005)(5660300002)(8936002)(82960400001)(71200400001)(91956017)(38100700002)(83380400001)(64756008)(2906002)(66556008)(76116006)(8676002)(4326008)(66446008)(316002)(66476007)(66946007)(6486002)(6916009)(54906003)(186003)(2616005)(31686004)(36756003)(31696002)(86362001)(85182001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNQbWlRSFhCczhaMU5wSkVuVjNJUE9iMEt3MGZNcEZSWFg3UlBlNmIzL1ZG?=
 =?utf-8?B?cDZ1WWtNUDZPcWxEWjVFeHA0bFBFT1pTVnZIOWc1TVBoOFEwQlVRdWhuWUt4?=
 =?utf-8?B?QzBzcm9zTEJsUWJ4VWtubnJ4ZE10dTNhMEx4MzQ2Wkp0THk5cDBXMXpEaytX?=
 =?utf-8?B?NUxGNyt0TTl6RlNTeGxoQ292aW4zb254WXVVSHgzckl5ZmVYNTI5Vnk5cGtv?=
 =?utf-8?B?S1MzR2s3RmJwTWFkS2wwYmVFSmpmdURhY1UwSmFPWWlLZklCNzR4MGxFVDdC?=
 =?utf-8?B?dkgreEUrWXBhR1hwazRBa1NiNng0c0lVNkZRQmc0bDAvUjFRUzJKeWJaR0lV?=
 =?utf-8?B?bldDOEE0UGpiLytObG42b1MrVStNbWIrVkN4ZTlFWFN0eXVuLzVuQzNSVGR6?=
 =?utf-8?B?MWRTaWJXcUFPK2ZWS0g3VXprSC93TmQwMDRLSGxwRDFtUndaOXlqNHQwa2xH?=
 =?utf-8?B?TTVZSzFJUDlVVWVqM3ovVXc3OXlXYU8yUGlNUk9QYlZxRndZY3dWb3NQTXIw?=
 =?utf-8?B?TXVoUi96cHJFOFNYYnJSYVA2TmZ3bHNzb3B2MmN0c0tCQXpNeVBNcEp4cmlm?=
 =?utf-8?B?SXAwbGkyWW9YQ1pDbnlkMzEzYjgyYXdZdWxFQUVma01zdDRSWmRGQllMbHQv?=
 =?utf-8?B?U3RUODFnVU0wQ0kzWlN4M1hCRFY3LzUxTTN1UitSUElROFJ3dVJuVlFaM2N6?=
 =?utf-8?B?Qk93NnA0Y2Z0QzJxRDE3VktNRDlKc3NNVmJTNExKZTNSK3Iwd3FnZVVIK3FU?=
 =?utf-8?B?ZmpNWVk4Smt1N1V3cjg5UCtraEhLWFBhcXh6V2Erd2dYNldPNHRYZ3ZwcFdk?=
 =?utf-8?B?SndsbHR4aUVwK242V2F4TVA1V0p5eHN5bzlPVHRUOFlDZi8yb2k1MS9kTzNH?=
 =?utf-8?B?VVJ6Y1R6ZXV4ZG1JSUYzRE1jbjBsQW9XWlhIeGtIaGIweWJDYmdwVSsrS2pP?=
 =?utf-8?B?SStDOGpoeFdnUFVvVmE4dU81UlFXYmxqc0grSXdxdjIvUlhnWEZEZEJiZDhJ?=
 =?utf-8?B?R2dIM1hWQTFYRnBRVlhXTEgyUEtoVnpxQkpBQWxwOEdUWHVxam1ESFVnc3Fw?=
 =?utf-8?B?SXZaVFFMMXZrdkdqL3dnWVduaytTdGpiT0UvU0oxaDlEMGZRWFAyMndHbStF?=
 =?utf-8?B?RHB2SmJtTkJjTzhyVVpmU2pCZlZmRTk4Y1NJMHpycWdJcUFhN05NRE9GcHYy?=
 =?utf-8?B?WEl4SXBVVzNxZnQ4TmdYd3RJQ001STdYQ0NIUFl4M2g5OEpmQkVtQ2FSa3Az?=
 =?utf-8?B?SlBmb3lDYzN5dmNVSVZZK2VWYVkvMWZaYlBqaDhEcHVORWZ5M21GU3ZHcHZ5?=
 =?utf-8?B?SVFvL3Y1RDJFU2NuQVIwUWZ6M0UzMXQvN2prRUE1aVhkejAwUUM4V0ErYTEy?=
 =?utf-8?B?d3ppUVlPTU5kSFVVRkpIR0Q0RFkyVkFyZ0hzY0ljbzFweGh3QXU4aTRzQ3gz?=
 =?utf-8?B?Y2d6Mlo1WmJQaHhaME8xa2ZsMHlpMk00YnI0dVZTNFh0VWQ4THZTY0E5STdp?=
 =?utf-8?B?aEduMzNMdFJIVEwxUEhsdWVMVGtrYzVtcWNUWmd3SEMzazBneWZIbmxjVXhy?=
 =?utf-8?B?MmlDYXpudElERGdKR2xOSWtqZzhKYkIxMDB2NytxdXJNcVU0WEZmYmlXUnVC?=
 =?utf-8?B?OVlZQW1jTlZlY0kxOVhwZ3lPZEIvNm85cW8rNURsTkM5R2J0dy85N3g1TzFs?=
 =?utf-8?B?TzVDRXhtZjBCK0J4Zy90K1hjKzh6bzhSeFA5ZEYxSnlkaDUxVkduZ2JaRlpE?=
 =?utf-8?B?SGtGTUNKK0dSaExmaDE4TnVZbVRDcHhxeE41ajN0QlQxMDgwN1F4YnMzMXpl?=
 =?utf-8?B?K29HUzhNV1pvS2swQzlCVTZUdzl2N3BzQUdLdytSMkI5ZmZERXg0dkpQcGRo?=
 =?utf-8?B?ek40Y3N1YUE3RnU5WHVCVTJNM3BWdkNWbUxOQlhWMXY5Yklnc3hwclBIN3FX?=
 =?utf-8?B?cWVpYitQYjB5WExHTEhrYkxVUkpiN1BtNEpDZitLdENXZlRORjU0ZEFEZUpN?=
 =?utf-8?B?SlV4cm5FaHVidXR3RE0yb1ozanVQVUxOZDlCM3NkUVhESHMyQStVbTBVVnJM?=
 =?utf-8?B?eFgreVg3M2JZVlRwbUNpMDR4cDM4RndpaTZSUm1mZEFkeS9yUDkvQm1qZHN5?=
 =?utf-8?B?U1U1TCs4eWFLSEkxdEFMSGZvbzhtSk5xZlIzMEdMbEsrTzJlMjJ5Njdzbzhz?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DC5AF099A39814BAE09DD47C1447DFD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31045558-1457-41f3-d764-08da64c83e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 12:07:23.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9XIPIPU+YaLfGHLaSpr2JnfNFlIwQjtXWcxPVFSTF9q3d7Kx7FX6smdDj1b8RAa3JUK0qHommNRodgUQOjXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10372
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpvbiA3LzEzLzIwMjIgNjo0MSBQTSwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gSGkg
WmhpamlhbiwgdGhhbmtzIGZvciB0aGlzIHYyIHBhdGNoLiBJIGZvdW5kIGEgZmV3IG1pbm9yIG5p
dHMgaW4gdGhlIGNoYW5nZXMNCj4gaW4gdGhlICJuZXciIHNjcmlwdC4gUGxlYXNlIGZpbmQgbXkg
Y29tbWVudHMgaW4gbGluZS4gQWxzbywgdGhlIHdvcmQNCj4gIlN1cHBvcnRpbmciIGluIHRoZSBj
b21taXQgdGl0bGUgaXMgbm90IHNvIG1lYW5pbmdmdWwuIEl0IGNvdWxkIGJlDQo+ICJjb21tb24s
IHRlc3RzOiBQcmludCBtdWx0aXBsZSBza2lwIHJlYXNvbnMiLg0KPg0KPiBDb3VsZCB5b3UgcmVz
cGluIHRoZSBwYXRjaCBvbmUgbW9yZSB0aW1lPw0KDQpObyBwcm9ibGVtIDopDQoNCg0KDQo+DQo+
IE9uIEp1bCAxMiwgMjAyMiAvIDA4OjIxLCBsaXpoaWppYW5AZnVqaXRzdS5jb20gd3JvdGU6DQo+
PiBTb21lIHRlc3QgY2FzZXMgb3IgdGVzdCBncm91cHMgaGF2ZSByYXRoZXIgbGFyZ2UgbnVtYmVy
IG9mIHRlc3QNCj4+IHJ1biByZXF1aXJlbWVudHMgYW5kIHRoZW4gdGhleSBtYXkgaGF2ZSBtdWx0
aXBsZSBza2lwIHJlYXNvbnMuIEhvd2V2ZXIsDQo+PiBibGt0ZXN0cyBjYW4gcmVwb3J0IG9ubHkg
c2luZ2xlIHNraXAgcmVhc29uLiBUbyBrbm93IGFsbCBvZiB0aGUgc2tpcA0KPj4gcmVhc29ucywg
d2UgbmVlZCB0byByZXBlYXQgc2tpcCByZWFzb24gcmVzb2x1dGlvbiBhbmQgYmxrdGVzdHMgcnVu
Lg0KPj4gVGhpcyBpcyBhIHRyb3VibGVzb21lIHdvcmsuDQo+Pg0KPj4gSW4gdGhpcyBwYXRjaCwg
d2UgYWRkIHNraXAgcmVhc29ucyB0byBTS0lQX1JFQVNPTlMgYXJyYXksIHRoZW4gYWxsIG9mDQo+
PiB0aGUgc2tpcCByZWFzb25zIHdpbGwgYmUgcHJpbnRlZCBieSBpdGVyYXRpbmcgU0tJUF9SRUFT
T05TIGF0IG9uZSBzaG90DQo+PiBydW4uDQo+Pg0KPj4gTW9zdCBvZiB0aGUgd29ya3MgYXJlIGRv
bmUgYnkgZm9sbG93aW5nIHNjcmlwdDoNCj4+DQo+PiBzZWQgLWkgJ3MvU0tJUF9SRUFTT04vU0tJ
UF9SRUFTT05TLycgJChnaXQgbHMtZmlsZXMpDQo+PiBnaXQgZ3JlcCAtaCAnU0tJUF9SRUFTT05T
PScgfCBhd2sgLUYnU0tJUF9SRUFTT05TPScgJ3twcmludCAkMn0nIHwgc29ydCB8IHVuaXEgfA0K
Pj4gd2hpbGUgcmVhZCAtciByDQo+PiBkbw0KPj4gCXM9IlNLSVBfUkVBU09OUz0kciINCj4+IAlm
PSQoZ2l0IGdyZXAgLWwgIiRzIikNCj4+IAlzZWQgLWkgInNAJHNAU0tJUF9SRUFTT05TKz0oJHIp
QCIgJGYNCj4+IGRvbmUNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+IFsuLi5dDQo+DQo+PiBkaWZmIC0tZ2l0IGEvbmV3IGIvbmV3DQo+
PiBpbmRleCA0MWY4YjhkNTQ2OGIuLjgxNzY1NmZhYzk3YiAxMDA3NTUNCj4+IC0tLSBhL25ldw0K
Pj4gKysrIGIvbmV3DQo+PiBAQCAtNjQsMjkgKzY0LDMxIEBAIGlmIFtbICEgLWUgdGVzdHMvJHtn
cm91cH0gXV07IHRoZW4NCj4+ICAgDQo+PiAgICMgVE9ETzogaWYgdGhpcyB0ZXN0IGdyb3VwIGhh
cyBhbnkgZXh0cmEgcmVxdWlyZW1lbnRzLCBpdCBzaG91bGQgZGVmaW5lIGENCj4+ICAgIyBncm91
cF9yZXF1aXJlcygpIGZ1bmN0aW9uLiBJZiB0ZXN0cyBpbiB0aGlzIGdyb3VwIGNhbm5vdCBiZSBy
dW4sDQo+PiAtIyBncm91cF9yZXF1aXJlcygpIHNob3VsZCBzZXQgdGhlIFwkU0tJUF9SRUFTT04g
dmFyaWFibGUuDQo+PiArIyBncm91cF9yZXF1aXJlcygpIHNob3VsZCBhZGQgc3RyaW5ncyB0byB0
aGUgXCRTS0lQX1JFQVNPTlMgYXJyYXkgd2hpY2gNCj4+ICsjIGRlc2NyaWJlIHdoeSB0aGUgZ3Jv
dXAgY2Fubm90IGJlIHJ1bi4NCj4+ICAgIw0KPj4gICAjIFVzdWFsbHksIGdyb3VwX3JlcXVpcmVz
KCkganVzdCBuZWVkcyB0byBjaGVjayB0aGF0IGFueSBuZWNlc3NhcnkgcHJvZ3JhbXMgYW5kDQo+
PiAgICMga2VybmVsIGZlYXR1cmVzIGFyZSBhdmFpbGFibGUgdXNpbmcgdGhlIF9oYXZlX2ZvbyBo
ZWxwZXJzLiBJZg0KPj4gLSMgZ3JvdXBfcmVxdWlyZXMoKSBzZXRzIFwkU0tJUF9SRUFTT04sIGFs
bCB0ZXN0cyBpbiB0aGlzIGdyb3VwIHdpbGwgYmUgc2tpcHBlZC4NCj4+ICsjIGdyb3VwX3JlcXVp
cmVzKCkgYWRkcyBzdHJpbmdzIHRvIFwkU0tJUF9SRUFTT05TLCBhbGwgdGVzdHMgaW4gdGhpcyBn
cm91cCB3aWxsDQo+PiArIyBiZSBza2lwcGVkLg0KPj4gICBncm91cF9yZXF1aXJlcygpIHsNCj4+
ICAgCV9oYXZlX3Jvb3QNCj4+ICAgfQ0KPj4gICANCj4+ICAgIyBUT0RPOiBpZiB0aGlzIHRlc3Qg
Z3JvdXAgaGFzIGV4dHJhIHJlcXVpcmVtZW50cyBmb3Igd2hhdCBkZXZpY2VzIGl0IGNhbiBiZQ0K
Pj4gICAjIHJ1biBvbiwgaXQgc2hvdWxkIGRlZmluZSBhIGdyb3VwX2RldmljZV9yZXF1aXJlcygp
IGZ1bmN0aW9uLiBJZiB0ZXN0cyBpbiB0aGlzDQo+PiAtIyBncm91cCBjYW5ub3QgYmUgcnVuIG9u
IHRoZSB0ZXN0IGRldmljZSwgaXQgc2hvdWxkIHNldCB0aGUgXCRTS0lQX1JFQVNPTg0KPj4gLSMg
dmFyaWFibGUuIFwkVEVTVF9ERVYgaXMgdGhlIGZ1bGwgcGF0aCBvZiB0aGUgYmxvY2sgZGV2aWNl
IChlLmcuLCAvZGV2L252bWUwbjENCj4+IC0jIG9yIC9kZXYvc2RhMSksIGFuZCBcJFRFU1RfREVW
X1NZU0ZTIGlzIHRoZSBzeXNmcyBwYXRoIG9mIHRoZSBkaXNrIChub3QgdGhlDQo+PiAtIyBwYXJ0
aXRpb24sIGUuZy4sIC9zeXMvYmxvY2svbnZtZTBuMSBvciAvc3lzL2Jsb2NrL3NkYSkuIElmIHRo
ZSB0YXJnZXQgZGV2aWNlDQo+PiAtIyBpcyBhIHBhcnRpdGlvbiBkZXZpY2UsIFwkVEVTVF9ERVZf
UEFSVF9TWVNGUyBpcyB0aGUgc3lzZnMgcGF0aCBvZiB0aGUNCj4+IC0jIHBhcnRpdGlvbiBkZXZp
Y2UgKGUuZy4sIC9zeXMvYmxvY2svbnZtZTBuMS9udm1lMG4xcDEgb3IgL3N5cy9ibG9jay9zZGEv
c2RhMSkuDQo+PiAtIyBPdGhlcndpc2UsIFwkVEVTVF9ERVZfUEFSVF9TWVNGUyBpcyBhbiBlbXB0
eSBzdHJpbmcuDQo+PiArIyBncm91cCBjYW5ub3QgYmUgcnVuIG9uIHRoZSB0ZXN0IGRldmljZSwg
aXQgc2hvdWxkIGFkZHMgc3RyaW5ncyB0bw0KPiBzL2FkZHMvYWRkLw0KPg0KPj4gKyMgXCRTS0lQ
X1JFQVNPTlMuIFwkVEVTVF9ERVYgaXMgdGhlIGZ1bGwgcGF0aCBvZiB0aGUgYmxvY2sgZGV2aWNl
IChlLmcuLA0KPj4gKyMgL2Rldi9udm1lMG4xICMgb3IgL2Rldi9zZGExKSwgYW5kIFwkVEVTVF9E
RVZfU1lTRlMgaXMgdGhlIHN5c2ZzIHBhdGggb2YgdGhlDQo+PiArIyBkaXNrIChub3QgdGhlICMg
cGFydGl0aW9uLCBlLmcuLCAvc3lzL2Jsb2NrL252bWUwbjEgb3IgL3N5cy9ibG9jay9zZGEpLiBJ
Zg0KPiBUd28gI3MgYXJlIGxlZnQgaW4gdGhlIHR3byBsaW5lcyBhYm92ZS4NCj4NCj4+ICsjIHRo
ZSB0YXJnZXQgZGV2aWNlIGlzIGEgcGFydGl0aW9uIGRldmljZSwgXCRURVNUX0RFVl9QQVJUX1NZ
U0ZTIGlzIHRoZSBzeXNmcw0KPj4gKyMgcGF0aCBvZiB0aGUgcGFydGl0aW9uIGRldmljZSAoZS5n
LiwgL3N5cy9ibG9jay9udm1lMG4xL252bWUwbjFwMSBvcg0KPj4gKyMgL3N5cy9ibG9jay9zZGEv
c2RhMSkuIE90aGVyd2lzZSwgXCRURVNUX0RFVl9QQVJUX1NZU0ZTIGlzIGFuIGVtcHR5IHN0cmlu
Zy4NCj4+ICAgIw0KPj4gICAjIFVzdWFsbHksIGdyb3VwX2RldmljZV9yZXF1aXJlcygpIGp1c3Qg
bmVlZHMgdG8gY2hlY2sgdGhhdCB0aGUgdGVzdCBkZXZpY2UgaXMNCj4+ICAgIyB0aGUgcmlnaHQg
dHlwZSBvZiBoYXJkd2FyZSBvciBzdXBwb3J0cyBhbnkgbmVjZXNzYXJ5IGZlYXR1cmVzIHVzaW5n
IHRoZQ0KPj4gLSMgX3JlcXVpcmVfdGVzdF9kZXZfZm9vIGhlbHBlcnMuIElmIGdyb3VwX2Rldmlj
ZV9yZXF1aXJlcygpIHNldHMgXCRTS0lQX1JFQVNPTiwNCj4+IC0jIGFsbCB0ZXN0cyBpbiB0aGlz
IGdyb3VwIHdpbGwgYmUgc2tpcHBlZCBvbiB0aGF0IGRldmljZS4NCj4+ICsjIF9yZXF1aXJlX3Rl
c3RfZGV2X2ZvbyBoZWxwZXJzLiBJZiBncm91cF9kZXZpY2VfcmVxdWlyZXMoKSBhZGRzIHN0cmlu
Z3MgdG8NCj4+ICsjIFwkU0tJUF9SRUFTT05TLCBhbGwgdGVzdHMgaW4gdGhpcyBncm91cCB3aWxs
IGJlIHNraXBwZWQgb24gdGhhdCBkZXZpY2UuDQo+PiAgICMgZ3JvdXBfZGV2aWNlX3JlcXVpcmVz
KCkgew0KPj4gICAjIAlfcmVxdWlyZV90ZXN0X2Rldl9pc19mb28gJiYgX3JlcXVpcmVfdGVzdF9k
ZXZfc3VwcG9ydHNfYmFyDQo+PiAgICMgfQ0KPj4gQEAgLTE0OSwyOCArMTUxLDI4IEBAIERFU0NS
SVBUSU9OPSIiDQo+PiAgICMgQ0FOX0JFX1pPTkVEPTENCj4+ICAgDQo+PiAgICMgVE9ETzogaWYg
dGhpcyB0ZXN0IGhhcyBhbnkgZXh0cmEgcmVxdWlyZW1lbnRzLCBpdCBzaG91bGQgZGVmaW5lIGEg
cmVxdWlyZXMoKQ0KPj4gLSMgZnVuY3Rpb24uIElmIHRoZSB0ZXN0IGNhbm5vdCBiZSBydW4sIHJl
cXVpcmVzKCkgc2hvdWxkIHNldCB0aGUgXCRTS0lQX1JFQVNPTg0KPj4gLSMgdmFyaWFibGUuIFVz
dWFsbHksIHJlcXVpcmVzKCkganVzdCBuZWVkcyB0byBjaGVjayB0aGF0IGFueSBuZWNlc3Nhcnkg
cHJvZ3JhbXMNCj4+IC0jIGFuZCBrZXJuZWwgZmVhdHVyZXMgYXJlIGF2YWlsYWJsZSB1c2luZyB0
aGUgX2hhdmVfZm9vIGhlbHBlcnMuIElmIHJlcXVpcmVzKCkNCj4+IC0jIHNldHMgXCRTS0lQX1JF
QVNPTiwgdGhlIHRlc3QgaXMgc2tpcHBlZC4NCj4+ICsjIGZ1bmN0aW9uLiBJZiB0aGUgdGVzdCBj
YW5ub3QgYmUgcnVuLCByZXF1aXJlcygpIHNob3VsZCBhZGQgc3RyaW5ncyB0bw0KPj4gKyMgXCRT
S0lQX1JFQVNPTlMuIFVzdWFsbHksIHJlcXVpcmVzKCkganVzdCBuZWVkcyB0byBjaGVjayB0aGF0
IGFueSBuZWNlc3NhcnkNCj4+ICsjIHByb2dyYW1zIGFuZCBrZXJuZWwgZmVhdHVyZXMgYXJlIGF2
YWlsYWJsZSB1c2luZyB0aGUgIF9oYXZlX2ZvbyBoZWxwZXJzLg0KPiBEb3VibGUgc3BhY2VzIGlu
IHRoZSBsaXZlIGFib3ZlLg0KPg0KPj4gKyMgSWYgcmVxdWlyZXMoKSBhZGRzIHN0cmluZ3MgdG8g
XCRTS0lQX1JFQVNPTlMsIHRoZSB0ZXN0IGlzIHNraXBwZWQuDQo+PiAgICMgcmVxdWlyZXMoKSB7
DQo+PiAgICMgCV9oYXZlX2Zvbw0KPj4gICAjIH0NCj4gWy4uLl0NCj4=
