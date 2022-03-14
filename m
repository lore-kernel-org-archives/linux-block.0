Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BEC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiCNORv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiCNORu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 10:17:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1519C12
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647267400; x=1678803400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gfMVESIIM3U8QF4DbL0A+w9u+yTVn3eCk07WCRglquo=;
  b=QXFd4eoGoWgaDKcw2aerAAvVqZItidcVVOgivoxUeSrvfmQ+I/J7mQW/
   uVToCdKN/ih7+l9GcWPZ4fGXc2Y/Wqf8hFdjSR1HGPG+ZfAIUODaJLJIf
   TGXsDNJJIW8DZcKvG0sPnt8eguMTHcN6HeGFVnV7j1GBRxjuwUOfs7yK8
   U3qfWA7c4/8a4FNX/yYfan05UvSzScd4ZO6BJYvJJhboNuy6N4lisT626
   ShRdRXfH5+5SzP1rKRQwV+rqGbLxGNXivbb2cLbYoiXFJPmZB4XlUzidB
   S+5vcJZ2tMhgm1r3ykU8SubD0Iy6wthEiqpYcE+g0oPoNs1g9GtAbFHix
   w==;
X-IronPort-AV: E=Sophos;i="5.90,181,1643644800"; 
   d="scan'208";a="307267390"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 22:16:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoZSJdpg+0Dnaxy/XFRcmQ61/kRuYJ8QznvmYUZ7UTMzJ4nCz+8yys2gSzx8UaWuGrv2hHYH/YtEJIXIcRKMLXW6uG+ymLzKx/FXurpCMc42P/cJWWqV0KIzGqS9nDevz1E++6QEAPcRPiUAJdA6UTIjgzXr1n/eWBFo9AJMgPINnta/+x1FPWL7J09rWFTr+MFwO50NuuEjva9hlnroaDt3vrF7eqpRKYukyjYYlUfB9/g+DZEvy+wrjVXhLQgQBL0wlrj6+0wT2SfMlwRae16iuf/cNOu+5U2Gl8NxtmDy4EeqL3L0vnZhXpQ8gZ6mJgcDLcV7ZLkPIQ46nwV6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfMVESIIM3U8QF4DbL0A+w9u+yTVn3eCk07WCRglquo=;
 b=hA1ogBxPaG/YR05YjAhrqiH+3ZuAbJeZbmR0eX/U499ZGkKLY1nFYfWl+WysBvKmZ7DcRUKnbfnIplPxDF84JyIfZG5T+CXenYYCmUvnSYE5X3CXLKLX5vajKaP0zRWYS/EsyLRMnTo1YxjvTVcizIgUbMTZ9ocQZIOz9ZQv418JATsID5XOJ9rdmVGwXmfOD+nUlju3NFsfbo455Z2tLRF61iOYObs685GgY1gG3/DZEo3quBuP0nwUnx+CZYtp8oetppls8+/djwUt37UmWe2RhViIWZ/yurcxWp+rw/9i7g0KxG6lvN9WCoe4uu4imbyoBVxT5kuDr8+B1nfKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfMVESIIM3U8QF4DbL0A+w9u+yTVn3eCk07WCRglquo=;
 b=SZap+fP5bzo/H4cuJBgDBzQK95n2cTT2Ye2EfuEqblsvDV8smY4xrHjuQzY5S76HibEw5HVXZmDPFW0lB/X7iQTzwhpPzUuCBZ9PJecFDlynmnPjUeGmT6nVLBsyCFZf79+4gCfolP5t8GOt+/pX9uN7NGGo5PJbmmOOdgvonPc=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 14:16:36 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 14:16:36 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbg
