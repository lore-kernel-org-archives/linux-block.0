Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F2C433DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 01:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4152075D
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 01:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHQBkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:40:49 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:40714 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgHQBkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 21:40:49 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Aug 2020 21:40:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id EA1661801A5F5
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 01:34:23 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 607B5180A7FEF;
        Mon, 17 Aug 2020 01:34:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen59_160526327012
X-Filterd-Recvd-Size: 3007
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 01:34:20 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH V2 0/6] ceph: Use more generic logging
Date:   Sun, 16 Aug 2020 18:34:03 -0700
Message-Id: <cover.1597626802.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert the dout macro to the normal pr_debug.
Convert embedded function names in these changes to %s, __func__
Remove the dout macro definitions

Joe Perches (6):
  ceph: Use generic debugging facility
  ceph: Remove embedded function names from pr_debug uses
  net: ceph:  Use generic debugging facility
  net: ceph: Remove embedded function names from pr_debug uses
  rbd: Use generic debugging facility
  ceph_debug: Remove now unused dout macro definitions

 drivers/block/rbd.c             | 231 +++++++-------
 fs/ceph/addr.c                  | 266 ++++++++--------
 fs/ceph/cache.c                 |  22 +-
 fs/ceph/caps.c                  | 533 ++++++++++++++++----------------
 fs/ceph/debugfs.c               |   4 +-
 fs/ceph/dir.c                   | 141 ++++-----
 fs/ceph/export.c                |  36 +--
 fs/ceph/file.c                  | 170 +++++-----
 fs/ceph/inode.c                 | 338 ++++++++++----------
 fs/ceph/ioctl.c                 |   6 +-
 fs/ceph/locks.c                 |  42 +--
 fs/ceph/mds_client.c            | 374 +++++++++++-----------
 fs/ceph/mdsmap.c                |  16 +-
 fs/ceph/metric.c                |   4 +-
 fs/ceph/quota.c                 |   4 +-
 fs/ceph/snap.c                  | 135 ++++----
 fs/ceph/super.c                 |  67 ++--
 fs/ceph/xattr.c                 |  64 ++--
 include/linux/ceph/ceph_debug.h |  30 --
 include/linux/ceph/messenger.h  |   2 +-
 net/ceph/auth.c                 |  21 +-
 net/ceph/auth_none.c            |   4 +-
 net/ceph/auth_x.c               |  85 ++---
 net/ceph/buffer.c               |   6 +-
 net/ceph/ceph_common.c          |  18 +-
 net/ceph/cls_lock_client.c      |  32 +-
 net/ceph/crypto.c               |   8 +-
 net/ceph/debugfs.c              |   4 +-
 net/ceph/messenger.c            | 330 ++++++++++----------
 net/ceph/mon_client.c           |  99 +++---
 net/ceph/msgpool.c              |  14 +-
 net/ceph/osd_client.c           | 393 ++++++++++++-----------
 net/ceph/osdmap.c               | 101 +++---
 net/ceph/pagevec.c              |  10 +-
 34 files changed, 1835 insertions(+), 1775 deletions(-)

-- 
2.26.0

