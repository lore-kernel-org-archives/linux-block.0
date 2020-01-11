Return-Path: <SRS0=o2oO=3A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461DAC33C9E
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 12:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C722072E
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gvb+OYHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgAKM55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Jan 2020 07:57:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729376AbgAKM55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Jan 2020 07:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578747474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ga9Io2xZqq3PGDvsxpXsFS1Z4TDUu2UXqEBliWnFKoQ=;
        b=Gvb+OYHW/qxTbp5Ub467svOIBs12c6eoVWdQhjOhGXUdVHZkPvaFABX7zeuAlvAVCmOcCS
        SwZ5PkGhIjvliDzA0UBbMwVdbXNvCD9eyir2QQJPxqnhIQm1EyATB2m8VR5iWotVAh1tY7
        8cOtDkPflN9/2PWEM3+HfItQATcSMPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-NRQLcHMcO-ORcRtqMogEOw-1; Sat, 11 Jan 2020 07:57:51 -0500
X-MC-Unique: NRQLcHMcO-ORcRtqMogEOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD03801E78;
        Sat, 11 Jan 2020 12:57:50 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E00E5C1D4;
        Sat, 11 Jan 2020 12:57:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] block: fix get_max_segment_size() overflow on 32bit arch
Date:   Sat, 11 Jan 2020 20:57:43 +0800
Message-Id: <20200111125743.4222-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 429120f3df2d starts to take account of segment's start dma address
when computing max segment size, and data type of 'unsigned long'
is used to do that. However, the segment mask may be 0xffffffff, so
the figured out segment size may be overflowed in case of zero physical
address on 32bit arch.

Fix the issue by returning queue_max_segment_size() directly when that
happens.

Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- don't use 64bit offset, so that not adding overhead on 32bit
	physical address space

 block/blk-merge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..1534ed736363 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -164,8 +164,13 @@ static inline unsigned get_max_segment_size(const st=
ruct request_queue *q,
 	unsigned long mask =3D queue_segment_boundary(q);
=20
 	offset =3D mask & (page_to_phys(start_page) + offset);
-	return min_t(unsigned long, mask - offset + 1,
-		     queue_max_segment_size(q));
+
+	/*
+	 * overflow may be triggered in case of zero page physical address
+	 * on 32bit arch, use queue's max segment size when that happens.
+	 */
+	return min_not_zero(mask - offset + 1,
+			(unsigned long)queue_max_segment_size(q));
 }
=20
 /**
--=20
2.20.1

