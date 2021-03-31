Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F767C433E3
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4466B619E5
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 00:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCaAJf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:09:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41408 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhCaAJQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 20:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617149372; x=1648685372;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rVqFl1I5nPzhtC3qpdyeKyY/QuZw2kaUUw9FPJ+cqXw=;
  b=LqCnDMKNxZ7l+Xp8D0pqkoamCjSfaLgfvWkom4lOZfk8lWO9lB7Eie32
   TMV586cKJYwOWvpzdfTtfom3uXCJa+Y9DDktedZqKuZ2zyTEs92OR1e38
   gGZAU9matAx66i2cPOWAEj8jZR3VWsjGDNdRuYKxWAfnyvcG4ssSdbtQ5
   y4vXtgaS36Bz+DDYXbKWCJ5wXjZPTpKTDfIobn40N5P2Z5YYXQYKfTRtG
   i+THeug59H05CaGGuGARYQucf9sPpNP1gg42Q5QQPDEmMODgNzv3+WlL8
   2gvyw1nAjk9VVb4FATzLsagtKo+z96TVev1kDqNWGyGRPZmwzkxYg0QNc
   A==;
IronPort-SDR: YFph+X4I3aXmYHBW8Eal0DvKFpIXC5xGjcdUFH2DiP3Ze1iCgkzpPmpEBa4qw39ex7hJOQCugU
 VpmcInasTii1Fq2MDTLwsQPd38AjBOfbiZZ//fsLCrbVjChvWmDwkzyARV3UFEyg/ifndnWVur
 xKg+4RhwVM2DD3PcJDi2KUA9+lILDAxZivU18AkKaUvWfx6bh2Ulpi05ZB2nUrWMK2Pt1IePn8
 Xoi2/IY+L0PzDBSWgJE5gRNCq+UQSN3OpAwJhMZBG7egE4O19p1QME81MVx4vFOPPE5UeVETMj
 enA=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="267821655"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 08:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKyByz5sF2zG1Ys9tZJ4EAHXt46/3KpRumyuJZT/KMQKqjaAySqRp0UzDykiqx48zQX3gGTTuMfm1thrhWiFH/EV7G1Hbutx8lDzPz+JpKqatK0yp0wdcVYPd6lk5Tmvpg9eXZvWsD4eeL8hA5FsuTRdmpdweb5tNIisb/zUS2jmL2JdOeLS17QMOnWnTyFOG9PCMrohveQzXr0yF8TuCfpZXLwKqPW0G0w6OhLImswSH21EJAAJXOwJuotLVVv9gx4w4F61n2fcRfVL29Q8FAUjbwYzUOES/JfsN+/neeolxH3pxMwEJ3M1zmHCrQbchzVgBpraZEyp/YY7w9FeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc+uELVnmaJtAtg2M4DgSLrXJ8csYPiZUT2YkRimrek=;
 b=UYLHtZblZq7o5vhHsCp8s0yCjTa4lHCo9pJyXjNUiteanlZF2Iv0Qrqq7Z887t3LCgAv90ji9EIlUkTwTCMr6XhuoG/hPDz8w+Q8qzK6avZhFmiYLZG+ZA03BbPPJOI7Hfo/CGjjuumh6WhrmWpuiyZnvEQhNiD5QB1AmnKA7AbMIaBQtQiLzn0vpxSkofT93Jey7uVrgZ6jOm/hGx/0qUEe8ckxw1ri1tg0S/8CxQiXzNog/roROgVEutncAyRVhDDndy+Q0vp5UCw7sgSzRyubK7BbKXfJvyKrqbY7dOyVntYEjxRBGbgrrPVX/VNrrZuVeR65d4umrhJ8GXXfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc+uELVnmaJtAtg2M4DgSLrXJ8csYPiZUT2YkRimrek=;
 b=ESSPi1BGROBR7DrIpORoYgrgjH15ONhRshvoBaxTSV5ISAhEFpqvgLs5xAWUT1OBXIFMemWGXVuYuoSNeA97ybvcIEcB/phIEqSJMVnSGGWVZp1MvOe4NasomczSPUQyvLaeI+0zr1QLzYmIHLUqTUzlylZDGn1/JDK9kBO51+4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 00:08:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 00:08:14 +0000
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
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 for-next 23/24] block/rnbd-clt-sysfs: Remove copy buffer
 overlap in rnbd_clt_get_path_name
