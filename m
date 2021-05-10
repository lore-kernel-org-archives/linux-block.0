Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33672C43617
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99A061490
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhEJKp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 06:45:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34086 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhEJKmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 06:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620643298; x=1652179298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tPesVSfhAAkOQKv89Y/bnNcKLxWS0QTNcaCN84Elras=;
  b=g6bwo4XGCgu0ele1otW1gvjJvYrm2IM56N49ILM08663LreioYvc1nXB
   VkXFiKInxCqxZjawAyoolUopM+wIjnEmTzShV69NfkWlefy7bBPSUlQha
   Hpyt7NmA5ZOwXBWB31xaJqpUljmbbYXeiL1NZRSvK+VeJ8gMjol3ahoMo
   3ZKtPOWegmX4qEKWA9bHhKv3YYo+qHhUnollou2naG+MK/WZYsYOXas+u
   Kqth2tD5HRAFp/GmWL/7YmtEixVxI5TfBpkjMK1e7hHQ0KtFMWY6RBxzt
   0nTodQEDSDc75PLN6tA8PXVqwWXwUnD1F6LEve6r8WOvNFaTCe2LzJzfS
   A==;
IronPort-SDR: dO626D+qe7JfNuO9RaYBDytqi8zE0woQQ0EhT1WM/rLfaacxIVzoWVGr2qHDJRXzyOKRfAw7Hi
 0SIvGgahYBU/BcXoOTeJph2c1/JGFiqWpR8fSpWVYVyfMCbky02OLc8L6LqajvXmL05PxoNsxZ
 0y62vtMM6Ca5X6Lm0QO8vqo9CKbDDL+olcB3SaJGRlivSQxMSCO2J/9WbxverscHw0eLtcZvRn
 14UinTDrUaXFsFvHomP+cR8nbfNtA8A1AXeWIp9XGfUBErHV4QgOmB0aT9jMR6RSYN25h7zjK2
 R8w=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="172190042"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 18:41:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WInW6hxVGYPSi7ouC6gi4lOGwWhY35X9lgq3ok91SQrIp6rZbFXjiJzAhmoHUWq0HJVMbFpEUT+T5W+M9+3VBksaIvw0nlOm4VrgmMBvGREOlvlrY/CsPZILvtwup256WC8KB6XqeOoMY7xEaYIzwcjkM9kulI0dMwFzY8mvnin7UjO30AoDIL6KXai9eNGEhMN3P3HAEms4qzzwTPjjpsncnj6543eoLyGI9zYaAzZlxf4vOqgHWcuMNn3EsrSYnta9e9Blj0D8PyVVIq5nMAOQqdi3GCW+8UcXHoYn0+1+81ajTpY1saBx+9BKBpSir+rN/0EGpyuvLxl8Fmoehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEUJ9FU1bqV7YHn//mLhXxm63Sg8URrDwQWqZSB2KNA=;
 b=i4Q0RgqR/jcQ0iKHCXabwmPZAkjUDomEIRCBhbJbUof1dWWp5ele+ZujBZDXeR0Iru/wpPpZuHECb8QJT2SdwfD5+YcVRglobs6KYwWnNIIGf3x4NvJVs4roaEo40HcsdiU/Jnk5HBsTiW08FIA8QZwSpy9T0luuzG+xycfvsYTHVxIHTjLfQkxlzEKFmRJXFZZL5mKq111GNw1u/4VcxpNZGKjlV2qFsSOjlA6Se/6Bc1R5/+8mXi22KcOLYMxeojZNHMGto0mvGmc/d5d29nAkJ1Y2Adj99RJ2+71gIHRYMftyCLTgbNaIjFzngM8DzuHW+IJKB5YL9q8rl3yRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEUJ9FU1bqV7YHn//mLhXxm63Sg8URrDwQWqZSB2KNA=;
 b=wBKFVrje9vuKiuDueOHachCEMx3Q+bCBRVOdXOTPUg5r8Pl5iPU566zjFxfOH/D33XlBiGovRihX5ES9YcJRq56FLAVxZTPyrXE2GeNxhl+eME7sBGMGnDN7Dz+Yioh1JSnR250V5OqmN5S2Mj3wLrQU0hNF/t4Z6a8EDINIkkM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4153.namprd04.prod.outlook.com (2603:10b6:5:a0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Mon, 10 May 2021 10:41:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 10:41:34 +0000
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
Subject: RE: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
Thread-Topic: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
Thread-Index: AQHXQohQmJ5aCkIH3kCczJUde/3xEqrcbNXwgAAf84A=
Date:   Mon, 10 May 2021 10:41:34 +0000
Message-ID: <DM6PR04MB6575FC67AED514877921AC99FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org>
 <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdd1877a-76ed-40dd-3234-08d913a02e83
x-ms-traffictypediagnostic: DM6PR04MB4153:
x-microsoft-antispam-prvs: <DM6PR04MB4153C4182A1B6F5960754446FC549@DM6PR04MB4153.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PliomfHk3+hoivP9oNYWbtcRJKihsZliDyLhKdCnV3rP0nApH84MgTPNVX07cMSNHgqkwdTcRcbksN+UIY1xgwz4b2kq+RnvF/FTlxlT9wGzWEuD4uxTw/41TzVm2XmbMZjJVVf9LtzWEfqgtiOkQHZFLQ0Kikdzg6JJ+m0Paxy4MLPejyDF0u2QlD6O/S+uFHEMgNVvw9Zz3B/uXDS5uHDMSKqreUgtlxntLqVHGi0WJ/k50+b697sS8ryNpzKdKxI6Va7sWdkOpdWRpSq7BSGK1KOGKZR9QdqKMHVW2VaozJfiiql9nS49hAKugx1PebQLcm2kRqJ1RVBkZqdIwLzIEErwDOGE79RII9rUo5A+3sTw+a+zoALJbJ2zn+qNjuPTnzv+4NcaiSWHDTAFPj5cAQnFuk20jy9J6J0NopWF3nNthh7jIsaYP/JltXdggG1Dm3/B9hqiJ7P0rHMBIpFNWA8ZsDR2gNDyvVN8xk+voQk4guATub5ul6GX/PMW3OoXLWHHv/umNZCtQc1MBDkHOwoFCBzb92G+D+CefH6x9KxHWJJdvfBnPDZPt/xt4DYz5AZlJwchyXy+QPZYm5TrSKr4dpKLpYu/GaY/Ao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(76116006)(71200400001)(6506007)(498600001)(55016002)(83380400001)(52536014)(66556008)(66946007)(66446008)(64756008)(66476007)(2906002)(2940100002)(33656002)(5660300002)(7696005)(9686003)(26005)(4326008)(186003)(54906003)(110136005)(38100700002)(8936002)(122000001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?173bWsZecGbli7GtW0o27nqrpIUqa4Gu9EtIx/g63ie+RLIE7QMErO8a9w+6?=
 =?us-ascii?Q?3CZqqGjqRjVrdLjKXk3fXY9X4Bz/197OQgiWlUsiFq1IrjaTrU82A2O86ivq?=
 =?us-ascii?Q?lABzWgG0eqsdEXvD4UJiHBQZfUuscpDoQEf9EvZXtmKosZIu7zkepOjkank/?=
 =?us-ascii?Q?jXO6aEHcJlzqKO6z0dEtze3CLPXc9IaQcdzv2CTQd85lEscSQbk4cJXF9hAP?=
 =?us-ascii?Q?Oe9hfzuZkHEfVRL7GgDR74ijesExBLLjAs4iaKxmD7LNQ/n3CSN/PCyg26Ow?=
 =?us-ascii?Q?zTbl102pNw4tPr+t9ad6B4vb2zFBZhM+49baUyu0wTm2Rgv/Jo76vF5ahhnK?=
 =?us-ascii?Q?YX2r8/I+UN6pzKHp/D5rOfX/0TWj8va24ooB/suZ5TBasDN6NImxiFUMyTXl?=
 =?us-ascii?Q?vOb0xrLNSi8tt2bcX0DrcxEXIstYsF0mRv85z/sQbR1vQL/sC1cS+PPqWD/O?=
 =?us-ascii?Q?KUu4kAMrwxDLwoYY6pz4BteD00bYRQqKbNDlrF+7860iI/Y3H/oSOhd+CrHR?=
 =?us-ascii?Q?ccD7nDlKYjp31e5+mt5RaGh5qAD2fIlcEoabo8K3V8PRi8zOZhSeG601UQX7?=
 =?us-ascii?Q?CMwntHzLxWG5b61PZM6371h9L1qox07/8gkeps4cQMjv+3KrydVCs/StdUQj?=
 =?us-ascii?Q?hc2+3jVFuIUQ+Qkl2r+QvRdENGaK4/Cny4UTou2dVRYfGX2B2f2pkuspHK93?=
 =?us-ascii?Q?i3vr9xC9utfXqJM2IQJbueSqFO84xVI5darHooHV+KOrfRHv+HbEpE5XuShv?=
 =?us-ascii?Q?pBtc81jGEGaCLn8lsPPuYcY3UkoV8/JkS1zgAOz+TZq7q977LGNNZ5RLWhNt?=
 =?us-ascii?Q?D3ASCS07KqJJOWo2mPbE79IOOSZDFaTQfWz0Q6ImIQWBu2KEWMIdu37BR6d4?=
 =?us-ascii?Q?2Udp2UFdELRoErjkz4P2K3l/TboCWP0TL1Q/kC1PwYgbis0bvwVImMQxQXau?=
 =?us-ascii?Q?pho0lzTHIZA8PkIrGUkABRcMhW7IGtWSsWnA8spztfxmR1S4h7AElq3pGrR9?=
 =?us-ascii?Q?/KN1W8101SAzN+SVVIBQE9h4AYVZ4ZnBtrQCDG4qgdP5KYCqjipyBVpg848Z?=
 =?us-ascii?Q?Ch3qQhafp5zjiDxi7bW0kB+S0AmfQO+IxwJJaiwObCIBrOHriPb1B4PbeyOU?=
 =?us-ascii?Q?Nn4Rg4H2K5xis1beToEFAA1CBj0mAbgX1MWN5kKLsDSUC84+rdm/I71fwNGP?=
 =?us-ascii?Q?uQeeIfbD7UmdKku3IS2KGtgNdTfoLIv4QgwnzWPqv8wmFIUZR6aZ950Em393?=
 =?us-ascii?Q?Q8YK0PR7/vvv6KPW7yDjAoYjYYo/QcrKoAbE++OilnXbThGEw3h4DNQUCqRL?=
 =?us-ascii?Q?q0jzjPBi8SepKfbQrxuHu9Wd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd1877a-76ed-40dd-3234-08d913a02e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 10:41:34.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4N+D2Fzj956D9MKKfA+UB1GJ4w1cMUm5VymxUfPCfm1qIhzwvSjsa+07cAxiD1ytj0eM3CTke4S8PT6QneZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4153
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > +       if (!err)
> > +               card->ext_perf.feature_enabled |=3D SD_EXT_PERF_CACHE;
> Maybe
> If (err)
>     card->ext_perf.feature_enabled &=3D ~SD_EXT_PERF_CACHE;
>=20
> and move to out: to catch the sd_write_ext_reg err ?
Please ignore - got mixed up with card->ext_perf.feature_support...

Sorry,
Avri

>=20
> > +
> > +out:
> > +       kfree(reg_buf);
> > +       return err;
> > +}
> > +
> >  /*
> >   * Handle the detection and initialisation of a card.
> >   *
> > @@ -1442,6 +1531,13 @@ static int mmc_sd_init_card(struct mmc_host
> > *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       /* Enable internal SD cache if supported. */
> > +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> > +               err =3D sd_enable_cache(card);
> > +               if (err)
> > +                       goto free_card;
> If cache enablement failed, is it worthwhile to bail out?
> Maybe disabling the cache with the appropriate message is enough?
>=20
> > +       }
> > +
> >         if (host->cqe_ops && !host->cqe_enabled) {
> >                 err =3D host->cqe_ops->cqe_enable(host, card);
> >                 if (!err) {
> > @@ -1694,6 +1790,8 @@ static const struct mmc_bus_ops mmc_sd_ops =3D
> {
> >         .alive =3D mmc_sd_alive,
> >         .shutdown =3D mmc_sd_suspend,
> >         .hw_reset =3D mmc_sd_hw_reset,
> > +       .cache_enabled =3D sd_cache_enabled,
> > +       .flush_cache =3D sd_flush_cache,
> >  };
>=20
> I would expect 2 more patches in this series:
>  - flush cache on power down
>  - cache disablement events?
>=20
> Thanks,
> Avri
