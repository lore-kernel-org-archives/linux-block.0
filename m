Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:40756 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbcJCHtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 03:49:14 -0400
Date: Mon, 3 Oct 2016 09:49:03 +0200
From: Wouter Verhelst <w@uter.be>
To: Alex Bligh <alex@alex.org.uk>
Cc: Josef Bacik <jbacik@fb.com>, axboe@fb.com,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
Message-ID: <20161003074903.zhbrpjunxbenqfkh@grep.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
 <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
 <20160929164100.akytbkbtvziwaqqj@grep.be>
 <a2d8d560-41d0-e17d-90df-b1953ce00a51@fb.com>
 <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F4CD5523-E3BC-4151-B9B8-ADFE9040F6E3@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Oct 02, 2016 at 05:17:14PM +0100, Alex Bligh wrote:
> On 29 Sep 2016, at 17:59, Josef Bacik <jbacik@fb.com> wrote:
> > Huh I missed that.  Yeah that's not possible for us for sure, I think my option 
> > idea is the less awful way forward if we want to address that limitation.  Thanks,
> 
> I think if the server supports flush (which you can tell), sending flush on
> all channels is the only safe thing to do, without substantial protocol
> changes (which I'm not sure how one would do given flush is in a sense
> a synchronisation point). I think it's thus imperative this gets fixed
> before the change gets merged.

Whoa there, Alex.

I don't think this should be a blocker. There is a theoretical problem
yes, but I believe it to be limited to the case where the client and the
server are not in the same broadcast domain, which is not the common
case (most NBD connections run either over the localhost iface, or to a
machine nearby). In the case where the client and server are on the same
LAN, random packet drop is highly unlikely, so TCP communication will
not be delayed and so the replies will, with high certainty, arrive in
the same order that they were sent.

Obviously the documentation for the "spawn multiple connections" option
in nbd-client needs to clearly state that it will decrease reliability
in this edge case, but I don't think that blocking this feature until a
solution for this problem is implemented is the right way forward. There
are valid use cases where using multiple connections is preferable, even
with the current state of affairs, and they do not all involve "switch
off flush".

Regards,

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
