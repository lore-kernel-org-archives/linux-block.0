Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE18221577
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567307; cv=none; b=Xf41Bci90pAVGfLx7ufbB8jth+eZKc5YEVLVOBMwZO4LNQwM3y2vIyrxaCtLm4anq0Zw+hrV2SbQ/mqFsCv+raR1OIsUDPvenmJ1gwFxvOfSAoux5rOE2Usg78fD6uQJL5wdBO4/GWM+rr6KCtxElH2+w6FvmLuBph580lL0C9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567307; c=relaxed/simple;
	bh=MSD5heh9l0UM2N1GKjrOwjnveahToBXZqRV1qlsfbDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Z2zefejmtTE4SuPmnB4rYHpQ3Kco6o6KvXXFmbmCvV7P23CzAbytz5JVcjdTXGNBeUuwEhIKj8FInIAQgcnujsXpmiPP/zvwvqWqL9v9IgT14htV0u2DxRnZZ0vcxXUDNfhVo5MVkVh55phqwiBq2BQ9I6EQNlPeIzGQ4MuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CA9wJuHk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA9wJuHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768567305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pti+zbbkFzi3gUThcTzY9psQKCZwirLbVoZGGYlaJDY=;
	b=CA9wJuHkTO2ssxTAQhKx1QxGS3YQfxszX0jxioWxcY7ENQVJeUliegn8tY7oIGWDcyzkJ0
	x0Ip4W1oucROYGBG97lYIwXR2mlXE7c9CofDs/XqccKCMc+2zkawBUayzy5g4wVHrv6s9y
	kOK9rD+P+9PDKS37cV8biUzoYRf6h+0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-IdhA_OcaPfGmz-l5R_ulfQ-1; Fri,
 16 Jan 2026 07:41:42 -0500
X-MC-Unique: IdhA_OcaPfGmz-l5R_ulfQ-1
X-Mimecast-MFC-AGG-ID: IdhA_OcaPfGmz-l5R_ulfQ_1768567301
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB90A180047F;
	Fri, 16 Jan 2026 12:41:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3245130002D6;
	Fri, 16 Jan 2026 12:41:35 +0000 (UTC)
Date: Fri, 16 Jan 2026 20:41:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: alex+zkern@zazolabs.com
Cc: Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	fengnanchang@gmail.com, linux-block <linux-block@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
Message-ID: <aWox-MEzRBKG5UjX@fedora>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora>
 <8c523b07-f868-41c9-88f1-753c77ef85fb@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c523b07-f868-41c9-88f1-753c77ef85fb@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jan 16, 2026 at 01:54:15PM +0200, Alexander Atanasov wrote:
> Hello Ming,
> 
> On 14.01.26 16:11, Ming Lei wrote:
> > On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
> > > On Thu, Jan 8, 2026 at 2:39 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > > > 
> > > > On Thu, Jan 8, 2026 at 12:48 AM Jens Axboe <axboe@kernel.dk> wrote:
> > > > > 
> > > > > On 1/7/26 9:39 AM, Yi Zhang wrote:
> > > > > > Hi
> > > > > > The following issue[2] was triggered by blktests nvme/059 and it's
> > > > > 
> > > > > nvme/049 presumably?
> > > > > 
> > > > Yes.
> > > > 
> > > > > > 100% reproduced with commit[1]. Please help check it and let me know
> > > > > > if you need any info/test for it.
> > > > > > Seems it's one regression, I will try to test with the latest
> > > > > > linux-block/for-next and also bisect it tomorrow.
> > > > > 
> > > > > Doesn't reproduce for me on the current tree, but nothing since:
> > > > > 
> > > > > > commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
> > > > > > Merge: 29cefd61e0c6 fcf463b92a08
> > > > > > Author: Jens Axboe <axboe@kernel.dk>
> > > > > > Date:   Tue Jan 6 05:48:07 2026 -0700
> > > > > > 
> > > > > >      Merge branch 'for-7.0/blk-pvec' into for-next
> > > > > 
> > > > > should have impacted that. So please do bisect.
> > > > 
> > > > Hi Jens
> > > > The issue seems was introduced from below commit.
> > > > and the issue cannot be reproduced after reverting this commit.
> > > 
> > > The issue still can be reproduced on the latest linux-block/for-next
> > 
> > Hi Yi,
> > 
> > Can you try the following patch?
> > 
> > 
> > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > index a9c097dacad6..7b0e62b8322b 100644
> > --- a/drivers/nvme/host/ioctl.c
> > +++ b/drivers/nvme/host/ioctl.c
> > @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> >   	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
> >   	/*
> > -	 * IOPOLL could potentially complete this request directly, but
> > -	 * if multiple rings are polling on the same queue, then it's possible
> > -	 * for one ring to find completions for another ring. Punting the
> > -	 * completion via task_work will always direct it to the right
> > -	 * location, rather than potentially complete requests for ringA
> > -	 * under iopoll invocations from ringB.
> > +	 * For IOPOLL, complete the request inline. The request's io_kiocb
> > +	 * uses a union for io_task_work and iopoll_node, so scheduling
> > +	 * task_work would corrupt the iopoll_list while the request is
> > +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
> > +	 * iopoll_completed rather than scheduling task_work.
> > +	 *
> > +	 * For non-IOPOLL, complete via task_work to ensure we run in the
> > +	 * submitter's context and handling multiple rings is safe.
> >   	 */
> > -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> > +	if (blk_rq_is_poll(req)) {
> > +		if (pdu->bio)
> > +			blk_rq_unmap_user(pdu->bio);
> > +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
> > +	} else {
> > +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> > +	}
> > +
> >   	return RQ_END_IO_FREE;
> >   }
> 
> 
> While this is a good optimisation and it will fix the list issue for a
> single user - it may crash with multiple users of the context. I am still
> learning this code, so excuse my ignorance here and there.

Jens has sent the following fix already:

https://lore.kernel.org/io-uring/aWhGEMsaOf752f5z@fedora/T/#t

> 
> The bisected patch 3c7d76d6128a changed io_wq_work_list which looks like
> safe to be used  without locks (it is a derivate of llist) , list_head
> require proper locking to be safe.
> 
> ctx can be used to poll multiple files, iopoll_list is a list for that
> reason.
> sqpoll is calling io_iopoll_req_issued without lock -> it does list_add_tail
> if that races with other list addition or deletion it will corrupt the list.
> 
> is there any mechanism to prevent that? or i am missing something?

io_iopoll_req_issued() will grab ctx->uring_lock if it isn't held.


Thanks,
Ming

