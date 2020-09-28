Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4418C4346E
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 02:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A8523119
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 02:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bc4jl4V9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Er3n0jGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI1C6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 22:58:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27554 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1C6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 22:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601261881; x=1632797881;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ViAg2eCDuUm9fCtH1ACY1Y7v/2T6nlbGDyJAIiDvVpQ=;
  b=Bc4jl4V9yMNFD4+gh6/i6XpQ4rRtX8aOxBzw4X6bRYYke8DVO2xQ42/n
   QvU7cRpWvE8Xfzopg8dPw7STStX4Fu7M2lBu0etYK9p1q8tn9S+9oNYwn
   Yi4WFPEYEX20tmcBuFsFUR6PjF7LsTcSnnsruKkmm2zyXO9mOgbXfDZca
   26VlMDDRD9wcsLvqv2F892vRO/+ecureIP/b+M7z77z7YEVt9A5ITwjXa
   kzeuKpP8kxkVsiyCV5LlIQSmIyEkY31MOtHOM7eyOB1lJlGzQwWZPB+KI
   12ku36AISt5U9gYHW1JAMQ3qeT20kGK/ISGBGrYwqAjiSBjpyJT+vsvZk
   g==;
IronPort-SDR: J/pFGiUWRIiKhy9vqB/LBMSCMijHi48kuqIX8pDUralfrCBkIAcZmQUxQoQhkhKYMduw45RUGY
 /LNFtxY6NdR9M/NCjbADW4LJDuCEtOtq/SG2GgiOK5j16DdpHfcL21PYTOitm2kz5wpuaeP01l
 GRCDkF1L6K8X6UqtCNfA2xdetbmEmMHHlRDFY4SgKQNg6X+HRB2udVRcVWzyTmbjiINGErlm3C
 fRVshZLj7jZYaWDZWQEdOFLRw9QaKTubRLjQycJZ99EJvF/ClC5J11zSPdQ3cvWjQVj3ZShN2x
 5as=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; 
   d="scan'208";a="148425353"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:58:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VITWII/1BvIjEkhwE/jIt3gUxTTh6LQKZkR2itQGpUV77rap8j90PyefGmuZ6w1uQ+8aOzzVjUf2EQ7gKk2tMlMXHDMXNQwPTpbRC/pkVOqn6HMwWkCGz8ZIn/3hC22Fhnw9CoDkfY0eCiqhulmtIsRGTktT9sLFTytyOJQvRHlpQVvQ56oeI5sr/RzntCY/6svCRs8HxCHPvzJRZdpKyVAAKnFscuNgv7fxTE9MlCVUxBaOQS1JnBl/twFVobVucjD+7ySeEciIMONaFVdpPhpIPbFq059plpvuVNzrstq7CXB9JpzR1Yg45h3y5S52B0+1goHzfp/XNXoS8IP+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScVvKCt7XfrW1aoYmtBtSRUkeYRrtc9eOlk8uoTuPco=;
 b=SPwCFOqMSHUN80nHA4YSxieNgst+7F2L2t9N9uWRsy9X5v4VPj3SOGDjnxSlJCbYZgYJAB1KPXQdRfLtb8luQ6hhqQccJPrJXiM30m2fA0kSg7HEBRPRe2Jxw6oX/b6lCSW8S1pDksHZ7eVlIRcntN8WcWd2eAqkCxpLJfeaXY9yrRKammCEb9bTy9TbppZROOy6Mu1BrkuS/TEAJ9s+sgyS8VreOmFiFs/g2BRnb/JrW7468M9Do3o+voTb/gPlFxrGRLfIeIhdSOI2KPPynOllYxfnjqML2frODSLXjMdRpA8gW2kMtxeaQYBODsLCfAvZLQLbJfvTBCc1hXwi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScVvKCt7XfrW1aoYmtBtSRUkeYRrtc9eOlk8uoTuPco=;
 b=Er3n0jGiktxKBVHhOrN3AGvJzwYl8p5OqUrK4N46v99wyq93zrM2KGQ5IFx9pw3WJeewIiTkaUKsImSYAlXncw758cRkUmLlo/iTWoGtHKay+wZO6q6HWbZoyB9900XoV0736MHyac11anKqVUaoE0EjEUi9OznSjyj9Gwy0Gyw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2313.namprd04.prod.outlook.com (2a01:111:e400:c60e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 02:57:59 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:57:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix a typo for skd_main.c
Thread-Topic: [PATCH] block: fix a typo for skd_main.c
Thread-Index: AQHWk6p2onDsXA7IX0SNWou/lLgP8A==
Date:   Mon, 28 Sep 2020 02:57:59 +0000
Message-ID: <CY4PR04MB375129B151BF9E9F9A7364A9E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <1601086321-1173-1-git-send-email-wangqing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2cd5395-d915-4438-a000-08d8635a4eec
x-ms-traffictypediagnostic: CY1PR04MB2313:
x-microsoft-antispam-prvs: <CY1PR04MB23131FD69CD614443E513BC6E7350@CY1PR04MB2313.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvyLzi8kB9tAxlr/FHNHZO0i5JjxHJ6YUJmQT4QmkodqzVNqD1ZyEaB5IkHFasnm0vYd0g82LUSXdSK4aSBiCobDBnCMAt5nvNHN9a5RPg+yHWHtNzIozTy7r7n5aKK1vfeNJKIvUUrmwuPpK3e9tDL24B0nGnscOQRFjwITwqgnbIpBmoYVT/7IknRREQbiOt90m2PG8hTR5kD6uT97yz2jlzA8dZ3gqO3fGobrqoQ9G6wbHapqbldXb+/U0dmXHkeThlguXYdNwaRvlTNJNmbynjPZUaqpsF7ys2Ewcy62SYrY7FIVDG0WPNIZU2gRjo+waI76Z58LmsZp9ebf1e61Uiexxe198TQNCkSpw+q2KbMbGolXH/OiHH4677pX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(6506007)(71200400001)(52536014)(66446008)(64756008)(66556008)(66476007)(83380400001)(33656002)(91956017)(66946007)(76116006)(4744005)(5660300002)(55016002)(186003)(8676002)(86362001)(53546011)(7696005)(9686003)(2906002)(110136005)(478600001)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /u2BpsoflwKzRuxDglXmL8xskscPcEEBuJr8BB/1OMdpf/DOYyhmzyF2Sk0w2cOo53q55veOzN0xEjhYvlFL7QqU8KoI2kflJHAfXL8c2zBOjsOAA0Zafw1ZsEDjE8fHxIj9Bc4MAfD+Ria9oPzkZOScZZG0Qp3RcocCnngjtxBmaOmdg4cUfUR+bRDnmtkTyWxg2sXDiPRBGyY6/YBIKv2Gvd4K3Iv7q1F5DIKrZGE81wyVBhTU9rZ71XN3+0YE+RAV8Xs2h7wq7seakMoTEfhQn/p3TRqBsWqJVWIf40Be5+0X0dPkNjQv1ESHTFfLwmvLpzCvwTSvWgUAvQuT/6h45nB+BhumpYINKcjrjX40Vf+4NsNLv6kQ2guvO0pjmK6Ul7+aV2B/LB6UH1n1nIRg3c7o0b1HI5hDaWj5bGjkvnJk5nOOG8cR30saW+KGLR3jRgbDoFnii87AZxJMgtb3W9XiaHE2djeWVm4OF2UiWW1o68OYztxLX83PhMisxMo1ZYXZGtq0XoIVNLvMXUd0uqt/xp4s1f44aA/Ye3Kl++3t8kdgwa0tOBpT73ds7g6YkO9DVsIAFrzL7KOYDBdgU1Owy4uQuewj9t06eaAxmG9qbPgBof+vPwe3ayErKRLYN8yh4c4A0V1RELqqFnYVnKH0y+ZC3a280EsIjyb8WIDA3vaSu5AXMCt/B7OE9yqGLiQ8OI9XoYqzMQOLdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cd5395-d915-4438-a000-08d8635a4eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 02:57:59.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ukYiyOGdCnHSa5RxkslMl8ZxGobJ43FHcJv3EYBkMy14Da8b3OvHMihWaWwkeZG39WrQ8T/9rA59HMHdVE6CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2313
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/09/26 11:12, Wang Qing wrote:=0A=
> Modify the comment typo: "compliment" -> "complement".=0A=
> =0A=
> Signed-off-by: Wang Qing <wangqing@vivo.com>=0A=
> ---=0A=
>  drivers/block/skd_main.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index ae6454c..e70e764=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -2037,7 +2037,7 @@ static void skd_enable_interrupts(struct skd_device=
 *skdev)=0A=
>  	val =3D FIT_ISH_FW_STATE_CHANGE +=0A=
>  	      FIT_ISH_COMPLETION_POSTED + FIT_ISH_MSG_FROM_DEV;=0A=
>  =0A=
> -	/* Note that the compliment of mask is written. A 1-bit means=0A=
> +	/* Note that the complement of mask is written. A 1-bit means=0A=
>  	 * disable, a 0 means enable. */=0A=
>  	SKD_WRITEL(skdev, ~val, FIT_INT_MASK_HOST);=0A=
>  	dev_dbg(&skdev->pdev->dev, "interrupt mask=3D0x%x\n", ~val);=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
