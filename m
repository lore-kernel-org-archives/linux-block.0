Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA23B28D
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714985; cv=none; b=hzjtBxJowHofuRhEeNZq46dHoABlultczb9mqJIYnxyueMKTlz6pFCozLt7lMB2MO2hp01YzGBoBTP7LfvTpc6WPdhDo/QsIWiFeQdjbNNK/Qt8ZZbpBbQ2neti8XV4Y2+KFPqgT9xVHmgNw18RPHKm5JZiWYJ8CriD+BlyGpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714985; c=relaxed/simple;
	bh=pWFdblXxzUvChQRDYfOX7Xlk17SBWTpHs1hgmVkrMMg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=m2Xoh/iuz8S4ETusPqBm+M8sCjAdHVHFljpRaC6yGjGfpiBaE4FGdGK5+e7w3hc+z3hilLM/UuN/Dxinb43UzCc5mTjWKRQ4ugJiPAHgWO9xyT5+213XU+knLS6+nWbLf4mA7Rx0sgWDqF2bu7O4ztodkfWy9b+9RNmPNz8qwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gj5Yf12w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj5Yf12w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767714982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CURtiT1vEb9MQLm7OwN0Og1vpduG1I0ZINayEJgwQSU=;
	b=Gj5Yf12wC2zyyvw8dvxK6fxl0Ga+RafLdpFrUSSRzO/+KOk9KhgsJsEshkvrvyEt/WFHt3
	vVXyaoRTGyDYrJBHl8YqswfE3kX6W0wiDVRwCJPAAlAfclXC0JodUPIwCMCEEtl8qKCAf7
	GYA9bHkfv1zq/594ynqgN9+uIzbglBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-7iwD3ll_Px2a9trUDuMyjw-1; Tue,
 06 Jan 2026 10:56:18 -0500
X-MC-Unique: 7iwD3ll_Px2a9trUDuMyjw-1
X-Mimecast-MFC-AGG-ID: 7iwD3ll_Px2a9trUDuMyjw_1767714976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACAA818002ED;
	Tue,  6 Jan 2026 15:56:15 +0000 (UTC)
Received: from [10.44.33.27] (unknown [10.44.33.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51A0919560AB;
	Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
Date: Tue, 6 Jan 2026 16:56:07 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>, 
    Fengnan Chang <changfengnan@bytedance.com>, Jens Axboe <axboe@kernel.dk>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Frederic Weisbecker <frederic@kernel.org>, 
    Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
    Joel Fernandes <joelagnelf@nvidia.com>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Uladzislau Rezki <urezki@gmail.com>
cc: rcu@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-ID: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
virtual machine when probing a virtio-scsi disk:
[    1.011641] SCSI subsystem initialized
[    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
[    1.015983] scsi host0: Virtio SCSI HBA
[    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
[    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
[    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
[    1.024688] scsi host1: ahci
[    1.025432] scsi host2: ahci
[    1.025966] scsi host3: ahci
[    1.026511] scsi host4: ahci
[    1.028371] scsi host5: ahci
[    1.028918] scsi host6: ahci
[    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
[    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
[    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
[    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
[    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
[    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
[    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
[    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
[    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
[    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
[    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
[    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
[    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
[    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
[   16.483477] sd 0:0:0:0: Power-on or device reset occurred
[   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
[   16.483762] sd 0:0:0:0: [sda] Write Protect is off
[   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk

I bisected it and it is caused by the commit 89e1fb7ceffd which
introduces calls to synchronize_rcu_expedited.

This commit replaces synchronize_rcu_expedited and kfree with a call to 
kfree_rcu_mightsleep, avoiding the 15-second delay.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")

---
 block/blk-mq.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/block/blk-mq.c
===================================================================
--- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
+++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
@@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
 		 * Make sure reading the old queue_hw_ctx from other
 		 * context concurrently won't trigger uaf.
 		 */
-		synchronize_rcu_expedited();
-		kfree(hctxs);
+		kfree_rcu_mightsleep(hctxs);
 		hctxs = new_hctxs;
 	}
 

