Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10964A
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488138; cv=none; b=k6uv00xKMTLLxKxGwWxvJKcYdDB2aT0dl86lVm8fT36x4GKk8N5MFhPSh9ymaW0HSg50Xhvx0yKMxlu6CSFZ3pE9Hzu0gkzMdyY5+bBMRYXmNuLNIEYgaLt8j8l/rxztXx9U4aQ69wXClbpcKjPC5K5QiMSzTdHAoKbx+ctMX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488138; c=relaxed/simple;
	bh=ehpO5fG2BSF+1lugs8ItCmF5LmwD7qIsCroqaCt6VqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUie2wdxfYBGJyZep1se3mSIv/cYYwx8KF3rrQzQ6NkHAfkzZB8QUSae+VoQiRoOmVeS57T2pcrxB1YT+DdM13NBkE+L6Q+mDG3roCcVKa6T4zKNV6Yv+Rtqmb30Xzams6T5E2LpJ9ls/Tq9CqFUJ0cutWEdruwAkWYI+fXCmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBeD5yfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBeD5yfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713488135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nWxMOFlJzgP0C20kJOnoeu6yGkyD+A/iEAYOmCMiLrQ=;
	b=UBeD5yfxyc4IVagP8dDRQtYlV47NGI+aoClxthe5dKI8Voil5wwpEbNCKJvMsCwq45XEDv
	9YEsiyc7e7Lo8DT25eLAljBvliaQsRH3xmUhA64+iGsTiQxGUieGGL3U5P8cLUqjiL+jNv
	grbPz8+jOdf8gScwjUhh9T5kNWttu8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-hjxNktGTP-KOdvBqf6dUpg-1; Thu, 18 Apr 2024 20:55:30 -0400
X-MC-Unique: hjxNktGTP-KOdvBqf6dUpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC5BC18065B3;
	Fri, 19 Apr 2024 00:55:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A79A82166B32;
	Fri, 19 Apr 2024 00:55:26 +0000 (UTC)
Date: Fri, 19 Apr 2024 08:55:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 0/9] io_uring: support sqe group and provide group
 kbuf
Message-ID: <ZiHA+pN28hRdprhX@fedora>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408010322.4104395-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Apr 08, 2024 at 09:03:13AM +0800, Ming Lei wrote:
> Hello,
> 
> This patch adds sqe user ext flags, generic sqe group usage, and
> provide group kbuf based on sqe group. sqe group provides one efficient
> way to share resource among one group of sqes, such as, it can be for
> implementing multiple copying(copy data from single source to multiple
> destinations) via single syscall.
> 
> Finally implements provide group kbuf for uring command, and ublk use this
> for supporting zero copy, and actually this feature can be used to support
> generic device zero copy.
> 
> The last liburing patch adds helpers for using sqe group, also adds
> tests for sqe group. 
> 
> ublksrv userspace implements zero copy by sqe group & provide group
> kbuf:
> 
> 	https://github.com/ublk-org/ublksrv/commits/group-provide-buf/
> 	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf
> 
> 	make test T=loop/009:nbd/061:nbd/062	#ublk zc tests
> 
> Any comments are welcome!

Hello Jens and Guys,

Any comments on this patchset?



thanks,
Ming

