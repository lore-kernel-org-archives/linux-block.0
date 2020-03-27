Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD5C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893E720663
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D64kRoji";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Po2XGXaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0Tfs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:35:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45435 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0Tfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 15:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585337748; x=1616873748;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=a1sLbGGIHmCnAlurlWL6OTUHq5E5aeyfbI4JCAItx84=;
  b=D64kRojiqKoda+9qvtlzj8pKV6XC8Lhy9oN4bg1xbr/5c6o4q9O+0E/r
   wz+sWLWFFQ76l45P09G51nud6olRyEY0E7x79c92/v2uEixNXzTM7YjYk
   jZAokbSER8UmmXD1OGAW1nShITThZxweu9CcN8aUieC5Pcj/TQWe3EHjt
   2dUr819hGfCbbVuXa5AsHIVBGrAdo7SOeZtMrY1Tq9bl2zyHWcQ1w8nov
   d0PpTHIh/nAUKS9N6MUSLOqvvB3IlZKy6Dr3OqI7TNWYAgZhfOQcUR0aa
   vSFfrtlgVdBHhMx/uveRM7L/Ak8RkcdBzBHWVbX/qSCWsgLWENJg5Ee+b
   Q==;
IronPort-SDR: 7vGvqMleZm55VdlwDi5HQNl1GOF1tbRew5wEqZoQqnJzeiFcrtpunA90i4CN4yzNoK0bvRztGJ
 i1FGO50ZgCZClO14APjjMWeZ3kATsGcqVe6Bd00OL4lxPxuoOYEaWgAauZ3o/D5qaot4+yRNlj
 j/WyC7TfNAW2PT+EzVa30ViX5b98rGonNTaO4X8dWarzoQqmITiQgF297tFE9uvMprH1SElRjc
 fGWbjzEaoP8tBrzcwVy8rOktgoC5+17cVaBAnCaLIyMGTAxwhDgmXL4CCd8nRpQ67gFUAHbW4D
 LxQ=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="133701720"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 03:35:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btS1panpw+iwQ4ZeVqr8jRM2L+gdZ3rvnL/nS752fZTOTaDP9sS0TQrx7gpPEcQsG99Wbgyj9jOlC0cGM825MSA9WFoRT/AzGabdRixSetdV1WyoOxpQW8CmDyFVsorISKdEnGnkyqP0gaPSkPWNcwoBnnRzhHltp+PmqNBl8FKtWpLQ/kO5kcOX9HXOtQ1Hu3Zihml1GqIhvEpJSg1/STwhzRkH1eBpAn9QtglCubxmY3LJq6EyG1Vo4GRawOLDf/9k8SdyY+H/hEbmGsZSrpsficW5A05aZXO/i2JUv+SNUQfBIrh7lWQoHuhPS88dd+B6XwQbPxnasWCDNLELTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1sLbGGIHmCnAlurlWL6OTUHq5E5aeyfbI4JCAItx84=;
 b=nE3s/CU/4R1MYmYtRoZfXdqpKpP+x1ST9dpnQORKiOIbCmfdI0uKDRWRAx9PTJDlzoYVqDpfciJ1njN6OeL6teaq8UMKIeWkj/1pQOpde6s27V7YPHdgKlNZSaKro3evWDoLU64uysza0HBY5AOVT0S6QnI+GUHQQU1UDf2AibcynB+d4LwU3ReYXv8XgyY5Cof9XhPGi2wS62WSmziG/jablKZgfCp4fOlH5nLEIAuJnUWlMIpxzj4M16LnsDfqwLaqpHudYUAcAPhdQ7KqcwbpxZ30Eckvktk2g9qelB+U4pdWO23NGxssgwfIKm/s+fyYptLIRNV+rfTOiqk0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1sLbGGIHmCnAlurlWL6OTUHq5E5aeyfbI4JCAItx84=;
 b=Po2XGXaEXgP0h0/FuZoAsFga20Emvzc1iJ1QcMxb9srk4R5Q7MzDRGbkNsraBP2md7gsGRk7oCI0Ra/HOK6tuATwQGbQisZWG3bEQhMu1ISMnrOk44PkYa+47BX0MhUSSz67u0luYvxUBaFH/m/yp6/bSKcHkU8N2Y5QRJUDSoQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4888.namprd04.prod.outlook.com (2603:10b6:a03:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 19:35:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 19:35:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Topic: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Index: AQHWAlR/KLeasVEdYkWa6OO45kCzaw==
Date:   Fri, 27 Mar 2020 19:35:45 +0000
Message-ID: <BYAPR04MB49659E6F0542900C9DFFE05A86CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <093c4ab1-924f-b109-31a8-ce5813f52e14@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e40:3000:5d24:96c0:e1da:fa3e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a24b1b8-3fe9-45e9-469f-08d7d2860b6f
x-ms-traffictypediagnostic: BYAPR04MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB48882249570A9E984B1E06D086CC0@BYAPR04MB4888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(71200400001)(6506007)(66946007)(66556008)(7696005)(64756008)(66446008)(86362001)(478600001)(316002)(52536014)(54906003)(966005)(2906002)(66476007)(76116006)(5660300002)(4744005)(33656002)(186003)(53546011)(8676002)(81156014)(4326008)(55016002)(6916009)(81166006)(8936002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPAAdQ9jwA09tXQavAz64KWqO29WUmGncwYci9YJHTZei0DGhGUro0Mcsat1iSidkNGVtON6cy2z+lnFpwhkjbEFyqDB5TKKeoWEE42Zz7lXAJxDSi/1u+jARFN5m7J2vDIvMxw0+Sv+qQFMw34cQVlpUSajr26ulxFCw/c6JDhcL1/AcV/FNRswKPiyADGjiSZvlkMLpAI/etW+49KYUWOAe/1Av/c7bq2vVtWpCtw41XNCX9rtdn+fiuTjuio24LMGOzVnJ7FRXnfIZnMkissgjQDL3fcwriWW99qiMmllmn3YnkNj1kmRQ1bv7JrEhkMiDolLAGin2bzVbSGFamyOWaE/v/lwZHxE2/8d1zJAjnBhgp8LQO4CjCpxFRfBRTi/8ALkCIwQ923RuZ/bVzxSjkjulU3aTuhU67jbUsNzwIURus3zKm6e+7V2e7KppVvFUwEBhAl1CpamXZsJ6uxDSe45fB+W1LECfWmMJNNqLnME4yoGC9X4BJKxkFgVHd8bNKF+C/9EdjLRA967gw==
x-ms-exchange-antispam-messagedata: J3Ml8O+3eKu0GWSBjS+SFil3uUA5j5JqFPp6iOcRTRQs+jIniNlsLioq2oELeZSUuk10PueMtjdz8p5/W+/KQU6lJ5CBL+2To53SsASF+xuLC38bfXcWxuc65kYqPiIude8Pn171P4vhGtthoTooAtLYC8FGwdh15+0TjJKw8yRwzys2J/S68gGZDEs02K/EvIQIz47/wlukVQIwKTNZUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24b1b8-3fe9-45e9-469f-08d7d2860b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 19:35:45.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ElXxSTDxUex5VJafnf2NsU/asjU2JgbiE3ped7I7qUBdVi65+pJKU1REA+cRsReM47limGVMcLHo7hs7kCIfPOVTgTgl8NzDP9g770igQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4888
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 8:35 AM, Jens Axboe wrote:=0A=
> On 3/26/20 9:12 PM, Chaitanya Kulkarni wrote:=0A=
>> Hi Jens,=0A=
>>=0A=
>> Can we get this in ?=0A=
> There still seems to be the unresolved issue of the function=0A=
> declaration. I agree that we should not have a declaration for=0A=
> a function if CONFIG_BLK_DEV_ZONED isn't set, so move it under=0A=
> the existing ifdef.=0A=
>=0A=
Sorry for replying to previous series.=0A=
=0A=
Here is link for V4 which has above fix and Damien's review :-=0A=
=0A=
https://www.spinics.net/lists/linux-block/msg51305.html=0A=
=0A=
