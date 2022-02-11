Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A131BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 09:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiBKJmY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBKJmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 04:42:21 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 01:42:20 PST
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC9109C
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 01:42:20 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220211093551euoutp010d768a2563ea0da8e005466b751f0ebe~SsaiA82Bl0546705467euoutp01f
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 09:35:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220211093551euoutp010d768a2563ea0da8e005466b751f0ebe~SsaiA82Bl0546705467euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644572151;
        bh=yDcLop0GXahLhlWZJiqXR1dyUUdSlonjwf1s0tQbvGQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Lj7fE7esE1ZKUdzYGqG8CVApdPMi/m8MhKL2UL6ur+aZi5Yp/xhkqSGKsTm7J6Nwa
         t2E1jeTfTdH6lp6wujmo5J0aH962BqhLFd16LUk8B73KeeoRvaes4c4vb83HPfNB5R
         ivocwzXNW1pZ7SNDAl1zEPipKDKu1j/dTBqjRRQ0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220211093550eucas1p1cada1d4f319a4c4b988e04963408b25d~SsahLwwKK2914229142eucas1p15;
        Fri, 11 Feb 2022 09:35:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.FA.10260.7FD26026; Fri, 11
        Feb 2022 09:35:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220211093549eucas1p122dbc242f60ec6fb701617184494dd98~SsagpFS3m2682526825eucas1p1x;
        Fri, 11 Feb 2022 09:35:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220211093549eusmtrp132478df10337676f350498640570022a~SsagoSFqr1150811508eusmtrp1m;
        Fri, 11 Feb 2022 09:35:49 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-8a-62062df74498
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.3A.09522.7FD26026; Fri, 11
        Feb 2022 09:35:51 +0000 (GMT)
Received: from localhost (unknown [106.210.248.166]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220211093549eusmtip10980fd6dbbb816db11ef04f911846bdb~SsagWMYP21096810968eusmtip1v;
        Fri, 11 Feb 2022 09:35:49 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v1 0/1] Regression in ZNS devices due to batched completions
Date:   Fri, 11 Feb 2022 10:34:24 +0100
Message-Id: <20220211093425.43262-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7o/dNmSDM7vYrKYfljRYvXdfjaL
        0xMWMVk8vvOZ3eLo/7dsFntvaVvcmPCU0eLz0hZ2izU3n7I4cHrsnHWX3WPzCi2Py2dLPTat
        6mTz6NuyitHj8ya5ALYoLpuU1JzMstQifbsErozuE3/ZCq4KVlzr+8TWwHiJr4uRk0NCwETi
        af9G5i5GLg4hgRWMEtMWrmeBcL4wStxZe5QVwvnMKDGl+SozTEvzqeNQieWMEgsPwVS9ZJR4
        9rsVqJ+Dg01AS6Kxkx2kQUTAXeL+gRNgNcwCS5kk+k8tZQepERbwkbg6WR+khkVAVeJvSzcT
        SJhXwFJizzcuiF3yEjMvfQcbwysgKHFy5hMWEJsZKN68dTbY2RICazkkHm46wwbSKyHgIrFx
        qS9Er7DEq+Nb2CFsGYnTk3tYIOr7GSWmtvxhgnBmMEr0HN7MBNFsLdF3JgfEZBbQlFi/Sx+i
        11Fi9rPzrBAVfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWSxM6fT6C2SkhcbprDAmF7SCxc28gI
        YgsJxEpM2/GIZQKjwiwkj81C8tgshBsWMDKvYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93E
        CEw+p/8d/7qDccWrj3qHGJk4GA8xSnAwK4nwrrjBmiTEm5JYWZValB9fVJqTWnyIUZqDRUmc
        NzlzQ6KQQHpiSWp2ampBahFMlomDU6qBySPxh8aqXr8zr//LBGu5CMR8WGYdpCSTGj//yi1n
        lwc+cUItp6dKlV1ccYjnZu6jFeWOi/aXPC/7P+HD37yIsK355y9Ium1g75MwrRP89jFPvdW8
        YfuvjycnFDQ8s71/Q1ZNTiZswyWVx+wvpM/NPHTXMD9Zfb12/6aCUCffn39Z6/7+2zuPKyqM
        e2aGbYTCxgC3B7O9zh89c3KWbyJHukHx+k1y7vyH9pseaO2uUBP1kfVRmXlbf4Zg+b7Chdy7
        PTc9WbV9aTOv8ocnoSaJ4QamPHV/pipWzF60cfWSVTbrj3r1Cr/tuM2jsr6YKXjp/xcX77Z/
        +xonbr7lpMH/n/OSrzPVXutu/6nV198WqMRSnJFoqMVcVJwIAJuAGtutAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xu7rfddmSDGb+lrCYfljRYvXdfjaL
        0xMWMVk8vvOZ3eLo/7dsFntvaVvcmPCU0eLz0hZ2izU3n7I4cHrsnHWX3WPzCi2Py2dLPTat
        6mTz6NuyitHj8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU
        1JzMstQifbsEvYzuE3/ZCq4KVlzr+8TWwHiJr4uRk0NCwESi+dRx1i5GLg4hgaWMEr86NzBB
        JCQkbi9sYoSwhSX+XOtigyh6zijxZPULoCIODjYBLYnGTnaQGhEBT4m2je1gg5gFVjNJ/D3X
        ywJSIyzgI3F1sj5IDYuAqsTflm6wVl4BS4k937ggxstLzLz0HWwMr4CgxMmZT1hAbGagePPW
        2cwTGPlmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDstx37uXkH47xXH/UO
        MTJxMB5ilOBgVhLhXXGDNUmINyWxsiq1KD++qDQntfgQoynQeROZpUST84GRl1cSb2hmYGpo
        YmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwGQdeD9Rl++9xcLr8mzbuhf8/eXH
        0rtFpPBVlf2E3GgOH76pi7a4fygrmJFkEzuzSzmdR/T+N+f6/qMv0mr0i5/YijZkLLxhzpFl
        4pe/4eMjJbdPD5W+X/hv//h61Xz9w9V21+dbrGcMU5aefOLrGg9toyDhWpE1uv3PPSse6tXu
        mqwv+b8jzEZtM2+O4p1bWUf3fagUMKt7t0u6WqFWfoahlZv6aua5H7bwTg1Z8HPfzMKKr5XZ
        CuqTBB4m//pjdrNfhvkRczyX4bwzWYHl7R8WPz7KFjfDg6G602qWkPPSJVknfk5NjV2jb8Cw
        5E52QthPSUfzexImR01UXq9XDtYUn2wWKN9+5lDRnn3hSizFGYmGWsxFxYkAKW2jBQQDAAA=
