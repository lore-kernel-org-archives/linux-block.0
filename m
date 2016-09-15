Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44919 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752429AbcIOOyP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:54:15 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Subject: [GIT PULL] Block fixes for 4.8-rc
Message-ID: <e3b80293-d2e2-dc21-073b-b892664dff36@fb.com>
Date: Thu, 15 Sep 2016 08:54:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

A set of fixes for the current series in the realm of block. Like the
previous pull request, the meat of it are fixes for the nvme fabrics/target
code. Outside of that, just one fix from Gabriel for not doing a queue
suspend if we didn't get the admin queue setup in the first place.

Note that this branch contains a patch that will cause a merge conflict
with your commit:

commit bd0b841fee49de421f615cc173ccff063303672f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Sep 11 14:41:49 2016 -0700

     nvme: make NVME_RDMA depend on BLOCK

since you ended up fixing that one up yourself. Apart from that, it will
merge cleanly.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Arnd Bergmann (1):
       nvme-rdma: add back dependency on CONFIG_BLOCK

Colin Ian King (1):
       nvme-rdma: fix null pointer dereference on req->mr

Gabriel Krisman Bertazi (1):
       nvme: Don't suspend admin queue that wasn't created

Jens Axboe (1):
       Merge branch 'nvmf-4.8-rc' of 
git://git.infradead.org/nvme-fabrics into for-linus

Sagi Grimberg (1):
       nvme-rdma: add DELETING queue flag

Steve Wise (5):
       iw_cxgb4: call dev_put() on l2t allocation failure
       iw_cxgb4: block module unload until all ep resources are released
       nvme_rdma: keep a ref on the ctrl during delete/flush
       nvme-rdma: destroy nvme queue rdma resources on connect failure
       nvme-rdma: use ib_client API to detect device removal

Wenbo Wang (1):
       nvme/quirk: Add a delay before checking device ready for memblaze 
device

  drivers/infiniband/hw/cxgb4/cm.c       |   6 +-
  drivers/infiniband/hw/cxgb4/device.c   |   5 ++
  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |   1 +
  drivers/nvme/host/Kconfig              |   1 +
  drivers/nvme/host/pci.c                |   9 ++-
  drivers/nvme/host/rdma.c               | 144 
++++++++++++++++-----------------
  6 files changed, 91 insertions(+), 75 deletions(-)

-- 
Jens Axboe