Date:   Mon, 14 Mar 2022 14:16:36 +0000
Message-ID: <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
In-Reply-To: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab716fe7-8795-4066-d40f-08da05c53fc4
x-ms-traffictypediagnostic: CY4PR04MB0567:EE_
x-microsoft-antispam-prvs: <CY4PR04MB056762EA8B31D88154B9B4C7F10F9@CY4PR04MB0567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KybaDG3Du/sZaFbwuIvuT+INAc8qT/w1tlBaLD/L3ix0C6/WAd4Gej+Ji4/MUesBZdYdUvxQkLkC5YtDWn0lqcI9h/c7D6T4XCW0SLLXHpeGb1SsllXkmzW68gVlYof8Aof72yKWfn9E/sXL6FBW0OwWR/n8BduyMXHFRr2YiiwRG4n017rMJm6mfBKPkzaypBOxauMhQ6I9cSM8jUi6VBw3+yKE91ONRMxwLqM9SyDAQukVZ8rDl6gWyeKNaSD3tttDHpQ1989s8EjyVsmcH9Cu4RBxzz9oecmpGCf9UBwGvBJEsjqqsIFKLcQ9A1dbcMqP/wSRepAAXcygHTdPrmvmxVDlDFfMIk8oKG52xsEKTRrtBcHzN5T6+TqAJQpVCukVHXm3/e1TEyAoYtnTB6AuSyR9vPLR43lt5E0TVCZ5m8N8Umcumib0BHJJ8dzTR2SUZyfFNov/YT9JGcYjm6ROMdtFsigm8xlrpgITQmXhsKa0DZ3HF+7NScGUD29DkeualzoE7AEryRl0aOidh35VL8C4xC7jiXqOZJ6CKIor/1KxXNcXY1k8Vlu4D6Z9KFo7G+Xd+FSLiM0kYtZkqufXVblSCgv28badAIHx+sMqobcwSemG+/ydUoCDxn626UJx+cDTPiMJq5lOJLAFkTgz4UV1T+rDIA+aF7Om0FE2p/dEwTXFTBK3qSYcQjIMd086tJGx8WiZpOYObZGN/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(4326008)(8676002)(5660300002)(54906003)(83380400001)(33656002)(110136005)(316002)(8936002)(85202003)(52536014)(55016003)(86362001)(71200400001)(82960400001)(26005)(186003)(122000001)(38070700005)(508600001)(85182001)(9686003)(6506007)(7696005)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnI1THlCK2UxZEd5Zm12VU1USlYyb210d2ZRN1RSUFFrMmVyUDlBMEdoMW1o?=
 =?utf-8?B?UHV2U3NCc1llVzJyelNzbGRYMXROQlMwamZDOHhoNGNmeUhwbXc4WE9mOEhG?=
 =?utf-8?B?SlJSV2cyMnFENS9adW4zZmVaa2tYaG5IeTI3dHgxU3hrWGlMeUFBd3MvVnM2?=
 =?utf-8?B?Rk90aG9GeXRVWmJ6V0t3dWoxdXdLeldjb0V6WHZkQnFNbGN2SnFjTll6Tkxx?=
 =?utf-8?B?cEdkZUh2OUEyQnNCZlZLYnloWnhhT1hFek9GL1NjNE5QTllkSThwY1FNY2oy?=
 =?utf-8?B?RjZmZmovTG5TVlFjNllFa0RxTTFidDhCZmtIUFNyL3lOcTRqOXZraURrZ1JZ?=
 =?utf-8?B?bHdjeDhJaUZTc1RQL1gzckZEM2VvaHRTc1ZOeGZ0dS9DZzdjQVV1dVhXTzBE?=
 =?utf-8?B?ZktBV00yUFE5cGUybmo4dkg0aXlxSDBoeWpYQkI1b1A3L0hncmFsbzBPdTcw?=
 =?utf-8?B?cGM4ZzlHZW00dzd1VCt0SHNDUUp4ckxhc1pyNUUyYVZ2MDNBMnp5Sk43cWRI?=
 =?utf-8?B?VEdGdmdUSEthYU16eG82VzdSbkJxL2pWNGw5NFNmMDMvU1Nwa0o2Tk5Bb2wx?=
 =?utf-8?B?YWwrdk1sU0I5VDB4V2NBMXB5cnJjR2pvRXpYZ1d3WE91NHY5ekJxUXRPY25n?=
 =?utf-8?B?dFZ4OVRSWENBdFBzby8zWU9CRW00Wnpmd3NzbVJma1dEL0Jxb3FjZEJ4MWs0?=
 =?utf-8?B?N2tWSzlKMUlVZHN0TDVSZGRhaEFhd2lyd1ljRFNCVC9Vc2FSeUc4Ujd4bzJ4?=
 =?utf-8?B?R2ZpUkgyOGJuSklaQnQ2VHNFbHdsYXY3Nk93QXhaam0yRlIwWXU2djBxbkNY?=
 =?utf-8?B?ekNSb2VUU0gzMHNWOUMwTUhaQ0NETWJmaEtGanN4VkQ4RGJuc2tnd0JycHlY?=
 =?utf-8?B?N3hIdjlhWlZ6RzIrcmNCWjBic3YyWURSKzc5cHFydWRMcGVQUnBmWUIvM0Zx?=
 =?utf-8?B?V2lpZXBieXJUS1FuSFB5VWpCb3M0TkdiTXdTM3VTU3Voc2ZYV3ZWYVFoU24r?=
 =?utf-8?B?VmNxa3dQNlRBZXBpUmhJZENsWHFwWU1hakFrMDBhZnhYUHh4WjVXTlJlVElI?=
 =?utf-8?B?Z0R6L1hpUm5mTXVTS0ZjU29Qdm5uTVR0VTVZMHJxQ3BvQzlubStIcmJSZnFa?=
 =?utf-8?B?N0gzbjBsQTFxTGVaMUR2SzlRNmJtNm9DVGpuN1dWZWRYKytlaGpWcERxR2Nx?=
 =?utf-8?B?NllEbTl2MFFkLzRpRzByVi84WURidGJqSTFIcGk4ZzBob3Y3TFh1MjQ1UUJk?=
 =?utf-8?B?WHVJdTJHWDBYVHpiNHZsNGI5V1dUWC9qbmo5ci9uK2YwMmUzY25LMnRJTnJH?=
 =?utf-8?B?bkZVdVFoSDNSbm90UXVNOFpaLzlBYWJnTmJiVEUwenM0SU1YTjlMV3dOQUVt?=
 =?utf-8?B?UkZidWFCM0VpUU1mR2ovZGRYbFcybVZSUzJLT00yZ3V3TUN6M0ZML3ZGaHNK?=
 =?utf-8?B?QWtmdWx6SmREY0hQaHc3VjV4QlMxWUhGNkpNYThwenBybkwzdU9kQXFpZ1Jw?=
 =?utf-8?B?SmVod1hsY0pBbW1BZ2JiMnNrWmNKNktIRUxWME44SXRuRGdVWHZHNHJuNHVw?=
 =?utf-8?B?RlN2N29TRUpHY3Z4TlRRYU5ONTBkVTI3L1R5NDNrdTh0WHBPbmcyZTFCRnY4?=
 =?utf-8?B?dW5QWm1PdjhiUVIzQ21KUkpmbDg3YzNhcVdoWEZCWlUzOGFVa3lhZ1c3L3NW?=
 =?utf-8?B?cDVneUV2RHBXZDB0bk5hVUZZUFJVZ2NWNEc4ejAzMFdHc29PL29HWUsvMFBT?=
 =?utf-8?B?bGNwWDRNaU9veHU2QnE1YnEwdGZYRnhPMmF6V0Zoc2Y4aDlxM3I3T3pDK0NO?=
 =?utf-8?B?ME9Bc1E0VUZJZDhBYkFzRlpRNXhLcTRGbmVwaGdHZEVKc0tVWHNCbGJwRWov?=
 =?utf-8?B?Z01ySElZeVhIN0N3TFYwcTE3bm1oZGNySmVqR0V1QjNnRDd2bk91WUwwdml3?=
 =?utf-8?Q?QobxJJzFv0pvcR8Tz9eeuzKp2z5N2p6+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab716fe7-8795-4066-d40f-08da05c53fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 14:16:36.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoAhtS9uBFcIP3KqVQCYpOyCBh4iN4/jWaj5sHONb+mrkXzpxwHZbPxZG931EGBxBzuHsXuCzmNZ5jSAfh3MZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+PiBBZ3JlZWQuIFN1cHBvcnRpbmcgbm9uLXBvd2VyIG9mIHR3byBzaXplcyBpbiB0aGUgYmxv
