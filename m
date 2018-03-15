Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeCOKmv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 06:42:51 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/4] bcache-tools: enable big endian support for s390x 
Date: Thu, 15 Mar 2018 18:42:36 +0800
Message-Id: <20180315104240.24647-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recently I recieve a bug report that bcache does not work on IBM s390x,
I find the problem is from endianness support and checksum calculation.

Both user space tools and Linux kernel code should be fixed, this patch
set is the modification to user space tools.

Ideas of this patch set are,
1, super block members should be swapped to little endian before writting
   down to media.
2, super block members should be explicitly swapped to little endian
   before calculate checksum.
3, checksum also should be swapped to little endian before writiting down
   to media.
4, checksum is checked before super block members being swapped into CPU
   byteorder.

The first 3 patches are preparation and the last patch does big endian
support.

NOTE: Linux kernel code also needs to be patched, this patch set just
makes new created bcache devices in a correct byte order.

Coly Li
---

Coly Li (4):
  bcache-tools: change bcache.c:crc64() to non-inline function
  bcache-tools: only set/display sb.bucket_size for cache devices
  bcache-tools: print more super block information in bcache-super-show
  bcache-tools: add CPU endianness support

 bcache-super-show.c | 52 +++++++++++++++++++++-----------
 bcache.c            | 75 ++++++++++++++++++++++++++++++++++++++++++++-
 bcache.h            | 19 +++++++++---
 byteorder.h         | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 make-bcache.c       |  5 +--
 5 files changed, 212 insertions(+), 26 deletions(-)
 create mode 100644 byteorder.h

-- 
2.16.2
