Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:45192 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbcIOPSC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 11:18:02 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <93b5c669-fbcf-e972-fc4d-3b08f1c76299@fb.com>
Date: Thu, 15 Sep 2016 16:17:58 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Message-Id: <61FA9037-0D6C-4902-968C-11BCDEED3DC8@alex.org.uk>
References: <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org> <20160915122120.4h3ykbewaavjk5nx@grep.be> <20160915122304.GA15501@infradead.org> <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk> <20160915123646.GA10394@infradead.org> <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk> <20160915124103.GA20657@infradead.org> <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk> <20160915131741.cth6kilmcgnobbuu@grep.be> <93b5c669-fbcf-e972-fc4d-3b08f1c76299@fb.com>
To: Josef Bacik <jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Josef,

> On 15 Sep 2016, at 14:57, Josef Bacik <jbacik@fb.com> wrote:
>=20
> This isn't an NBD problem, this is an application problem.  The =
application must wait for all writes it cares about _before_ issuing a =
flush.  This is the same as for normal storage as it is for NBD.  It is =
not NBD's responsibility to maintain coherency between multiple requests =
across connections, just simply to act on and respond to requests.
>=20
> I think changing the specification to indicate that this is the case =
for multiple connections is a good thing, to keep NBD servers from doing =
weird things like sending different connections to the same export to =
different backing stores without some sort of synchronization.  It =
should definitely be explicitly stated somewhere that NBD does not =
provide any ordering guarantees and that is up to the application.  =
Thanks,

I don't think that's correct.

The block stack issues a flush to mean (precisely) "do not reply to this =
until all preceding writes THAT HAVE BEEN REPLIED TO have been persisted =
to non-volatile storage".

The danger is with multiple connections (where apparently only one flush =
is sent - let's say down connection 1) that not al the writes that have =
been replied to on connection 2 have been persisted to non-volatile =
storage. Only the ones on connection 1 have been persisted (this is =
assuming the nbd server doesn't 'link' in some way the connections).

There's nothing the 'application' (here meaning the kernel or higher =
level) can do to mitigate this. Sure it can wait for all the replies, =
but this doesn't guarantee the writes have been persisted to =
non-volatile storage, precisely because writes may return prior to this.

--=20
Alex Bligh




