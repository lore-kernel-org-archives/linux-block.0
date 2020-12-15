Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21335C2BB48
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D668622582
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 22:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgLOWNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 17:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbgLOWNh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 17:13:37 -0500
Date:   Tue, 15 Dec 2020 14:12:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070376;
        bh=eq135qPs8rX0EmCuSg7lZlv26CCkNVi2mHFfW0PaKfQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3qupgigEqSrKUhsJO8QIOooNBFGrLuClWbNNK9y0yBjA48Ww9Iyb1JnWf4mDL8c8
         tPv2cHyK31BoJYBIU+VlKDjnY5oKR9XZalPNPJohOiO1jCZeE2RovqofhsCWK+qP2z
         dbDtxkIlmfItBa8kngt7/mgiRgqIL3G5vq2uaz9ckI/i/B67zqYhsHnRa4SOaxYxUZ
         z8YEMbixosH8WJ11WNKeRyloU7+tkPdEtq2HWbkupYA1XF7FhJDOVdaDVg+gt4KINv
         bbPy88UqWp1u+jSm5QgF7/ioStaG81EDpF6KFFaRSxVrBXfe924llAccDX5axUg2Zf
         jVai8ToW+Lcmw==
From:   Keith Busch <kbusch@kernel.org>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
References: <20201215195557.30169-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215195557.30169-1-javier.gonz@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
> 
> The char device is presented as /dev/generic-nvmeXcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.
> 
> Christoph, Keith: Is this going in the right direction?

I think this is looking okay, though I'm getting some weird errors and
warnings during boot. The first one looks like the following (I will
look into it too, but I wanted to get a reply out sooner).

[    4.734143] sysfs: cannot create duplicate filename '/dev/char/242:1'
[    4.736359] CPU: 4 PID: 7 Comm: kworker/u16:0 Not tainted 5.10.0+ #172
[    4.740836] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    4.744228] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[    4.745558] Call Trace:
[    4.746122]  dump_stack+0x6d/0x88
[    4.746834]  sysfs_warn_dup.cold+0x17/0x24
[    4.747656]  sysfs_do_create_link_sd.isra.0+0xb0/0xc0
[    4.747659]  device_add+0x604/0x7b0
[    4.749298]  cdev_device_add+0x46/0x70
[    4.753241]  ? cdev_init+0x51/0x60
[    4.753246]  nvme_alloc_ns+0x670/0x8a0 [nvme_core]
[    4.753249]  ? _cond_resched+0x15/0x30
[    4.753253]  nvme_validate_or_alloc_ns+0x99/0x190 [nvme_core]
[    4.753258]  nvme_scan_work+0x152/0x290 [nvme_core]
[    4.753261]  process_one_work+0x1ac/0x330
[    4.753262]  worker_thread+0x50/0x3a0
[    4.753264]  ? process_one_work+0x330/0x330
[    4.753265]  kthread+0xfb/0x130
[    4.753266]  ? kthread_park+0x90/0x90
[    4.753269]  ret_from_fork+0x1f/0x30
[    4.753272] CPU: 5 PID: 88 Comm: kworker/u16:1 Not tainted 5.10.0+ #172

> Keith: Regarding nvme-cli support, what do you think about reporting the
> char device as existing block devices? If this is OK with you, I will
> submit patches for the filters.

I'm not sure I understand what you mean about reporting these as
"existing block devices". Are you talking about what's shown in the
'nvme list' output?
