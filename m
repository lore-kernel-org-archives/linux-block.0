Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34035 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750780AbdFPFDn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 01:03:43 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Fri, 16 Jun 2017 15:02:09 +1000
Subject: [PATCH 0/2] Two fixes for loop devices
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149758925866.10006.12779875832895865043.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,
 one of these is a resend of a patch I sent a while back.
 The other is new - loop closes files differently from close()
 and in a way that can confuse NFS.

Thanks,
NeilBrown

---

NeilBrown (2):
      loop: use filp_close() rather than fput()
      loop: Add PF_LESS_THROTTLE to block/loop device thread.


 drivers/block/loop.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--
Signature
