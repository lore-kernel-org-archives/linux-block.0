Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5BCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54B220869
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3UowjlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDPzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:55:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbfKDPzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 10:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572882945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDcQMMMn2Ou9SSLJFTCCAcAa+uzHLXJu4Rft8/2r9bQ=;
        b=E3UowjlHHmdOePCJ2S6P90NxIrhAxyHTIDybt3IWYvZe8LtobqGPbU6KoCmMNu9vqkWS3e
        so28A8Edn71Q+Td+m7xDG+bMCQ4tjweVWALglvpfytMfgMvGyQyQNqd/yQUMpOBF/DhTi7
        KaL98uhk/npXlgVHUUqhCOznDRIPlRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-aSMgDo0_PzS2zz_3yBjnEQ-1; Mon, 04 Nov 2019 10:55:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA551005500;
        Mon,  4 Nov 2019 15:55:40 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D61A5D6C8;
        Mon,  4 Nov 2019 15:55:33 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v2 1/3] spec: update RPM version number to 0.2
Date:   Mon,  4 Nov 2019 16:55:22 +0100
Message-Id: <20191104155524.58422-2-stefanha@redhat.com>
In-Reply-To: <20191104155524.58422-1-stefanha@redhat.com>
References: <20191104155524.58422-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: aSMgDo0_PzS2zz_3yBjnEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liburing.spec b/liburing.spec
index 1337034..f9e9262 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -1,5 +1,5 @@
 Name: liburing
-Version: 0.1
+Version: 0.2
 Release: 1
 Summary: Linux-native io_uring I/O access library
 License: LGPLv2+
--=20
2.23.0

