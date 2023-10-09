Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCCE95A91
	for <linux-block@archiver.kernel.org>; Mon,  9 Oct 2023 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjJIJfV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjJIJfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2023 05:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD93EA2
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2023 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696844078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tq+Ci0wfhdVfXx27WuiNYwGov0M93T2ZRy4Z/qGJvWw=;
        b=T0MMGGIYW9Ma2JcqzaviYqfVZCE+f2uJP3JpmERvQvXy6D9LXSJvZirhW9HXfyQq4WxFej
        afG9EGBjbcGCA9vUtQlH5QIsHNWYs5iWTL4oy9FgKBP9+cHmayTKv+zefntdDddU0tzB7q
        QVDrM3389Q75J48XyZLj5FJuP9DtUjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-Ph7N5N8PN_arA3l8LJwbJw-1; Mon, 09 Oct 2023 05:34:26 -0400
X-MC-Unique: Ph7N5N8PN_arA3l8LJwbJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56ECA85A5BD;
        Mon,  9 Oct 2023 09:34:26 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82161140E962;
        Mon,  9 Oct 2023 09:34:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Subject: [PATCH for-6.7/io_uring 0/7] ublk: simplify abort with cancelable uring_cmd
Date:   Mon,  9 Oct 2023 17:33:15 +0800
Message-ID: <20231009093324.957829-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Simplify ublk request & io command aborting handling with the new added
cancelable uring_cmd. With this change, the aborting logic becomes
simpler and more reliable, and it becomes easy to add new feature, such
as relaxing queue/ublk daemon association.

Pass `blktests ublk` test, and pass lockdep when running `./check ublk`
of blktests.


Ming Lei (7):
  ublk: don't get ublk device reference in ublk_abort_queue()
  ublk: make sure io cmd handled in submitter task context
  ublk: move ublk_cancel_dev() out of ub->mutex
  ublk: rename mm_lock as lock
  ublk: quiesce request queue when aborting queue
  ublk: replace monitor with cancelable uring_cmd
  ublk: simplify aborting request

 drivers/block/ublk_drv.c | 306 ++++++++++++++++++++++++---------------
 1 file changed, 190 insertions(+), 116 deletions(-)

-- 
2.41.0

