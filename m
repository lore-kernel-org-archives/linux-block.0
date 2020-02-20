Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0162C11D07
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7757B24656
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuKCozOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBTMFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:05:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727298AbgBTMFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 07:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582200351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J4Trzyi62hKNJZ+m1l9MJwIu+S3SlOuFeej9qw7Smqk=;
        b=EuKCozOhSj6hURr923zfDfejuYzxnvGzmt9SFdV+d5nfEiAKs+lGtLRL9NSdUvKGj+/iBP
        MJt4ZGP3pZDheib2S/1LlXxmR+S4i4K/ONWZA2RKFTTS2j2J+xKCFxX5v9g+sIOvRCsnOF
        gZ/zphC/CMBgqdiyN8iMTNMnfT/eKsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-_jp3uFUwNWKOS2GeqHQN6A-1; Thu, 20 Feb 2020 07:05:41 -0500
X-MC-Unique: _jp3uFUwNWKOS2GeqHQN6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D8AA801E67;
        Thu, 20 Feb 2020 12:05:40 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECD9160BE1;
        Thu, 20 Feb 2020 12:05:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: Prevent hung_check firing during long sync IO
Date:   Thu, 20 Feb 2020 20:05:27 +0800
Message-Id: <20200220120527.15082-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
takes up to 100 second on some devices. Also any block I/O operation
that occurs after the BLKSECDISCARD is submitted will also potentially
be affected by the hung task timeouts.

So prevent hung_check from firing by taking same approach used
in blk_execute_rq(), and the wake-up interval is set as half the
hung_check timer period, which keeps overhead low enough.

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Link: https://lkml.org/lkml/2020/2/12/1193
Reported-by: Salman Qazi <sqazi@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..c9ce19a86de7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -17,6 +17,7 @@
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
 #include <linux/highmem.h>
+#include <linux/sched/sysctl.h>
=20
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio=
)
 int submit_bio_wait(struct bio *bio)
 {
 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
+	unsigned long hang_check;
=20
 	bio->bi_private =3D &done;
 	bio->bi_end_io =3D submit_bio_wait_endio;
 	bio->bi_opf |=3D REQ_SYNC;
 	submit_bio(bio);
-	wait_for_completion_io(&done);
+
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	hang_check =3D sysctl_hung_task_timeout_secs;
+	if (hang_check)
+		while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
+	else
+		wait_for_completion_io(&done);
=20
 	return blk_status_to_errno(bio->bi_status);
 }
--=20
2.20.1

