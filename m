Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F2257D
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538816; cv=none; b=k5pjzl49Kwdplype2DdqzNJXQhMCnxFL++j/Ybf4tPQp2HbUGQEwaHONJETbZtUiB+nMDqBQBEvgamkKTbF69hXswZZO868sB8HvDTwCDohGE2enACdwsxHegx64W4klRTnMCPM9XzkfZSWfqh7R1FCERcHGVqQ3D+shDiT1SQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538816; c=relaxed/simple;
	bh=yW/FAGr9qeBMEJg7ZwLUJlBs9o7NBrN/4R6kJp+SfuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPWQHeBUeWBP6duZWiGkMXyXt66AM2djF7UWrxNOC9kGjtUMSj3A8qGsDl59/mJWfdUFHwGLJkmg6Ml3h++58wUwxnaKGBE2QrXfIeAq3xNaVAcZqmQ/vCvc8nYzqtYX8YXW9lu0uDyFoddZd2JASJ6rBZ6G7BOAiBQTut7M1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixMO6bFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixMO6bFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ea/aVjhf0zSCkaf20Hp+YprZzm3cgQoG3nYM/pv2u0=;
	b=ixMO6bFTqhOsG05OoUMVdSTlCIuklmIlHJOjPx6bRSLSXYgOgkLgWOm2w8DFe+HrsaABvB
	cXkkI4ywV7BwZo8CvOUfWABl7uT8clWWi+hYdn5RHw4fUTh9VojyEaoPRN+f8xgemN/QCh
	6qh8aRbzL8MSgiwxRbizaODrL8joNRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-npAo-ElgP0e2PSRw2AFEjQ-1; Tue,
 06 May 2025 09:40:09 -0400
X-MC-Unique: npAo-ElgP0e2PSRw2AFEjQ-1
X-Mimecast-MFC-AGG-ID: npAo-ElgP0e2PSRw2AFEjQ_1746538808
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C7561955DD0;
	Tue,  6 May 2025 13:40:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFA1918001D7;
	Tue,  6 May 2025 13:40:05 +0000 (UTC)
Date: Tue, 6 May 2025 21:40:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: Port to 6.14-stable - ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-ID: <aBoRMF7Wy4Ff2JV-@fedora>
References: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
 <aBlwTtmeZErD4gnH@fedora>
 <df889108-6b11-4cb7-b77e-8d27922cbbc7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df889108-6b11-4cb7-b77e-8d27922cbbc7@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, May 06, 2025 at 04:16:25PM +0300, Jared Holzman wrote:
> On 06/05/2025 5:13, Ming Lei wrote:
> > On Mon, May 05, 2025 at 07:06:37PM +0300, Jared Holzman wrote:
> >> Hi Ming,
> >>
> >> I'm attempting to back port the fix for this issue to the 6.14-stable branch.
> >>
> >> Greg Kroah-Hartman has already applied d6aa0c178bf8 - "ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA",
> >> but was unable to apply f40139fde527 cleanly.
> >>
> >> I created the patch below. It applies and compiles, but when I rerun the scenario I get several hung tasks waiting on the ub->mutex
> >> which is being held by the following task:
> > 
> > Hi Jared,
> > 
> > You need to pull in the following patchset too:
> > 
> > https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
> > 
> > which avoids ub->mutex in error handling code path.
> > 
> > I just picked them in the following tree:
> > 
> > https://github.com/ming1/linux/commits/linux-6.14.y/
> > 
> > Please test and see if they work for you.
> > 
> > 
> > Thanks,
> > Ming
> > 
> 
> Hi Ming,
> 
> Tested. It works great!
> 
> Will you be sending a pull request to Greg or should I send him the patches?

Hi Jared,

Please make a PR and send to Greg since I didn't test & verify it on 6.14-y
tree yet.

And please Cc me, I will give one double review.


Thanks,
Ming

