Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4477C76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E321019
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKTvE4/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfGRMoH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:44:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55336 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfGRMoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 08:44:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so25439842wmj.5
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS8vnU3ecan2i1/OO2Y6tvR1DOXqFiFRTJBV+WH4b/w=;
        b=bKTvE4/D/KmSbeF6nrjTCwRz8hhg3QS8GznTxNG/CLtsGsLYHz0dGnheWET4t0ieMf
         EqkwC2yqIr2Sdpjg00rJCVcis9lPCPoqwkCPrEAsPbPwg0oYh5By4Ety6Ht/5BQnwtjA
         OLgCOVzZkWXQ3iRFGvXzDroyw0W1eQwhlU+TDbQcEU2SidQk/coEwR4MXoesOYQb7v23
         X2+bq4ULoDhsOcJ3qoVHn4C4WTCnIvBltBw7s9MhVGzqbCMasPk4HaTfS5j8/vvMxFNR
         xfMWQokZSRr4JnvLavp4BL1WCopvjvep+JRalJUVfs1083oCHqluHzzXLm3R0INnBRME
         sD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS8vnU3ecan2i1/OO2Y6tvR1DOXqFiFRTJBV+WH4b/w=;
        b=Hbe+pI4E7POxS2L7tKjxUU47zrlXrtTux2QHyKVfz0P8zb+n1QcLCDktGtTLgb3s+F
         paj8O72JmPuariMLAWLZSPqNt4fOcKwSUu0mXnE/Hl9ueQCmHLaAHqNuN3QSKIc2YKXz
         gv9Tq2O34S8TRFeVbqQglf534Frynrzr7OCC/wu3P56nuO+x1IIc+LX7qXtpRqLFCfmL
         LIFEDxarh2OgJnrwTwW/OSnKQ1MnrpViER8tSlq8IV5nEFTuPblu9tXcVdVxiSKrONUo
         8JgAWupG17S2GaoyqvuuVrtPummeCqlnkqQgr0k3MsLpyx8gKwKjHnWZzmWtlroCj8J9
         xBUQ==
X-Gm-Message-State: APjAAAV0bpCrRCMUr5HJFXDTgPb3AxFt+RUfX3yn2iC2VRLckptp+FsK
        t+SiR4RbOLwSozZTWe2O99V8caLVXoAXGPp/uPbg
X-Google-Smtp-Source: APXvYqxAlp9/0Oc6DGKMN4Zg6dm2vP1/Vu/RQWya+BHffL8c1J2ZebGwZ3HAa6YCI2fmFRbiPV1HJpRImMPRjEXm94Q=
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr43460959wmk.88.1563453845217;
 Thu, 18 Jul 2019 05:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-10-fred@fredlawl.com>
In-Reply-To: <20190718020745.8867-10-fred@fredlawl.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 18 Jul 2019 07:43:53 -0500
Message-ID: <CAErSpo6BmWDxi3Vckm03=fZHEUosTgkMUjqCvYRA186jv8XbFw@mail.gmail.com>
Subject: Re: [PATCH] skd: Prefer pcie_capability_read_word()
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Jens Axboe <axboe@kernel.dk>, bvanassche@acm.org,
        linux-block@vger.kernel.org,
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
>  drivers/block/skd_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> index 7d3ad6c22ee5..996c38d03fc4 100644
> --- a/drivers/block/skd_main.c
> +++ b/drivers/block/skd_main.c
> @@ -3137,18 +3137,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
>
>  static char *skd_pci_info(struct skd_device *skdev, char *str)
>  {
> -       int pcie_reg;
> -
>         strcpy(str, "PCIe (");
> -       pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
>
> -       if (pcie_reg) {
> +       if (pci_is_pcie(skdev->pdev)) {
>
>                 char lwstr[6];
>                 uint16_t pcie_lstat, lspeed, lwidth;
>
> -               pcie_reg += 0x12;
> -               pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
> +               pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
>                 lspeed = pcie_lstat & (0xF);
>                 lwidth = (pcie_lstat & 0x3F0) >> 4;

This should use PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_CLS, PCI_EXP_LNKSTA_NLW, etc.

Would probably make sense to do that in a separate patch so this patch
matches the other conversions to pcie_capability_read_word().
