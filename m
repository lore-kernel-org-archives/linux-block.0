Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952F1FF5F7
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959521; cv=none; b=gSt273tkKH1TU9hAd8Q3ROlhM/EbeHSwQex/zguksgaMiCod3T7o/X4RJha32TX9Ew2n0JYai11ZkB+Qcv8jISRLSFnjebhyclGrhD0IWjKIi/Zwf1bwA91QQNlolK7LbCsqWB0n2JhmlqJvE6DNyddOSYlOd+uQIbNVuR5466Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959521; c=relaxed/simple;
	bh=mqon7A7zdnJY2tlacRpMmphXYI0wAeeQZ3yNXrUMWfQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nCcTUOQKrT36nxLo/hIOSb4EGiJeCnZexjd4F9D0k3wgu62WPvAeHWFlijhGeLFS3NvHk8WopZJdRW2SyynmX4Gy2ivWODEOSrDdb8URUcjum/v66FUztx+1Zd9TmvYGKLm/PFjOYeeKDLmBoe7qw+pfphKI2tsdwPBdbaLTn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Whpf8fSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whpf8fSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741959518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=siMQUnZtffeXrH4L1mE3LJxMTHKjSmBCQ/9CAmI7V4w=;
	b=Whpf8fSJ0xwtgGEeUedvrRI8CJngberCzfcuSAbPTvmwpwOVwEU5a+mVLX1ImrOkKa6T0f
	AiJEOHtb2CRsNkJsXWo6Wj1Mynb6qUM+rO6TS0HNVQKayabiQD76EDL4uYZZ2E22sr+518
	cEPBVynH5G26K8Uflf0RkXo7TYrD4IQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-IVd9pnedNyqi2ZIqAfVAng-1; Fri,
 14 Mar 2025 09:38:35 -0400
X-MC-Unique: IVd9pnedNyqi2ZIqAfVAng-1
X-Mimecast-MFC-AGG-ID: IVd9pnedNyqi2ZIqAfVAng_1741959514
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 999EC18001F8;
	Fri, 14 Mar 2025 13:38:33 +0000 (UTC)
Received: from [10.22.82.75] (unknown [10.22.82.75])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1F411954B32;
	Fri, 14 Mar 2025 13:38:30 +0000 (UTC)
Date: Fri, 14 Mar 2025 14:38:26 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
cc: Benjamin Marzinski <bmarzins@redhat.com>, 
    Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/7] dm: handle failures in dm_table_set_restrictions
In-Reply-To: <60f0f94c-3c80-4806-82aa-04ace428b4d4@kernel.org>
Message-ID: <ad565ffc-d34e-7c24-ab2b-aad4774f92f1@redhat.com>
References: <20250309222904.449803-1-bmarzins@redhat.com> <20250309222904.449803-4-bmarzins@redhat.com> <9b5ff861-964d-472c-9267-5e5b10186ed3@kernel.org> <Z88jTxQqoLitl4ee@redhat.com> <Z88sP2WyotRbTd2E@redhat.com>
 <60f0f94c-3c80-4806-82aa-04ace428b4d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 11 Mar 2025, Damien Le Moal wrote:

> Yes, for simple scalar limits, I do not think there is any issue. But there are
> some cases where changing one limit implies a change to other limits when the
> limits are committed (under the limits lock). So my concern was that if the
> above runs simultaneously with a queue limits commit, we may endup with the
> limits struct copy grabbing part of the new limits and thus resulting in an
> inconsistent limits struct. Not entirely sure that can actually happen though.
> But given that queue_limits_commit_update() does:
> 
> 	q->limits = *lim;
> 
> and this code does:
> 
> 	old_limits = q->limits;
> 
> we may endup depending on how the compiler handles the struct copy ?

There is no guarantee that struct copy will update the structure fields 
atomically.

On some CPUs, a "rep movsb" instruction may be used, which may be 
optimized by the CPU, but it may be also interrupted at any byte boundary.

I think it should be changed to the sequence of WRITE_ONCE statements, for 
example:
WRITE_ONCE(q->limits->file, lim->field);

Mikulas

