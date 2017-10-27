Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx.ewheeler.net ([66.155.3.69]:57464 "EHLO mail.ewheeler.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932279AbdJ0XbI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2017 19:31:08 -0400
Date: Fri, 27 Oct 2017 23:31:06 +0000 (UTC)
From: Eric Wheeler <bcache@lists.ewheeler.net>
To: Michael Lyle <mlyle@lyle.org>
cc: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>, Kai Krakow <hurikhan77@gmail.com>,
        Junhui Tang <tang.junhui@zte.com.cn>, stable@vger.kernel.org
Subject: Re: [PATCHv4] bcache: only permit to recovery read error when cache
 device is clean
In-Reply-To: <CAJ+L6qdZekS4hTFwXG6oSHuXEuVODW1PRWh3j62RJDMWj9EXgw@mail.gmail.com>
Message-ID: <alpine.LRH.2.11.1710272310510.24585@mail.ewheeler.net>
References: <20171016180428.123657-1-colyli@suse.de> <alpine.LRH.2.11.1710271955340.24585@mail.ewheeler.net> <CAJ+L6qeSP6OLkaNBs1N0=D5=4hz3wDa2UcZfRSKHUM_rxZFpTQ@mail.gmail.com> <alpine.LRH.2.11.1710272111120.24585@mail.ewheeler.net>
 <CAJ+L6qdZekS4hTFwXG6oSHuXEuVODW1PRWh3j62RJDMWj9EXgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 27 Oct 2017, Michael Lyle wrote:

> On Fri, Oct 27, 2017 at 2:13 PM, Eric Wheeler <bcache@lists.ewheeler.net> wrote:
> [snip]
> >> > Can KEY_DIRTY facilitate this?
> >>
> >> Don't we only have the metadata to know if the key is dirty on the
> >> cache if we have the cache device? ;)
> >
> > Certainly if this is for removal or a missing cache (perhaps I missed
> > that).
> >
> > However, I thought this was just a recovery on an IO error where the disk
> > might be mostly dead--but partly alive!
> >
> > Of course if the metadata lookup fails subsequently, then you would need
> > to fall back to the dc->has_dirty flag.
> 
> Seems like something that's a lot of effort for little gain.  It'll
> only help when A) everything you need isn't dirty, and 

Indeed!

> B) all the associated btree nodes are in memory.  

Is the dirty key map not memory resident?  

> Since bcache tries to keep 10% dirty by default, and it's likely to be 
> heavy on filesystem metadata-- I don't know how often this would help 
> anyone in the real world.

Perhaps not---but if it is easy to implement, then this would provide the 
most optimistic recovery.



--
Eric Wheeler


> 
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
