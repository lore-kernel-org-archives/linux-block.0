Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE632C6FD19
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCJUQc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 15:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCJUQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 15:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585312DDD6
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678479332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppIa7KL6T1jyviPGvoaICUIPVqm/wSOFkhdUqjpubIE=;
        b=gfRFmn7rLHFjWQavjFdqXVBm5df/YYTdIOuGeFa187GI6Nm8vAjE2UzNoNvv79GNVyFEER
        BkszyQDic+xHIv2Qrj9PZqC6WLX0zDCzcWgj6Trz2KEqN5ZygUZuSwWVL/qWRv2poCzz0+
        6Ya/yvH0RgkJGMd0rLcPqi3ZhR7qeMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-lbKHM_LDMR6GQI_jhdVRew-1; Fri, 10 Mar 2023 15:15:29 -0500
X-MC-Unique: lbKHM_LDMR6GQI_jhdVRew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1B9285CBE0;
        Fri, 10 Mar 2023 20:15:28 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A004014CF3;
        Fri, 10 Mar 2023 20:15:27 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] uapi nbd: add cookie alias to handle
Date:   Fri, 10 Mar 2023 14:15:24 -0600
Message-Id: <20230310201525.2615385-3-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-1-eblake@redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The uapi <linux/nbd.h> header declares a 'char handle[8]' per request;
which is overloaded in English (are you referring to "handle" the
verb, such as handling a signal or writing a callback handler, or
"handle" the noun, the value used in a lookup table to correlate a
response back to the request).  Many client-side NBD implementations
(both servers and clients) have instead used 'u64 cookie' or similar,
as it is easier to directly assign an integer than to futz around with
memcpy.  In fact, upstream documentation is now encouraging this shift
in terminology: https://lists.debian.org/nbd/2023/03/msg00031.html

Accomplish this by use of an anonymous union to provide the alias for
anyone getting the definition from the uapi; this does not break
existing clients, while exposing the nicer name for those who prefer
it.  Note that block/nbd.c still uses the term handle (in fact, it
actually combines a 32-bit cookie and a 32-bit tag into the 64-bit
handle), but that internal usage is not changed the public uapi, since
no compliant NBD server has any reason to inspect or alter the 64
bits sent over the socket.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/uapi/linux/nbd.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 8797387caaf7..f58f2043f62e 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -81,7 +81,10 @@ enum {
 struct nbd_request {
 	__be32 magic;	/* NBD_REQUEST_MAGIC	*/
 	__be32 type;	/* See NBD_CMD_*	*/
-	char handle[8];
+	union {
+		char handle[8];
+		__be64 cookie;
+	};
 	__be64 from;
 	__be32 len;
 } __attribute__((packed));
@@ -93,6 +96,9 @@ struct nbd_request {
 struct nbd_reply {
 	__be32 magic;		/* NBD_REPLY_MAGIC	*/
 	__be32 error;		/* 0 = ok, else error	*/
-	char handle[8];		/* handle you got from request	*/
+	union {
+		char handle[8];	/* handle you got from request	*/
+		__be64 cookie;
+	};
 };
 #endif /* _UAPILINUX_NBD_H */
-- 
2.39.2

