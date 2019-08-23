Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D6C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A095F2173E
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I7lw6jGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfHWAPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30872 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHWAPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519330; x=1598055330;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NVzjKfjVqM0tEBBsmDVJCQ0K1dgI4f105BIsAh1iws0=;
  b=I7lw6jGIljJwz2Mahag+t3UpVwJm47gStzszLY1av+31e6eiDZtl6STq
   OJNrXe+WGNTx0oYHMnDUQiNtGNQOCJ5hkxq7QpzPofzCj+d9srZsaOPwe
   djK48RxhoWQWYvIn6zZ0WKmXlL96urFwamReRFDuWvrs9QuedRfOIOzdb
   rfohTNkZZ/W4wtN+OHiqraqsACdA6caoTj1alEUL30FitCXAXJgx39GkU
   uq71upWJSf/vaXyA5g8Col6KdzIzCNos1zxgr/zyYcTulHohSQprvmnoP
   tXW95KXvGpU5OaNk29S87aAL1h9nU799VaM/KZPFgxrv/XVslPy0JhGPZ
   w==;
IronPort-SDR: wUsR5vV0uORbY9B7FcYFRJ/5m0pza/lk7GRNCd8bpjnj/LSLvcXX++0CABsU+w2/bY3nYBPgYh
 uOKX7oFuAzvqgUJSVZmVS5PUp1D1hK6zrt3o353/xaAX/DcG9GKRlWrbUQe76lIdrkQc9/q90M
 OioA3JVp/ZwR1lPxVOCPZ2cvT6K78EKinC+14rjz7NvDAi/rJJD3phlPlLsWf1aBzsNOkRBzrX
 4QdPs8sBEnvMRNW2w5w2sQ3DDoJRc0di2u2fBkZXblBFkThlv0bZmP9j2BYEE8NRNPShO+ALWB
 BJo=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063662"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:30 +0800
IronPort-SDR: 6NABK5qhD+NuVHpaAtVr+BQJxwGGNTeib8slIJUGtA2UAuvJ/Bbe7WH06QZFlWQQ+Nct0yN9+t
 md77V12BzvSbiBRFaMsVUCGf6JSp5Xm6kvsFDmNtOHIt+Jny6VmTdQ/GKoVsW7/+GmVQW5YIq5
 tthXWutzB/BSzQu7Bvx8YWnsQ7djqTIk4yhmQnSCwLggg6U9BA6e3rzQrO3oprSfE42fRe7acc
 yFYfXdcZAfGtnLOn1Hmyz4Ij5Kx0ELB5GcmVPvFXeTaKTo1SIxlK+xE/ngYwry2x5XzKYkoWtA
 cgqnXCRsLDvREfcV6uTkNDSe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:49 -0700
IronPort-SDR: E9+3aFmMK7s0pzPt3SKVyzeeK8AZrhfJhmQkH+bTx4UXqzAcJg6wtr69+hQJibNvZlAe/4JjGk
 sGbhyvNJkDadt6a4EuFj1RWTt1sb65wVCQqPIhoEL7WjNnL2b13wCJ8pMYwPXuzNPKOwgPDB4h
 Y1pKLhBgyITVV/JSM6LJm79wx/giJXfl74Utwd238dmUGLEUm8LUWdysSyIxLQqfDDeZG2mhB9
 LLJb9But4IT8YyHVOoEKj0ylOie4hKLdQxnRhsQLL0YM190S7c3MhlrVeXhV/ok72LKrBo7YFj
 /2k=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/7] Elevator cleanups and improvements
Date:   Fri, 23 Aug 2019 09:15:21 +0900
Message-Id: <20190823001528.5673-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series implements some cleanup of the elevator initialization
code and introduces elevator features identification and device matching
to enhance checks for elevator/device compatibility and fitness.

The first 3 patches of the series are simple cleanups which simplify and
streamline elevator initialization for newly allocated device queues.

The following two patches introduce elevator features control which
allow defining features and function that an elevator supports and match
these against features required by a block device driver. With this, the
sysfs elevator list for a device always only shows elevators matching
the features that a particular device requires, with the exception of
the none elevator which has no features but is always available for use
with any device.

The first feature defined is for zoned block device write order control
through zone write locking which prevents the use of any scheduler that
does not support this feature with zoned devices.

The last 2 patches of this series rework the default elevator selection
and initialization to allow for the feature matching to work,
simultaneously addressing cases not currently well supported, namely,
multi-queue zoned block devices.

Damien Le Moal (7):
  block: Cleanup elevator_init_mq() use
  block: Change elevator_init_mq() to always succeed
  block: Remove sysfs lock from elevator_init_rq()
  block: Introduce elevator features
  block: Introduce zoned block device elevator feature
  block: Improve default elevator selection
  block: Delay default elevator initialization

 block/blk-mq.c                |  10 ---
 block/blk-settings.c          |  15 ++++
 block/blk.h                   |   2 +-
 block/elevator.c              | 144 +++++++++++++++++++++++++---------
 block/genhd.c                 |   3 +
 block/mq-deadline.c           |   1 +
 drivers/block/null_blk_main.c |   5 ++
 drivers/scsi/sd_zbc.c         |   2 +
 include/linux/blkdev.h        |   4 +
 include/linux/elevator.h      |   8 ++
 10 files changed, 147 insertions(+), 47 deletions(-)

-- 
2.21.0

