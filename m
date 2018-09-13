Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44342 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMGNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Sep 2018 02:13:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so1897922pgp.11
        for <linux-block@vger.kernel.org>; Wed, 12 Sep 2018 18:06:34 -0700 (PDT)
Date: Wed, 12 Sep 2018 18:06:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
Message-ID: <20180913010631.GA32250@vader>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
 <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
 <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
 <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
 <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
 <20180824002133.GA14674@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180824002133.GA14674@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 23, 2018 at 05:21:33PM -0700, Omar Sandoval wrote:
> On Thu, Aug 23, 2018 at 01:53:33AM +0000, Bart Van Assche wrote:
> > On Tue, 2018-08-21 at 08:46 +0200, Johannes Thumshirn wrote:
> > > On Mon, Aug 20, 2018 at 03:46:45PM +0000, Bart Van Assche wrote:
> > > > Moving these tests into the nvme directory is possible but will make it
> > > > harder to run the NVMeOF multipath tests separately. Are you fine with this?
> > > 
> > > Both way's have it's up and downsides, I agree.
> > > 
> > > Having two distinct groups requires to run './check nvme nvmeof-mp' to
> > > run full coverage with nvme.
> > > 
> > > Having it all in one group would require to run './check nvme 18 19 20
> > > 21 22 23 24 ...' to get only the dm-mpath ones.
> > > 
> > > Honestly I hate both but your's (the two distinct groups) is probably
> > > easier to handle in the end, I have to admit.
> > 
> > Omar, do you have a preference for one of the two aforementioned approaches?
> > 
> > Thanks,
> > 
> > Bart.
> > 
> 
> Let's keep it in a separate category, since lots of people running nvme
> tests probably aren't interested in testing multipath.
> 
> A bunch of the tests failed with
> 
> modprobe: FATAL: Module nvme is in use.
> 
> Maybe related to my test VM having an nvme device?

Ping, Bart, can you look into this? It'd be nice to get this in.
