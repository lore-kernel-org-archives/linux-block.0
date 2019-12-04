Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2848FC2BD09
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00162077B
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVU9JLog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLDLbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:31:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575459101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKs0pmWjgzwOTI2mhLlyuFtK7c71lprgusa2QYdDAHY=;
        b=LVU9JLogLzuP7A4BXMvnBvBiONFDgJglBlUxgwRuKsfJVi8l8p6bYKING04xeG6bx+zbRe
        hyTyJqDO80FKDF7nvHgugFXod0DrADVMoT4NhnQZ6NpNFaewD0f9lsU0bcL6X6mJjH1GO9
        TAB+inJxLiZvCWQh6IrlvwxmzxkC55Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ViB04F3uPuaTtEAq0ah2cw-1; Wed, 04 Dec 2019 06:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4549E800D54;
        Wed,  4 Dec 2019 11:31:36 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0DC5C1B0;
        Wed,  4 Dec 2019 11:31:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Stephen Rust <srust@blockbridge.com>
Subject: [PATCH 2/2] brd: warn on un-aligned buffer
Date:   Wed,  4 Dec 2019 19:31:15 +0800
Message-Id: <20191204113115.17818-3-ming.lei@redhat.com>
In-Reply-To: <20191204113115.17818-1-ming.lei@redhat.com>
References: <20191204113115.17818-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ViB04F3uPuaTtEAq0ah2cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Queue dma alignment limit requires users(fs, target, ...) of block layer
to pass aligned buffer.

So far brd doesn't support un-aligned buffer, even though it is easy
to support it.

However, given brd is often used for debug purpose, and there are other
drivers which can't support un-aligned buffer too.

So add warning so that brd users know what to fix.

Reported-by: Stephen Rust <srust@blockbridge.com>
Cc: Stephen Rust <srust@blockbridge.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/brd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c2e5b2ad88bc..a8730cc4db10 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -297,6 +297,10 @@ static blk_qc_t brd_make_request(struct request_queue =
*q, struct bio *bio)
 =09=09unsigned int len =3D bvec.bv_len;
 =09=09int err;
=20
+=09=09/* Don't support un-aligned buffer */
+=09=09WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
+=09=09=09=09(len & (SECTOR_SIZE - 1)));
+
 =09=09err =3D brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
 =09=09=09=09  bio_op(bio), sector);
 =09=09if (err)
--=20
2.20.1

