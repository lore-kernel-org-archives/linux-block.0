Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA71F2BAE
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663240; cv=none; b=lbYQk+jw04wbNWyf6YEc7OakqjMuIlN/jm3lTKsR82YLTr1c6pzC1bDdtjM0lkZka4tY2KSwA7Ln3yHnXBfqqbgApaFFjrjPCqm3ZIpv1CVbzzx+UqHiYHhdFtObu95KYtKtorJ/0UR0/Mei2Lgaqj0tuvDynSrAtRqRaIVPi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663240; c=relaxed/simple;
	bh=urHR22ntLAVIohHFj8KD/WJUVMre7/Xkcuud53NaFeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHHCWLl+bEaI7Xi+YXqoOuswS1NkqFZU82vlccBlszaPxjcPPJRe6uH1Cc27hhJLFgYgMHnMzg4yXTZ2/jSo6tkeaGEEgSNAHYMIqn5cq/X8h4GqBdeEfu/RkaN+rkRbDADojgpvTJDkh5XsVECZAgP56YRLUzayvLP1ZlHA6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnonNwfs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnonNwfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750663237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pG5XywEL0gWDW1+DX/PnV1EkgEnI9aoLGUGB9yGzfsE=;
	b=hnonNwfssUQa7x5XvQ+Grt7UlWSwb1rOM8ejUQwNgz9ILtybxlYr8SNnEXJ4sAHTv/CFHR
	W098N9n3wUaBluCFOsyj+iykjombWsZfT3OSYaAluRtOtSNsW55twOn+mXfDOAL/R4OVkz
	HhXkZZmvM7LIoCU7bmSYd/qullAhz/c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-RXGAWKvdNd61HiIQPmXfyQ-1; Mon,
 23 Jun 2025 03:20:33 -0400
X-MC-Unique: RXGAWKvdNd61HiIQPmXfyQ-1
X-Mimecast-MFC-AGG-ID: RXGAWKvdNd61HiIQPmXfyQ_1750663232
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F645195608E;
	Mon, 23 Jun 2025 07:20:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 881D819560A3;
	Mon, 23 Jun 2025 07:20:29 +0000 (UTC)
Date: Mon, 23 Jun 2025 15:20:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/14] ublk: use vmalloc for ublk_device's __queues
Message-ID: <aFkANyA-QeaXXTbH@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 20, 2025 at 09:09:55AM -0600, Caleb Sander Mateos wrote:
> struct ublk_device's __queues points to an allocation with up to
> UBLK_MAX_NR_QUEUES (4096) queues, each of which have:
> - struct ublk_queue (48 bytes)
> - Tail array of up to UBLK_MAX_QUEUE_DEPTH (4096) struct ublk_io's,
>   32 bytes each
> This means the full allocation can exceed 512 MB, which may well be
> impossible to service with contiguous physical pages. Switch to
> kvcalloc() and kvfree(), since there is no need for physically
> contiguous memory.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

