Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F20C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 04:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C352084D
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 04:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBGEFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:05:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58746 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGEFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 23:05:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grawe-0003Vq-2f; Thu, 07 Feb 2019 04:05:48 +0000
Date:   Thu, 7 Feb 2019 04:05:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190207040547.GX2217@ZenIV.linux.org.uk>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <0d2e5085-32ff-e86e-d628-6000071fd132@kernel.dk>
 <20190206010104.GV2217@ZenIV.linux.org.uk>
 <608c1102-5818-e38c-cfc7-b1cec5a1ecb4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608c1102-5818-e38c-cfc7-b1cec5a1ecb4@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 06, 2019 at 10:56:41AM -0700, Jens Axboe wrote:
> On 2/5/19 6:01 PM, Al Viro wrote:
> > On Tue, Feb 05, 2019 at 05:27:29PM -0700, Jens Axboe wrote:
> > 
> >> This should be better, passes some basic testing, too:
> >>
> >> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=01a93aa784319a02ccfa6523371b93401c9e0073
> >>
> >> Verified that we're grabbing the right refs, and don't hold any
> >> ourselves. For the file registration, forbid registration of the
> >> io_uring fd, as that is pointless and will introduce a loop regardless
> >> of fd passing.
> > 
> > *shrug*
> > 
> > So pass it to AF_UNIX socket and register _that_ - does't change the
> > underlying problem.
> 
> Maybe I'm being dense here, but it's an f_op match. Should catch a
> passed fd as well, correct?

f_op match on _what_?

> With that, how can there be a loop?

	io_uring_fd = ....
	socketpair(PF_UNIX, SOCK_STREAM, 0, sock_fds);
	register sock_fds[0] and sock_fds[1] to io_uring_fd
	send SCM_RIGHTS datagram with io_uring_fd to sock_fds[0]
	close sock_fds[0], sock_fds[1] and io_uring_fd

And there's your unreachable loop.
