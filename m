Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9032FA2C
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117091; cv=none; b=rEZCMo+Q/48815S/vaackXe7SyS26sPGrD61c9fwwFS3uX8oLkSh7NI88+1zysY5pxArJDfxGIq1thuPxbMsSzzg9R89onO/xuXwuNRi4aCdCrHT7XmxcRh2H2jA0V5BXrcEx+jHyraXaEGGG7IyfmjHoYy2+d3F/JUgF7cDeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117091; c=relaxed/simple;
	bh=JDwzG10CjdMNzaVAVuClyAr1f5kyfccGkv+CaOIDDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+DSQh9Blnfk6XG+oyBdAcRSS2kay0OuSJTMgbHakDOn7deIKJWHec2hGqqkFByM5YWTMwFXNwxQk+6eent3YALTqirZlV8MVWHnTd5ivJrEyiKrW6/agX7nfm0Gs/cCUHalKdmfHR0xLqaUA4WQpZQyBAalhupqmgZDjKl4SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g01UL2Gh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g01UL2Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770117088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIueVBBCXcriHzWqfI+eCbpC9/+UTkWA0vibOjUyafk=;
	b=g01UL2GhXwrN28L0tI5Ruq+W3ryA9UllLtAnVTnciTuxhBO0bd1OWn371eY6lCupEEgJ4p
	4+AeahvBlG9s1KpOw6gxt0UGfSO4x1lR2bIfMQCd578/yGs5F+kyJcyKlQAG79WJGTPo7U
	5bJPn/rDTicu4WwflATJE+UjTOocYGA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-qQvQUZrJMKSyWnjugSNfKA-1; Tue,
 03 Feb 2026 06:11:25 -0500
X-MC-Unique: qQvQUZrJMKSyWnjugSNfKA-1
X-Mimecast-MFC-AGG-ID: qQvQUZrJMKSyWnjugSNfKA_1770117083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F10FA1956046;
	Tue,  3 Feb 2026 11:11:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B5B61956053;
	Tue,  3 Feb 2026 11:11:16 +0000 (UTC)
Date: Tue, 3 Feb 2026 19:11:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <aYHXzyRJbzFSohNm@fedora>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 03, 2026 at 11:54:34AM +0100, Michal Koutný wrote:
> Hello.
> 
> On Tue, Feb 03, 2026 at 11:03:01AM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > Can you try the following patch?
> 
> I think it'd work thanks to the rcu_read_lock() in
> __blkcg_rstat_flush(). However, the chaining of RCU callbacks makes
> predictability of the release path less deterministic and may be
> unnecessary.

RCU supports this way, here is just 2-stage RCU chain, and everything
is deterministic.

> 
> What about this:
> 
> index 3cffb68ba5d87..e2f51e3bf04ef 100644
> --- a/tmp/b.c
> +++ b/tmp/a.c
> @@ -1081,6 +1081,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  		smp_mb();
>  
>  		WRITE_ONCE(bisc->lqueued, false);
> +		blkg_put(blkg);
>  		if (bisc == &blkg->iostat)
>  			goto propagate_up; /* propagate up to parent only */
>  
> @@ -2220,8 +2221,10 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	if (!READ_ONCE(bis->lqueued)) {
>  		struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
>  
> +		blkg_get(bio->bi_blkg);
>  		llist_add(&bis->lnode, lhead);
>  		WRITE_ONCE(bis->lqueued, true);
> +

I thought about this way, but ->lqueued is lockless, and in theory the `blkg_iostat_set`
can be added again after WRITE_ONCE(bisc->lqueued, false) happens, so this way looks
fragile.


Thanks, 
Ming

