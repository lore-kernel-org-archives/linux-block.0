Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42934 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbeGCVjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 17:39:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so124736plr.9
        for <linux-block@vger.kernel.org>; Tue, 03 Jul 2018 14:39:20 -0700 (PDT)
Date: Tue, 3 Jul 2018 14:39:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180703213918.GC25954@vader>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader>
 <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
 <20180703194913.GA25954@vader>
 <20180703195010.GB25954@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180703195010.GB25954@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 03, 2018 at 12:50:10PM -0700, Omar Sandoval wrote:
> On Tue, Jul 03, 2018 at 12:49:13PM -0700, Omar Sandoval wrote:
> > On Fri, Jun 29, 2018 at 09:13:53AM -0700, Bart Van Assche wrote:
> > > On 06/28/18 16:43, Omar Sandoval wrote:
> > > > On Wed, Jun 27, 2018 at 02:49:08PM -0700, Bart Van Assche wrote:
> > > > [ ... ]
> > > > srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
> > > > runtime  6.680s  ...  6.640s
> > > >      --- tests/srp/002.out       2018-06-28 15:18:36.537169282 -0700
> > > >      +++ results/nodev/srp/002.out.bad   2018-06-28 16:21:59.930603931 -0700
> > > >      @@ -3,5 +3,4 @@
> > > >       Unloaded the rdma_rxe kernel module
> > > >       Configured SRP target driver
> > > >       Unloaded the ib_srp kernel module
> > > >      -Unloaded the ib_srpt kernel module
> > > >      -Unloaded the rdma_rxe kernel module
> > > >      +/dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000: not found
> > > > 
> > > > And everything else fails like srp/002.
> > > 
> > > I think that indicates a problem with the multipathing software on your
> > > setup. Was multipathd running? Had the proper multipath configuration
> > > (/etc/multipath.conf) been provided? Was multipathing enabled in the kernel
> > > config?
> > 
> > Ah, the README says /etc/multipathd.conf. Fixing it to multipath.conf
> > didn't work, either, though.
> 
> Hit send too early. multipathd is running, but I did find this in my
> dmesg:
> 
> [ 1844.347561] multipath[6558]: segfault at 100 ip 00007fbb7cda51e6 sp 00007fffe9241798 error 4 in libc-2.27.so[7fbb7cd0e000+1b3000]
> 
> I'll look into that.

Alright, I installed multipath-tools from source and the segfaults are
gone, but I still don't get these symlinks. Instead, they show up as

/dev/disk/by-id/scsi-3600140572616d6469736b32000000000

Any ideas?
