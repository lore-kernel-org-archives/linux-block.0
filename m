Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FAC33CB6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE49208C3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 12:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPMgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:36:38 -0500
Received: from relay.sw.ru ([185.231.240.75]:39058 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAPMgh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 07:36:37 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1is4NM-0000yM-QR; Thu, 16 Jan 2020 15:35:52 +0300
Subject: [PATCH block v2 0/3] block: Introduce REQ_NOZERO flag for
 REQ_OP_WRITE_ZEROES operation
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com, ktkhai@virtuozzo.com
Date:   Thu, 16 Jan 2020 15:35:51 +0300
Message-ID: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(was "[PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE
 to reflect extents allocation in block device internals")

v2: Introduce new flag for REQ_OP_WRITE_ZEROES instead of
    introduction a new operation as suggested by Martin K. Petersen.
    Removed ext4-related patch to focus on block changes
    for now.

Information about continuous extent placement may be useful
for some block devices. Say, distributed network filesystems,
which provide block device interface, may use this information
for better blocks placement over the nodes in their cluster,
and for better performance. Block devices, which map a file
on another filesystem (loop), may request the same length extent
on underlining filesystem for less fragmentation and for batching
allocation requests. Also, hypervisors like QEMU may use this
information for optimization of cluster allocations.

This patchset introduces REQ_NOZERO flag for REQ_OP_WRITE_ZEROES,
which makes a block device to allocate blocks instead of actual
blocks zeroing. This may be used for forwarding user's fallocate(0)
requests into block device internals. E.g., in loop driver this
will result in allocation extents in backing-file, so subsequent
write won't fail by the reason of no available space. Distributed
network filesystems will be able to assign specific servers for
specific extents, so subsequent write will be more efficient.

Patch [1/3] is preparation, patch [2/3] introduces REQ_NOZERO flag
and implements all the logic, patch [3/3] adds loop as the first
user of the flag.

Note, that here is only block-related patches, example of usage
for ext4 with a performance numbers may be seen in [1].

[1] https://lore.kernel.org/linux-ext4/157599697369.12112.10138136904533871162.stgit@localhost.localdomain/T/#me5bdd5cc313e14de615d81bea214f355ae975db0

---

Kirill Tkhai (3):
      block: Add @flags argument to bdev_write_zeroes_sectors()
      block: Add support for REQ_NOZERO flag
      loop: Add support for REQ_NOZERO


 block/blk-core.c                    |    6 +++---
 block/blk-lib.c                     |   17 ++++++++++-------
 block/blk-merge.c                   |    9 ++++++---
 block/blk-settings.c                |   17 +++++++++++++++++
 drivers/block/loop.c                |   15 ++++++++++++---
 drivers/md/dm-kcopyd.c              |    2 +-
 drivers/target/target_core_iblock.c |    4 ++--
 fs/block_dev.c                      |    4 ++++
 include/linux/blk_types.h           |    5 ++++-
 include/linux/blkdev.h              |   34 ++++++++++++++++++++++++++--------
 10 files changed, 85 insertions(+), 28 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

