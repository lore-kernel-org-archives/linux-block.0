Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A61AC3F2CE
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C220757
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgCQPLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:11:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCQPLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 11:11:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4A3E4290AC2
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel@collabora.com,
        andrzej.p@collabora.com
Subject: [PATCH 0/2] loop: Better discard support for block devices
Date:   Tue, 17 Mar 2020 16:11:09 +0100
Message-Id: <20200317151111.25749-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a respin of the series from Evan, after rebasing it
on a current tree (v5.6-rc6). In the current upstream tree
there already is code which differentiates between REQ_OP_DISCARD
and REQ_OP_WRITE_ZEROS. Since applying the second patch required
dropping some code inside it, I have also dropped the A-b/R-b tags.

Below is the cover letter of the previous iteration of the series:

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support write zeroes.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
zeroing capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does an fallocate operation on the
backing device. After this change, backing block devices that do support
zeroing will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support zeroing will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.


Changes in v5:
- Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)

Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated tags
- Updated commit description

Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 51 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 13 deletions(-)

-- 
2.17.1

