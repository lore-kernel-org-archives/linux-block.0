Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A09C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9D96139A
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhESHoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:44:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14866 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbhESHoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621410173; x=1652946173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bVZpfdD3XkY2gKUC0Jhp3aY2cuNsepM0I40RRSugfDQ=;
  b=rjA1eSi/rBi5E4VnNPoJPTfgEEIa8MEwN3L/CxEk265ppneWWjuV8NjM
   Nl+MhcGVX7646sXNlo4cgrNN20FKpZgRM1YU2PbNE1PMb+1tlt5QQulDX
   lVC9R9XV+hq+crMz3iTBCzL9HNtZYV+4FLbknS8JA9rr4352jzFMi8vBj
   kE1jrXIYht4B5WiTjJ86lflqMhK2fSnY2KzGSg5FNc2cFEyZg7F0Hu5Ma
   bU9PKwr6pDZMeiIKE8Q0i/eUXE+9jeUSFbnoIlBTHnM7j01DZLT9RuZ+t
   6FMwmosbhCiwuIDnwhh0JRcq9n6LNIH9K41c/iS8A6RuolPjhmHGgfwmT
   g==;
IronPort-SDR: eZ0QUX+NfQADNdlxQq1aEFK66GbCnU2ZG3i/M2yDlGSVjjtpATb/bmcDZhwwp92xf3BPFK3D/q
 AAVL8cC35YS3nfhgyhUaAfp8lqbQIz07PxB9wpR6pMeNBTqTBTAnDOrlRfYKeuCunUSiEr4Upd
 ik2WMhjnAv8KGiIQ2Pf8de8rhYgZiFGd9Bv/y/zEo6GbcxP+JiPCa+A1VQ5UW5B+V5i+ozQy4t
 FFW1QeAbibXVn7T4Y6atCMWaGPbl2b0PDz8mQgsUnB10fNi506sK6MAeAK9DDPfvuwN5LgrgAd
 y8o=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="169222019"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:42:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/QZ1C7YvSWznNze3zad7V1d6XCCmom/e/Kfb17kixRBtCmVR0thJdAtc0BhgDtr70mLXMRJh3Bs/j8QQRpFKYu52kXU5XOkjOlpLx7L6wT68kqegSTyMTlnDyjLBlMNAueNtspXphrRden563uKQzdDFvkOAI1PtlyMWGirXK1SM2tdXFxl1Sr5EbCzGjqblLYIw8LapZOgY7yoss8Bk8ZU//MB2PQidB39ZTlqnJWCiT+kXBc0jyWaiThPuuNjVKnwoGhO27UVLcx48/5fauH2H+HRE+mf2vVlJbt5kMztqiJhIdOYuXkjraKeWSLLeH7C7vH3/IKKaMfV0k8Btw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVZpfdD3XkY2gKUC0Jhp3aY2cuNsepM0I40RRSugfDQ=;
 b=DePnVnL6iMPfDgDdPuhF/TDaC02C1caLj+FTYoCFKnJSmpNIIx++LW6QOXBFIgDILfRiTLRE4YxBQvDGMCqJsuIovYziOAhdUsDanj//vFImq3lGR7ylos4QxxjgaV/roIgALGm53ar3XJROJaI7fsvDRe1JH42rSdeFIlkz1tDUk4gI6kaAViv3tKsunmwqjeA2iGUm4MuKRTU218I/xqDcbHOhQ/cDLcxRwTnFUQfegdtOy3YB5RyY9fIxpyv4Csq1zpA5pWjNKt+hogNNgYCcw6yreL3E1duM6jCdDgL5DgZntv2Hm0QROlJ3P3EWB13+QLL29gISI5abnHPPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVZpfdD3XkY2gKUC0Jhp3aY2cuNsepM0I40RRSugfDQ=;
 b=Mrw8gH06S+j2tuGRi/AjHWZKojmmVciNcZgE85QXxcBk8FGsJ9weAZ6kwysOvmddj/mR57M+tjXRDd9idhRBS8Zd+mGgi9TxrPfQbKVpyZoqMOZdJaqHwoOe/gTHsxpDdy7KFKF6R/UIea3H9KJNb5jGhCiYxGQ/zlkCtHwJ4xY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6642.namprd04.prod.outlook.com (2603:10b6:a03:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:42:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:42:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] block: introduce bio zone helpers
