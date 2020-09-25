Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F40C4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 01:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20D720838
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 01:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600997326;
	bh=5VtJpDdYtCwZlRfMorsUAUPg+YDyujpIPaxXRnHMyk0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=C38DoROkjPQTM6HnIDJ0s1dAbo0N54EWoOEThpUD1rKLb75nzUf3TLao9tBrfXt5I
	 O5OGMqP8ngrMUE4M+klHXm3YRu/W7k+dW3cE4bD5Rdg9E0E43Elp5aK5hfEhNfWui9
	 z6/dmWengZoyrC2O9ndA2pGUIJ/TzUOC8RxQAWHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIYB2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgIYB2k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 21:28:40 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2035320809;
        Fri, 25 Sep 2020 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600997319;
        bh=5VtJpDdYtCwZlRfMorsUAUPg+YDyujpIPaxXRnHMyk0=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2UiWXKbQbJSc+yQpun/bDs5/NcjuHWRe9tkKiqGMHZlsgMmsEUVHZxP6nyGaRwqz
         fjBNTwUMIAfvc8HUBkRAqwFCDi5wsmzqbHq4zMENphEqDoacUDrKEuMFizuRcaTQgN
         L1kdPkolCTr9I1Rz5/vbo/g1Q2F2v5seKk7SWI6E=
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/3] zoned block device specific errors
Date:   Thu, 24 Sep 2020 18:28:35 -0700
Message-Id: <20200925012838.4043473-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zone block devices may have some limits that require special handling.
This series provides a way for drivers to notify of these conditions.

v3 -> v4:

Added reviews/acks/sobs

Dropped unintended patch

Damien Le Moal (1):
  scsi: handle zone resources errors

Keith Busch (2):
  block: add zone specific block statuses
  nvme: translate zone resource errors

 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-core.c                    |  4 ++++
 drivers/nvme/host/core.c            |  4 ++++
 drivers/scsi/scsi_lib.c             |  9 +++++++++
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 5 files changed, 43 insertions(+)

-- 
2.24.1

