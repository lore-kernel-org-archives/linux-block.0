Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475C20DD59
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309808; cv=none; b=Bgde0URCM73ZjvNV8xi0RqRYGiGx0RroW9dWJBSuWtu+jUbp81VFzLVTc2uvNXzlWAhI/KwVF8urtAbAi5d3Nz/c7OAvuB45iu18oXSCUHXpHGAJKwT3vMl6iF80VdwbO3LakircwyJAQUTz55KbBDfCht9oMbYohWlr1Uf80tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309808; c=relaxed/simple;
	bh=sOWU4p5DHg6Fbzp83qLQPUObyHXWU9PThVQOyUyc3dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW11R2iVkDtKLczchAP7tV8ckJkyEFulaBZZmeJmX73JoV7KaNlVTGLsUk8r7xvDC+cwG9i/EdxPf3YYPcNm+IIKziT5rU2EpxVllT9yjq14RCeI0Y8FFJrRcXsHyFG1QSuoE85zJMvTEiAvxnPt7R4PMiPivxoIlnH+qzAKUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jClkoOjp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jClkoOjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742309801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MWVVX2LSuZdqO8+74bvGsn6twEgJqbAt+G3ZbT6EyXs=;
	b=jClkoOjpY/Bpthf+FQZsUjbro6vcdJ2iBx6yW5s3WXeLSeH1/rKkqVOl0/LVyfdLxIxeXZ
	GcnDSw4MP6QoDO93BJrLcGbToj58p7G/Y/JZ9SAwLEJOBFeTaYyw6q3Nf7gm8hhtAjpMLX
	ssTaBYMnyezsXfvoUR31KoYapDB2TUg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-kOwqq8oROkafdOWZKCNzyg-1; Tue,
 18 Mar 2025 10:56:38 -0400
X-MC-Unique: kOwqq8oROkafdOWZKCNzyg-1
X-Mimecast-MFC-AGG-ID: kOwqq8oROkafdOWZKCNzyg_1742309797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3889D1955DCF;
	Tue, 18 Mar 2025 14:56:37 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA4D1800268;
	Tue, 18 Mar 2025 14:56:31 +0000 (UTC)
Date: Tue, 18 Mar 2025 22:56:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATC] block: update queue limits atomically
Message-ID: <Z9mJmlhmZwnOlnqT@fedora>
References: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 18, 2025 at 03:26:10PM +0100, Mikulas Patocka wrote:
> The block limits may be read while they are being modified. The statement

It is supposed to not be so for IO path, that is why queue is usually down
or frozen when updating limit.

For other cases, limit lock can be held for sync the read/write.

Or you have cases not covered by both queue freeze and limit lock?

> "q->limits = *lim" is not really atomic. The compiler may turn it into
> memcpy (clang does).
> 
> On x86-64, the kernel uses the "rep movsb" instruction for memcpy - it is
> optimized on modern CPUs, but it is not atomic, it may be interrupted at
> any byte boundary - and if it is interrupted, the readers may read
> garbage.
> 
> On sparc64, there's an instruction that zeroes a cache line without
> reading it from memory. The kernel memcpy implementation uses it (see
> b3a04ed507bf) to avoid loading the destination buffer from memory. The
> problem is that if we copy a block of data to q->limits and someone reads
> it at the same time, the reader may read zeros.
> 
> This commit changes it to use WRITE_ONCE, so that individual words are
> updated atomically.

It isn't necessary, for this particular problem, it is also fragile to
provide atomic word update in this low level way, such as, what if
sizeof(struct queue_limits) isn't 8byte aligned?

> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

stable often requires bug description.



Thanks,
Ming

