Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2C395265
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404064; cv=none; b=O8+7xJ4OvjF1dl2PI089reAnJQv1+i2VaFC2kb9Gw282Crm0jj9HMAJhF+4X7kywqhiIWor0GaWZZCBx5cxysQnYXaIRmE6mhhpiPEtAElbn3B02gKGXVD/5yx/4W7T0js7EYR3eOODCQaqoh0iVy1mswcoVnMVMwVL73+J86R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404064; c=relaxed/simple;
	bh=+ppo8uAsVXBnNoEqLyGHQvlQbFfKFeNVvEZIeCIkHOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWAtGBUR5sDdBulEHvVOqcy0Ag6XvgyBykpuU5j/bARjX7AlXE4rPgwS5HnCnwMsAikrsp+dzQ7sU7DaMrqCyw89wpTr/5/FDmlv+PgXlpp20q955IqfgD8CI/i5z8s5wMx2W2CDsFMhBeVqvOeUdy1x2+OITwkCXTWpfHlakzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmY3aV4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmY3aV4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768404055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PORKFyOlulgLeMZWUR+Z9OcSRM22XDJVeQCJWthQ4yk=;
	b=EmY3aV4XpBhD29aZ7qgsQAyx7vXhF+QpYFqhVvKWvctw8i37JBEIP085zOrCF7HsCphclt
	rZY2GdZ+Tc+r7gK/O2WphS/M0RhuZkCJs6Qnt8gqKvfsXACqJlBsoEDXSld8jfMQMr6xq8
	QKYPOXowoKha8R2f+v+pOSoEqDIhIFI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-exutarICO02XXWkaGcvRMw-1; Wed,
 14 Jan 2026 10:20:52 -0500
X-MC-Unique: exutarICO02XXWkaGcvRMw-1
X-Mimecast-MFC-AGG-ID: exutarICO02XXWkaGcvRMw_1768404051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2DEE1956061;
	Wed, 14 Jan 2026 15:20:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F20718004D8;
	Wed, 14 Jan 2026 15:20:46 +0000 (UTC)
Date: Wed, 14 Jan 2026 23:20:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>, fengnanchang@gmail.com,
	linux-block <linux-block@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
Message-ID: <aWe0SjcDRQZM2t2G@fedora>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora>
 <78ff994b-26e8-4b35-a83f-15bb61865e87@kernel.dk>
 <9ae067ba-d0b6-49ac-9e96-01d23348261f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae067ba-d0b6-49ac-9e96-01d23348261f@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 14, 2026 at 07:58:54AM -0700, Jens Axboe wrote:
> On 1/14/26 7:43 AM, Jens Axboe wrote:
> > On 1/14/26 7:11 AM, Ming Lei wrote:
> >> On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
> >>> On Thu, Jan 8, 2026 at 2:39?PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >>>>
> >>>> On Thu, Jan 8, 2026 at 12:48?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>
> >>>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
> >>>>>> Hi
> >>>>>> The following issue[2] was triggered by blktests nvme/059 and it's
> >>>>>
> >>>>> nvme/049 presumably?
> >>>>>
> >>>> Yes.
> >>>>
> >>>>>> 100% reproduced with commit[1]. Please help check it and let me know
> >>>>>> if you need any info/test for it.
> >>>>>> Seems it's one regression, I will try to test with the latest
> >>>>>> linux-block/for-next and also bisect it tomorrow.
> >>>>>
> >>>>> Doesn't reproduce for me on the current tree, but nothing since:
> >>>>>
> >>>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
> >>>>>> Merge: 29cefd61e0c6 fcf463b92a08
> >>>>>> Author: Jens Axboe <axboe@kernel.dk>
> >>>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
> >>>>>>
> >>>>>>     Merge branch 'for-7.0/blk-pvec' into for-next
> >>>>>
> >>>>> should have impacted that. So please do bisect.
> >>>>
> >>>> Hi Jens
> >>>> The issue seems was introduced from below commit.
> >>>> and the issue cannot be reproduced after reverting this commit.
> >>>
> >>> The issue still can be reproduced on the latest linux-block/for-next
> >>
> >> Hi Yi,
> >>
> >> Can you try the following patch?
> >>
> >>
> >> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> >> index a9c097dacad6..7b0e62b8322b 100644
> >> --- a/drivers/nvme/host/ioctl.c
> >> +++ b/drivers/nvme/host/ioctl.c
> >> @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> >>  	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
> >>  
> >>  	/*
> >> -	 * IOPOLL could potentially complete this request directly, but
> >> -	 * if multiple rings are polling on the same queue, then it's possible
> >> -	 * for one ring to find completions for another ring. Punting the
> >> -	 * completion via task_work will always direct it to the right
> >> -	 * location, rather than potentially complete requests for ringA
> >> -	 * under iopoll invocations from ringB.
> >> +	 * For IOPOLL, complete the request inline. The request's io_kiocb
> >> +	 * uses a union for io_task_work and iopoll_node, so scheduling
> >> +	 * task_work would corrupt the iopoll_list while the request is
> >> +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
> >> +	 * iopoll_completed rather than scheduling task_work.
> >> +	 *
> >> +	 * For non-IOPOLL, complete via task_work to ensure we run in the
> >> +	 * submitter's context and handling multiple rings is safe.
> >>  	 */
> >> -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> >> +	if (blk_rq_is_poll(req)) {
> >> +		if (pdu->bio)
> >> +			blk_rq_unmap_user(pdu->bio);
> >> +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
> >> +	} else {
> >> +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> >> +	}
> >> +
> >>  	return RQ_END_IO_FREE;
> >>  }
> >>  
> > 
> > Ah yes that should fix it, the task_work addition will conflict with
> > the list addition. Don't think it's safe though, which is why I made
> > them all use task_work previously. Let me fix it in the IOPOLL patch
> > instead.
> 
> This should be better:
> 
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> index dd084a55bed8..1fa8d829cbac 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -719,13 +719,10 @@ struct io_kiocb {
>  	atomic_t			refs;
>  	bool				cancel_seq_set;
>  
> -	/*
> -	 * IOPOLL doesn't use task_work, so use the ->iopoll_node list
> -	 * entry to manage pending iopoll requests.
> -	 */
>  	union {
>  		struct io_task_work	io_task_work;
> -		struct list_head	iopoll_node;
> +		/* For IOPOLL setup queues, with hybrid polling */
> +		u64                     iopoll_start;
>  	};
>  
>  	union {
> @@ -734,8 +731,8 @@ struct io_kiocb {
>  		 * poll
>  		 */
>  		struct hlist_node	hash_node;
> -		/* For IOPOLL setup queues, with hybrid polling */
> -		u64                     iopoll_start;
> +		/* IOPOLL completion handling */
> +		struct list_head	iopoll_node;
>  		/* for private io_kiocb freeing */
>  		struct rcu_head		rcu_head;
>  	};

This way looks better, just `req->iopoll_start` needs to read to local
variable first in io_uring_hybrid_poll().


Thanks,
Ming

