Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E16C433E1
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 02:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEF820773
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 02:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZpSBjMtc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z+M+uiQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGUC5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:57:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGUC5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 22:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595300251; x=1626836251;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6dwiQs45B6OKigGHznMegoKAJD6GCG00C6oGMeF19sU=;
  b=ZpSBjMtc925ZJqktWsUPf+7djFxLrGlkjCbLldsLw8XS1qawfIYC1oGU
   aP4bhAdHqQU2IkB0u8FMgSBDrOOOPbxrl9uVjYWhb49XLRHJ/a7bh6f1/
   8IflLseznjThwD9fM2Icq5cJOlHwmbPppstu8UqXYbAYzj1QFgQ8vZgsD
   IJBUAlYgftfi3UlJTY23ejivUp/EfmUsk6G+xva8z7Pm7GnV8pbfN+/qS
   ptUGYmpKBy3kcR7w5KY7jxb4Z7lV/DscGR1FPWMOa9VyXQf/gTzXmhQOl
   cLcR36JEMaP40jBUc7oopsVIQRiMySNwwDR+KHCJlbnLSgtWouu+NjnA5
   A==;
IronPort-SDR: umm+ut04vCVaux05dcM0ABFIgI5uf/tRsSJI5u90yUiMCEacDKEML1wMG4oxRSXOwWdlvTlkrB
 u0pCNx/cnHnYbUI/jjk/pECYU4YFA/Zn3C2y55K1373rYuXVX1uOLniQd1k5WpUHNUNVB9FzUS
 +guPiS86FOjkh2k8mNJ4M3w99OirmahtwgMc3MZDD8j6cKN9sUaP3uvc1sp9fsM+7gw5bVt0Fa
 HGI0itsgDPIzMzg4fgKXlepBpNypD0dqkJ/ldItDiD5Jha5IxmK78MoWnVeUvWNljf4Td4ohZy
 f6s=
X-IronPort-AV: E=Sophos;i="5.75,377,1589212800"; 
   d="scan'208";a="142975021"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 10:57:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMmE91IOzgRGuWiElirlsibAYAnt8cKG62yw4wYIogaTnS3wJ1YyjRBs3VgbuIqCqlY716XuS43gjo2lR69lYxNNGWOWZCdJm5y5DBgrEvnCw29q0wDlSE6VvWVL9plCBBwV85GePjZI7BQMG0qL7VtMZqCmUVYZtLGsUBJ6kr2U+ey0+auizY89Lzj0upObns6wfdtzZbMKxoTitX+rdGVwnjtc53L7rOiWoxPZ9LEcq5RwfpADkgP5g3O/3GWu60bt15Ez/bKwAu6H3izQ+2un55gjiv4ORcow134yhTHXkVSbpQeOxqK/Ueu6QrYnR2TGlKK8H/MYJtPAvFquKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaCWxcgFE7qyvNZ9arWf47/7Mn2ZTVyGDagG6Q2tiQw=;
 b=cyXY6yQsoHT7O06bUHnoc/PWworfZ6ESHbDtbmUyFhEKZdUmHbj6/WvqKUwFmviIM2PoiQQywgLUkoElQHVP43jiQ2mtVgrBQXnpgHbYUuPDbhMLLSJneeEEhiLmggt7/YWni/o0HZBWBlaRoRNrxTAvjuq2PIocXYVUgXu5VP3d00roZwwZ+PTvBgGQ2hmmRGJFdFadlDK8h/epe82PoSnnDMhVZWZwHiUxdm34v/K5kRA2fGlT9WrXUNQYewa6dAAYZE0zzoy0WQxZLFUTQeSipftEr2sr0ouy5HM3mzdD/9gg2xi8nhO1FROOwvAQe/P5b9cbXxE5boimfxGz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaCWxcgFE7qyvNZ9arWf47/7Mn2ZTVyGDagG6Q2tiQw=;
 b=z+M+uiQgssRmd/8T6WkJlCPbgPllml+HrUZ0DwdBjH1y0BDDyuonD53h3U2m1VfjvTLxa+cAgm76mP6bnuldR65ZFLo1yBKIZ9/i0l3h+dsQeaDuMMfMZ7ZqAN14A8OZekB8k5cGgB+u8qVpvXrl3nOODE9acHm7u1WoOBFZa48=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2220.namprd04.prod.outlook.com (2a01:111:e400:c60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 02:57:28 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 02:57:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] skd: use generic power management
