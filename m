Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C950CA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63932217F9
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjspXGU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfKARfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:35:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbfKARfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Nov 2019 13:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f31ZclG/RJxENvGCAs10O3ojjOrA9kpGCTfILvXe/Gk=;
        b=FjspXGU2PeyaFJLGdB1SmRC3gIlTz/m5daYv6ZZLcIfCGGKqlIxVfnhh4SChMMRgA3iGUr
        abrT8jtk6dDOb0WDqc0KEG8mtQ42U6JpT97KjeWOROK2MDcvE0dmgucZ+uvzzqoYe/ldfm
        0poOjs1JtvhnADsZVIuK8SKGxSczF44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-596x9dcRPvmD5UotO2FJKA-1; Fri, 01 Nov 2019 13:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCBD800686;
        Fri,  1 Nov 2019 17:35:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78ED60BEC;
        Fri,  1 Nov 2019 17:35:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 07/11] pipe: Conditionalise wakeup in pipe_read() [ver
 #3]
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
Date:   Fri, 01 Nov 2019 17:35:05 +0000
Message-ID: <157262970587.13142.9476858866693533437.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 596x9dcRPvmD5UotO2FJKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only do a wakeup in pipe_read() if we made space in a completely full
buffer.  The producer shouldn't be waiting on pipe->wait otherwise.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index ea134f69a292..c16950e36ded 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -328,11 +328,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09spin_lock_irq(&pipe->wait.lock);
 =09=09=09=09tail++;
 =09=09=09=09pipe->tail =3D tail;
-=09=09=09=09do_wakeup =3D 0;
-=09=09=09=09wake_up_interruptible_sync_poll_locked(
-=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+=09=09=09=09do_wakeup =3D 1;
+=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09=09=09spin_unlock_irq(&pipe->wait.lock);
-=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09=09=09}
 =09=09=09total_len -=3D chars;
 =09=09=09if (!total_len)
@@ -361,11 +363,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09ret =3D -ERESTARTSYS;
 =09=09=09break;
 =09=09}
-=09=09if (do_wakeup) {
-=09=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNO=
RM);
- =09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-=09=09=09do_wakeup =3D 0;
-=09=09}
 =09=09pipe_wait(pipe);
 =09}
 =09__pipe_unlock(pipe);

