Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815D8C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 04:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078302158C
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 04:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XJ7cgHfz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qzjAbGks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409206AbgJ0EJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 00:09:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20329 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409072AbgJ0EJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 00:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603771746; x=1635307746;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cr928VxoWQTe4PMAbAjLId32ReB9Jg5ba3Fdr90jcmk=;
  b=XJ7cgHfzvtaymtyLi/4vB6iOWI+nGLrFP1wncKuBHeWtYGIIO2qcoYj1
   dL/7i1ftHOqu0EkAHBi+J8v6sumSkhM5UpGfSGbvuRiTuxcZrOAQs9Zny
   YL/h3FOWQUsiMBByffLzPyrXwHY6pYiTxi907l7OifXC1oC1qCkKLy4XI
   jPb3ua3bXVbPdSB57vGNDcAR5ck0ukkEenZMJ/wl3YqPzfgIXAtiHaBHd
   8DN2TTiGGFXAA57hVtlKD9YJ94dUr7rf4n/u52rssy0XGhN6+qtGApsxA
   2MYIm/c6MgGxFY/ZVl7pxaGdkkFKu/5WaM0JTFQrGTAbbLkfgAXZPpYFZ
   A==;
IronPort-SDR: GNyETeTag9QFFmd5CtWTFm8xo746JPECEKz1iBghZ/XEtR1YNm7jKnmVMLuoRTAWlzHO2m9fa5
 2pkklKU5bnC10+8+mnWORMhT0oxZnnbGD+7UtgmNigjDD7cr3fO2Aa3hLWmiVaKvXOVqMe282J
 dhSTIoAM7Mj4rjpj9uR3f9H16SXRMGxXC2jjSjl+qhsdL0Ph56FU0RPPC3zi0KiE58+4J77FnS
 bshUQvs7jToUi31AmRlbIis6zpdzKWaj1g3YOZKZfHskgK/gSPOYukZEAsezgZx1LGZFqwEH28
 TZc=
X-IronPort-AV: E=Sophos;i="5.77,422,1596470400"; 
   d="scan'208";a="155383235"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 12:09:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmuoCyk3KoR+w1lAUveXNcaUYKFWs7BgPVJs69Gd7Bx7zSjxH+QmFdNDVRF0FV4Z/4n61WMbWsgfVPxGD9VG5zw0ttmKW6BGUhUMMempDOpQ0+7dGHnKnmhqjohiWV++QpjqSooVZp25RVWxO+ZhNsaucV71x++gXxqQKgRGW9xuHBZw4NPjr5ksfrVi3tL6sXkIzUVUlJ0TbFosmBtU/ZcU1KiAm9woJSDv1PaERZxwaCL6z9p/cPuCEtqpO5YCZsTJYFJodbe3KlgzgGId9Wigtoq6oxaLPt0orBMDdllXcSJGbddyvifUB/EQ2zmmWbUotybOAdXyjWuIwxob6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFNxFpIqFwhcQHv0KiKYEzyyueGlzUUUvS09yZNTIm8=;
 b=PHtnyMKW/ux7CXy9rSK22HEGz2SUE+h+NAdDMnV+o38IBUkYVCGN9E6AN3j/QkhoWPxhjgPAFBrORlxYFIhIXla4KtbvAD2DvOij5SATf0xFwd5DwTqQT3dfpb4E/A4HUgh2KqMKA7w+JjqxnIfCdMmNJW8bk49vMhBvkwriG/S96rBijvk3HoKYMXT1FBMYE5whRA3FTsiy1GE97H+q5uMjLYT+Vid0sslf5F7CWYHeJPoYAXtoU7zZLnCkEOaa6yhfDqtcgWxucWalMy9OBxyD9tJkqkfZRNC/jAPWKRNMOvlLTok/xaxiSCyHNEl+XVOVSHbXeySJPCU9YySV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFNxFpIqFwhcQHv0KiKYEzyyueGlzUUUvS09yZNTIm8=;
 b=qzjAbGksfdDsOeA4IbuzEqGpU5BPut5a3QxZoSmQCniM1FUK2s3OOELMsc3RD8Xgf7KblXPYf1uXvz6iQcGCbCOzEvPweTnMKZxIHr5Xx/9lc82YqQgc55cxn+K90O5h5QGRF0LHp7r8Bs/Hsv59DtwBmTm7s9QtxVsiqjSlVcM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4770.namprd04.prod.outlook.com (2603:10b6:208:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 04:09:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 04:09:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Tian Tao <tiantao6@hisilicon.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] skd: replace spin_lock_irqsave by spin_lock in hard IRQ
