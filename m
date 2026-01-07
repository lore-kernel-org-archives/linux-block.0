Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E926318138
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788556; cv=none; b=gzgVwoZTe7sbnmp1hMBwEETCaWREF7dhLeR81g8MCmgltO1YdeF4dci/kf7MMfy5Z+uHKjT2X5XM7ZCHoeMjRAJPe8ersDaIiKfNPGrBIBW3Zx/tVOklYmNyFmMNNRTVq5Dbak/8PmHSx5wAxe1Ke6ExBR6krFbUojUlw0xTyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788556; c=relaxed/simple;
	bh=eGGfN0liByXS39EQKEjIU++P9IZz4I37rP4lLELN3Bk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR8/hCxJvsRjTR0nLjuSSxUbkqQJjZNVc548/E72oWF+BVYp/r7NwaksjYsU1vOjjFbDz/05jGSgVLZ5UOeZhcwmkgDxnqvhlVafGe9Ic5VOyvnrTwPUe316oB/BsN2M5XS5lhQnD8Gk7A8X4Xl433Em7Ksv6LMTWAb35UqU/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay742aWo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay742aWo"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b25acdffbso1743091e87.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788553; x=1768393353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXHS+KKjz4hyBITZ2kjUBgPM0nCaj+r59CK7A6HLgAs=;
        b=ay742aWoK3R/x1MrHz8XiLoQ+ef+GYKLvAgqx+fuDEO0iNdHNl5mS0hE1X2mOWLRzL
         FxmTa2/OkM4fRQVWIHUpp0nFtci2lEXjtxjHszrx+l6TOacjO74ytAjvTSMM0mzksn57
         9vvKWep/sY0CYvIwnA8x/gOx3Mtps7sXCjNDTZDwLmYUAzHezm454+xDFRz4f/SUoGCp
         +bupfOWxBsVZZZ0/+INT20HTRlb3cWB+xLBMFfSTxB9+aYUl5xomulPxkjJQEyWHMPLz
         h8q/ZEbZ00t9ZNo6F/KL27DIV7sUHoYs/6qOtDbMngkz0N78JC4We+3giPBvEu5444cB
         7RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788553; x=1768393353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXHS+KKjz4hyBITZ2kjUBgPM0nCaj+r59CK7A6HLgAs=;
        b=jkanK3eRyi5IwsPwhSqBpaFCzPELGA7MEVqC3Zg/ackmGRmiCAAabcN1kp4AA8ZNU4
         grSZgGDXlhTA0LtV9vwW3D62B2F17tn2fohTxbzyNkJVMmDn6a/fHfXVZGTAlu6KMZr+
         vySExN3ncGi8QjY7VHqEQMewCgZNQVh65eWHZeNsxLPRcxQrkzhg1xghYP/W8cj2Bhi+
         +ZxcrfKHqc0BuYNRMQzuo5+xBGzCI4bmK72dCwc8wjtNirwHKBvVnDp9a0cLMrvaGM/0
         1OKQMSLjEu7XOgUcFJk+dtwOc524eTvi7pai+ZpWvAdylRCpxLYYPmBWEQLC2+kOCADQ
         Hy8g==
X-Forwarded-Encrypted: i=1; AJvYcCWZOLFbTD5rag7nMJ4Iyih0PoQHdUtSi2ZmpY4TR1z+4Jhm9Lq2jeuNeDE+4h1NZ3hoL3xcsQ6GScsbfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQXJZ8q8pdB29qGreXVUDyIlYzTuZGwLotSOax1iO4RCXet1t
	FET2OO3VlDjXWtB57NkJ8wetGY1GvVzAoIhG/WssRRPyxpfn4jfemwwm