X-CMS-MailID: 20220211093549eucas1p122dbc242f60ec6fb701617184494dd98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220211093549eucas1p122dbc242f60ec6fb701617184494dd98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220211093549eucas1p122dbc242f60ec6fb701617184494dd98
References: <CGME20220211093549eucas1p122dbc242f60ec6fb701617184494dd98@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

  I found the following regression in ZNS devices when executing some basic
  workload:
[  182.240375] Call Trace:
[  182.240517]  <TASK>
[  182.240656]  btrfs_start_dirty_block_groups+0x6be/0xe80 [btrfs]
[  182.241091]  ? bio_init+0x398/0x620
[  182.241307]  ? btrfs_setup_space_cache+0x240/0x240 [btrfs]
[  182.241731]  ? mutex_unlock+0x80/0xd0
[  182.241964]  ? __mutex_unlock_slowpath.constprop.0+0x2a0/0x2a0
[  182.242490]  btrfs_commit_transaction+0x18aa/0x2820 [btrfs]
[  182.242901]  ? kasan_unpoison+0x23/0x50
[  182.243156]  ? join_transaction+0x255/0xe80 [btrfs]
[  182.244105]  ? btrfs_apply_pending_changes+0x50/0x50 [btrfs]
[  182.244554]  ? vfs_fsync_range+0x210/0x210
[  182.244839]  ? btrfs_attach_transaction_barrier+0x1f/0x70 [btrfs]
[  182.245293]  ? vfs_fsync_range+0x210/0x210
[  182.245563]  iterate_supers+0x109/0x200
[  182.245794]  ksys_sync+0xa8/0x130
[  182.245990]  ? vfs_fsync+0x200/0x200
[  182.246197]  ? do_user_addr_fault+0x31e/0xd60
[  182.246454]  ? kvm_read_and_reset_apf_flags+0x41/0x60
[  182.247240]  ? fpregs_assert_state_consistent+0x4a/0xb0
[  182.247613]  __do_sys_sync+0xa/0x10
[  182.247827]  do_syscall_64+0x3b/0x90
[  182.248041]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  182.252155]  </TASK>
[  182.252281] ---[ end trace 0000000000000000 ]---
[  182.252561] BTRFS: error (device nvme0n2) in btrfs_run_delayed_refs:2159:
                errno=-17 Object already exists
[  182.253110] BTRFS info (device nvme0n2): forced readonly

I am using QEMU with a ZNS drive with zoned.zone_capacity=128M,
zoned.zone_size=128M.

Steps to reproduce:

$ mkfs.btrfs /dev/nvme0n2 -d single -m single
$ mount -t btrfs  /dev/nvme0n2 /mnt/btrfs
$ cd /mnt/btrfs
$ head --bytes 1048576 /dev/random >> 4k_rand.bin
$ sync 
$ head --bytes 1048576 /dev/random >> 4k_rand.bin
$ sync

Git bisect run pointed the following as the offending commit:
commit 5581a5ddfe8d ("block: add completion handler for fast path")

The fast path completion handler does not handle the ZONE_APPEND
requests correctly.


Pankaj Raghav (1):
  block: Add handling for zone append command in blk_complete_request

 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.25.1

