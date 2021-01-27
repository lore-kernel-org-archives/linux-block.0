Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70035C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F0820771
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbhA0PTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343805AbhA0PSt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:18:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB462207E8;
        Wed, 27 Jan 2021 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611760685;
        bh=zyhEc7kPWdoyip3nZRJOgrKtgNeWHG9ySl/9Iognr+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aka1ho4tHdFJ+JLt3RsqrB/ZlKXDUm1HZ1rRm9nRK5R2kAySjah39sKcfUzG+eGb7
         w0K/5fgeclSRL41i4FOqAYCnuWpDZ8QH+Kj6mPt9XsvZdVWZnzBwSM7I2K+OhUwBr9
         +788j+/gVhd9vZvtQ6jCm4xih77W6RFGPfMiDCufCx8DGUPGWuxWx8lOXn2WxhqUyV
         KcX31HYsmlfnc+B0uXODFJGkSQ1D7KlKo/1axNL56uWC/i/Ygr4qaWQg3s+wXvNfpj
         nbW5abLKrgReUU1UgEzLqzFWM42Prz0eUGLecQ2Vv6h5YiPLHqbp4Xu2pTu47Bdbmg
         sTTyP+pMhl3BQ==
Date:   Wed, 27 Jan 2021 09:18:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Message-ID: <20210127151802.GA2985075@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3228074F-0E0A-4AF1-A950-C978F6FB3908@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 27, 2021 at 07:58:26AM +0000, Chaitanya Kulkarni wrote:
> > On Jan 26, 2021, at 11:41 PM, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> > ﻿On 1/26/21 14:14, Bjorn Helgaas wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >> 
> >> Use PCI #defines for PCIe Device Control register values instead of
> >> hard-coding bit positions.  No functional change intended.
> >> 
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > I've verified the values present in the include/uapi/linux/pci_regs.h
> > matches open coded bit shift values. LGTM.
> > 
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > 
> Something is seriously wrong. I sent out this in the morning and it
> got delivered right now. 

I noticed that, too.  Seems like the mailing list is really backed up.
Thanks a lot for taking a look at this!

Bjorn
