Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0810C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AD920748
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si1ux0D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKOKnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:43:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbfKOKnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573814586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyE0Mjzl0M4TOtYje9evGCsRdibvgbalgYO6kWcw1ng=;
        b=Si1ux0D/Z8jf6XEIOYECgr9FPryC70AsoAFW1ELm0aZ1e2dewTDkR1Feg/y+FAyn172rp4
        7Evbgjyma13HfDyoNCZyT59gg0vU2I/0SPATmuYKq5eVM0okF20Cl6CzbhpFH8cBjHD8Hu
        5CgzWFwrNJtQ+P4xGHid5+dJIVXSMek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-OYGCRsUtN82bLl9nwxGQIw-1; Fri, 15 Nov 2019 05:43:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4B88048ED;
        Fri, 15 Nov 2019 10:43:01 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD7495DC1B;
        Fri, 15 Nov 2019 10:42:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH RFC 1/3] block: reuse one scheduler/flush field for private request's data
Date:   Fri, 15 Nov 2019 18:42:36 +0800
Message-Id: <20191115104238.15107-2-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OYGCRsUtN82bLl9nwxGQIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reuse one union shared by elevator and flush request for data of
private request. Private request won't enter IO scheduler and never
be a flush request, so reuse the space for data of private request.

This field is added to pass driver private info for private request
only.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a4f7abbdcf7..ce708dc10bdc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -177,7 +177,8 @@ struct request {
 =09 * Three pointers are available for the IO schedulers, if they need
 =09 * more they have to dynamically allocate it.  Flush requests are
 =09 * never put on the IO scheduler. So let the flush fields share
-=09 * space with the elevator data.
+=09 * space with the elevator data. Private request are never put on
+=09 * IO scheduler, and not be a flush request.
 =09 */
 =09union {
 =09=09struct {
@@ -190,6 +191,9 @@ struct request {
 =09=09=09struct list_head=09list;
 =09=09=09rq_end_io_fn=09=09*saved_end_io;
 =09=09} flush;
+
+=09=09/* used for private request only */
+=09=09unsigned long private_rq_data;
 =09};
=20
 =09struct gendisk *rq_disk;
--=20
2.20.1

