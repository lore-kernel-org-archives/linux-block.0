Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdHRRZM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 13:25:12 -0400
Date: Fri, 18 Aug 2017 19:25:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
Message-ID: <20170818172505.pdpb4hebvx7qarej@ws.net.home>
References: <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de>
 <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de>
 <20170818074700.GH2459@vader>
 <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de>
 <20170818080539.GI2459@vader>
 <3a42bb8d-1850-8d6c-11c6-bf8632af5e7a@suse.de>
 <20170818082226.GK2459@vader>
 <20170818092239.sxdpayiyukpwaoge@ws.net.home>
 <20170818164425.GA26094@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170818164425.GA26094@vader.DHCP.thefacebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 18, 2017 at 09:44:25AM -0700, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 11:22:39AM +0200, Karel Zak wrote:
> > On Fri, Aug 18, 2017 at 01:22:26AM -0700, Omar Sandoval wrote:
> > > On Fri, Aug 18, 2017 at 10:12:51AM +0200, Hannes Reinecke wrote:
> > > > On 08/18/2017 10:05 AM, Omar Sandoval wrote:
> > > > > On Fri, Aug 18, 2017 at 09:56:26AM +0200, Hannes Reinecke wrote:
> > > > >> On 08/18/2017 09:47 AM, Omar Sandoval wrote:
> > > > [ .. ]
> > > > >>>
> > > > >>> I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
> > > > >>> always set and lo_init[0] always filled in.
> > > > >>>
> > > > >> The original argument I had with the util-linux maintainer did not
> > > > >> revolve so much around technical details :-)
> > > > > 
> > > > > Karel, what were your concerns here?
> > > > > 
> > > > It wasn't Karel, it was our guy.
> > > > Doesn't make it any better, though...
> > > 
> > > I just went through the code and util-linux doesn't mention lo_init at
> > > all except for the definition, and everywhere it's using lo_flags would
> > > work fine with the behavior I implemented here. Unless there's an actual
> > > issue someone can point out, I see no reason to not do it this way.
> > 
> >  Hmm.. we have loopdev API enhancement in Linus' tree and losetup
> >  maintainer have no clue about it ;-)
> 
> Ha, glad you're hearing about it now before it's too late :)
> 
> >  Anyway, I like the idea with LO_FLAGS_BLOCKSIZE and lo_init[]. It
> >  seems like a backwardly compatible way how to make loopdevs usable
> >  for dd(1) images from non-512 devices, etc.
> > 
> >  For now nothing uses lo_init[], so it seems no problem to use it for
> >  LOOP_GET_STATUS64. 
> 
> Do you see any issues with the behavior I added in this patch? Namely,
> LOOP_GET_STATUS{,64} will always return lo_flags with LO_FLAGS_BLOCKSIZE
> set and lo_init[0] will always contain the blocksize. Older userspace
> which doesn't know about LO_FLAGS_BLOCKSIZE will just ignore it and the
> LOOP_GET_STATUS64; modify stuff; LOOP_SET_STATUS64 pattern will still
> work.

Yes, I think your idea is correct. All unknown flags should be ignored
by userspace. This is not the first time the API (lo_flags) is extended
by a new flag.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
