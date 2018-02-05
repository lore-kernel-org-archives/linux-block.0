Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44260 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeBEMPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Feb 2018 07:15:35 -0500
Received: by mail-lf0-f66.google.com with SMTP id v188so41390769lfa.11
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2018 04:15:34 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 0/4] lightnvm: base 2.0 implementation
Date: Mon,  5 Feb 2018 13:15:01 +0100
Message-Id: <20180205121505.27563-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

A couple of patches for 2.0 support for the lightnvm subsystem. They
form the basis for integrating 2.0 support.

For the rest of the support, Javier has code that implements report
chunk and sets up the LBA format data structure. He also has a bunch
of patches that brings pblk up to speed.

The first two patches is preparation for the 2.0 work. The third patch
implements the 2.0 data structures, the geometry command, and exposes
the sysfs attributes that comes with the 2.0 specification. Note that
the attributes between 1.2 and 2.0 are different, and it is expected
that user-space shall use the version sysfs attribute to know which
attributes will be available.

The last patch implements support for using the nvme namespace logical
block and metadata fields and sync it with the internal lightnvm
identify structures.

-Matias

Matias Bjørling (4):
  lightnvm: make 1.2 data structures explicit
  lightnvm: flatten nvm_id_group into nvm_id
  lightnvm: add 2.0 geometry identification
  nvme: lightnvm: add late setup of block size and metadata

 drivers/lightnvm/core.c      |  27 ++-
 drivers/nvme/host/core.c     |   2 +
 drivers/nvme/host/lightnvm.c | 508 ++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h     |   2 +
 include/linux/lightnvm.h     |  64 +++---
 5 files changed, 426 insertions(+), 177 deletions(-)

-- 
2.11.0
