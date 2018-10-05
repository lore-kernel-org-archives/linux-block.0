Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeJFBuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Oct 2018 21:50:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so5105173pgm.7
        for <linux-block@vger.kernel.org>; Fri, 05 Oct 2018 11:50:19 -0700 (PDT)
Date: Fri, 5 Oct 2018 11:50:16 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
Message-ID: <20181005185016.GK25437@vader>
References: <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
 <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
 <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
 <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
 <20180824002133.GA14674@vader>
 <66df74ec-43d3-c7c4-73d0-16e008b23695@acm.org>
 <20180918232429.GB479@vader>
 <e73f116a-f665-7222-1c3e-63ef1c031687@acm.org>
 <20180919001815.GF479@vader>
 <1538090802.226558.17.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1538090802.226558.17.camel@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 27, 2018 at 04:26:42PM -0700, Bart Van Assche wrote:
> On Tue, 2018-09-18 at 17:18 -0700, Omar Sandoval wrote:
> > On Tue, Sep 18, 2018 at 05:02:47PM -0700, Bart Van Assche wrote:
> > > On 9/18/18 4:24 PM, Omar Sandoval wrote:
> > > > On Tue, Sep 18, 2018 at 02:20:59PM -0700, Bart Van Assche wrote:
> > > > > Can you have a look at the updated master branch of
> > > > > https://github.com/bvanassche/blktests? That code should no longer fail if
> > > > > unloading the nvme kernel module fails. Please note that you will need
> > > > > kernel v4.18 to test these scripts - a KASAN complaint appears if I run
> > > > > these tests against kernel v4.19-rc4.
> > > > 
> > > > Thanks, these pass now. Is it expected that my nvme device gets a
> > > > multipath device configured after running these tests?
> > > > 
> > > > $ lsblk
> > > > NAME     MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
> > > > vda      254:0    0  16G  0 disk
> > > > └─vda1   254:1    0  16G  0 part  /
> > > > vdb      254:16   0   8G  0 disk
> > > > vdc      254:32   0   8G  0 disk
> > > > vdd      254:48   0   8G  0 disk
> > > > nvme0n1  259:0    0   8G  0 disk
> > > > └─mpatha 253:0    0   8G  0 mpath
> > > 
> > > No, all multipath devices that were created during a test should be removed
> > > before that test finishes. I will look into this.
> > > 
> > > > Also, can you please fix:
> > > > 
> > > > 	_have_kernel_option NVME_MULTIPATH && exit 1
> > > > 
> > > > to not exit on failure? It should use SKIP_REASON and return 1. You
> > > > might need to add something like _dont_have_kernel_option to properly
> > > > handle the case where the config is not found.
> > > 
> > > OK, I will change this.
> > > 
> > > > Side note which isn't a blocker for merging is that there's a lot of
> > > > duplicated code between these helpers and the srp helpers. How hard
> > > > would it be to refactor that?
> > > 
> > > Are you perhaps referring to the code that is shared between the
> > > tests/srp/rc tests/nvmeof-mp/rc shell scripts?
> > 
> > Yes, those.
> > 
> > > The hardest part is probably
> > > to chose a location where to store these functions. Should I create a file
> > > with common code under common/, under tests/srp/, under tests/nvmeof-mp/ or
> > > perhaps somewhere else?
> > 
> > Just put it under common.
> 
> Hi Omar,
> 
> All feedback mentioned above has been addressed. The following pull request has
> been updated: https://github.com/osandov/blktests/pull/33. Please let me know
> if you want me to post these patches on the linux-block mailing list.
> 
> Note: neither the upstream kernel v4.18 nor v4.19-rc4 are stable enough to pass
> all nvmeof-mp tests if kernel debugging options like KASAN are enabled.
> Additionally, the NVMe device_add_disk() race condition often causes multipathd
> to refuse to consider /dev/nvme... devices. The output on my test setup is as
> follows (all tests pass):
> 
> # ./check -q nvmeof-mp
> nvmeof-mp/001 (Log in and log out)                           [passed]
>     runtime  1.528s  ...  1.909s
> nvmeof-mp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [
> passed]time  38.968s  ...
>     runtime  38.968s  ...  38.571s
> nvmeof-mp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-
> nvmeof-mp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-
> mq)) [passed]38.632s  ...
>     runtime  38.632s  ...  37.529s
> nvmeof-mp/005 (Direct I/O with large transfer sizes and bs=4M) [passed]
>     runtime  13.382s  ...  13.684s
> nvmeof-mp/006 (Direct I/O with large transfer sizes and bs=8M) [passed]
>     runtime  13.511s  ...  13.480s
> nvmeof-mp/009 (Buffered I/O with large transfer sizes and bs=4M) [passed]
>     runtime  13.665s  ...  13.763s
> nvmeof-mp/010 (Buffered I/O with large transfer sizes and bs=8M) [passed]
>     runtime  13.442s  ...  13.900s
> nvmeof-mp/011 (Block I/O on top of multipath concurrently with logout and login) [pass
> ed] runtime  37.988s  ...
>     runtime  37.988s  ...  37.945s
> nvmeof-mp/012 (dm-mpath on top of multiple I/O schedulers)   [passed]
>     runtime  21.659s  ...  21.733s

Thanks, Bart, merged.
