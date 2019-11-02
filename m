Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4DCA9ED0
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF420862
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJKpeI1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKBIC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 04:02:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbfKBIC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Nov 2019 04:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572681747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMCEdevrU7bRW4SpQI8SBdcaxtFmL8hYAWppn4dTBQk=;
        b=IJKpeI1esUkNb9CKEBjUIGSWKeqmA8Z4DAIz5HNpBcu9mfcAmdeytQe5mVbvHrOuR+CECf
        QWt2ad268lwOFYCe/dUK8CafKwFkw8FiuWNMsMELgEhsAlEIGz6nlXnJDBj+CgiYWmSVz+
        /II5F07L/USyaXLLPjI99iytwC9KWUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-59gF5HU6MkCHvpqSePO3zQ-1; Sat, 02 Nov 2019 04:02:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AFD107ACC0;
        Sat,  2 Nov 2019 08:02:23 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09B0B5D6D8;
        Sat,  2 Nov 2019 08:02:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Date:   Sat,  2 Nov 2019 16:02:15 +0800
Message-Id: <20191102080215.20223-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 59gF5HU6MkCHvpqSePO3zQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is reported that sysfs buffer overflow can be triggered in case
of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
hctx via /sys/block/$DEV/mq/$N/cpu_list.

So use snprintf for avoiding the potential buffer overflow.

This version doesn't change the attribute format, and simply stop
to show CPU number if the buffer is to be overflow.

Cc: stable@vger.kernel.org
Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load"=
)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index a0d3ce30fa08..68996ef1d339 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -166,20 +166,25 @@ static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(=
struct blk_mq_hw_ctx *hctx,
=20
 static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char =
*page)
 {
+=09const size_t size =3D PAGE_SIZE - 1;
 =09unsigned int i, first =3D 1;
-=09ssize_t ret =3D 0;
+=09int ret =3D 0, pos =3D 0;
=20
 =09for_each_cpu(i, hctx->cpumask) {
 =09=09if (first)
-=09=09=09ret +=3D sprintf(ret + page, "%u", i);
+=09=09=09ret =3D snprintf(pos + page, size - pos, "%u", i);
 =09=09else
-=09=09=09ret +=3D sprintf(ret + page, ", %u", i);
+=09=09=09ret =3D snprintf(pos + page, size - pos, ", %u", i);
+
+=09=09if (ret >=3D size - pos)
+=09=09=09break;
=20
 =09=09first =3D 0;
+=09=09pos +=3D ret;
 =09}
=20
-=09ret +=3D sprintf(ret + page, "\n");
-=09return ret;
+=09ret =3D snprintf(pos + page, size - pos, "\n");
+=09return pos + ret;
 }
=20
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags =3D {
--=20
2.20.1

