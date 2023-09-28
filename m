Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3574E732C7
	for <linux-block@archiver.kernel.org>; Thu, 28 Sep 2023 12:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjI1Mo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjI1Mo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 08:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE18198
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695905020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGQv8WHWzBOGeXP20BWUU0/SoENJTiP/zRSu2EFqd3E=;
        b=OD1zZajj/Q+jpjr/1eY9a3Fyhsn1fpwI7yOdLm5UbzN3evWo/DvYkaezYgbc5Z/vcrn3Hk
        jKwraBxzwKLaxhM9rRCuZFKfGXuT7/meY37F8r/a2m4VJ0d9mD2uKqHZwFEsurNMdnbUpG
        SZpHuvac2WH45rL/xMh0ov6cGRIyEkw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-drWz3kt8MbWFpHWGz0Ebrw-1; Thu, 28 Sep 2023 08:43:36 -0400
X-MC-Unique: drWz3kt8MbWFpHWGz0Ebrw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45DE83C025B4;
        Thu, 28 Sep 2023 12:43:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49F3C492C37;
        Thu, 28 Sep 2023 12:43:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 0/2] io_uring: cancelable uring_cmd
Date:   Thu, 28 Sep 2023 20:43:23 +0800
Message-ID: <20230928124327.135679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Patch 1 retains top 8bits of  uring_cmd flags for kernel internal use.

Patch 2 implements cancelable uring_cmd.

git tree(with ublk change)

	https://github.com/ming1/linux/commits/uring_exit_and_ublk

V5:
	- return void from io_uring_cmd_mark_cancelable()
	- fix one line comment on IO_URING_F_CANCEL
	- remove one unnecessary warn from io_uring_try_cancel_uring_cmd()
	- all are suggested from Jens

V4:
	- return -EINVAL in case that internal bits are set
	- replace static lock checker with lockdep_assert_held(&ctx->uring_lock);

V3:
	- code style change as suggested by Jens
	- add patch 1

V2:
	- use ->uring_cmd() with IO_URING_F_CANCEL for canceling command


Ming Lei (2):
  io_uring: retain top 8bits of uring_cmd flags for kernel internal use
  io_uring: cancelable uring_cmd

 include/linux/io_uring.h       | 18 +++++++++++++
 include/linux/io_uring_types.h |  6 +++++
 include/uapi/linux/io_uring.h  |  5 ++--
 io_uring/io_uring.c            | 36 +++++++++++++++++++++++++
 io_uring/uring_cmd.c           | 49 +++++++++++++++++++++++++++++++++-
 5 files changed, 110 insertions(+), 4 deletions(-)

-- 
2.41.0

