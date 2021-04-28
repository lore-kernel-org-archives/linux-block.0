Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA215C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CF86024A
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhD1S2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 14:28:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59107 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhD1S2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 14:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619634448; x=1651170448;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FhaaOlKVhjPx2YFiLY3E1Qcl3a33HcrjC9cNlw0p2O4=;
  b=jaHJcz/xMbFyoFaxjJ9TR9kVcoKuE1URQhaEV7W07XRtOYOpy9NYfFjo
   r6ye4PQZPeYyfCVSmn1ERCzgOZy27bYVNxCXyewax3omAN5PxMNpgLhTj
   qr5ju9r3D8lFRSmX/gbt10J6VZqe4zxIc7ZzSur5BOJx2jmfESx4aUtHx
   gZ2SHcipQ6vIcOIaBlv1L2felidPIxMPUk6uTvki5ztud/197hosP71Cc
   F/eXazwRCR1h7reUW/hxSoghhgctErMrWJ0oJF/7JNyJ5xDtVqsYdUVL1
   icezC0UK20FlL8YbHK//2CtPY6a7GUnIpHg3nZv1cu6syzRu1VSNkN3nQ
   g==;
IronPort-SDR: Yd+UH+f3NVnr+UHB3apgPMy8p7zSKwVfaRRoo9AAZKbU0fqNE4nvNRk1YQSydFgbpwkFUeW8E2
 HqKlZGv5oSQfxBO08aZasXnW5AqYobWswgc/yCsnFyz7NOYAn1WBqNhc0fxMi7XwiHFcC4871x
 larZGIGGmrsTu/10yTLv9WorrYCJ6yXr+5zv++8iAiaT2BW1/nzKurYyViK8aGHb8Yp9IFiZVi
 joPakLCc+gPdhREl5TclrBi7McF6af2ehPPkF+jpl4eo1zdjjNIHcgwSOQBTQYWUgP1a3IxElU
 VWE=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; 
   d="scan'208";a="167112049"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 02:27:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyrFFAHs27LpxwHWFnJ2alQo5BqZfO3v5Z4xoegSMyQ/XuZiQMoIQ/Aj5llxea7lEOf1XRgahHSeFLcp2ESTt5e1Kus3hMuJNC3XjlVNC87FBNsg+2EVuYI8KyV7JGsPwes0crganuK13TyNKuSln3b21iv6QCuIsqhFeFLxLYmWaEtBKwMVFJqJqT9zB1E54jam040jcGrypbK/UyZO7B2G5xqhuL4RGjKuNy7vCThGrKtMiOHqW2PhJui2T/cr0LHJsfjjt771MgGUerGb9+wOr6gJZNG7t+ozAmsfNjKn7p03vpHU08xD9thKk0gjDdYPhIcNJlc5FXK8IEKTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaaOlKVhjPx2YFiLY3E1Qcl3a33HcrjC9cNlw0p2O4=;
 b=ljEwnJgvIcS33NXK6iZ4DuTcm+5zX4/fXCTQsV7PqgKfFeflPcpcCaHtCYQzQzEbCz6g77Dl9x7vNgEvxT3k16OVXtJKLE7YTHFNsw6Mgag2Hg9I3xBh28B8ZYBRh3JXO/+CvEPs4ftN+2XdfHNHZ9UDKxsjsRymPjTHeVTkqZkwQNmcDAaqOlaLAO7DeqJbEPGiN2mllAyw5/NQOXNCoLKQZhdb691jVw+BKnWlm2Yn/TLTue108jZcyzRGqWHVLuRLhdRUt3Lv4YcGvRK3hlEisQLM54yQ3KGbbnqtyn9isQg3cJlew6iHwkiNgHJGXtetRAyOyTqTauJa47NaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaaOlKVhjPx2YFiLY3E1Qcl3a33HcrjC9cNlw0p2O4=;
 b=w0n+EvPic2cgQfcKIbZ42jzihaq7oL9iiBNlZqW/UMIsDioS8+j3Z4pMweo+TfHqeEJC3jy1xhAn6pG9jZe7a7ZCCqoxbeT5SrrUiLXt0DxoFBUMxNMaheHzezXayRG/PDxrt7kn0x42p7F0pinIS4RsVa1YoVUq+LCP0tGIAvc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7693.namprd04.prod.outlook.com (2603:10b6:a03:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 18:27:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Wed, 28 Apr 2021
 18:27:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>
Subject: Re: [PATCH for-next 2/4] block/rnbd: Fix style issues
Thread-Topic: [PATCH for-next 2/4] block/rnbd: Fix style issues
Thread-Index: AQHXO/XLgsnZCJxpaUmt6zSAxgn1qw==
Date:   Wed, 28 Apr 2021 18:27:25 +0000
Message-ID: <BYAPR04MB496588A3FDC46C6357C51DA786409@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
 <20210428061359.206794-3-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb514c8-860b-43ff-dbb2-08d90a73458e
x-ms-traffictypediagnostic: SJ0PR04MB7693:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR04MB769397CFA7A4065F1AE8EC4286409@SJ0PR04MB7693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4rG/i6iu5MYPv6WSMc/UZ7h7aBTHrQLsDfezx+B7AAs3XYo60udlsp3RsCxmIMTHclQVNWiDQZl7XutKmE64xC55GumJvUoMchPKTVMk3pweJRSJF9Zz15qW5kegQfBhbdsG4vvX5AkQdNW7hFOfnKqDbdYvOahY1uyVYVR7uBuSIR4p53smDTaXRcxtXMbFEuteAoWMjMR94Nf+oCprDi+8NQTXbZoGBs0kQfa4tFHirXMFZpW5djO0X03h0Din4cFMsxQMHAzoesClAu2xW/549/fD6fMuRpy4N0ip/h/wPShjlVtD2vzpE40Fxkx3eq1xf7whvhAhWNjizBggkVUWwnOadFqkMymqptT5bbNhTRPosoTGokGPSkv2UNWrL60TfPY08tRS+ojXh1rkWcWJiZ67wyzzLyZYHjdPelvbcwnW9vexRGw3Lc7ieNwT1TU1P41INRfrXx3SxIRuOAk56a1f5SRLW2bXxsbWCX1il+3ptcMCvDMK56cdwzWvRICwEeYwMIzkQ2VjBViX9CzRPwkt764esWLFZsz5IWvT08nQYmgHyim7NXZn59VhRKhPAvQPZrDunRt6329cf3OKAGrzC8GdHopmz67X3hA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(316002)(8676002)(8936002)(54906003)(4326008)(66476007)(53546011)(38100700002)(7416002)(110136005)(9686003)(71200400001)(6506007)(5660300002)(7696005)(122000001)(478600001)(26005)(4744005)(33656002)(86362001)(83380400001)(66446008)(64756008)(66946007)(55016002)(66556008)(52536014)(76116006)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fHIUlTa1q7IfHxCQoKm0FAVXFzVnHM5CwJJc36tT7RRJgesA7ZL/RZ9gdE2S?=
 =?us-ascii?Q?R02Bv9EEqiSLxMmgy4xEHYFZci7qSVwaNXknQFQEXZecxYDFOn8Uxz94vrag?=
 =?us-ascii?Q?Er91YGLpQnENo0BmYVlxhB3ylRTLNrK7Bk0iyttENRYOh3qgp0C4S1siIxXM?=
 =?us-ascii?Q?YKnemXhLmstCW+cEVoUafthogH0J7HvLilBEhB7xwSXq7adGsC20SjAhc8qQ?=
 =?us-ascii?Q?nGGv57LdA+QJLFlwInURhZ+FG6wCWjyAHS9O0AsuamkDJzOXs6uioCHTYU/I?=
 =?us-ascii?Q?v/+G7Hkvhs6qsncZcjhOy9bDKrsHcZtmR8RGI7RlzBkYHp2L5VMuVfv5VbE/?=
 =?us-ascii?Q?TPDOf+btX9E7oeHX9p/3ADkkJiFqY42qXOGnIOsInxXZdAj8BbZxueYTeXnk?=
 =?us-ascii?Q?tkallMr2aoh4/ZdkfaczCETCgPh/vCwdOHkcv2NjQlrX7GovfPIoyuTe8piD?=
 =?us-ascii?Q?587mdWLlb7EUyvus2p5idnwwbGjggYoZ9leEJPQ24w0NWy16YufJAfk4yVjQ?=
 =?us-ascii?Q?BXXtFm1h/FYDYWqhQHUvG5XPokgv3yXJhWhyNlI/y3eawWm4LLAjkN9uOa3r?=
 =?us-ascii?Q?Uob5+LA6PPesE5CyfA0x3btubRzG3FJBAwRwys/XHOmYZMDdUCPTGSIT1o8K?=
 =?us-ascii?Q?gu0zHY9tjK9NOUjZpcQ6cMWSpo1uoV4cCU89qM97KbYMVJ8/APjrYvPBzqt3?=
 =?us-ascii?Q?FKoZWixWu6wzKYMZXio/JWPUjRkaL7/9xzT+9d0Qk2AgJmoB2PQ4iQM2MWnT?=
 =?us-ascii?Q?3g6lM1EzMSDcbBKQPCe+OS1+OtPyNeiIWWdIZA8VRb1LgNrT0HSuV8f8XBRI?=
 =?us-ascii?Q?+nrMaKtGes4ozgXCSIRnQRRQ5t8Aai2EGyloHMOCMHQhrSOSiWk+ANVk6NTC?=
 =?us-ascii?Q?ykRPcxmBmX0vPtqzkI+wjlTq019EUWoxe27BRFl7siguUlMxIP0fIGuxweZ8?=
 =?us-ascii?Q?o4zpO+1tCmLVL9wvELkOV9xKVL94d3Lbx7kYsgscMUHkJnUHtXPbiz9tY1g5?=
 =?us-ascii?Q?1WYA0k8r3AOxplWz6vfCEZzkhSMVq80DH72WFnbP+Rqrnf3DJvrsnhHo6cVp?=
 =?us-ascii?Q?e9KxNZnyOh2PZWxm5+aqg7kA7fOwhy/Tjru0Cq18uCKCSGxq/vO0+LqO37v4?=
 =?us-ascii?Q?IlGhI/v7MTTS0G4VFC6UlrGE4rrDBAZBccPD/aNVVnGwlgprt/Xs4yf0h/tQ?=
 =?us-ascii?Q?iEBZ5jSCs5LY2vvsNzxm0g8vbjT1pqmLzM0hb5WuqXQgKDqVTvAhnQzKyayZ?=
 =?us-ascii?Q?IhBK/rf4+rWpjfH0ULUB9Es4oLCtAobGdrwlg9v5pa3U1kGQbM4SPSnNvy0e?=
 =?us-ascii?Q?gAjh3poAHtGln2DQRh4lboig?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb514c8-860b-43ff-dbb2-08d90a73458e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 18:27:25.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oowcvx63X2+5lRxq45qmfWUMB/RPnvNpsL/XGntvf65xfAYKUEo2RegWg+/Vxi/fMvd7UIEQQCqRYYoCe0Vz46sTTDZWVMmfEPJFJHPC+CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/21 23:14, Gioh Kim wrote:=0A=
> From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>=0A=
>=0A=
> This patch fixes some style issues detected by scripts/checkpatch.pl=0A=
> * Resolve spacing and tab issues=0A=
> * Remove extra braces in rnbd_get_iu=0A=
> * Use num_possible_cpus() instead of NR_CPUS in alloc_sess=0A=
> * Fix the comments styling in rnbd_queue_rq=0A=
>=0A=
> Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
