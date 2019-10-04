Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415BAC4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B95215EA
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbfJDSRm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfJDSRE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Oct 2019 14:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB6D3004E5B;
        Fri,  4 Oct 2019 18:17:04 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7477C600D1;
        Fri,  4 Oct 2019 18:17:04 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCHSET v2] io_uring: support fileset add/remove/modify
References: <20191004162222.10390-1-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 04 Oct 2019 14:17:03 -0400
In-Reply-To: <20191004162222.10390-1-axboe@kernel.dk> (Jens Axboe's message of
        "Fri, 4 Oct 2019 10:22:20 -0600")
Message-ID: <x49pnjcl6jk.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 04 Oct 2019 18:17:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Currently we only support registrering a fixed file set. If changes need
> to be made to that set, the application must unregister the existing set
> first, then register a new one.
>
> This patchset adds support for sparse file sets (patch 1), which means
> the application can register a fileset with room for expansion. This is
> done through having unregistered slots use fd == -1.
>
> On top of that, we can add IORING_REGISTER_FILES_UPDATE. This allows
> modifying the existing file set through:
>
> - Replacing empty slots with valid file descriptors
> - Replacing valid descriptors with an empty slot
> - Modifying an existing slot, replacing a file descriptor with a new one

I don't pretend to understand the socket code you wrote.  The io_uring
bits look good to me.  I also added a testcase to your file-register.c
program--diff below.  The test passes, of course.  :)

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Cheers,
Jeff

diff --git a/test/file-register.c b/test/file-register.c
index b25f0f5..322545f 100644
--- a/test/file-register.c
+++ b/test/file-register.c
@@ -358,6 +358,40 @@ err:
 	return 1;
 }
 
+/*
+ * Register 0 files, but reserve space for 10.  Then add one file.
+ */
+static int test_zero(struct io_uring *ring)
+{
+	struct io_uring_files_update up;
+	int *files;
+	int ret;
+
+	files = open_files(0, 10, 0);
+	ret = io_uring_register(ring->ring_fd, IORING_REGISTER_FILES, files, 10);
+	if (ret)
+		goto err;
+
+	up.fds = open_files(1, 0, 1);
+	up.offset = 0;
+	ret = io_uring_register(ring->ring_fd,
+				IORING_REGISTER_FILES_UPDATE, &up, 1);
+	if (ret != 1) {
+		printf("ret=%d, errno=%d\n", ret, errno);
+		goto err;
+	}
+
+	ret = io_uring_register(ring->ring_fd, IORING_UNREGISTER_FILES, NULL, 0);
+	if (ret)
+		goto err;
+
+	close_files(up.fds, 1, 1);
+	return 0;
+err:
+	close_files(up.fds, 1, 1);
+	return 1;
+}
+
 int main(int argc, char *argv[])
 {
 	struct io_uring ring;
@@ -426,5 +460,11 @@ int main(int argc, char *argv[])
 		return ret;
 	}
 
+	ret = test_zero(&ring);
+	if (ret) {
+		printf("test_zero failed\n");
+		return ret;
+	}
+
 	return 0;
 }
