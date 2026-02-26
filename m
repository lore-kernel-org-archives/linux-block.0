Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F229AB15
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114681; cv=none; b=t+Dg7uknXDuvFdhnCWNQna8Nwh5WIjY2Ujo7M4dx5HEP7a7xdLr5CR+X2ec8PUxPI4Ehe4Nv10jxJXXDMvEnu/+2D+5StS79ZQiS6tDWxYom4mh1KReOvpG7eld/+Do7QBLQVzd9B4dLx+h7rmVyeYibHm0gB2mm8ypP3T3Brfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114681; c=relaxed/simple;
	bh=ZPrfuNnO1n8ODYByKlvzs1rczBFGZ/IjALAS+Uul6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAWLncdna0w5j/Pj7OjNYLDBt6WGf4HOS+R3WGYXlMJ7so/0UlTgvlB+sqpCBEq6fGQFgI7hEPyEwtgLKs4UZ5xZB6//w/BY1QV+LdMKT9VheRHV6WILuuDonOlTFCodXr1HkQR6O+6CFYX1/qsUDpJTnupCTWUnS7fHoA60IqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+OCF7di; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+OCF7di"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772114679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGVLntgS7y17jrtUPVq3eOV3I3Dp+Pz66Cj+hxDGxis=;
	b=h+OCF7diVnx4f/p57mBWrIoYK8cLcBhSsXB8U6eO7AeppRzhC+NqNucEeV7pJXx87idIxE
	np+PgawXiBeNM3rqelVvVlCcAHwP+sFhM1Dt5skphyh9HDu8AAKNfWSYQaAhpTt/qeQWQm
	40W7/zWNl5jGdsEL76J8DdKLHTMSSPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-cd0trrkZNFKZDEH-N7NXbA-1; Thu,
 26 Feb 2026 09:04:37 -0500
X-MC-Unique: cd0trrkZNFKZDEH-N7NXbA-1
X-Mimecast-MFC-AGG-ID: cd0trrkZNFKZDEH-N7NXbA_1772114675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED52D1956079;
	Thu, 26 Feb 2026 14:04:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EE591956053;
	Thu, 26 Feb 2026 14:04:25 +0000 (UTC)
Date: Thu, 26 Feb 2026 22:04:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu
 hotplug lock in group_cpus_evenly"
Message-ID: <aaBS4pvtiFHL1LSz@fedora>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Feb 26, 2026 at 02:40:37PM +0100, Daniel Wagner wrote:
> This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.
> 
> The reason the lock was removed was that the nvme-pci driver reset
> handler attempted to acquire the CPU read lock during CPU hotplug
> offlining (holds the CPU write lock). Consequently, the block layer
> offline notifier callback could not progress because in-flight requests
> were detected.
> 
> Since then, in-flight detection has been improved, and the nvme-pci
> driver now explicitly updates the hctx state when it is safe to ignore
> detected in-flight requests. As a result, it's possible to reintroduce
> the CPU read lock in group_cpus_evenly.

Can you explain your motivation a bit? Especially adding back the lock
causes the API hard to use. Any benefit?


Thanks, 
Ming

