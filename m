Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E264C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AD92186A
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553094992;
	bh=FPNOqaV/XGHFK/rDDDmzzLNpvY62fIyCEG19AH7c6H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddt3f/aClPjs7VgtyLN2P/i/3WtMo8kfqrBnhlZHLhsI79vI6WA3CpCUPVpQpsd0B
	 irft5x51cy8E88Nsck3X2qkM1P2OYQfVX/2yaAQpc65Vl/xxvWa096fqMnap80TqNe
	 PWJIrsTHixb8xIVDNYXa6U8EA70Zv+tFKv2P2WqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCTPQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCTPQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 11:16:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38322184D;
        Wed, 20 Mar 2019 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553094991;
        bh=FPNOqaV/XGHFK/rDDDmzzLNpvY62fIyCEG19AH7c6H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYLBX6JAhN6zqEEQStPJqIuLiJaiD8VEo1MWVGu46KRjiGc6T2AVYIPePpjFNoqan
         FKKDZ07zC//Hb5Ph1SBNHn+cwgVrTVDt8MKoI2+l633aq/Xt47Oml+CpWqFBOEZfFT
         zWRIIssiBgC4nqDi0DdhvOyKLWHksykdKylSPMKg=
Date:   Wed, 20 Mar 2019 16:16:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: Revert commit 310ca162d77
Message-ID: <20190320151628.GA32063@kroah.com>
References: <20190320125806.GD9485@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125806.GD9485@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 20, 2019 at 01:58:06PM +0100, Jan Kara wrote:
> Hello,
> 
> commit 310ca162d77 "block/loop: Use global lock for ioctl() operation." has
> been pushed to multiple stable trees. This patch is a part of larger series
> that overhauls the locking inside loopback device upstream and for 4.4,
> 4.9, and 4.14 stable trees only this patch from the series is applied. Our
> testing now has shown [1] that the patch alone makes present deadlocks
> inside loopback driver more likely (the openqa test in our infrastructure
> didn't hit the deadlock before whereas with the new kernel it hits it
> reliably every time). So I would suggest we revert 310ca162d77 from 4.4,
> 4.9, and 4.14 kernels.
> 
> Another option would be to backport other locking fixes for the loop
> device but honestly I don't think that's a stable material - never heard
> of real users hitting problems, only syzkaller could, and we are still
> fixing up some small glitches resulting from that rework...
> 
> 								Honza
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1129739

Note, I do not have access to that bug report :(

