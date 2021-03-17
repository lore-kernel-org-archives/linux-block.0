Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA6C433E9
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B9D64F30
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 10:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCQKrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 06:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhCQKrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 06:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615978020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FV92v9zlPp9PO61QQ8L+ixherErQblRKxttUCA2cBOo=;
        b=Jm7IoT06Em4VDnCJfYzDoppEXc9zQRMNjKwIaLhZEseNpeEZBT2yhUqi8E9VIQ/Yc1XgZB
        VE9lQlZN5m6yDyT8e6iZqNLwaMDT++f6DhrbBfuQtHioP0PkNRoXIW3w2nrgdpkeF0CApl
        HOK1xSnoH6lHfnpzbE3srGajeFTE+tA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-Yg3PKCDQMb-684LP4fE5-A-1; Wed, 17 Mar 2021 06:46:58 -0400
X-MC-Unique: Yg3PKCDQMb-684LP4fE5-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC65557088;
        Wed, 17 Mar 2021 10:46:57 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A6C62A6F;
        Wed, 17 Mar 2021 10:46:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 12HAkn5g000602;
        Wed, 17 Mar 2021 06:46:49 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 12HAknhv000598;
        Wed, 17 Mar 2021 06:46:49 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 17 Mar 2021 06:46:49 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Zdenek Kabelac <zkabelac@redhat.com>, ming.lei@redhat.com
Subject: [PATCH] block: remove the "detected capacity change" message
Message-ID: <alpine.LRH.2.02.2103170644080.32577@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every time a new device mapper device is created, a message "detected
capacity change from 0 to 2097152" is reported. This message is useless,
so this patch removes it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/genhd.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/block/genhd.c
===================================================================
--- linux-2.6.orig/block/genhd.c	2021-03-17 11:03:52.000000000 +0100
+++ linux-2.6/block/genhd.c	2021-03-17 11:04:27.000000000 +0100
@@ -72,9 +72,6 @@ bool set_capacity_and_notify(struct gend
 	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
 		return false;
 
-	pr_info("%s: detected capacity change from %lld to %lld\n",
-		disk->disk_name, capacity, size);
-
 	/*
 	 * Historically we did not send a uevent for changes to/from an empty
 	 * device.

