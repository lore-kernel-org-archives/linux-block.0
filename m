Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D804C7EE2E
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 00:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjFMA76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMA75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 20:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4890E10DF
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686617948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vFUoY1XuyodHeGwk9ADN+LxzuiHOfmLb8weJEijWvGw=;
        b=drGQsPKNAN2nVXAJVNo8+Lu6CDSPXEVB9xc8p2qKDbvTTsL4dJV90qqbt0xokqYH2C0icb
        p809JouVP0Q1FNKO+h8w2EXyz7RlUfYo9r/RiPEwwhoiEGZnHwkPdgJFZxluTBQ5hvUBRg
        bDXdJ3Pj7bk0kGCP1+qLGNNUls+n4t4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-OvieugCRP2ihrcCTrgcgKg-1; Mon, 12 Jun 2023 20:59:05 -0400
X-MC-Unique: OvieugCRP2ihrcCTrgcgKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840C71C03389;
        Tue, 13 Jun 2023 00:59:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4FBB40D1B61;
        Tue, 13 Jun 2023 00:59:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: fix two kinds of IO hang from removing NSs
Date:   Tue, 13 Jun 2023 08:58:45 +0800
Message-Id: <20230613005847.1762378-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch fixes io hang when controller removal interrupts error
recovery, then queue is left as quiesced.

The 2nd patch fixes io hang when controller is left as frozen.


Ming Lei (2):
  nvme: core: unquiesce io queues when removing namespaces
  nvme: don't freeze/unfreeze queues from different contexts

 drivers/nvme/host/core.c | 10 +++++++---
 drivers/nvme/host/pci.c  |  8 +++++---
 drivers/nvme/host/rdma.c |  3 ++-
 drivers/nvme/host/tcp.c  |  3 ++-
 4 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.40.1

