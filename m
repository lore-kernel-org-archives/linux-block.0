Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32170C1975A
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 03:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F8A206F1
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 03:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmxfuwI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCRDnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:43:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30898 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRDnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 23:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584503032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bmQ827waZds22LTCNtV+9ynvhEbmWFFpwt6zLVq2YUE=;
        b=WmxfuwI/RDiXB7Qiu06cuTiXYjnrPcHhnr9gREAOc5hk78D9A0b8lButtzCMKf+m0kas6J
        TQ8Rk3M4zKgnxKTY27PtrBMJmT13XSW/ixpOjEMV6axxPaFcStuvPkLPdKrfcSF/IFOQQr
        nLKd1iDt7lFEThNQp6R/wRhKDwxABsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Wdyd3PQ3OS2Kk1zMDsiEMg-1; Tue, 17 Mar 2020 23:43:48 -0400
X-MC-Unique: Wdyd3PQ3OS2Kk1zMDsiEMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74875801E53;
        Wed, 18 Mar 2020 03:43:47 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E49B19C58;
        Wed, 18 Mar 2020 03:43:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2] block: Prevent hung_check firing during long sync IO
Date:   Wed, 18 Mar 2020 11:43:36 +0800
Message-Id: <20200318034336.6212-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Another report is that task hang can be observed when running mkfs
over raid10 which takes a small max discard sectors limit because
of chunk size.

So prevent hung_check from firing by taking same approach used
in blk_execute_rq(), and the wake-up interval is set as half the
hung_check timer period, which keeps overhead low enough.

Cc: Salman Qazi <sqazi@google.com>
Cc: Jesse Barnes <jsbarnes@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Link: https://lkml.org/lkml/2020/2/12/1193
Reported-by: Salman Qazi <sqazi@google.com>
Reviewed-by: Jesse Barnes <jsbarnes@google.com>
Reviewed-by: Salman Qazi <sqazi@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix checkpatch warning
	- add reviewed-by
	- add comment log for covering one recent report on task hung on
	  raid10

 block/bio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..0985f3422556 100644
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
@@ -1019,12 +1020,21 @@ static void submit_bio_wait_endio(struct bio *bio=
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
+		while (!wait_for_completion_io_timeout(&done,
+					hang_check * (HZ/2)))
+			;
+	else
+		wait_for_completion_io(&done);
=20
 	return blk_status_to_errno(bio->bi_status);
 }
--=20
2.20.1

