Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F37210F5A
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311911; cv=none; b=eVONVvSSxIkSfYYCEA8M43ZurBSkqP3SJIH5A6WXQx0jhm7hH9guwWZG4uMgcarWTEFiiUOxQ55VXUM8mzJUt36AcTeygZmxbNxNnGgb0mF6e5225VF+2TtS8gYnMWiIrbkS9nksKLGfgDSkaoRcnMMwQdx2jfzr8c2vyCrKszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311911; c=relaxed/simple;
	bh=bdStWsgebDCDpXIsIcLRLtVwYMaHWOn2ybqeS5iTUm8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WD8Ce3caD75KK4ESvMZRcxv6Np6DuJlAW8eBQwMWa4txJq4hyKuhmshB8kS8vEmadj3S8Qyy//Exuv6zexn++NzMTKzRngMoUguWPjfnkb38ER2U1G2yqMBgWKsdA06FwkAiTHWU7aZXMzLnFxZTVj1nNDK7NfJOFwxDekDLnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L93Za2Sd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L93Za2Sd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742311905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYQ7FfKQroCOodU41rHpA8TgO41jqwfOEBAbfRTkj38=;
	b=L93Za2Sd2ZX9sLBhfXlZ5s+Nv5uj2r6AeDjgb40Km/3F5lhqbnoexuu6rnR9IsDkRwQ7AK
	xzaelq8YzC5Wpp4Tn3QKBQeiKKNrTZlyH4v9FtsYon0ZeVhIsPwmzLM6M046HOq9pCEJ95
	ZaRxXtp/pPXsnS5KbL49L7xmuub0A3U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-zItq7CKtOn66wc18qvLzHg-1; Tue,
 18 Mar 2025 11:31:43 -0400
X-MC-Unique: zItq7CKtOn66wc18qvLzHg-1
X-Mimecast-MFC-AGG-ID: zItq7CKtOn66wc18qvLzHg_1742311902
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38632180025E;
	Tue, 18 Mar 2025 15:31:42 +0000 (UTC)
Received: from [10.22.82.75] (unknown [10.22.82.75])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F2AD1956094;
	Tue, 18 Mar 2025 15:31:39 +0000 (UTC)
Date: Tue, 18 Mar 2025 16:31:35 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev
Subject: Re: [PATC] block: update queue limits atomically
In-Reply-To: <Z9mJmlhmZwnOlnqT@fedora>
Message-ID: <d5193df0-5944-8cf6-7eb6-26adf191269e@redhat.com>
References: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com> <Z9mJmlhmZwnOlnqT@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Tue, 18 Mar 2025, Ming Lei wrote:

> On Tue, Mar 18, 2025 at 03:26:10PM +0100, Mikulas Patocka wrote:
> > The block limits may be read while they are being modified. The statement
> 
> It is supposed to not be so for IO path, that is why queue is usually down
> or frozen when updating limit.

The limits are read at some points when constructing a bio - for example 
bio_integrity_add_page, bvec_try_merge_hw_page, bio_integrity_map_user.

> For other cases, limit lock can be held for sync the read/write.
> 
> Or you have cases not covered by both queue freeze and limit lock?

For example, device mapper reads the limits of the underlying devices 
without holding any lock (dm_set_device_limits, __process_abnormal_io, 
__max_io_len). It also writes the limits in the I/O path - 
disable_discard, disable_write_zeroes - you couldn't easily lock it here 
because it happens in the interrupt contex.

I'm not sure how many other kernel subsystems do it and whether they could 
all be converted to locking.

> > "q->limits = *lim" is not really atomic. The compiler may turn it into
> > memcpy (clang does).
> > 
> > On x86-64, the kernel uses the "rep movsb" instruction for memcpy - it is
> > optimized on modern CPUs, but it is not atomic, it may be interrupted at
> > any byte boundary - and if it is interrupted, the readers may read
> > garbage.
> > 
> > On sparc64, there's an instruction that zeroes a cache line without
> > reading it from memory. The kernel memcpy implementation uses it (see
> > b3a04ed507bf) to avoid loading the destination buffer from memory. The
> > problem is that if we copy a block of data to q->limits and someone reads
> > it at the same time, the reader may read zeros.
> > 
> > This commit changes it to use WRITE_ONCE, so that individual words are
> > updated atomically.
> 
> It isn't necessary, for this particular problem, it is also fragile to
> provide atomic word update in this low level way, such as, what if
> sizeof(struct queue_limits) isn't 8byte aligned?

struct queue_limits contains two "unsigned long" fields, so it must be 
aligned on "unsigned long" boundary.

In order to make it future-proof, we could use __alignof__(struct 
queue_limits) to determine the size of the update step.

> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> stable often requires bug description.

The bug is that you may read mangled numbers when reading the 
queue_limits.

Mikulas

