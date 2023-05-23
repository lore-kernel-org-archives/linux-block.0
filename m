Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD3C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjEWHym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjEWHy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:28 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6799A1AD
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CBbH/2Wtu1agz164i1n7UjP5raCPCguoFeU9ZeHUOzc=;
        b=HeMnADA3bFRUo0hx5zdMzrmDAEHP7gj2+JfuN7d2VJKzN8isz9uALB6EMUC8+knEiHUP1m
        IIhhK6Y9fao22Q1oYY+Ev2QsZPv2jQ3kni7KNHSXCRdCciQ1cYffed6oeRK65wUVlL4PK9
        RICUG7luAl7jMe85wLWIcQaG7mYJf3Q=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 00/10] misc patches for rnbd
Date:   Tue, 23 May 2023 15:53:21 +0800
Message-Id: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This series mostly do cleanup and other trival things, pls review.    

Thanks,
Guoqing    

Guoqing Jiang (10):
  block/rnbd: kill rnbd_flags_supported
  block/rnbd-srv: remove unused header
  block/rnbd: introduce rnbd_access_modes
  block/rnbd-srv: no need to check sess_dev
  block/rnbd-srv: defer the allocation of rnbd_io_private
  block/rnbd-srv: rename one member in rnbd_srv_dev
  block/rnbd-srv: init ret with 0 instead of -EPERM
  block/rnbd-srv: init err earlier in rnbd_srv_init_module
  block/rnbd-srv: make process_msg_sess_info returns void
  block/rnbd: change device's name

 drivers/block/rnbd/Makefile         |  6 ++--
 drivers/block/rnbd/rnbd-clt-sysfs.c |  6 ++--
 drivers/block/rnbd/rnbd-common.c    | 23 ------------
 drivers/block/rnbd/rnbd-proto.h     | 31 +++++-----------
 drivers/block/rnbd/rnbd-srv-sysfs.c |  5 ++-
 drivers/block/rnbd/rnbd-srv.c       | 56 ++++++++++++-----------------
 drivers/block/rnbd/rnbd-srv.h       |  2 +-
 7 files changed, 40 insertions(+), 89 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-common.c

-- 
2.35.3

