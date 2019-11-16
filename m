Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4182BC432C3
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671920729
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhHw4qXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfKPFuY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:50:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbfKPFuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573883422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5ppeAinJuC8+Miw24tWwYglqjydVjn6Me9me1BWEf4=;
        b=LhHw4qXnUv8iQTFeurtzg26WaTKDVTOxQxHbe1I7jB1sXb/angV5WgcFBbfL0EXiO0tWVl
        IF1vt+E6SmB+lKUojwc42FttEWttdRE8WDFRBAA05VDQnOILTCgn9csMWqRnhIZJQ56cR0
        4r06Q3Ov/aS+aHOTb+S5CPexSGl4UZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-7CMd4AMBPf6GNC2ytdZWxQ-1; Sat, 16 Nov 2019 00:50:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 084B1802466;
        Sat, 16 Nov 2019 05:50:20 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-253.rdu2.redhat.com [10.10.125.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5468169183;
        Sat, 16 Nov 2019 05:50:19 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     nbd@other.debian.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/2] nbd: move send_disconnects
Date:   Fri, 15 Nov 2019 23:50:16 -0600
Message-Id: <20191116055017.6253-2-mchristi@redhat.com>
In-Reply-To: <20191116055017.6253-1-mchristi@redhat.com>
References: <20191116055017.6253-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7CMd4AMBPf6GNC2ytdZWxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just move send_disconnects so we can call it earlier in the file in the
next patch.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a94ee45440b3..06b63c11ae50 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -980,6 +980,30 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx =
*hctx,
 =09return ret;
 }
=20
+static void send_disconnects(struct nbd_device *nbd)
+{
+=09struct nbd_config *config =3D nbd->config;
+=09struct nbd_request request =3D {
+=09=09.magic =3D htonl(NBD_REQUEST_MAGIC),
+=09=09.type =3D htonl(NBD_CMD_DISC),
+=09};
+=09struct kvec iov =3D {.iov_base =3D &request, .iov_len =3D sizeof(reques=
t)};
+=09struct iov_iter from;
+=09int i, ret;
+
+=09for (i =3D 0; i < config->num_connections; i++) {
+=09=09struct nbd_sock *nsock =3D config->socks[i];
+
+=09=09iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+=09=09mutex_lock(&nsock->tx_lock);
+=09=09ret =3D sock_xmit(nbd, i, 1, &from, 0, NULL);
+=09=09if (ret <=3D 0)
+=09=09=09dev_err(disk_to_dev(nbd->disk),
+=09=09=09=09"Send disconnect failed %d\n", ret);
+=09=09mutex_unlock(&nsock->tx_lock);
+=09}
+}
+
 static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long=
 fd,
 =09=09=09=09     int *err)
 {
@@ -1139,30 +1163,6 @@ static void nbd_parse_flags(struct nbd_device *nbd)
 =09=09blk_queue_write_cache(nbd->disk->queue, false, false);
 }
=20
-static void send_disconnects(struct nbd_device *nbd)
-{
-=09struct nbd_config *config =3D nbd->config;
-=09struct nbd_request request =3D {
-=09=09.magic =3D htonl(NBD_REQUEST_MAGIC),
-=09=09.type =3D htonl(NBD_CMD_DISC),
-=09};
-=09struct kvec iov =3D {.iov_base =3D &request, .iov_len =3D sizeof(reques=
t)};
-=09struct iov_iter from;
-=09int i, ret;
-
-=09for (i =3D 0; i < config->num_connections; i++) {
-=09=09struct nbd_sock *nsock =3D config->socks[i];
-
-=09=09iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
-=09=09mutex_lock(&nsock->tx_lock);
-=09=09ret =3D sock_xmit(nbd, i, 1, &from, 0, NULL);
-=09=09if (ret <=3D 0)
-=09=09=09dev_err(disk_to_dev(nbd->disk),
-=09=09=09=09"Send disconnect failed %d\n", ret);
-=09=09mutex_unlock(&nsock->tx_lock);
-=09}
-}
-
 static int nbd_disconnect(struct nbd_device *nbd)
 {
 =09struct nbd_config *config =3D nbd->config;
--=20
2.21.0

