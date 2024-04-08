Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BE51C34
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562158; cv=none; b=GFHG+sYckbKX8So2eof6/bICoC0Prz+Bw2M9XHsVsj/ZhDg62pE/6Fd9/WdzkmSlByDOn/UPCg+LySO7WcqnqiKkrK2cl/qoGP1C6Z0iMRyVRv2GEe3zyFIBXK2l/K1sJL9DThhECv6B3XsbnPMaYHucFXfuFjwGcqHMHjAerLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562158; c=relaxed/simple;
	bh=RNrZ83nHh9K9DQlyMZOl7ilVCR/Flf1Waw9CU4gScus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVdfWPfO544dXQG4Pb4Uy+8+1iSe3pm9vHXZNxuKrSmkUGQoTcwPcsSNNHK2QB8k96sGZATbpOdAStkm7WqmHn4i1Lf8+v7MtgSZjOVK6MZvhZUk6IzKdAhMiVcM6UpKmVN+fuXgcNScuS/KfwbV2mjpU+Ks60nLdE4jsQHe71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YK0fgGee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK0fgGee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oUqnUBMC+52eiLqxJ8y1FQYEbDUebxOr1a1G9nKZtno=;
	b=YK0fgGeeyXOHkomvLwAKE9Vlorv9CQenVuyc4aGTJ5WH+bGK2usky18GH10t4hiHb09g/Y
	+nF6eM6pOUCBRyU0DbPLTKlK7qxaSe6Y0cl29KJtNmT94pMrRCrgk9FNlad/gdO8Vx67vY
	UrpPgBHcrg5KwYvQhYXDKHrsqdFKJEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-A14Zao8jNvSMDF3axh4A9w-1; Mon, 08 Apr 2024 03:42:32 -0400
X-MC-Unique: A14Zao8jNvSMDF3axh4A9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BF2E806603;
	Mon,  8 Apr 2024 07:42:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C9B210FCEE0;
	Mon,  8 Apr 2024 07:42:29 +0000 (UTC)
Date: Mon, 8 Apr 2024 15:42:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] block: fix q->blkg_list corruption during disk rebind
Message-ID: <ZhOf3RxSWgLRZYhP@fedora>
References: <20240407125910.4053377-1-ming.lei@redhat.com>
 <ZhOHhVlfgj7ngHjH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhOHhVlfgj7ngHjH@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sun, Apr 07, 2024 at 10:58:29PM -0700, Christoph Hellwig wrote:
> On Sun, Apr 07, 2024 at 08:59:10PM +0800, Ming Lei wrote:
> > Multiple gendisk instances can allocated/added for single request queue
> > in case of disk rebind. blkg may still stay in q->blkg_list when calling
> > blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.
> > 
> > Fix the list corruption issue by:
> 
> The right fix is to move the blkgs to the gendisk as there is no use
> for them on a request_queue without a gendisk.

The fix needs to be backported to stable, so it isn't good to fix in
that aggressive way, especially last time your attempt failed, please see
the revert commits in my last reply to Yu Kuai.

Thanks,
Ming

