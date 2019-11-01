Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090BECA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D201621855
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deAWFZ+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfKARfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:35:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbfKARfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 13:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qoe4+68SxhMAUVnSP6Av5bTGeZl7pUYmSw55Mh+o64M=;
        b=deAWFZ+gz8ZZVZIh/v1UUpx9/bwr59RwEfTamIMqw2incw0BsUPBUCpQ3NBodjN8FhXeFD
        AGnsCLnL45WYieeWgnC1AAPLFP3Zbd3ZzRsc1THyl83jdGFsgKUBBNkRpNKBcyK03IFFgF
        nRPMyUPk0DMiVPrq1Lx0X0JnHkYyce4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-L0312JSnMXO9VBv0kwfEmw-1; Fri, 01 Nov 2019 13:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D81800A1A;
        Fri,  1 Nov 2019 17:35:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFDA860876;
        Fri,  1 Nov 2019 17:34:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/11] pipe: Advance tail pointer inside of wait
 spinlock in pipe_read() [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Nov 2019 17:34:57 +0000
Message-ID: <157262969721.13142.294641621235161592.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: L0312JSnMXO9VBv0kwfEmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Advance the pipe ring tail pointer inside of wait spinlock in pipe_read()
so that the pipe can be written into with kernel notifications from
contexts where pipe->mutex cannot be taken.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 69afeab8a73a..ea134f69a292 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -325,9 +325,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
=20
 =09=09=09if (!buf->len) {
 =09=09=09=09pipe_buf_release(pipe, buf);
+=09=09=09=09spin_lock_irq(&pipe->wait.lock);
 =09=09=09=09tail++;
 =09=09=09=09pipe->tail =3D tail;
-=09=09=09=09do_wakeup =3D 1;
+=09=09=09=09do_wakeup =3D 0;
+=09=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+=09=09=09=09spin_unlock_irq(&pipe->wait.lock);
+=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09=09=09}
 =09=09=09total_len -=3D chars;
 =09=09=09if (!total_len)
@@ -359,6 +364,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09if (do_wakeup) {
 =09=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNO=
RM);
  =09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+=09=09=09do_wakeup =3D 0;
 =09=09}
 =09=09pipe_wait(pipe);
 =09}

