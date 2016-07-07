Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51399 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750946AbcGGS0l (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 7 Jul 2016 14:26:41 -0400
Date: Thu, 7 Jul 2016 12:26:36 -0600
From: Jens Axboe <axboe@fb.com>
To: <torvalds@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: [GIT PULL] IO fixes for 4.7-rc
Message-ID: <20160707182636.GA8567@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Three small fixes that have been queued up and tested for this series.
This pull request contains:

- A bug fix for xen-blkfront from Bob Liu, fixing an issue with
  incomplete requests during migration.

- A fix for an ancient issue in retrieving the IO priority of a
  different PID than self, preventing that task from going away while we
  access it. From Omar.

- A writeback fix from Tahsin, fixing a case where we'd call ihold()
  with a zero ref count inode.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bob Liu (1):
      xen-blkfront: save uncompleted reqs in blkfront_resume()

Jens Axboe (1):
      Merge branch 'stable/for-jens-4.7' of git://git.kernel.org/.../konrad/xen into for-linus

Omar Sandoval (1):
      block: fix use-after-free in sys_ioprio_get()

Tahsin Erdogan (1):
      writeback: inode cgroup wb switch should not call ihold()

 block/ioprio.c               |  2 +
 drivers/block/xen-blkfront.c | 91 +++++++++++++++++++-------------------------
 fs/fs-writeback.c            |  2 +-
 3 files changed, 43 insertions(+), 52 deletions(-)

-- 
Jens Axboe

