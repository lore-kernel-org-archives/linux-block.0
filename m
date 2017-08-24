Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34764 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdHXHDw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:03:52 -0400
Received: by mail-pg0-f51.google.com with SMTP id s14so12546989pgs.1
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2017 00:03:52 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 0/4] loop: support different logical block sizes
Date: Thu, 24 Aug 2017 00:03:40 -0700
Message-Id: <cover.1503558155.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi, everyone,

Here's another attempt at supporting different logical block sizes for
loop devices. First, some terminology:

 * Logical block size: the lowest possible block size that the storage
   device can address.
 * Physical block size: the lowest possible sector size that the
   hardware can operate on without reverting to read-modify-write
   operations. Always greater than or equal to the logical block size.

These are characteristics of the device itself tracked in the
request_queue. For loop devices, both are currently always 512 bytes.

struct block_device also has another block size, basically a "soft"
block size which is the preferred I/O size and can be changed from
userspace. For loop devices, this is PAGE_SIZE if the backing file is a
regular file or otherwise the soft block size of the backing block
device.

Patch 1 simplifies how the soft block size is set. I'm tempted to not
set it at all and use the default of PAGE_SIZE, but maybe someone is
depending on inheriting the soft block size from the backing block
device...

Patch 2 sets the physical block size of loop devices to a more
meaningful value for loop, PAGE_SIZE.

Patch 3 allows us to change the logical block size. It adds a new ioctl
instead of the previous approach (which extends LOOP_{GET,SET}_STATUS).
Hannes, I assume you had a specific reason for doing it the way you did,
care to explain?

Patch 4 is a cleanup.

This is based on my patch reverting the original block size support,
targeting 4.14. Thanks!

Omar Sandoval (4):
  loop: get rid of lo_blocksize
  loop: set physical block size to PAGE_SIZE
  loop: add ioctl for changing logical block size
  loop: fold loop_switch() into callers

 drivers/block/loop.c      | 112 ++++++++++++++++------------------------------
 drivers/block/loop.h      |   1 -
 include/uapi/linux/loop.h |   1 +
 3 files changed, 40 insertions(+), 74 deletions(-)

-- 
2.14.1
