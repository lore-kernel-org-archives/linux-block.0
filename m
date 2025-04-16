Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4415E96
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769097; cv=none; b=q9F49CMRuPDwkGXUDuebUT2rD3It0QxIzjwHfuxcMKGov67zFetLQEYVbrDctxn5spZVRSCu6lFHO0m16xPFUnDub/MwNLYB/yngbE6DV4NtTHpr06z8bKKW1cZRwXM+n2TweFd1Xx+Oy/pRmOlo/9ntJ9EwdHI9+YSlxfPstPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769097; c=relaxed/simple;
	bh=iAoHZAM8iEnVfLfXgnoZjK6ubd5VEv/SLrrk/iH79KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8InChOEjbuIDzfHPsH+DpuCfjbENTkt83K2ZG01ciSsBsCz42VNih98XUOrIRYNx05N1KA69dOpS3thQMg4g1nIO22sXiqSK7yCB3gLSu8VStKC9Yx574wxDoPTZfW5w5Bd8xbz74FimWS2iZsRQq+ntF3VvRAQ5LFDqz47K6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcFiIdKg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcFiIdKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744769094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gVJlyVXQBVEedd5DK54MK9QwlVpTzHnOPdU6M1MV2AE=;
	b=AcFiIdKgQNB6tJz064r2OODX7ApjvwPOF7IWfnxPd9dbLD65SgHu7SBZCi/ZbOuk8G27Cn
	A+F2KTJiiRrrYnXg6Fg+lwfdeLAQsemRDiW6ciwhT2yogJkVNKeVuvcdGJnd0n+eGH74I8
	7ur7SeuohXZDDKk61oEVf0NCdeHU1jE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-y1NnluiaOAeTygL0eQqz9g-1; Tue,
 15 Apr 2025 22:04:51 -0400
X-MC-Unique: y1NnluiaOAeTygL0eQqz9g-1
X-Mimecast-MFC-AGG-ID: y1NnluiaOAeTygL0eQqz9g_1744769090
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E45D6180035E;
	Wed, 16 Apr 2025 02:04:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A45B51955BC0;
	Wed, 16 Apr 2025 02:04:45 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:04:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z_8QOSd7jQV3Cwz1@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
 <Z_8EQPd_tcY3NyvW@fedora>
 <be1d189f-2c00-4b0f-979f-11fe4169d79a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1d189f-2c00-4b0f-979f-11fe4169d79a@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 15, 2025 at 07:17:09PM -0600, Jens Axboe wrote:
> On 4/15/25 7:13 PM, Ming Lei wrote:
> > On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
> >> On 4/14/25 1:58 PM, Uday Shankar wrote:
> >>> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> >>> +		      struct ublk_queue *ubq, struct ublk_io *io,
> >>> +		      const struct ublksrv_io_cmd *ub_cmd,
> >>> +		      unsigned int issue_flags)
> >>> +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (issue_flags & IO_URING_F_NONBLOCK)
> >>> +		return -EAGAIN;
> >>> +
> >>> +	mutex_lock(&ub->mutex);
> >>
> >> This looks like overkill, if we can trylock the mutex that should surely
> >> be fine? And I would imagine succeed most of the time, hence making the
> >> inline/fastpath fine with F_NONBLOCK?
> > 
> > The mutex is the innermost lock and it won't block for handling FETCH
> > command, which is just called during queue setting up stage, so I think
> > trylock isn't necessary, but also brings complexity.
> 
> Then the NONBLOCK check can go away, and a comment added instead on why
> it's fine. Or maybe even a WARN_ON_ONCE() if trylock fails or something.
> Otherwise it's going to look like a code bug.

Yes, the NONBLOCK check isn't needed. 

ublk uring cmd is always handled with !(issue_flags & IO_URING_F_UNLOCKED), please
see ublk_ch_uring_cmd() and ublk_ch_uring_cmd_local().


thanks,
Ming

