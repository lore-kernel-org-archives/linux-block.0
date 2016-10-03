Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:36807 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbcJCLeb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 07:34:31 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161003075701.GA29457@infradead.org>
Date: Mon, 3 Oct 2016 12:34:33 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <97C12880-A095-4F7B-B828-1837E65F7721@alex.org.uk>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com> <20160929095204.mexr6wpypo3bl6mx@grep.be> <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com> <20160929164100.akytbkbtvziwaqqj@grep.be> <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com> <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk> <2B49072B-6F83-4CD2-863B-5AB21E1F7816@fb.com> <20161003072049.GA16847@infradead.org> <20161003075149.u3ppcnk2j55fci6h@grep.be> <20161003075701.GA29457@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 3 Oct 2016, at 08:57, Christoph Hellwig <hch@infradead.org> wrote:
>=20
>> Can you clarify what you mean by that? Why is it an "odd flush
>> definition", and how would you "properly" define it?
>=20
> E.g. take the defintion from NVMe which also supports multiple queues:
>=20
> "The Flush command shall commit data and metadata associated with the
> specified namespace(s) to non-volatile media. The flush applies to all
> commands completed prior to the submission of the Flush command.
> The controller may also flush additional data and/or metadata from any
> namespace."
>=20
> The focus is completed - we need to get a reply to the host first
> before we can send the flush command, so anything that we require
> to be flushed needs to explicitly be completed first.

I think there are two separate issues here:

a) What's described as the "HOL blocking issue".=20

This comes down to what Wouter said here:

> Well, when I asked earlier, Christoph said[1] that blk-mq assumes that
> when a FLUSH is sent over one channel, and the reply comes in, that =
all
> commands which have been received, regardless of which channel they =
were
> received over, have reched disk.
>=20
> [1] Message-ID: <20160915122304.GA15501@infradead.org>
>=20
> It is impossible for nbd to make such a guarantee, due to head-of-line
> blocking on TCP.

this is perfectly accurate as far as it goes, but this isn't the current
NBD definition of 'flush'.

That is (from the docs):

> All write commands (that includes NBD_CMD_WRITE, and NBD_CMD_TRIM) =
that the server completes (i.e. replies to) prior to processing to a =
NBD_CMD_FLUSH MUST be written to non-volatile storage prior to replying =
to thatNBD_CMD_FLUSH. This paragraph only applies if NBD_FLAG_SEND_FLUSH =
is set within the transmission flags, as otherwise NBD_CMD_FLUSH will =
never be sent by the client to the server.

I don't think HOL blocking is an issue here by that definition, because =
all FLUSH requires is that commands that are actually completed are =
flushed to disk. If there is head of line blocking which delays the =
arrival of a write issued before a flush, then the sender cannot be =
relying on whether that write is actually completed or not (or it would =
have waited for the result). The flush requires only that those commands =
COMPLETED are flushed to disk, not that those commands RECEIVED have =
been flushed to disk (and a fortiori not that those commands SENT FIRST) =
have been flushed to disk. =46rom the point of view of the client, the =
flush can therefore only guarantee that the data associated with those =
commands for which it's actually received a reply prior to issuing the =
flush will be flushed, because the replies can be disordered too.

I don't think there is actually a problem here - Wouter if I'm wrong =
about this, I'd like to understand your argument better.



b) What I'm describing - which is the lack of synchronisation between =
channels.

Suppose you have a simple forking NBD server which uses (e.g.) a Ceph =
backend. Each process (i.e. each NBD channel) will have a separate =
connection to something with its own cache and buffering. Issuing a =
flush in Ceph requires waiting until a quorum of backends (OSDs) has =
been written to, and with a number of backends substantially greater =
than the quorum, it is not unlikely that a flush on one channel will not =
wait for writes on what Ceph considers a completely independent channel =
to have fully written (assuming the write completes before the flush is =
done).

The same would happen pretty trivially with a forking server that uses a =
process-space write-back cache.

This is because the spec when the spec says: "All write commands (that =
includes NBD_CMD_WRITE, and NBD_CMD_TRIM) that the server completes =
(i.e. replies to) prior to processing to a NBD_CMD_FLUSH MUST be written =
to non-volatile storage prior to replying to that NBD_CMD_FLUSH." what =
it currently means is actually "All write commands (that includes =
NBD_CMD_WRITE, and NBD_CMD_TRIM) ***ASSOCIATED WITH THAT CLIENT*** that =
the server completes (i.e. replies to) prior to processing to a =
NBD_CMD_FLUSH MUST be written to non-volatile storage prior to replying =
to that NBD_CMD_FLUSH".=20

So what we would need the spec to mean is "All write commands (that =
includes NBD_CMD_WRITE, and NBD_CMD_TRIM) ***ASSOCIATED WITH ANY CHANNEL =
OF THAT CLIENT*** that the server completes (i.e. replies to) prior to =
processing to a NBD_CMD_FLUSH MUST be written to non-volatile storage =
prior to replying to that NBD_CMD_FLUSH". And as we have no way to =
associate different channels of the same client, for servers that can't =
rely on the OS to synchronise flushing across different clients relating =
to the same file, in practice that means "All write commands (that =
includes NBD_CMD_WRITE, and NBD_CMD_TRIM) ***ASSOCIATED WITH ANY CLIENT =
AT ALL*** that the server completes (i.e. replies to) prior to =
processing to a NBD_CMD_FLUSH MUST be written to non-volatile storage =
prior to replying to that NBD_CMD_FLUSH" - i.e. a flush on any channel =
of any client must flush every channel of every client, because we have =
no easy way to tell which clients are in fact two channels. I have =
concerns over the scalability of this.

Now, in the reference server, NBD_CMD_FLUSH is implemented through an =
fdatasync(). Each client (and therefore each channel) runs in a =
different process.

Earlier in this thread, someone suggested that if this happens:

      Process A                Process B
      =3D=3D=3D=3D=3D=3D=3D=3D=3D                =3D=3D=3D=3D=3D=3D=3D=3D=3D=


      fd1=3Dopen("file123")
                               fd2=3Dopen("file123")

      write(fd1, ...)
                               fdatasync("fd2")

then the fdatasync() is guaranteed to sync the write that Process A has =
written. This may or may not be the case under Linux (wiser minds than =
me will know). Is it guaranteed to be the case with (e.g.) the file on =
NFS? On all POSIX platforms?

Looking at =
http://pubs.opengroup.org/onlinepubs/009695399/functions/fdatasync.html =
I'd say it was a little ambiguous as to whether it will ALWAYS flush all =
data associated with the file even if it is being written by a different =
process (and a different FD).

If fdatasync() is always guaranteed to flush data associated with writes =
by a different process (and separately opened fd), then as it happens =
there won't be a problem on the reference server, just on servers that =
don't happen to use fdatasync() or similar to implement flushes, and =
which don't maintain their own caches. If fdatasync() is not so =
guaranteed, we have a problem with the reference server too, at least on =
some platforms and fling systems.

What I'm therefore asking for is either:
a) that the server can say 'if you are multichannel, you will need to =
send flush on each channel' (best); OR
b) that the server can say 'don't go multichannel'

as part of the negotiation stage. Of course as this is dependent on the =
backend, this is going to be something that is per-target (i.e. needs to =
come as a transmission flag or similar).

--=20
Alex Bligh