Thread-Topic: [PATCH v2 3/3] skd: use generic power management
Thread-Index: AQHWXpopAyN24hyhnE6CLtHPJKt76g==
Date:   Tue, 21 Jul 2020 02:57:28 +0000
Message-ID: <CY4PR04MB375176CACBFC3C2BEBE6D0AAE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720133002.448809-1-vaibhavgupta40@gmail.com>
 <20200720133002.448809-4-vaibhavgupta40@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 785ddce8-c2d6-4f4d-b5f2-08d82d21ce20
x-ms-traffictypediagnostic: CY1PR04MB2220:
x-microsoft-antispam-prvs: <CY1PR04MB222032FF248DE60B3652E026E7780@CY1PR04MB2220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdqbM1SzoD9EXKDjZ5KVWWWftIXURU5sIAy/fjMNE0niQA9bIqRbtcKrxcnBkiXrKVk5evPHSy4XIl3Rg1XE/CwxcAfre2cgkxW9nO9YiaMwAwtwSIvE7yhvVWCrX54B7GFP5ib5sfSTDoismKb4x2eM9gUmUwosJsJ/RJajZGq9/7g1qSh5XGct6NGkavj8qkEEJMdgNAwLriKP3YUMzbDGBeJje2Pyp1B/s05J9dqwwJ4fZfr1xWKa/b7tdtt0P2+hBWQSCaKC5VLSptq/tGkYuHOf9rnqpwJmNur8TAeg8KzJNemqfWZXZ0tOpt1xk3V6qlD/tp0b6U6Ml/MCdcKszpOLLzh8MxzkYjzryaJiU9LQG9l2gGifimySp5/W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(8676002)(7696005)(71200400001)(83380400001)(66946007)(2906002)(7416002)(66476007)(8936002)(53546011)(6506007)(186003)(86362001)(5660300002)(52536014)(66446008)(64756008)(66556008)(4326008)(26005)(110136005)(33656002)(9686003)(316002)(55016002)(478600001)(91956017)(54906003)(76116006)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yTta3G3mLxH+Gz/DtOexdCxFIo+9pcqtci2t4qvKTflro7T9ZX6HX496CCJfYMtaI3NTNmi0ZAvHHP3LDENPVPDR/3NZSxgjmQw/oLEFZZVu9smoijucVl4Qtph+aV8XKioebOW3EdlAgm6m01g8+4xhuz9RVXyziEoE0jiomuWsIG1iQwYpF/jSnJSg35xOhSD6KLu77PV1iQutfDIB7KTr84rsazkrbgtWYzKZwKx/yXi4qzv2orXADeusU+zafsTI+BCZri9l6kfuit/foaFVj5D13rVVScL1tPFgeWhVKA1uXcc4BorqNBPnYROQwnhQ3+81mlhjjc6ma2M/DPrI+CILmN4pu3iTeMOl96AU07dQlDXvJuAGCDfjT/7SBFnG7o+1876RsdSLOYgBwbmoGL27xX31oHDyo0VH69xijZErlXuPNafDVKD+CRdi+uhAOw1kylSi+V/Z6EYoLCZe/LZWXC0vgj8IFa8TzJtWJOW2DzhmKl3wGVHIjcXH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785ddce8-c2d6-4f4d-b5f2-08d82d21ce20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 02:57:28.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cShcuLkp+O7/emY8a3qjkL52SLtWPZoQrMSweFGf7gYD+MeJCEjrBikNzpVu7t/fd2OfkhLsdql/mjLaZwuaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2220
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 22:32, Vaibhav Gupta wrote:=0A=
> Drivers using legacy PM have to manage PCI states and device's PM states=
=0A=
> themselves. They also need to take care of configuration registers.=0A=
> =0A=
> With improved and powerful support of generic PM, PCI Core takes care of=
=0A=
> above mentioned, device-independent, jobs.=0A=
> =0A=
> This driver makes use of PCI helper functions like=0A=
> pci_save/restore_state(), pci_enable/disable_device(),=0A=
> pci_request/release_regions(), pci_set_power_state() and=0A=
> pci_set_master() to do required operations. In generic mode, they are no=
=0A=
> longer needed.=0A=
> =0A=
> Change function parameter in both .suspend() and .resume() to=0A=
> "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable=
.=0A=
=0A=
This commit message is rather vague, and the last sentence actually does no=
t=0A=
describe correctly the change. What about something very simple, yet clear,=
 like=0A=
