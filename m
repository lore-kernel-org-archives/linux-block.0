Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664F233147
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756995; cv=none; b=ewpfVhiIO2F6EUTM+HeHMnY8kaKF1I58bUG4TpTU5kibqSGh1YpTy3x4x5JFqTP4q5R75iHGOKqUI+T/g9VU+aS1i2ZVmY6X1QD7X95QEfrbwuGByDDOYQVqjoq7rvJJk6qkpRRYt8FIYSwwF/Zg/RYWbVidIDhJAYzEbQNsxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756995; c=relaxed/simple;
	bh=dBBh2L0GRTutoCtgtcm0z/4Dr/JhYHq2koDnETJwpow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzOR3U9+9jLvKOs+1Kdcn4+6nLs87dyfvpsYY6CxMsyfiTewWSBk78cI5MOyG4CHTDRI8VpZaW5FMlG+E6mnA461XN8A3A60RltGwns8jzEIalzOzvavW5hHvDsEkSt/LVDBnlPkT413KgD+b8HMZvSZfA+pktj01byPuYAFmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZW/KAT3z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZW/KAT3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736756992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6GNSSNmAfq8X4vJUzhF/qrQ0SkEFIP0FbiQxYL4Q5E=;
	b=ZW/KAT3zepZuH1/9zcwZGMtcBv+aWxhUacdzV4Fh4c3zOEbxLwEiqy5Sd3ivVRPojKcqBD
	HzeHPmJVJmo9r1tX2cp+umfBk9lPQ/EtHe0VACJ0pWlVmDPWeQEMk2GZv+Xu19t/Nbmkxe
	7mY4UAMHSqz2EhWC32EFZ9+GstOWMTY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-ulrURbz_NwWqRjfHtXuC6g-1; Mon,
 13 Jan 2025 03:29:49 -0500
X-MC-Unique: ulrURbz_NwWqRjfHtXuC6g-1
X-Mimecast-MFC-AGG-ID: ulrURbz_NwWqRjfHtXuC6g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A707195606F;
	Mon, 13 Jan 2025 08:29:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77F7730001BE;
	Mon, 13 Jan 2025 08:29:43 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:29:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Message-ID: <Z4TO8bVgTnB2q4Oz@fedora>
References: <20250113015833.698458-1-ming.lei@redhat.com>
 <2fa89c60-a507-43a0-98ed-4d182bcea3ee@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fa89c60-a507-43a0-98ed-4d182bcea3ee@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 13, 2025 at 08:23:19AM +0000, John Garry wrote:
> On 13/01/2025 01:58, Ming Lei wrote:
> > sysfs ->store is called with queue freezed, meantime we have several
> > ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> > memory with GFP_KERNEL which may run into direct reclaim code path,
> > then potential deadlock can be caused.
> > 
> > Fix the issue by marking NOIO around sysfs ->store()
> > 
> > Reported-by: Thomas Hellström<thomas.hellstrom@linux.intel.com>
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> 
> I guess that you should be including a link to https://lore.kernel.org/linux-block/Z4RkemI9f6N5zoEF@fedora/T/#mc774c65eeca5c024d29695f9ac6152b87763f305
> 

Indeed, I will add a Closes tag in V2.


> Regardless, FWIW:
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks,


-- 
Ming

