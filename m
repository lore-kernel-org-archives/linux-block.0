Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81DAD5E
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882914; cv=none; b=gW/bEc0VpSQZ19qMmgHMZG/EFvXXeluEmF4lDHBL8MfsJjb5lYJggJ8VueKqP3ZxmkYD57SscUbgWcHhOyWrminQsjP3pJiJU2NJ07DJgQC2IDzGXTFJtDYlLPfiUJ6ueYtW+NunwmCTE0GrEFC0e2DA0Gw0d2cysztZbNTwkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882914; c=relaxed/simple;
	bh=CkAzU1+9DFLlLdS1VO1VcMi/LXavTqiDt8MpDvSizCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XY4gnTfDi6FOoqH4mIGJeh1H2K9py2z0U9rFu7MUFVfAx9D269E7HLpwticOO70mor+hhu99k4SBs6Mx/7//PwJf+eFXrRPcKYT1AUdF+3AIekRhSggeqqm14hiOzXiGgAWGlWHDJpM9mci+YbrsAEBbhiXaCpeRHnw3q6qdFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwqZJzr2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwqZJzr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741882908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BJD/2p9RWVFLV6Cz1T+irkrY0gl9LEh5vyb9izaK40=;
	b=LwqZJzr2eAWIMB9iEA9BwfZgaj1owwxg5dol/hEuywKDAWe46rjhXuPXUxVEs28Dk/nDl4
	iMydWmHXP6Dzfw/3fj7bvKoNg5C8O68fnQpJcIw2sHMgK8JSp2WzqND6PmmpHBlpq7nG99
	OE2NDTNQpALkHiVtsYc7ID8gpvLr5mE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-LGXzGZkLPSykuHXLWxa3rQ-1; Thu,
 13 Mar 2025 12:21:45 -0400
X-MC-Unique: LGXzGZkLPSykuHXLWxa3rQ-1
X-Mimecast-MFC-AGG-ID: LGXzGZkLPSykuHXLWxa3rQ_1741882903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA2CD1955DCD;
	Thu, 13 Mar 2025 16:21:42 +0000 (UTC)
Received: from [10.22.82.75] (unknown [10.22.82.75])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 786A618001D4;
	Thu, 13 Mar 2025 16:21:39 +0000 (UTC)
Date: Thu, 13 Mar 2025 17:21:36 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Kent Overstreet <kent.overstreet@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
    Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, 
    zkabelac@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z9GYGyjJcXLvtDfv@infradead.org>
Message-ID: <e92833a3-c262-d7f5-9034-2a803e27dae7@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org> <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com> <Z8XlvU0o3C5hAAaM@infradead.org> <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com> <Z8cE_4KSKHe5-J3e@infradead.org>
 <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb> <Z9GYGyjJcXLvtDfv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> IS_SWAPFILE isn't going way, as can't allow other writers to it.
> Also asides from the that the layouts are fairly complex.
> 
> The right way ahead for swap is to literally just treat it as a slightly
> special case of direct I/o that is allowed to IS_SWAPFILE files.  We
> can safely do writeback to file backed folios under memory pressure,
> so we can also go through the normal file system path.

But that is prone to low-memory-deadlock because the filesystems allocate 
buffer memory when they are mapping logical blocks to physical blocks. You 
would need to have a mempool in the filesystems, so that they can make 
forward progress even if there is no memory free - and that would 
complicate them.

GFP_NOIO won't help if the memory is completely exhausted. Only mempool 
would help in this situation.

Mikulas

