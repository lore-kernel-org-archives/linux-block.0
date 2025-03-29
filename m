Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9591DFFC
	for <linux-block@vger.kernel.org>; Sat, 29 Mar 2025 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743213598; cv=none; b=btlLWWKaN29VtG3GOx+hQy491VyF7HGYprMdkUk2hE4e3iOlB6GUznxuPh3lfXbDuPlkKzZeMtVl9hNc67X2Mjj8k6H/N/wsOpWrmSrR6HfwGkY/JlMIYWflSEoDwwGFjJs1A0TlhQEyU3p17NB5of93siz1cAZHvcwbGfcQ6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743213598; c=relaxed/simple;
	bh=fzfKJMbK5AcAKl2AmcfVvaTF+8nmCh0DPH0nLxVk9Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1bejODrjQZDsawdwA9s5b+uNzPkDh+vnqogMzLYCKkhT3hw/8FIBvRrY5l12VM2K2IsihYFwr1fG49kY5Zpn/aMXP/KvP7g68Utg8OxbOA4IS1ouyXi1WcucvDLvzObnuYt984PXvzVFM3wNi6/C0oalz6+yn9HOjmGej+XR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDnFDpiP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDnFDpiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743213594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ujqnZ6t3I87/+eNzjM8VGw0zdV2aNa4K5PuELkT1So=;
	b=PDnFDpiPgOHNqXqpvaD60WHO60MNnBpO7N8Sale53LDag7fzgG5L+hgFU9EsqjxRZ/WRdH
	0Hj3q+kD6O8WCv/E4zoTKQqeiIKJTjY0TelxSeR5pjj04x93Cs6Er5vop6U+kjaH4G6Jdl
	PuN774kRE1Ogy26Pdo5y3L7uSLoI3CA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-yVmLorBuMqymqhlicz1PDw-1; Fri,
 28 Mar 2025 21:59:49 -0400
X-MC-Unique: yVmLorBuMqymqhlicz1PDw-1
X-Mimecast-MFC-AGG-ID: yVmLorBuMqymqhlicz1PDw_1743213588
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CDB01800EC5;
	Sat, 29 Mar 2025 01:59:48 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD42619560AB;
	Sat, 29 Mar 2025 01:59:42 +0000 (UTC)
Date: Sat, 29 Mar 2025 09:59:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [syzbot] [block?] possible deadlock in elv_iosched_store
Message-ID: <Z-dUCLvf06SfTOHy@fedora>
References: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Mar 28, 2025 at 07:37:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1384b43f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7e0f9b94ad65811efb
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178cfa4c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8ca4c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> 

...

> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..d7a103dc258b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	return NULL;
 }
 
-static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
-						struct request_queue *q)
+static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				     struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i, j;
 
-	/* protect against switching io scheduler  */
-	mutex_lock(&q->elevator_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int old_node;
 		int node = blk_mq_get_hctx_node(set, i);
@@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	xa_for_each_start(&q->hctx_table, j, hctx, j)
 		blk_mq_exit_hctx(q, set, hctx, j);
-	mutex_unlock(&q->elevator_lock);
+}
+
+static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+				   struct request_queue *q, bool lock)
+{
+	if (lock) {
+		/* protect against switching io scheduler  */
+		mutex_lock(&q->elevator_lock);
+		__blk_mq_realloc_hw_ctxs(set, q);
+		mutex_unlock(&q->elevator_lock);
+	} else {
+		__blk_mq_realloc_hw_ctxs(set, q);
+	}
 
 	/* unregister cpuhp callbacks for exited hctxs */
 	blk_mq_remove_hw_queues_cpuhp(q);
@@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	xa_init(&q->hctx_table);
 
-	blk_mq_realloc_hw_ctxs(set, q);
+	blk_mq_realloc_hw_ctxs(set, q, false);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
@@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		blk_mq_realloc_hw_ctxs(set, q, true);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;

Thanks,
Ming

