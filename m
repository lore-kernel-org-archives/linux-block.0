Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516C9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 15:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiDTPIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiDTPIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 11:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4CE937AB7
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650467166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6DKh4o2jS010YVUvBT4jr1LtaBa+8/+wEj/lEYqROuM=;
        b=JSXQ29b4IEewbMrW85QAUN9UxymmUjCEAPICp5w9dC+j71dyod0yZIxOw+0yd492JS4py8
        8VGo4Mx1SLptNcvblZqJ4wDnvX897idKLdzenz2+euKOqAbxc/ObebXDYiBi7GsQ2AT24B
        zg6+sJGZucXGKfgJ+SIvjnIFpkTuYB8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-OS1SCCbiNWqoSE-FbH9wgA-1; Wed, 20 Apr 2022 11:06:03 -0400
X-MC-Unique: OS1SCCbiNWqoSE-FbH9wgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D080129AA3B9;
        Wed, 20 Apr 2022 15:06:02 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 639A4112131B;
        Wed, 20 Apr 2022 15:05:47 +0000 (UTC)
Date:   Wed, 20 Apr 2022 23:05:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Message-ID: <YmAhRtOnezJ2EwBl@T590>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590>
 <20220420124213.5wc4umnjrlvu6zbi@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420124213.5wc4umnjrlvu6zbi@shindev>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 20, 2022 at 12:42:14PM +0000, Shinichiro Kawasaki wrote:
> On Apr 20, 2022 / 17:34, Ming Lei wrote:
> > On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
> > > The test case block/002 checks that device removal during blktrace run
> > > does not leak debugfs directory. The Linux kernel commit 0a9a25ca7843
> > > ("block: let blkcg_gq grab request queue's refcnt") triggered failure of
> > > the test case. The commit delayed queue release and debugfs directory
> > > removal then the test case checks directory existence too early. To
> > > avoid this false-positive failure, delay the directory existence check.
> > > 
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > ---
> > >  tests/block/002 | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tests/block/002 b/tests/block/002
> > > index 9b183e7..8061c91 100755
> > > --- a/tests/block/002
> > > +++ b/tests/block/002
> > > @@ -29,6 +29,7 @@ test() {
> > >  		echo "debugfs directory deleted with blktrace active"
> > >  	fi
> > >  	{ kill $!; wait; } >/dev/null 2>/dev/null
> > > +	sleep 0.5
> > >  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
> > >  		echo "debugfs directory leaked"
> > >  	fi
> > 
> > Hello,
> > 
> > Jens has merged Yu Kuai's fix[1], so I think it won't be triggered now.
> > 
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.18&id=a87c29e1a85e64b28445bb1e80505230bf2e3b4b
> 
> Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/002.
> Unfortunately, it failed with a new symptom with KASAN use-after-free [2]. I
> ran block/002 with linux-block/block-5.18 branch tip with git hash a87c29e1a85e
> and got the same KASAN uaf. Reverting the patch from the linux-block/block-5.18
> branch, the KASAN uaf disappears (Still block/002 fails). Regarding block/002,
> it looks the patch made the failure symptom worse.

Hi Shinichiro,

Looks Yu Kuai's patch has other problem, can you drop that patch and
apply & test the attached patch?

Jens, looks the patch of "blk-mq: fix possible creation failure for 'debugfs_dir'"
isn't ready to go, can you drop it first from block-5.18?

diff --git a/block/blk-core.c b/block/blk-core.c
index f305cb66c72a..c41c415849d9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -438,6 +438,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
 	int ret;
+	char q_name[32];
 
 	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
 			GFP_KERNEL | __GFP_ZERO, node_id);
@@ -495,6 +496,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
+	snprintf(q_name, 32, "%d", q->id);
+	q->debugfs_dir = debugfs_create_dir(q_name, blk_debugfs_root);
+
 	return q;
 
 fail_stats:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..651ec10a5a87 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -837,8 +837,8 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	mutex_lock(&q->debugfs_mutex);
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
+	q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
+			blk_debugfs_root, kobject_name(q->kobj.parent));
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (queue_is_mq(q)) {
@@ -913,6 +913,7 @@ int blk_register_queue(struct gendisk *disk)
 void blk_unregister_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
+	char q_name[32];
 
 	if (WARN_ON(!q))
 		return;
@@ -951,5 +952,11 @@ void blk_unregister_queue(struct gendisk *disk)
 
 	mutex_unlock(&q->sysfs_dir_lock);
 
+	mutex_lock(&q->debugfs_mutex);
+	snprintf(q_name, 32, "%d", q->id);
+	q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
+			blk_debugfs_root, q_name);
+	mutex_unlock(&q->debugfs_mutex);
+
 	kobject_put(&disk_to_dev(disk)->kobj);
 }

Thanks,
Ming

