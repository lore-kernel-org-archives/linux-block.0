Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF0FC3F2CE
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5239D214DB
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GBTOfaAB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Px3HB6FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCAKul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:50:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCAKul (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 05:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583059840; x=1614595840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZUihEFe6lucCnYhqRqGFX9GtVfhOMQU8b74ptvWcomo=;
  b=GBTOfaABiW1iXxdf3Ybigfcq5oUBuTI9grfNuAmhPRWPiy0bjZtc8PeB
   rbsJLNZ5zT5e/vsSOnOQ/6sNJRUnduXoVwXhWNaTi7lQFnu8Q4veoy1+E
   JZjv8tNhO5gOba83jt0kBl6EoX7l3I9N2j7Nk/XIYOo0pkEE8OYN124pz
   OuARgHSTzKpDHaeZIJrDirQV3Km1Ja63EbHYQAYN812UW9ulHW2wwtW8q
   oLJrxPqco3yBo2pFl1BofY/+myNOChk55A6Qy/ZbvSRRUOjmIDm3rIA3w
   UYA9aD8RYYd8Q9PRpqsy96FbNuT4Df+geyG8ocQhQ/WsHU1wEArR5uwYl
   Q==;
IronPort-SDR: 017aSLWPQR9O4Oi8X4SvHHTcwFTmmzpnhz4OnwOfMxDL8p7qv9sc7O2S16LmD5AQqVNqn8s5Vq
 jFGVqhfwGJ8OmpnEGQB+Gpj9tfMha7uSXAAh1AYXxsRtgFPaQ5UQVQTI+mUIJlU7u5SCMPHzaz
 LnaB/2nuADn3OVURZl2JIUdM32g5VD/PLK7+snbgK8vxYVD0dHQpwWOGhjuaYFi8wxUa1SHmBt
 nMCTjwZx5vBXrAbYLza9ZvLC+j3Qr4Cg9aoceIrtGP+PIfFbXNkrakQzh5rOTGY7FSnU7E+XWi
 tvE=
X-IronPort-AV: E=Sophos;i="5.70,503,1574092800"; 
   d="scan'208";a="239293287"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 18:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/JkfxskcVQ89amNXq2RheM8P0VUeaWXbL9Mf7WpBk5HNL/Y33i/6xxJjYH3jKJ4nQSjDzLWF4GbaXoQ3/sJY/adikBvJVdAoU6j7ZICMf1VMcIh33xJiYOl97BpD/R3aWUlH0RxXM+7MrG6BiWAgT9f4A4/wmDqDcMCXAkKIM7PhbPCDw8a6w5OuBjqA3nTDlKbAyGgOGxBKAmuU/e6XJJ8Ql5FIp0DD+4wOW9xSB1gGgOVEKk9pPN4BUAkSCCwt9cwREu0+CjYZ3Z4gtoAUoZ4G2d659YLJxqUri6eZ+8r2n8pkPwRdyxvKpTugd86q/C2K4RU22XRkYHjO3vSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0Xyz7gRBmPJm+wIunw4MZlcE4dhsVHsOBRtju3pIOA=;
 b=SZONRVquBjGkCPHx2R+NCNGtOMskShj8Zlg/FN81q33s2FV80lc45WlZy1erbDiP90skBZpCQllwG0gr0PkXCWgXacgKvQ54AX+rtIYIPie4iN1Xj71pEkNcxdpcEE4hjL9vB7KsD5qEuBET7qqcJdO4wyMRbIxNbWaGQw+/9Va0pi+YvJupVfMzIUhLTU1lAOs9a493oNoqbqTbpln51Wea/tQSzX8pvTGx2Vcamnb8eHL0GEIFtbpiD4XBGAnij8eaRf92ZXewNDLFajNU+6IOQ/A7WHHimBrBWfWFvWPgMsDwYv8kSafeCONhgG14bB92AQJu9X1KvW9jTPhjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0Xyz7gRBmPJm+wIunw4MZlcE4dhsVHsOBRtju3pIOA=;
 b=Px3HB6FVYO8m32d7+LM2a9NHGwylGuiSNnBNVAjXUF2wfuqpzV2vFbmT6GAL7YpeFPeBvkLgTWHqg2xvqI3yanHy28SS7OJIB7SOCLL05LqHpPZV0K1jPdA4V8YuCNhKUOjhlTi8o2POkZ4VN5i6ujEZV5G6vNWIdstPXRiL2l8=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (2603:10b6:208:1e1::17)
 by MN2PR04MB5743.namprd04.prod.outlook.com (2603:10b6:208:38::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Sun, 1 Mar
 2020 10:50:36 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::3885:5fac:44af:5de7%7]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 10:50:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Thread-Topic: [PATCH v1 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Thread-Index: AQHV62lMjgFqnDamZECwOoicj2ncZ6gzlnYA
Date:   Sun, 1 Mar 2020 10:50:35 +0000
Message-ID: <MN2PR04MB699121991FCB80BE39FC106FFCE60@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20200224231841.26550-1-digetx@gmail.com>
 <20200224231841.26550-2-digetx@gmail.com>
In-Reply-To: <20200224231841.26550-2-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf52e812-7238-4e77-2d93-08d7bdce5f8e
x-ms-traffictypediagnostic: MN2PR04MB5743:
x-microsoft-antispam-prvs: <MN2PR04MB574337FB6A8B96CB0C12209FFCE60@MN2PR04MB5743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(26005)(54906003)(4326008)(81156014)(81166006)(110136005)(8676002)(71200400001)(52536014)(8936002)(186003)(5660300002)(316002)(33656002)(2906002)(66946007)(76116006)(478600001)(66446008)(7416002)(64756008)(66476007)(66556008)(86362001)(7696005)(9686003)(6506007)(55016002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5743;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuS37PXuG05YUycIzsR8uthIntfeH+m9jvODPjrFjgxal1bUWyqojQajGMiXekvAs7bvuGTCBcaU0RZTTR7laJwm7VVEumBrgY6mF68TnhcJ+kuhpybxRl/TC2v3cRZzjZ1JdKGTZiyVd0K356Pm2BwEkE4wAf9eX7QsaNSenNe5sCMpYrBXZixH8xkTxn+olP2Pm3CHP3Wv9l+rSnAeFs3X1wnPNjO6EBYpVBmLl1GYiD6UDCQjhiwCTPNOu9U7O5bnNArLlKcZqkrK1xHoDlVXgfgBS+LEzrLhd85lKaADTFNHobZVl/ag9zUJlVXhrR09dWO+I9Yv6hA4XV1v1bWieeixU8/6pnzK63LKST4zbSLGVFI4WhbtrV2WFdsTgH5lG8sqF2CW1sragm/qKsNJ5dQ/6ozAoVATW7SwfMmnO3uDJ8M8HPtSOL8nxYnFlY3uexot7oQlM5WUZ1B6COeK2kB64A8ocThnLIipiUFVS6+3J+9BDT2RZxNZX2cZ
x-ms-exchange-antispam-messagedata: gutNQRUR92V3XNn9icm1DqsHVtl3/81d8CmNEURm5ndSuMejErA/zfCTLMK/fhKidTMPB/HTEmlbYXKsaOKDYyiYk4Wrt58+AiOTtXHw328cY+YHL6K7FKCRG/9NeTXU3uz78RdjSVa6hmOJy0aQkw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf52e812-7238-4e77-2d93-08d7bdce5f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 10:50:35.8199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHQ1VjF4jKSlSYSC5Vf7WNwW2hSk7X5FXEaP3ONhacq5j0LbyZ43B+uvFFyHHZeIxuUYR9XmdgoKpYRD/rGufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5743
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
>=20
>=20
> In order to support parsing of NVIDIA Tegra Partition Table format, we
> need to know the BOOT_SIZE_MULT value of the Extended CSD register
> because
> NVIDIA's bootloader linearizes the boot0/boot1/main partitions into a
> single virtual space, and thus, all partition addresses are shifted by
> the size of boot0 + boot1 partitions.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/core/mmc.c   | 2 ++
>  include/linux/mmc/card.h | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f6912ded652d..88e5b4224d3c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -417,6 +417,8 @@ static int mmc_decode_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
>                 ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
>         card->ext_csd.raw_hc_erase_grp_size =3D
>                 ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
> +       card->ext_csd.raw_boot_mult =3D
> +               ext_csd[EXT_CSD_BOOT_MULT];
You might want at this point multiply it by 128K,
And get rid of: part_size =3D ext_csd[EXT_CSD_BOOT_MULT] << 17;
Below...

Thanks,
Avri
