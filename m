Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:33382 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbcIOQm1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 12:42:27 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915162714.om3rwucexi5ogjtm@grep.be>
Date: Thu, 15 Sep 2016 17:42:22 +0100
Cc: Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com
Message-Id: <47676832-5A50-4894-80D2-9AB9287AEA42@alex.org.uk>
References: <20160915120125.GA31044@infradead.org> <20160915122120.4h3ykbewaavjk5nx@grep.be> <20160915122304.GA15501@infradead.org> <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk> <20160915123646.GA10394@infradead.org> <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk> <20160915124103.GA20657@infradead.org> <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk> <20160915131741.cth6kilmcgnobbuu@grep.be> <ECDC1983-E21B-48D5-892D-63CA3572B2B4@alex.org.uk> <20160915162714.om3rwucexi5ogjtm@grep.be>
To: Wouter Verhelst <w@uter.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Wouter,

> On 15 Sep 2016, at 17:27, Wouter Verhelst <w@uter.be> wrote:
>=20
> On Thu, Sep 15, 2016 at 05:08:21PM +0100, Alex Bligh wrote:
>> Wouter,
>>=20
>>> The server can always refuse to allow multiple connections.
>>=20
>> Sure, but it would be neater to warn the client of that at =
negotiation
>> stage (it would only be one flag, e.g.  'multiple connections
>> unsafe').
>=20
> I suppose that's not a bad idea.

Good.

> [...]
>>> I was thinking of changing the spec as follows:
>>>=20
>>> diff --git a/doc/proto.md b/doc/proto.md
>>> index 217f57e..cb099e2 100644
>>> --- a/doc/proto.md
>>> +++ b/doc/proto.md
>>> @@ -308,6 +308,23 @@ specification, the
>>> [kernel =
documentation](https://www.kernel.org/doc/Documentation/block/writeback_ca=
che_control.txt)
>>> may be useful.
>>>=20
>>> +For performance reasons, clients MAY open multiple connections to =
the
>>> +same server. To support such clients, servers SHOULD ensure that at
>>> +least one of the following conditions hold:
>>> +
>>> +* Flush commands are processed for ALL connections. That is, when =
an
>>> +  `NBD_CMD_WRITE` is processed on one connection, and then an
>>> +  `NBD_CMD_FLUSH` is processed on another connection, the data of =
the
>>> +  `NBD_CMD_WRITE` on the first connection MUST reach permanent =
storage
>>> +  before the reply of the `NBD_CMD_FLUSH` is sent.
>>> +* The server allows `NBD_CMD_WRITE` and `NBD_CMD_FLUSH` on at most =
one
>>> +  connection
>>> +* Multiple connections are not allowed
>>> +
>>> +In addition, clients using multiple connections SHOULD NOT send
>>> +`NBD_CMD_FLUSH` if an `NBD_CMD_WRITE` for which they care in =
relation to
>>> +the flush has not been replied to yet.
>>> +
>>=20
>> I don't think that should be a mandatory behaviour.
>=20
> Which part of it?

I've read it again :-) The wording was slightly contorted. I think
what I mean is that if you don't support flush at all, that's
another option.

The final paragraph I am not sure is right, as that's not what the =
kernel
currently does. If we are going to suggest a change in our main client's
behaviour, should we not just request that flush is done on all =
channels?

>> For once, it would
>> be reasonably easy on gonbdserver but a PITA on the reference server.
>> You'd need to put in IPC between each of the forked processes OR rely
>> on fdatasync() only - I'm not sure that would necessarily work
>> safely with (e.g.) the 'treefiles' / COW options.
>>=20
>> I think better would be to say that the server MUST either
>>=20
>> * Not support NBD_CMD_FLUSH at all
>=20
> I think we should discourage not supporting FLUSH, rather than
> suggesting it.=20

Sure, but some backends just don't support flush. For them, this
aspect at least is not a problem.

>> * Support NBD_CMD_FLUSH across channels (as you set out above), or
>> * Indicate that it does not support multiple channels.
>=20
> You dropped the one with no writes. I said "at most" there for a =
reason.
> Originally I was going to say "if the server is read-only", but then
> thought that it could work to do the "at most" thing. After having =
given
> that some more thought, I now realize that if you write, you need to
> flush across to other channels, regardless of whether they write too, =
so
> that bit of it is moot now anyway.
>=20
> Still, a server which exports read-only should still be safe for
> multiple connections, even if there is no cache coherency (since
> presumably nothing's going to change anyway).

Yes

>> Actually I think this is a problem anyway. A simpler failure case is
>> one where (by chance) one channel gets the writes, and one channel
>> gets the flushes. The flush reply is delayed beyond the replies to
>> unconnected writes (on the other channel) and hence the kernel thinks
>> replied-to writes have been persisted when they have not been.
>=20
> Yes, that is another example of essentially the same problem.

Yeah, I was just trying to simplify things.

>> The only way to fix that (as far as I can see) without changing flush
>> semantics is for the block layer to issue flush requests on each
>> channel when flushing on one channel.
>=20
> Christoph just said that that doesn't (currently) happen; I don't know
> whether the kernel currently already (optimistically) sends out flush
> requests before the writes that it expects to hit permanent storage =
have
> finished, but if it doesn't do that, then there is no problem and my
> suggested bit of spec would be okay.
>=20
> If there are good reasons to do so, however, we do indeed have a =
problem
> and something else is necessary. I don't think flushing across all
> connections is the best solution, though.

Well, the way I look at it is that we have a proposed change in
client behaviour (multiple channels) which causes problems at
least with flush and also (I think) with cache coherency (see other
email). We should either not make that change, or ensure other changes
are added which mitigate these issues.

Flush is actually the obvious one. Cache coherency is far more
subtle (though possibly fixable by something in the spec that
states that if multiple connections are supported, cache must
be coherent between them).

--=20
Alex Bligh




