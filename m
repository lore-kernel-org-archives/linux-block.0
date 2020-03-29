Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8676BC43331
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406072073B
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KN6IRIin";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rN7IIu9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgC2QsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:48:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28133 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgC2QsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 12:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585500498; x=1617036498;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RbMGyFEOny2llMrAwdlKRX6saY5vUGprXzIyG16MjkA=;
  b=KN6IRIintQtmoBsJ9w72DhDWrcJIeXbCDnDpMhwn+xmF46OgYKtE115C
   c/vHjStMv+c4CLphxbCu5cSN4kXd+F2NmePAQ8VDd/PUtuflYbPTrgea7
   a17pUsn/sc82pB/VdRnO1xDT8MBesngfxV2/zph5IRQBo8SKGDHJeBR2w
   gyL+QqUypTujq9zXcBqXHcUHh3kyldQZYaEROsJJLAW800r/DkkkVT3wg
   h3x3PZwLdxrCMPZHgxWNm5Sn+lnlL+AVc6WFFJ95PFWxkU0MgOABdeaNH
   4DVuhZXvcsrjuO/ZXWdEIL33CUWuL65Sjb0umiRxc0M+rFU8UCeN7CxfS
   w==;
IronPort-SDR: IC6U+cUGT9MdXqp7zVdpMc1rE6TaH+15eaXLGtgwKB8wJuCairpA/zT7uZ8WrMFreNgEL2Qbc0
 1nXxyY9j737RrMNXDMLXTllzpkjOmdJbyVmSovMdrHQN0lwM0Z7I075TSUVKszmXSjGRPQSyb3
 MgA3GdbksAJ+Pdc+6m8QVIV8QGeru4rNx3BoT+M8Sxzorh967/2n4bSNfSHmpVRx6dc1NnmcCp
 G0xgRu8PZqV7JDcJIFO+4j/HhsU3B35RR3jYS+BBkfSqMtW14jIo5eDqcZC1O6Ua+0B3UcL367
 ueA=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="135247846"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 00:48:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dypDuFIoxRcbzWD6oM0cN+7UaAsf4ftkj4SZvY9g4lBSBvQHk6mSMdbyJE69zzBikmq9bMl7KSkZ61kuwwU9F/y1jxwEoZxS+OeNcs8xxHB7U9khXvzXnq2XIH2E0bvFgleCAgfIkiM+ZJpm/N/a5y4ypvjM1/GQwH5wsPtb+E9euaRwujmIO+o4sXInUOEQ2ruBchUlTKoGTj1Bs/C0/XzQ4JnaGca2fhfuaQahuh5eitORsX0xecXEUAczNWT5CXjYUTMJ7sYsfVufSKv5rXUo9Z2csVjRya+dHBmR05dDnD9yDB6zxaQgWqmJvq2xWlzFj9E4vlpWlFJjs7Bb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Ef8528ladLJNaTkCj02n5hX85Yr0CUhEVdBtAEl2A=;
 b=Wp/Gtf0Ap7st0mhHfy13OSBwpsfxm3V9vYbfiPR+qhc4vxxRyVzu0O9DujVXDAL8xSuY2w6DZmVl1FeiT/xB5FtOhVUq3G/AHXN6p0/vtCCefngNFF6Y48bF2RBtJQWl+wgZ6vpHP5z3b/u3yd0HYow0wHWq/GVWrNWDQ1Zuah3ChCbODwmR+0vuqxA8Cm9oeeeAb2kLm/PXzU6s6TiuGYInUmCo8dDfHS02Qfq6Zx7AxL11rOVegh/hBmJQ6g/jAEV0f0Q9QHhpeKvLOCrG4hO0ovy1DOziTM72FSMKx723B26Swvq9DK9spHYuQ3fjkcS7aq8BE2ldEkQftMWAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Ef8528ladLJNaTkCj02n5hX85Yr0CUhEVdBtAEl2A=;
 b=rN7IIu9X8hiNQ9jY7sJ8vDBmMV7Y9l/umniQ3U6qrQ9NfchzPT076im62+YGSxu3WxVSB2Sm+wA4w8+vAHg9fdyt2WgESZhxfZ8cmcseZPOyb50v4hIjMb05mJgVFkesXC8DLRlhXuhWqy7RmnApus6lkuxfiNKjfuSHgB/PzE4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5672.namprd04.prod.outlook.com (2603:10b6:a03:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sun, 29 Mar
 2020 16:48:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Sun, 29 Mar 2020
 16:48:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Martijn Coenen <maco@android.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
Thread-Topic: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
Thread-Index: AQHWBdMQQUAktCkpRU6btFmcg2in5Q==
Date:   Sun, 29 Mar 2020 16:48:12 +0000
Message-ID: <BYAPR04MB4965F147D89443CAD75FDE0E86CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200329140459.18155-1-maco@android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 709f9920-e3b0-4d46-df1e-08d7d400f816
x-ms-traffictypediagnostic: BYAPR04MB5672:
x-microsoft-antispam-prvs: <BYAPR04MB56728CFA151C3A4E8799744F86CA0@BYAPR04MB5672.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(71200400001)(52536014)(316002)(8676002)(66476007)(54906003)(33656002)(81166006)(81156014)(110136005)(9686003)(4326008)(26005)(55016002)(2906002)(186003)(5660300002)(8936002)(53546011)(478600001)(76116006)(966005)(66556008)(64756008)(86362001)(66946007)(66446008)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W78KCzbnGUJAyiYCaxGnqqY1si9iEzq7VQ90bK1AETbB0jxhPvwfQMik4jhpEcvSyjdmVUICmJaOp+WcmR/LlkVD7scHZ+SBAAwKpWqJ6MWSkPqhb0nu/lsMSlNggzEedRUlPyxJmnUdE3JhsvIRTShK5EWsf+CbTa00viB0k3X+euD7yU++N7Jlyn/BcNrS+asVTkQgNynCvcplYHzTTETpCneNX66LgeTu+u8Wwp9s1gcE+LNwvt1egKDzLq9c/BOKnQqsApTP8uR7XKhkISKw0OEJdTRWLhs4zEcDIcow/wiJpbEo7X1s9TbwUKdsU6fp/llO+7FtsX+/tH/B5dixqC8tu8co0Nq1uT7OrZfj/b9m8ARLnCeg+6u0P6a4N3a21SSGbYylpauSA+JeCwwRgrgrv/OTZLKOxvSsOgaiSjEsURracGRvXPNaWg2sBJvQWXEh3FIB0U1F2TTChV+gPMg9E775SCeE+8949d+JL0lUQo1+mpzmVHm2qCaZm7R+Kne6AX+NgJKGR/K8fA==
x-ms-exchange-antispam-messagedata: p1xQ0Vtaac5XkOahnmM+3I3jGXCCbKG57xQzsBDqt9rk8wmXfSqw8+TYEs5BaZcwfIwWgU9PDDJCuB77jZQcixAYFWWnOYl0IrjQId9qPOGVKivms2ZEZ/anzuuNB8bI8+clIjjaFUcEQh/Lbimu/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f9920-e3b0-4d46-df1e-08d7d400f816
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 16:48:12.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cRVeVKsuggNyTZ64CKX/8KqMfMeCNZMuJbZku0TXOEJOpTMFKdsGj1Tzay5nXLjqanBGWUD/8OjJdCnTjk+A71DwbJyi2bpTqY55jdTi/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/29/2020 07:05 AM, Martijn Coenen wrote:=0A=
> Configuring a loop device for a filesystem that is located at an offset=
=0A=
> currently requires calling LOOP_SET_FD and LOOP_SET_STATUS(64)=0A=
> consecutively. This has some downsides.=0A=
>=0A=
> The most important downside is that it can be slow. Here's setting=0A=
> up ~70 regular loop devices on an x86 Android device:=0A=
>=0A=
> vsoc_x86:/system/apex # time for i in `seq 30 100`;=0A=
> do losetup -r /dev/block/loop$i com.android.adbd.apex; done=0A=
>      0m01.85s real     0m00.01s user     0m00.01s system=0A=
>=0A=
> Here's configuring ~70 devices in the same way, but with an offset:=0A=
>=0A=
> vsoc_x86:/system/apex # time for i in `seq 30 100`;=0A=
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done=0A=
>      0m03.40s real     0m00.02s user     0m00.03s system=0A=
>=0A=
> This is almost twice as slow; the main reason for this slowness is that=
=0A=
> LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to freeze the associated=
=0A=
> queue; this requires waiting for RCU synchronization, which I've=0A=
> measured can take about 15-20ms on this device on average.=0A=
>=0A=
> A more minor downside of having to do two ioctls is that on devices with=
=0A=
> max_part > 0, the kernel will initiate a partition scan, which is=0A=
> needless work if the image is at an offset.=0A=
>=0A=
> This change introduces a new ioctl to combine setting the backing file=0A=
> together with the offset, which avoids the above problems. Adding more=0A=
> parameters could be a consideration, but offset appears to be the only=0A=
> commonly used parameter that is required for accessing the device=0A=
> safely.=0A=
>=0A=
> Signed-off-by: Martijn Coenen<maco@android.com>=0A=
=0A=
This patch seems to solve problem, can you please make sure to add a=0A=
blktest [1] for the same since it is a new IOCTL ?=0A=
=0A=
[1] https://github.com/osandov/blktests.=0A=
=0A=
=0A=
