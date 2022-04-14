Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B471C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 00:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiDNAUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiDNAUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 20:20:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571A24BD7
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 17:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JauCVZkSy6P6HwlEeSvJZeqfHK7YcfYHvZB6Z0BdPPY=; b=aou5HY0tdYRu3rSKY+ahJABMpR
        fvHbgXEzi/9cTxmDHLySxz9U7tqetGFHuey/Yt98WBfbTbrxZOseC2dwEKZM1pwhI6w/im9Cr6S1n
        pxsVmf5JF4iWsNJcDFG7s1LmbbFYcwhqfXEuTVrrhsYsrFktWXlPIpLz9JQ+uImx0LNSkUYd4tS6C
        V0NCuqsHeiLPpqHr5vIBXUJOIQ2fHlmHS845UsjHgVj2UV/nUbYEU6dJHRPxwo8qw+sBq4/8glaRt
        zMsQVHGKDvtwkHw8l2hetihJE1nHNiP3Oc6dLkIlOrH5Y5L2nsC7bY8Dzd+g+W6YAzbF+TifmEH/7
        3VtqIeBg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nenBi-0039sN-2t; Thu, 14 Apr 2022 00:18:18 +0000
Date:   Wed, 13 Apr 2022 17:18:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Subject: blktests srp failures with a guest with kdevops on v5.17-rc7 removal
Message-ID: <YldoSh6o5sbifsJf@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've started to work on expanding coverage of testing with blktests
on kdevops [0] to other test groups. srp was one of them. But the amount
of failures I'm seeing seems to tell me I'm probably doing something
really stupid, so please help me review the setup. The baseline for
srp is listed below, each of these is a failure. I've used v5.17-rc7
as a starting point.

You should able to reproduce the failure by creating a KVM guest with
kdevops, confuguring the kernel to test to be v5.17-rc7 and then then
running the following to bring up the guest:

make menuconfig # enable blktests and just enable srp as the only guest
make
make bringup # bring up your guests
make linux # compile and install v5.17-rc7 with all of blktests deps on guests
make blktests # compile and install blktest as well as set up srp deps on guests
make blktests-baseline # This runs the srp tests

Or you can just skip the last step and run the test manually.
The hosts created use a prefix based on CONFIG_KDEVOPS_HOSTS_PREFIX.

On a system with this:

grep CONFIG_KDEVOPS_HOSTS_PREFIX .config
CONFIG_KDEVOPS_HOSTS_PREFIX="linux517"

I then just

ssh linux-517-blktests-srp
sudo su -
cd /usr/local/blktests
./check srp

Note: if you enabled more than the srp guest you can also just run the
test for that guest as follows:

make blktests-baseline HOSTS=linux-517-blktests-srp

Likewise on the host you can inspect the console:

sudo virsh vagrant_linux-517-blktests-srp

The failures I can rerproduce easily (and if not just run the test twice):

srp/001 # failure rate is 1 always fails soft lockup https://gist.github.com/mcgrof/f94ad51123cfdbff4520a9964c292c2c
srp/002 # failure rate is 1 always fails with an NMI https://gist.github.com/mcgrof/9f3b1b9592d2196eb79f8c22238dbfd9
srp/005 # failure rate is 1 always fails with an NMI https://gist.github.com/mcgrof/d73bc3c0fe91fbbf6d4b9957e51b3ddb
srp/006 # failure rate is 1 always fails with a diff                            
srp/007 # failure rate is 1 always fails with a diff                            
srp/008 # failure rate is 1 always fails with a diff                            
srp/009 # failure rate is 1 always fails with a soft lockup https://gist.github.com/mcgrof/d6b351b40f2345dd20a7fa8acee3f704
srp/010 # failure rate is 1 always fails with a diff                            
srp/011 # failure rate is 1 always fails with an NMI https://gist.github.com/mcgrof/8f80e72f9f3bae20dcc3d45a06f30379
srp/012 # failure rate is 1 always fails with an NMI https://gist.github.com/mcgrof/72929570da5de920d9a37cb401225822
srp/013 # failure rate is 1 always fails with an NMI https://gist.github.com/mcgrof/eed4d4683fa53960bffc10c3c4fe1fda
srp/014 # failure rate is 1 always fails with a diff  

To see the status of any host you can run on the host the blktests
kdevops watchdog output manually, for instance I get:

./scripts/workflows/blktests/blktests_watchdog.py hosts baseline
                           Hostname           Test-name        Completion %          runtime(s)     last-runtime(s)   Stall-status                        Kernel
            linux517-blktests-block           block/004                  0%                  13                   0             OK                    5.17.0-rc7
             linux517-blktests-loop                None                  0%                   0                   0             OK                    5.17.0-rc7
              linux517-blktests-nbd                None                  0%                   0                   0             OK                    5.17.0-rc7
             linux517-blktests-nvme                None                  0%                   0                   0             OK                    5.17.0-rc7
           linux517-blktests-nvmemp                None                  0%                   0                   0             OK                    5.17.0-rc7
             linux517-blktests-scsi                None                  0%                   0                   0             OK                    5.17.0-rc7
              linux517-blktests-srp                None                  0%                   0                   0   Hung-Stalled                   Uname-issue
              linux517-blktests-zbd             zbd/006                  0%                  32                   0             OK                    5.17.0-rc7

[0] https://github.com/mcgrof/kdevops.git

  LUis
