Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF3C636D7
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjBJPdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBJPda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 10:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0A28231
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676043161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BylpAHJhBQbW5HRA2ArLH6MZWqyqiWhscbiNJfHnoXw=;
        b=JvNsGlQvB9GxGfnSfiethkqLZVkZ/mx14+mO008FpDwN9CBoJklKVcVfRm+8Hyillt9jFn
        T+OX/CUS7rXmXXqYP77TmwgTSNumoola0hRvSI0xoyW6Yw9vEMgg6EAtMeCuP0Y1byO5e5
        hvciujgA9THnETJljeKQKwtlONSx3iA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-379S1MqcNjaH-3Al0vMLJA-1; Fri, 10 Feb 2023 10:32:38 -0500
X-MC-Unique: 379S1MqcNjaH-3Al0vMLJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 735FE857F45;
        Fri, 10 Feb 2023 15:32:36 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 007492166B29;
        Fri, 10 Feb 2023 15:32:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Date:   Fri, 10 Feb 2023 23:32:08 +0800
Message-Id: <20230210153212.733006-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Add two OPs which buffer is retrieved via kernel splice for supporting
fuse/ublk zero copy.

The 1st patch enhances direct pipe & splice for moving pages in kernel,
so that the two added OPs won't be misused, and avoid potential security
hole.

The 2nd patch allows splice_direct_to_actor() caller to ignore signal
if the actor won't block and can be done in bound time.

The 3rd patch add the two OPs.

The 4th patch implements ublk's ->splice_read() for supporting
zero copy.

ublksrv(userspace):

https://github.com/ming1/ubdsrv/commits/io_uring_splice_buf
    
So far, only loop/null target implements zero copy in above branch:
    
	ublk add -t loop -f $file -z
	ublk add -t none -z

Basic FS/IO function is verified, mount/kernel building & fio
works fine, and big chunk IO(BS: 64k/512k) performance gets improved
obviously.
 
Any comment is welcome!

Ming Lei (4):
  fs/splice: enhance direct pipe & splice for moving pages in kernel
  fs/splice: allow to ignore signal in __splice_from_pipe
  io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
  ublk_drv: support splice based read/write zero copy

 drivers/block/ublk_drv.c      | 169 +++++++++++++++++++++++++++++++--
 fs/splice.c                   |  19 +++-
 include/linux/pipe_fs_i.h     |  10 ++
 include/linux/splice.h        |  23 +++++
 include/uapi/linux/io_uring.h |   2 +
 include/uapi/linux/ublk_cmd.h |  31 +++++-
 io_uring/opdef.c              |  37 ++++++++
 io_uring/rw.c                 | 174 +++++++++++++++++++++++++++++++++-
 io_uring/rw.h                 |   1 +
 9 files changed, 456 insertions(+), 10 deletions(-)

-- 
2.31.1