X-Gm-Gg: AY/fxX4JlqOFDpKrZCZTgBWyPXwv/lSJq5SwoUEPG0QPwKZjCNIsESgMjdm/PvljOBk
	a0YP2EbiueMIy6O5caeIcf5xwT8oMsG6CdKNrwGZlgbIL/zhRIQXDIzB8jXZRUApYticxRmxFtk
	tYkW9JTj7a4gY9VbcfWKIv79orhWk9u57pSyjh+UIYcmQ92Kk3iXouWtWtCau0GwVdKSQRtGnNh
	6vXpvwgpE73jD2riwW07natOHuIpvCmoq5qD/4tTeGmIc214PeJWDGOk7lRteHN3KrRn4XfbTCJ
	M4RwNrw6d/wCQ/N75TYJNLSBYNKSGgWLduZayStC9H4Ffj6Zq5L0e2jdeuDW6VgT0Iz1Sl2bYan
	US0eMhuWK5IirnFWdi5z0wp13vroNj6AJKy9kC+c3gpa6bS3r4Lq1
X-Google-Smtp-Source: AGHT+IHvP9wqjJwz6tGXGf7/fvFUZ+hOMwyV34shhKNw6reb41E6gDD9qU++oNv52n2PLpRvDUFTBw==
X-Received: by 2002:a05:6512:2205:b0:598:eb4e:2aba with SMTP id 2adb3069b0e04-59b6f02d0ffmr673407e87.30.1767788552329;
        Wed, 07 Jan 2026 04:22:32 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6ae8a169sm916816e87.24.2026.01.07.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:31 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 7 Jan 2026 13:22:30 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Fengnan Chang <fengnanchang@gmail.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-ID: <aV5QBv02mcAkzCL7@milan>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
 <aV04Vp3nmCg41YZD@pc636>
 <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>
 <aV49En4-qub5af-C@milan>
 <7f873eba-7f74-6e74-10c8-dfc178cc2a72@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f873eba-7f74-6e74-10c8-dfc178cc2a72@redhat.com>

