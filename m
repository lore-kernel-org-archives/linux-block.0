Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D616A283FDD
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783705; cv=none; b=PZ9IE6W/YA0OyJdfJPCfh6Ak0R1lru3IgJtNy2k/qrcxDhUq99gVeTnx6uLd/j71zNd+mpotOsP++Uxj0i1rKcI7y63JTgvbsh6p56t6/6Zt8cJ7CX0LfwoV2+S85lu7PkmjTdRtuvLetOH4+cBPG0/xwLyxoGGSKH7z493j0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783705; c=relaxed/simple;
	bh=1etL+6scw9quQ+KtPtj0BPbuo+bh7iGR/cBtgvirTqs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIkfuLjNUbjKlnZkTedUCwlQ1Ebr6UPYDcmno/pGdpG+PuWfDeiOzXk2jOyBvANLTQiWp4AS7V0/zTAiGYutkJcq1D9PGS38woDnwKMmgghG3veQHBd2I7GQM46jp3xTOurW1UPB8psX3f7INieF39ZD1hmZKFvEwpXEg5eY+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM+aGmFJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM+aGmFJ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b7073f61dso668864e87.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767783702; x=1768388502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vH7sVip8YBoc0jyqFGrFID1VITFPoEJ6FVSoKHW8RA=;
        b=bM+aGmFJ+hksrjYPcfR6YOmbfEcTZ77SdhNaGJvRBQxsSD6jbgLv7Hx18aROVI6Mp0
         aqNwR5y39h9VFGFHtnD71GxA/kpRNWZRACjb4UFnMft+MLCzHxr5Pn3HW+6KqQz10jxn
         3lKHBhRNfzn3em22MmFynMMD9UsuMlDQ0oc+GrT8Nmg803jCZdKPEcu7PxZO8HWsKQ7v
         ZSSTrnIor+bC63eGDv2hF22soSKGSL+86xbuRssBYJPUHzBsLT7WFIbh//yt4KjUNuj+
         5dBzoAd14nG8DseSzANCfD/suJy/4VSfhDpcaB7vC6L1uelcr1W9pWbgIj+9KaJWaN0Z
         s9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783702; x=1768388502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vH7sVip8YBoc0jyqFGrFID1VITFPoEJ6FVSoKHW8RA=;
        b=ctPH0ba1xvHrmZGLw9s2wQL/2vVzukYOaXKLVxIIUasco35rqCTZHXY/EltDd/Z34o
         GI7q1CiqsC7EeCD85j1bKPE0+O2QrqYg1KF2ZPzlTocQGnJv1d/rb6jL+O5DSlst3g8i
         4s2bcc6t+pi0nCwde689+SoD3DhmNpjQU5eWRdqeLaPa7rnqCtxKEZP3/ge0qeiAjA4+
         O5JVDv3KkNgmJY90Ec+HIQW5IEO8kcc4CDw3DDYcwIJuFCkMKGsx+rS4kFs+vu68PLVS
         cQ2rUNn0eX06pNTNvFyrVhQRDRzsaPEB7RVkKoV0rxBoKwmrRen+OfthqGAwe00jVbPQ
         hFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAtSeHRen57jBhBsS8nAZD9plPBrP3CCOcIeM+MunOeWqI0IbJ3g83WIWTWoTHhCmwxQUPNYuiTBbG8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1OWbtBtSJOPoqyZqEPCfE0mX1LnceJd3PqS/kd0O6StnSS/8
	/qCIl7X8ucvbXzBavudJceb5/11uAdd1U21Cfgq8ezBZ5T3BWslGuKDK
X-Gm-Gg: AY/fxX4GY856tkiBjZawAQAXobcBy0SZy1u8UbowYVUHm8bN4Be/6IAhyt/nGhifGrH
	RnDPa3cjZs/eDaS+uuBElKzrlzvuoq/u6dHFCdaI/ufmUbalw64PAsBpH3MsxIRpqqTdk948fAE
	nR6pvosXunHulYb76syt+l99ZJUeZD/BRqyEK+tiEsfcBw2TUC4WvNvwM2Tnqa8w8CI7rCBWIqf
	FdYxivt1HqfGIejdNNGPNcrl3rtvm9lbLn3YAA5FxGVx0omkp/EOnv6BCyzDv4bnMjbD+m5tUbc
	hyX598t0O+zzBaenDLds3G8iG1HeiJPORCBmk8WHjf/FeHBQa3L1Ps11f/g1aXescwVmMToLgL9
	j5iggmXAZqZokrqPSUWdgSkDBYF11NQpx4OfbgYa8M/bM08tQgdcz
X-Google-Smtp-Source: AGHT+IGaA2Nx4sS8tB+fh0DIuVKmhBM0sprOcJlqgy094I7FKRtoJJoSZ+dObTTEY2owLZYluuBBgA==
X-Received: by 2002:a05:6512:32ca:b0:592:ee1f:227a with SMTP id 2adb3069b0e04-59b6f04d3fbmr753449e87.43.1767783701201;
        Wed, 07 Jan 2026 03:01:41 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b739a7349sm84043e87.8.2026.01.07.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 03:01:40 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 7 Jan 2026 12:01:38 +0100
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
Message-ID: <aV49En4-qub5af-C@milan>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
 <aV04Vp3nmCg41YZD@pc636>
 <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>

