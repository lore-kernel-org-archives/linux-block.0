Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:58353 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933530AbcIOLnj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:43:39 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915113807.GA23259@infradead.org>
Date: Thu, 15 Sep 2016 12:43:35 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Message-Id: <751994A2-653B-4201-8210-A31495804788@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Christoph,

> On 15 Sep 2016, at 12:38, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Thu, Sep 15, 2016 at 12:49:35PM +0200, Wouter Verhelst wrote:
>> A while back, we spent quite some time defining the semantics of the
>> various commands in the face of the NBD_CMD_FLUSH and =
NBD_CMD_FLAG_FUA
>> write barriers. At the time, we decided that it would be unreasonable
>> to expect servers to make these write barriers effective across
>> different connections.
>=20
> Do you have a nbd protocol specification?  treating a flush or fua
> as any sort of barrier is incredibly stupid.  Is it really documented
> that way, and if yes, why?

Sure, it's at:

=
https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-a=
nd-writes

and that link takes you to the specific section.

The treatment of FLUSH and FUA is meant to mirror exactly the
linux block layer (or rather how the linux block layer was a few
years ago). I even asked on LKML to verify a few points.

--=20
Alex Bligh




