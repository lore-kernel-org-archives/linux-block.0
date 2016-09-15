Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:58488 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934807AbcIOL5C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:57:02 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915114610.GA6411@infradead.org>
Date: Thu, 15 Sep 2016 12:56:59 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Message-Id: <918692FE-9B1B-4F33-8626-731F48909F41@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org> <751994A2-653B-4201-8210-A31495804788@alex.org.uk> <20160915114610.GA6411@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 12:46, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Thu, Sep 15, 2016 at 12:43:35PM +0100, Alex Bligh wrote:
>> Sure, it's at:
>>=20
>> =
https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-a=
nd-writes
>>=20
>> and that link takes you to the specific section.
>>=20
>> The treatment of FLUSH and FUA is meant to mirror exactly the
>> linux block layer (or rather how the linux block layer was a few
>> years ago). I even asked on LKML to verify a few points.
>=20
> Linux never expected ordering on the wire.  Before 2010 we had =
barriers
> in the kernel that provided ordering to the caller, but we never
> required it from the protocol / hardware.

Sure. And I think the doc section reflects exactly Linux's post-2010
expectations (note the link to the kernel documentation). IE
servers are not required to order reads/writes (save that all
writes that the server completes prior to reply to an NBD_CMD_FLUSH
must be persisted prior to the reply to that NBD_CMD_FLUSH
which I believe to be exactly the same behaviour as the kernel
dealing with an empty bio with REQ_FLUSH set).

Perhaps the section should be called "No ordering of messages
and writes"!

My point was that *in practice* disordering is not well tested
as *in practice* many server implementations do in fact process
each command in order, though that's changed recently.

--=20
Alex Bligh




