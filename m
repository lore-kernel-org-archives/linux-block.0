Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C77B73
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 09:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjE3Joz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 05:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjE3Joo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 05:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1DF3
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685439834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pe8varXcsYJct+7Kt2+peE/f+2D7cGSjb5CW31FfVK4=;
        b=NQ9IA+TTQzzvwMhwClcZI9xcUX/dCzkBYwhKj+b/XB7TU51DfOdHaQ7l6Z/a8hUFBIoBKK
        Vl4Mobf4jUHDAF68eRNm8lz95yZlBnfV75AWqa1qElY0XDlEsUIu3nmyuRdjRa4+sw0a4E
        FN8IT9eBxHp6xhypqp9QzpiQPAOClfA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-WnO3XKQtNHCTffxVNnokPw-1; Tue, 30 May 2023 05:43:50 -0400
X-MC-Unique: WnO3XKQtNHCTffxVNnokPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E96E2A59566;
        Tue, 30 May 2023 09:43:50 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBA740CFD08;
        Tue, 30 May 2023 09:43:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: add nvme_delete_dead_ctrl for avoiding io deadlock
Date:   Tue, 30 May 2023 17:43:20 +0800
Message-Id: <20230530094322.258090-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch adds nvme_delete_dead_ctrl().

The 2nd patch calls it after reconnection fails in tcp/rdma driver, and
fixes one io dead lock.

Ming Lei (2):
  nvme: add API of nvme_delete_dead_ctrl
  nvme: rdma/tcp: call nvme_delete_dead_ctrl for handling reconnect
    failure

 drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  2 +-
 4 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.40.1

