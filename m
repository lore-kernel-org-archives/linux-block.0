Return-Path: <ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ian W MORRISON <ianwmorrison@gmail.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [GIT PULL] MMC fixes for v4.19-rc2
Date: Thu, 30 Aug 2018 14:20:53 +0200
Message-Id: <20180830122053.15803-1-ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.19-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 778a33959a8ad4cb1ea2f4c5119f9e1e8b9f9d9b:

  Merge tag 'please-pull-noboot' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2018-08-20 19:37:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-2

for you to fetch changes up to d2332f887ddfba50fee93b8e1736376517c2df0c:

  mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts (2018-08-23 10:00:49 +0200)

----------------------------------------------------------------
MMC core:
 - Fix unsupported parallel dispatch of requests

MMC host:
 - atmel-mci/android-goldfish: Fixup logic of sg_copy_{from,to}_buffer
 - renesas_sdhi_internal_dmac: Prevent IRQ-storm due of DMAC IRQs
 - renesas_sdhi_internal_dmac: Fixup bad register offset

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix unsupported parallel dispatch of requests

Ludovic Desroches (2):
      mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
      mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion

Sergei Shtylyov (2):
      mmc: renesas_sdhi_internal_dmac: fix #define RST_RESERVED_BITS
      mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts

 drivers/mmc/core/queue.c                      | 12 +++++++-----
 drivers/mmc/core/queue.h                      |  1 +
 drivers/mmc/host/android-goldfish.c           |  4 ++--
 drivers/mmc/host/atmel-mci.c                  | 12 ++++++------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 10 +++++++++-
 5 files changed, 25 insertions(+), 14 deletions(-)
