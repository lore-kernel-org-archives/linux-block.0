Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0590C169C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C12083B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 02:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBDC4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Feb 2019 21:56:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36992 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfBDC4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Feb 2019 21:56:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gqUQe-00059W-6w; Mon, 04 Feb 2019 02:56:12 +0000
Date:   Mon, 4 Feb 2019 02:56:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190204025612.GR2217@ZenIV.linux.org.uk>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 02:29:05AM +0100, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> > We normally have to fget/fput for each IO we do on a file. Even with
> > the batching we do, the cost of the atomic inc/dec of the file usage
> > count adds up.
> >
> > This adds IORING_REGISTER_FILES, and IORING_UNREGISTER_FILES opcodes
> > for the io_uring_register(2) system call. The arguments passed in must
> > be an array of __s32 holding file descriptors, and nr_args should hold
> > the number of file descriptors the application wishes to pin for the
> > duration of the io_uring context (or until IORING_UNREGISTER_FILES is
> > called).
> >
> > When used, the application must set IOSQE_FIXED_FILE in the sqe->flags
> > member. Then, instead of setting sqe->fd to the real fd, it sets sqe->fd
> > to the index in the array passed in to IORING_REGISTER_FILES.
> >
> > Files are automatically unregistered when the io_uring context is
> > torn down. An application need only unregister if it wishes to
> > register a new set of fds.
> 
> Crazy idea:
> 
> Taking a step back, at a high level, basically this patch creates sort
> of the same difference that you get when you compare the following
> scenarios for normal multithreaded I/O in userspace:

> This kinda makes me wonder whether this is really something that
> should be implemented specifically for the io_uring API, or whether it
> would make sense to somehow handle part of this in the generic VFS
> code and give the user the ability to prepare a new files_struct that
> can then be transferred to the worker thread, or something like
> that... I'm not sure whether there's a particularly clean way to do
> that though.

Using files_struct for that opens a can of worms you really don't
want to touch.

Consider the following scenario with any variant of this interface:
	* create io_uring fd.
	* send an SCM_RIGHTS with that fd to AF_UNIX socket.
	* add the descriptor of that AF_UNIX socket to your fd
	* close AF_UNIX fd, close io_uring fd.
Voila - you've got a shiny leak.  No ->release() is called for
anyone (and you really don't want to do that on ->flush(), because
otherwise a library helper doing e.g. system("/bin/date") will tear
down all the io_uring in your process).  The socket is held by
the reference you've stashed into io_uring (whichever way you do
that).  io_uring is held by the reference you've stashed into
SCM_RIGHTS datagram in queue of the socket.

No matter what, you need net/unix/garbage.c to be aware of that stuff.
And getting files_struct lifetime mixed into that would be beyond
any reason.

The only reason for doing that as a descriptor table would be
avoiding the cost of fget() in whatever uses it, right?  Since
those are *not* the normal syscalls (and fdget() really should not
be used anywhere other than the very top of syscall's call chain -
that's another reason why tossing file_struct around like that
is insane) and since the benefit is all due to the fact that it's
*NOT* shared, *NOT* modified in parallel, etc., allowing us to
treat file references as stable... why the hell use the descriptor
tables at all?

All you need is an array of struct file *, explicitly populated.
With net/unix/garbage.c aware of such beasts.  Guess what?  We
do have such an object already.  The one net/unix/garbage.c is
working with.  SCM_RIGHTS datagrams, that is.

IOW, can't we give those io_uring descriptors associated struct
unix_sock?  No socket descriptors, no struct socket (probably),
just the AF_UNIX-specific part thereof.  Then teach
unix_inflight()/unix_notinflight() about getting unix_sock out
of these guys (incidentally, both would seem to benefit from
_not_ touching unix_gc_lock in case when there's no unix_sock
attached to file we are dealing with - I might be missing
something very subtle about barriers there, but it doesn't
look likely).

And make that (i.e. registering the descriptors) mandatory.
Hell, combine that with creating io_uring fd, if we really
care about the syscall count.  Benefits:
	* no file_struct refcount wanking
	* no fget()/fput() (conditional, at that) from kernel
threads
	* no CLOEXEC-dependent anything; just the teardown
on the final fput(), whichever way it comes.
	* no fun with duelling garbage collectors.
