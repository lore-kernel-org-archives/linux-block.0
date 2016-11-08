Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44321 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbcKHSQY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 13:16:24 -0500
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-block@vger.kernel.org,
        Stephen Bates <stephen.bates@microsemi.com>
Message-ID: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
Date: Tue, 8 Nov 2016 11:16:20 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------ED5B86C66CB198DB454D75CD"
Subject: BUG: Hung task timeouts in for-4.10/dio
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------ED5B86C66CB198DB454D75CD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi guys,

We were looking at testing the new IO polling improvements and we built
a kernel from the 'for-4.10/dio' (64ead7d) branch in linux-block.
However this branch seems to cause hung tasks when booted. Most
noticeably, dhclient seems to always hang as it tries to read from it's
leases file, and that means networking does not work on the computers we
tested on. Other tasks seemed to hang occasionally and randomly.

We tested on two machines with radically different hardware but both
running Debian Jessie.  (One is a dual-socket server system with the
root FS on an HDD and the other is an off the shelf commodity
motherboard with root on an SSD.)

We performed a bisect to find the culprit commit to be:

[b685d3d65ac791406e0dfd8779cc9b3707fea5a3] block: treat REQ_FUA and
REQ_PREFLUSH as synchronous

I've attached a bisect log.

Thanks,

Logan

--------------ED5B86C66CB198DB454D75CD
Content-Type: text/x-log;
 name="block-bisect.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="block-bisect.log"

git bisect start
# good: [1001354ca34179f3db924eb66672442a173147dc] Linux 4.9-rc1
git bisect good 1001354ca34179f3db924eb66672442a173147dc
# bad: [64ead7d24b34ed40e85577e9be8bd203835e57c4] blk-mq: make the polling code adaptive
git bisect bad 64ead7d24b34ed40e85577e9be8bd203835e57c4
# bad: [70fd76140a6cb63262bd47b68d57b42e889c10ee] block,fs: use REQ_* flags directly
git bisect bad 70fd76140a6cb63262bd47b68d57b42e889c10ee
# good: [2552e3f878c2b43b41d7728a328821d8220c28da] blk-mq: get rid of confusing blk_map_ctx structure
git bisect good 2552e3f878c2b43b41d7728a328821d8220c28da
# good: [aa39ebd404423e62f74cfd3e27e9ffe7e38b2a25] cfq-iosched: use op_is_sync instead of opencoding it
git bisect good aa39ebd404423e62f74cfd3e27e9ffe7e38b2a25
# good: [67f055c798c72c49ee0c844eae0cd6e9c83b1b16] btrfs: use op_is_sync to check for synchronous requests
git bisect good 67f055c798c72c49ee0c844eae0cd6e9c83b1b16
# bad: [b685d3d65ac791406e0dfd8779cc9b3707fea5a3] block: treat REQ_FUA and REQ_PREFLUSH as synchronous
git bisect bad b685d3d65ac791406e0dfd8779cc9b3707fea5a3
# good: [6f6b29171a192e84b666c816e49d2175afbbb09f] block: don't use REQ_SYNC in the READ_SYNC definition
git bisect good 6f6b29171a192e84b666c816e49d2175afbbb09f
# first bad commit: [b685d3d65ac791406e0dfd8779cc9b3707fea5a3] block: treat REQ_FUA and REQ_PREFLUSH as synchronous

--------------ED5B86C66CB198DB454D75CD--
