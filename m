Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7A1A9F9F
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718775; cv=none; b=Dgh6KstPBeoKiZCIv4Vc5021Sz+xpedFBt5tPN4HOGvW8XmA4xhaBwk5Ht14jTglrfTX1DEXXSVwBIu5RjRi9Z0jg8jeDZ7WU9K9yjuGubJIOfCF2w7R0JrGaOO5EtGXvCo3I8Yb8aa8KGGx+qilykIV0JboFU1de1KCR2kwY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718775; c=relaxed/simple;
	bh=cmNKtg+J8LhTwVzg2ci/rk3+VO/unz9oDnPTminxzP0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XvAWHGtgiXgHHa81UnYErfUvCxBW45qOcoajK8iT1fH5HKmJWyIpFpzdqbEblB//wvnNux3tVdtBfwdrvCf1xUcVldjNMsfMiyssRdQpLvZKzHT4lnR5yMowfhy0mF517k7xF2aukh/1NvUHiphVdVfMGhADWvW3TizVIZfkRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhX/9PLP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhX/9PLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767718772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXIPja358bYJTShsT3/eIi172a+gL/gWyu8mS8R++3E=;
	b=DhX/9PLPXyBvqpqEhTtKMkemwtIpqJQ5vZ2anJiHJd3yBUj6s4x3scyxFFPJnjzVoVZJoA
	x1zhu/l0xE01dMgV6I6GWjxWz7AXVhV1BmhV71E6IqoSouNiWmPgohPKyhrBM7PdOFvoLw
	sPaFb95VD1lByKSoG7CoMM7VzPhWtww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-H7_ducD1MVuQwnNRvvOrKg-1; Tue,
 06 Jan 2026 11:59:28 -0500
X-MC-Unique: H7_ducD1MVuQwnNRvvOrKg-1
X-Mimecast-MFC-AGG-ID: H7_ducD1MVuQwnNRvvOrKg_1767718766
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B7701800654;
	Tue,  6 Jan 2026 16:59:26 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A5C530001B9;
	Tue,  6 Jan 2026 16:59:22 +0000 (UTC)
Date: Tue, 6 Jan 2026 17:59:16 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
cc: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>, 
    Fengnan Chang <changfengnan@bytedance.com>, Jens Axboe <axboe@kernel.dk>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Frederic Weisbecker <frederic@kernel.org>, 
    Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
    Joel Fernandes <joelagnelf@nvidia.com>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    rcu@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
In-Reply-To: <aV04Vp3nmCg41YZD@pc636>
Message-ID: <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com> <aV04Vp3nmCg41YZD@pc636>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Tue, 6 Jan 2026, Uladzislau Rezki wrote:

> On Tue, Jan 06, 2026 at 04:56:07PM +0100, Mikulas Patocka wrote:
> > On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> > virtual machine when probing a virtio-scsi disk:
> > [    1.011641] SCSI subsystem initialized
> > [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> > [    1.015983] scsi host0: Virtio SCSI HBA
> > [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> > [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> > [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> > [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> > [    1.024688] scsi host1: ahci
> > [    1.025432] scsi host2: ahci
> > [    1.025966] scsi host3: ahci
> > [    1.026511] scsi host4: ahci
> > [    1.028371] scsi host5: ahci
> > [    1.028918] scsi host6: ahci
> > [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> > [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> > [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> > [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> > [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> > [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> > [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> > [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> > [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> > [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> > [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> > [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> > [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> > [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> > [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> > [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> > [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> > [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> > 
> > I bisected it and it is caused by the commit 89e1fb7ceffd which
> > introduces calls to synchronize_rcu_expedited.
> > 
> > This commit replaces synchronize_rcu_expedited and kfree with a call to 
> > kfree_rcu_mightsleep, avoiding the 15-second delay.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> > 
> > ---
> >  block/blk-mq.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > Index: linux-2.6/block/blk-mq.c
> > ===================================================================
> > --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> > +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> > @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
> >  		 * Make sure reading the old queue_hw_ctx from other
> >  		 * context concurrently won't trigger uaf.
> >  		 */
> > -		synchronize_rcu_expedited();
> > -		kfree(hctxs);
> > +		kfree_rcu_mightsleep(hctxs);
> >
> I agree, doing freeing that way is not optimal. But kfree_rcu_mightsleep()
> also might not work. It has a fallback, if we can not place an object into
> "page" due to memory allocation failure, it inlines freeing:
> 
> <snip>
> synchronize_rcu();
> free().
> <snip>
> 
> Please note, synchronize_rcu() can easily be converted into expedited
> version. See rcu_gp_is_expedited().
> 
> --
> Uladzislau Rezki

Would this patch be better? It does GFP_KERNEL allocation which dones't 
fail in practice.

> Inlining is a corner case but it can happen. The best way is to add
> rcu_head to the blk_mq_hw_ctx structure and use kfree_rcu(). It never
> blocks.

We are not protecting the blk_mq_hw_ctx structure with RCU, we are 
protecting the q->queue_hw_ctx array. So, rcu_head cannot be added to an 
array. We could cast the array to rcu_head (and make sure that the initial 
allocation is at least sizeof(struct rcu_head)), but that is hacky.

Mikulas

---
 block/blk-mq.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

Index: linux-2.6/block/blk-mq.c
===================================================================
--- linux-2.6.orig/block/blk-mq.c	2026-01-06 15:55:41.000000000 +0100
+++ linux-2.6/block/blk-mq.c	2026-01-06 16:22:40.000000000 +0100
@@ -4531,6 +4531,18 @@ static struct blk_mq_hw_ctx *blk_mq_allo
 	return NULL;
 }
 
+struct rcu_free_hctxs {
+	struct rcu_head head;
+	struct blk_mq_hw_ctx **hctxs;
+};
+
+static void rcu_free_hctxs(struct rcu_head *head)
+{
+	struct rcu_free_hctxs *r = container_of(head, struct rcu_free_hctxs, head);
+	kfree(r->hctxs);
+	kfree(r);
+}
+
 static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
@@ -4539,6 +4551,7 @@ static void __blk_mq_realloc_hw_ctxs(str
 
 	if (q->nr_hw_queues < set->nr_hw_queues) {
 		struct blk_mq_hw_ctx **new_hctxs;
+		struct rcu_free_hctxs *r;
 
 		new_hctxs = kcalloc_node(set->nr_hw_queues,
 				       sizeof(*new_hctxs), GFP_KERNEL,
@@ -4553,8 +4566,14 @@ static void __blk_mq_realloc_hw_ctxs(str
 		 * Make sure reading the old queue_hw_ctx from other
 		 * context concurrently won't trigger uaf.
 		 */
-		synchronize_rcu_expedited();
-		kfree(hctxs);
+		r = kmalloc(sizeof(struct rcu_free_hctxs), GFP_KERNEL);
+		if (!r) {
+			synchronize_rcu_expedited();
+			kfree(hctxs);
+		} else {
+			r->hctxs = hctxs;
+			call_rcu(&r->head, rcu_free_hctxs);
+		}
 		hctxs = new_hctxs;
 	}
 
> 

