Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFFBC76195
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7139C21019
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxdJ/w2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfGRMtG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:49:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 08:49:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so21443147wmd.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWWuA/JtQHEoXMKz+XE4VOt7xAtoTKB5e9hojkHO6LI=;
        b=QxdJ/w2pcS5etMpYFrkbCU3kTpMD2xOsMbc/inBrOnvQ4wZ6IFI1V11ePOF5YUuwgW
         ilIk7JFacuYmv2DT47pxaYmrnBK1OLf17OEPhbOnd3aUkIwlt+ghtoo1S28rwT9/SOPt
         l6WzoMUl7MHq0o2scyM2bYcl0ltdPLMGeImAdhyPmEOBNAtwdOSrycyQT/Ehq9IMPPcO
         GseRtwNwyi1cqKW1t5uyED1Bdjzd8r/LWENnle5fjnyLodIBjTq7AziXYWqSY8GuyUed
         QUDKArW/Do6s5tXL22QClyTw5oAX9yfOVCNrktiqT4hl5eUGc64Uq4Pi5aEvk8M93HOa
         RFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWWuA/JtQHEoXMKz+XE4VOt7xAtoTKB5e9hojkHO6LI=;
        b=a/Z7ztQa4yTifCao6VY4J3vAgOie6AhM0rZxjpahZn4PkbQv2U135QwogFXPmpTLFt
         N28UgF2hJJiVJRfWlG0CSnFfp8BoIFwRPMDkIIeRc0dOPnhfOX/pw+e6ZWpMrGwvroUO
         DGOksWsi/KV/AQZZkwL3zOCsca+fuggEaKjVNewJOlt/kj3vYCBqq7FGHvs367+/PCDI
         8CcNTgwNiU5Up1AvKAId868oJHEWVrwSltc5Y6Zh4gaGH57MRALbZMp4U5kHx7o/QAe0
         0e7vg7lBLQPqX10guKbFFw6WC0SryjSWeQv9AmCy2AmUOrVdmsOqHh4YHdBQM9ysfaM2
         +0yw==
X-Gm-Message-State: APjAAAXzVTL2Vt1c0jlKsSnut1BT8AYDvblnMI3B/pNOXbt7exelBd3/
        eqIymFrwy4etFOkziL7ZOtPxY2aQzC/LP7Zek4I0
X-Google-Smtp-Source: APXvYqy6CDJOP3TkhKIRwK/Jy2ldyzs9AHrBBFwOO86437RdJVO4H7Wh9eWo6BybO5H9SQagTXh6cIAk34GC+ElLzQ0=
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr39537254wmf.60.1563454144157;
 Thu, 18 Jul 2019 05:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-6-fred@fredlawl.com>
In-Reply-To: <20190718020745.8867-6-fred@fredlawl.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 18 Jul 2019 07:48:51 -0500
Message-ID: <CAErSpo5TZC3iM09SB1td+F7b-+aiu9EHwPYa1ayiU-i1tseV5w@mail.gmail.com>
Subject: Re: [PATCH] mtip32xx: Prefer pcie_capability_read_word()
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 17, 2019 at 9:09 PM Frederick Lawler <fred@fredlawl.com> wrote:
>
> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> added accessors for the PCI Express Capability so that drivers didn't
> need to be aware of differences between v1 and v2 of the PCI
> Express Capability.
>
> Replace pci_read_config_word() and pci_write_config_word() calls with
> pcie_capability_read_word() and pcie_capability_write_word().
>
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index f0105d118056..b7b26e33248b 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3952,22 +3952,18 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
>         int pos;
>         unsigned short pcie_dev_ctrl;
>
> -       pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> -       if (pos) {
> -               pci_read_config_word(pdev,
> -                       pos + PCI_EXP_DEVCTL,
> -                       &pcie_dev_ctrl);
> -               if (pcie_dev_ctrl & (1 << 11) ||
> -                   pcie_dev_ctrl & (1 << 4)) {
> -                       dev_info(&dd->pdev->dev,
> -                               "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
> -                                       pdev->vendor, pdev->device);
> -                       pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
> -                                               PCI_EXP_DEVCTL_RELAX_EN);
> -                       pci_write_config_word(pdev,
> -                               pos + PCI_EXP_DEVCTL,
> -                               pcie_dev_ctrl);
> -               }
> +       if (!pci_is_pcie(pdev))
> +               return;
> +
> +       pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
> +       if (pcie_dev_ctrl & (1 << 11) ||
> +           pcie_dev_ctrl & (1 << 4)) {

Hmm, sort of sloppy that  d1e714db8129 ("mtip32xx: Fix ERO and NoSnoop
values in PCIe upstream on AMD systems") used
PCI_EXP_DEVCTL_NOSNOOP_EN and PCI_EXP_DEVCTL_RELAX_EN below, but not
here.  Could be fixed with a separate follow-on patch.

> +               dev_info(&dd->pdev->dev,
> +                        "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
> +                        pdev->vendor, pdev->device);
> +               pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
> +                                       PCI_EXP_DEVCTL_RELAX_EN);
> +               pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, pcie_dev_ctrl);
>         }
>  }
>
> --
> 2.17.1
>
