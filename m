Return-Path: <linux-block-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:47940 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdGUMOv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2017 08:14:51 -0400
Date: Fri, 21 Jul 2017 14:14:39 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        nbd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: nbd drops connection on most writes
Message-ID: <20170721121439.ofwm3lfuzqjsvjok@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi!
I'm afraid that 4.13-rc1 nbd aborts connection on writes for me:

[  251.938384] block nbd0: Send data failed (result -11)
[  251.943484] block nbd0: Request send failed trying another connection
[  251.950034] block nbd0: Receive control failed (result -32)
[  251.955676] block nbd0: Attempted send on invalid socket
[  251.961022] print_req_error: I/O error, dev nbd0, sector 2206344
[  251.961025] block nbd0: shutting down sockets

Not all kinds of writes trigger the problem.  For example, you can dd to the
nbd block device, likewise badblocks -w succeeds without a hitch.  Yet at
least btrfs and swap disconnect nearly immediately.  Reads seem to work: for
example, btrfs can usually mount and scrub successfully, yet minor writes
that happen on a filesystem mounted rw even without explicit user-level
writes cause a disconnect in a short time.  "Real" writes to the filesystem
trigger it apparently outright.  Likewise, to use swap you need to write to
it first, thus it fails quickly.

Reproduced on arm64 (Pine64) first.  As this SoC just switched from an
out-of-tree ethernet driver to a completely different new one (dwmac-sun8i),
and such a switch can't be bisected, I assumed that's the culprit and did
not complain while in -next.

However, turns out the same happens on a bog-standard amd64, both on bare
metal and in qemu.

In all of these cases, the server is an amd64 Debian stretch, kernel
4.9.30-2+deb9u2, nbd-server 1:3.15.2-3.

Bisect blames dc88e34d "nbd: set sk->sk_sndtimeo for our sockets", and
indeed, reverting that patch makes everything fine again.


Bisect log:
# bad: [63a86362130f4c17eaa57f3ef5171ec43111a54e] Merge tag 'pm-4.13-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
# good: [6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c] Linux 4.12
git bisect start 'linus/master' 'v4.12'
# bad: [55a7b2125cf4739a8478d2d7223310ae7393408c] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 55a7b2125cf4739a8478d2d7223310ae7393408c
# bad: [1849f800fba32cd5a0b647f824f11426b85310d8] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 1849f800fba32cd5a0b647f824f11426b85310d8
# bad: [cbcd4f08aa637b74f575268770da86a00fabde6d] Merge tag 'staging-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad cbcd4f08aa637b74f575268770da86a00fabde6d
# bad: [1b044f1cfc65a7d90b209dfabd57e16d98b58c5b] Merge branch 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 1b044f1cfc65a7d90b209dfabd57e16d98b58c5b
# bad: [892ad5acca0b2ddb514fae63fa4686bf726d2471] Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 892ad5acca0b2ddb514fae63fa4686bf726d2471
# bad: [e442cbf910c71fba5926cf757dd7f8fcce22fc5f] pktcdvd: remove the call to blk_queue_bounce
git bisect bad e442cbf910c71fba5926cf757dd7f8fcce22fc5f
# bad: [d86c4d8ef31b3d99c681c859cb4e936dafc2d7a4] nvme: move reset workqueue handling to common code
git bisect bad d86c4d8ef31b3d99c681c859cb4e936dafc2d7a4
# bad: [fdd050b5b3c96813ae6756ed68157d32ba31b9f2] Merge branch 'uuid-types' of bombadil.infradead.org:public_git/uuid into nvme-base
git bisect bad fdd050b5b3c96813ae6756ed68157d32ba31b9f2
# bad: [a104c9f22c7d073d4ae308ca36383ce5cc4631cc] nvme-rdma: fix merge error
git bisect bad a104c9f22c7d073d4ae308ca36383ce5cc4631cc
# good: [b040ad9cf6a169cc000a5324fcada695dfa1f4b3] loop: fix error handling regression
git bisect good b040ad9cf6a169cc000a5324fcada695dfa1f4b3
# bad: [36ffc6c1c0e67acdacb53348350d0a37206dbadf] block_dev: propagate bio_iov_iter_get_pages error in __blkdev_direct_IO
git bisect bad 36ffc6c1c0e67acdacb53348350d0a37206dbadf
# bad: [f729b66fca43d850d564b264c2033980c00a14b0] gfs2: remove the unused sd_log_error field
git bisect bad f729b66fca43d850d564b264c2033980c00a14b0
# bad: [401741547f95c0883fe143ac446d92c772937556] nvme-lightnvm: use blk_execute_rq in nvme_nvm_submit_user_cmd
git bisect bad 401741547f95c0883fe143ac446d92c772937556
# bad: [dc88e34d69d87c370deaa9d613dac8e3a0411f59] nbd: set sk->sk_sndtimeo for our sockets
git bisect bad dc88e34d69d87c370deaa9d613dac8e3a0411f59
# first bad commit: [dc88e34d69d87c370deaa9d613dac8e3a0411f59] nbd: set sk->sk_sndtimeo for our sockets


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
