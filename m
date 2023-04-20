Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83806C77B76
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 15:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjDTPly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDTPlu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3661A1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682005251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WPqqrZTI9Ol2xMn+wJTehT7/2LpIfxpae3G1mEh0SJg=;
        b=T2Cl9FH6gvBrT9oeT0r2KX/bxZjDLqqiQ1CZqpwKuco1iS7Et3lA5SoyWiM6L7F8BwuDs9
        9LiyuM1xpsNUNnE/rwoMmo4zIzqKAE5mwNgxzARjlmVqAXKsJGVV3bBUPRxNH1mweTAzvZ
        lCdhl9RzJ88vpTRVPPQhGFDEVMrQ1pg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-Lx4Ww-pSMEqnvkCDpmMuGw-1; Thu, 20 Apr 2023 11:40:44 -0400
X-MC-Unique: Lx4Ww-pSMEqnvkCDpmMuGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C5C1858F09;
        Thu, 20 Apr 2023 15:40:44 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526C51410F1E;
        Thu, 20 Apr 2023 15:40:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/7] ublk: cleanup and support user copy
Date:   Thu, 20 Apr 2023 23:40:25 +0800
Message-Id: <20230420154032.1272836-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st 3 patch are cleanup.

The other patches supports to move data copy between io request pages and
userspace buffer into ublk server(userspace). This way avoids one round trip
of uring command(UBLK_F_NEED_GET_DATA), and solve buffer release issue for
READ. Meantime both sides becomes cleaner. Also it can be thought as
prep patch for supporting zero copy.


Ming Lei (7):
  ublk: kill queuing request by task_work_add
  ublk: cleanup io cmd code path by adding ublk_fill_io()
  ublk: cleanup ublk_copy_user_pages
  ublk: grab request reference when the request is handled by userspace
  ublk: support to copy any part of request pages
  ublk: add read()/write() support for ublk char device
  ublk: support user copy

 drivers/block/ublk_drv.c      | 457 +++++++++++++++++++++++++---------
 include/uapi/linux/ublk_cmd.h |  25 +-
 2 files changed, 361 insertions(+), 121 deletions(-)

-- 
2.39.2

