Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:45312 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755183AbcIOLQ5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:16:57 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915104935.ohuwgq2chsedz6fl@grep.be>
Date: Thu, 15 Sep 2016 12:09:28 +0100
Cc: Alex Bligh <alex@alex.org.uk>, linux-block@vger.kernel.org,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Blake <eblake@redhat.com>
Message-Id: <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be>
To: Wouter Verhelst <w@uter.be>, Josef Bacik <jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wouter, Josef, (& Eric)

> On 15 Sep 2016, at 11:49, Wouter Verhelst <w@uter.be> wrote:
> 
> Hi,
> 
> On Fri, Sep 09, 2016 at 10:02:03PM +0200, Wouter Verhelst wrote:
>> I see some practical problems with this:
> [...]
> 
> One more that I didn't think about earlier:
> 
> A while back, we spent quite some time defining the semantics of the
> various commands in the face of the NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
> write barriers. At the time, we decided that it would be unreasonable
> to expect servers to make these write barriers effective across
> different connections.

Actually I wonder if there is a wider problem in that implementations
might mediate access to a device by presence of an extant TCP connection,
i.e. only permit one TCP connection to access a given block device at
once. If you think about (for instance) a forking daemon that does
writeback caching, that would be an entirely reasonable thing to do
for data consistency.

I also wonder whether any servers that can do caching per
connection will always share a consistent cache between 
connections. The one I'm worried about in particular here
is qemu-nbd - Eric Blake CC'd.

A more general point is that with multiple queues requests
may be processed in a different order even by those servers that
currently process the requests in strict order, or in something
similar to strict order. The server is permitted by the spec
(save as mandated by NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA) to
process commands out of order anyway, but I suspect this has
to date been little tested.

Lastly I confess to lack of familiarity with the kernel side
code, but how is NBD_CMD_DISCONNECT synchronised across
each of the connections? Presumably you need to send it on
each channel, but cannot assume the NBD connection as a whole
is dead until the last tcp connection has closed?

-- 
Alex Bligh




