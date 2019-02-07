Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94173C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652F6218D3
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfBGQvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:51:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38868 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 11:51:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grmte-0001tv-C9; Thu, 07 Feb 2019 16:51:30 +0000
Date:   Thu, 7 Feb 2019 16:51:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190207165130.GF2217@ZenIV.linux.org.uk>
References: <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <0d2e5085-32ff-e86e-d628-6000071fd132@kernel.dk>
 <20190206010104.GV2217@ZenIV.linux.org.uk>
 <608c1102-5818-e38c-cfc7-b1cec5a1ecb4@kernel.dk>
 <20190207040547.GX2217@ZenIV.linux.org.uk>
 <51f167c6-aacc-dd5b-4481-7168c6f8b413@kernel.dk>
 <20190207163047.GE2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207163047.GE2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 07, 2019 at 04:30:47PM +0000, Al Viro wrote:
> Well, yes - once you receive it, you obviously have no references
> sitting in SCM_RIGHTS anymore.
> 
> Get rid of recv_fd() there (along with fork(), while we are at it - what's
> it for?) and just do send_fd + these 3 close (or just exit, for that matter).

If you pardon a bad ASCII graphics,

ring_fd            sv[0]             sv[1]                 (descriptors)
   |                |                  |
   V                V                  V
[io_uring]        [socket1]          [socket2]             (struct file)
 ^ |               ^  |                ^  |
 | |               |  |                |  |
 | \_______________/__|________________/  |                (after registering)
 |                    |                   |
 |                    V                   V
 |                 [unix_sock1]<---->[unix_sock2]          (struct unix_sock)
 |                                        |
 |                                        V
 \----------------------------------[SCM_RIGHTS]           (queue contents)

References from io_uring to other two struct file are added when you
register these suckers.  Reference from SCM_RIGHTS appears when you
do send_fd().  Now, each file has two references to it.  And
if you close all 3 descriptors (either explicitly, or by exiting)
you will be left with this graph:

[io_uring]------------\-------------------\
 ^                    |                   |
 |                    V                   V
 |                [socket1]          [socket2]
 |                    |                   |
 |                    V                   V
 |                 [unix_sock1]<---->[unix_sock2]
 |                                        |
 |                                        V
 \----------------------------------[SCM_RIGHTS]

All struct file still have references, so they are all still alive,
->release() isn't called on any of them.  And the entire thing
is obviously unreachable from the rest of data structures.

Of course recvmsg() would've removed the loop.  The point is, with
that situation you *can't* get it called - you'd need to reach
socket2 to do that and you can't do that anymore.
