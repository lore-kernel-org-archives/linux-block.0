Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD25C433E0
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DCD20714
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 07:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpIwpOne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGVHWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 03:22:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35C4C0619DC;
        Wed, 22 Jul 2020 00:22:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 8so704960pjj.1;
        Wed, 22 Jul 2020 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RTwx8JspPqMJt5hO5/cyyNv4iyME0D4xtrXj8pb1/A=;
        b=bpIwpOneXvBYc8FEzs8nb3CCo2bvWVP6TRWYtlLRnWDuXW3Vf371P2WMwhhsoQkAK+
         EkUB2wuIP5Ao77Q5g81N2+nkCx5cL8gDiWFEc8ieU7b9vPWFA7V0vAJWvcmUMX5GukfY
         HUHrowS3a4n256j9+bE5mTG9sTwPC0FebfwFdxr0fhFSRLO4OROkK31jQcTgpzHytv6i
         4sf+Opdz1NskXXr82S3nok6eQ3Uex5aCULUDnS3XB/HFrwQAm4743QigJr54mic13BYZ
         S2KWA+7TRrVEWBCaVCydsGGuwyoIxofvN+xqLdkTLEp06YwmXsxZWf5zMOh5FxXS6lp6
         7uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RTwx8JspPqMJt5hO5/cyyNv4iyME0D4xtrXj8pb1/A=;
        b=ruX3r8kibGfZA5REvJRE5BYlZ+/x0rYxaMw+CbNOAS3FIjGwiAqCT8QkT1UPPNmR3t
         c2AL68F8//T0InbergiofZ0fig4B1IPi1aWKjfOIDMEPWYnbdmHP/xzWScDDLJjVW2PU
         Tn1ffhY0umqs2v7vvCMsNEy5LuDkX6gbH22YcP9uc02eRf8kyYzHnsdzVgCdWvdwhSDW
         GAoJnIM7qcAnrMc2wiSN3TfhM0mNTWrnUzLnsQOS61Lpm6d0nBQkG61+XHfdyoVZwGT4
         Q3LMj5LUymW7h4SVQSSH4k2RGU7T6u2dtvKBwPI39xq7gGMvlSx0pvN1LQXFWzc1Efq7
         RVXQ==
X-Gm-Message-State: AOAM533TjQC4sCLnWLsnEwSO7xieoxI78xrXKP9D9orugattLmcWf95F
        p284dmTNOhrXQLkObiggjFE=
X-Google-Smtp-Source: ABdhPJyV/EGIMaYsBn8KcB0g6not85kSXa4fuGiroiJRYflAiR/0TPf9j8Ay6zV0WlaeolZ2+q2WPQ==
X-Received: by 2002:a17:90a:204:: with SMTP id c4mr8364676pjc.165.1595402571054;
        Wed, 22 Jul 2020 00:22:51 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id z11sm22596372pfk.46.2020.07.22.00.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 00:22:49 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:51:06 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "josh.h.morris@us.ibm.com" <josh.h.morris@us.ibm.com>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "vaibhav.varodek@gmail.com" <vaibhav.varodek@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "pjk1939@linux.ibm.com" <pjk1939@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] skd: use generic power management
Message-ID: <20200722072106.GA2474@gmail.com>
References: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720133002.448809-1-vaibhavgupta40@gmail.com>
 <20200720133002.448809-4-vaibhavgupta40@gmail.com>
 <CY4PR04MB375176CACBFC3C2BEBE6D0AAE7780@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200721070939.GB51743@gmail.com>
 <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 06:28:58AM +0000, Damien Le Moal wrote:
