Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541320B80D
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511228; cv=none; b=t0VajifktSGx+ugxSl0WeSGq7enR1/4Rf0od0hWOVZE8UzWJcSHjDuJw+7q7w3et66PFzrQT4h6SVF5dbxDUN3o3Q2ia5GYZSTgeg1OOFH5uVtGjRkGRNsbhd9tVgdCl+LfYv4DCmyeD2KDv2B9ADguYEk8t4xJGPDcShdq6FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511228; c=relaxed/simple;
	bh=zdwubspvnWsyvcJX0bsEo6CStdv8yryXQ60DGocX4rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Oq3vnyJTvpV4HLU6Dj8nIar+glpdOdfm6M9ce3jxUQXdP7yp+ixWEq8w1tpekcrdPERKsacMuHfBeOnzcKBKJaYjrALYnlx1wE2DZmSXF3+Qa5BTODfzB0NBEuz8LjgAYIp0L2LaG3Irilckvht9e8qr5PDdWHuqayW+t20m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRaU2TH4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRaU2TH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736511225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26fUd6BcmPg4OW4DS/radkncv/Rrtu39G7uO+wMXhzY=;
	b=JRaU2TH4LJZGBPHk6pu6/ykrhAwmySaQSljE9SSwBWr4PqoT0UZC9JcnaLrvvQUm3xpABw
	GqK50QBYqEX8YjNoqprruNp2lOo/VMUZxTlBxF9SGqc/WZnkQG2j+XRW9Q3pJHKmd4rBd8
	EsMHQy0eWn56cvlsKm0LXt+bmXUL62Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-8Kris34rOeqp3lhK0LF17A-1; Fri,
 10 Jan 2025 07:13:40 -0500
X-MC-Unique: 8Kris34rOeqp3lhK0LF17A-1
X-Mimecast-MFC-AGG-ID: 8Kris34rOeqp3lhK0LF17A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25AE51956051;
	Fri, 10 Jan 2025 12:13:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EC6B19560AD;
	Fri, 10 Jan 2025 12:13:34 +0000 (UTC)
Date: Fri, 10 Jan 2025 20:13:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <Z4EO6YMM__e6nLNr@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jan 10, 2025 at 11:12:58AM +0100, Thomas Hellström wrote:
> Ming, Others
> 
> On 6.13-rc6 I'm seeing a couple of lockdep splats which appear
> introduced by the commit
> 
> f1be1788a32e ("block: model freeze & enter queue as lock for supporting
> lockdep")

The freeze lock connects all kinds of sub-system locks, that is why
we see lots of warnings after the commit is merged.

...

> #1
> [  399.006581] ======================================================
> [  399.006756] WARNING: possible circular locking dependency detected
> [  399.006767] 6.12.0-rc4+ #1 Tainted: G     U           N
> [  399.006776] ------------------------------------------------------
> [  399.006801] kswapd0/116 is trying to acquire lock:
> [  399.006810] ffff9a67a1284a28 (&q->q_usage_counter(io)){++++}-{0:0},
> at: __submit_bio+0xf0/0x1c0
> [  399.006845] 
>                but task is already holding lock:
> [  399.006856] ffffffff8a65bf00 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0xe2/0xa20
> [  399.006874] 

The above one is solved in for-6.14/block of block tree:

	block: track queue dying state automatically for modeling queue freeze lockdep

> 
> #2:
> [   81.960829] ======================================================
> [   81.961010] WARNING: possible circular locking dependency detected
> [   81.961048] 6.12.0-rc4+ #3 Tainted: G     U            

...

>                -> #3 (&q->limits_lock){+.+.}-{4:4}:
> [   81.967815]        __mutex_lock+0xad/0xb80
> [   81.968133]        nvme_update_ns_info_block+0x128/0x870 [nvme_core]
> [   81.968456]        nvme_update_ns_info+0x41/0x220 [nvme_core]
> [   81.968774]        nvme_alloc_ns+0x8a6/0xb50 [nvme_core]
> [   81.969090]        nvme_scan_ns+0x251/0x330 [nvme_core]
> [   81.969401]        async_run_entry_fn+0x31/0x130
> [   81.969703]        process_one_work+0x21a/0x590
> [   81.970004]        worker_thread+0x1c3/0x3b0
> [   81.970302]        kthread+0xd2/0x100
> [   81.970603]        ret_from_fork+0x31/0x50
> [   81.970901]        ret_from_fork_asm+0x1a/0x30
> [   81.971195] 
>                -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:

The above dependency is killed by Christoph's patch.


Thanks,
Ming

