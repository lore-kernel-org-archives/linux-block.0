Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:58432 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755773AbcIOMoc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:44:32 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915124103.GA20657@infradead.org>
Date: Thu, 15 Sep 2016 13:44:29 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mpa@pengutronix.de, kernel-team@fb.com
Message-Id: <DA0880DA-700F-4989-9326-68F5F7A55F25@alex.org.uk>
References: <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org> <20160915122120.4h3ykbewaavjk5nx@grep.be> <20160915122304.GA15501@infradead.org> <2ABB8966-5C20-45A7-BB4C-6882F042905D@alex.org.uk> <20160915123646.GA10394@infradead.org> <C48DD624-6EDF-4EED-B474-8BEA021F00F0@alex.org.uk> <20160915124103.GA20657@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 13:41, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Sep 15, 2016 at 01:39:11PM +0100, Alex Bligh wrote:
>> That's probably right in the case of file-based back ends that
>> are running on a Linux OS. But gonbdserver for instance supports
>> (e.g.) Ceph based backends, where each connection might be talking
>> to a completely separate ceph node, and there may be no cache
>> consistency between connections.
> 
> Yes, if you don't have a cache coherent backend you are generally
> screwed with a multiqueue protocol.

I wonder if the ability to support multiqueue should be visible
in the negotiation stage. That would allow the client to refuse
to select multiqueue where it isn't safe.

Wouter?

-- 
Alex Bligh




