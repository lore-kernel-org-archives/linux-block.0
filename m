Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C0FA372C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6223E2178F
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0ppXYLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHKQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:16:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30091 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbfKHKQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Nov 2019 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573208178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2shrkcHKCrBVesmORB29OVfI//yC5Hun0LArn9Zkx8I=;
        b=V0ppXYLR6IdI0y7b3oxknhMUasZkV0c/0KGzqJF0+x0oHhv8T8M/oDcxhg0mi1qf4zuDQJ
        nQOKvu4kOK5tVpaL8Y7l3LxRYmVgxaNmPiTWnUdyt2VqthNDIkIuyQ/wMSqXSez4ic/qA3
        j8doPfgpi9KmgCX+iTON5jg04teMSzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-GJuR_s5DONSzOEIzgIVBNQ-1; Fri, 08 Nov 2019 05:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A9F107ACC3;
        Fri,  8 Nov 2019 10:16:16 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C67D35C651;
        Fri,  8 Nov 2019 10:16:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH 2/2] block: split bio if the only bvec's length is > SZ_4K
Date:   Fri,  8 Nov 2019 18:15:28 +0800
Message-Id: <20191108101528.31735-3-ming.lei@redhat.com>
In-Reply-To: <20191108101528.31735-1-ming.lei@redhat.com>
References: <20191108101528.31735-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GJuR_s5DONSzOEIzgIVBNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

64K PAGE_SIZE is popular on ARM64 or other ARCHs, and 64K has been big
enough to break some devices probably, so change the logic to split bio
if the only bvec's length is > SZ_4K instead of PAGE_SIZE.

Fixes: fa5322872187 (block: avoid blk_bio_segment_split for small I/O opera=
tions)
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d783bdc4559b..f35327f63ef4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -320,7 +320,7 @@ void __blk_queue_split(struct request_queue *q, struct =
bio **bio,
 =09=09if (!q->limits.chunk_sectors &&
 =09=09    (*bio)->bi_vcnt =3D=3D 1 &&
 =09=09    ((*bio)->bi_io_vec[0].bv_len +
-=09=09     (*bio)->bi_io_vec[0].bv_offset) <=3D PAGE_SIZE) {
+=09=09     (*bio)->bi_io_vec[0].bv_offset) <=3D SZ_4K) {
 =09=09=09*nr_segs =3D 1;
 =09=09=09break;
 =09=09}
--=20
2.20.1

