Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A47C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjESGvk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjESGvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806EE4D
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R+hUWwHZA+B+7sh3aURM1G+TvWvwRO5hd9z+Ojs1j7Q=;
        b=AbNQHwIkA0mbxHeVYppQyJNRdE0kdcgFUI3k57fvqkIbR8cDuS3flIjUc4YtV2O4rcRAAW
        8+2Zsp1B5g6UpxsvYaTmZv9WjJkwSvU4NycomXhOWc0ZDtqS0uDS6heQVE2nRnBNxBA/JO
        Qn+hRn+gK6PXjfXxg/dpEA9gcG5DIig=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-dNwRe3zIO1uIKeGtjYEfbg-1; Fri, 19 May 2023 02:50:45 -0400
X-MC-Unique: dNwRe3zIO1uIKeGtjYEfbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2295A1C08971;
        Fri, 19 May 2023 06:50:45 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 531A940CFD45;
        Fri, 19 May 2023 06:50:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/7] ublk: cleanup and support user copy
Date:   Fri, 19 May 2023 14:50:23 +0800
Message-Id: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st 3 patch are cleanup.

The other patches support to move data copy between io request pages and
userspace buffer into ublk server(userspace). This way avoids one round trip
of uring command(UBLK_F_NEED_GET_DATA), and solve buffer release issue for
READ[1]. Meantime both sides becomes cleaner. Also it can be thought as
prep patch for supporting zero copy.

ublksrv loop usercopy code:

	https://github.com/ming1/ubdsrv/commits/usercopy

[1] https://lore.kernel.org/linux-block/116d8a56-0881-56d3-9bcc-78ff3e1dc4e5@linux.alibaba.com/T/#m23bd4b8634c0a054e6797063167b469949a247bb


V3:
	- rebase on for-6.5/block
	- run xfstests and not see regression

V2:
	- rebase on latest linus tree


Ming Lei (7):
  ublk: kill queuing request by task_work_add
  ublk: cleanup io cmd code path by adding ublk_fill_io_cmd()
  ublk: cleanup ublk_copy_user_pages
  ublk: grab request reference when the request is handled by userspace
  ublk: support to copy any part of request pages
  ublk: add read()/write() support for ublk char device
  ublk: support user copy

 drivers/block/ublk_drv.c      | 457 +++++++++++++++++++++++++---------
 include/uapi/linux/ublk_cmd.h |  25 +-
 2 files changed, 361 insertions(+), 121 deletions(-)

-- 
2.40.1

