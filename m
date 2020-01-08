Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D511C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 01:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F202077B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 01:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqIIzdqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgAHBZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:25:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51972 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgAHBZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 20:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578446741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gDqADfz8Ee1HsbENC360QZpohrBWxpJ+eIsXlPuahmY=;
        b=BqIIzdqsUA3SVsZJ9AqT0KPwn8JzOxR4AziwiEM8yKFswtzw7T29T7yYYSoptPOFRMxNQp
        4PYYMz9lL/SklMLeDoLj9SMMaT3axfvamwMAUywbXC0RALomQFS544Oq7d/EC+mzytooT7
        bKYfXOi2yhDV7F/s2xiN7AIbnZvRFuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-eoWnjHTaMOqn-MElOoC1dg-1; Tue, 07 Jan 2020 20:25:40 -0500
X-MC-Unique: eoWnjHTaMOqn-MElOoC1dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32567107ACC7;
        Wed,  8 Jan 2020 01:25:39 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3039560BF4;
        Wed,  8 Jan 2020 01:25:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Date:   Wed,  8 Jan 2020 09:25:26 +0800
Message-Id: <20200108012526.26731-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 429120f3df2d starts to take account of segment's start dma address
when computing max segment size, and data type of 'unsigned long'
is used to do that. However, the segment mask may be 0xffffffff, so
the figured out segment size may be overflowed because DMA address can
be 64bit on 32bit arch.

Fixes the issue by using 'unsigned long long' to compute max segment
size.

Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..b0fcc72594cb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct reque=
st_queue *q,
=20
 static inline unsigned get_max_segment_size(const struct request_queue *=
q,
 					    struct page *start_page,
-					    unsigned long offset)
+					    unsigned long long offset)
 {
 	unsigned long mask =3D queue_segment_boundary(q);
=20
 	offset =3D mask & (page_to_phys(start_page) + offset);
-	return min_t(unsigned long, mask - offset + 1,
+	return min_t(unsigned long long, mask - offset + 1,
 		     queue_max_segment_size(q));
 }
=20
--=20
2.20.1