Y2sgbGF5ZXIgaXMNCj4gPj4gZmFpcmx5IGVhc3kgYXMgc2hvd24gYnkgc29tZSBvZiB0aGUgcGF0
Y2hlcyBzZWVucyBpbiB0aGlzIHNlcmllcy4NCj4gPj4gU3VwcG9ydGluZyB0aGVtIHByb3Blcmx5
IGluIHRoZSB3aG9sZSBlY29zeXN0ZW0gaXMgbm90IHRyaXZpYWwgYW5kDQo+ID4+IHdpbGwgY3Jl
YXRlIGEgbG9uZy10ZXJtIGJ1cmRlbi4gIFdlIGNvdWxkIGRvIHRoYXQsIGJ1dCB3ZSdkIHJhdGhl
cg0KPiA+PiBoYXZlIGEgcmVhbGx5IGdvb2QgcmVhc29uIGZvciBpdCwgYW5kIHJpZ2h0IG5vdyBJ
IGRvbid0IHNlZSB0aGF0Lg0KPiANCj4gSSB0aGluayB0aGF0IEJvJ3MgdXNlLWNhc2UgaXMgYW4g
ZXhhbXBsZSBvZiBhIG1ham9yIHVwc3RyZWFtIExpbnV4IGhvc3QgdGhhdCBpcw0KPiBzdHJ1Z2ds
aW5nIHdpdGggdW5tbWFwcGVkIExCQXMuIENhbiB3ZSBmb2N1cyBvbiB0aGlzIHVzZS1jYXNlIGFu
ZCB0aGUgcGFydHMNCj4gdGhhdCB3ZSBhcmUgbWlzc2luZyB0byBzdXBwb3J0IEJ5dGVkYW5jZT8N
Cg0KQW55IGFwcGxpY2F0aW9uIHRoYXQgdXNlcyB6b25lZCBzdG9yYWdlIGRldmljZXMgd291bGQg
aGF2ZSB0byBtYW5hZ2UgdW5tYXBwZWQgTEJBcyBkdWUgdG8gdGhlIHBvdGVudGlhbCBvZiB6b25l
cyBiZWluZy9iZWNvbWluZyBvZmZsaW5lIChubyByZWFkcy93cml0ZXMgYWxsb3dlZCkuIEVsaW1p
bmF0aW5nIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gem9uZSBjYXAgYW5kIHpvbmUgc2l6ZSB3aWxs
IG5vdCByZW1vdmUgdGhpcyByZXF1aXJlbWVudCwgYW5kIGhvbGVzIHdpbGwgY29udGludWUgdG8g
ZXhpc3QuIEZ1cnRoZXJtb3JlLCB3cml0aW5nIHRvIExCQXMgYWNyb3NzIHpvbmVzIGlzIG5vdCBh
bGxvd2VkIGJ5IHRoZSBzcGVjaWZpY2F0aW9uIGFuZCBtdXN0IGFsc28gYmUgbWFuYWdlZC4NCg0K
R2l2ZW4gdGhlIGFib3ZlLCBhcHBsaWNhdGlvbnMgaGF2ZSB0byBiZSBjb25zY2lvdXMgb2Ygem9u
ZXMgaW4gZ2VuZXJhbCBhbmQgd29yayB3aXRoaW4gdGhlaXIgYm91bmRhcmllcy4gSSBkb24ndCB1
bmRlcnN0YW5kIGhvdyBhcHBsaWNhdGlvbnMgY2FuIHdvcmsgd2l0aG91dCBoYXZpbmcgcGVyLXpv
bmUga25vd2xlZGdlLiBBbiBhcHBsaWNhdGlvbiB3b3VsZCBoYXZlIHRvIGtub3cgYWJvdXQgem9u
ZXMgYW5kIHRoZWlyIHdyaXRlYWJsZSBjYXBhY2l0eS4gVG8gZGVjaWRlIHdoZXJlIGFuZCBob3cg
ZGF0YSBpcyB3cml0dGVuLCBhbiBhcHBsaWNhdGlvbiBtdXN0IG1hbmFnZSB3cml0aW5nIGFjcm9z
cyB6b25lcywgc3BlY2lmaWMgb2ZmbGluZSB6b25lcywgYW5kIChjdXJyZW50bHkpIGl0cyB3cml0
ZWFibGUgY2FwYWNpdHkuIEkuZS4sIGtub3dsZWRnZSBhYm91dCB6b25lcyBhbmQgaG9sZXMgaXMg
cmVxdWlyZWQgZm9yIHdyaXRpbmcgdG8gem9uZWQgZGV2aWNlcyBhbmQgaXNuJ3QgZWxpbWluYXRl
ZCBieSByZW1vdmluZyB0aGUgUE8yIHpvbmUgc2l6ZSByZXF1aXJlbWVudC4NCg0KRm9yIHllYXJz
LCB0aGUgUE8yIHJlcXVpcmVtZW50IGhhcyBiZWVuIGtub3duIGluIHRoZSBMaW51eCBjb21tdW5p
dHkgYW5kIGJ5IHRoZSBaTlMgU1NEIHZlbmRvcnMuIFNvbWUgU1NEIGltcGxlbWVudG9ycyBoYXZl
IGNob3NlbiBub3QgdG8gc3VwcG9ydCBQTzIgem9uZSBzaXplcywgd2hpY2ggaXMgYSBwZXJmZWN0
bHkgdmFsaWQgZGVjaXNpb24uIEJ1dCBpdHMgaW1wbGVtZW50b3JzIGtub3dpbmdseSBkaWQgdGhh
dCB3aGlsZSBrbm93aW5nIHRoYXQgdGhlIExpbnV4IGtlcm5lbCBkaWRuJ3Qgc3VwcG9ydCBpdC4g
DQoNCkkgd2FudCB0byB0dXJuIHRoZSBhcmd1bWVudCBhcm91bmQgdG8gc2VlIGl0IGZyb20gdGhl
IGtlcm5lbCBkZXZlbG9wZXIncyBwb2ludCBvZiB2aWV3LiBUaGV5IGhhdmUgY29tbXVuaWNhdGVk
IHRoZSBQTzIgcmVxdWlyZW1lbnQgY2xlYXJseSwgdGhlcmUncyBnb29kIHByZWNlZGVuY2Ugd29y
a2luZyB3aXRoIFBPMiB6b25lIHNpemVzLCBhbmQgYXQgbGFzdCwgaG9sZXMgY2FuJ3QgYmUgYXZv
aWRlZCBhbmQgYXJlIHBhcnQgb2YgdGhlIG92ZXJhbGwgZGVzaWduIG9mIHpvbmVkIHN0b3JhZ2Ug
ZGV2aWNlcy4gU28gd2h5IHNob3VsZCB0aGUga2VybmVsIGRldmVsb3BlcidzIHRha2Ugb24gdGhl
IGxvbmctdGVybSBtYWludGVuYW5jZSBidXJkZW4gb2YgTlBPMiB6b25lIHNpemVzPw0K
