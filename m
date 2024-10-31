Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80C1993B2
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373486; cv=none; b=GZ/gQOp0UFtFbLv5hgRTXYZ6S7kiShHuUzQ9D0Et5ZAOKPgbCXkEh0N9GcmNA7egIiVpLUdXVYD0ExpwADmu1Bpr9xlkq7BEXqbMkOXTkTpp93gUk2RQfS4HJrAJKxLjGXgtEhk7/bf/+iotkzVI2tpprgCs3WpN5PiVbtv3BIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373486; c=relaxed/simple;
	bh=bwpvelYK0UtnFAEzNrylSJg+KyuetJoHpJpK3ReqJWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1dWAHzcAT8bbO51majTMSyfpVGAIanNJnIhD9Ea/fGPwMwxWGmXst92VDq5oPADILlYSJHZ8M57+goK4YjCyeNKE43YAnY2h4nWnDgtxYIMmEiNulTG22e4XfybKpB+YN64LC2y9geFIQ3KqnbDOAne2Lr8M+mwd+5xwpI44Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTKZaRa6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTKZaRa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730373483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5sGiN35PQFL8rUGgMxPhoKpvl3YRPqT1auSO/v+iIc=;
	b=NTKZaRa64/SX3XSRuFPnWP7NOm6C3BL5Ct2eBIgcVOydMyEjefwecdlcs70TsR5OCL5DQv
	wNf98DUARq6eb5DMecAF6eovwJMl3xkSItT04THQ5RkqmGUtkftNTPlJM4Il/Hs20HL59U
	1A5I7MDuqTw/igP8G8voNL4hExsRlDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-ovA66PpLPayLORYMYV5Kag-1; Thu,
 31 Oct 2024 07:18:00 -0400
X-MC-Unique: ovA66PpLPayLORYMYV5Kag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F6221956096;
	Thu, 31 Oct 2024 11:17:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DB06300018D;
	Thu, 31 Oct 2024 11:17:49 +0000 (UTC)
Date: Thu, 31 Oct 2024 19:17:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	klara@kasm.eu
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZyNnWAsaPyn5gYwd@fedora>
References: <20241024050021.627350-1-hch@lst.de>
 <fa2f2722-fab2-4108-8d3a-f7da87bb9efa@gmail.com>
 <ZyLL-eXIntwBY5q2@fedora>
 <ZyLNqtmxsEt-VYIE@fedora>
 <2fd45655-9847-44a3-adf3-14ced29abd33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd45655-9847-44a3-adf3-14ced29abd33@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 31, 2024 at 09:42:32AM +0100, Klara Modin wrote:
> On 2024-10-31 01:22, Ming Lei wrote:
> > On Thu, Oct 31, 2024 at 08:14:49AM +0800, Ming Lei wrote:
> > > On Wed, Oct 30, 2024 at 06:56:48PM +0100, Klara Modin wrote:
> > > > Hi,
> > > > 
> > > > On 2024-10-24 07:00, Christoph Hellwig wrote:
> > > > > From: Ming Lei <ming.lei@redhat.com>
> > > > > 
> > > > > The iov_iter_extract_pages interface allows to return physically
> > > > > discontiguous pages, as long as all but the first and last page
> > > > > in the array are page aligned and page size.  Rewrite
> > > > > iov_iter_extract_bvec_pages to take advantage of that instead of only
> > > > > returning ranges of physically contiguous pages.
> > > > > 
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > [hch: minor cleanups, new commit log]
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > 
> > > > With this patch (e4e535bff2bc82bb49a633775f9834beeaa527db in next-20241030),
> > > > I'm unable to connect via nvme-tcp with this in the log:
> > > > 
> > > > nvme nvme1: failed to send request -5
> > > > nvme nvme1: Connect command failed: host path error
> > > > nvme nvme1: failed to connect queue: 0 ret=880
> > > > 
> > > > With the patch reverted it works as expected:
> > > > 
> > > > nvme nvme1: creating 24 I/O queues.
> > > > nvme nvme1: mapped 24/0/0 default/read/poll queues.
> > > > nvme nvme1: new ctrl: NQN
> > > > "nqn.2018-06.eu.kasm.int:freenas:backup:parmesan.int.kasm.eu", addr
> > > > [2001:0678:0a5c:1204:6245:cbff:fe9c:4f59]:4420, hostnqn:
> > > > nqn.2018-06.eu.kasm.int:parmesan
> > > 
> > > I can't reproduce it by running blktest 'nvme_trtype=tcp ./check nvme/'
> > > on both next tree & for-6.13/block.
> > > 
> > > Can you collect the following bpftrace log by running the script before
> > > connecting to nvme-tcp?
> 
> I didn't seem to get any output from the bpftrace script (I confirmed that I
> had the config as you requested, but I'm not very familiar with bpftrace so
> I could have done something wrong). I could, however, reproduce the issue in

It works for me on Fedora(37, 40).

> qemu and added breakpoints on nvmf_connect_io_queue and
> iov_iter_extract_pages. The breakpoint on iov_iter_extract_pages got hit
> once when running nvme connect:
> 
> (gdb) break nvmf_connect_io_queue
> Breakpoint 1 at 0xffffffff81a5d960: file
> /home/klara/git/linux/drivers/nvme/host/fabrics.c, line 525.
> (gdb) break iov_iter_extract_pages
> Breakpoint 2 at 0xffffffff817633b0: file
> /home/klara/git/linux/lib/iov_iter.c, line 1900.
> (gdb) c
> Continuing.
> [Switching to Thread 1.1]

Wow, debug kernel with gdb, cool!

> 
> Thread 1 hit Breakpoint 2, iov_iter_extract_pages
> (i=i@entry=0xffffc900001ebd68,
>     pages=pages@entry=0xffffc900001ebb08, maxsize=maxsize@entry=72,
> maxpages=8,
>     extraction_flags=extraction_flags@entry=0,
> offset0=offset0@entry=0xffffc900001ebb10)
>     at /home/klara/git/linux/lib/iov_iter.c:1900
> 1900	{
> (gdb) print i->count
> $5 = 72
> (gdb) print i->iov_offset
> $6 = 0
> (gdb) print i->bvec->bv_offset
> $7 = 3952
> (gdb) print i->bvec->bv_len
> $8 = 72
> (gdb) c
> Continuing.
> 
> I didn't hit the breakpoint in nvmf_connect_io_queue, but I instead hit it
> if I add it to nvmf_connect_admin_queue. I added this function to the
> bpftrace script but that didn't produce any output either.

Your kernel config shows all BTF related options are enabled, maybe
bpftrace userspace issue?

> 
> > 
> > And please try the following patch:
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 9fc06f5fb748..c761f6db3cb4 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
> >                  i->bvec++;
> >                  skip = 0;
> >          }
> > +       bi.bi_idx = 0;
> >          bi.bi_size = maxsize + skip;
> >          bi.bi_bvec_done = skip;
> > 
> > 
> 
> Applying this seems to fix the problem.

Thanks for the test, and the patch is sent out.


thanks,
Ming