> On Tue, 2020-07-21 at 12:39 +0530, Vaibhav Gupta wrote:
> > On Tue, Jul 21, 2020 at 02:57:28AM +0000, Damien Le Moal wrote:
> > > On 2020/07/20 22:32, Vaibhav Gupta wrote:
> > > > Drivers using legacy PM have to manage PCI states and device's PM states
> > > > themselves. They also need to take care of configuration registers.
> > > > 
> > > > With improved and powerful support of generic PM, PCI Core takes care of
> > > > above mentioned, device-independent, jobs.
> > > > 
> > > > This driver makes use of PCI helper functions like
> > > > pci_save/restore_state(), pci_enable/disable_device(),
> > > > pci_request/release_regions(), pci_set_power_state() and
> > > > pci_set_master() to do required operations. In generic mode, they are no
> > > > longer needed.
> > > > 
> > > > Change function parameter in both .suspend() and .resume() to
> > > > "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.
> > > 
> > > This commit message is rather vague, and the last sentence actually does not
> > > describe correctly the change. What about something very simple, yet clear, like
> > > this:
> > > 
> > > skd: use generic power management
> > > 
> > > Switch from the legacy .suspend()/.resume() power management interface to the
> > > generic power management interface using the single .driver.pm() method. This
> > > avoids the need for the driver to directly call most of the PCI helper functions
> > > and device power state control functions as the generic power management
> > > interface takes care of the necessary operations.
> > > 
> > Okay. I will improve on it. Just inform me after testing that if any other
> > changes are required. I guess [PATCH 1/3] and [PATCH 2/3] are okay, so I will
> > only send v3 of [PATCH 3/3] after suggested changes.
> > > > Compile-tested only.
> > > > 
> > > > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > > > ---
> > > >  drivers/block/skd_main.c | 30 ++++++++----------------------
> > > >  1 file changed, 8 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> > > > index 51569c199a6c..7f2d42900b38 100644
> > > > --- a/drivers/block/skd_main.c
> > > > +++ b/drivers/block/skd_main.c
> > > > @@ -3315,10 +3315,11 @@ static void skd_pci_remove(struct pci_dev *pdev)
> > > >  	return;
> > > >  }
> > > >  
> > > > -static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> > > > +static int __maybe_unused skd_pci_suspend(struct device *dev)
> > > >  {
> > > >  	int i;
> > > >  	struct skd_device *skdev;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > >  
> > > >  	skdev = pci_get_drvdata(pdev);
> > > >  	if (!skdev) {
> > > > @@ -3337,18 +3338,15 @@ static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> > > >  	if (skdev->pcie_error_reporting_is_enabled)
> > > >  		pci_disable_pcie_error_reporting(pdev);
> > > >  
> > > > -	pci_release_regions(pdev);
> > > > -	pci_save_state(pdev);
> > > > -	pci_disable_device(pdev);
> > > > -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static int skd_pci_resume(struct pci_dev *pdev)
> > > > +static int __maybe_unused skd_pci_resume(struct device *dev)
> > > >  {
> > > >  	int i;
> > > >  	int rc = 0;
> > > >  	struct skd_device *skdev;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > >  
> > > >  	skdev = pci_get_drvdata(pdev);
> > > >  	if (!skdev) {
> > > > @@ -3356,16 +3354,8 @@ static int skd_pci_resume(struct pci_dev *pdev)
> > > >  		return -1;
> > > >  	}
> > > >  
> > > > -	pci_set_power_state(pdev, PCI_D0);
> > > > -	pci_enable_wake(pdev, PCI_D0, 0);
> > > > -	pci_restore_state(pdev);
> > > > +	device_wakeup_disable(dev);
> > > >  
> > > > -	rc = pci_enable_device(pdev);
> > > > -	if (rc)
> > > > -		return rc;
> > > > -	rc = pci_request_regions(pdev, DRV_NAME);
> > > > -	if (rc)
> > > > -		goto err_out;
> > > >  	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > >  	if (rc)
> > > >  		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > > @@ -3374,7 +3364,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
> > > >  		goto err_out_regions;
> > > >  	}
> > > >  
> > > > -	pci_set_master(pdev);
> > > >  	rc = pci_enable_pcie_error_reporting(pdev);
> > > >  	if (rc) {
> > > >  		dev_err(&pdev->dev,
> > > > @@ -3427,10 +3416,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
> > > >  		pci_disable_pcie_error_reporting(pdev);
> > > >  
> > > >  err_out_regions:
> > > > -	pci_release_regions(pdev);
> > > > -
> > > > -err_out:
> > > > -	pci_disable_device(pdev);
> > > >  	return rc;
> > > >  }
> > > >  
> > > > @@ -3450,13 +3435,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev)
> > > >  	skd_stop_device(skdev);
> > > >  }
> > > >  
> > > > +static SIMPLE_DEV_PM_OPS(skd_pci_pm_ops, skd_pci_suspend, skd_pci_resume);
> > > > +
> > > >  static struct pci_driver skd_driver = {
> > > >  	.name		= DRV_NAME,
> > > >  	.id_table	= skd_pci_tbl,
> > > >  	.probe		= skd_pci_probe,
> > > >  	.remove		= skd_pci_remove,
> > > > -	.suspend	= skd_pci_suspend,
> > > > -	.resume		= skd_pci_resume,
> > > > +	.driver.pm	= &skd_pci_pm_ops,
> > > >  	.shutdown	= skd_pci_shutdown,
> > > >  };
> > > >  
> > > > 
> > > 
> > > Apart from the commit message, this looks OK to me.
> > > I will give this a spin today on the hardware to check.
> > > 
> > Thanks!
> 
> Tested this and it seems OK.
> 
> Of note, after having removed the device (echo 1 >
> /sys/block/skd0/device/remove) and rescaning its PCI slot, I got a
> lockdep splat:
> 
> [ 4449.098757] ======================================================
> [ 4449.104945] WARNING: possible circular locking dependency detected
> [ 4449.111136] 5.8.0-rc6+ #846 Not tainted
> [ 4449.114980] ------------------------------------------------------
> [ 4449.121168] tcsh/1550 is trying to acquire lock:
> [ 4449.125798] ffffffffa85c3748 (pci_rescan_remove_lock){+.+.}-{3:3},
> at: dev_rescan_store+0x38/0x60
> [ 4449.134686] 
> [ 4449.134686] but task is already holding lock:
> [ 4449.140522] ffff8f6cd352ed28 (kn->active#294){++++}-{0:0}, at:
> kernfs_fop_write+0xad/0x1c0
> [ 4449.148795] 
> [ 4449.148795] which lock already depends on the new lock.
> [ 4449.148795] 
> [ 4449.156979] 
> [ 4449.156979] the existing dependency chain (in reverse order) is:
> [ 4449.164464] 
> [ 4449.164464] -> #1 (kn->active#294){++++}-{0:0}:
> [ 4449.170486]        __kernfs_remove+0x276/0x2f0
> [ 4449.174939]        kernfs_remove_by_name_ns+0x41/0x80
> [ 4449.180001]        remove_files+0x2b/0x60
> [ 4449.184018]        sysfs_remove_group+0x38/0x80
> [ 4449.188560]        sysfs_remove_groups+0x29/0x40
> [ 4449.193190]        device_remove_attrs+0x4b/0x70
> [ 4449.197818]        device_del+0x167/0x3f0
> [ 4449.201843]        pci_remove_bus_device+0x70/0x110
> [ 4449.206728]        pci_stop_and_remove_bus_device_locked+0x1e/0x30
> [ 4449.212915]        remove_store+0x55/0x60
> [ 4449.216939]        kernfs_fop_write+0xd9/0x1c0
> [ 4449.221398]        vfs_write+0xc7/0x1f0
> [ 4449.225239]        ksys_write+0x58/0xd0
> [ 4449.229089]        do_syscall_64+0x4f/0x2c0
> [ 4449.233284]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 4449.238863] 
> [ 4449.238863] -> #0 (pci_rescan_remove_lock){+.+.}-{3:3}:
> [ 4449.245575]        __lock_acquire+0x1194/0x1fd0
> [ 4449.250113]        lock_acquire+0x97/0x390
> [ 4449.254221]        __mutex_lock+0x58/0x820
> [ 4449.258330]        dev_rescan_store+0x38/0x60
> [ 4449.262697]        kernfs_fop_write+0xd9/0x1c0
> [ 4449.267154]        vfs_write+0xc7/0x1f0
> [ 4449.270999]        ksys_write+0x58/0xd0
> [ 4449.274846]        do_syscall_64+0x4f/0x2c0
> [ 4449.279041]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 4449.284620] 
> [ 4449.284620] other info that might help us debug this:
> [ 4449.284620] 
> [ 4449.292628]  Possible unsafe locking scenario:
> [ 4449.292628] 
> [ 4449.298555]        CPU0                    CPU1
> [ 4449.303090]        ----                    ----
> [ 4449.307630]   lock(kn->active#294);
> [
> 4449.311131]                                lock(pci_rescan_remove_lock
> );
> [ 4449.317838]                                lock(kn->active#294);
> [ 4449.323855]   lock(pci_rescan_remove_lock);
> [ 4449.328048] 
> [ 4449.328048]  *** DEADLOCK ***
> [ 4449.328048] 
> [ 4449.333977] 3 locks held by tcsh/1550:
> [ 4449.337731]  #0: ffff8f6f18b7d448 (sb_writers#4){.+.+}-{0:0}, at:
> vfs_write+0x174/0x1f0
> [ 4449.345747]  #1: ffff8f6e74d09a88 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write+0xa5/0x1c0
> [ 4449.354111]  #2: ffff8f6cd352ed28 (kn->active#294){++++}-{0:0}, at:
> kernfs_fop_write+0xad/0x1c0
> [ 4449.362821] 
> [ 4449.362821] stack backtrace:
> [ 4449.367192] CPU: 15 PID: 1550 Comm: tcsh Not tainted 5.8.0-rc6+ #846
> [ 4449.373548] Hardware name: Supermicro Super Server/X11DPL-i, BIOS
> 3.1 05/21/2019
> [ 4449.380953] Call Trace:
> [ 4449.383419]  dump_stack+0x78/0xa0
> [ 4449.386744]  check_noncircular+0x12d/0x150
> [ 4449.390853]  __lock_acquire+0x1194/0x1fd0
> [ 4449.394875]  lock_acquire+0x97/0x390
> [ 4449.398462]  ? dev_rescan_store+0x38/0x60
> [ 4449.402486]  __mutex_lock+0x58/0x820
> [ 4449.406067]  ? dev_rescan_store+0x38/0x60
> [ 4449.410090]  ? dev_rescan_store+0x38/0x60
> [ 4449.414113]  ? lock_acquire+0x97/0x390
> [ 4449.417876]  ? kernfs_fop_write+0xad/0x1c0
> [ 4449.421983]  dev_rescan_store+0x38/0x60
> [ 4449.425831]  kernfs_fop_write+0xd9/0x1c0
> [ 4449.429768]  vfs_write+0xc7/0x1f0
> [ 4449.433092]  ksys_write+0x58/0xd0
> [ 4449.436421]  do_syscall_64+0x4f/0x2c0
> [ 4449.440094]  ? prepare_exit_to_usermode+0xa/0x40
> [ 4449.444725]  ? rcu_read_lock_sched_held+0x3f/0x50
> [ 4449.449436]  ? asm_exc_page_fault+0x8/0x30
> [ 4449.453546]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 4449.458608] RIP: 0033:0x7fcce58f45e7
> [ 4449.462191] Code: Bad RIP value.
> [ 4449.465426] RSP: 002b:00007fff2592c898 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 4449.473000] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> 00007fcce58f45e7
> [ 4449.480141] RDX: 0000000000000002 RSI: 0000556d30b96100 RDI:
> 0000000000000001
> [ 4449.487283] RBP: 0000556d30b96100 R08: 0000000000000000 R09:
> 00007fff2592c7f0
> [ 4449.494425] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000001
> [ 4449.501567] R13: 0000556d31fc4fb8 R14: 0000556d31fc37c0 R15:
> 0000556d31fc4fb4
> [ 4449.520721] pci 0000:d8:00.0: [1b39:0001] type 00 class 0x018000
> [ 4449.526802] pci 0000:d8:00.0: reg 0x10: [mem 0xfbe00000-0xfbe0ffff]
> [ 4449.533121] pci 0000:d8:00.0: reg 0x14: [mem 0xfbe10000-0xfbe10fff]
> [ 4449.539474] pci 0000:d8:00.0: reg 0x30: [mem 0xfbd00000-0xfbdfffff
> pref]
> [ 4449.546327] pci 0000:d8:00.0: supports D1 D2
> [ 4449.550936] pci 0000:d8:00.0: BAR 6: assigned [mem 0xfbd00000-
> 0xfbdfffff pref]
> [ 4449.559804] pci 0000:d8:00.0: BAR 0: assigned [mem 0xfbe00000-
> 0xfbe0ffff]
> [ 4449.568849] pci 0000:d8:00.0: BAR 1: assigned [mem 0xfbe10000-
> 0xfbe10fff]
> [ 4449.577178] skd 0000:d8:00.0: PCIe (5.0GT/s 4X) 64bit
> [ 4449.582272] skd 0000:d8:00.0: bad enable of PCIe error reporting
> rc=-5
> [ 4449.589764] skd 0000:d8:00.0: s1120 state INIT(1)=>SOFT_RESET(8)
> [ 4449.595788] skd 0000:d8:00.0: Driver state STARTING(3)=>STARTING(3)
> [ 4449.829900] skd 0000:d8:00.0: s1120 state SOFT_RESET(8)=>INIT(1)
> [ 4449.835929] skd 0000:d8:00.0: Driver state STARTING(3)=>STARTING(3)
> [ 4450.076148] skd 0000:d8:00.0: Time sync driver=0x5f17d872
> device=0x162bdfe9
> [ 4450.083139] skd 0000:d8:00.0: s1120 state INIT(1)=>ONLINE(3)
> [ 4450.088822] skd 0000:d8:00.0: Queue depth limit=64 dev=255 lowat=43
> [ 4450.095101] skd 0000:d8:00.0: Driver state STARTING(3)=>STARTING(3)
> [ 4450.101539] skd 0000:d8:00.0: Driver state STARTING(3)=>ONLINE(4)
> [ 4450.107653] skd 0000:d8:00.0: STEC s1120 ONLINE
> [ 4450.120422]  skd1: p1
> 
> But that looks completely unrelated to your patch. Will have a look at
> this.
> 
Thanks. I will send the patch-series as v3 with updated commit message as
suggested.

--Vaibhav Gupta
> -- 
> Damien Le Moal
> Western Digital Research
