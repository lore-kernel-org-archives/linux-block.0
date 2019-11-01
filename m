Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0CCA9ED1
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78478217D9
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 17:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8kS7un1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfKARfe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:35:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729837AbfKARfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Nov 2019 13:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/3IjFBlrcu9yWMCYn5372hkbcEcVSpB5vL0sJqAX3o=;
        b=e8kS7un1jUu9yv5WMzhOdDPLizxERroGi1aiDCbdM5A5s4PDZpvYv+1sMwjFAw1JDB25HR
        GRLlS5rN4nVJ2rys5uxtSd/Jp8o4lHFnh+rpDIsOEcYfe0O/zPRQUyBb3roUqEuBGuy7OP
        oFMdksJhdA0d5ngnRP5qd8n+SXFMMc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-vc67HLdpPwahTj8KtFndSw-1; Fri, 01 Nov 2019 13:35:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C0271800D6B;
        Fri,  1 Nov 2019 17:35:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F0F860BEC;
        Fri,  1 Nov 2019 17:35:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 09/11] pipe: Remove redundant wakeup from pipe_write()
 [ver #3]
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
Date:   Fri, 01 Nov 2019 17:35:24 +0000
Message-ID: <157262972442.13142.11480420475866936493.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vc67HLdpPwahTj8KtFndSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove a redundant wakeup from pipe_write().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index ce77ac0d8901..d7b8d3f22987 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -517,11 +517,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09=09ret =3D -ERESTARTSYS;
 =09=09=09break;
 =09=09}
-=09=09if (do_wakeup) {
-=09=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNOR=
M);
-=09=09=09kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-=09=09=09do_wakeup =3D 0;
-=09=09}
 =09=09pipe->waiting_writers++;
 =09=09pipe_wait(pipe);
 =09=09pipe->waiting_writers--;

