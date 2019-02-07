Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C6C282C4
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A332175B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBGQ0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:26:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38562 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGQ0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 11:26:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grmV3-00011I-Ul; Thu, 07 Feb 2019 16:26:06 +0000
Date:   Thu, 7 Feb 2019 16:26:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        linux-aio <linux-aio@kvack.org>, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190207162605.GD2217@ZenIV.linux.org.uk>
References: <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <20190206005638.GU2217@ZenIV.linux.org.uk>
 <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
 <20190207040058.GW2217@ZenIV.linux.org.uk>
 <20190207092253.GD19821@veci.piliscsaba.redhat.com>
 <20190207133135.GZ2217@ZenIV.linux.org.uk>
 <CAJfpegutRaXZ8EC_Am_PomxwdmSoH7eQkxAewaLfUrMALjym-w@mail.gmail.com>
 <20190207152002.GC2217@ZenIV.linux.org.uk>
 <CAJfpegvayM_ZmuVetfYzpK+qqZJPkVzfQVRQ7OO98f1=reqiYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvayM_ZmuVetfYzpK+qqZJPkVzfQVRQ7OO98f1=reqiYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 07, 2019 at 04:27:13PM +0100, Miklos Szeredi wrote:
> On Thu, Feb 7, 2019 at 4:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Feb 07, 2019 at 03:20:06PM +0100, Miklos Szeredi wrote:
> >
> > > > Am I right assuming that this queue-modifying operation is accept(), removing
> > > > an embryo unix_sock from the queue of listener and thus hiding SCM_RIGHTS in
> > > > _its_ queue from scan_children()?
> > >
> > > Hmm... How about just receiving an SCM_RIGHTS socket (which was a
> > > candidate) from the queue of the peeked socket?
> >
> > Right, skb unlinked before unix_detach_fds().  I was actually thinking of a stream
> > case, where unlink is done after that...
> >
> > *grumble*
> >
> > The entire thing is far too brittle for my taste ;-/
> 
> If it gets used as part of io_uring, I guess it's worth a fresh look.
> I wrote it without basically any experience with either networking or
> garbage collecting, so no wonder it has rough edges.

It had a plenty of those edges before your changes as well - I'm not blaming you
for that mess, in case that's not obvious from what I'd written.

I'm trying to put together some formal description of what's going on in there.
Another question, BTW: updates of user->unix_inflight would seem to be movable
into the callers of unix_{not,}inflight().  Any objections against lifting
it into unix_{attach,detach}_fds()?  We do, after all, have fp->count right
there, so what's the point incrementing/decrementing the sucker one-by-one?
_And_ we are checking it right there (in too_many_unix_fds() called from
unix_attach_fds())...
