Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF09C433E0
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 02:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA274207DF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 02:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DRghygTA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t4Z9ZF6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGUCtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:49:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60230 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 22:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595299749; x=1626835749;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cyslQVh3F0gfd/VjsO3hDxS14+xeKMHg/tLtqjLH5ug=;
  b=DRghygTA3MZTqLAyzGH3WpeI6sh8Kr0E6bFjHcF7Qnbjv4LoFMRdrcEp
   gTko1LubsI0fsDgogH7AdoamzPL9la1PHyfrk/7kv6FGK4YsWNaV7ZYm/
   BXSVhmT0g8qiSp9orIYsvLzBv1yKwOsyUmR7DnXJbtfSZCEteDlzHMDhM
   RLbo0eGjaDwr89f/iaiAHq6hIGbApXDrfXCXsJa9/zR9I+R+asUqwkap3
   gbKuYzRh3vI2xJ09kXVjubVfOMUtiVVDp02+r188RKwEhUFGIzyTlR95L
   5rdLVX6KaGvIFJNpf8RrNZhKlanuVILvlOSySYqqdS3fDfhvNdbgUtELm
   Q==;
IronPort-SDR: z14ogrvk6FHSNFtjKhzkvK5FT1joKetHqxpSN/YoVdnb1FrIx6X/GJU/a2v42KK2gm3R51kXEl
 OTA8uxbjqNZzusWOvSxjOBxFITHViznwaiKf7V7hy1PJ9GkGnqapAuluXXBNBjS/MHRd8Q38cs
 MoKQ31nd7FFthDZ6Bshkm547+bBKe8va3km/0V7elgdGKDb5xeA0mdvFEZDYVrcFCEpPJBYk/h
 BIrx0UTE8sp5TEvN8qR3++i9QU+mhoUST5l9PgjBWGkPrwVeqn5V8YiSruQlgMzWC3F0Wyud2n
 e34=
X-IronPort-AV: E=Sophos;i="5.75,377,1589212800"; 
   d="scan'208";a="142974495"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 10:49:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZDBUe0bnc74bx+o4fg+JJEBXF6pdDnf9ACoEcuFJcrVSweA+6xpQ4IMD1r1Gx6pnveHsdorSt3EPKLsasJBTedOxTEbIgTAlKjldJuam0gduYFk4y6SN/qHruFDJxogFRpYXqTN6qG28T4S6++GkWVBdU0G3ik6h+jEKrqikujqot1+jj8jv9pv+mmly/VQC217DCzVqy6S6V5koyexi0ovDRbYSH3rM4qU100oZfSVQM4u4aPyCewYHGfjBRcFbh3xyA8Lb4XF9qYbyyLjto13pRQMJNwGD1agFoQNBpKpkPDzbDhotYCJFFRLTgc32Jsdx80fJhLzCGt4gmO34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u9+32+uyALLdlURmFJSOACrp68yps216cmy3wADEfo=;
 b=Clgl7U7NxiibXIYgHyYk8DsQPD1hnypsUuWLI5BNSykq3OgAJb4cMPzvJtKr8Tpj5i7PNas9pbVbUvPM1Pl1fIFqiGS79ynPa9cJNJc9jSSmhOB8WKD5g0KoZBhiDYYDglzQq0e+T8P0ODsDi9/bEyz+Za39r0REhXUAprQBhLv2bGlc+f+tFGSFf+hWWcVG7RYz0cGBk47/hdGBgrydB8/lkZ48mrp7PZBRO++VdxFqb32o5els5Lmb/0mt8ez9GsUBj57wlEnFvBbE5M2guwPWt73om2Vo0abFNuKN93G9qLKTN2MESa9dtmpEVYF5jrNuXTxpMhVr/c2n+sSHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u9+32+uyALLdlURmFJSOACrp68yps216cmy3wADEfo=;
 b=t4Z9ZF6BRuU6fTalWHghxO5CVykVSkGxNRQHfOdMrRDSWDdIVUXXLJ8kA15BJsDAQN1V5omBn6I1ffCYQa6tdNrtVPwgzc2oIwktPJ56eMXVh19QevrwCWY3yr5hAephAcsJ5TY8QEmeeBp6UhUkp61TEXRfReTWpEVw9R0k1vY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0342.namprd04.prod.outlook.com (2603:10b6:903:3f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 21 Jul
 2020 02:49:06 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 02:49:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] skd: use generic power management
