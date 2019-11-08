Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CEC5DF60
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE94D2178F
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 10:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euLWaQDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKHKQN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:16:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbfKHKQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 05:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573208172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QWDWTIZzIXHoFcFstIZ3PcLcGtIz8gXy1HRSGyYauw=;
        b=euLWaQDVDzw/x9K6ucKAo5EC58zLucraypl5YAJpICugO6T112D7ENxdD3SCsFt3a2xrLv
        7l3bdNi/NCBFLvLVe0vFC/VbymNC2uznMQoQSwrGiwmI0Mf/BMeCz5THDGbxHHUkkp2XVR
        Z2pt5namCgGGj04xX+m1KQb2eXTdp7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-FmUQ-ywRMqKtK15rUvbwAA-1; Fri, 08 Nov 2019 05:16:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 455998017DD;
        Fri,  8 Nov 2019 10:16:09 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13B8C6715D;
        Fri,  8 Nov 2019 10:16:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: still try to split bio if the bvec crosses pages
Date:   Fri,  8 Nov 2019 18:15:27 +0800
Message-Id: <20191108101528.31735-2-ming.lei@redhat.com>
In-Reply-To: <20191108101528.31735-1-ming.lei@redhat.com>
References: <20191108101528.31735-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FmUQ-ywRMqKtK15rUvbwAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some device may set segment boundary as PAGE_SIZE - 1. If the bvec
crosses pages, and meantime its length is <=3D PAGE_SIZE, we still need
to split the bvec into 2 segments.

Fixes this issue by still splitting bio if the single bvec crosses
pages.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: fa5322872187 (block: avoid blk_bio_segment_split for small I/O opera=
tions)
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f22cb6251d06..d783bdc4559b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -319,7 +319,8 @@ void __blk_queue_split(struct request_queue *q, struct =
bio **bio,
 =09=09 */
 =09=09if (!q->limits.chunk_sectors &&
 =09=09    (*bio)->bi_vcnt =3D=3D 1 &&
-=09=09    (*bio)->bi_io_vec[0].bv_len <=3D PAGE_SIZE) {
+=09=09    ((*bio)->bi_io_vec[0].bv_len +
+=09=09     (*bio)->bi_io_vec[0].bv_offset) <=3D PAGE_SIZE) {
 =09=09=09*nr_segs =3D 1;
 =09=09=09break;
 =09=09}
--=20
2.20.1

