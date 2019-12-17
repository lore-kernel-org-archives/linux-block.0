Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C0C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8995121835
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIUTIhif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLQQAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:00:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30058 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbfLQQAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576598429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=LHY7/sCHlK9IhST8k8x/+uuV5bPNih9LNczJAHNHTZw=;
        b=FIUTIhifJN9nIRwC5vgZ2BvzWTE74gh/q/Uf3qIQ5f2W+e1IId2POv9sC95BmfOVNUxNYo
        yz/B+TDO4quxODQAA5HAVstQY5VZ0FqHejloXqQ7TW+G34bhZHi0W9jrKbdbKxv/RVftDP
        FwlZFaL8laFmlYPslTLYoMK1otZytGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-qgkBDHZCMv-tKbI_DTZH4w-1; Tue, 17 Dec 2019 11:00:27 -0500
X-MC-Unique: qgkBDHZCMv-tKbI_DTZH4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B58107ACCD
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 16:00:26 +0000 (UTC)
Received: from redhat (ovpn-124-205.rdu2.redhat.com [10.10.124.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 357E4620CE;
        Tue, 17 Dec 2019 16:00:26 +0000 (UTC)
Date:   Tue, 17 Dec 2019 11:00:24 -0500
From:   David Jeffery <djeffery@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     David Jeffery <djeffery@redhat.com>,
        John Pittman <jpittman@redhat.com>
Subject: [PATCH] sbitmap: only queue kyber's wait callback if not already
 active
Message-ID: <20191217160024.GA23066@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Under heavy loads where the kyber I/O scheduler hits the token limits for
its scheduling domains, kyber can become stuck.  When active requests
complete, kyber may not be woken up leaving the I/O requests in kyber
stuck.

This stuck state is due to a race condition with kyber and the sbitmap
functions it uses to run a callback when enough requests have completed.
The running of a sbt_wait callback can race with the attempt to insert the
sbt_wait.  Since sbitmap_del_wait_queue removes the sbt_wait from the list
first then sets the sbq field to NULL, kyber can see the item as not on a
list but the call to sbitmap_add_wait_queue will see sbq as non-NULL. This
results in the sbt_wait being inserted onto the wait list but ws_active
doesn't get incremented.  So the sbitmap queue does not know there is a
waiter on a wait list.

Since sbitmap doesn't think there is a waiter, kyber may never be
informed that there are domain tokens available and the I/O never advances.
With the sbt_wait on a wait list, kyber believes it has an active waiter
so cannot insert a new waiter when reaching the domain's full state.

This race can be fixed by only adding the sbt_wait to the queue if the
sbq field is NULL.  If sbq is not NULL, there is already an action active
which will trigger the re-running of kyber.  Let it run and add the
sbt_wait to the wait list if still needing to wait.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Reported-by: John Pittman <jpittman@redhat.com>
Tested-by: John Pittman <jpittman@redhat.com>
---

This bug was reliably being triggered on several test systems.  With the
fix, the tests no longer fail.

 sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 33feec8989f1..af88d1346dd7 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -650,8 +650,8 @@ void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
 	if (!sbq_wait->sbq) {
 		sbq_wait->sbq = sbq;
 		atomic_inc(&sbq->ws_active);
+		add_wait_queue(&ws->wait, &sbq_wait->wait);
 	}
-	add_wait_queue(&ws->wait, &sbq_wait->wait);
 }
 EXPORT_SYMBOL_GPL(sbitmap_add_wait_queue);
 

