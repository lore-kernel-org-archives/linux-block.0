Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FDEB64D9
	for <linux-block@archiver.kernel.org>; Sat,  8 Jul 2023 02:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGHCDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGHCDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 22:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED27119AE
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688781789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=24UfmB016A/GqBFfCA1JIRwCB2hlMi90kSaOAET9UMM=;
        b=MZp1Pz16ZI9+hs32mPv66CZSPYNCr+sXZ99M+/InVCSghR4JCduHFHVQcavn2emA6Uaah9
        1D0j7Pl71kwK9yoJpLg5qijAUJnn1Wbbx/7BI/MuTwj6j13+IlwNuQglQdvlWXlxLXGb4p
        pjmj5OT7BnSf2hlG3LUAp8fKNXBRkqQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-VlUcIER5N_Czf5bf9cpYiw-1; Fri, 07 Jul 2023 22:03:05 -0400
X-MC-Unique: VlUcIER5N_Czf5bf9cpYiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91C453806704;
        Sat,  8 Jul 2023 02:03:04 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C27D8492C13;
        Sat,  8 Jul 2023 02:03:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq & nvme-pci: fix io failure in kdump kernel
Date:   Sat,  8 Jul 2023 10:02:57 +0800
Message-Id: <20230708020259.1343736-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This two patches fixes nvme-pci io failure on kdump kernel.

Thanks,
Ming

Ming Lei (2):
  blk-mq: add blk_mq_max_nr_hw_queues()
  nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues

 block/blk-mq.c          | 9 +++++++++
 drivers/nvme/host/pci.c | 2 +-
 include/linux/blk-mq.h  | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.40.1

