Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V5 PATCH 0/3] lightnvm: pblk: take write semaphore on metadata
Date: Tue, 11 Sep 2018 13:24:48 +0200
Message-Id: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

# Changes since V4:
 - Rebase on top of Matias' core
 - Reorder patches to avoid in-patchset changes

# Changes since V3:
 - Encapsulate rqd dma allocations to reduce code replication (by Matias)

# Changes since V2:
 - Split the original patch between the metadata refactoring and the
   semaphore logic. This simplifies the write path, where the semaphore
   is taken.

# Changes singe V1:
    - Fix double I/O on the read path (by Matias)
    - Improve commit message (by Jens)

This patchset refactors the metadata separate write and read paths,
which simplifies how the semaphore is taken for writes.

Thanks,
Javier

Javier González (3):
  lightnvm: encapsule rqd dma allocations
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata

 drivers/lightnvm/pblk-core.c     | 376 ++++++++++++++++++++-------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-read.c     |  31 ++--
 drivers/lightnvm/pblk-recovery.c |  34 ++--
 drivers/lightnvm/pblk-write.c    |  15 +-
 drivers/lightnvm/pblk.h          |   7 +-
 6 files changed, 222 insertions(+), 243 deletions(-)

-- 
2.7.4
