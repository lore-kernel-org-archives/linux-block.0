Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C9239E9D
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362913; cv=none; b=W1GzQrdUrJasc4hXu3w3cQkWAjzcFIQF5GkBg9iUZ82WyxaUG6lD+20FRRVnWU7HycFE4UzVHDqdEIlTOJD4bWM3RHAVR8KOyGdn751Gs8MJMG45M2L82PxyeBXZWVbC3cYs7zgnjgsBFXhUW2rwn3B4cnCTJpPikl8rkYP879I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362913; c=relaxed/simple;
	bh=VdJ0XuJJfg/8+ppoGtu7D6pP8/OefORs8b3IGoP7ftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5WRqlChxDmV+5GhYVUWAX+OMyUeGbAoA7jMdAAqqiG9QCRKyx72n/judTVkTjkNSPRUNl/NbqsrxH7/QDJ8iQVWVXmUL744MHaJZ0CdKyVoFpvHJwFSJgRvvZUphPZ+NInBd64nMPWZGDlfxIGgiOXd5Z7AyheeBjP0T4KY++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMBIHMnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMBIHMnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768362911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPVLP8SsFzQ5LP36MIV6B72lGX9eLEptP6jgLXp3T9s=;
	b=QMBIHMnph9etF/xVJyYx/0FQ/QFkXiGthAHJbgK3D7FIbIwjGcv4e7EBNFSC+KO/z/pMxg
	q4W7Lchp6H0S4NV7IZ542g/nyKTJ0ZBCv92a8siYvzdtjs29W3mxD2vNEWPaRzLfe6V7Jg
	DP5PM4wdxxG1lL6Zc672H8zVVEcJxyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-JMsiyniQPHqEngE8kjRLAw-1; Tue,
 13 Jan 2026 22:55:10 -0500
X-MC-Unique: JMsiyniQPHqEngE8kjRLAw-1
X-Mimecast-MFC-AGG-ID: JMsiyniQPHqEngE8kjRLAw_1768362909
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA86D1956094;
	Wed, 14 Jan 2026 03:55:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67FE919560A2;
	Wed, 14 Jan 2026 03:55:05 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:55:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Seamus Connor <sconnor@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
Message-ID: <aWcTlFbYh7LbDLf2@fedora>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260112225614.1817055-1-sconnor@purestorage.com>
 <aWWnhX7h3m9w2wc6@fedora>
 <CAB5MrP5mezn9rWZmykXTcc5-kLRPScu79xQsd_4Q7L=X=hn6dQ@mail.gmail.com>
 <aWXAbhyzVvyCuqBQ@fedora>
 <CAB5MrP7M4TU+Y87QyM25kcqWX-mCzkdgWMn_CrB0oT=1aA1AJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB5MrP7M4TU+Y87QyM25kcqWX-mCzkdgWMn_CrB0oT=1aA1AJA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 13, 2026 at 03:03:04PM -0800, Seamus Connor wrote:
> Hi Ming,
> 
> I did the following test. I updated kublk.c so that getpid() could be
> overridden with arbitrary values. I then added probes around the code
> change. I tested the behavior of the change with arbitrary negative,
> and positive pids, confirming that I covered both pids that do exist,
> and pids that do not exist. The behavior of
> `pid_nr(find_vpid(ublksrv_pid));` is correct under these
> circumstances.
> 
> Of course, I am happy to add explicit checks, move to a helper, or add
> the tests I mentioned to the suite. Let me know.

Hi Seamus,

Please go ahead and post V3.

Thanks,
Ming

