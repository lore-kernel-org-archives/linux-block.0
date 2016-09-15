Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:50430 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbcIOQIZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:08:25 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915131741.cth6kilmcgnobbuu@grep.be>
Date: Thu, 15 Sep 2016 17:08:21 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, mpa@pengutronix.de, kernel-team@fb.com
Message-Id: <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk>
References: <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org> <20160915122120.4h3ykbewaavjk5nx@grep.be> <20160915122304.GA15501@infradead.org> <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk> <20160915123646.GA10394@infradead.org> <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk> <20160915124103.GA20657@infradead.org> <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk> <20160915131741.cth6kilmcgnobbuu@grep.be>
To: Wouter Verhelst <w@uter.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wouter,

> The server can always refuse to allow multiple connections.

Sure, but it would be neater to warn the client of that
at negotiation stage (it would only be one flag, e.g.
'multiple connections unsafe'). That way the connection
won't fail with a cryptic EBUSY or whatever, but will
just negotiate a single connection.

> I was thinking of changing the spec as follows:
>=20
> diff --git a/doc/proto.md b/doc/proto.md
> index 217f57e..cb099e2 100644
> --- a/doc/proto.md
> +++ b/doc/proto.md
> @@ -308,6 +308,23 @@ specification, the
> [kernel =
documentation](https://www.kernel.org/doc/Documentation/block/writeback_ca=
che_control.txt)
> may be useful.
>=20
> +For performance reasons, clients MAY open multiple connections to the
> +same server. To support such clients, servers SHOULD ensure that at
> +least one of the following conditions hold:
> +
> +* Flush commands are processed for ALL connections. That is, when an
> +  `NBD_CMD_WRITE` is processed on one connection, and then an
> +  `NBD_CMD_FLUSH` is processed on another connection, the data of the
> +  `NBD_CMD_WRITE` on the first connection MUST reach permanent =
storage
> +  before the reply of the `NBD_CMD_FLUSH` is sent.
> +* The server allows `NBD_CMD_WRITE` and `NBD_CMD_FLUSH` on at most =
one
> +  connection
> +* Multiple connections are not allowed
> +
> +In addition, clients using multiple connections SHOULD NOT send
> +`NBD_CMD_FLUSH` if an `NBD_CMD_WRITE` for which they care in relation =
to
> +the flush has not been replied to yet.
> +

I don't think that should be a mandatory behaviour. For once, it would
be reasonably easy on gonbdserver but a PITA on the reference server.
You'd need to put in IPC between each of the forked processes OR rely
on fdatasync() only - I'm not sure that would necessarily work
safely with (e.g.) the 'treefiles' / COW options.

I think better would be to say that the server MUST either

* Not support NBD_CMD_FLUSH at all
* Support NBD_CMD_FLUSH across channels (as you set out above), or
* Indicate that it does not support multiple channels.

> #### Request message
>=20
> The request message, sent by the client, looks as follows:
>=20
> The latter bit (on the client side) is because even if your backend =
has
> no cache coherency issues, TCP does not guarantee ordering between
> multiple connections. I don't know if the above is in line with what
> blk-mq does, but consider the following scenario:
>=20
> - A client sends two writes to the server, followed (immediately) by a
>  flush, where at least the second write and the flush are not sent =
over
>  the same connection.
> - The first write is a small one, and it is handled almost =
immediately.
> - The second write takes a little longer, so the flush is handled
>  earlier than the second write
> - The network packet containing the flush reply gets lost for whatever
>  reason, so the client doesn't get it, and we fall into TCP
>  retransmits.
> - The second write finishes, and its reply header does not get lost
> - After the second write reply reaches the client, the TCP retransmits
>  for the flush reply are handled.
>=20
> In the above scenario, the flush reply arrives on the client side =
after
> a write reply which it did not cover; so the client will (incorrectly)
> assume that the write has reached permanent storage when in fact it =
may
> not have done so yet.
>=20
> If the kernel does not care about the ordering of the two writes =
versus
> the flush, then there is no problem. I don't know how blk-mq works in
> that context, but if the above is a likely scenario, we may have to
> reconsider adding blk-mq to nbd.

Actually I think this is a problem anyway. A simpler failure case is
one where (by chance) one channel gets the writes, and one channel
gets the flushes. The flush reply is delayed beyond the replies to
unconnected writes (on the other channel) and hence the kernel thinks
replied-to writes have been persisted when they have not been.

The only way to fix that (as far as I can see) without changing flush
semantics is for the block layer to issue flush requests on each
channel when flushing on one channel. This, incidentally, would
resolve every other issue!

--=20
Alex Bligh




