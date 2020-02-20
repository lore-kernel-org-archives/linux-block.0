Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DAC11D05
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E922465D
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1di/khd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBTOrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:47:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727705AbgBTOrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 09:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FdLYBHLzW6AT7gObvWeMQH4F9mSt2j7qukSIs/JiLag=;
        b=D1di/khdR80fMk87R3mIUWSY9Dzc8LU8WwZhOWglpjIFJlu+4mafohy1RKhCDebTxp6V1+
        BsJ1N66N/I7Rqm+5iqVjosNTc2kcE/pTw978cRbgmWKJ3BfBgucLm86i1n/jeEaE8DhhX8
        Lc2809FvIHLRhTEIVGkO0Xias53GTdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-BsKB0UDBMbO10yMY3EV8ZQ-1; Thu, 20 Feb 2020 09:47:09 -0500
X-MC-Unique: BsKB0UDBMbO10yMY3EV8ZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C00C910509DF;
        Thu, 20 Feb 2020 14:47:07 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163CB8681F;
        Thu, 20 Feb 2020 14:47:05 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sunke32@huawei.com
Subject: [PATCH blktests] nbd/003: fix compiling error with gcc version 4.8.5
Date:   Thu, 20 Feb 2020 22:46:49 +0800
Message-Id: <20200220144649.16881-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cc  -O2 -Wall -Wshadow   -o mount_clear_sock mount_clear_sock.c
mount_clear_sock.c: In function =E2=80=98main=E2=80=99:
mount_clear_sock.c:39:2: error: =E2=80=98for=E2=80=99 loop initial declar=
ations are only allowed in C99 mode
  for (int i =3D 0; i < loops; i++) {
  ^
mount_clear_sock.c:39:2: note: use option -std=3Dc99 or -std=3Dgnu99 to c=
ompile your code

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 src/mount_clear_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mount_clear_sock.c b/src/mount_clear_sock.c
index 4030a4a..984395e 100644
--- a/src/mount_clear_sock.c
+++ b/src/mount_clear_sock.c
@@ -18,7 +18,7 @@
 int main(int argc, char **argv)
 {
 	const char *mountpoint, *dev, *fstype;
-	int loops, fd;
+	int loops, fd, i;
=20
 	if (argc !=3D 5) {
 		fprintf(stderr, "usage: %s DEV MOUNTPOINT FSTYPE LOOPS", argv[0]);
@@ -36,7 +36,7 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
=20
-	for (int i =3D 0; i < loops; i++) {
+	for (i =3D 0; i < loops; i++) {
 		pid_t mount_pid, clear_sock_pid;
 		int wstatus;
=20
--=20
2.21.0

