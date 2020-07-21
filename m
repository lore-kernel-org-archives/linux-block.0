Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485AFC433E2
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 07:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E122BEF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 07:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGl1Sor6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGUHLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgGUHLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jul 2020 03:11:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D63C061794;
        Tue, 21 Jul 2020 00:11:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so1029769pjb.1;
        Tue, 21 Jul 2020 00:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F7dnB0uyrp2//lzhWBnJDT1hxEJsTvhLSMhJ0j3szqk=;
        b=LGl1Sor623ghfLqynlcLzD8JmrYoad2mJCtjF1kwWGMq1G7LlOdQdm8re6dwb+JVUN
         KQzJwivtTVhkBR9TUhNOE3Fu8DJK6dY5ForqbmTS3QI6ViKqMcyCwmjtE5kKFvw0zkWY
         CzMvz/kC7DfQ+2WFAEOPsXkl/OwvBNEOWuuI6hdAVHUjoYTcEPGxFqtum/be8gpagj4b
         gkE9U271Rbx4OBj0JA7tNqRtu7pYXGvxLjiPTkHZs6ozS1WxgaE9AqD/dHruECOe3+pB
         pPe1rc0ZUKGI+RPhmCphe/Ds30LMQ0hWh/pQFB2RxZ5kzYm6x7rrN5MEIo+cCIFa+alY
         AlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F7dnB0uyrp2//lzhWBnJDT1hxEJsTvhLSMhJ0j3szqk=;
        b=nKX0PGpsoDvXtIzv0Qhvny5gWZbNbiloDmQDohHkvOncDtH7Z38KOKG9aIdA9ShJxF
         NR3VUkRQJuBULoT6ByY2dlqxeYBIYR4yAwuva6D5k0HLqYMPkS6CBigDQnu+rzuFEZJ4
         oaK6VJ9IJ0F98iVS9UkqoXRplxJzCkk2p2ehLgxFkklMSzwECdddTD6mTy5SNKIJrIZG
         XL5OJW9qKKUP4NM69VSefwivqUvvvzTRoJ1Jar74VRVtW6o0ZTOxEJFhebChXZFwjxyn
         sW64EhFPjnkSl/uSYfy7EbBiwI5b2n+6hJ69b7vn0fH7uuHQF09NlWpiuvnR7yRJfAPu
         fKfQ==
X-Gm-Message-State: AOAM533ce/dMiDNVzsT8K1RvD7CLwIv6/rnL2HBbjwETZoxeWTedRNnu
        JIATaEbCiWcFT1fAqYKf6nE=
X-Google-Smtp-Source: ABdhPJwZCH6RgPBLfoctq+orlJ06dkyhPg1CFs1b4Iz1YKTMVT2yB32dMvFMQ24eKpgATMC14Pchhg==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr3204477pjb.44.1595315465837;
        Tue, 21 Jul 2020 00:11:05 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id g5sm19271924pfh.168.2020.07.21.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:11:04 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:39:39 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
Subject: Re: [PATCH v2 3/3] skd: use generic power management
Message-ID: <20200721070939.GB51743@gmail.com>
References: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720133002.448809-1-vaibhavgupta40@gmail.com>
 <20200720133002.448809-4-vaibhavgupta40@gmail.com>
 <CY4PR04MB375176CACBFC3C2BEBE6D0AAE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375176CACBFC3C2BEBE6D0AAE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 21, 2020 at 02:57:28AM +0000, Damien Le Moal wrote:
