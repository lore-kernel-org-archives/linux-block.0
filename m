Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D6C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiKBC6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKBC6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A862252B
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667357842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z/oodAW8tY/A2YDI3YyoMZ1e6KkT5y11OiMXHmNXw00=;
        b=iNSEsQah0kYGs2GBucQlbBwaKcWva6NsTWVOuq0LPza/e1hiIbeA8nUH/t7mCbunNN+101
        Psy9km45aHUU2okMB+0yOx4bJt+7MXVVMXFhcVe6YqaOfyx5r6gBk2N9D8C0kzKUtCZFG3
        6H8i5hXpcgQFEi10WWI5r/eeREH088s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-P9FMepT3P4SbRoX5SEPIFA-1; Tue, 01 Nov 2022 22:57:21 -0400
X-MC-Unique: P9FMepT3P4SbRoX5SEPIFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC58800B30;
        Wed,  2 Nov 2022 02:57:20 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ECE1422A9;
        Wed,  2 Nov 2022 02:57:18 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH V2 blktests 0/3] fix and improvement for xfs log size change from new xfsprogs version
Date:   Wed,  2 Nov 2022 10:56:59 +0800
Message-Id: <20221102025702.1664101-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

The first patch addressed nvme/012 nvme/013 failure which introduced
from xfsprogs v5.19.0, the minimun xfs log size change to 64m

The second patch introduced one new function _require_test_dev_size_mb

The third patch add one new parameter to _run_fio_verify_io, this will
allow fio I/O size definition to the test case


V2:
Update the new function to _require_test_dev_size_mb and nvme/035
to call it for test dev size checking for the second patch
Update the title and description for better reflect the change for the
third patch

V1: https://lore.kernel.org/linux-block/20221024061319.1133470-1-yi.zhang@redhat.com/

Yi Zhang (3):
  common/xfs: set the minimal log size 64m during mkfs.xfs
  common/rc: add one function _require_test_dev_size_mb
  nvme/012,013,035: change fio I/O size and move size definition place

 common/rc      | 10 ++++++++++
 common/xfs     |  5 +++--
 tests/nvme/012 |  2 +-
 tests/nvme/013 |  2 +-
 tests/nvme/035 |  6 +++++-
 5 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.34.1

