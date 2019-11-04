Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482ACA9ED3
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163542190F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXG/WNwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfKDI1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:27:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDI1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 03:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572856044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QdQl81n0UTgWStNxUsm/z1Hfm51ZVadasHNxoeSSYqM=;
        b=SXG/WNwTq3b7qROcfst324KI1ulXqVpHUYCbng9ilkWhGLT0QfRA5oiIHs04texmE4oL6/
        2mjo2ByCr0ErJ+Cd+8FYxRrFcl+zYDDzmeSNRePnfzmH5jkZ9rEQKHTvHli8lO+ryGHglQ
        TgN578CNdSn2cwK5AyLe9f/6e0E3GyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7qjl8rWvMKGKxqfofxscWQ-1; Mon, 04 Nov 2019 03:27:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFFBA2A3;
        Mon,  4 Nov 2019 08:27:16 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A18E26FAA;
        Mon,  4 Nov 2019 08:27:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: make sure that line break can be printed
Date:   Mon,  4 Nov 2019 16:26:53 +0800
Message-Id: <20191104082653.3279-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7qjl8rWvMKGKxqfofxscWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores"=
)
avoids sysfs buffer overflow, and reserves one charactor for line break.
However, the last snprintf() doesn't get correct 'size' parameter passed
in, so fixed it.

Fixes: 8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU=
 cores")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 4caa56d1bc85..062229395a50 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -175,7 +175,7 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_=
hw_ctx *hctx, char *page)
 =09=09pos +=3D ret;
 =09}
=20
-=09ret =3D snprintf(pos + page, size - pos, "\n");
+=09ret =3D snprintf(pos + page, size + 1 - pos, "\n");
 =09return pos + ret;
 }
=20
--=20
2.20.1

