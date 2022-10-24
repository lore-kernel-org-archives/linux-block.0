Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC30CC38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJXGPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJXGOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 02:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87660EA4
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666592052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=liXl5vAicX7ThqI3AqOVR54+B6XhwSHhU/P0UG99Dvo=;
        b=RHDBvkU5pQ07SY79GdKiaQ+eMCed5iYb26yB49I2geblZdoGwRbo5+/wZjfpHrBgLqdzCi
        vKqPc/LfXmtwVmvYlVTl+Pw/OTnCjb78LdFs3O5x+kdCZPNwOzY70hcYevBmilu2EwOm2/
        UNi+S/qudlXjO6Ji2l3+af6ImlIQBP4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-GVXhx1v4N7mp2iUu6JRqYA-1; Mon, 24 Oct 2022 02:14:09 -0400
X-MC-Unique: GVXhx1v4N7mp2iUu6JRqYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4E0C3C00088;
        Mon, 24 Oct 2022 06:14:03 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E07B6201F402;
        Mon, 24 Oct 2022 06:13:48 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 0/3] fix for xfs log size change from new version of xfsprogs
Date:   Mon, 24 Oct 2022 14:13:16 +0800
Message-Id: <20221024061319.1133470-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

This first patch addressed nvme/012 nvme/013 failure which introduced from xfsprogs
v5.19.0, the minimum xfs log size changed to 64m.

The second patch introduced one new function _get_test_dev_size_mb.

The third patch updated _xfs_run_fio_verify_io to accept one new
parameter size which will be used for nvme/012 nvme/013 nvme/015



Yi Zhang (3):
  common/xfs: set the minimal log size 64m during mkfs.xfs
  common/rc: add one function to get test dev size in mb
  common/xfs: update _xfs_run_fio_verify_io to accept the size parameter

 common/rc      | 8 ++++++++
 common/xfs     | 5 +++--
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/035 | 9 ++++++++-
 5 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.34.1

