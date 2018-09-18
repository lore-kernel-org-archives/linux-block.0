Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeISE70 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 00:59:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so1747900pfi.1
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 16:24:31 -0700 (PDT)
Date: Tue, 18 Sep 2018 16:24:29 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
Message-ID: <20180918232429.GB479@vader>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
 <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
 <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
 <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
 <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
 <20180824002133.GA14674@vader>
 <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 18, 2018 at 02:20:59PM -0700, Bart Van Assche wrote:
> On 8/23/18 5:21 PM, Omar Sandoval wrote:
> > On Thu, Aug 23, 2018 at 01:53:33AM +0000, Bart Van Assche wrote:
> > > On Tue, 2018-08-21 at 08:46 +0200, Johannes Thumshirn wrote:
> > > > On Mon, Aug 20, 2018 at 03:46:45PM +0000, Bart Van Assche wrote:
> > > > > Moving these tests into the nvme directory is possible but will make it
> > > > > harder to run the NVMeOF multipath tests separately. Are you fine with this?
> > > > 
> > > > Both way's have it's up and downsides, I agree.
> > > > 
> > > > Having two distinct groups requires to run './check nvme nvmeof-mp' to
> > > > run full coverage with nvme.
> > > > 
> > > > Having it all in one group would require to run './check nvme 18 19 20
> > > > 21 22 23 24 ...' to get only the dm-mpath ones.
> > > > 
> > > > Honestly I hate both but your's (the two distinct groups) is probably
> > > > easier to handle in the end, I have to admit.
> > > 
> > > Omar, do you have a preference for one of the two aforementioned approaches?
> > 
> > Let's keep it in a separate category, since lots of people running nvme
> > tests probably aren't interested in testing multipath.
> > 
> > A bunch of the tests failed with
> > 
> > modprobe: FATAL: Module nvme is in use.
> > 
> > Maybe related to my test VM having an nvme device?
> 
> Hello Omar,
> 
> Can you have a look at the updated master branch of
> https://github.com/bvanassche/blktests? That code should no longer fail if
> unloading the nvme kernel module fails. Please note that you will need
> kernel v4.18 to test these scripts - a KASAN complaint appears if I run
> these tests against kernel v4.19-rc4.

Thanks, these pass now. Is it expected that my nvme device gets a
multipath device configured after running these tests?

$ lsblk
NAME     MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
vda      254:0    0  16G  0 disk
└─vda1   254:1    0  16G  0 part  /
vdb      254:16   0   8G  0 disk
vdc      254:32   0   8G  0 disk
vdd      254:48   0   8G  0 disk
nvme0n1  259:0    0   8G  0 disk
└─mpatha 253:0    0   8G  0 mpath

Also, can you please fix:

	_have_kernel_option NVME_MULTIPATH && exit 1

to not exit on failure? It should use SKIP_REASON and return 1. You
might need to add something like _dont_have_kernel_option to properly
handle the case where the config is not found.

Side note which isn't a blocker for merging is that there's a lot of
duplicated code between these helpers and the srp helpers. How hard
would it be to refactor that?
