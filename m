Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45323CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17448217F4
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 12:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC1axhRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfKDMF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:05:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbfKDMF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 07:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572869158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX3MENt9H948tvZRMkm6vUw7B2bDTuG4mimG9EWlwJE=;
        b=HC1axhRVCRfQjdzlifnrc0y1pLpIGK+KGbQliTfbjc+7LpNJ6633eBokjzFdopPfylHkwE
        V8Xky8T4RlYJDuosdFMRlGt4yiUVTX7EqQFEg39BnetgnASJWqiVBeKg0/Q7XjrUI3lZKn
        2hS7r1IzvO0oro7tte5CQvYnhOVhvSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-E_HpD_zePZ2GeI_pAOtNMw-1; Mon, 04 Nov 2019 07:05:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F302AD;
        Mon,  4 Nov 2019 12:05:54 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82FC160F8A;
        Mon,  4 Nov 2019 12:05:47 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 2/3] Makefile: add missing .pc dependency on .spec file
Date:   Mon,  4 Nov 2019 13:05:31 +0100
Message-Id: <20191104120532.32839-3-stefanha@redhat.com>
In-Reply-To: <20191104120532.32839-1-stefanha@redhat.com>
References: <20191104120532.32839-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: E_HpD_zePZ2GeI_pAOtNMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The version number is extracted from the .spec file.  Make .pc depend on
.spec so that VERSION variable substitutions are always up-to-date.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cc457bb..8af1c3a 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@ ifneq ($(MAKECMDGOALS),clean)
 include config-host.mak
 endif
=20
-%.pc: %.pc.in config-host.mak
+%.pc: %.pc.in config-host.mak $(SPECFILE)
 =09sed -e "s%@prefix@%$(prefix)%g" \
 =09    -e "s%@libdir@%$(libdir)%g" \
 =09    -e "s%@includedir@%$(includedir)%g" \
--=20
2.23.0

