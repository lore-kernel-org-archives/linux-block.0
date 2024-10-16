Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072F3A8F0
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085721; cv=none; b=VQGuFvUa40lFHP/PKDJrts86tYXbgF0pIeH1OgROoZl+kx3oMvs+U+en6ig/E1A6DgUIZm4I4FHF3avJaBg6yoSi06+0RK2+14DZBdFwYRMvqqInJMaq1U47h2lHvbAtBG3zc7xXd6p2gIWKa4yUziZS95SWLdF78Ev1AlrWXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085721; c=relaxed/simple;
	bh=51Np2I/hOH0B4FOqOzjreLpr8/9GlN32VK6QJT13ZY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIz2H2Zn6c9BEvatjKTuJH/5ARQghDsd/BdceQntroWH1lnelsRDX8IkDNwfmmySqmXZ9X26It6MWVjihNLYbV0Me5Q5o4NU/gczvUUuCuLc8L7FHWSir/uj082N3aO//qdLyg97xQz2KuVONNvm+iTiCFa3D5WclhHbHPIbDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWRSlQY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWRSlQY6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729085717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=If+Fh/ak7r1pMttiNvSZXD3oMPpldJ6k1mot0mcAUAE=;
	b=MWRSlQY6SLJHwXXI2Ibq6qkgJ30OWZptul5yLfKjFs+qpEhHkbsofDjUEWZ5/hbfzjkYBu
	lbBH/kRLdTvkgJEV7TOTnqFNP+gneceRKoHnOAEV9BBAvXa7JRTdtE9gZgXYhcDQi6zRre
	Bd/sdd6I8GjCI8jBczfrkX+aPahUgUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-iIIk1BaxOuSnL92TUddraQ-1; Wed,
 16 Oct 2024 09:35:14 -0400
X-MC-Unique: iIIk1BaxOuSnL92TUddraQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7788D1954AF9;
	Wed, 16 Oct 2024 13:35:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 854B31955F41;
	Wed, 16 Oct 2024 13:35:08 +0000 (UTC)
Date: Wed, 16 Oct 2024 21:35:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <Zw_BBgrVAJrxrfpe@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009113831.557606-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 09, 2024 at 01:38:20PM +0200, Christoph Hellwig wrote:
> When del_gendisk shuts down access to a gendisk, it could lead to a
> deadlock with sd or, which try to submit passthrough SCSI commands from
> their ->release method under open_mutex.  The submission can be blocked
> in blk_enter_queue while del_gendisk can't get to actually telling them
> top stop and wake them up.

When ->release() waits in blk_enter_queue(), the following code block

	mutex_lock(&disk->open_mutex);
	__blk_mark_disk_dead(disk);
	xa_for_each_start(&disk->part_tbl, idx, part, 1)
	        drop_partition(part);
	mutex_unlock(&disk->open_mutex);

in del_gendisk() should have been done.

Then del_gendisk() should move on and finally unfreeze queue, so I still
don't get the idea how the above dead lock is triggered.


Thanks,
Ming

