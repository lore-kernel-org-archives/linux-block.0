Return-Path: <SRS0=p+1D=3P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE5C35240
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 04:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1896120842
	for <linux-block@archiver.kernel.org>; Sun, 26 Jan 2020 04:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAZEmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jan 2020 23:42:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:26120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgAZEmZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jan 2020 23:42:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 20:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,364,1574150400"; 
   d="scan'208";a="260691504"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.70.106])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2020 20:42:23 -0800
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To:     axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: [PATCH 0/2] Enable polling on stackable devices
Date:   Sat, 25 Jan 2020 21:41:36 -0700
Message-Id: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

IO polling is available on blk-mq devices. Currently it is not possible to
perform IO polling on stackable devices like MD. 

We have built a prototype exposing new function for bio devices to do IO
polling on them. That function is in available on request_queue so bio based
drivers can provide handler for it. 

IO polling has been provided for RAID-0 level for MD.

Andrzej Jakowski (2):
  block: introduce polling on bio level
  md: enable io polling

 block/blk-core.c       |  3 ++-
 block/blk-mq.c         | 26 ++++++++++++++++++++++++++
 drivers/md/md.c        | 39 +++++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  2 ++
 4 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.20.1

