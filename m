Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934132AbcION6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 09:58:42 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
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
 <20160915131741.cth6kilmcgnobbuu@grep.be>
CC: Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <mpa@pengutronix.de>,
        <kernel-team@fb.com>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <93b5c669-fbcf-e972-fc4d-3b08f1c76299@fb.com>
Date: Thu, 15 Sep 2016 09:57:25 -0400
MIME-Version: 1.0
In-Reply-To: <20160915131741.cth6kilmcgnobbuu@grep.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/15/2016 09:17 AM, Wouter Verhelst wrote:
> On Thu, Sep 15, 2016 at 01:44:29PM +0100, Alex Bligh wrote:
>>
>>> On 15 Sep 2016, at 13:41, Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> On Thu, Sep 15, 2016 at 01:39:11PM +0100, Alex Bligh wrote:
>>>> That's probably right in the case of file-based back ends that
>>>> are running on a Linux OS. But gonbdserver for instance supports
>>>> (e.g.) Ceph based backends, where each connection might be talking
>>>> to a completely separate ceph node, and there may be no cache
>>>> consistency between connections.
>>>
>>> Yes, if you don't have a cache coherent backend you are generally
>>> screwed with a multiqueue protocol.
>>
>> I wonder if the ability to support multiqueue should be visible
>> in the negotiation stage. That would allow the client to refuse
>> to select multiqueue where it isn't safe.
>
> The server can always refuse to allow multiple connections.
>
> I was thinking of changing the spec as follows:
>
> diff --git a/doc/proto.md b/doc/proto.md
> index 217f57e..cb099e2 100644
> --- a/doc/proto.md
> +++ b/doc/proto.md
> @@ -308,6 +308,23 @@ specification, the
>  [kernel documentation](https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt)
>  may be useful.
>
> +For performance reasons, clients MAY open multiple connections to the
> +same server. To support such clients, servers SHOULD ensure that at
> +least one of the following conditions hold:
> +
> +* Flush commands are processed for ALL connections. That is, when an
> +  `NBD_CMD_WRITE` is processed on one connection, and then an
> +  `NBD_CMD_FLUSH` is processed on another connection, the data of the
> +  `NBD_CMD_WRITE` on the first connection MUST reach permanent storage
> +  before the reply of the `NBD_CMD_FLUSH` is sent.
> +* The server allows `NBD_CMD_WRITE` and `NBD_CMD_FLUSH` on at most one
> +  connection
> +* Multiple connections are not allowed
> +
> +In addition, clients using multiple connections SHOULD NOT send
> +`NBD_CMD_FLUSH` if an `NBD_CMD_WRITE` for which they care in relation to
> +the flush has not been replied to yet.
> +
>  #### Request message
>
>  The request message, sent by the client, looks as follows:
>
> The latter bit (on the client side) is because even if your backend has
> no cache coherency issues, TCP does not guarantee ordering between
> multiple connections. I don't know if the above is in line with what
> blk-mq does, but consider the following scenario:
>
> - A client sends two writes to the server, followed (immediately) by a
>   flush, where at least the second write and the flush are not sent over
>   the same connection.
> - The first write is a small one, and it is handled almost immediately.
> - The second write takes a little longer, so the flush is handled
>   earlier than the second write
> - The network packet containing the flush reply gets lost for whatever
>   reason, so the client doesn't get it, and we fall into TCP
>   retransmits.
> - The second write finishes, and its reply header does not get lost
> - After the second write reply reaches the client, the TCP retransmits
>   for the flush reply are handled.
>
> In the above scenario, the flush reply arrives on the client side after
> a write reply which it did not cover; so the client will (incorrectly)
> assume that the write has reached permanent storage when in fact it may
> not have done so yet.

This isn't an NBD problem, this is an application problem.  The application must 
wait for all writes it cares about _before_ issuing a flush.  This is the same 
as for normal storage as it is for NBD.  It is not NBD's responsibility to 
maintain coherency between multiple requests across connections, just simply to 
act on and respond to requests.

I think changing the specification to indicate that this is the case for 
multiple connections is a good thing, to keep NBD servers from doing weird 
things like sending different connections to the same export to different 
backing stores without some sort of synchronization.  It should definitely be 
explicitly stated somewhere that NBD does not provide any ordering guarantees 
and that is up to the application.  Thanks,

Josef
