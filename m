Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A598EB64DB
	for <linux-block@archiver.kernel.org>; Sat, 17 Jun 2023 12:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjFQMN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jun 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjFQMN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2023 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356B26B3
        for <linux-block@vger.kernel.org>; Sat, 17 Jun 2023 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687003974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HlaXseyq5U5o1i8LIFlWuZ5rATyuHBFais1x2nt408=;
        b=NRU2NMM4IIAb7e40wuFtw7w2v/4OfytCJht/vwUcJSf1OP/qkAYgo/8HF31l8/9J0O6/bH
        2tuj6ltMncxDcgz8wFjV0gzNvcPVwgSf84q9xYEtNT9wofy67rpzypMlCtKg/fvUwuJT/x
        9IHYjxAyBstcVhHsUM6rUn9EFK+r3Zw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-NmwNDhxxO3e69TbO3-hfEA-1; Sat, 17 Jun 2023 08:12:49 -0400
X-MC-Unique: NmwNDhxxO3e69TbO3-hfEA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E311C08782;
        Sat, 17 Jun 2023 12:12:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30CB0492C1B;
        Sat, 17 Jun 2023 12:12:46 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH net-next v2 13/17] drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
Date:   Sat, 17 Jun 2023 13:11:42 +0100
Message-ID: <20230617121146.716077-14-dhowells@redhat.com>
In-Reply-To: <20230617121146.716077-1-dhowells@redhat.com>
References: <20230617121146.716077-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use sendmsg() conditionally with MSG_SPLICE_PAGES in _drbd_send_page()
rather than calling sendpage() or _drbd_no_send_page().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Philipp Reisner <philipp.reisner@linbit.com>
cc: Lars Ellenberg <lars.ellenberg@linbit.com>
cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: drbd-dev@lists.linbit.com
cc: linux-block@vger.kernel.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Wrap lines at 80.

 drivers/block/drbd/drbd_main.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83987e7a5ef2..8a01a18a2550 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1540,7 +1540,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 		    int offset, size_t size, unsigned msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	int len = size;
+	struct bio_vec bvec;
+	struct msghdr msg = { .msg_flags = msg_flags, };
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1549,33 +1550,35 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (drbd_disable_sendpage || !sendpage_ok(page))
-		return _drbd_no_send_page(peer_device, page, offset, size, msg_flags);
+	if (!drbd_disable_sendpage && sendpage_ok(page))
+		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
+
+	bvec_set_page(&bvec, page, offset, size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-	msg_flags |= MSG_NOSIGNAL;
 	drbd_update_congested(peer_device->connection);
 	do {
 		int sent;
 
-		sent = socket->ops->sendpage(socket, page, offset, len, msg_flags);
+		sent = sock_sendmsg(socket, &msg);
 		if (sent <= 0) {
 			if (sent == -EAGAIN) {
 				if (we_should_drop_the_connection(peer_device->connection, socket))
 					break;
 				continue;
 			}
-			drbd_warn(peer_device->device, "%s: size=%d len=%d sent=%d\n",
-			     __func__, (int)size, len, sent);
+			drbd_warn(peer_device->device, "%s: size=%d len=%zu sent=%d\n",
+				  __func__, (int)size, msg_data_left(&msg),
+				  sent);
 			if (sent < 0)
 				err = sent;
 			break;
 		}
-		len    -= sent;
-		offset += sent;
-	} while (len > 0 /* THINK && device->cstate >= C_CONNECTED*/);
+	} while (msg_data_left(&msg)
+		 /* THINK && device->cstate >= C_CONNECTED*/);
 	clear_bit(NET_CONGESTED, &peer_device->connection->flags);
 
-	if (len == 0) {
+	if (!msg_data_left(&msg)) {
 		err = 0;
 		peer_device->device->send_cnt += size >> 9;
 	}

