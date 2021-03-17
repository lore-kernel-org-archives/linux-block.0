Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54742C433E9
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A7F64F79
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhCQPvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232756AbhCQPvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 11:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615996263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8H8OWhg17sJjqBEbsaohXSLcVxJEm1vjVGCfPGKif5o=;
        b=EUoimClbzDvc0p01BWjtoCqq4lJzpkhTZSz3wHNPxl/P3YIAHynUQPNHb6P8HAsAdmqi9f
        7AYCeNk13Z2nNsJYrVkbshcj1QJ1hawUZMrFQ0Q47EyMgk1NlVY6IoUDq1TRAAAu/OU92U
        aTs1BO469KDvKTcxdY/cqH505oPJPKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-OicBpSriMyKFn0ji33RJ3Q-1; Wed, 17 Mar 2021 11:34:48 -0400
X-MC-Unique: OicBpSriMyKFn0ji33RJ3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FBB210866A3;
        Wed, 17 Mar 2021 15:34:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0AE05C5DF;
        Wed, 17 Mar 2021 15:34:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 12HFYeMU029722;
        Wed, 17 Mar 2021 11:34:40 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 12HFYdrE029718;
        Wed, 17 Mar 2021 11:34:39 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 17 Mar 2021 11:34:39 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Zdenek Kabelac <zkabelac@redhat.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: remove the "detected capacity change" message
In-Reply-To: <20210317134715.GA362913@infradead.org>
Message-ID: <alpine.LRH.2.02.2103171129550.2959@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2103170644080.32577@file01.intranet.prod.int.rdu2.redhat.com> <20210317134715.GA362913@infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 17 Mar 2021, Christoph Hellwig wrote:

> No, it is everything but useless.  It is not needed during device
> creation, but that is something that the GENHD_FL_UP check should catch.
> 
> You should probably audit the device mapper code why it sets the initial
> capacity when the gendisk is up already, as that can cause all kinds of
> problems.  If the setting of the initial capacity after add_disk is
> indeed intentional you can switch to set_capacity(), but you should
> probably document the rationale in a detailed comment.

BTW. the loop device has the same problem as device mapper - it also 
prints "loop0: detected capacity change from 0 to 2097152" when it is 
being activated.

Would you accept this patch?

Or do you think that we should change device mapper and the loopback 
driver to call "set_capacity" on the initial device creation?

Mikulas

---
 block/genhd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/block/genhd.c
===================================================================
--- linux-2.6.orig/block/genhd.c	2021-03-17 16:26:11.000000000 +0100
+++ linux-2.6/block/genhd.c	2021-03-17 16:26:42.000000000 +0100
@@ -71,16 +71,16 @@ bool set_capacity_and_notify(struct gend
 	if (size == capacity ||
 	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
 		return false;
-
-	pr_info("%s: detected capacity change from %lld to %lld\n",
-		disk->disk_name, capacity, size);
-
 	/*
 	 * Historically we did not send a uevent for changes to/from an empty
 	 * device.
 	 */
 	if (!capacity || !size)
 		return false;
+
+	pr_info("%s: detected capacity change from %lld to %lld\n",
+		disk->disk_name, capacity, size);
+
 	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
 	return true;
 }

