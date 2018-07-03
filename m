Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44904 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeGCTtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 15:49:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so1488769pfh.11
        for <linux-block@vger.kernel.org>; Tue, 03 Jul 2018 12:49:15 -0700 (PDT)
Date: Tue, 3 Jul 2018 12:49:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180703194913.GA25954@vader>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader>
 <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 29, 2018 at 09:13:53AM -0700, Bart Van Assche wrote:
> On 06/28/18 16:43, Omar Sandoval wrote:
> > On Wed, Jun 27, 2018 at 02:49:08PM -0700, Bart Van Assche wrote:
> > [ ... ]
> > srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
> > runtime  6.680s  ...  6.640s
> >      --- tests/srp/002.out       2018-06-28 15:18:36.537169282 -0700
> >      +++ results/nodev/srp/002.out.bad   2018-06-28 16:21:59.930603931 -0700
> >      @@ -3,5 +3,4 @@
> >       Unloaded the rdma_rxe kernel module
> >       Configured SRP target driver
> >       Unloaded the ib_srp kernel module
> >      -Unloaded the ib_srpt kernel module
> >      -Unloaded the rdma_rxe kernel module
> >      +/dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000: not found
> > 
> > And everything else fails like srp/002.
> 
> I think that indicates a problem with the multipathing software on your
> setup. Was multipathd running? Had the proper multipath configuration
> (/etc/multipath.conf) been provided? Was multipathing enabled in the kernel
> config?

Ah, the README says /etc/multipathd.conf. Fixing it to multipath.conf
didn't work, either, though.
