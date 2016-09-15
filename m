Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:60454 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbcIONSJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 09:18:09 -0400
Date: Thu, 15 Sep 2016 15:17:41 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, mpa@pengutronix.de, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915131741.cth6kilmcgnobbuu@grep.be>
References: <20160915113807.GA23259@infradead.org>
 <20160915115514.7hba23nqvvwfhb5z@grep.be>
 <20160915120125.GA31044@infradead.org>
 <20160915122120.4h3ykbewaavjk5nx@grep.be>
 <20160915122304.GA15501@infradead.org>
 <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
 <20160915123646.GA10394@infradead.org>
 <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk>
 <20160915124103.GA20657@infradead.org>
 <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 01:44:29PM +0100, Alex Bligh wrote:
> 
> > On 15 Sep 2016, at 13:41, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Thu, Sep 15, 2016 at 01:39:11PM +0100, Alex Bligh wrote:
> >> That's probably right in the case of file-based back ends that
> >> are running on a Linux OS. But gonbdserver for instance supports
> >> (e.g.) Ceph based backends, where each connection might be talking
> >> to a completely separate ceph node, and there may be no cache
> >> consistency between connections.
> > 
> > Yes, if you don't have a cache coherent backend you are generally
> > screwed with a multiqueue protocol.
> 
> I wonder if the ability to support multiqueue should be visible
> in the negotiation stage. That would allow the client to refuse
> to select multiqueue where it isn't safe.

The server can always refuse to allow multiple connections.

I was thinking of changing the spec as follows:

diff --git a/doc/proto.md b/doc/proto.md
index 217f57e..cb099e2 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -308,6 +308,23 @@ specification, the
 [kernel documentation](https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt)
 may be useful.
 
+For performance reasons, clients MAY open multiple connections to the
+same server. To support such clients, servers SHOULD ensure that at
+least one of the following conditions hold:
+
+* Flush commands are processed for ALL connections. That is, when an
+  `NBD_CMD_WRITE` is processed on one connection, and then an
+  `NBD_CMD_FLUSH` is processed on another connection, the data of the
+  `NBD_CMD_WRITE` on the first connection MUST reach permanent storage
+  before the reply of the `NBD_CMD_FLUSH` is sent.
+* The server allows `NBD_CMD_WRITE` and `NBD_CMD_FLUSH` on at most one
+  connection
+* Multiple connections are not allowed
+
+In addition, clients using multiple connections SHOULD NOT send
+`NBD_CMD_FLUSH` if an `NBD_CMD_WRITE` for which they care in relation to
+the flush has not been replied to yet.
+
 #### Request message
 
 The request message, sent by the client, looks as follows:

The latter bit (on the client side) is because even if your backend has
no cache coherency issues, TCP does not guarantee ordering between
multiple connections. I don't know if the above is in line with what
blk-mq does, but consider the following scenario:

- A client sends two writes to the server, followed (immediately) by a
  flush, where at least the second write and the flush are not sent over
  the same connection.
- The first write is a small one, and it is handled almost immediately.
- The second write takes a little longer, so the flush is handled
  earlier than the second write
- The network packet containing the flush reply gets lost for whatever
  reason, so the client doesn't get it, and we fall into TCP
  retransmits.
- The second write finishes, and its reply header does not get lost
- After the second write reply reaches the client, the TCP retransmits
  for the flush reply are handled.

In the above scenario, the flush reply arrives on the client side after
a write reply which it did not cover; so the client will (incorrectly)
assume that the write has reached permanent storage when in fact it may
not have done so yet.

If the kernel does not care about the ordering of the two writes versus
the flush, then there is no problem. I don't know how blk-mq works in
that context, but if the above is a likely scenario, we may have to
reconsider adding blk-mq to nbd.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
