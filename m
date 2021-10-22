Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE1C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B41610A8
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJVI5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:57:33 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:40346 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJVI5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 04:57:32 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mdqIC-005NTO-V3; Fri, 22 Oct 2021 10:52:48 +0200
Date:   Fri, 22 Oct 2021 10:52:48 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] memremap: remove support for external pgmap refcounts
Message-ID: <YXJ74Atvd7i40O4x@angband.pl>
References: <20211019073641.2323410-1-hch@lst.de>
 <20211019073641.2323410-3-hch@lst.de>
 <YXFtwcAC0WyxIWIC@angband.pl>
 <20211022055515.GA21767@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211022055515.GA21767@lst.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 22, 2021 at 07:55:15AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 21, 2021 at 03:40:17PM +0200, Adam Borowski wrote:
> > This breaks at least drivers/pci/p2pdma.c:222
> 
> Indeed.  I've updated this patch, but the fix we need to urgently
> get into 5.15-rc is the first one only anyway.
> 
> nvdimm maintainers, can you please act on it ASAP?

As for build tests, after the p2pdma thingy I've tried all{yes,no,mod}config
and a handful of randconfigs, looks like it was the only place you missed.

As for runtime, a bunch of ndctl uses work fine with no explosions.

Thus: Tested-By.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Don't be racist.  White, amber or black, all beers should
⣾⠁⢠⠒⠀⣿⡁ be judged based solely on their merits.  Heck, even if a
⢿⡄⠘⠷⠚⠋⠀ cider applies for a beer's job, why not?
⠈⠳⣄⠀⠀⠀⠀ On the other hand, mass-produced lager is not a race.
