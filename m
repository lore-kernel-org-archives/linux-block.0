Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B1C3F2D4
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD6B21D56
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgCAI7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:59:19 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31997 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCAI7T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 03:59:19 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0218x5Td024221;
        Sun, 1 Mar 2020 09:59:05 +0100
Date:   Sun, 1 Mar 2020 09:59:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] floppy: remove dead code for drives scanning on ARM
Message-ID: <20200301085905.GA24218@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
 <758c8079-50d7-7dc7-ca83-46be038f182b@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758c8079-50d7-7dc7-ca83-46be038f182b@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Denis,

On Sun, Mar 01, 2020 at 11:21:45AM +0300, Denis Efremov wrote:
> Hi,
> 
> For patches 11-16,
> 
> I've checked the building on x86, arm.
> x86 shows no difference in floppy.o binary.

Thanks for double-checking.

> Compilation on arm tested (make rpc_defconfig).
> 
> I think that macro fd_outb from arm could be turned to
> the static inline function, like on mips or m68k arches. However,
> it's up to you if you want to keep the changes close to the
> original structure.

I wanted to do it as well but wondered if we should focus on limiting
changes or doign an in-depth cleanup. I'll see if I find time for
an extra round of per-arch cleanup, I think it doesn't cost much and
is probably worth being done.

> Please address the warnings and resend the patches:
(...)

Will do in my local patch set and I'll also CC RMK and the few other
persons having touched the ARM part of the driver.

> Everything else looks good to me. Thanks!

Thank you! I've also found an unlocking bug in the driver, when doing
ioctl(FDRESET), if a signal comes, we leave without unlocking. I'll
send a separate patch for this.

Regards,
Willy
