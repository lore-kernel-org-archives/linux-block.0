Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19C11185
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705647; cv=none; b=fvX7qn08XXtc1yNXOLg8Ak8DW8/sdY8sj5mHLN27l8Tf2V0uG2jabLt8bQMvJ4SBKIsAZJeOZR7DBfNXThSL3rHhja1RJgD4SHoaK8sfiN92qxbEXpIQYYiWxH8liRIgZNSFC2FN/FnFjofJ6vgApNfeuRKzmOHLgKNt+Snuy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705647; c=relaxed/simple;
	bh=ZrLiNAhLQoPW7EeuMLn4G89OvAWWigl8ItlcJ7eDGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgsGrcdgJR9WEdJwi+Y5RwqTc1V5eGOFRgQ5uhGuyy5dgxG3lxIIrE1/8eATH9lP2Z5p5XFOM7p4xI00TOR4Z3CWSZO6ZwSI4JODqJaZ53KZZ5iKx/15Oq33aDGVd3RkCWJ/XwGno9O4ptlsxhWeZ+nw8COg3aebJuEXzPAFJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ic/lz+de; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ic/lz+de"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728705644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai4NDu7q5UomWSSO6uV8oCCRRqhHkvT0GmePFYViccc=;
	b=Ic/lz+derja6jJdaALEhrcxmjVn13uIRY5oH+7lR4ngAcDlj6fIvVoe2z6igX4a2tSlupa
	sH8d7pQAeI0FhNRlQyJIJsoBfruMfgJj+X58vfT4icAJ5cD2c4RtElsR0wm1zV64CdZOuL
	EdcEbSa5v4fsKTsqzOZs5p0EI1vFOvs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-Z9M16H6mM2GEzoNgEAa6nA-1; Sat,
 12 Oct 2024 00:00:42 -0400
X-MC-Unique: Z9M16H6mM2GEzoNgEAa6nA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D1E195608B;
	Sat, 12 Oct 2024 04:00:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 474B730001A5;
	Sat, 12 Oct 2024 04:00:37 +0000 (UTC)
Date: Sat, 12 Oct 2024 12:00:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Rick Koch <mr.rickkoch@gmail.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: Kernel Oops in blk_mq_hctx_notify_online() using Raxda CM5
Message-ID: <Zwn0X5EUOT6g5lg_@fedora>
References: <CANa58eeNDozLaBHKPLxSAhEy__FPfJT_F71W=sEQw49UCrC9PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANa58eeNDozLaBHKPLxSAhEy__FPfJT_F71W=sEQw49UCrC9PQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Rick,

On Fri, Oct 11, 2024 at 03:17:43PM -0400, Rick Koch wrote:
> Hello linux-block,
> 
> I have been working with a fellow Ham Radio operator, Martin CT1IQI, on an
> upgrade
> to an open source SDR radio. The upgrade will replace a pi CM4 with a Raxda
> CM5.
> https://apache-labs.com/al-products/1061/ANAN-G2-Ultra-HF--6M-100W-Ultra-High-Performance-SDR.html
> 
> We are progressing very well with that project but have come across an
> intermittent
> issue that we are hoping you may provide some clues on how to fix.
> 
> We are using kernel version 6.11.1 under an Armbian OS. This issue doesn't
> happen
> on the Armbian 6.1.75 branch but will happen without any of our changes to
> 6.11.1.
> I have also tested with 6.11.3 and found the same problem.
> 
> This issue is a kernel Oops that happens randomly early in boot. Probably 1
> out of 10
> boots. It will hang if the issue happens.
> 
> I wonder if you may have any ideas about it? I have attached a dmesg but it
> is the dmesg from
> after a successful boot as I don't know how to get the dmesg when the Oops
> happens as the
> board is locked up. If there are other methods to get more info to you
> please let me know.
> 
> Misc info:
> root@saturn-radxa-cm5-8inch:~# lspci
> 0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
> 
> Radxa CM5 Compute Module attached to a piCM4-IO board
> 
> Samsung KLMCG2UCTB 16GB onboard eMMC
> 
> Kernel version 6.11.1
> 
> This is the Oops:
> 
> 
> [    1.515476] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    1.516043] Modules linked in:
> [    1.516326] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted
> 6.11.1-edge-rockchip-rk3588 #1
> [    1.517063] Hardware name: Radxa CM5 Saturn SDR (DT)
> [    1.517506] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.518128] pc : blk_mq_hctx_notify_online+0x34/0xb0

Can you test the following patch first?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..2ea6edff56d4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4310,6 +4310,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	q->tag_set = set;
+
 	if (blk_mq_alloc_ctxs(q))
 		goto err_exit;
 
@@ -4328,8 +4330,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->tag_set = set;
-
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);


If the above patch doesn't work, please figure out the above pc points to which
line of source code by:

$gdb vmlinux
gdb>l *(blk_mq_hctx_notify_online+0x34)


Thanks, 
Ming

