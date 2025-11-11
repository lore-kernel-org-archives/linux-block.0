Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9013043CB
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830093; cv=none; b=UU968VQEMH5DhRAmeeb5uDCCPHmxrNABpNk6nAwUF2KZ13VC13DLS3/dDrdUGQWd9L4GNRB0mXoFew4o2W9t8pBya2RJocxXzpYwbzfdDEmMTloFUViu1AbTAJesBpCsSr6lcRuPG8Mc/azH0GELHijoKD133Be/2dFGiGJk0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830093; c=relaxed/simple;
	bh=LnA5bsHjo2tnnb1tdWOWI9jyUL/03htGcYNWN2vstUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmeZrrKJhS1ehLstIEkyyLo9PgAyslwv7hDKe0flnzZWUQU4J4Uq8vHjVqn21q+sPhzZ1ADXL6wXgCnUvGpxPUIfu5B910JPlUkGgLmowSiQPSeq3d0VCi6PVArBkzhXiAb1+PiVCFmcYjexRKc39P6EF0OQGm4eWRKLkghOej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4swBX90; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4swBX90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762830090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1tlbi2iy+yp8IsNdh+8aD/aU7rzPyNJEHyuvK8B+Y4=;
	b=B4swBX90Fy4Hpk5Sf5BtKCzAJ6w3mJRiqt3VfaM6OPB0CNUHOEOJUd2FWLEwx9s3++Ynod
	pLKNmRLe7wsbZ5gdpgxMVn+RxlnGOZJIzBkuMc4ADCm8zKqaZosjYdnFKDt0OsvyEJ9iK8
	SHlyEkwNyUtjtBK0vGEiL32I5G+EjbY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-OSHfTofxNw2jn3-dCbK3RA-1; Mon,
 10 Nov 2025 22:01:27 -0500
X-MC-Unique: OSHfTofxNw2jn3-dCbK3RA-1
X-Mimecast-MFC-AGG-ID: OSHfTofxNw2jn3-dCbK3RA_1762830085
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9509D19560B2;
	Tue, 11 Nov 2025 03:01:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41D8C30044E0;
	Tue, 11 Nov 2025 03:01:18 +0000 (UTC)
Date: Tue, 11 Nov 2025 11:01:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv4 5/5] block: define alloc_sched_data and free_sched_data
 methods for kyber
Message-ID: <aRKm-qGucFuHoGtE@fedora>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-6-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110081457.1006206-6-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Nov 10, 2025 at 01:44:52PM +0530, Nilay Shroff wrote:
> Currently, the Kyber elevator allocates its private data dynamically in
> ->init_sched and frees it in ->exit_sched. However, since ->init_sched
> is invoked during elevator switch after acquiring both ->freeze_lock and
> ->elevator_lock, it may trigger the lockdep splat [1] due to dependency
> on pcpu_alloc_mutex.
> 
> To resolve this, move the elevator data allocation and deallocation
> logic from ->init_sched and ->exit_sched into the newly introduced
> ->alloc_sched_data and ->free_sched_data methods. These callbacks are
> invoked before acquiring ->freeze_lock and ->elevator_lock, ensuring
> that memory allocation happens safely without introducing additional
> locking dependencies.
> 
> This change breaks the dependency chain involving pcpu_alloc_mutex and
> prevents the reported lockdep warning.
> 
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
> 
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

