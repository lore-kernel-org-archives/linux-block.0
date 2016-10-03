Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:51576 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbcJCOq6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 10:46:58 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <5cf31839-3642-166a-55ab-8d4313025b0c@fb.com>
Date: Mon, 3 Oct 2016 15:46:53 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Wouter Verhelst <w@uter.be>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <A8EF4CD3-61BC-4E29-8796-1013FDBC96F1@alex.org.uk>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com> <20160929095204.mexr6wpypo3bl6mx@grep.be> <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com> <20160929164100.akytbkbtvziwaqqj@grep.be> <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com> <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk> <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com> <20161003072049.GA16847@infradead.org> <20161003075149.u3ppcnk2j55fci6h@grep.be> <20161003075701.GA29457@infradead.org> <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk> <5cf31839-3642-166a-55ab-8d4313025b0c@fb.com>
To: Josef Bacik <jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Josef,

> On 3 Oct 2016, at 15:32, Josef Bacik <jbacik@fb.com> wrote:
>=20
> Ok I understand your objections now.  You aren't arguing that we are =
unsafe by default, only that we are unsafe with servers that do =
something special beyond simply writing to a single disk or file.  I =
agree this is problematic, but you simply don't use this feature if your =
server can't deal with it well.

Not quite. I am arguing that:

1. Parallel channels as currently implemented are inherently unsafe on =
some servers - I have given an example of such servers

2. Parallel channels as currently implemented may be unsafe on the =
reference server on some or all platforms (depending on the behaviour of =
fdatasync() which might varies between platforms)

3. Either the parallel channels stuff should issue flush requests on all =
channels, or the protocol should protect the unwitting user by =
negotiating an option to do so (or refusing multi-channel connects). It =
is not reasonable for an nbd client to have to know the intimate details =
of the server and its implementation of synchronisation primitives - =
saying 'the user should disable multiple channels' is not good enough, =
as this is what we have a protocol for.

"unsafe" here means 'do not conform to the kernel's requirements for =
flush semantics, whereas they did without multiple channels'

So from my point of view either we need to have an additional connection =
flag ("don't use multiple channels unless you are going to issue a flush =
on all channels") OR flush on all channels should be the default.

Whatever SOME more work needs to be done on your patch because there it =
current doesn't issue flush on all channels, and it currently does not =
have any way to prevent use of multiple channels.


I'd really like someone with linux / POSIX knowledge to confirm the =
linux and POSIX position on fdatasync of an fd opened by one process on =
writes made to the same file by another process. If on all POSIX =
platforms and all filing systems this is guaranteed to flush the second =
platform's writes, then I think we could argue "OK there may be some =
weird servers which might not support multiple channels and they just =
need a way of signalling that". If on the other hand there is no such =
cross platform guarantee, I think this means in essence even with the =
reference server, this patch is unsafe, and it needs adapting to send =
flushes on all channels - yes it might theoretically be possible to =
introduce IPC to the current server, but you'd still need some way of =
tying together channels from a single client.

--=20
Alex Bligh