On Wed, Jan 07, 2026 at 01:05:14PM +0100, Mikulas Patocka wrote:
> 
> 
> On Wed, 7 Jan 2026, Uladzislau Rezki wrote:
> 
> > On Tue, Jan 06, 2026 at 05:59:16PM +0100, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Tue, 6 Jan 2026, Uladzislau Rezki wrote:
> > > 
> > > > On Tue, Jan 06, 2026 at 04:56:07PM +0100, Mikulas Patocka wrote:
> > > > > On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> > > > > virtual machine when probing a virtio-scsi disk:
> > > > > [    1.011641] SCSI subsystem initialized
> > > > > [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> > > > > [    1.015983] scsi host0: Virtio SCSI HBA
> > > > > [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> > > > > [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> > > > > [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> > > > > [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> > > > > [    1.024688] scsi host1: ahci
> > > > > [    1.025432] scsi host2: ahci
> > > > > [    1.025966] scsi host3: ahci
> > > > > [    1.026511] scsi host4: ahci
> > > > > [    1.028371] scsi host5: ahci
> > > > > [    1.028918] scsi host6: ahci
> > > > > [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> > > > > [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> > > > > [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> > > > > [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> > > > > [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> > > > > [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> > > > > [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> > > > > [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> > > > > [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> > > > > [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> > > > > [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> > > > > [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> > > > > [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > > > [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> > > > > 
> > > > > I bisected it and it is caused by the commit 89e1fb7ceffd which
> > > > > introduces calls to synchronize_rcu_expedited.
> > > > > 
> > > > > This commit replaces synchronize_rcu_expedited and kfree with a call to 
> > > > > kfree_rcu_mightsleep, avoiding the 15-second delay.
> > > > > 
> > > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > > Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> > > > > 
> > > > > ---
> > > > >  block/blk-mq.c |    3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > Index: linux-2.6/block/blk-mq.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> > > > > +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> > > > > @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
> > > > >  		 * Make sure reading the old queue_hw_ctx from other
> > > > >  		 * context concurrently won't trigger uaf.
> > > > >  		 */
> > > > > -		synchronize_rcu_expedited();
> > > > > -		kfree(hctxs);
> > > > > +		kfree_rcu_mightsleep(hctxs);
> > > > >
> > > > I agree, doing freeing that way is not optimal. But kfree_rcu_mightsleep()
> > > > also might not work. It has a fallback, if we can not place an object into
> > > > "page" due to memory allocation failure, it inlines freeing:
> > > > 
> > > > <snip>
> > > > synchronize_rcu();
> > > > free().
> > > > <snip>
> > > > 
> > > > Please note, synchronize_rcu() can easily be converted into expedited
> > > > version. See rcu_gp_is_expedited().
> > > > 
> > > > --
> > > > Uladzislau Rezki
> > > 
> > > Would this patch be better? It does GFP_KERNEL allocation which dones't 
> > > fail in practice.
> > > 
> > > > Inlining is a corner case but it can happen. The best way is to add
> > > > rcu_head to the blk_mq_hw_ctx structure and use kfree_rcu(). It never
> > > > blocks.
> > > 
> > > We are not protecting the blk_mq_hw_ctx structure with RCU, we are 
> > > protecting the q->queue_hw_ctx array. So, rcu_head cannot be added to an 
> > > array. We could cast the array to rcu_head (and make sure that the initial 
> > > allocation is at least sizeof(struct rcu_head)), but that is hacky.
> > > 
> > > Mikulas
> > > 
> > > ---
> > >  block/blk-mq.c |   23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > 
> > > Index: linux-2.6/block/blk-mq.c
> > > ===================================================================
> > > --- linux-2.6.orig/block/blk-mq.c	2026-01-06 15:55:41.000000000 +0100
> > > +++ linux-2.6/block/blk-mq.c	2026-01-06 16:22:40.000000000 +0100
> > > @@ -4531,6 +4531,18 @@ static struct blk_mq_hw_ctx *blk_mq_allo
> > >  	return NULL;
> > >  }
> > >  
> > > +struct rcu_free_hctxs {
> > > +	struct rcu_head head;
> > > +	struct blk_mq_hw_ctx **hctxs;
> > > +};
> > > +
> > > +static void rcu_free_hctxs(struct rcu_head *head)
> > > +{
> > > +	struct rcu_free_hctxs *r = container_of(head, struct rcu_free_hctxs, head);
> > > +	kfree(r->hctxs);
> > > +	kfree(r);
> > > +}
> > > +
> > >  static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > >  				     struct request_queue *q)
> > >  {
> > > @@ -4539,6 +4551,7 @@ static void __blk_mq_realloc_hw_ctxs(str
> > >  
> > >  	if (q->nr_hw_queues < set->nr_hw_queues) {
> > >  		struct blk_mq_hw_ctx **new_hctxs;
> > > +		struct rcu_free_hctxs *r;
> > >  
> > >  		new_hctxs = kcalloc_node(set->nr_hw_queues,
> > >  				       sizeof(*new_hctxs), GFP_KERNEL,
> > > @@ -4553,8 +4566,14 @@ static void __blk_mq_realloc_hw_ctxs(str
> > >  		 * Make sure reading the old queue_hw_ctx from other
> > >  		 * context concurrently won't trigger uaf.
> > >  		 */
> > > -		synchronize_rcu_expedited();
> > > -		kfree(hctxs);
> > > +		r = kmalloc(sizeof(struct rcu_free_hctxs), GFP_KERNEL);
> > > +		if (!r) {
> > > +			synchronize_rcu_expedited();
> > > +			kfree(hctxs);
> > > +		} else {
> > > +			r->hctxs = hctxs;
> > > +			call_rcu(&r->head, rcu_free_hctxs);
> > > +		}
> > >  		hctxs = new_hctxs;
> > >  	}
> > >  
> > > > 
> > > 
> > I see. That will work but this looks like a temporary fix. It would be
> > great to understand why synchronize_rcu_expedited() is blocked for so long.
> > 16 seconds is a way too long.
> 
> synchronize_rcu_expedited is called 257 times from the block layer. One 
> call is approximately 50ms.
> 
OK. I thought the _one_ call of synchronize_rcu_expedited() was stuck for
~15 seconds. Whereas you just have many of them.

Therefore you can easily just go back to your original patch and use
kfree_rcu_mightsleep(hctxs)!

--
Uladzislau Rezki
