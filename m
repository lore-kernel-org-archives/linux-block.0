Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:53464 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932223AbcI2Jwi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 05:52:38 -0400
Date: Thu, 29 Sep 2016 11:52:04 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        nbd-general@lists.sourceforge.net
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20160929095204.mexr6wpypo3bl6mx@grep.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475092892-8230-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Josef,

On Wed, Sep 28, 2016 at 04:01:32PM -0400, Josef Bacik wrote:
> NBD can become contended on its single connection.  We have to serialize all
> writes and we can only process one read response at a time.  Fix this by
> allowing userspace to provide multiple connections to a single nbd device.  This
> coupled with block-mq drastically increases performance in multi-process cases.
> Thanks,

This reminds me: I've been pondering this for a while, and I think there
is no way we can guarantee the correct ordering of FLUSH replies in the
face of multiple connections, since a WRITE reply on one connection may
arrive before a FLUSH reply on another which it does not cover, even if
the server has no cache coherency issues otherwise.

Having said that, there can certainly be cases where that is not a
problem, and where performance considerations are more important than
reliability guarantees; so once this patch lands in the kernel (and the
necessary support patch lands in the userland utilities), I think I'll
just update the documentation to mention the problems that might ensue,
and be done with it.

I can see only a few ways in which to potentially solve this problem:
- Kernel-side nbd-client could send a FLUSH command over every channel,
  and only report successful completion once all replies have been
  received. This might negate some of the performance benefits, however.
- Multiplexing commands over a single connection (perhaps an SCTP one,
  rather than TCP); this would require some effort though, as you said,
  and would probably complicate the protocol significantly.

Regards,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
