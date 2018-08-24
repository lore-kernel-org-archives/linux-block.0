Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43507 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Aug 2018 23:53:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so3641115pfi.10
        for <linux-block@vger.kernel.org>; Thu, 23 Aug 2018 17:21:34 -0700 (PDT)
Date: Thu, 23 Aug 2018 17:21:33 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
Message-ID: <20180824002133.GA14674@vader>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
 <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
 <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
 <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
 <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 23, 2018 at 01:53:33AM +0000, Bart Van Assche wrote:
> On Tue, 2018-08-21 at 08:46 +0200, Johannes Thumshirn wrote:
> > On Mon, Aug 20, 2018 at 03:46:45PM +0000, Bart Van Assche wrote:
> > > Moving these tests into the nvme directory is possible but will make it
> > > harder to run the NVMeOF multipath tests separately. Are you fine with this?
> > 
> > Both way's have it's up and downsides, I agree.
> > 
> > Having two distinct groups requires to run './check nvme nvmeof-mp' to
> > run full coverage with nvme.
> > 
> > Having it all in one group would require to run './check nvme 18 19 20
> > 21 22 23 24 ...' to get only the dm-mpath ones.
> > 
> > Honestly I hate both but your's (the two distinct groups) is probably
> > easier to handle in the end, I have to admit.
> 
> Omar, do you have a preference for one of the two aforementioned approaches?
> 
> Thanks,
> 
> Bart.
> 

Let's keep it in a separate category, since lots of people running nvme
tests probably aren't interested in testing multipath.

A bunch of the tests failed with

modprobe: FATAL: Module nvme is in use.

Maybe related to my test VM having an nvme device?
