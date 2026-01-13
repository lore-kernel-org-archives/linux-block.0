Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D682FE04E
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276097; cv=none; b=U6hPXJAGuDZs+0iFpiSCoMPlfWKJXe0aFHA7nMZIqDwhnyd/+bTqb84lgRfp2yQ3O9MMUjkE6atvraHxNGMB7E4i4Gav0XO1HxyjfXmEQxjYZfj87kjHLyCDJ2UdLdeA07bbzLU6l0oHlCCUh4/SUhSlY54dhR7yf06/agf/f5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276097; c=relaxed/simple;
	bh=T2NpbCiifsZ5LqFPxEeqKccK3zZ1nAiUDemfIA5tnzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7+opCjKpplRJIyJ11ieF4Sk241pL5RUijhz43ZZTUytOOZLpgDqLIGkSAJ9Sj27fnhjVS1Q6/m4gtPowTH/tTtVEUkMwbTRvr3LaS2M6HdEYxrk1ofJIG10Bi/2i9l3iEz3fdYXRny2Q18p02uzqcxXyJ6gGWlmzbEtD1ZFy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diJKDFxa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diJKDFxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768276092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OmpEjBLswdv1b5FKrbarupjUFzTqMt0rXxYaIinVSxM=;
	b=diJKDFxaczhiwLZkeQ9MAUGLHFHoGK66RL52UMNsproIBIVISRTZ94T9I1zbTxcBY6oNwm
	e73Kiigfd+8jNViVFZlfzUzo6JXnjiEGaAc/OP35hNMkmDQ7lpVgJdqOKKQ0TU4kid2v6W
	QyAZ1//mI/IheSNS0N1yELWWwkXsFZM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-38D-lu0rOrOV7INpJKQLAA-1; Mon,
 12 Jan 2026 22:48:07 -0500
X-MC-Unique: 38D-lu0rOrOV7INpJKQLAA-1
X-Mimecast-MFC-AGG-ID: 38D-lu0rOrOV7INpJKQLAA_1768276086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EAC01956094;
	Tue, 13 Jan 2026 03:48:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6981930001A8;
	Tue, 13 Jan 2026 03:48:03 +0000 (UTC)
Date: Tue, 13 Jan 2026 11:47:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Seamus Connor <sconnor@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
Message-ID: <aWXAbhyzVvyCuqBQ@fedora>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260112225614.1817055-1-sconnor@purestorage.com>
 <aWWnhX7h3m9w2wc6@fedora>
 <CAB5MrP5mezn9rWZmykXTcc5-kLRPScu79xQsd_4Q7L=X=hn6dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB5MrP5mezn9rWZmykXTcc5-kLRPScu79xQsd_4Q7L=X=hn6dQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 12, 2026 at 06:46:06PM -0800, Seamus Connor wrote:
> > `ublksrv_pid` is from userspace, so it may be invalid, then you may have to
> > check result of find_vpid().
> 
> find_vpid() returns either a valid struct pid* or NULL as far as I
> understand, and pid_nr handles the case where the provided struct pid*
> is NULL. Is there another case to handle that I am missing?

pid_nr(NULL) returns 0, but the stored ->ublksrv_pid can't be zero, so this
bad condition is always covered?  If yes, looks it is fine to not check
NULL `pid*` explicitly.


Thanks,
Ming