this:=0A=
=0A=
skd: use generic power management=0A=
=0A=
Switch from the legacy .suspend()/.resume() power management interface to t=
he=0A=
generic power management interface using the single .driver.pm() method. Th=
is=0A=
avoids the need for the driver to directly call most of the PCI helper func=
tions=0A=
and device power state control functions as the generic power management=0A=
interface takes care of the necessary operations.=0A=
=0A=
> =0A=
> Compile-tested only.=0A=
> =0A=
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>=0A=
> ---=0A=
>  drivers/block/skd_main.c | 30 ++++++++----------------------=0A=
>  1 file changed, 8 insertions(+), 22 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
> index 51569c199a6c..7f2d42900b38 100644=0A=
> --- a/drivers/block/skd_main.c=0A=
> +++ b/drivers/block/skd_main.c=0A=
> @@ -3315,10 +3315,11 @@ static void skd_pci_remove(struct pci_dev *pdev)=
=0A=
>  	return;=0A=
>  }=0A=
>  =0A=
> -static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)=0A=
> +static int __maybe_unused skd_pci_suspend(struct device *dev)=0A=
>  {=0A=
>  	int i;=0A=
>  	struct skd_device *skdev;=0A=
> +	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>  =0A=
>  	skdev =3D pci_get_drvdata(pdev);=0A=
>  	if (!skdev) {=0A=
> @@ -3337,18 +3338,15 @@ static int skd_pci_suspend(struct pci_dev *pdev, =
pm_message_t state)=0A=
>  	if (skdev->pcie_error_reporting_is_enabled)=0A=
>  		pci_disable_pcie_error_reporting(pdev);=0A=
>  =0A=
> -	pci_release_regions(pdev);=0A=
> -	pci_save_state(pdev);=0A=
> -	pci_disable_device(pdev);=0A=
> -	pci_set_power_state(pdev, pci_choose_state(pdev, state));=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -static int skd_pci_resume(struct pci_dev *pdev)=0A=
> +static int __maybe_unused skd_pci_resume(struct device *dev)=0A=
>  {=0A=
>  	int i;=0A=
>  	int rc =3D 0;=0A=
>  	struct skd_device *skdev;=0A=
> +	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>  =0A=
>  	skdev =3D pci_get_drvdata(pdev);=0A=
>  	if (!skdev) {=0A=
> @@ -3356,16 +3354,8 @@ static int skd_pci_resume(struct pci_dev *pdev)=0A=
>  		return -1;=0A=
>  	}=0A=
>  =0A=
> -	pci_set_power_state(pdev, PCI_D0);=0A=
> -	pci_enable_wake(pdev, PCI_D0, 0);=0A=
> -	pci_restore_state(pdev);=0A=
> +	device_wakeup_disable(dev);=0A=
>  =0A=
> -	rc =3D pci_enable_device(pdev);=0A=
> -	if (rc)=0A=
> -		return rc;=0A=
> -	rc =3D pci_request_regions(pdev, DRV_NAME);=0A=
> -	if (rc)=0A=
> -		goto err_out;=0A=
>  	rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));=0A=
>  	if (rc)=0A=
>  		rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));=0A=
> @@ -3374,7 +3364,6 @@ static int skd_pci_resume(struct pci_dev *pdev)=0A=
>  		goto err_out_regions;=0A=
>  	}=0A=
>  =0A=
> -	pci_set_master(pdev);=0A=
>  	rc =3D pci_enable_pcie_error_reporting(pdev);=0A=
>  	if (rc) {=0A=
>  		dev_err(&pdev->dev,=0A=
> @@ -3427,10 +3416,6 @@ static int skd_pci_resume(struct pci_dev *pdev)=0A=
>  		pci_disable_pcie_error_reporting(pdev);=0A=
>  =0A=
>  err_out_regions:=0A=
> -	pci_release_regions(pdev);=0A=
> -=0A=
> -err_out:=0A=
> -	pci_disable_device(pdev);=0A=
>  	return rc;=0A=
>  }=0A=
>  =0A=
> @@ -3450,13 +3435,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev=
)=0A=
>  	skd_stop_device(skdev);=0A=
>  }=0A=
>  =0A=
> +static SIMPLE_DEV_PM_OPS(skd_pci_pm_ops, skd_pci_suspend, skd_pci_resume=
);=0A=
> +=0A=
>  static struct pci_driver skd_driver =3D {=0A=
>  	.name		=3D DRV_NAME,=0A=
>  	.id_table	=3D skd_pci_tbl,=0A=
>  	.probe		=3D skd_pci_probe,=0A=
>  	.remove		=3D skd_pci_remove,=0A=
> -	.suspend	=3D skd_pci_suspend,=0A=
> -	.resume		=3D skd_pci_resume,=0A=
> +	.driver.pm	=3D &skd_pci_pm_ops,=0A=
>  	.shutdown	=3D skd_pci_shutdown,=0A=
>  };=0A=
>  =0A=
> =0A=
=0A=
Apart from the commit message, this looks OK to me.=0A=
I will give this a spin today on the hardware to check.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
