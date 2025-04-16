Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC133206F0E
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744766032; cv=none; b=RBoZBtggixUvD1LjaIamiLl0VCZcamcdtTQeqaoPTiq1JGbQoxsfZc8CM1/6t+hB17AGiZTz48D6oO/cR6g470D2KVPA5smneep14HDLN2lTXVvkTHi97gNnVAb12hqgNWzvUWLwoUjDfCngUIbzXZNRmLr6AH0UX7lg+iUXQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744766032; c=relaxed/simple;
	bh=3Ae/yiDo1VlShsCMEXbkFP1ulljk11oCOoE071mEkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3HnURq/NWZGprRbc+C+BOi7bNHm2R1pjf75c4C+QYgpucYFeCTzcTrTArMx/gS/YsloGfpoCfROWh/Dxiq06nC2YNMa2zyCs27D1tV4ZYMDYOJitIggWhmDEAFl1cjGLta1gY68dLURIgHKJjV8J9eg4F5r0/Q6ghGcLPHfThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSC+Gshn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSC+Gshn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744766029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGsflCkqegM91AH1zVwvb6137cy3hts9zNB7JlKecE0=;
	b=dSC+GshnaM2kS1Iy6kGk+5MLhqH+k2zviE16DVt1vPOVUD81iy9fCMWn/VR+AFXLHGqmII
	pGsMmpKXXR8ceywKQY4ByCdBBJxxVldp8cXARznKSXatX0zdrIRHInM5LiJiMZM/uEJAmS
	kHAlU6R0kZOmhqLLI+PWkE0JgQEvDz4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-4ckcmkKMPI6C5eHXzcdByA-1; Tue,
 15 Apr 2025 21:13:47 -0400
X-MC-Unique: 4ckcmkKMPI6C5eHXzcdByA-1
X-Mimecast-MFC-AGG-ID: 4ckcmkKMPI6C5eHXzcdByA_1744766026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF18A1800349;
	Wed, 16 Apr 2025 01:13:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADC2C18009BC;
	Wed, 16 Apr 2025 01:13:42 +0000 (UTC)
Date: Wed, 16 Apr 2025 09:13:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z_8EQPd_tcY3NyvW@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
> On 4/14/25 1:58 PM, Uday Shankar wrote:
> > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > +		      struct ublk_queue *ubq, struct ublk_io *io,
> > +		      const struct ublksrv_io_cmd *ub_cmd,
> > +		      unsigned int issue_flags)
> > +{
> > +	int ret = 0;
> > +
> > +	if (issue_flags & IO_URING_F_NONBLOCK)
> > +		return -EAGAIN;
> > +
> > +	mutex_lock(&ub->mutex);
> 
> This looks like overkill, if we can trylock the mutex that should surely
> be fine? And I would imagine succeed most of the time, hence making the
> inline/fastpath fine with F_NONBLOCK?

The mutex is the innermost lock and it won't block for handling FETCH
command, which is just called during queue setting up stage, so I think
trylock isn't necessary, but also brings complexity.


Thanks,
Ming