Thread-Topic: [PATCHv2 for-next 23/24] block/rnbd-clt-sysfs: Remove copy
 buffer overlap in rnbd_clt_get_path_name
Thread-Index: AQHXJTgMANN7XOe/EEC9qPmnSVu3QQ==
Date:   Wed, 31 Mar 2021 00:08:14 +0000
Message-ID: <BYAPR04MB4965972D569F0AFBFA7D13D7867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-24-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2eee9363-c0c6-4bbc-e508-08d8f3d9140c
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB6753C5A27FCE74E2CF0B7573867C9@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ntExBSt7ceDdGKHxcj95vjWPhvXMBX/tWG2Imk97pPrcozszTPfhD4nv/byDA0sbQ3P1Y1VENBwVkPWAryQG6by8JpZWBwTvw7bafYJlE7JfrpVCYv6Vnt1YItuVl4WNvKTPoKNfbIbtdYaq/DF3LPfk6j6uqQ8RwNeZ9gs8JkhQdqRkKSF537XTjj2HYFERYJXtc/wyRRC8GEX8NkZnBXCAtId/ZyVSx8t1akL4gjdIfgotdu9O3Qe/WHcbSn3+stojHpErqxQB0lBH2APgPiR1TN+dLRqPgiXO3Me/pz4b/wP04GbfUrb6L1hswweISD8qfGkv447ycp4hQCeun80CzYajBHbvipwSLZ4ACOqdu3/XxSiycOSzfmW7piWAMKg5wNL6nSNJsXxwO/uz8ermfsTaOuRVfvSaXjXnFI6tuKd8rPHilShmsbfOxkP3e/gypJfYfapQvjouyP8xwTLI8lVb92Oc3T72afD6Jj+3VcoMImsHwQgPQL3YghB7AYVmyzbfAoI03KGMrLRL2T2u27WdLI0zZaJl3uHnTWJO8ATgdUL/OHdMzcaofl5QrLoECBKvjl6p0yWAXeXMkkv3Dq6sUiI6cS7XbaaZxrIv0MS2sSUatYGP5pBCQuNx6jyzLNpO5AjEHU/uIPMEFnN3pgP5XaDPrcjYKNgrSLVNyRemRW7vxYnY3RoumZnjXvxY0DKN/eV7QKNpOtlR7s9gc4iA/AwQwK59sw2trQskso3NP9o7R5UiK0z/gw/0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(6506007)(26005)(8936002)(71200400001)(7416002)(5660300002)(66946007)(86362001)(76116006)(66446008)(91956017)(66476007)(2906002)(52536014)(66556008)(83380400001)(53546011)(4744005)(478600001)(64756008)(8676002)(186003)(110136005)(54906003)(9686003)(55016002)(4326008)(7696005)(38100700001)(33656002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sdu8WSgI0LYOM2p+4S6iHcyrOIjFgd8EPc7DUf/Sismoadg8lg0WMV/TI+RB?=
 =?us-ascii?Q?P3NktdTOajEyZnyetTJn3LIjznrRN/CY1jSaR4IlJtG/GrGAIP2Bwy6XYZ1Y?=
 =?us-ascii?Q?C7RyyhYKckOk3QoywHYR/ipgRLKPyRwCFQiKeniwuNX+i7vK3Uk3D7AVKsvP?=
 =?us-ascii?Q?9iKc2VVbX7dGmtdJvI68MY38rMePWG0u0YZPOtFI3XUX/SEhCoH/elpGC/ja?=
 =?us-ascii?Q?GzYJ0OXdes+MnCfEvtdlVryXqHppKKhsnWDpFvqpr/1nJdNeo6EdpE/v8J6I?=
 =?us-ascii?Q?1uoHBUsIhc4tVApRLpIr1Vf4PeQAlAKDahyp2qN6zVz672iSlTb7cBV+aGf6?=
 =?us-ascii?Q?fbG3et7WgjCMJwbPj9nMdIup09gZP6jb0+08CTfwPi5wMJckf25dBtEWj2y2?=
 =?us-ascii?Q?roQMw50MmevLaC3in4N4V90R8+fuPgC7H4sEBYAYRzkDs+bJ/ASNyDthS6P4?=
 =?us-ascii?Q?LPsT39NB45B06I51o+cybnSTwO5oFrTw4x7EI5u05AwxWmOUunIyAr32mXcU?=
 =?us-ascii?Q?TIRQtnsyblkQXjbbh6wEyMKDXwNEP1/fOnSvnGHDivDnY2de22g1uHWVRR4d?=
 =?us-ascii?Q?j3O7CZFX/Xo4lsGuPHJ7vSUuQLVPNJrFVwBN1YCdtx6lridDJ66xCJXo3NEk?=
 =?us-ascii?Q?kNwi6uJ+MHSVQgo4f2kdEmT4iKcIrv1BW0P0tfNUPIPKDv+Mg6nfspLoP9qr?=
 =?us-ascii?Q?C2Fy5xwP4RYBrEAPXny90u2BDFVRQxBrTS76RWDHNR0QxfpWKuWS8tFjM3oA?=
 =?us-ascii?Q?3Xj63i+wDH+5Fr90XGXdG/WoTXYnDkFxPDTFzoCfhX6nCQSyBzbfhLtv1pya?=
 =?us-ascii?Q?AikiIqrqMa31E2b2NWhlwrIHk3deOJu4gSuLW9z8En7N7zGGDpFAVRCryV8g?=
 =?us-ascii?Q?79gEkXaxzswC5sOhB9+TESopVDkQkATpn/zHiSkUWPGp3k3X9L8zpDSpTj0o?=
 =?us-ascii?Q?SAOCCAmmOIslB8IunDCLPnTP66hdUih/uCa3iRXMsMPO6Wa6BlXlsPFlnHTX?=
 =?us-ascii?Q?hXmJ4M08dySEvQBQ32X5z6N1GsLKVz6wIoRyphJFJt9tY1rguzLbKc8flwqj?=
 =?us-ascii?Q?0Dj5+58s6CJGY57Dg/OVD/vEVA7cHfZkNSE06sr/C5X5IEYwcDwR6ZQAMftJ?=
 =?us-ascii?Q?PA38SW0tRj002L1jgFYMqlHkphwDlmIJvIkMJC+qAIPXl+GF66ibkj9ka0nt?=
 =?us-ascii?Q?K8DckzTJnpsiHc0UPQZ4kKEBIe276JCUAYNZVqxsy2+K5C6fMGHNEVhUGGRt?=
 =?us-ascii?Q?dDcrAWmkYMrAxVFDAWzUXU5iyhbcqvDENxAVsAOj3M0hNroeipl+2AeZZpeJ?=
 =?us-ascii?Q?JGsDHWNNPmbIqqGDLlCnizvWWMZALgTMSCGQfUdQW1j6Pw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eee9363-c0c6-4bbc-e508-08d8f3d9140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 00:08:14.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtOkBD4cdN9orZ5xH9n63QhQXUMu1mO9djtQk6Hy8hQWuMtW1JOjgeTGhY7PTFAgWlEN94fI7gVgDmXDPes2npVNBuJ8iP3RY1fkFUXNyCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:41, Gioh Kim wrote:=0A=
> From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>=0A=
>=0A=
> cppcheck report the following error:=0A=
>   rnbd/rnbd-clt-sysfs.c:522:36: error: The variable 'buf' is used both=0A=
>   as a parameter and as destination in snprintf(). The origin and=0A=
>   destination buffers overlap. Quote from glibc (C-library)=0A=
>   documentation=0A=
>   (http://www.gnu.org/software/libc/manual/html_mono/libc.html#Formatted-=
Output-Functions):=0A=
>   "If copying takes place between objects that overlap as a result of a=
=0A=
>   call to sprintf() or snprintf(), the results are undefined."=0A=
>   [sprintfOverlappingData]=0A=
> Fix it by initializing the buf variable in the first snprintf call.=0A=
>=0A=
> Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices")=0A=
> Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>=0A=
> Cc: Arnd Bergmann <arnd@arndb.de>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
