Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:34248 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbcJBQRN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Oct 2016 12:17:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
Date: Sun, 2 Oct 2016 17:17:14 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        axboe@fb.com, linux-block@vger.kernel.org, kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com> <20160929095204.mexr6wpypo3bl6mx@grep.be> <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com> <20160929164100.akytbkbtvziwaqqj@grep.be> <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
To: Josef Bacik <jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 29 Sep 2016, at 17:59, Josef Bacik <jbacik@fb.com> wrote:
>=20
> On 09/29/2016 12:41 PM, Wouter Verhelst wrote:
>> On Thu, Sep 29, 2016 at 10:03:50AM -0400, Josef Bacik wrote:
>>> So think of it like normal disks with multiple channels.  We don't =
send flushes
>>> down all the hwq's to make sure they are clear, we leave that =
decision up to the
>>> application (usually a FS of course).
>>=20
>> Well, when I asked earlier, Christoph said[1] that blk-mq assumes =
that
>> when a FLUSH is sent over one channel, and the reply comes in, that =
all
>> commands which have been received, regardless of which channel they =
were
>> received over, have reched disk.
>>=20
>> [1] Message-ID: <20160915122304.GA15501@infradead.org>
>>=20
>> It is impossible for nbd to make such a guarantee, due to =
head-of-line
>> blocking on TCP.
>>=20
>=20
> Huh I missed that.  Yeah that's not possible for us for sure, I think =
my option=20
> idea is the less awful way forward if we want to address that =
limitation.  Thanks,

I think if the server supports flush (which you can tell), sending flush =
on
all channels is the only safe thing to do, without substantial protocol
changes (which I'm not sure how one would do given flush is in a sense
a synchronisation point). I think it's thus imperative this gets fixed
before the change gets merged.

--=20
Alex Bligh




