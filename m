Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C81C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5082229F
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBKRfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:35:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51048 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKRfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 12:35:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gtFUH-00067j-UB; Mon, 11 Feb 2019 17:35:21 +0000
Date:   Mon, 11 Feb 2019 17:35:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190211173521.GI2217@ZenIV.linux.org.uk>
References: <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <20190206005638.GU2217@ZenIV.linux.org.uk>
 <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
 <20190207040058.GW2217@ZenIV.linux.org.uk>
 <73e23146-2138-5a46-46ed-9c7f1f912a04@kernel.dk>
 <20190211085533.35190404@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211085533.35190404@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 11, 2019 at 08:55:33AM -0700, Jonathan Corbet wrote:
> On Thu, 7 Feb 2019 11:45:40 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > > OK, braindump time:  
> > 
> > [snip]
> > 
> > This is great info, and I think it belongs in Documentation/ somewhere.
> > Not sure I've ever seen such a good and detailed dump of this before.
> 
> I suspect I might be able to make something like that happen :)  Stay
> tuned.

There are several typos I see in there (e.g. in

        * struct file instances A and B being AF_UNIX sockets.
        * A is a listener
        * B is an established connection, with the other end
yet to be accepted on A
        * the only references to A and B are in an SCM_RIGHTS
datagram sent over by A.

the last line should be "datagram sent over by B", of course - you can't
send anything over a listener socket, to start with).

Another thing is this:

        * references cannot be extracted from SCM_RIGHTS datagrams
while the garbage collector is running (achieved by having
unix_notinflight() done before references out of SCM_RIGHTS)
        * removal of SCM_RIGHTS associated with a socket can't
be done without a reference to that socket _outside_ of any
SCM_RIGHTS (automatically true).

That's worse than a typo - that's an actual bug (see the subthread
with Miklos).  Correct version would be
	* any references extracted from SCM_RIGHTS during the
garbage collector run will not be actually used until the end
of garbage collection.  For normal recvmsg() it is guaranteed
by having unix_notinflight() called between the extraction of
scm_fp_list from the packet and doing anything else with the
references extracted.  For MSG_PEEK recvmsg() it's actually
broken and lacks synchronization; Miklos has proposed to grab
and release unix_gc_lock in those, between scm_fp_dup() and
doing anything else with the references copied.

If you turn that thing into a coherent text, I'd appreciate a chance
to take a look at the result and see if anything else needs to be
corrected...