Thread-Topic: [PATCH v1 3/3] skd: use generic power management
Thread-Index: AQHWXBHK3yyvSpv7dkelMB844h700w==
Date:   Tue, 21 Jul 2020 02:49:06 +0000
Message-ID: <CY4PR04MB3751EB3DA357A6856B3337D0E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200717080910.342741-1-vaibhavgupta40@gmail.com>
 <20200717080910.342741-4-vaibhavgupta40@gmail.com>
 <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720131627.GA447599@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0984d12f-e396-4b19-a57c-08d82d20a2d2
x-ms-traffictypediagnostic: CY4PR04MB0342:
x-microsoft-antispam-prvs: <CY4PR04MB0342EDFA4294E07F17152C1FE7780@CY4PR04MB0342.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ghh4PKc1uZkAOPKfZgtFULuQnS123rcjNUbQw9CSuLBoZEsg2VKQsNb1onzcmrgZ0+1tKgHNJmOgUVRC7y0xV8C1nr37H4AqRUXT0fMmiKzgGrhf8PTL2VmrYuf/mhzgWlep3r1PZHsI3/VH2eQGnZZ7lqJZjBHg5DlrrpTnkOLbWNO74yPF/pgTDtUeVOOcn4iXKVe+vIe+OlFv4TCqhhUvXv8xxlhMboLlkZtj8ZrV0HYlfahDtfJaAMMmYoNC/QFB36X2BWJzbFJmRwNbmnyXd69cb8rNsjb0gMT7sZxrqT0mmrTKTB5zgRg9ajeMh2pEVqOLDaP12GM/qrHxNtH6vIclOO8IFqX/5OT1jB6vXpsh/4ArcxQ9dIq7WwcV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(55016002)(9686003)(6916009)(8936002)(76116006)(7696005)(91956017)(26005)(64756008)(66476007)(66556008)(7416002)(66946007)(186003)(66446008)(6506007)(53546011)(33656002)(2906002)(478600001)(5660300002)(71200400001)(316002)(54906003)(86362001)(8676002)(52536014)(4326008)(83380400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pxty9KAp35cLYu6plltLF022SNnQ6M2PzOAw0tA5WldLoAt5b4U6IqnMJGUVEn0tE/4pDnQSibCLwVW9oob0MZJY9eRIg8gCTePYzkTsaX7NgkIdeKYPMHsn978KC0oeS+E1vqjPWpQyFl4JtkGmMQnE/IIPhNDskb/XKN/gCsQjr+8hFwEbnu5pwTL4VA42xyaa+IaISJxS0/7v7G/rqUZLJTYARTWC4bbw0kEo21gdyVmGKD4xFx3yaDXtFyUHzfVZaUKT4SV0+vTOQlrzNV5LbLJ++qIXLdhoS4qx9GYeumIFjtdZW8aSZLF2ChdmMUNuB1ov7KWkD2+1Bou2lNyvos3H/CsZjmtqI2b4NX4azy7bdy5y7I/bkn0tIQoWaglZFJF08HZmRMQITC4v3vfSFGpRvvv7T8BCrkpeGaKKE/KLRs6yxVRM3EbHSiId5sW3chzO1trndzkzY4ZNbVIhY060qfkMWgNgMxl1JNdzerFK3qf8mU1i2Swt8Nog
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0984d12f-e396-4b19-a57c-08d82d20a2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 02:49:06.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVn5SmPm/6LZftXXOmhdjdfbGImgqvSReTmabn1kw/sJcjaOtIynOIdfDhQQD99Lx25XgVmZdtSgXmMrknnxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0342
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 22:18, Vaibhav Gupta wrote:=0A=
> On Mon, Jul 20, 2020 at 12:52:14PM +0000, Damien Le Moal wrote:=0A=
>> On 2020/07/17 17:10, Vaibhav Gupta wrote:=0A=
>>> Drivers using legacy PM have to manage PCI states and device's PM state=
s=0A=
>>> themselves. They also need to take care of configuration registers.=0A=
>>>=0A=
>>> With improved and powerful support of generic PM, PCI Core takes care o=
f=0A=
>>> above mentioned, device-independent, jobs.=0A=
>>>=0A=
>>> This driver makes use of PCI helper functions like=0A=
>>> pci_save/restore_state(), pci_enable/disable_device(),=0A=
>>> pci_request/release_regions(), pci_set_power_state() and=0A=
>>> pci_set_master() to do required operations. In generic mode, they are n=
o=0A=
>>> longer needed.=0A=
>>>=0A=
>>> Change function parameter in both .suspend() and .resume() to=0A=
>>> "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variab=
le.=0A=
>>>=0A=
>>> Compile-tested only.=0A=
>>=0A=
>> I do not think this belongs into the commit message. This was mentioned =
in the=0A=
>> cover letter.=0A=
>>=0A=
> The messages in cover letter and commit message are bit similar. But the =
commit=0A=
> message has patch specific changes mentioned in it.=0A=
=0A=
My point was about the "compile-tested only" mention in the commit message.=
 That=0A=
should be mentioned in the cover letter only. The goal of the patch review=
=0A=
process is also to get these patches tested by others if you do not have ac=
cess=0A=
to the hardware. That is fine, and I can test for the skd driver. But a pat=
ch=0A=
mentioning that it is untested cannot be applied, for obvious reasons :)=0A=
=0A=
So I only requested that you remove the "compiled tested only" note. The co=
mmit=0A=
message could be simpler too, see followup comment.=0A=
=0A=
>>>=0A=
>>> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>=0A=
>>> ---=0A=
>>>  drivers/block/skd_main.c | 36 ++++++++++--------------------------=0A=
>>>  1 file changed, 10 insertions(+), 26 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
>>> index 51569c199a6c..d8d1042e7338 100644=0A=
>>> --- a/drivers/block/skd_main.c=0A=
>>> +++ b/drivers/block/skd_main.c=0A=
>>> @@ -3315,12 +3315,12 @@ static void skd_pci_remove(struct pci_dev *pdev=
)=0A=
>>>  	return;=0A=
>>>  }=0A=
>>>  =0A=
>>> -static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)=
=0A=
>>> +static int __maybe_unused skd_pci_suspend(struct device *dev)=0A=
>>>  {=0A=
>>>  	int i;=0A=
>>> -	struct skd_device *skdev;=0A=
>>> +	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>>> +	struct skd_device *skdev =3D pci_get_drvdata(pdev);=0A=
>>=0A=
>> You can just add the pdev declaration here. The other 2 changes are not =
needed.=0A=
>>=0A=
> Okay.=0A=
>>>  =0A=
>>> -	skdev =3D pci_get_drvdata(pdev);=0A=
>>=0A=
>> You can keep this as is.=0A=
>>=0A=
>>>  	if (!skdev) {=0A=
>>>  		dev_err(&pdev->dev, "no device data for PCI\n");=0A=
>>>  		return -EIO;=0A=
>>> @@ -3337,35 +3337,23 @@ static int skd_pci_suspend(struct pci_dev *pdev=
, pm_message_t state)=0A=
>>>  	if (skdev->pcie_error_reporting_is_enabled)=0A=
>>>  		pci_disable_pcie_error_reporting(pdev);=0A=
>>>  =0A=
>>> -	pci_release_regions(pdev);=0A=
>>> -	pci_save_state(pdev);=0A=
>>> -	pci_disable_device(pdev);=0A=
>>> -	pci_set_power_state(pdev, pci_choose_state(pdev, state));=0A=
>>>  	return 0;=0A=
>>>  }=0A=
>>>  =0A=
>>> -static int skd_pci_resume(struct pci_dev *pdev)=0A=
>>> +static int __maybe_unused skd_pci_resume(struct device *dev)=0A=
>>>  {=0A=
>>>  	int i;=0A=
>>>  	int rc =3D 0;=0A=
>>> -	struct skd_device *skdev;=0A=
>>>  =0A=
>>> -	skdev =3D pci_get_drvdata(pdev);=0A=
>>=0A=
>> Same comment as above. Keep these as is and add only pdev declaration.=
=0A=
>>=0A=
> Okay.=0A=
> Sending v2 with suggested changes.=0A=
> =0A=
> --Vaibhav Gupta=0A=
>>> +	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>>> +	struct skd_device *skdev =3D pci_get_drvdata(pdev);=0A=
>>>  	if (!skdev) {=0A=
>>>  		dev_err(&pdev->dev, "no device data for PCI\n");=0A=
>>>  		return -1;=0A=
>>>  	}=0A=
>>>  =0A=
>>> -	pci_set_power_state(pdev, PCI_D0);=0A=
>>> -	pci_enable_wake(pdev, PCI_D0, 0);=0A=
>>> -	pci_restore_state(pdev);=0A=
>>> +	device_wakeup_disable(dev);=0A=
>>>  =0A=
>>> -	rc =3D pci_enable_device(pdev);=0A=
>>> -	if (rc)=0A=
>>> -		return rc;=0A=
>>> -	rc =3D pci_request_regions(pdev, DRV_NAME);=0A=
>>> -	if (rc)=0A=
>>> -		goto err_out;=0A=
>>>  	rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));=0A=
>>>  	if (rc)=0A=
>>>  		rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));=0A=
>>> @@ -3374,7 +3362,6 @@ static int skd_pci_resume(struct pci_dev *pdev)=
=0A=
>>>  		goto err_out_regions;=0A=
>>>  	}=0A=
>>>  =0A=
>>> -	pci_set_master(pdev);=0A=
>>>  	rc =3D pci_enable_pcie_error_reporting(pdev);=0A=
>>>  	if (rc) {=0A=
>>>  		dev_err(&pdev->dev,=0A=
>>> @@ -3427,10 +3414,6 @@ static int skd_pci_resume(struct pci_dev *pdev)=
=0A=
>>>  		pci_disable_pcie_error_reporting(pdev);=0A=
>>>  =0A=
>>>  err_out_regions:=0A=
>>> -	pci_release_regions(pdev);=0A=
>>> -=0A=
>>> -err_out:=0A=
>>> -	pci_disable_device(pdev);=0A=
>>>  	return rc;=0A=
>>>  }=0A=
>>>  =0A=
>>> @@ -3450,13 +3433,14 @@ static void skd_pci_shutdown(struct pci_dev *pd=
ev)=0A=
>>>  	skd_stop_device(skdev);=0A=
>>>  }=0A=
>>>  =0A=
>>> +static SIMPLE_DEV_PM_OPS(skd_pci_pm_ops, skd_pci_suspend, skd_pci_resu=
me);=0A=
>>> +=0A=
>>>  static struct pci_driver skd_driver =3D {=0A=
>>>  	.name		=3D DRV_NAME,=0A=
>>>  	.id_table	=3D skd_pci_tbl,=0A=
>>>  	.probe		=3D skd_pci_probe,=0A=
>>>  	.remove		=3D skd_pci_remove,=0A=
>>> -	.suspend	=3D skd_pci_suspend,=0A=
>>> -	.resume		=3D skd_pci_resume,=0A=
>>> +	.driver.pm	=3D &skd_pci_pm_ops,=0A=
>>>  	.shutdown	=3D skd_pci_shutdown,=0A=
>>>  };=0A=
>>>  =0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
