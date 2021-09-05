Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFEC433F5
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEBB60F92
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhIEQ4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 12:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231804AbhIEQ4S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Sep 2021 12:56:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0575E60698;
        Sun,  5 Sep 2021 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630860915;
        bh=peja4UsmMQfd8162o4jydzYRnQjZBpaPQebO4NjOaUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktr3orceGvMj7XfR74R6yCylxjd9QrwRFY1SWdvll0KqAECbe1zchQPWF01tTr1oL
         ZAix4FOO8sro4/YJvX1OyuH5P4y94DfSImBKalZEu1Y1SQvfio6JHZnLpw1Fn0jfM2
         EhMA2X1dQg6nmJ/3yndktwEUgsZTORhGzjmdV8Alo2JF3rqLcFvlF/cYmzflkn5nP+
         O4Dpg/MhTzVpCTBdmXfoj+TR95WfEVUNGT7VZeP25uSeCYiXp2eFnhaSnq2ml8moe9
         cXDdIFtAktAod0s1FIyUR5v2Xeb4vFnVig9VaT+zmScOhPgbHOayhCdnmOCVuFqTvB
         7B1jiodwN6i6g==
Date:   Sun, 5 Sep 2021 09:55:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ian Pilcher <arequipeno@gmail.com>, axboe@kernel.dk, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-block@vger.kernel.org,
        kabel@kernel.org
Subject: Re: [PATCH 09/18] ledtrig-blkdev: Periodically check devices for
 activity & blink LEDs
Message-ID: <YTT2cbhFkxtWw0mO@sol.localdomain>
References: <20210903204548.2745354-1-arequipeno@gmail.com>
 <20210903204548.2745354-10-arequipeno@gmail.com>
 <YTMLxdQ3TFKPN+WH@kroah.com>
 <8b0a2244-d81c-1099-927f-cfe9b04a4285@gmail.com>
 <YTTZiBWz0Rc7+IGZ@kroah.com>
 <cf19e61d-97a6-1463-3072-d3527d8a1e3a@gmail.com>
 <YTTeZ1kSQMRZNpz7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTTeZ1kSQMRZNpz7@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 05, 2021 at 05:12:39PM +0200, Greg KH wrote:
> On Sun, Sep 05, 2021 at 09:56:58AM -0500, Ian Pilcher wrote:
> > On 9/5/21 9:51 AM, Greg KH wrote:
> > > On Sun, Sep 05, 2021 at 09:39:57AM -0500, Ian Pilcher wrote:
> > > > On 9/4/21 1:01 AM, Greg KH wrote:
> > > > > Please never use WARN_ON() in new code unless the machine is really
> > > > > broken and you can not do anything else here.
> > > > 
> > > > Wait what?  I thought that was BUG_ON.
> > > 
> > > Not whan panic-on-warn is set, which is getting more and more common
> > > these days.
> > 
> > Fair enough.  What is the recommend approach to reporting a "this should
> > never" happen situation these days?
> 
> dev_err() and handle the error properly.
> 
> 

WARN_ON is the right choice for reporting recoverable kernel bugs, and BUG_ON
for unrecoverable ones; see the two comments in include/asm-generic/bug.h which
explain this.  Please don't use dev_err() if it's a kernel bug (and not just
unexpected input from userspace or hardware behaving weirdly), as that prevents
the bug from being reported if it occurs.

Greg, you've been corrected on this before, e.g.
https://lore.kernel.org/linux-fsdevel/20210707023548.15872-1-desmondcheongzx@gmail.com/T/#u.
Please stop spreading false information as it is destroying your credibility :-(

- Eric