Thread-Topic: [PATCH] skd: replace spin_lock_irqsave by spin_lock in hard IRQ
Thread-Index: AQHWp0fG0krxUmEHkkSBi3Qjiu2mWw==
Date:   Tue, 27 Oct 2020 04:09:05 +0000
Message-ID: <BL0PR04MB65149BE243D53CEF34C992C5E7160@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1603243006-9189-1-git-send-email-tiantao6@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3dd3:d7e5:5981:e303]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5abbd289-a12b-4605-8b77-08d87a2e0ba4
x-ms-traffictypediagnostic: BL0PR04MB4770:
x-microsoft-antispam-prvs: <BL0PR04MB47704F36EF747A65FF995FC6E7160@BL0PR04MB4770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUgs9XwArQlkBBsxK7yXBJpriC8aN1w6JO/AGJ4ZMI5+bRb8nph4FnzWMjjXGV6eiK6rzCEMe6NHAEBJYkIUnQiqzXa+0R5XWDIq21GWvpjjp/YdZCmgtQxf4gGl0rwJzEvg0XfG54w8jyx8SJiR32owq/+/CPahS2jE/pMXZ6LuPqqCsnMAxqQhu7aqfYhKApN4XA+3UXszaZaEEVR1vT/dM3G5zDm9fV4wtD6KfGzIEszJNs74I9fQRmkYRmWLNeezvZoDI+4SLaI+w2bgBm6EhW2GJh1zcx3ddGVkwwK/lZcL2gQBqOeIYooES6WeeWHhRCSK5tTlSauf9BoQRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(86362001)(91956017)(66946007)(66446008)(7696005)(64756008)(52536014)(33656002)(76116006)(66476007)(478600001)(71200400001)(66556008)(83380400001)(5660300002)(2906002)(186003)(55016002)(110136005)(316002)(8676002)(6506007)(53546011)(8936002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ybBf7aKuour32JXLNCXXSBZiEnB7nhyzr7pmotEdLMlmj/r+7yuA8p5Lq0rAzg7K7r8ej1qiqQMueqe/1UfYuQA/8c+x9nF1zu6f6sH7yUhJcvwD1UNcG4eRvFzZ2dgHfQEWXdbcraTte+cARnW4qWgzQbOxlTZcSk2Z8WjlcoFFeVOsJ9kWw/GhBl6ziSRSGZq3HGBYZQmv4cKRkNhKHRF5x8iZQa5X0t32Wbm6XElQ6HeDON/bHuE07y3CDhynjjDqzYutW8RsjXrqHLDbLpNDfYO0b3/hLBrxYx3H8hRuTE5Am/w6bValBaffco4JB72PFU8umlMvix6mOVl5+9PRJAHmPPoGmOSoskge753r+YqX9CkXFL6zlEOd3HGWmvKe9enlq+TJ0ILxFE5ZBosqJYU70noJRhO7KKfFc82TMYD1wveq/D9q40aMSJdf0YMMCguxtEsJZfgci2w6L7DwnjtKCH8AziCLawHXv9975/ry5e03Ks+PCE0TH8fw+xQEYnUOM/uUbOfFnUe7rcbrT2FOy5Xe1mzAmFZwOKICIO2sPgBlc5hLAc8Najo0mzs7+cLa8xwc5pjOA6qdiIPLgdYnx1AGtJQuNgSzWkH6uwqh1UP5DmNnmrMoWcfb6xQNdb4t4qjDdHPHIIXIC5fa+szzAj3TwZ2sj3hDHqVIAWOJYw6VW/AJMwaTEZV30amXfAmKIgvAFGqE2CVeEA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abbd289-a12b-4605-8b77-08d87a2e0ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 04:09:05.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11ci+8/yYc5T+Z9yXi6LCWavcmJhiv7GOQJ/uCVOSA+DwPWOT2RqmiQvFyioAwCLHlQ1HnLSayS+EfGxELPLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4770
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/10/21 10:16, Tian Tao wrote:=0A=
> The code has been in a irq-disabled context since it is hard IRQ. There=
=0A=
> is no necessity to do it again.=0A=
> =0A=
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>=0A=
> ---=0A=
>  drivers/block/skd_main.c | 25 ++++++++++---------------=0A=
>  1 file changed, 10 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index ae6454c..e80b670 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -2368,40 +2368,37 @@ static int skd_unquiesce_dev(struct skd_device *s=
kdev)=0A=
>  static irqreturn_t skd_reserved_isr(int irq, void *skd_host_data)=0A=
>  {=0A=
>  	struct skd_device *skdev =3D skd_host_data;=0A=
> -	unsigned long flags;=0A=
>  =0A=
> -	spin_lock_irqsave(&skdev->lock, flags);=0A=
> +	spin_lock(&skdev->lock);=0A=
>  	dev_dbg(&skdev->pdev->dev, "MSIX =3D 0x%x\n",=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	dev_err(&skdev->pdev->dev, "MSIX reserved irq %d =3D 0x%x\n", irq,=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	SKD_WRITEL(skdev, FIT_INT_RESERVED_MASK, FIT_INT_STATUS_HOST);=0A=
> -	spin_unlock_irqrestore(&skdev->lock, flags);=0A=
> +	spin_unlock(&skdev->lock);=0A=
>  	return IRQ_HANDLED;=0A=
>  }=0A=
>  =0A=
>  static irqreturn_t skd_statec_isr(int irq, void *skd_host_data)=0A=
>  {=0A=
>  	struct skd_device *skdev =3D skd_host_data;=0A=
> -	unsigned long flags;=0A=
>  =0A=
> -	spin_lock_irqsave(&skdev->lock, flags);=0A=
> +	spin_lock(&skdev->lock);=0A=
>  	dev_dbg(&skdev->pdev->dev, "MSIX =3D 0x%x\n",=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	SKD_WRITEL(skdev, FIT_ISH_FW_STATE_CHANGE, FIT_INT_STATUS_HOST);=0A=
>  	skd_isr_fwstate(skdev);=0A=
> -	spin_unlock_irqrestore(&skdev->lock, flags);=0A=
> +	spin_unlock(&skdev->lock);=0A=
>  	return IRQ_HANDLED;=0A=
>  }=0A=
>  =0A=
>  static irqreturn_t skd_comp_q(int irq, void *skd_host_data)=0A=
>  {=0A=
>  	struct skd_device *skdev =3D skd_host_data;=0A=
> -	unsigned long flags;=0A=
>  	int flush_enqueued =3D 0;=0A=
>  	int deferred;=0A=
>  =0A=
> -	spin_lock_irqsave(&skdev->lock, flags);=0A=
> +	spin_lock(&skdev->lock);=0A=
>  	dev_dbg(&skdev->pdev->dev, "MSIX =3D 0x%x\n",=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	SKD_WRITEL(skdev, FIT_ISH_COMPLETION_POSTED, FIT_INT_STATUS_HOST);=0A=
> @@ -2415,7 +2412,7 @@ static irqreturn_t skd_comp_q(int irq, void *skd_ho=
st_data)=0A=
>  	else if (!flush_enqueued)=0A=
>  		schedule_work(&skdev->start_queue);=0A=
>  =0A=
> -	spin_unlock_irqrestore(&skdev->lock, flags);=0A=
> +	spin_unlock(&skdev->lock);=0A=
>  =0A=
>  	return IRQ_HANDLED;=0A=
>  }=0A=
> @@ -2423,27 +2420,25 @@ static irqreturn_t skd_comp_q(int irq, void *skd_=
host_data)=0A=
>  static irqreturn_t skd_msg_isr(int irq, void *skd_host_data)=0A=
>  {=0A=
>  	struct skd_device *skdev =3D skd_host_data;=0A=
> -	unsigned long flags;=0A=
>  =0A=
> -	spin_lock_irqsave(&skdev->lock, flags);=0A=
> +	spin_lock(&skdev->lock);=0A=
>  	dev_dbg(&skdev->pdev->dev, "MSIX =3D 0x%x\n",=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	SKD_WRITEL(skdev, FIT_ISH_MSG_FROM_DEV, FIT_INT_STATUS_HOST);=0A=
>  	skd_isr_msg_from_dev(skdev);=0A=
> -	spin_unlock_irqrestore(&skdev->lock, flags);=0A=
> +	spin_unlock(&skdev->lock);=0A=
>  	return IRQ_HANDLED;=0A=
>  }=0A=
>  =0A=
>  static irqreturn_t skd_qfull_isr(int irq, void *skd_host_data)=0A=
>  {=0A=
>  	struct skd_device *skdev =3D skd_host_data;=0A=
> -	unsigned long flags;=0A=
>  =0A=
> -	spin_lock_irqsave(&skdev->lock, flags);=0A=
> +	spin_lock(&skdev->lock);=0A=
>  	dev_dbg(&skdev->pdev->dev, "MSIX =3D 0x%x\n",=0A=
>  		SKD_READL(skdev, FIT_INT_STATUS_HOST));=0A=
>  	SKD_WRITEL(skdev, FIT_INT_QUEUE_FULL, FIT_INT_STATUS_HOST);=0A=
> -	spin_unlock_irqrestore(&skdev->lock, flags);=0A=
> +	spin_unlock(&skdev->lock);=0A=
>  	return IRQ_HANDLED;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
