Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EF9C3A5A9
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 02:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8258206D7
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 02:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py8DJA7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEECKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 22:10:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbgEECKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 22:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bm5sR2PnQF/jHBY6XKYEDh8nT3RGgo6oZvSnhHOz/Gg=;
        b=Py8DJA7EJVb79FYtTVxBlT/c6UIJIsoBbsjaXdb2WPBgJHK/EqsCaFZKys009qOm6wSdmN
        1ENyNUIq2mzTfr39KeLXXVW9HK6hz31V17KsC+IE61dHltzdZtmD4D4XsNUhgZwVIjWEEj
        VhDH/p0dGaOQTU+WPu+u9SQimlgWME8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-1Io-rvSmMdOUGqzpKdcrIg-1; Mon, 04 May 2020 22:09:55 -0400
X-MC-Unique: 1Io-rvSmMdOUGqzpKdcrIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58DC91800D4A;
        Tue,  5 May 2020 02:09:54 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5795C5C1B2;
        Tue,  5 May 2020 02:09:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V10 01/11] block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
Date:   Tue,  5 May 2020 10:09:20 +0800
Message-Id: <20200505020930.1146281-2-ming.lei@redhat.com>
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far blk_rq_prep_clone() is only used for setup one underlying cloned
request from dm-rq request. block intetrity can be enabled for both dm-rq
and the underlying queues, so it is reasonable to clone rq's
nr_integrity_segments. Also write_hint is from bio, it should have been
cloned too.

So clone nr_integrity_segments and write_hint in blk_rq_prep_clone.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7f11560bfddb..1fe73051fec3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1630,8 +1630,12 @@ int blk_rq_prep_clone(struct request *rq, struct r=
equest *rq_src,
 		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
 		rq->special_vec =3D rq_src->special_vec;
 	}
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+#endif
 	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
 	rq->ioprio =3D rq_src->ioprio;
+	rq->write_hint =3D rq_src->write_hint;
=20
 	return 0;
=20
--=20
2.25.2

