Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB6C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E3864E92
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBIIgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 03:36:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31940 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBIIgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 03:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612859776; x=1644395776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3AKcFZ4MVVs/qH28pntzTQ+zjID1i/sogEFCM/dOnOc=;
  b=eGLqlyIsCBfv8RaE1m1cx0oMY/k+bwTzQmOqRs/fbKLtysLE5eRfBV6c
   IxtrepuPwGZ4O9FkZFCMRWJqkb80bpkAw9dPmOi533mHds8kvmRNhXTfb
   Yo2eyAr8qsUE/Us6k8izbZHk26ZizQny7wcR3C6z1VT6AEHFGaP4+o7/4
   erMtwXtlgA4YwAcqJoKlas4HWNqqXPPzGAEeZKGvr0JWsbiUcalKoNyZT
   mjZD9zMYand6oHUZr+FyCcxInHIUpf+a8W4jY/uc6k5eSXqz+V9jTVzt7
   QakWB8MuF1uqVCG9wDUfoJoimjjgVzVH7Mt+zpcjvme5Wrh+bXGAZMjYV
   g==;
IronPort-SDR: ysU1DkkGTfphX+LzEvI14yiN4elvZJlECI+s0QRGZIUyWJcoa+D42hB0FgxrxaIa6Ev9jeh5PB
 qnztIknhVjRxOSn250k82jgS4/BYxpEe/PmNIWao5muPxW9D5Ro9uFTP+wYaNQAIr57DD1Dtgq
 KSTM7Vf73LL7RS2NMUOYL/tVvG90OAKEhclIgvzuO1CczUzhv2Dpdm8BzADmYSyHzGIvhdOwFE
 ki7Sh9MfrJyXha1GQgdRrk2dZAO1foLL/cxpPdVC92DcNZCmb1um2UYrh4bjYUW5/3d+/5Pppo
 jcY=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; 
   d="scan'208";a="163983112"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 16:34:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdBr448aMbGmU/efidLiSbkSz7/f1CJKiCQ4L4c6A4yUe2t2Zi/JJk/yi24Ygo9tUQ+baySyFqJ8ChYXRHsIrSs4KM/1+4inrPqXZid8c7fk+l+Prj9pLhL2AQscynDROMfkwoW8Iqj+kulhdHjcvf7s4u2HdAREaWZl+ywZ5PLRk5B/P2oSIgbCCKVDWlyK4r3i2T7sGBBZkMCtO5iGbAnUO7bBxTyTJTLsMw//idGtXXJzf7Xa7xMj/GS25xJ/GuzUpqIAOmjheFjy7kJUH022wtxRTffpKKC4SGNLaQcP+6/+QO1zUajVUkH3OBIm7TsUm1lS37/H/UVdrdE6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AKcFZ4MVVs/qH28pntzTQ+zjID1i/sogEFCM/dOnOc=;
 b=RmgwgVCyKGHez20wxc4KmAUtStvJ3J9ysam10JTx511pl+qiPyLGnHM2dGWO4NVsyd4Cncj8e2Fv2aRxhpWJfKZ42XWkq6XgJyEY/DzmKCOXk/C1IKseG/o5nmgEyghb4n6t0V5dDxYQyy3jnky7QLlwhhIlWekP6aeafGUv2MItsyHV+5v/oNPxVm+zI2z9bfThIGpPUmS7lSkcNta4F174xVGtAjW8sK1KLsKMW+3fVI9vWHFJlNSr3AyMhFkYtfsmHY5nbu0wAF/pfhwo1zmowViXeo06G8AbRjSLecp0Qcds9+meNXOB3NHFTIy1hVh/sqIOoUVAW3sO45fChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AKcFZ4MVVs/qH28pntzTQ+zjID1i/sogEFCM/dOnOc=;
 b=TXedKSF9EOlr/7SbOU3mOKsEeKXskk8b9TbEqHBVMwtRrlhD5CfnYjvbnPGLOO4/tapc+/T4sk1p1cDzvFK7leMszz4HYKmEFTNyWjHsoygkc+Z9qS/JWR5Rd8XQFplusmGPNRkQOnRpIDqNiQcgAC4iDCCdTbGwCdDIXxdTAuU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7152.namprd04.prod.outlook.com (2603:10b6:a03:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 08:34:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Tue, 9 Feb 2021
 08:34:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Topic: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Index: 2tBd7/Jehsbeb/mKAfYcWAj9LaDboo1AHpmAAAfEwIAACUSQgAABsJQAABQ08IAABlDHgAAA+4iAAAGR72k=
Date:   Tue, 9 Feb 2021 08:34:58 +0000
Message-ID: <65F086AF-DDD7-46B7-9134-3E6B577E75A6@wdc.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>,<20210209075001.GA94287@T590>
In-Reply-To: <20210209075001.GA94287@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:7827:2b95:9ccb:6c22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21e770e0-dbd9-4e0b-8a13-08d8ccd595f4
x-ms-traffictypediagnostic: SJ0PR04MB7152:
x-microsoft-antispam-prvs: <SJ0PR04MB7152FA2943777839AFFE2898868E9@SJ0PR04MB7152.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ua32D9WoEERyZVWQk7jMfubMhYRB5mq0c5xXaqSEpYPQYNkFxqOYZ2pyPrA+8BJMmwjR62D//mXzyPaT5yWgcaX7YEUwDUbzV7EXDH+u/FJrvDcqEPhXef57y3MCM0q0J+ggSRVsFUnkUqiKOJkdtWhR/WMxWmNKlBWFAW90Ass0toCD8vFZNV9A0RXuhT4UVi4DZ+jBoCGwGekTuBLAxAILyf9JmV0g9BYZi6hTlEHmQJS6xtGHK6VF0fugSmYQ+yMWVm0oJ+E0s+ZJiUyVDGDlUsKoX0Rr3RfO0Dj7cKbH5WAz0DjTseszmu5DyfBS4c8AvIX4YocarntSuQZptv6dEm0bgzf07zYYkl9mwgmbT1JhQz+9k3MlyOEQKCYKIuMt1x5lHInUjUst1wTC8O4iNmmPTiTBHPtWutfL0NMORQAgH+fBsZifJNZqeT8xTAQ+mAMe9qkab770fL7d4W3PmdBTnxMYZKV5izOdKk/K5ZwQwdcxLbQigVzH+docBxIdERem3aA0iVYl3xcKpa6ew4YpAnvBMb0dPNvbgtnDnP5QMuCddZ8YFsNUQY2zz3Vijuk638KdV6NrGGbUmAZmXeHErr8M94UoozK3vJ2TYb6KvbUNuOy2VOKi96xT8290nzdtpcFi+F3nla/XJdOzkZagvLJutGX7aVNqCgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(6506007)(33656002)(66476007)(966005)(186003)(76116006)(54906003)(36756003)(316002)(5660300002)(2616005)(8676002)(6512007)(6486002)(86362001)(53546011)(83380400001)(71200400001)(4326008)(66946007)(6916009)(66556008)(66446008)(64756008)(478600001)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VWl0K1E4WmVXanFJMjhWYVJMbkh5NDZURndmUGhjNmJPZmNLVTE2b0c5RzdB?=
 =?utf-8?B?TWxjSUFFZkJLdW5rZXZxTGNwSHA3MzMvY2F0VGhCQTBJOVNRZXh4aHJxb2lr?=
 =?utf-8?B?dWZMS3NjbHU1WlBkd1RxWk5PQjRQT2d4TFBEUFpnZXVadjUzZnQ2ZEgxSm56?=
 =?utf-8?B?c01WV2RsQlF3bjJIV2VITjg4S1Y3RTQ4VGdqRm13cm1HRDV4OUprQS9TSVhL?=
 =?utf-8?B?UE5LYURXeVBLSWh6RXIwajVMUVl5a01RVnd2Y0lISE9paGdialE2ZHVSK2VT?=
 =?utf-8?B?Q3RQaHpzRk9CbFJ1Z1NUa3lWZktxUjRLNGF2bDdUYjFKa1NJcXJpbXdZaTFu?=
 =?utf-8?B?T2UxWk5ZalRjaE53azA0OFc5di9vWDhEeXJob1dhMG1vT09PSjQ4NDdtdHdi?=
 =?utf-8?B?Rk5XZ1F3UUFpaCtzNjc2WXk1UDNVOHl3cjhLZVQ2cmpodExTOGt5NFowS29D?=
 =?utf-8?B?WHJDRk43YldwQzhoeFNOYVkvdmZjQ2NBTUVDeUJMNFU0ODVVTlZIdCtUenUr?=
 =?utf-8?B?RXE1SENrUXkreTNFZk9zZ0hnS200MU1NNkhGZ25aYy8wVWtLc0drMFJDazFO?=
 =?utf-8?B?RDhadjZIRGR3YlBkWG9uQThwbW9xOHdwWGsxZ2pvckJTeTh3Q1lHdHlnVmEz?=
 =?utf-8?B?RjRhYlo5TmhNT2xzL1o3L05hSjBPWWtxWEVHWWlOOXNrcEs4ZWxmbEh2SGhU?=
 =?utf-8?B?WCt4ZzNreGFPS2o2SVNMU0hBSm5SbWR4SUlOaEdma0NkTzN4cnBZVTc5REtN?=
 =?utf-8?B?THdxeVY1VlBCbUpERUQ0b2lDL0lNcnNHakl2eURiQ2VxRkI5bW1hZnNEeU5B?=
 =?utf-8?B?WW9NQWp1YlVlSFRwa3paRjlsb3FGYSs2YTR2WWUxMlBMc3VNb1BzQmtCc0xR?=
 =?utf-8?B?VUg4R3FCYzJvcll2Sys0cmlCdmpDdmUwNGNDK3VvTEFVK0VGZ0lnUE5UZW5S?=
 =?utf-8?B?WWRsenV6bFBldUtWRzJzKzhZVXUxcFh1cVNJOW0wam9qcnh5RnBHcWVyK1lj?=
 =?utf-8?B?bS9BZlRlWVhKSjNkT1FUSVNaOW5pVG1udjdQMVhMQkVSWTBBaG9PU0lMNjQr?=
 =?utf-8?B?QldSTzZFUklzSkVoRVBZWnEyOG1RdlhzT29IWldQb0lkL1VycExNbFZjV29H?=
 =?utf-8?B?cEFPL2lnbXZ5QVUvaXlpR3puOEdDWnk4ZlVKRU9DeE1ORFh6cjlqK043VVd3?=
 =?utf-8?B?bEl6UWZjZnVzY2xxQ2htakdhbXhMd3AvTStKNGEvQXl0SktDVWlwbmxCbk1K?=
 =?utf-8?B?a1NoRkZ0ZlMrOTZyYmlYRkxvQmd2OTFxYTRxYzBocUxJS1EwbU9xdFlXQXRD?=
 =?utf-8?B?WFF0WU8vWVcyZm8rMnFONXY5MWJORkJCUkdGWWpJbWZaRXl2OE15Tlh1eitT?=
 =?utf-8?B?aTZITTVma0RUc2hvdDladXBQMzJZTVpHc2FtR3ovcm82ckRodWhMVEdlNG45?=
 =?utf-8?B?S1JWRDYvcHNlNm1aTU1RNDBNejBlbWg1OVlKekh0Z1c3bHdxai9PR1ZTakpP?=
 =?utf-8?B?SEFEVDg5cmJBdUQzT2xrWU5pUHlXMDhQa1ZoSllpUERMb2hwa3BOVDUrZUph?=
 =?utf-8?B?Tm9FUFlHcEN3MEZsMW9wWktKTjdzL2Rpc0N4WlFzYi9Hd2I1aVpNbWpzRWhH?=
 =?utf-8?B?UWQxcEp6bjNCQVNaZjl6eVorZ1Ewc05XUHo2dk9ZZHZmQWRISUszVzVsMS95?=
 =?utf-8?B?c1ZiMDNKWGNiRXlGN2JFMy9PUFFUaUx4YlpvVUJtVEVxRGxVN09jTmRibExq?=
 =?utf-8?B?cHp4cUdZUlJXL0NpV1puNnVtV1c3eVR4ajdYbVF2WjMwNStnSUhXeERoMVB5?=
 =?utf-8?B?bE5yMFF3QVFFZmo5T2FJVThWVytsdHZCcW56VEFsUFVnM1lTUlV2UUE0NGda?=
 =?utf-8?Q?VRz6vIQXB/VtA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e770e0-dbd9-4e0b-8a13-08d8ccd595f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 08:34:58.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC2s6RFYeZ3/p5t2/8qBPB8y/YlPCKaNa5T7ro0KiD2Vx+KdLLdHWrg+ZjB77eaVJIJmCEtfoX+zS0p5yCXKkWbqlVAa3pZTZ2LAgIy/dmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7152
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+IE9uIEZlYiA4LCAyMDIxLCBhdCAxMTo1MCBQTSwgTWluZyBMZWkgPG1pbmcubGVpQHJlZGhh
dC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMTE6MjE6NTNQ
TSAtMDgwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMi84LzIxIDg6
MjEgUE0sIE1pbmcgTGVpIHdyb3RlOg0KPj4+IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDEwOjQy
OjI4QU0gLTA4MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4+IA0KPj4+Pj4+IEhpIFNhZ2kN
Cj4+Pj4+PiANCj4+Pj4+PiBPbiAyLzgvMjEgNTo0NiBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToN
Cj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBIZWxsbw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBXZSBmb3VuZCB0
aGlzIGtlcm5lbCBOVUxMIHBvaW50ZXIgaXNzdWUgd2l0aCBsYXRlc3QNCj4+Pj4+Pj4+IGxpbnV4
LWJsb2NrL2Zvci1uZXh0IGFuZCBpdCdzIDEwMCUgcmVwcm9kdWNlZCwgbGV0IG1lIGtub3cNCj4+
Pj4+Pj4+IGlmIHlvdSBuZWVkIG1vcmUgaW5mby90ZXN0aW5nLCB0aGFua3MNCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gS2VybmVsIHJlcG86DQo+Pj4+Pj4+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9heGJvZS9saW51eC1ibG9jay5naXQNCj4+Pj4+Pj4+IENv
bW1pdDogMTFmOGI2ZmQwZGI5IC0gTWVyZ2UgYnJhbmNoICdmb3ItNS4xMi9pb191cmluZycgaW50
byBmb3ItbmV4dA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBSZXByb2R1Y2VyOiBibGt0ZXN0cyBudm1l
LXRjcC8wMTINCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIE1pbmcsIEkn
dmUgdHJpZWQgdG8gcmVwcm9kdWNlIHRoaXMgb24gbXkgVk0NCj4+Pj4+Pj4gYnV0IGRpZCBub3Qg
c3VjY2VlZC4gR2l2ZW4gdGhhdCB5b3UgaGF2ZSBpdCAxMDAlIHJlcHJvZHVjaWJsZSwNCj4+Pj4+
Pj4gY2FuIHlvdSB0cnkgdG8gcmV2ZXJ0IGNvbW1pdDoNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IDBkYzll
ZGFmODBlYSBudm1lLXRjcDogcGFzcyBtdWx0aXBhZ2UgYnZlYyB0byByZXF1ZXN0IGlvdl9pdGVy
DQo+Pj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IFJldmVydCB0aGlzIGNvbW1pdCBmaXhlZCB0aGUg
aXNzdWUgYW5kIEkndmUgYXR0YWNoZWQgdGhlIGNvbmZpZy4gOikNCj4+Pj4+IA0KPj4+Pj4gR29v
ZCB0byBrbm93LA0KPj4+Pj4gDQo+Pj4+PiBJIHNlZSBzb21lIGRpZmZlcmVuY2VzIHRoYXQgSSBz
aG91bGQgcHJvYmFibHkgY2hhbmdlIHRvIGhpdCB0aGlzOg0KPj4+Pj4gLS0gDQo+Pj4+PiBAQCAt
MjU0LDE0ICsyNTYsMTUgQEAgQ09ORklHX1BFUkZfRVZFTlRTPXkNCj4+Pj4+ICAgIyBlbmQgb2Yg
S2VybmVsIFBlcmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMNCj4+Pj4+IA0KPj4+Pj4gICBD
T05GSUdfVk1fRVZFTlRfQ09VTlRFUlM9eQ0KPj4+Pj4gK0NPTkZJR19TTFVCX0RFQlVHPXkNCj4+
Pj4+ICAgIyBDT05GSUdfQ09NUEFUX0JSSyBpcyBub3Qgc2V0DQo+Pj4+PiAtQ09ORklHX1NMQUI9
eQ0KPj4+Pj4gLSMgQ09ORklHX1NMVUIgaXMgbm90IHNldA0KPj4+Pj4gLSMgQ09ORklHX1NMT0Ig
aXMgbm90IHNldA0KPj4+Pj4gLUNPTkZJR19TTEFCX01FUkdFX0RFRkFVTFQ9eQ0KPj4+Pj4gLSMg
Q09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9NIGlzIG5vdCBzZXQNCj4+Pj4+ICsjIENPTkZJR19T
TEFCIGlzIG5vdCBzZXQNCj4+Pj4+ICtDT05GSUdfU0xVQj15DQo+Pj4+PiArIyBDT05GSUdfU0xB
Ql9NRVJHRV9ERUZBVUxUIGlzIG5vdCBzZXQNCj4+Pj4+ICtDT05GSUdfU0xBQl9GUkVFTElTVF9S
QU5ET009eQ0KPj4+Pj4gICAjIENPTkZJR19TTEFCX0ZSRUVMSVNUX0hBUkRFTkVEIGlzIG5vdCBz
ZXQNCj4+Pj4+IC0jIENPTkZJR19TSFVGRkxFX1BBR0VfQUxMT0NBVE9SIGlzIG5vdCBzZXQNCj4+
Pj4+ICtDT05GSUdfU0hVRkZMRV9QQUdFX0FMTE9DQVRPUj15DQo+Pj4+PiArQ09ORklHX1NMVUJf
Q1BVX1BBUlRJQUw9eQ0KPj4+Pj4gICBDT05GSUdfU1lTVEVNX0RBVEFfVkVSSUZJQ0FUSU9OPXkN
Cj4+Pj4+ICAgQ09ORklHX1BST0ZJTElORz15DQo+Pj4+PiAgIENPTkZJR19UUkFDRVBPSU5UUz15
DQo+Pj4+PiBAQCAtMjk5LDcgKzMwMiw4IEBAIENPTkZJR19IQVZFX0lOVEVMX1RYVD15DQo+Pj4+
PiAgIENPTkZJR19YODZfNjRfU01QPXkNCj4+Pj4+ICAgQ09ORklHX0FSQ0hfU1VQUE9SVFNfVVBS
T0JFUz15DQo+Pj4+PiAgIENPTkZJR19GSVhfRUFSTFlDT05fTUVNPXkNCj4+Pj4+IC1DT05GSUdf
UEdUQUJMRV9MRVZFTFM9NA0KPj4+Pj4gK0NPTkZJR19EWU5BTUlDX1BIWVNJQ0FMX01BU0s9eQ0K
Pj4+Pj4gK0NPTkZJR19QR1RBQkxFX0xFVkVMUz01DQo+Pj4+PiAgIENPTkZJR19DQ19IQVNfU0FO
RV9TVEFDS1BST1RFQ1RPUj15DQo+Pj4+PiAtLSANCj4+Pj4+IA0KPj4+Pj4gUHJvYmFibHkgQ09O
RklHX1NMVUIgYW5kIENPTkZJR19TTFVCX0RFQlVHIHNob3VsZCBiZSB1c2VkLg0KPj4+PiANCj4+
Pj4gVXNlZCB5b3VyIHByb2ZpbGUgYW5kIHRoaXMgc3RpbGwgZG9lcyBub3QgaGFwcGVuIDooDQo+
Pj4gDQo+Pj4gT25lIG9idmlvdXMgZXJyb3IgaXMgdGhhdCBucl9zZWdtZW50cyBpcyBjb21wdXRl
ZCB3cm9uZy4NCj4+PiANCj4+PiBZaSwgY2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBwYXRjaD8N
Cj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJz
L252bWUvaG9zdC90Y3AuYw0KPj4+IGluZGV4IDg4MWQyOGViMTVlOS4uYTM5M2Q5OWI3NGUxIDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+Pj4gKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvdGNwLmMNCj4+PiBAQCAtMjM5LDkgKzIzOSwxNCBAQCBzdGF0aWMgdm9pZCBu
dm1lX3RjcF9pbml0X2l0ZXIoc3RydWN0IG52bWVfdGNwX3JlcXVlc3QgKnJlcSwNCj4+PiAgICAg
ICAgICBvZmZzZXQgPSAwOw0KPj4+ICAgICAgfSBlbHNlIHsNCj4+PiAgICAgICAgICBzdHJ1Y3Qg
YmlvICpiaW8gPSByZXEtPmN1cnJfYmlvOw0KPj4+ICsgICAgICAgIHN0cnVjdCBiaW9fdmVjIGJ2
Ow0KPj4+ICsgICAgICAgIHN0cnVjdCBidmVjX2l0ZXIgaXRlcjsNCj4+PiArDQo+Pj4gKyAgICAg
ICAgbnNlZ3MgPSAwOw0KPj4+ICsgICAgICAgIGJpb19mb3JfZWFjaF9idmVjKGJ2LCBiaW8sIGl0
ZXIpDQo+Pj4gKyAgICAgICAgICAgIG5zZWdzKys7DQo+Pj4gICAgICAgICAgdmVjID0gX19idmVj
X2l0ZXJfYnZlYyhiaW8tPmJpX2lvX3ZlYywgYmlvLT5iaV9pdGVyKTsNCj4+PiAtICAgICAgICBu
c2VncyA9IGJpb19zZWdtZW50cyhiaW8pOw0KPj4gDQo+PiBUaGlzIHdhcyBleGFjdGx5IHRoZSBw
YXRjaCB0aGF0IGNhdXNlZCB0aGUgaXNzdWUuDQo+IA0KPiBXaGF0IHdhcyB0aGUgaXNzdWUgeW91
IGFyZSB0YWxraW5nIGFib3V0PyBBbnkgbGluayBvciBjb21taXQgaGFzaD8NCj4gDQo+IG52bWUt
dGNwIGJ1aWxkcyBpb3ZfaXRlcihCVkVDKSBmcm9tIF9fYnZlY19pdGVyX2J2ZWMoKSwgdGhlIHNl
Z21lbnQNCj4gbnVtYmVyIGhhcyB0byBiZSB0aGUgYWN0dWFsIGJ2ZWMgbnVtYmVyLiBCdXQgYmlv
X3NlZ21lbnQoKSBqdXN0IHJldHVybnMNCj4gbnVtYmVyIG9mIHRoZSBzaW5nbGUtcGFnZSBzZWdt
ZW50LCB3aGljaCBpcyB3cm9uZyBmb3IgaW92X2l0ZXIuDQo+IA0KPiBQbGVhc2Ugc2VlIHRoZSBz
YW1lIHVzYWdlIGluIGxvX3J3X2FpbygpLg0KPiANClRoYXQgd2hhdCBJIGhhdmUgc3VnZ2VzdGVk
IGJ1dCBJJ3ZlIGFsc28gc3VnZ2VzdGVkIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBwYXJ0IHdoaWNo
IFNhZ2kgZXhwbGFpbmVkIHdoeSBpdCBpcyBiZXR0ZXIgdG8gYXZvaWQuIA0KDQpJbiBteSBvcGlu
aW9uIHdlIHNob3VsZCBhdCBsZWFzdCB0cnkgYnZlYyBjYWxjdWxhdGlvbiBpbiBsb19haW9fcnco
KSBhbmQgc2VlIHRoZSBwcm9ibGVtIGNhbiBiZSBmaXhlZCBvciBub3QsIHVubGVzcyByZXZlcnRp
bmcgdGhlIGNvbW1pdCBpdCByaWdodCBhcHByb2FjaCBmb3Igc29tZSByZWFzb24uIA0KPiAtLSAN
Cj4gTWluZw0KPiANCg==
