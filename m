Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97735C4BA21
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 18:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8C120714
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 18:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgBZSlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:41:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31600 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSlg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 13:41:36 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01QIfUxf002268;
        Wed, 26 Feb 2020 19:41:30 +0100
Date:   Wed, 26 Feb 2020 19:41:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
Message-ID: <20200226184130.GA2265@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
 <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 26, 2020 at 09:49:05AM -0800, Linus Torvalds wrote:
> On Wed, Feb 26, 2020 at 6:57 AM Denis Efremov <efremov@linux.com> wrote:
> >
> > If Linus has no objections (regarding his review) I would prefer to
> > accept 1-10 patches rather to resend them again. They seems complete
> > to me as the first step.
> 
> I have no objections, and the patches 11-16 seem to have addressed all
> my "I wish.." concerns too (except for the "we should rewrite or
> sunset the driver entirely").

Sorry if I broke your dream :-)

> Looks fine to me.

Thanks!

Willy
