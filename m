Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F155F61241
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 19:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhIWTuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242940AbhIWTuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 15:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632426514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Vt7YWjNxWEYJFK3AH8bfC/R43Amq3ybj79IQEHl8+aI=;
        b=i/qCrMhrRQN+YyUiPDBvIccNEv6o2wQXrHXo6GGj/pq/aTOn0OCriH41vyGl48tPXxVRx5
        agfrSu4AZskkRgMn+h3HmrpZppnAu49GG9E8Pu2tNBnRver3syb5xptJvP4OoJVcH++G/B
        W+DilbUE/sglV2THI0Qcr9LnsKJxKgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-T-FWAu2fPNaInLZae4EhUQ-1; Thu, 23 Sep 2021 15:48:33 -0400
X-MC-Unique: T-FWAu2fPNaInLZae4EhUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F65F9126D;
        Thu, 23 Sep 2021 19:48:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3ED96A900;
        Thu, 23 Sep 2021 19:48:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 18NJmSnx029918;
        Thu, 23 Sep 2021 15:48:28 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 18NJmRWh029914;
        Thu, 23 Sep 2021 15:48:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 23 Sep 2021 15:48:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org
Subject: [PATCH] loop: don't print warnings if the underlying filesystem
 doesn't support discard
Message-ID: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

When running the lvm testsuite, we get a lot of warnings 
"blk_update_request: operation not supported error, dev loop0, sector 0 op 
0x9:(WRITE_ZEROES) flags 0x800800 phys_seg 0 prio class 0". The lvm 
testsuite puts the loop device on tmpfs and the reason for the warning is 
that tmpfs supports fallocate, but doesn't support FALLOC_FL_ZERO_RANGE.

I've created this patch to silence the warnings.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

The loop driver checks for the fallocate method and if it is present, it
assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and
FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or
tmpfs) have the fallocate method, but lack the capability to do
FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.

This results in syslog warnings "blk_update_request: operation not
supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800
phys_seg 0 prio class 0"

This patch sets RQF_QUIET to silence the warnings.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/block/loop.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c	2021-09-23 17:06:57.000000000 +0200
+++ linux-2.6/drivers/block/loop.c	2021-09-23 21:29:39.000000000 +0200
@@ -493,7 +493,16 @@ static int lo_fallocate(struct loop_devi
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		ret = -EIO;
- out:
+out:
+
+	/*
+	 * Some filesystems have the fallocate method, but lack the capability
+	 * to do FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE requests.
+	 * We do not want a syslog warning in this case.
+	 */
+	if (ret == -EOPNOTSUPP)
+		rq->rq_flags |= RQF_QUIET;
+
 	return ret;
 }
 

