Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:39250 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933464AbcIOMdX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:33:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915122304.GA15501@infradead.org>
Date: Thu, 15 Sep 2016 13:33:20 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Message-Id: <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org> <20160915122120.4h3ykbewaavjk5nx@grep.be> <20160915122304.GA15501@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 13:23, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Sep 15, 2016 at 02:21:20PM +0200, Wouter Verhelst wrote:
>> Right. So do I understand you correctly that blk-mq currently doesn't
>> look at multiple queues, and just assumes that if a FLUSH is sent over
>> any one of the queues, it applies to all queues?
> 
> Yes.  The same is true at the protocol level for NVMe or SCSI transports
> that can make use of multiple queues.

At an implementation level that is going to be a little difficult
for some NBD servers, e.g. ones that fork() a different process per
connection. There is in general no IPC to speak of between server
instances. Such servers would thus be unsafe with more than one
connection if FLUSH is in use.

I believe such servers include the reference server where there is
process per connection (albeit possibly with several threads).

Even single process servers (including mine - gonbdserver) would
require logic to pair up multiple connections to the same
device.

I suspect ALL nbd servers would require a change. So I think we should
think carefully before introducing this protocol change.

It might be easier to make the client code change work around this
issue (somehow).

-- 
Alex Bligh




