Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:60853 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbcIOLqJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:46:09 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915114005.GC23259@infradead.org>
Date: Thu, 15 Sep 2016 12:46:07 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Message-Id: <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk> <20160915112936.vb7zxe7k6rvczosg@grep.be> <20160915114005.GC23259@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 12:40, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Thu, Sep 15, 2016 at 01:29:36PM +0200, Wouter Verhelst wrote:
>> Yes, and that is why I was asking about this. If the write barriers
>> are expected to be shared across connections, we have a problem. If,
>> however, they are not, then it doesn't matter that the commands may =
be
>> processed out of order.
>=20
> There is no such thing as a write barrier in the Linux kernel.  We'd
> much prefer protocols not to introduce any pointless synchronization
> if we can avoid it.

I suspect the issue is terminological.

Essentially NBD does supports FLUSH/FUA like this:

=
https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt=


IE supports the same FLUSH/FUA primitives as other block drivers (AIUI).

Link to protocol (per last email) here:

=
https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-a=
nd-writes

--=20
Alex Bligh