> On 2020/07/20 22:32, Vaibhav Gupta wrote:
> > Drivers using legacy PM have to manage PCI states and device's PM states
> > themselves. They also need to take care of configuration registers.
> > 
> > With improved and powerful support of generic PM, PCI Core takes care of
> > above mentioned, device-independent, jobs.
> > 
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_enable/disable_device(),
> > pci_request/release_regions(), pci_set_power_state() and
> > pci_set_master() to do required operations. In generic mode, they are no
> > longer needed.
> > 
> > Change function parameter in both .suspend() and .resume() to
> > "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.
> 
> This commit message is rather vague, and the last sentence actually does not
> describe correctly the change. What about something very simple, yet clear, like
> this:
> 
> skd: use generic power management
> 
> Switch from the legacy .suspend()/.resume() power management interface to the
> generic power management interface using the single .driver.pm() method. This
> avoids the need for the driver to directly call most of the PCI helper functions
> and device power state control functions as the generic power management
> interface takes care of the necessary operations.
>
Okay. I will improve on it. Just inform me after testing that if any other
changes are required. I guess [PATCH 1/3] and [PATCH 2/3] are okay, so I will
only send v3 of [PATCH 3/3] after suggested changes.
> > 
> > Compile-tested only.
> > 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/block/skd_main.c | 30 ++++++++----------------------
> >  1 file changed, 8 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> > index 51569c199a6c..7f2d42900b38 100644
> > --- a/drivers/block/skd_main.c
> > +++ b/drivers/block/skd_main.c
> > @@ -3315,10 +3315,11 @@ static void skd_pci_remove(struct pci_dev *pdev)
> >  	return;
> >  }
> >  
> > -static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> > +static int __maybe_unused skd_pci_suspend(struct device *dev)
> >  {
> >  	int i;
> >  	struct skd_device *skdev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> >  
> >  	skdev = pci_get_drvdata(pdev);
> >  	if (!skdev) {
> > @@ -3337,18 +3338,15 @@ static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> >  	if (skdev->pcie_error_reporting_is_enabled)
> >  		pci_disable_pcie_error_reporting(pdev);
> >  
> > -	pci_release_regions(pdev);
> > -	pci_save_state(pdev);
> > -	pci_disable_device(pdev);
> > -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> >  	return 0;
> >  }
> >  
> > -static int skd_pci_resume(struct pci_dev *pdev)
> > +static int __maybe_unused skd_pci_resume(struct device *dev)
> >  {
> >  	int i;
> >  	int rc = 0;
> >  	struct skd_device *skdev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> >  
> >  	skdev = pci_get_drvdata(pdev);
> >  	if (!skdev) {
> > @@ -3356,16 +3354,8 @@ static int skd_pci_resume(struct pci_dev *pdev)
> >  		return -1;
> >  	}
> >  
> > -	pci_set_power_state(pdev, PCI_D0);
> > -	pci_enable_wake(pdev, PCI_D0, 0);
> > -	pci_restore_state(pdev);
> > +	device_wakeup_disable(dev);
> >  
> > -	rc = pci_enable_device(pdev);
> > -	if (rc)
> > -		return rc;
> > -	rc = pci_request_regions(pdev, DRV_NAME);
> > -	if (rc)
> > -		goto err_out;
> >  	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >  	if (rc)
> >  		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > @@ -3374,7 +3364,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
> >  		goto err_out_regions;
> >  	}
> >  
> > -	pci_set_master(pdev);
> >  	rc = pci_enable_pcie_error_reporting(pdev);
> >  	if (rc) {
> >  		dev_err(&pdev->dev,
> > @@ -3427,10 +3416,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
> >  		pci_disable_pcie_error_reporting(pdev);
> >  
> >  err_out_regions:
> > -	pci_release_regions(pdev);
> > -
> > -err_out:
> > -	pci_disable_device(pdev);
> >  	return rc;
> >  }
> >  
> > @@ -3450,13 +3435,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev)
> >  	skd_stop_device(skdev);
> >  }
> >  
> > +static SIMPLE_DEV_PM_OPS(skd_pci_pm_ops, skd_pci_suspend, skd_pci_resume);
> > +
> >  static struct pci_driver skd_driver = {
> >  	.name		= DRV_NAME,
> >  	.id_table	= skd_pci_tbl,
> >  	.probe		= skd_pci_probe,
> >  	.remove		= skd_pci_remove,
> > -	.suspend	= skd_pci_suspend,
> > -	.resume		= skd_pci_resume,
> > +	.driver.pm	= &skd_pci_pm_ops,
> >  	.shutdown	= skd_pci_shutdown,
> >  };
> >  
> > 
> 
> Apart from the commit message, this looks OK to me.
> I will give this a spin today on the hardware to check.
> 
Thanks!
--Vaibhav Gupta
> 
> -- 
> Damien Le Moal
> Western Digital Research