On Tue, Jan 06, 2026 at 05:59:16PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 6 Jan 2026, Uladzislau Rezki wrote:
> 
> > On Tue, Jan 06, 2026 at 04:56:07PM +0100, Mikulas Patocka wrote:
> > > On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> > > virtual machine when probing a virtio-scsi disk:
> > > [    1.011641] SCSI subsystem initialized
> > > [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> > > [    1.015983] scsi host0: Virtio SCSI HBA
> > > [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> > > [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> > > [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> > > [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> > > [    1.024688] scsi host1: ahci
> > > [    1.025432] scsi host2: ahci
> > > [    1.025966] scsi host3: ahci
> > > [    1.026511] scsi host4: ahci
> > > [    1.028371] scsi host5: ahci
> > > [    1.028918] scsi host6: ahci
> > > [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> > > [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> > > [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> > > [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> > > [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> > > [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> > > [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> > > [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> > > [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> > > [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> > > [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> > > [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> > > [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> > > [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> > > [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> > > [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> > > [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> > > [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> > > 
> > > I bisected it and it is caused by the commit 89e1fb7ceffd which
> > > introduces calls to synchronize_rcu_expedited.
> > > 
> > > This commit replaces synchronize_rcu_expedited and kfree with a call to 
> > > kfree_rcu_mightsleep, avoiding the 15-second delay.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> > > 
> > > ---
> > >  block/blk-mq.c |    3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > Index: linux-2.6/block/blk-mq.c
> > > ===================================================================
> > > --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> > > +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> > > @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
> > >  		 * Make sure reading the old queue_hw_ctx from other
> > >  		 * context concurrently won't trigger uaf.
> > >  		 */
> > > -		synchronize_rcu_expedited();
> > > -		kfree(hctxs);
> > > +		kfree_rcu_mightsleep(hctxs);
> > >
> > I agree, doing freeing that way is not optimal. But kfree_rcu_mightsleep()
> > also might not work. It has a fallback, if we can not place an object into
> > "page" due to memory allocation failure, it inlines freeing:
> > 
> > <snip>
> > synchronize_rcu();
> > free().
> > <snip>
> > 
> > Please note, synchronize_rcu() can easily be converted into expedited
> > version. See rcu_gp_is_expedited().
> > 
> > --
> > Uladzislau Rezki
> 
> Would this patch be better? It does GFP_KERNEL allocation which dones't 
> fail in practice.
> 
> > Inlining is a corner case but it can happen. The best way is to add
> > rcu_head to the blk_mq_hw_ctx structure and use kfree_rcu(). It never
> > blocks.
> 
> We are not protecting the blk_mq_hw_ctx structure with RCU, we are 
> protecting the q->queue_hw_ctx array. So, rcu_head cannot be added to an 
> array. We could cast the array to rcu_head (and make sure that the initial 
> allocation is at least sizeof(struct rcu_head)), but that is hacky.
> 
> Mikulas
> 
> ---
>  block/blk-mq.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/block/blk-mq.c
> ===================================================================
> --- linux-2.6.orig/block/blk-mq.c	2026-01-06 15:55:41.000000000 +0100
> +++ linux-2.6/block/blk-mq.c	2026-01-06 16:22:40.000000000 +0100
> @@ -4531,6 +4531,18 @@ static struct blk_mq_hw_ctx *blk_mq_allo
>  	return NULL;
>  }
>  
> +struct rcu_free_hctxs {
> +	struct rcu_head head;
> +	struct blk_mq_hw_ctx **hctxs;
> +};
> +
> +static void rcu_free_hctxs(struct rcu_head *head)
> +{
> +	struct rcu_free_hctxs *r = container_of(head, struct rcu_free_hctxs, head);
> +	kfree(r->hctxs);
> +	kfree(r);
> +}
> +
>  static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> @@ -4539,6 +4551,7 @@ static void __blk_mq_realloc_hw_ctxs(str
>  
>  	if (q->nr_hw_queues < set->nr_hw_queues) {
>  		struct blk_mq_hw_ctx **new_hctxs;
> +		struct rcu_free_hctxs *r;
>  
>  		new_hctxs = kcalloc_node(set->nr_hw_queues,
>  				       sizeof(*new_hctxs), GFP_KERNEL,
> @@ -4553,8 +4566,14 @@ static void __blk_mq_realloc_hw_ctxs(str
>  		 * Make sure reading the old queue_hw_ctx from other
>  		 * context concurrently won't trigger uaf.
>  		 */
> -		synchronize_rcu_expedited();
> -		kfree(hctxs);
> +		r = kmalloc(sizeof(struct rcu_free_hctxs), GFP_KERNEL);
> +		if (!r) {
> +			synchronize_rcu_expedited();
> +			kfree(hctxs);
> +		} else {
> +			r->hctxs = hctxs;
> +			call_rcu(&r->head, rcu_free_hctxs);
> +		}
>  		hctxs = new_hctxs;
>  	}
>  
> > 
> 
I see. That will work but this looks like a temporary fix. It would be
great to understand why synchronize_rcu_expedited() is blocked for so long.
16 seconds is a way too long.

Is that easy to reproduce?

--
Uladzislau Rezki
