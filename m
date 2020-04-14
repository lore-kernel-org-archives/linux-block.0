Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA2C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BEA20656
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 16:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbgDNQM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:12:59 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34583 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbgDNQM6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 12:12:58 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03EGCCqm021445;
        Tue, 14 Apr 2020 18:12:12 +0200
Date:   Tue, 14 Apr 2020 18:12:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
Subject: Re: [PATCH 00/23] Floppy driver cleanups
Message-ID: <20200414161212.GA21441@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <ae23d88d-fc21-6f46-7c27-ea0adf6211e5@kernel.dk>
 <20200414053119.GB20927@1wt.eu>
 <da6afb7c-d543-b0a3-c165-89ad0b2a2783@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6afb7c-d543-b0a3-c165-89ad0b2a2783@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Denis,

On Tue, Apr 14, 2020 at 01:29:02PM +0300, Denis Efremov wrote:
> I was expecting that some of the arch maintainers will at least
> ack the patches.

TBH, floppy is probably very low on any arch maintainer's priority list.

> Willy, could you please resend the patchset with printks fix for sparc64?
> Or if Jens don't mind and you don't want to send 30 patches again you can
> resend only sparc64 patch and I will reapply it and send everything to Jens
> with merge request. I applied your patches a couple of days ago here
> https://github.com/evdenis/linux-floppy/ to cleanups branch.

Then I'll redo this one only and directly send it to you as I really hate
spamming innocents with patches. This will also help Jens in that you've
already recomposed the whole series for him.

> I also faced minor ubsan warning in setup_rw_floppy that is not related
> to these patches. It's false alarm of cross-boundary access of cmd,
> reply_count, reply in floppy_raw_cmd. This access is intentional.
> I will send a patch on top of your patchset.

OK, cool!

Thanks!
Willy
