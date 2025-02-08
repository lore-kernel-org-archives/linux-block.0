Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1D23C8D6
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739003431; cv=none; b=MhFRmmIpvdmRXMBU8gSo0YEFrbGTLPiglPkUi5Zvk2elPkHoNu5V0A+PilWHY5NL4fpz/KJL+x6bycN3qtBmk0VstdfryblTpDpR8WN/rJtcy6gxc0AgBeU6FH3zSYvTPfLe2H5aqVidJh9sUywtUQDJC8oj24QMzfrWIDzBao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739003431; c=relaxed/simple;
	bh=Ff186vZTkkWOHTsGRTEcxihh0ir5Ce0THy/5xlTrkQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7EKWPsOtxvYrsXLnGoonUtUniKIc7yph1lFhYSzWqKUyXA2i20IyCWQpHDcumh2k7Qinn25IiRbhpAhpee90gmivoJ6vHFpPKxkPju9c+mImcQFazddB5obXcPdvrSFOLvnt68V5k8fOV96ru2//rfb+NLeFecWiMHRqX4ZOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdBJGflW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdBJGflW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739003428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wLdXMMRILupURM/myRQkUyRnuG3IslEM4XpxtbPyZwY=;
	b=SdBJGflWaIPRkzgtOyEh/VMM5Qa97lCtLX5MyNdzdZLlvJYsxnDnlwQcHmz9gwQ/To3NBS
	0zEYYuD305F4jTbBIcLa2E0+Pkj/5Fjg18ZEhfoY19cb3Ta/YYnVLMyEMKvaPyvxnNacQ3
	7iFc0dAyhuw8K42AL+9F/JKT9PpV3b8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-zLNU4VJEM32fTah-MhFwzQ-1; Sat,
 08 Feb 2025 03:30:24 -0500
X-MC-Unique: zLNU4VJEM32fTah-MhFwzQ-1
X-Mimecast-MFC-AGG-ID: zLNU4VJEM32fTah-MhFwzQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43DC1956094;
	Sat,  8 Feb 2025 08:30:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBDEF19560AE;
	Sat,  8 Feb 2025 08:30:16 +0000 (UTC)
Date: Sat, 8 Feb 2025 16:30:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
Message-ID: <Z6cWE_scvYcE_mWN@fedora>
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-2-nilay@linux.ibm.com>
 <20250205155952.GB14133@lst.de>
 <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
 <Z6X1hbzI4euK_r-S@fedora>
 <fee9de06-e235-43c1-b756-b10e9fa2c68e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee9de06-e235-43c1-b756-b10e9fa2c68e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Feb 07, 2025 at 11:32:37PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/7/25 5:29 PM, Ming Lei wrote:
> > On Thu, Feb 06, 2025 at 06:52:36PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 2/5/25 9:29 PM, Christoph Hellwig wrote:
> >>> On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
> >>>>  
> >>>>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >>>> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >>>>  		return;
> >>>>  
> >>>>  	memflags = memalloc_noio_save();
> >>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> >>>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >>>> +		mutex_lock(&q->sysfs_lock);
> >>>
> >>> This now means we hold up to number of request queues sysfs_lock
> >>> at the same time.  I doubt lockdep will be happy about this.
> >>> Did you test this patch with a multi-namespace nvme device or
> >>> a multi-LU per host SCSI setup?
> >>>
> >> Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
> >> complain. Agreed we need to hold up q->sysfs_lock for multiple 
> >> request queues at the same time and that may not be elegant, but 
> >> looking at the mess in __blk_mq_update_nr_hw_queues we may not
> >> have other choice which could help correct the lock order.
> > 
> > All q->sysfs_lock instance actually shares same lock class, so this way
> > should have triggered double lock warning, please see mutex_init().
> > 
> Well, my understanding about lockdep is that even though all q->sysfs_lock
> instances share the same lock class key, lockdep differentiates locks 
> based on their memory address. Since each instance of &q->sysfs_lock has 
> got different memory address, lockdep treat each of them as distinct locks 
> and IMO, that avoids triggering double lock warning.

That isn't correct, think about how lockdep can deal with millions of
lock instances.

Please take a look at the beginning of Documentation/locking/lockdep-design.rst

```
The validator tracks the 'usage state' of lock-classes, and it tracks
the dependencies between different lock-classes.
```

Please verify it by the following code:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e76651e786d..a4ffc6198e7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5150,10 +5150,37 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 		cancel_delayed_work_sync(&hctx->run_work);
 }

+struct lock_test {
+	struct mutex	lock;
+};
+
+void init_lock_test(struct lock_test *lt)
+{
+	mutex_init(&lt->lock);
+	printk("init lock: %p\n", lt);
+}
+
+static void test_lockdep(void)
+{
+	struct lock_test A, B;
+
+	init_lock_test(&A);
+	init_lock_test(&B);
+
+	printk("start lock test\n");
+	mutex_lock(&A.lock);
+	mutex_lock(&B.lock);
+	mutex_unlock(&B.lock);
+	mutex_unlock(&A.lock);
+	printk("end lock test\n");
+}
+
 static int __init blk_mq_init(void)
 {
 	int i;

+	test_lockdep();
+
 	for_each_possible_cpu(i)
 		init_llist_head(&per_cpu(blk_cpu_done, i));
 	for_each_possible_cpu(i)



Thanks,
Ming

