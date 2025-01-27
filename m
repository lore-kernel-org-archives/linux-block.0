Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4917BA1
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000567; cv=none; b=mKY1Be5uQtJXhYbsuGMgjxsAnoiOY9bAojKkX4CZ4BpqvRCisszQdiDqCPl66XsZtQXjG+5a9gfK+RQ+Q8EaWNkkYTuiDdeWHEsKvZ7W972k+LachGPFIumhLJoK+0lYcrI+JGeanqbBCkZMBmuYWR+Re6B2LKlm32GcJBPRMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000567; c=relaxed/simple;
	bh=fZF7B91NYTsHaZ7DGIpW7kTE9R7yjMdrf4ME515/WDs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KBD1BWHTzgudPLkRfjqOTD8FqNE9nIgnTm/LkUrrYTG3eoTE/+kDM7XipePR14divLAq9gPbSi0tTvquU/XAQPz6vP+0csXJFbkLEWix6o0+qjSMeAJ4Bn5Jx7mWC/EKehy68wtXBtQaruZ2Ev+3uz8g2PwNdbYCE1KOMm9WS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/kSMOlE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/kSMOlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738000564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NtkL2XkEzqj46VL+eqj4l5IKFcws6Me10SqKUziFnbg=;
	b=c/kSMOlEnd7yvBOWgraNSu+Yc3f1LLrj/kaDtMcrw3IMEiwPN7paJgat+0h14gI1He5IQB
	hyBqBoPprBkJEqm45hhNTxIT++IMvkj7kXAWW/w+Z0KMOHFSIDfRn2joTBA5YJUGbNk/pA
	qAAG696w+kuraDfTBwKg9xYjibpVEj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-FpCtCt6EMh2qXHtxyZiQWg-1; Mon,
 27 Jan 2025 12:56:00 -0500
X-MC-Unique: FpCtCt6EMh2qXHtxyZiQWg-1
X-Mimecast-MFC-AGG-ID: FpCtCt6EMh2qXHtxyZiQWg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 194CA19560B0;
	Mon, 27 Jan 2025 17:55:58 +0000 (UTC)
Received: from [10.45.224.57] (unknown [10.45.224.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D471195608E;
	Mon, 27 Jan 2025 17:55:55 +0000 (UTC)
Date: Mon, 27 Jan 2025 18:55:50 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
    Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v17 02/14] dm-linear: Report to the block layer that the
 write order is preserved
In-Reply-To: <785fd5c7-e0a2-47f7-a7b0-f10c24142dfa@acm.org>
Message-ID: <c73ed1d4-b580-be42-48a5-dfa4c920d192@redhat.com>
References: <20250115224649.3973718-1-bvanassche@acm.org> <20250115224649.3973718-3-bvanassche@acm.org> <b0717657-8ecd-0fcf-4ca1-eb9f91ad01cf@redhat.com> <785fd5c7-e0a2-47f7-a7b0-f10c24142dfa@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 21 Jan 2025, Bart Van Assche wrote:

> > How is write pipelining supposed to work with suspend/resume? dm doesn't
> > preserve the order of writes in case of suspend.
> 
> That's an interesting question. I expect that the following will happen
> upon resume if zoned writes would have been reordered by dm-linear:
> * The block device reports one or more unaligned write errors.
> * For the zones for which an unaligned write error has been reported,
>   the flag BLK_ZONE_WPLUG_ERROR is set (see also patch 07/14 in this
>   series).
> * Further zoned writes are postponed for the BLK_ZONE_WPLUG_ERROR zones
>   until all pending zoned writes have completed.
> * Once all pending zoned writes have completed for a
>   BLK_ZONE_WPLUG_ERROR zone, these are resubmitted. This happens in LBA
>   order.
> * The resubmitted writes will succeed unless the submitter (e.g. a
>   filesystem) left a gap between the zoned writes. If the submitter
>   does not follow the zoned block device specification, the zoned
>   writes will be retried until the number of retries has been exhausted.
>   Block devices are expected to set the number of retries to a small
>   positive number.

On suspend, dm_submit_bio calls queue_io to add bios to a list. On resume, 
the list is processed in order and the bios are submitted, but this 
submitting of deferred bios may race with new bios that may be received 
and directed to the underlying block device - so, the new bios may be 
submitted before the old bios.

Mikulas

