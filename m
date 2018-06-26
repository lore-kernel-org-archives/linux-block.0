Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934609AbeFZBhm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 21:37:42 -0400
Date: Tue, 26 Jun 2018 09:37:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Omar Sandoval <osandov@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
Message-ID: <20180626013719.GA31259@ming.t460p>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
 <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 25, 2018 at 10:05:41AM -0700, Bart Van Assche wrote:
> On 06/22/18 20:15, Ming Lei wrote:
> > Just tried srp/001
> > 
> > [root@ktest-04 blktests]# ./check srp/001
> > srp/001 (Create and remove LUNs)                             [failed]
> >      runtime  0.912s  ...  18.358s
> >      --- tests/srp/001.out 2018-06-23 02:41:33.267925950 +0000
> >      +++ results/nodev/srp/001.out.bad 2018-06-23 03:11:30.062799405 +0000
> >      @@ -1,8 +1,27 @@
> >      -Unloaded the ib_srpt kernel module
> >      +Unloaded the ib_srp kernel module
> >      +modprobe: FATAL: Module target_core_mod is in use.
> >      +modprobe: FATAL: Module target_core_mod is in use.
> >      +modprobe: FATAL: Module target_core_mod is in use.
> >      +modprobe: FATAL: Module target_core_mod is in use.
> >      +modprobe: FATAL: Module target_core_mod is in use.
> >      ...
> >      (Run 'diff -u tests/srp/001.out results/nodev/srp/001.out.bad' to
> > see the entire diff)
> > 
> > [root@ktest-04 blktests]# lsmod | grep target
> > iscsi_target_mod      303104  1 ib_isert
> > target_core_mod       356352  2 iscsi_target_mod,ib_isert
> 
> LIO must be unconfigured before the SRP tests are run. The above output
> shows that LIO was already loaded before the SRP tests were started. I will
> add a test that prevents the SRP tests to start if LIO was already
> configured.

I run SRP test on Fedora 27, and not run any LIO specific commands
to load it, seems it is done automatically.

So looks it might not a good idea to fail SRP test if LIO is loaded,
just wondering why your SRP test can't make the two co-exist?

Thanks,
Ming
