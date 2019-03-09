Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F334C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 03:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E58D20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 03:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCIDDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:03:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46810 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCIDDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 22:03:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2SH2-0004Gp-4b; Sat, 09 Mar 2019 03:03:44 +0000
Date:   Sat, 9 Mar 2019 03:03:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
Message-ID: <20190309030343.GF2217@ZenIV.linux.org.uk>
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk>
 <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
 <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
 <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCvMXSbuDmPAZ1sHzuQFxzuVsrh4Q8rQmB9nooP8QOKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 03:36:46PM -0800, Linus Torvalds wrote:

> I'm getting the very strong signal that this code had all the logic
> taken from fs/aio.c, bugs and all.

Definitely.

> Al has patches to fix the aio.c cases. I very much suspect some very
> similar patches are needed in fs/io_ring.c.

Very likely so.  BTW, another lovely problem is that read from
a registered AF_UNIX socket really needs an extra reference to
struct file that would *NOT* be covered by ->inflight.  Otherwise
we are asking for serious trouble with garbage collector...
