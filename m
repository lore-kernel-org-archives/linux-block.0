Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE076C83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCA620787
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146529;
	bh=N12cB1T0tW1/D8uYYvNBt+N6bWu69JrTpvZIdNYw7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVxauCb51q1kZrO0Q7n5a9zBZHGX2JGjTzWi1o9Vw0inhTkH/+aAe1e87UfziZCU5
	 p87Xzn2DD5Non7UJOREz4FGk9DCLCqXYpl2j1yWsAAz4t/4qt2wqctIYPAn2kVwtmo
	 IPxahANiiQKzEtEsK/7YRzUc+qRHnohcsPCZxDug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2Hst (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:48:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgD2Hss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id y25so710266pfn.5;
        Wed, 29 Apr 2020 00:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Mprrx+N/1IG0lpOsMC6pFihehpTtLFM4Po0pnJv2xU=;
        b=UwaRbLLkpgTigexrRgSOt0cpXoDxAirn1VRXH+hIKiioYa2WuSIW9HHXW96AemRLj3
         oIkzU5FmKEX3bWdR3ORiu+Jw+rHbqRsIyX2Fn+WS6O1vC4igUcARQEEygMmDjm2FqGP/
         oyNPjZ4vNYj3joriLsdQ38tv6Wqpkh3XHa9l065ytXqFl96wYcu1ByJ9MBNJaK1VTwBT
         mAaI+4F2aCT3w8N1XtoYlqYN8j9TFuOObhZ2y71O75m45JER8RW3O8BzMqGyBqvwJ9hu
         5w0IXubowJVK4WRfGWA4KCUYc2lkWsd/Y/3wa31i3I/wCAXlhEY7t+GUDDd8mUwDi5lt
         jRuA==
X-Gm-Message-State: AGi0Pua6UqkbosMBEgmCN6xfhc5PMcj0v5SMs+6Psymr9dYxQP1hQj9v
        yUQGHUPz3ON3mNsU4ZFaYnSZ5hTSWzk=
X-Google-Smtp-Source: APiQypI7ngW2h14GNvjybk2+5wFMX/mrJjPeSOgs5TfeYAxwwwe7wA+6l1nxeOK2MadAl5dUdWVMbA==
X-Received: by 2002:a62:c1c1:: with SMTP id i184mr35127925pfg.18.1588146527969;
        Wed, 29 Apr 2020 00:48:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 127sm419071pfz.128.2020.04.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A483940045; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 1/6] block: refcount the request_queue early in __device_add_disk()
Date:   Wed, 29 Apr 2020 07:48:39 +0000
Message-Id: <20200429074844.6241-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We refcount the request_queue right now towards the end of the
__device_add_disk(), however when we add error handling on this
function we'll want to refcount the request_queue first, to help
make less complicated changes on drivers on their error paths.

For instance, today a driver may call add_disk without error handling
but still handle other errors:

int foo_block_add(...)
{
	...
	queue = blk_mq_init_queue(...);
	...
	disk->queue = queue;
	disk = alloc_disk(...);
	if (!disk)
		goto out_free_queue;
	...
        add_disk(disk);
	...
        return 0;

out_free_queue:
        blk_cleanup_queue(queue);
	/* Note: we never call put_disk() as add_disk() never failed */
	...
}

We want drivers to cleanup with put_disk() on the error path if
add_disk() fails. However, calling blk_cleanup_queue() will already
put the queue, and so the last put_disk() on the error path will
be extra. This can be simplified later if once error handling is
added to __device_add_disk(), if refcounting the request_queue
fails right away on __device_add_disk() we just return early and
set disk->NULL for the driver. That would ensure driver error
paths chug on with their error paths, and all they'd need to
expand with is the missing put_disk().

The collateral evolution for adding error paths for add_disk() becomes
larger with the alternative of replacing the blk_cleanup_queue() with
a put_disk(). We'd still need to sprinkle then some blk_cleanup_queue()
calls on the driver paths up above prior to add_disk(). And how would
we know we reached a part of add_disk() which did refcount then?

A related commit is 5a0ec388ef0f ("pktcdvd: Fix pkt_setup_dev() error
path") which *had* to take the approach of removing the blk_cleanup_queue()
because otherwise the driver crashes.

Moving this to the top ensure our future error path can easily just
handle this itself. For instance, if it was not able to refcount the
request_queue it can disk->queue to NULL, that way allowing a
blk_cleanup_queue() call followed but a put_disk(). And if the
refcount was incremented, we'd still be able to keep the same error
path of blk_cleanup_queue() followed by put_disk().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a933cffbee2e..5f7faaf9cc83 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -803,6 +803,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	dev_t devt;
 	int retval;
 
+	/*
+	 * Take an extra ref on queue which will be put on disk_release()
+	 * so that it sticks around as long as @disk is there.
+	 */
+	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+
 	/*
 	 * The disk queue should now be all set with enough information about
 	 * the device for the elevator code to pick an adequate default
@@ -854,12 +860,6 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	if (register_queue)
 		blk_register_queue(disk);
 
-	/*
-	 * Take an extra ref on queue which will be put on disk_release()
-	 * so that it sticks around as long as @disk is there.
-	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
-
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-- 
2.25.1

