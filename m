Return-Path: <javier@javigon.com>
Return-Path: <javier@javigon.com>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V3 PATCH 0/2] lightnvm: pblk: take write semaphore on metadata
Date: Fri, 17 Aug 2018 12:19:08 +0200
Message-Id: <1534501150-11906-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

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

Javier González (2):
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata

 drivers/lightnvm/pblk-core.c     | 352 +++++++++++++++++++--------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-recovery.c |   4 +-
 drivers/lightnvm/pblk.h          |   5 +-
 4 files changed, 178 insertions(+), 185 deletions(-)

-- 
2.7.4
