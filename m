Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA8C43461
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE4610A7
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 09:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEJJMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 05:12:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63910 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEJJMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620637855; x=1652173855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0UatDq0cPR59uTEDCbLAG9gKc+ccVe88v2rsllIQ3ug=;
  b=gLXGOdBdLyTLtZkSj6Df3K+7b6G/ZZrNK5yImF7LEeSE+nj409mFc8n7
   hMJanb4GQHU4Ne0jcSu3ufM1M/psr3udxYxBISlFkj7FmGRQkmHjgOvxS
   MBNL5uUQs7rDZiQ5pxUu+Ierq6VIpPy/5EJZGILKjugcod0rYAAuimI5Q
   SgDV/72EuPCx2aDh0wdYVfUi30/gzEhv+S25guR8f0eaa3dIGc0xsvMtp
   e8BHlst05A70xOFP/wb7WA0occ2YIy8A0M5Q1J12gj1DjR9j+Jq7Lb+rS
   GouonW2osE6dZDdT+mHaCInVd9NjLjRJnSV+KYoloZk2ORPQAMZA0tDXh
   A==;
IronPort-SDR: X14JhFRFGlxO715+HiWYBlY97qarQ8gibmEDoqlevPhhrK0jjeR6zbyIwtehT2EiR3sYVgvYHy
 dSZ72H+4n8d1PpTIlBektQ7bVtSp8ZOOjzRKSRc3Gi0XhZIxlYimxaMeFpEgkqY4ANv4g+SEAv
 klHNOrpt3s9uuSXckFZU98XTSLDvIiN3ZAHB5k6S4kYrOkxcG2AYEsomjdHKjdBhg0i42KEVl1
 7RkWN3Z/9iH2BjtUIXRhk/ZVS7Gdv+HQncNVoKSygaF9XT3pNI74I6lhH+EmKoIjaA6qt565C2
 uw4=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="166947287"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 17:10:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itWVucjeiXK2B6BzhK9oOVMAMwrFwZ5Hsho26j6LOGpW0GY07w/iiTym6WaBUugXnXf9MwnegV4nUYDs3lRSV0SNwxsLciJlmjKJxx74YycwNuLbYvGMv3kiP+KvCRiq06NWiSmc/+tUUvfTOqDgNjKfWxezLjxG2Ze131Q4XuSfKOYJak3EbLFcNYYQyDLnFC5JMZkpYGFR+r7p4ZNyk+rR/+1eSYAKqYh10CXbSjgOOzz4pgmkAkR7VTjZSs2FxPMbiBegd0pZmNVFVRLHsh4qiGPqRDApQFokDUTCB2SX8wd11Jag437gF8Qxp+VWzumZP0/SQAcK4fbSsKyDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTsU3E6VXJic0qk73S0C6h2OjPTgvj5kH/7jEUJhZII=;
 b=Z3yFYvVXlTStPE8bN/plUUDRMxWiC9AqWui5ySBaLyBhbXL2pwwel2DfLQ8EqqzsjGDqSHuwIt4Aeu/TlCk7Y/EIxZA1vaV9YrP+BN49g2t2zThLcSJ2MIeJeS2pVEa2LhkFAiMz8qOxeRBm8b4l5X2vL6+H5lkkY9nnlucn+KCfvhs/Sa4NhoJsNQm2WXJm+5RAkQpBzhoMhNKsWX2VxwJgg1sx7TG1raW2PCVyly5gQBm7PA6ep+qaRhyXzzniSbiqon3DzndEOq9pu2MWLi3V+sf59ulUhjDF0pjKYeqcsKV0gkK339NnVyQaQNvd/Eo1PwhNgvVWwt4eGsNZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTsU3E6VXJic0qk73S0C6h2OjPTgvj5kH/7jEUJhZII=;
 b=O02S57ZrskRThMXP487Haq3FFXnAMEj0VdJ1LoRki1sjadvOL2e9Qtuem5pljZcD8XKOx+TCOHjphPhnwFoxD4SYkm7iX/w3G1Zw85csk50qRLhUNz3qFjsQXBeay4OMAbqQpCsY8JrhaF2HQn69tr3hga38rLQeYCdq8PPynfw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7003.namprd04.prod.outlook.com (2603:10b6:5:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Mon, 10 May 2021 09:10:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 09:10:52 +0000
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
Thread-Index: AQHXQohQmJ5aCkIH3kCczJUde/3xEqrcbNXw
Date:   Mon, 10 May 2021 09:10:52 +0000
Message-ID: <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-3-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60b73d47-c1c6-4350-63e2-08d9139382e4
x-ms-traffictypediagnostic: DM6PR04MB7003:
x-microsoft-antispam-prvs: <DM6PR04MB700380E2999DB8FA6A36FC51FC549@DM6PR04MB7003.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWO5+L+pThWP2PuxG9ogStgBmHwv0vKL/o1SM+OI9di5Z40XgaG63Ws60mWztXcHZlCrSrXrewgsrFcTVB4Bb0LbUHF8PE4DeQ14ONU3KIphbFZuhkc0IoAQLS+mpA6P5815aBt1B1W5/oiqJlR0XuyNoCuTmaPCpa4//vHEmyy7NpMqNOjOekMcoDcIFK/CCDw9h7XhdYhm8b/wyR8U/kNu5YkuV9sN9QCWzzDs92xausve0I1hQz8YhjGuAZfKzakyf+nZNU5aU7aQK/8Ann5peKmtp+CZOC8eZwU/0U75orU6aCP8TL6IaEWSxYViSnzN9ZOQbzlyB1oWdIe551X7j0Cy3kIv01k1BkXIFgkOY0RrJ4nVOdeHYZA7KbbdXY+kPHbKY9k9NafPpZ8rW3gTzz0TkUwnNtH6dpRn1jVYwmGqd1dCC+DO0PJ6hbk7hcEo00NRdSfeQzrO3ZvrKJD46vvtfhO087fFmOWM/VVAqZgjkzD/cPxSGRZoYQD9kdoWYDNUDiXw/tumSnkKK4Bn7ovMTubAn3wFTiNHi4uaRm8g+wL3VzHDIJsGlANrUnTKT7CeoLSnQQGh9y+WENwrc+T1wbZoAgZu3RoesJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(52536014)(478600001)(5660300002)(33656002)(83380400001)(71200400001)(316002)(8936002)(8676002)(122000001)(4326008)(86362001)(26005)(38100700002)(54906003)(6506007)(64756008)(66946007)(66556008)(66446008)(2906002)(9686003)(76116006)(110136005)(186003)(55016002)(66476007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bL547ayNwgmbGQpY4V8nL582QB86iOc/4njJxsWUXy3eQ1DXPlRGtOmW2Wn3?=
 =?us-ascii?Q?mgyBYYMhGsoacDICppjj3EptFjyXgbWnl1atrb8YYzEv67n2XLBm468mc0wd?=
 =?us-ascii?Q?XA+fnP1ih7hVehg5iRm3b2MIUFJ/ZzKoq3ndI5+knRjGARnKAlHE7EyezFSG?=
 =?us-ascii?Q?+rDvPdRy0Gs3z1hb7ypi43K/dhaDFHJeSl0xSg4DiWWM+QCR8Fz3qsOaj5dO?=
 =?us-ascii?Q?mIyP/Ny1dErQg/I387y1DFNYk1YqtvwicNvTr4R+yoBa6PWmNnXsQifww1ie?=
 =?us-ascii?Q?XXQKYShQvJOzsn9lezOLRcsPSYvD33JbdsrkclulanCs0hrVEx6yvCVcNh66?=
 =?us-ascii?Q?vaMLssPHjbBko7sfoKuYWE79i7DpFOoS0vsfTHgsrlqhroQSZCEdg4/yHbJ7?=
 =?us-ascii?Q?WIZu8OoINzae2i7XKe3KgosEnHl5cejzPC2v+zt+NnsG3+HJ9w0j/WYB8NHO?=
 =?us-ascii?Q?FfbGdcdA+/evjpUsJEhEOPUv3RQwMcn3iv6IbsmKgXEM/d0wO11Q1uYIcAw2?=
 =?us-ascii?Q?3D5kkcfVLyPO0DIuH3WB7rO3g6yJsdMEpg1NLrSc/CImRGXwSd+rpq+ikqLb?=
 =?us-ascii?Q?jbPiGjlvlFjDQaF9FRYkWkAtDsOzKdbvXNQEWUTF2x5dG9XtLRKt6aKFk8sR?=
 =?us-ascii?Q?trGOaGYNowgIp8lmjGMgYAeXENU5Y561xFELVFzxvkgjB7YEyTM3HZCsMFy9?=
 =?us-ascii?Q?2eB2i//vVTN8cQdnA49kXkg78WIv/WZrwi8z5u1q3sV4/f21zI7b0LWEndjA?=
 =?us-ascii?Q?reSFbt+116H0waAlEwcrWpOEmP2K5s/KD5CNfs7VUgVBcdPbndTbup/IwqZ6?=
 =?us-ascii?Q?ZKgV1vDdMaBIxbdZDtUlDxfOXRItknvf539Urwd6QttBARAlAl9cwVKR1YIu?=
 =?us-ascii?Q?oVUQMc+R/AIYVSv8fA0/RPuaJ4OlS9TD0A09v5mExEB1YIIiGFnmK1d6epw6?=
 =?us-ascii?Q?xlPgxixDQMqikcRT2btq7lKdUUapSxhUhdCwJRexIr92j9rQu7Ubqk99HYTB?=
 =?us-ascii?Q?gXRTqS8f/ct5sLEASVolXDPXSKULNWl9ZGjexs74B3rJyWfzz1Ka4ylcXpnW?=
 =?us-ascii?Q?0z5ytFWUQQ+jsbklyL/4mM5yQoJlLinaV4+zSWkC/7/QGcfS3Ys8+KDsx9Mg?=
 =?us-ascii?Q?XqcvfpD/MGOJtKPaeN5nA6d06ZkXrXh+B16vHaCTMy1qRJ39UY3kvXB78z+v?=
 =?us-ascii?Q?/ZVElIspdQymklzx3JwXrkkOA/QG6c43dqG0qHfagx/AMLnTPKzoP13Dgnj4?=
 =?us-ascii?Q?alTPtEsPhh85D5U1RntLqbXfEyOdLkb/FNmUiGIMTXkxTHUww9PZBkHUxppg?=
 =?us-ascii?Q?l6iK01dn7MtUssuvN+zC/ExH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b73d47-c1c6-4350-63e2-08d9139382e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 09:10:52.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiFB0rfpOun3BM7HGnSPpTs90R1RyLLjfkON3E6Q2JIybbmn8SU3IF0XLw9SOvcMM+Blbod2MnI2T/rMwJzd6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7003
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int sd_enable_cache(struct mmc_card *card)
> +{
> +       u8 *reg_buf;
> +       int err;
> +
> +       reg_buf =3D kzalloc(512, GFP_KERNEL);
> +       if (!reg_buf)
> +               return -ENOMEM;
> +
> +       /*
> +        * Set the Cache Enable bit in the performance enhancement regist=
er at
> +        * 260 bytes offset.
> +        */
> +       err =3D sd_write_ext_reg(card, card->ext_perf.fno, card->ext_perf=
.page,
> +                              card->ext_perf.offset + 260, 0x1);
> +       if (err) {
> +               pr_warn("%s: error %d writing Cache Enable bit\n",
> +                       mmc_hostname(card->host), err);
> +               goto out;
> +       }
> +
> +       err =3D mmc_poll_for_busy(card,
> SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> +                               MMC_BUSY_EXTR_SINGLE);
I think 1sec is for flush cache, but I guess it makes sense to use it here =
as well.

> +       if (!err)
> +               card->ext_perf.feature_enabled |=3D SD_EXT_PERF_CACHE;
Maybe=20
If (err)
    card->ext_perf.feature_enabled &=3D ~SD_EXT_PERF_CACHE;

and move to out: to catch the sd_write_ext_reg err ?

> +
> +out:
> +       kfree(reg_buf);
> +       return err;
> +}
> +
>  /*
>   * Handle the detection and initialisation of a card.
>   *
> @@ -1442,6 +1531,13 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
>                         goto free_card;
>         }
>=20
> +       /* Enable internal SD cache if supported. */
> +       if (card->ext_perf.feature_support & SD_EXT_PERF_CACHE) {
> +               err =3D sd_enable_cache(card);
> +               if (err)
> +                       goto free_card;
If cache enablement failed, is it worthwhile to bail out?
Maybe disabling the cache with the appropriate message is enough?

> +       }
> +
>         if (host->cqe_ops && !host->cqe_enabled) {
>                 err =3D host->cqe_ops->cqe_enable(host, card);
>                 if (!err) {
> @@ -1694,6 +1790,8 @@ static const struct mmc_bus_ops mmc_sd_ops =3D {
>         .alive =3D mmc_sd_alive,
>         .shutdown =3D mmc_sd_suspend,
>         .hw_reset =3D mmc_sd_hw_reset,
> +       .cache_enabled =3D sd_cache_enabled,
> +       .flush_cache =3D sd_flush_cache,
>  };

I would expect 2 more patches in this series:
 - flush cache on power down
 - cache disablement events?

Thanks,
Avri
