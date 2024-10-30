Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03201E3DD7
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286548; cv=none; b=TWBZV5Bo1kZb2IR64wMNRVByXKNs30aV3FLKH3NizTyRB9zBdhr9EFqskznZW2j2QihiRmUNuP0elxUwb7G4CEULgNX1OtPRBi2zbFkamCFg68w1C3HASFKeEeMofAHDMlOL1o60QyvLq5NbS3jO7Pw9InhkxF4je+hVhnXzftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286548; c=relaxed/simple;
	bh=4S5x0bvrZAOnJSXqbrtJSSqpf+S3NcFFvryeJ9Msr1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIMgIZS0cgfe6001XUC8K0PgQJMs+QXcyYCJ6h9AxYu1eUO3mvsp3yggXSVHD6hDcEj58Hq8jt8Q1/fQNlE8TC5VzJ5APSUJSsNYcFFZxhYSsNNMy2CY+bFUWfWluRDVvkBcNud3ywvIKuMpIUp1RwAgf4pGYJ3WmdEcMC/4PqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxnQNm9M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxnQNm9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730286545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4gl0k9RMOgJbQRtMcfUOVUiznRtYig67HlXgTPy7Dw=;
	b=KxnQNm9MWJPSt9BHiY1GlBn2PF2mZUYAmmtUcYPe7Ym57CN44+w3KBvj7f+zz2vkNgqJHh
	Pk8fAquikl/kSkKKmxKSorK6mSinrijZWimKOJls9CNUoHRS7QYaWfoER+reurCVRmZY5a
	l6tS742TNfYY5pfs6ZRuu2xZozdH0BQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-VRRpXADHOcORiPwiXaomag-1; Wed,
 30 Oct 2024 07:09:04 -0400
X-MC-Unique: VRRpXADHOcORiPwiXaomag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A73C19560B4;
	Wed, 30 Oct 2024 11:09:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A4A300018D;
	Wed, 30 Oct 2024 11:08:52 +0000 (UTC)
Date: Wed, 30 Oct 2024 19:08:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZyITwN0ihIFiz9M2@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyIM0dWzxC9zBIuf@ly-workstation>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 30, 2024 at 06:39:13PM +0800, Lai, Yi wrote:
> On Wed, Oct 30, 2024 at 05:50:15PM +0800, Ming Lei wrote:
> > On Wed, Oct 30, 2024 at 4:51 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > > > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> > ...
> > > >
> > > > It should be addressed by the following patch:
> > > >
> > > > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> > > >
> > >
> > > I have applied proposed fix patch on top of next-20241029. Issue can
> > > still be reproduced.
> > >
> > > It seems the dependency chain is different from Marek's log and mine.
> > 
> > Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
> > blk_mq_init_sched is cut down by the patch?
> >
> 
> New possible deadlock log after patch applied:

This one looks like one real deadlock, any memory allocation with
q->sysfs_lock held has such risk.

There is another similar report related with queue sysfs store operation:

https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
 



Thanks,
Ming

