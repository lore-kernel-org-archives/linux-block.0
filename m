Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AE41775
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034357; cv=none; b=UxTKCc0dWtMf7lK9TigDPwXfZA1by8MPhDAzi7XKqFDSqHoCvxb3phTYDSdTMbtySKQ9N4hZTvzfdni/2XN2tu+zN6gSeR8a8G5HAAjoI+IBNehtUBmDa6c3lgBYzrSf9b0wUyd7t7kO90CjEWFO5Ndewnz//88SUMQeJK2Xx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034357; c=relaxed/simple;
	bh=QXRs1XG3Cg0RJG+JLl6/Lfrku4zuZIZW3mQC5Q6PTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJgkFuBeELTAG8/OMiYZ50EzRkqX/bwOW3+ocx+5bMVQa+pN9FAcK4hIOpy/Iqe/hoqtWx+zqPZUFaKSDhaf6KsQI2FBy9c9ccLCPOpeK174avEDGmgHIQb/SJiLmm7//biTlwsHBYiJUPpwQA5uwHvmIdq/xZDW8Ha6GrOoXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALGG3Obn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALGG3Obn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711034355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XfmCl/jdY2RzW3u/YlYakoeV/ii2QR0ZcnoGIpieLk=;
	b=ALGG3Obn18dSWVonFOpmbRa/rTqY89/zMwua8YDdvm/TSNhOiYg8kIiYZ4mZKfrk6LQKle
	ZAZs/tc7sZ7zkKfR7i3kUy1j+Sgs9OoCLyth53iV94utnPXlRVlaS4NFKbuO6Wj+HZNDWR
	BQwvZB66FduMQnNfJ5X6hW5DVHRWzh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-hIHaW3CWO6eyLD_9WYm37Q-1; Thu, 21 Mar 2024 11:19:10 -0400
X-MC-Unique: hIHaW3CWO6eyLD_9WYm37Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992528007A6;
	Thu, 21 Mar 2024 15:19:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A00A540C6CB3;
	Thu, 21 Mar 2024 15:19:07 +0000 (UTC)
Date: Thu, 21 Mar 2024 23:18:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZfxP03jzjHXAkW4C@fedora>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <36a990dd-589c-4da8-a41b-783a834c3797@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a990dd-589c-4da8-a41b-783a834c3797@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Mar 21, 2024 at 08:14:24AM -0700, Bart Van Assche wrote:
> On 3/21/24 06:16, Ming Lei wrote:
> > +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> > +{
> > +	unsigned int bs = q->limits.logical_block_size;
> > +	unsigned int size = bio->bi_iter.bi_size;
> > +
> > +	if (size & (bs - 1))
> > +		return false;
> > +
> > +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> > +		return false;
> Why "size &&"? It doesn't harm to reject unaligned bios if size == 0 and
> it will reduce the number of if-tests in the hot path.

It doesn't make sense to check the alignment for bio without data.

> 
> Why to shift bio->bi_iter.bi_sector left instead of shifting (bs - 1)
> right?

unit of bs is bytes, so .bi_sector needs to be converted to byte first.


Thanks,
Ming

