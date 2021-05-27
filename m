Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0AC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEDB6054E
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 22:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhE0WrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 18:47:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10082 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhE0WrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 18:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622155581; x=1653691581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=42TIbegfNA6HavOM0b9hCK0i18j6VX89TKq9mHBk3Cw=;
  b=W5xsSGuKfklvnNBNbZT9lt2v6NAxpwRbly6gCBT7WL6seBbL7F8IQ2V/
   FLkg1A8JQEEkXveaLeYyewyaZAlaC/Vs6Ms+XniZJp+XOoBVuenF6K1FL
   QD6LtQ8oWqqlSyceTPv2zGJWuPuEBviqQK309gGtOq7AbaQAh90Vq3527
   3MQTvuNh7aQ8FbCnzG5vBX2kISse0JFeMdWrM6I5BWvJ9WNdsZ7BiAL54
   pObpusi+JgZaHVv9cEIDBLVcWzK03kS5uSAXvyNwo5YpU2/QXxFVqfovX
   /cTEhS2psaSHjAOljiiB/VKNx8ctEyykvtYTipB99OvSpYd40u9e2qRt4
   g==;
IronPort-SDR: iG3FCKWbERXYMk3ApMb10r+3qGtUCqb2I7uUTrDBA9wjn3ktGx0hvg96wCRDl9zm52h8cMVgdX
 a7R72FZL4utr0CvXo+NyMk5GyFx4kkIQA2CaPxbvBqpXHjioqOHdI9I13KIYcmpFaIoCWr2FAK
 VqTbF4ETJnxwulm49ojq8AF/OaBdZuZ8SaHy+8u/bG27VmpThLji03FjDJO0I+iNkgsz5jAPej
 QluLkfezLMp/fu1YG16VybNBK/RiZfiuTbkW04QoowjbPjn5GGuhMDpfqbxgoa05hBLybgZxiG
 CLc=
X-IronPort-AV: E=Sophos;i="5.83,228,1616428800"; 
   d="scan'208";a="273631568"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 06:46:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bruDiknD7Q45I2JyIYK/AG8F6fdcyWSPOTEDj56Xiz0czM3SgeMErDtmXu2JcYiYaSScaFAUVr82TavZoTLn/qtMVBHRM2ulWJOalqtP8kJ7CVceu3EvLwolhF1YKet2rua4V9OFlgyUAhD5r+Ex5dtwvjD0rpzMubV67ZFiyNYBnYTlRznbag/LT80j8BItFsMmuYagRGQA2bHgt6gEQT2LEvS5fQqK48lTbDmyiZ784n4Fc4qBFP5Vs9zis6658M5KoaLE5d5qbg1QD5rLwmVuEOc2N7Af+v7/De7aX86HkKNrxXxjY1yk3DlQwvxBiKCGvYS2r9BwpWmq0ztSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TIbegfNA6HavOM0b9hCK0i18j6VX89TKq9mHBk3Cw=;
 b=RI/q001gtZdWttbu5EeZUHCr3z3hW4mBqYF9mril4KdzjvfGwDaVvwKT12BfLXcuYEVu8i9sCwFY2kF7RIqttNBdC8ZYL+QAZ+CgviaH9BTlz8UwVo2fJcTHHuTAIfuuI+MB3F8asC/0BWOqMFltMkLL8XUotju7lmOvFbAmeNoBu9EkTKqs4lGZ7vlmi2RlDKxKpVOSoZ6pB8yUsRCJyXrg6+7Gz4Q2qCZ3J8iHYseBC5KyILSvH4op85vqJjGzJgIU5ASvep0s0CQAFW1g84BvIxLWIUiu0Jvh4V9g4FdDMD/PYem1qDIlUFzM3MhOYq+NeLKFWYTSPTpQwTKGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TIbegfNA6HavOM0b9hCK0i18j6VX89TKq9mHBk3Cw=;
 b=OmSqTb3FbUjVcFxV156eEe3Nwe+vTuQpKMHD9TFRvi4n2VtsFTiKRVU9TwfUQ9huOfrOTG8XygqNprVdyt52CvPGkBZYGJJm+Or+T8X1vrHkMAT+SvKYHYp1p+padgL129NSfWh7xjVruneBtYds9w5QcuGCEf3QuXFEwH09NW8=
