Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1607EC5DF60
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4F2187F
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOsFspd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfKGNgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:36:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730937AbfKGNgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 08:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573133803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nb0Y0v4Wx0arNtIyqYDVHhABDd0ChPNhAeRPBiCtjEA=;
        b=UOsFspd2nkEEPWLuqzHL+05+Ts8v07KbbECsMBdmO0mmF4EMhhKWQEKRO7cuYiTAU5wZyh
        f0L2HSbrB76w/TbQQBWO3oY/BdiFkkiI9bhwgvP1rrgmX9hKe1rmvxWWR0StF0dStMdkWj
        EaCK0v6cqewMBUC9f8Pc0F9Zfdj2UAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28--xtrLlxmOUGa4-p7Shz2dA-1; Thu, 07 Nov 2019 08:36:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA02C8017DD;
        Thu,  7 Nov 2019 13:36:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 104E15DA2C;
        Thu,  7 Nov 2019 13:36:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/14] pipe: Allow buffers to be marked
 read-whole-or-error for notifications [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:36:33 +0000
Message-ID: <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -xtrLlxmOUGa4-p7Shz2dA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow a buffer to be marked such that read() must return the entire buffer
in one go or return ENOBUFS.  Multiple buffers can be amalgamated into a
single read, but a short read will occur if the next "whole" buffer won't
fit.

This is useful for watch queue notifications to make sure we don't split a
notification across multiple reads, especially given that we need to
fabricate an overrun record under some circumstances - and that isn't in
the buffers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c                        |    8 +++++++-
 include/linux/pipe_fs_i.h        |    1 +
 kernel/watch_queue.c             |    2 +-
 samples/watch_queue/watch_test.c |    2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 099bf4b657dd..588355c24ee0 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -298,8 +298,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09size_t written;
 =09=09=09int error;
=20
-=09=09=09if (chars > total_len)
+=09=09=09if (chars > total_len) {
+=09=09=09=09if (buf->flags & PIPE_BUF_FLAG_WHOLE) {
+=09=09=09=09=09if (ret =3D=3D 0)
+=09=09=09=09=09=09ret =3D -ENOBUFS;
+=09=09=09=09=09break;
+=09=09=09=09}
 =09=09=09=09chars =3D total_len;
+=09=09=09}
=20
 =09=09=09error =3D pipe_buf_confirm(pipe, buf);
 =09=09=09if (error) {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 816bc0d3aecd..a19d60a06869 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -8,6 +8,7 @@
 #define PIPE_BUF_FLAG_ATOMIC=090x02=09/* was atomically mapped */
 #define PIPE_BUF_FLAG_GIFT=090x04=09/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET=090x08=09/* read() as a packet */
+#define PIPE_BUF_FLAG_WHOLE=090x10=09/* read() must return entire buffer o=
r error */
=20
 /**
  *=09struct pipe_buffer - a linux kernel pipe buffer
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index b73fbfe0d467..b1d30296e29b 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -115,7 +115,7 @@ static bool post_one_notification(struct watch_queue *w=
queue,
 =09buf->ops =3D &watch_queue_pipe_buf_ops;
 =09buf->offset =3D offset;
 =09buf->len =3D len;
-=09buf->flags =3D 0;
+=09buf->flags =3D PIPE_BUF_FLAG_WHOLE;
 =09pipe->head =3D head + 1;
=20
 =09if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_t=
est.c
index 8925593bdb9b..f6fb6e813551 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -63,7 +63,7 @@ static void saw_key_change(struct watch_notification *n, =
size_t len)
  */
 static void consumer(int fd)
 {
-=09unsigned char buffer[4096], *p, *end;
+=09unsigned char buffer[433], *p, *end;
 =09union {
 =09=09struct watch_notification n;
 =09=09unsigned char buf1[128];

