Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:35502 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765949AbcIOKuV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 06:50:21 -0400
Date: Thu, 15 Sep 2016 12:49:35 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, mpa@pengutronix.de,
        kernel-team@fb.com, nbd-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915104935.ohuwgq2chsedz6fl@grep.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160909200203.phhvodsfs7ymukfp@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On Fri, Sep 09, 2016 at 10:02:03PM +0200, Wouter Verhelst wrote:
> I see some practical problems with this:
[...]

One more that I didn't think about earlier:

A while back, we spent quite some time defining the semantics of the
various commands in the face of the NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
write barriers. At the time, we decided that it would be unreasonable
to expect servers to make these write barriers effective across
different connections.

Since my knowledge of kernel internals is limited, I tried finding some
documentation on this, but I guess that either it doesn't exist or I'm
looking in the wrong place; therefore, am I correct in assuming that
blk-mq knows about such semantics, and will handle them correctly (by
either sending a write barrier to all queues, or not making assumptions
about write barriers that were sent over a different queue)? If not,
this may be something that needs to be taken care of.

Thanks,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
