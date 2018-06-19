Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47342 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbeFSUXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:23:55 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/9] blktests: Re-enable shellcheck warnings
Date: Tue, 19 Jun 2018 13:23:44 -0700
Message-Id: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Omar,

Since I noticed that several useful shellcheck warnings are suppressed in the
blktests project, I came up with this patch series that reenables all
shellcheck warnings and also suppresses false positive shellcheck reports. It
would be appreciated if you could have a look at this patch series.

Thanks,

Bart.

Bart Van Assche (9):
  common/rc: Fix _have_tracepoint()
  Annotate include statements in shell scripts where the source file is
    a variable
  check, tests/meta/012: Use array["index"] instead of array[index]
  Suppress shellcheck complaints about global variables
  check: Avoid that shellcheck complains that $FULL appears unused
  Multiple tests: remove unused and undefined variables
  Avoid passing tests/block/002 arguments to _init_scsi_debug
  check: Suppress a shellcheck warning about the DMESG_FILTER
    initialization
  Makefile: Do not suppress useful shellcheck warnings

 Makefile          | 15 +-------------
 check             | 53 ++++++++++++++++++++++++++---------------------
 common/cpuhotplug |  2 ++
 common/fio        |  2 ++
 common/iopoll     |  2 ++
 common/loop       |  1 +
 common/nbd        |  2 ++
 common/nvme       |  2 ++
 common/rc         |  2 ++
 common/scsi       |  2 ++
 common/scsi_debug |  3 +++
 common/shellcheck |  4 ++++
 new               |  1 +
 tests/block/001   |  1 +
 tests/block/002   |  3 ++-
 tests/block/003   |  2 ++
 tests/block/004   |  2 ++
 tests/block/005   |  2 ++
 tests/block/006   |  2 ++
 tests/block/007   |  1 +
 tests/block/009   |  1 +
 tests/block/010   |  2 ++
 tests/block/011   |  2 ++
 tests/block/012   |  2 ++
 tests/block/013   |  2 ++
 tests/block/014   |  2 ++
 tests/block/015   |  2 ++
 tests/block/016   |  2 ++
 tests/block/017   |  2 ++
 tests/block/018   |  2 ++
 tests/block/019   |  2 ++
 tests/block/020   |  2 ++
 tests/block/021   |  2 ++
 tests/loop/001    |  2 ++
 tests/loop/003    |  5 ++---
 tests/loop/005    |  2 ++
 tests/meta/001    |  2 ++
 tests/meta/002    |  2 ++
 tests/meta/003    |  2 ++
 tests/meta/004    |  2 ++
 tests/meta/005    |  2 ++
 tests/meta/006    |  2 ++
 tests/meta/007    |  2 ++
 tests/meta/008    |  2 ++
 tests/meta/009    |  2 ++
 tests/meta/010    |  2 ++
 tests/meta/011    |  2 ++
 tests/meta/012    |  6 ++++--
 tests/nbd/001     |  2 ++
 tests/nbd/002     |  2 ++
 tests/nvme/001    |  2 ++
 tests/nvme/002    |  2 ++
 tests/nvme/003    |  2 ++
 tests/nvme/004    |  2 ++
 tests/nvme/005    |  2 ++
 tests/nvme/006    |  2 ++
 tests/nvme/007    |  2 ++
 tests/nvme/008    |  2 ++
 tests/nvme/009    |  2 ++
 tests/nvme/010    |  5 +++--
 tests/nvme/011    |  5 +++--
 tests/nvme/012    |  3 ++-
 tests/nvme/013    |  3 ++-
 tests/scsi/001    |  2 ++
 tests/scsi/002    |  2 ++
 tests/scsi/003    |  2 ++
 tests/scsi/004    |  1 +
 67 files changed, 161 insertions(+), 50 deletions(-)
 create mode 100644 common/shellcheck

-- 
2.17.1
