Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9330C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 03:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiDOD5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 23:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiDOD5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 23:57:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFF73190D
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 20:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C64C1B82817
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 03:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65918C385A6;
        Fri, 15 Apr 2022 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649994879;
        bh=6Ih4djtR6MruO9Talc/bN4c9e3mFp3udvrXO33dS3Tw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WSIbgbVDaTSfr8X1DNe4q+IE4+shBZeWdTGpgFG+V2DT0gCadsT46WrBj+sPQO4op
         idkps+UZXaQ8eOpvkDx65Z04IclhiscMhs68N8oeNyaY4sNzZ8S3JVZXyzamO7/cjy
         e4O0riPVGyLhjhjE+YX/DV2/SEwAlG1sYq7wLg5S5ROBYZCy+T/TQJudsF/NJAU2eg
         gPqPd0xVmRxNaRpNzGo69AHTG9lbwkOU7qfHi+6JACEv8X9LH2C4n62SqyBQWHl+eQ
         zO5vLfkurSm8AOHAz7rI6HPpjQYM8c3RQu5vvbkxwiF/dMP5NGlSncCA2E0qP6Lt7m
         ahbTLMfhI18RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D9A045C0564; Thu, 14 Apr 2022 20:54:38 -0700 (PDT)
Date:   Thu, 14 Apr 2022 20:54:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, shinichiro.kawasaki@wdc.com,
        Klaus Jensen <its@irrelevant.dk>, linux-block@vger.kernel.org,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <20220415035438.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220415010945.wvyztmss7rfqnlog@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415010945.wvyztmss7rfqnlog@offworld>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 14, 2022 at 06:09:45PM -0700, Davidlohr Bueso wrote:
> On Thu, 14 Apr 2022, Luis Chamberlain wrote:
> 
> > Hey folks,
> > 
> > While enhancing kdevops [0] to embrace automation of testing with
> > blktests for ZNS I ended up spotting a possible false positive RCU stall
> > when running zbd/006 after zbd/005. The curious thing though is that
> > this possible RCU stall is only possible when using the qemu
> > ZNS drive, not when using nbd. In so far as kdevops is concerned
> > it creates ZNS drives for you when you enable the config option
> > CONFIG_QEMU_ENABLE_NVME_ZNS=y. So picking any of the ZNS drives
> > suffices. When configuring blktests you can just enable the zbd
> > guest, so only a pair of guests are reated the zbd guest and the
> > respective development guest, zbd-dev guest. When using
> > CONFIG_KDEVOPS_HOSTS_PREFIX="linux517" this means you end up with
> > just two guests:
> > 
> >  * linux517-blktests-zbd
> >  * linux517-blktests-zbd-dev
> > 
> > The RCU stall can be triggered easily as follows:
> > 
> > make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=y and blktests
> > make
> > make bringup # bring up guests
> > make linux # build and boot into v5.17-rc7
> > make blktests # build and install blktests
> > 
> > Now let's ssh to the guest while leaving a console attached
> > with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
> > 
> > ssh linux517-blktests-zbd
> > sudo su -
> > cd /usr/local/blktests
> > export TEST_DEVS=/dev/nvme9n1
> > i=0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=$i+1; done;
> > 
> > The above should never fail, but you should eventually see an RCU
> > stall candidate on the console. The full details can be observed on the
> > gist [1] but for completeness I list some of it below. It may be a false
> > positive at this point, not sure.
> > 
> > [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> > [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> > [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> > [493336.981666] nvme nvme9: Abort status: 0x0
> > [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> > [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [493425.817272] rcu:    4-....: (0 ticks this GP) idle=c48/0/0x0 softirq=11316030/11316030 fqs=939  (false positive?)
> > [493425.819275]         (detected by 7, t=14522 jiffies, g=31237493, q=6271)
> 
> Ok so CPU-7 detected stalls on CPU-4, which is in dyntick-idle mode,
> which is an extended quiescent state (EQS) to overcome the limitations of
> not having a tick (NO_HZ). So the false positive looks correct here in
> that idle threads in this state are not in fact blocking the grace period
> kthread.
> 
> No idea, however, why this would happen when using qemu as opposed to
> nbd.

This one is a bit strange, no two ways about it.

In theory, vCPU preemption is a possibility.  In practice, if the
RCU grace-period kthread's vCPU was preempted for so long, I would
have expected the RCU CPU stall warning to complain about starvation.
But it still might be worth tracing context switches on the underlying
hypervisor.

Another possibility is that the activity of the RCU CPU stall warning
kicked CPU 4 into action so that by the time the message was printed, it
had exited its RCU read-side critical section and transitioned to idle.
(This sort of behavior is rare, but it does sometimes happen.)

Would it be possible to ftrace __rcu_read_lock() and __rcu_read_unlock()?
That would be one really big trace, though.  Another possibility is to
instrument these two functions so that __rcu_read_unlock() complains
if the RCU read-side critical section has lasted for more than (say)
10 seconds.

Other thoughts?

							Thanx, Paul
