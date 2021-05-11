Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2897FC43460
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E303861164
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEKKl4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 06:41:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29115 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhEKKlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 06:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620729650; x=1652265650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s60RrmgK5qWoeoxfWvCL13PL81mrj7EBwbvjfqLKXBw=;
  b=CQxv98QEbkBADLC0yl5YrkCbDsaEAsnrHwbpkzeZBtAIj+6mazNusitF
   nmSPufLF+LXke1KQRY4734/Aacqk6cx0TiTt94451oP0QNQL8HOrwol9Y
   R45mCSa6A4mYxdiYvpghFZnCjzG/aXx7BvrFET0s6gG6UYmiYPP26EOKI
   1t30uTPzz92TDHtgyRld6CrtSrgVq9W4YtNqRkg+b33GkBQwrq8meegC4
   HNOYFO1nuZT6mZeabF5CPNaymYUshqy6K8KAK9iiTtHMI4Va0G7DUsnXt
   ixetX6aos4A6ShcqsblwCGssrahec7lh1dR+ebjGOX4ZMSuAAMRUVOUHZ
   Q==;
IronPort-SDR: 3MI0K9h6GZh9uvjfTZwv5KzJwKqgWkkRMdhEgb4ecZYgx22q+6+/NmSwu2n8BbYGUIioGQexrv
 M9WsbX4Evf620oilXvJNe9JtNwHnZ4FbI1QgcOVaUDYLy/UlrUnP5p4flwMAyN6wCY2tbj/edN
 JWbVAypGrRAccKp6yQBfmJUhEpRQjD44j7XGVmg6kFGtkBdjRG7Jz31IfZz+wjheXHeV4tazKw
 eKGvYGNHfj2IrcEfVfsC/f3OcP4G2Fahp3u6FVb+KqZXj91LW5vvxxRvLKpLTaitOh5Es5Hedt
 Y5Y=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="271724332"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 18:40:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl657quUMBZ4qiB+xURergCnPomf7+8gH2yIyLL0sQ5cZ+HtzVTIdbWL8zygbxTFuZhHGIrZpiwB0+USDqIJGDVEXQvZWQgQf2wdZcWGvU91qD0Bm+//C9UpCapBaQ9KYzcPHQe4hmJdgVQ1fixEuTfPWjs57Vw0tmtdlINw1CNH0j2lRBchogiV4hOc3FhjAFgKrHWggAJTBlsydGSd+yvhHYRQSrViTcsDV6Zv9gPVFtPV+HbVDJMopQpvITbwBPusxBRxuOIT+J53zBVtTHyPoaCBz7zaXAIIw9ldCD5W3b29hhI68oo1foD1ZqPcZxQQzlPaTubz2FzYI8/fAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ap1wnCmayI9lNkrX+9N4ystnKY69ImfkNX6+o6awMA=;
 b=T4bOdRJ5zk9GgkrTmFgz7IdIW2rTfhtsLXyIRPV380XIHq+RsnGP4mCEUdnEgp0paLkNk9A0uEkjmedk+Sp+thmVMv6J59nQSau/JhdppNxJ9+iKk98DJRXw2wtp7wBqe0/thJdx+bB5W8StOIUqjFyulXWbxs2Lhw4VC44xsD46gXfsimPk/lJOB6QRRmGaH4rcaYyOX5Hq3xZu+/suHlPSGE3IOHtXkTqqcp4NTFc1ByW6BHpmI9wCpvam/5lt2al3+iPA7w95F+jbMqZI9r2gwViUP6a7NElD22W1ivobTsBbz906zo6tnRuKMWUQMoVM+Ide909/ljkCSifsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ap1wnCmayI9lNkrX+9N4ystnKY69ImfkNX6+o6awMA=;
 b=DN7IjNCtZ6q7li3tYPHDa2gl8VEEhxtJLaQzcvFSLcCONi6QLnFsTogVivrjSAqu42CU1sm4c4/T60kVBT5LMYgfcn5vqD5BsXRovel2uU3chLgF5mTOQxVRk+T3620t1ASwB7Ca5IokEOOis3qLeefYmH/FXnXHKMpTTlXzQlI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5946.namprd04.prod.outlook.com (2603:10b6:5:161::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30; Tue, 11 May 2021 10:40:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 10:40:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: Add support for cache ctrl for SD cards
Thread-Topic: [PATCH v2] mmc: core: Add support for cache ctrl for SD cards
Thread-Index: AQHXRk5iDCVW9pafXEqO5n4u03P0lareFyjA
Date:   Tue, 11 May 2021 10:40:41 +0000
Message-ID: <DM6PR04MB6575686B680A115571EBB015FC539@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210511101359.83521-1-ulf.hansson@linaro.org>
In-Reply-To: <20210511101359.83521-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ba9a2ea-9e47-4ded-c6e3-08d914693963
x-ms-traffictypediagnostic: DM6PR04MB5946:
x-microsoft-antispam-prvs: <DM6PR04MB594699F3C8A565E6EEB2E5F2FC539@DM6PR04MB5946.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzaiUuiZrKkoFxkv0vv/yJYpSYGQ8odMdrrzZuerRJIzL+mjJlPonNb6KHiIsy+LyqhFxynntvTB0ZKxJAhRexNwrbPFA9t9sX0uk5mUg88ZVYYlM1S+W0XkdabT6JullLZ8Q1GjP/+BlNKawOek7ADaR+7WPGoE+bJdT1ud430Z+p46FEDZ9NLk/yYHrj+1zCLkCp1f4Z2P5ShMR6lCPPxlUt5jvyOmqrMJgt9k28JzuXzVttX3eKGu0/AGH3u86RHFrmXopfFXGV92DHX1IuYiy9jdE/w6x8AAxAprfBq8IiICZQ5hJAbjJ/t5OIEOH1ujQ92rnodo0yLCr+xh5T2rTmVvdJ3gJXon8OxtSWIqY7txCo/K1Agee0i/FkoatnWqu2rNrYQSC3H+Qc6LhclINc1krv3+ubdhkSA7bEwSM5xgLQoVFLOVyoJSHrtbYaA0DIfPoSpZg3/UmhtsZ8mFYGx7SqSdO/XtQ3F+2t44wbbNjTmQ4fbszLYJpr6uXOrlZeySptVmm2XuLybal2auXskZyxnMz4mHWPQXCQSwhyVr/T/Lcido9RsoTTkirQLRmEr0x8LDNaPt/oJudk0cfJhZ4JqZdyUn20VqRwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(71200400001)(52536014)(54906003)(110136005)(7696005)(316002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(38100700002)(2906002)(83380400001)(122000001)(5660300002)(33656002)(4326008)(9686003)(478600001)(186003)(86362001)(26005)(8936002)(8676002)(55016002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jHnavlRO7wimLexWHMwsXZecW/j6tWiW6jvcNMI3imiLTjnsg2gi2WVQNzFX?=
 =?us-ascii?Q?z0ZViW0c+B2KVcGvmfzrKRowjf5CLbG9RlGcsuIsLzT1qDlQcKr00p4e3Zh4?=
 =?us-ascii?Q?vkKee/yX4wKzZw3t2tBBqnsGuouMPB+rlHAi9JLQ0t4Q+HRWIEtCvMIvBKO5?=
 =?us-ascii?Q?VVZkRv0FJcsm7LoT1ZlrKT8ZljUtQB9elKc4g8S8PDOULLz8fmPHMUzd1/qX?=
 =?us-ascii?Q?7fEpNmC3+4YtKu6bN4+KFDZ1SrhKrwwqU1QtLyfE+GabO8yBlNGtwYZnIaWa?=
 =?us-ascii?Q?L5QUhTJnD7ZWuSHRbr/DOwuQxyiPbqUrIXDyLhQX8O3O7PHjLgzx7xARa9Pm?=
 =?us-ascii?Q?KiudJyWbxwYwl5znRPPZVBZ07KwCWNs4EXNSEBDBeU3aC1Vm3YwoIbV48pqf?=
 =?us-ascii?Q?LdUoIpVOTPivk7WdpBp9hKCXxvXmefUGawWrZNd3y4ieCfxfD2iHOR7RrIea?=
 =?us-ascii?Q?80nUjASDxfZKD1Wlz9JeCBxqILSi/xAatTk07mdquBtFJF7GOci1B4+FMWXL?=
 =?us-ascii?Q?XT5HzwSt2BJ/MEDEPjOtIDgIUhpRrcvTbISHjyBC18mkruNwyFPaeUt5lRzA?=
 =?us-ascii?Q?1QQoJ/Cwy2nEpK5dIAWknDPOvomxnQbnVGkH3fS2WJtewL38Mi3KAGbGh/Ey?=
 =?us-ascii?Q?vBUf7XJi6C1rEwSsXo1vFe4cHwGIoIrccGYSoj8x/AvUlNlQ0M3ZvxGJcjmB?=
 =?us-ascii?Q?r0GXhWN5WZq1URDGpAgCvosw6hp0ua5ENXNQlAIsZfLJdQbyG9Aw4S0m+OP4?=
 =?us-ascii?Q?jeVKu9aXvJXMUSf/SQoMTexK7SKeYlDmMZTiMcKdWKJwRows/88gqn9bKsqS?=
 =?us-ascii?Q?9An9My0bvXWfAFjjt5EgudQf+dI0Q/NN20cc88AfX1AaOwzo+ys8AZvyYNAn?=
 =?us-ascii?Q?b8cgQpJb0s0439+1o1ZRUQYCo9SaI52OtzF1R7f2hBkwHwjtfrSONUWowpIc?=
 =?us-ascii?Q?oe21Td3l9Ns/RH3t1GLmXpmRcRBbx0Rfq0FdmX4r72s4SdgA60HAnlVbVfEl?=
 =?us-ascii?Q?KsTxkUfckOcc0J2P74tk4AlMaLgzViIFkYpPFCskds08wckKp12FLpuNNE9/?=
 =?us-ascii?Q?rnAtgrr8MOAjfNcOw2c16eFv/glt0JxEJiw1HEO6wnLc6Z9P09PUNYtaZ32k?=
 =?us-ascii?Q?yEXNqUGF8XQb34u0MAMFI4YTcchD8cB2mFuXH4Hz959MHRTykVOwjck3GIGD?=
 =?us-ascii?Q?dXKhHZaSK10yyiEFFeyoC3cf9vj16Mue97/SED45fdUBevRfNV/kExHvnady?=
 =?us-ascii?Q?AVyAEZHVk8NSZgk7QoyePiU7Pqq0oCtUz8Yq6biweyd73aoNE0f7Cc9UuUqe?=
 =?us-ascii?Q?vxwnSPBUgZq8ZGlXwro+dwNj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9a2ea-9e47-4ded-c6e3-08d914693963
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 10:40:41.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1++FKRLpngZRmCrJRuGp1a/hj2F39DjrrbT8InlwLFye/YH6KZaR/A7KdLESUOo7X+sY8ggzDkFLYWOA9YHR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5946
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> In SD spec v6.x the SD function extension registers for performance
> enhancements were introduced. As a part of this an optional internal cach=
e
> on the SD card, can be used to improve performance.
>=20
> The let the SD card use the cache, the host needs to enable it and manage
> flushing of the cache, so let's add support for this.
>=20
> Note that for an SD card supporting the cache it's mandatory for it, to
> also support the poweroff notification feature. According to the SD spec,
> if the cache has been enabled and a poweroff notification is sent to the
> card, that implicitly also means that the card should flush its internal
> cache. Therefore, dealing with cache flushing for REQ_OP_FLUSH block
> requests is sufficient.
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>=20
> Changes in v2:
>  - Converted to use the BIT() macro for clarification, as suggested by Li=
nus.
>  - Reset SD_EXT_PERF_CACHE bit when cache enable fails, as suggested by
> Avri.
>=20
> Note that:
>  - I decided to keep the error path when failing to enable the cache. It'=
s
> seems more robust, as it's unclear what happens with the SD card at failu=
re.
> Additionally, if improvements are needed we can make it on top.
>=20
> ---
>  drivers/mmc/core/mmc_ops.c |   1 +
>  drivers/mmc/core/mmc_ops.h |   1 +
>  drivers/mmc/core/sd.c      | 100
> +++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h   |   1 +
>  4 files changed, 103 insertions(+)
>=20
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index af423acc4c88..3c58f6d0f482 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -456,6 +456,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>                 err =3D R1_STATUS(status) ? -EIO : 0;
>                 break;
>         case MMC_BUSY_HPI:
> +       case MMC_BUSY_EXTR_SINGLE:
>                 break;
>         default:
>                 err =3D -EINVAL;
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index c3c1d9c2577e..41ab4f573a31 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -14,6 +14,7 @@ enum mmc_busy_cmd {
>         MMC_BUSY_CMD6,
>         MMC_BUSY_ERASE,
>         MMC_BUSY_HPI,
> +       MMC_BUSY_EXTR_SINGLE,
>  };
>=20
>  struct mmc_host;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index bd40c682d264..781c1e24308c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -67,6 +67,7 @@ static const unsigned int sd_au_size[] =3D {
>         })
>=20
>  #define SD_POWEROFF_NOTIFY_TIMEOUT_MS 2000
> +#define SD_WRITE_EXTR_SINGLE_TIMEOUT_MS 1000
>=20
>  struct sd_busy_data {
>         struct mmc_card *card;
> @@ -1287,6 +1288,96 @@ static int sd_read_ext_regs(struct mmc_card
> *card)
>         return err;
>  }
>=20
> +static bool sd_cache_enabled(struct mmc_host *host)
> +{
> +       return host->card->ext_perf.feature_enabled & SD_EXT_PERF_CACHE;
> +}
> +
> +static int sd_flush_cache(struct mmc_host *host)
> +{
> +       struct mmc_card *card =3D host->card;
> +       u8 *reg_buf, fno, page;
> +       u16 offset;
> +       int err;
> +
> +       if (!sd_cache_enabled(host))
> +               return 0;
> +
> +       reg_buf =3D kzalloc(512, GFP_KERNEL);
> +       if (!reg_buf)
> +               return -ENOMEM;
> +
> +       /*
> +        * Set Flush Cache at bit 0 in the performance enhancement regist=
er at
> +        * 261 bytes offset.
> +        */
> +       fno =3D card->ext_perf.fno;
> +       page =3D card->ext_perf.page;
> +       offset =3D card->ext_perf.offset + 261;
> +
> +       err =3D sd_write_ext_reg(card, fno, page, offset, BIT(0));
> +       if (err) {
> +               pr_warn("%s: error %d writing Cache Flush bit\n",
> +                       mmc_hostname(host), err);
> +               goto out;
> +       }
> +
> +       err =3D mmc_poll_for_busy(card,
> SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> +                               MMC_BUSY_EXTR_SINGLE);
> +       if (err)
> +               goto out;
> +
> +       /*
> +        * Read the Flush Cache bit. The card shall reset it, to confirm =
that
> +        * it's has completed the flushing of the cache.
> +        */
> +       err =3D sd_read_ext_reg(card, fno, page, offset, 1, reg_buf);
> +       if (err) {
> +               pr_warn("%s: error %d reading Cache Flush bit\n",
> +                       mmc_hostname(host), err);
> +               goto out;
> +       }
> +
> +       if (reg_buf[0] & BIT(0))
> +               err =3D -ETIMEDOUT;
> +out:
> +       kfree(reg_buf);
> +       return err;
> +}
> +
> +static int sd_enable_cache(struct mmc_card *card)
> +{
> +       u8 *reg_buf;
> +       int err;
> +
> +       card->ext_perf.feature_enabled &=3D ~SD_EXT_PERF_CACHE;
> +
> +       reg_buf =3D kzalloc(512, GFP_KERNEL);
> +       if (!reg_buf)
> +               return -ENOMEM;
> +
> +       /*
> +        * Set Cache Enable at bit 0 in the performance enhancement regis=
ter at
> +        * 260 bytes offset.
> +        */
> +       err =3D sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf=
.page,
> +                              card->ext_perf.offset + 260, BIT(0));
> +       if (err) {
> +               pr_warn("%s: error %d writing Cache Enable bit\n",
> +                       mmc_hostname(card->host), err);
> +               goto out;
> +       }
> +
> +       err =3D mmc_poll_for_busy(card,
> SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> +                               MMC_BUSY_EXTR_SINGLE);
> +       if (!err)
> +               card->ext_perf.feature_enabled |=3D SD_EXT_PERF_CACHE;
> +
> +out:
> +       kfree(reg_buf);
> +       return err;
> +}
> +
>  /*
>   * Handle the detection and initialisation of a card.
>   *
> @@ -1442,6 +1533,13 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
>                         goto free_card;
>         }
>=20
> +       /* Enable internal SD cache if supported. */
> +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> +               err =3D sd_enable_cache(card);
> +               if (err)
> +                       goto free_card;
> +       }
> +
>         if (host->cqe_ops && !host->cqe_enabled) {
>                 err =3D host->cqe_ops->cqe_enable(host, card);
>                 if (!err) {
> @@ -1694,6 +1792,8 @@ static const struct mmc_bus_ops mmc_sd_ops =3D {
>         .alive =3D mmc_sd_alive,
>         .shutdown =3D mmc_sd_suspend,
>         .hw_reset =3D mmc_sd_hw_reset,
> +       .cache_enabled =3D sd_cache_enabled,
> +       .flush_cache =3D sd_flush_cache,
>  };
>=20
>  /*
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 2867af0635f8..74e6c0624d27 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -196,6 +196,7 @@ struct sd_ext_reg {
>         u8                      page;
>         u16                     offset;
>         u8                      rev;
> +       u8                      feature_enabled;
>         u8                      feature_support;
>  /* Power Management Function. */
>  #define SD_EXT_POWER_OFF_NOTIFY        (1<<0)
> --
> 2.25.1