Received: from BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 by BYAPR04MB4966.namprd04.prod.outlook.com (2603:10b6:a03:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 22:45:44 +0000
Received: from BY5PR04MB6549.namprd04.prod.outlook.com
 ([fe80::4900:1849:5718:70f]) by BY5PR04MB6549.namprd04.prod.outlook.com
 ([fe80::4900:1849:5718:70f%7]) with mapi id 15.20.4173.024; Thu, 27 May 2021
 22:45:44 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/9] Improve I/O priority support
Thread-Topic: [PATCH 0/9] Improve I/O priority support
Thread-Index: AQHXUpPj1h587LN2vki+xjB8TQ4eHar3nosAgAAPkYCAAEDIgA==
Date:   Thu, 27 May 2021 22:45:43 +0000
Message-ID: <06688c2708c59195a6a5a4c4f72a0f1ab8e7775b.camel@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
         <7c34db067cde1a4920dac73c1d38720597c948ca.camel@wdc.com>
         <a4846eaf-a53d-0413-04d5-b95fce5ad779@acm.org>
In-Reply-To: <a4846eaf-a53d-0413-04d5-b95fce5ad779@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [24.5.242.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adab1af3-5c91-4140-079e-08d921612970
x-ms-traffictypediagnostic: BYAPR04MB4966:
x-microsoft-antispam-prvs: <BYAPR04MB4966591F1989FE809F29C868F0239@BYAPR04MB4966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JmzaqC8LaRXPcgtAULwNRGUsA6tshHQ9/dBKZAXrVdGb6+aZfD0anSedtYctRTTHnhiImJHiH2m2Ya+bA8XVlQcYyuoO9VUYu1pBvH+jkf79gfKM17JuV6gB9tofULJgjH1jKSNAr5LZEfEcJLbYUG9gpzw+ilc+FX4A2r0xqGkCEoSZgSLxk0etc+bH8qD082qfsgwIMZlI3/uuoJZfvEqWdM/Cxpat//xpylDzm55Q+TJVFTKDfIIdTXkPAisoKd2XZxwuxM0ZiqAtbDTjpZZeMSYmTRFDFAj855D+upOa5MPYBg7H6oNEeJlC3GONg8AZiYBUAuv95QeosYEMBzwyNpJcsHJukFfFVK7cordTi3w0bjS/AddLoewYH/atEkdWM0gu4mk6/kBkmk/bhOMQutZ/aABAOYuOQhBnsfhK2BBl5xJnX/p+XvXee8f9Oqo8QvKY9GejYp2UcpnZC+KJnpeaoVHvkyOhmY9w+KPqwfBQoHb9sx1gTcKZH3BSLFiLHnNuCkNX+0qyr7kKxNqAAt5ZFLwAOMn2MC4xVWv0qlEciapqj8Jo6T1Vj7tqpQR7HbL+U0RX3h8NgFLefJ4nlMLSc6tPbAyQGJ6lAwpvpY8MtWWS3S5l734BttCWSxN9AcqPMWSQAJzq/qkqjBKXwQ3LkioZGKWD0I/E5Er9hPMHCmc+bXDtOWMkS5/CVcz1JmsXr+kB89dzUB3qOi3LmMFiOJfHCHKsiW3t88k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(5660300002)(478600001)(8936002)(6512007)(110136005)(38100700002)(26005)(122000001)(53546011)(54906003)(76116006)(186003)(36756003)(8676002)(83380400001)(66446008)(66476007)(966005)(316002)(66946007)(6506007)(2906002)(71200400001)(2616005)(64756008)(4326008)(86362001)(6486002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnowQXgvTW1BYkpNVUhtSUxFS21HWFhpUmlFWFFYUC9DeTd2b2lQdHZXQ1hZ?=
 =?utf-8?B?MGRjbVJjcEwrYlA3dzVrOFRoc0Q0UVlIZzZoMUpwWlJkZ2grVDAxMngxM0pW?=
 =?utf-8?B?djRSeFBIbTRVZE1oT0JpejEwdGUzbHZmTnNEQlBPV1gyUTZOYlc3N2NQOEtC?=
 =?utf-8?B?aVVyT3pnYkdTN0tQU1RRWjZHUXpsU292eW83V1hHOVJaaEhpenI3ZTBzOHVQ?=
 =?utf-8?B?eDdOSmJTellySzhVckZPa3ZXS2FodEFqWTR5ZitCYU5INVcwbXA2Njliekh6?=
 =?utf-8?B?c0F6ZDBXRGhveldZaHkzaitRSmJIZ250eDdueXc4cDBXNnVDSkk0YVpkNGtx?=
 =?utf-8?B?bVgzd2phemlGdWdxaFVqZGlDMDBQRE5XRFViNFkvaVJGajQ1ZG5zWlJJL2cv?=
 =?utf-8?B?U2lVVDVRWFNmeTdYVGtOWDFmMXViMmVhMG5jKzMwTkJXLzhKWFArOCtuMWRs?=
 =?utf-8?B?dzkzQlhPSWZ6K3F6N2dYMEE2eDhaWTBlNGNmN1JNRXZZbjM2TmlZRjlLdVpl?=
 =?utf-8?B?Ui9Xc1Z6M0tsRGNuRlYrMCtQNDYyU1J5TWtOWStZM1lseTlZWm1xc0FYUG9j?=
 =?utf-8?B?cVhYYmxibElNc3BSNThyT2hGQjFGVitna2Y1aS9DU1AzdkdvV2FyRHQyemRs?=
 =?utf-8?B?MFNWeitqK0RjWlZ5dEtQTzdmMVpRbm1pKzArK1JqbXU5S0IyaDFBa212azJS?=
 =?utf-8?B?aDd5VDIrM3JVVnAzTW5VeE1FU0syVjVIQnFjS2JCVThnMkhGVG5mdHNNYU5u?=
 =?utf-8?B?Nzk2bHRFSWVYUHh4dWNtcmllbW5DUm9TYXArczYvOGhETGtINXZOSzl6S3c3?=
 =?utf-8?B?QXdkTWJ3WHpoMm9xTmExWHc1dTJGYlM2NDk5U3JnaTNFWGYzN29iNnpIajZn?=
 =?utf-8?B?ekNURDdYNkZaLzNuYzIvdG1rSW00ZkE3V3AvaERlc2dqUFJrYWxmaWlWMGEx?=
 =?utf-8?B?ZDIyTEl0M2J2M2o0cVJEMXBNZHVBV1lDZ2dhWm5MMUg1a1dHQ1JqdlNaTnhv?=
 =?utf-8?B?QjZxb0JHamN0dGcwNk12Z3JNQTc3YWk1eWtGcWRZNmlENUJnSnRvWHZwTkgw?=
 =?utf-8?B?UTBOT2VuVmVvd0pCZlduMitOWnl5MFRydTRVMThyUjI2elBSR0U3RVAyZmdF?=
 =?utf-8?B?S2pCMmRQdnpxdVoxaERhMVQxbHVacVRvWmRyTGpCSWlDelpROURmOFJDckVC?=
 =?utf-8?B?eUxIUTZOMENqNi9ST1U5N3h2S05OWSt2LzRRMWpZbkJiTUZJTW5Za2NudmFr?=
 =?utf-8?B?NTI2UmxyYVFoSmVtZkFMdGhpMVJKc0Myd29DOFlpSmIxOGV3NC9Ec3pGQWhR?=
 =?utf-8?B?SUo3bFl5YkNyVzdFOS9VTThCcDJDQXQ2b01Gd1JLR2FMa0ZLY2p0VFZUTmV6?=
 =?utf-8?B?VTVTSVAwLzRzbzVsb0xSZURCY0xZR3V0UjNRRTY0UFhiUWFzYUtYWVhPS3pT?=
 =?utf-8?B?YnhxcjFaZzJpbG8zcGdyYlI3MENseXpkYUJCbEFqRHhQcU9MT0V5RE9lODRx?=
 =?utf-8?B?QTkzbkx3dHpIU3JvWmgrcjIvRzg5ZThIdWF1R3BqRnZyUDdRa0FkaGdDNW5H?=
 =?utf-8?B?ZFJuSEE5dGxySkUxSmI5YlE0Q0FZZ2pqNkFkTHVsQWdaQVRUdmNTUjRtcDhB?=
 =?utf-8?B?QUQ4YUpVSDJ4Zm1xYUo4TThHb1BOWW1kQ01RRGNqUVpqMFVIRFVoYVRNWTVE?=
 =?utf-8?B?Qm9EWnZsL01udUdoOU1LNkRXR1BiK0Jvc0RSZmwvVTVEZ3FpYTRXUkUzSDNy?=
 =?utf-8?Q?lqRznHDNddMkk00kXqErZDReDJFTMPyEvcg+DgY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9056CD9C286B284CBFE91C42FD37E906@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adab1af3-5c91-4140-079e-08d921612970
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 22:45:43.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eINDhwr730+NFYTfmLKahn7LCO4Y88mxgqjn8yR/36TMMOqGfSUOL51Zccf4oY1QQy19D+ex/kyBzMvq0prxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4966
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTI3IGF0IDExOjUzIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIDUvMjcvMjEgMTA6NTggQU0sIEFkYW0gTWFuemFuYXJlcyB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjEtMDUtMjYgYXQgMTg6MDEgLTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4g
PiA+IEEgZmVhdHVyZSB0aGF0IGlzIG1pc3NpbmcgZnJvbSB0aGUgTGludXgga2VybmVsIGZvciBz
dG9yYWdlDQo+ID4gPiBkZXZpY2VzIHRoYXQgc3VwcG9ydCBJL08gcHJpb3JpdGllcyBpcyB0byBz
ZXQgdGhlIEkvTyBwcmlvcml0eSBpbg0KPiA+ID4gcmVxdWVzdHMgaW52b2x2aW5nIHBhZ2UgY2Fj
aGUgd3JpdGViYWNrLg0KPiA+IA0KPiA+IFdoZW4gSSB3b3JrZWQgaW4gdGhpcyBhcmVhIHRoZSBn
b2FsIHdhcyB0byBjb250cm9sIHRhaWwgbGF0ZW5jaWVzDQo+ID4gZm9yDQo+ID4gYSBwcmlvcml0
aXplZCBhcHAuIE9uY2UgdGhlIHBhZ2UgY2FjaGUgaXMgaW52b2x2ZWQgYXBwIGNvbnRyb2wgb3Zl
cg0KPiA+IElPIGlzIGhhbmRlZCBvZmYgc3VnZ2VzdGluZyB0aGF0IHRoZSBwcmlvcml0aWVzIHBh
c3NlZCBkb3duIHRvIHRoZQ0KPiA+IGRldmljZSBhcmVuJ3QgYXMgbWVhbmluZ2Z1bCBhbnltb3Jl
Lg0KPiA+IA0KPiA+IElzIHBhc3NpbmcgdGhlIHByaW9yaXR5IHRvIHRoZSBkZXZpY2UgbWFraW5n
IGFuIGltcGFjdCB0bw0KPiA+IHBlcmZvcm1hbmNlIHdpdGggeW91ciB0ZXN0IGNhc2U/IElmIG5v
dCwgY291bGQgQkZRIGJlIHNlZW4gYXMgYQ0KPiA+IHZpYWJsZSBhbHRlcm5hdGl2ZS4NCj4gDQo+
IEhpIEFkYW0sDQo+IA0KPiBBcyB3ZSBhbGwga25vdyBjb21wbGV4aXR5IGlzIHRoZSBlbmVteSBv
ZiByZWxpYWJpbGl0eS4gQkZRIGlzDQo+IGNvbXBsaWNhdGVkIHNvIEkgYW0gaGVzaXRhbnQgdG8g
dXNlIEJGUSBpbiBhIGNvbnRleHQgd2hlcmUNCj4gcmVsaWFiaWxpdHkNCj4gaXMgaW1wb3J0YW50
LiBBZGRpdGlvbmFsbHksIHRoZSBCRlEgc2NoZWR1bGVyIHVzZXMgaGV1cmlzdGljcyB0bw0KPiBk
ZXRlY3QNCj4gdGhlIGFwcGxpY2F0aW9uIHR5cGUuIEFzIGJlY2FtZSBjbGVhciByZWNlbnRseSwg
dGhlcmUgaGV1cmlzdGljcyBjYW4NCj4gYmUNCj4gbWlzbGVkIGVhc2lseSBhbmQgZml4aW5nIHRo
aXMgaXMgbm9udHJpdmlhbCAoc2VlIGFsc28NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtYmxvY2svMjAyMTA1MjExMzEwMzQuR0wxODk1MkBxdWFjazIuc3VzZS5jei8NCj4gKS4NCj4g
SSB3YW50IHRoZSBhcHBsaWNhdGlvbiBsYXVuY2hlciB0byBjcmVhdGUgb25lIGNncm91cCBmb3Ig
Zm9yZWdyb3VuZA0KPiBhcHBsaWNhdGlvbnMgYW5kIGFub3RoZXIgY2dyb3VwIGZvciBiYWNrZ3Jv
dW5kIGFwcGxpY2F0aW9ucy4NCj4gQ29uZmlndXJpbmcNCj4gZGlmZmVyZW50IEkvTyBwcmlvcml0
aWVzIHBlciBjZ3JvdXAgaXMgYW4gZWFzeSBhbmQgcmVsaWFibGUgYXBwcm9hY2gNCj4gdG8NCj4g
Y29tbXVuaWNhdGUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGFwcGxpY2F0aW9uIHR5cGUgYW5kIGxh
dGVuY3kNCj4gZXhwZWN0YXRpb25zIHRvIHRoZSBibG9jayBsYXllci4NCg0KT2ssIG5vdyBJIGtu
b3cgd2h5IHlvdSBhcmUgc3RheWluZyBhd2F5IGZyb20gQkZRLiBUaGFua3MgZm9yIHNoYXJpbmcN
CnRoaXMgaW5mb3JtYXRpb24uDQoNCj4gDQo+IFNvbWUgZGF0YWJhc2UgYXBwbGljYXRpb25zIHVz
ZSBidWZmZXJlZCBJL08gYW5kIGZsdXNoIHRoYXQgZGF0YSBieQ0KPiBjYWxsaW5nIGZzeW5jKCku
IFdlIHdhbnQgdG8gc3VwcG9ydCBzdWNoIGFwcGxpY2F0aW9ucy4gU28gaXQgc2VlbXMNCj4gbGlr
ZQ0KPiB3ZSBoYXZlIGEgZGlmZmVyZW50IG9waW5pb24gYWJvdXQgd2hldGhlciBvciBub3QgYW4g
SS9PIHByaW9yaXR5DQo+IHNob3VsZA0KPiBiZSBhc3NpZ25lZCB0byBJL08gdGhhdCBpcyB0aGUg
cmVzdWx0IG9mIHBhZ2UgY2FjaGUgd3JpdGViYWNrPw0KDQpOb3QgbmVjZXNzYXJpbHksIEkgYW0g
anVzdCBhIGJpdCBjYXV0aW91cyBiZWNhdXNlIGluIG15IGV4cGVyaWVuY2UNCnByaW9yaXRpemVk
IEkvTyBoYXMgYmVuZWZpdHMgYXMgd2VsbCBhcyBsaW1pdGF0aW9ucy4gWW91IGp1c3QgaGF2ZSB0
bw0KbWFrZSBzdXJlIHRoYXQgdGhlIHBhZ2UgY2FjaGUgd3JpdGViYWNrIGRvZXMgbm90IHB1c2gg
dGhlIGhhcmR3YXJlIHRvIGENCnBvaW50IHdoZXJlIHRoZSBJL08gcHJpb3JpdGl6YXRpb24gaXMg
bm8gbG9uZ2VyIGJlbmVmaWNpYWwuICANCg0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KPiANCg0K
