Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:49483 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933540AbcIOMEa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:04:30 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915115217.GB6411@infradead.org>
Date: Thu, 15 Sep 2016 13:04:27 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Message-Id: <E19F1FFC-3112-40EE-8935-306CC5B039C2@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk> <20160915112936.vb7zxe7k6rvczosg@grep.be> <20160915114005.GC23259@infradead.org> <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk> <20160915115217.GB6411@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 12:52, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Thu, Sep 15, 2016 at 12:46:07PM +0100, Alex Bligh wrote:
>> Essentially NBD does supports FLUSH/FUA like this:
>>=20
>> =
https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt=

>>=20
>> IE supports the same FLUSH/FUA primitives as other block drivers =
(AIUI).
>>=20
>> Link to protocol (per last email) here:
>>=20
>> =
https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-a=
nd-writes
>=20
> Flush as defined by the Linux block layer (and supported that way in
> SCSI, ATA, NVMe) only requires to flush all already completed writes
> to non-volatile media.  It does not impose any ordering unlike the
> nbd spec.

As maintainer of the NBD spec, I'm confused as to why you think it
imposes any ordering - if you think this, clearly I need to clean up
the wording.

Here's what it says:

> The server MAY process commands out of order, and MAY reply out of =
order,
> except that:
>=20
> 	=E2=80=A2 All write commands (that includes NBD_CMD_WRITE, and =
NBD_CMD_TRIM)
> that the server completes (i.e. replies to) prior to processing to a
> NBD_CMD_FLUSH MUST be written to non-volatile storage prior to =
replying to that
> NBD_CMD_FLUSH. This paragraph only applies if NBD_FLAG_SEND_FLUSH is =
set within
> the transmission flags, as otherwise NBD_CMD_FLUSH will never be sent =
by the
> client to the server.

(and another bit re FUA that isn't relevant here).

Here's the Linux Kernel documentation:

> The REQ_PREFLUSH flag can be OR ed into the r/w flags of a bio =
submitted from
> the filesystem and will make sure the volatile cache of the storage =
device
> has been flushed before the actual I/O operation is started.  This =
explicitly
> guarantees that previously completed write requests are on =
non-volatile
> storage before the flagged bio starts. In addition the REQ_PREFLUSH =
flag can be
> set on an otherwise empty bio structure, which causes only an explicit =
cache
> flush without any dependent I/O.  It is recommend to use
> the blkdev_issue_flush() helper for a pure cache flush.


I believe that NBD treats NBD_CMD_FLUSH the same as a REQ_PREFLUSH and =
empty
bio.

If you don't read those two as compatible, I'd like to understand why =
not
(i.e. what additional constraints one is applying that the other is not)
as they are meant to be the same (save that NBD only has FLUSH as a =
command,
i.e. the 'empty bio' version). I am happy to improve the docs to make it
clearer.

(sidenote: I am interested in the change from REQ_FLUSH to REQ_PREFLUSH,
but in an empty bio it's not really relevant I think).

> FUA as defined by the Linux block layer (and supported that way in =
SCSI,
> ATA, NVMe) only requires the write operation the FUA bit is set on to =
be
> on non-volatile media before completing the write operation.  It does
> not impose any ordering, which seems to match the nbd spec.  Unlike =
the
> NBD spec Linux does not allow FUA to be set on anything by WRITE
> commands.  Some other storage protocols allow a FUA bit on READ
> commands or other commands that write data to the device, though.

I think you mean "anything *but* WRITE commands". In NBD setting
FUA on a command that does not write will do nothing, but FUA can
be set on NBD_CMD_TRIM and has the expected effect.

Interestingly the kernel docs are silent on which commands REQ_FUA
can be set on.

--=20
Alex Bligh




