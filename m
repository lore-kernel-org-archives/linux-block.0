Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5553CD4843
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 16:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjIVQLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjIVQLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 12:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9F31A1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695399054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mvOh6EIsqWi4szyKwu3X7nDFJW+6eI1IGRZ4BninK+g=;
        b=ftIJwXLp3WlIarMS5CzlwD/gJ+I/qnYTk7beFZkPsq8bydl5S3u28M6fD1WGmELkhgEPjS
        GO2XIDXgre5/ulTrz+atbDynVhDI5V8c2iGPIUlvl7GMrn7YsAxKyKEfaWW4DXleyuZkCa
        4LcMKzZ9HwfH7G4LKueB2I4EKEGSvw8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-AyHOI6xHPj-f37_a65UsbQ-1; Fri, 22 Sep 2023 12:10:51 -0400
X-MC-Unique: AyHOI6xHPj-f37_a65UsbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6D553C147EB;
        Fri, 22 Sep 2023 16:10:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E874420268D4;
        Fri, 22 Sep 2023 16:10:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/2] io_uring: cancelable uring_cmd
Date:   Sat, 23 Sep 2023 00:09:39 +0800
Message-ID: <20230922160943.2793779-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Patch 1 retains top 8bits of  uring_cmd flags for kernel internal use.

Patch 2 implements cancelable uring_cmd.

git tree(with ublk change)

	https://github.com/ming1/linux/commits/uring_exit_and_ublk

V3:
	- code style change as suggested by Jens
	- add patch 1

V2:
	- use ->uring_cmd() with IO_URING_F_CANCEL for canceling command

Ming Lei (2):
  io_uring: retain top 8bits of uring_cmd flags for kernel internal use
  io_uring: cancelable uring_cmd

 include/linux/io_uring.h       | 19 +++++++++++++
 include/linux/io_uring_types.h |  6 ++++
 include/uapi/linux/io_uring.h  |  5 ++--
 io_uring/io_uring.c            | 34 +++++++++++++++++++++++
 io_uring/uring_cmd.c           | 51 +++++++++++++++++++++++++++++++++-
 5 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.41.0