Thread-Topic: [PATCH 02/11] block: introduce bio zone helpers
Thread-Index: AQHXTFqE8cYwB7GqvU6hvEwRDzkvt6rqbG6S
Date:   Wed, 19 May 2021 07:42:50 +0000
Message-ID: <65441A15-23E1-4C5B-A145-8C1EA9ECB251@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-3-damien.lemoal@wdc.com>,<PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 020cdd61-2d9b-4132-c1d0-08d91a99b484
x-ms-traffictypediagnostic: BY5PR04MB6642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB66420BA6271DB78DF9A5324A862B9@BY5PR04MB6642.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jkQCMzQXmD0dmWvqFxA0X9dw58Qs/Eu3h0+OLLuxVlLliVXkaBHSIi3WF6R/m4DNGWvZiOAoOyudK+Nqq+9AS++EeT1TW0HlB4gbvty4R1FOJ/FRgqUM//SrtULv4j9nM5I2AtzBk3L7WOXBtWlVhNSdSr0i9v8k3dSC7/1VREGxwc57qaAXN3lYF+d489Mu+dls8jlCFpa+7i+Kb20ee+o8Ux80aP0h28wuUOT/QqIielC+jKBw2exyAFN8edPnePXqPWHOOOjOeTFwP7ogCu29/E4l3u4uu7Juh30aOkQ9ZXOPha7mNSTcpZ2nyBFSggulE8Hin+O9StInd9+t2YJM11nG+8RUWJAZOPPQXBtuhlKaw2wXzih6b1yhnAiuMHSOLJPyfoFGEdDdQp3SxoBy72bezEIptLufSBZIw4UF/XxCI/Y4qTQnObntdzVLaIf5K3LBIcAqV/zd+vMXYs4W4NYQN2XFhlirEhi5nUWH1kVedH/hWNFsQvzd84SxkiOB7heen8hPT2Ec6NEIL5h25o2UiBTlIYXTzdmp1qmtqanjaNbYgcsqc12TASpAgbEXTBl3igjAI9a1SQP9Fy76fqIZRI9N6QJO+mfa9thL6Pl1sJyP0NBZVAXwoaKSxBB4OSa/iJUMtZ0BRDElc8ZjzuThhsgrrtWRibbRSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(2906002)(37006003)(316002)(38100700002)(86362001)(6512007)(54906003)(36756003)(6862004)(4326008)(2616005)(26005)(53546011)(6506007)(83380400001)(5660300002)(186003)(33656002)(66946007)(6636002)(66556008)(64756008)(66476007)(66446008)(71200400001)(8676002)(6486002)(8936002)(4744005)(478600001)(122000001)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RllJSkwvQXB3d1F2TUZ4R0drTWNTQit2ZDVPOTI0WVJjZ1NsOGFmdk9tVG0r?=
 =?utf-8?B?WXQ2bHh1N0ZmUDcyY0J5ZGRkdHJvWXJzbEMreUR5UEcwaGhUQ2ZoMFlrc3dW?=
 =?utf-8?B?UHpLWlMxK3RVQTdlL3VsSnU4R01XTklKVEtWa1BTWTYyM0w2Z2ZwMFJWZ1NB?=
 =?utf-8?B?QXlNQ0V2RGtaand0SnpESUZETytHay85K0pHS2ZoYzNJMXdJdUs0UllKWUNr?=
 =?utf-8?B?b3ZsMHVGRGtQckhTNTlnREE1ZzdWUDlOSjBMTkJpWUlMTW94b3BFZ2xJT0ZH?=
 =?utf-8?B?a1d6MWVyS3RWd2hxRnV5cERib0JhalpjRElSREJaWTIza3V4aExyK3lMdTlt?=
 =?utf-8?B?NVBiekp1WUJwNzFnWGwrVVlUbU1JcmtlMFh4dHVzZkJBWVJscGtsMnpwUm5T?=
 =?utf-8?B?UkVrVDZzWGZCOTV4aEh0Q0QvVWMxaWMxbDBncVNSMHd4SWJ4TWEzSzhndncz?=
 =?utf-8?B?OEJIOG1jVGxMMnhXaFFtUFJRVE1nVGtVdTk0UTEwSFhyb1ozWjhxajdCcVRX?=
 =?utf-8?B?Nkl2bGEzaUhKTUw0Mkx4N21yckcrVElJdUYzd21pcnFOZDhwU1ZzSDhXeEg2?=
 =?utf-8?B?ZXlMbjNrTzA4Nks5WnlZb1RyZFlrQlFZcUVSSGJ2ajd2Mm1lQUV4bHNlbFV3?=
 =?utf-8?B?dVdValB1a1paU3RRbGU2M3dmbE0yeW94a3FTNjN3ZHRmejNuSnB4RkQ0Wko1?=
 =?utf-8?B?SFN6K1RiSGVOaFpJRzZFNWJNMExRa1htQzFEd2xaL1JHRVdOQnNBYW8xbzJ1?=
 =?utf-8?B?UHJCcGhZLzJWdlozSEdqaWJKMFVoc0pXeDZHaSt1bTFtQmZOVmpJS1NwcHpu?=
 =?utf-8?B?bm5Xd3VvUnJMUkFra3d0b0VScENpZk1vdHVtWjNPYmxnWEFFVXhSYytsUEh5?=
 =?utf-8?B?YVRUeklZS2VyMmZuNGVyQXV2YkkreEM5ZFdpM29hRDhVVVRSZ09ucWt4MHZp?=
 =?utf-8?B?aGZCVWNzdW9qM2h6UEE2TzBGejNBVkFjdlZWaVFNeitic3lEZjlDb2VjTWU4?=
 =?utf-8?B?VnBOTTFSZExOUWhUb2d5c0V3UWhQQnJWbGFReEV4ekRFMzl3YTEyOFM4bEFv?=
 =?utf-8?B?WkVZVHB0bU9CY3lwOW4zSlJ5UGtGaDVjNXZabklJekJnV2dNVEpvZmo2aXhw?=
 =?utf-8?B?QjNNdTFkK3B5ZWRRZ0dBNVlkcDlyNno2MWhEVFgzbXNvVVF1OGd6d3JQakVS?=
 =?utf-8?B?OG9VRzVXUzQ2YlpUcGYwekJvS20rajVyQnZUV0xiZVpHZXMzazZ0b1ExK1BR?=
 =?utf-8?B?dUtQL0YyWTd3Sy83SDBLRnZqRDFFVzRCNXI2SU1xclBKclNLQW9KUmQzU3N2?=
 =?utf-8?B?NXZHTlZQaDFVVE9pMGV3UHNkdmNZcDBtaFhTeUtlTVFMM21JVHByTm1mbVR0?=
 =?utf-8?B?SXl2aERpWDR2THJKbmw3U1BuUnZTbEV3L0txSWhmcnYzelZmQVR1Ulh2UXd0?=
 =?utf-8?B?cWpmTGRzU0VSQUYvbHBDaGFQQ1JLb1ZEWFJTbWY3SzlDUTRtdlNjelJ1Y1Vo?=
 =?utf-8?B?Uml1cFovZm1HZHN0di9ndzNRdDZXNVVFaHg1RHVQS1owTWZlM3BiUnp2dFVQ?=
 =?utf-8?B?RWlFcDdGWHBDbjRLUVowZDRXbXJUMXNnK0hjV2t2VlFXQmlxMWNvNGVMbkR3?=
 =?utf-8?B?cEJqeHdZUzV4eTQ4Y0JnMXJ6c3dHaUxGaExyZ2M4VUFkZ0JQWGFER2JZbFM5?=
 =?utf-8?B?OEdrZlVoVGkvaDBCd21EelRoRmVicGs3SnVCY0NpcTlZdm9xR1dwMXIzdFhE?=
 =?utf-8?Q?KLKH3rIzScWgLRPHZDVnndF0puIEplexEx4egTK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020cdd61-2d9b-4132-c1d0-08d91a99b484
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:42:50.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKJEXKQ+t8nqqZwU6+Uk8FZlSw2LWe3w+k/HdgEJHox+Wyeuuol7SYcRxYA7XpGtqLtGvqfctpKLY9zYiU/flldcG/wqbPAd04omQ+SLTNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6642
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBPbiBNYXkgMTksIDIwMjEsIGF0IDEyOjE3IEFN
LCBKb2hhbm5lcyBUaHVtc2hpcm4gPEpvaGFubmVzLlRodW1zaGlybkB3ZGMuY29tPiB3cm90ZToN
Cj4gDQo+IO+7v09uIDE5LzA1LzIwMjEgMDQ6NTYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4g
K3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGJpb196b25lX25vKHN0cnVjdCByZXF1ZXN0X3F1
ZXVlICpxLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJpbyAqYmlvKQ0KPj4g
K3sNCj4+ICsgICAgcmV0dXJuIGJsa19xdWV1ZV96b25lX25vKHEsIGJpby0+YmlfaXRlci5iaV9z
ZWN0b3IpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBiaW9f
em9uZV9pc19zZXEoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgYmlvICpiaW8pDQo+PiArew0KPj4gKyAgICByZXR1cm4gYmxrX3F1ZXVl
X3pvbmVfaXNfc2VxKHEsIGJpby0+YmlfaXRlci5iaV9zZWN0b3IpOw0KPj4gK30NCj4+ICsNCj4g
DQo+IENhbid0IHdlIGRlcml2ZSB0aGUgcXVldWUgZnJvbSB0aGUgYmlvIHZpYSBiaW8tPmJpX2Jk
ZXYtPmJkX2Rpc2stPnF1ZXVlDQo+IG9yIHdvdWxkIHRoaXMgYmUgdG9vIG11Y2ggcG9pbnRlciBj
aGFzaW5nIGZvciBhIHNtYWxsIGhlbHBlciBsaWtlIHRoaXM/DQoNCldlIGhhdmUgbWFkZSBzdWNo
IGNvZGUgY2hhbmdlcyB0byBnZXQgcmlkIG9mIHNlcGFyYXRlIGFyZ3VtZW50IHEgYW5kIGRlcml2
ZSBpdCBmcm9tIGJpbyBmb3IgYmxvY2sgdHJhY2UgY2xlYW51cC4gVW5sZXNzIHRoZXJlIGlzIGEg
c3Ryb25nIHJlYXNvbiAoc3VjaCBhcyBxIGlzIG5vdCBhdmFpbGFibGUgaW4gdGhpcyBjYWxsIHdo
aWNoIEkgaGF2ZSBub3QgbG9va2VkIGludG8pLCB3ZSBzaG91bGQgYXZvaWQgcGFzc2luZyBxIGFz
IHNlcGFyYXRlIGFyZ3VtZW50LiANCg0KDQo=
