Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B199FC433FE
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557FF23158
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 04:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbgLLE25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 23:28:57 -0500
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:43902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390895AbgLLE2e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 23:28:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 92A341802DA2D;
        Sat, 12 Dec 2020 04:27:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoe55_600a68027406
X-Filterd-Recvd-Size: 2115
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Dec 2020 04:27:50 +0000 (UTC)
Message-ID: <4257c266dd5edf3ad6617657331abcabfd59188f.camel@perches.com>
Subject: Re: [PATCH] block: drop dead assignments in loop_init()
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org
Date:   Fri, 11 Dec 2020 20:27:49 -0800
In-Reply-To: <CAKXUXMxjtv5B4ekC58=Ww8R4Ju2MvT0pXbPi7XH+OU7JuYnP3w@mail.gmail.com>
References: <20201211181236.25755-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.22.394.2012111923020.2669@hadrien>
         <CAKXUXMxjtv5B4ekC58=Ww8R4Ju2MvT0pXbPi7XH+OU7JuYnP3w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-12-11 at 19:40 +0100, Lukas Bulwahn wrote:
> On Fri, Dec 11, 2020 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > On Fri, 11 Dec 2020, Lukas Bulwahn wrote:
> > > Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> > > demand") simplified loop_init(); so computing the range of the block region
> > > is not required anymore and can be dropped.
> > > 
> > > Drop dead assignments in loop_init().
> > > 
> > > As compilers will detect these unneeded assignments and optimize this,
> > > the resulting object code is identical before and after this change.
> > > 
> > > No functional change. No change in object code.
> > 
> > It looks like some braces should be dropped too?

> I just rewrote it to:
> 
> nr = max_loop ? max_loop : CONFIG_BLK_DEV_LOOP_MIN_COUNT;

A relatively common gcc extension would use ?: like:

	nr = max_loop ?: CONFIG_BLK_DEV_LOOP_MIN_COUNT;


