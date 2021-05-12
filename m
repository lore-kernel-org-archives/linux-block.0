Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96852C43461
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD756192B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhELHDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:22 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44650 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhELHDS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:18 -0400
Received: by mail-pj1-f54.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2780136pjb.3;
        Wed, 12 May 2021 00:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4L1CM5TjzwngNWpSW5lfB0TalYgC1UQCXnGH/wxMcYc=;
        b=SvFqJ5h1Tcq3/m8UE6MEqsRovCIGJEBlhD2/nKQezdfj3e8U9yfUVFFksBz3Rw0ECR
         fEch/1wpCPtvOm20xWVyv0dtecFtqj7P47zqWXmXxdxS5eQ6mX59UYGgrlew4aKJzGRW
         6YzjMl2pBKqhyEFbYLd8VR+tIXuiBypN7QdUx+daPTlc+t8ugInKr9qzB924yF7M4/Ar
         k8qb2XVxPQ+hnDzfy+3yis5+RQntxayG6i/JLteH3L1h5+it4MJnv4NfhMdM3E6X64xj
         AQR7Rs6Ph2/+qXz3evIjZSkyGcLzmq3U2EbPZ5PCHGjawu7qMk1fr4tf/DEv9nI73OUa
         qCfA==
X-Gm-Message-State: AOAM531O9yKu3gqbXE7U0P/PrDmHa/gTmSBl/VCBd5J3bGj+aKqRbpeb
        wyaOQKbiz5T1pIfROdGlvyY=
X-Google-Smtp-Source: ABdhPJz9fwE4W3zj6q7xPB3oxXrCTaGFpysEzh+cDt24WcK0QMFwqTD/o5kQFDv8DpI4j1rtBo2WhA==
X-Received: by 2002:a17:90a:2844:: with SMTP id p4mr9728467pjf.89.1620802929782;
        Wed, 12 May 2021 00:02:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n8sm15211264pfu.111.2021.05.12.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1D7DD42079; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 1/8] block: refcount the request_queue early in __device_add_disk()
Date:   Wed, 12 May 2021 06:46:22 +0000
Message-Id: <20210512064629.13899-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A related commit is 5a0ec388ef0 ("pktcdvd: Fix pkt_setup_dev() error
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
index 39ca97b0edc6..51dff87c4756 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -504,6 +504,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
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
@@ -556,12 +562,6 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
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
2.30.2

