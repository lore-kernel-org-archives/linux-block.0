Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F18C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiDUSC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391238AbiDUSC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 14:02:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607BBE29
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h71PPsUCftSbNIx2YEYpL34UYfyDKKfxZOR30wmfF0Y=; b=XLV0UIIo3xfHXTbvscQzupyjHa
        ev8SaqVqC4NJ7/Pv0QRdQt/JyLc/JSBJCPmIh0rRr4Rbw1KiXZKQv7eqyYqXs8687o5KNfIKJtXx+
        4/j8o+mN9jQ9kMGDekQjaxhgK4PVqrxz+uMWXL9SzaywNYzF1pFGl8e6NsBi4/CGbBvXMrluv/q+m
        bqWsUVW5GzSfdD/tWQo4Jr68zS3RVmgX3ss513ybOsgiERUkCbfLl16937uEzqHmlefAoMEr3rxzL
        pUgrqtpnOZhHru3wE7DESVHsKpHyHXqDPYxdr1kMuNDoxnCUpOJBhKwltwXohE5jkXEEMqognQZd3
        k0fLfoyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhb63-00EXaZ-9e; Thu, 21 Apr 2022 18:00:03 +0000
Date:   Thu, 21 Apr 2022 11:00:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420055429.t5ni7yah4p4yxgsq@shindev>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
> On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
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
> >   * linux517-blktests-zbd
> >   * linux517-blktests-zbd-dev
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
> 
> Hello Luis,
> 
> I run blktests zbd group on several QEMU ZNS emulation devices for every rcX
> kernel releases. But, I have not ever observed the symptom above. Now I'm
> repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device, and do
> not observe the symptom so far, after 400 times repeat.

Did you try v5.17-rc7 ?

> I would like to run the test using same ZNS set up as yours. Can you share how
> your ZNS device is set up? I would like to know device size and QEMU -device
> options, such as zoned.zone_size or zoned.max_active.

It is as easy as the above make commands, and follow up login commands.
I'll be bumping the kernel to test for fstesta and blktests on kdevops
soon but the baseline is sadly not yet done for all filesystems and
blktests yet. Once the baseline is completed though it should be easy to
bump kernel and confirm if old failures are not failing anymore / find
new issues.

  Luis
