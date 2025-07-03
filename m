Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD730145323
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508537; cv=none; b=Xj/HBAa2s9MeEOv0muq1VcE5mdTXp4BhXJeGpO00huDaqXs++WnjaKOtriBa7ipqMPATtuwmvGFaNtgRXTIVXMZVt2FjUrOJacmTimkfRguRgx1nOVkiZm8uLiB+YRHW+l51S7RKvC0wpli6rybnAAXlev7nLNEgeI2aZIF2+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508537; c=relaxed/simple;
	bh=xuxmoyBv6Hc83w0VaD6m722C+zV2bRMFHcP9kM94acA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvyIMbYenyPkKyUQErbOqK4PzJ6/EAlgUHJXONcd2j/xBzpGquJlYEBXT4+JFZJBhAVeAKLB/WlOzynyLeoSNkq+rqrJ8YQf6FQnbx08wo3kRplSr0XBxyl10rlT+xSvQKZkQCGZT8huuQo0dMLCNEDDlIfqYekD7ZZcjIu6qxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSJOqebv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSJOqebv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751508534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/M29umMbsMChXKdFRpWTtKhVV8sXKJDMlvqyNyuZTXE=;
	b=YSJOqebv4W5/gFlHMi1fYdwwwHjj/rAZ8zeSy1QhP/nSb+Zhd0tvpYj1hf98zMZPtnsuhu
	u99jzq+9Ia9quAx0cvGv2UZTFM43OnD+x9A3/fcA8McM6gs7Fgc2duOEn+Lc41Yf3olBIZ
	ZitaUQQhCetSQvAWiySongbn/k4dsHU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-9pv0A832OzGQ9SjaN3FE1w-1; Wed,
 02 Jul 2025 22:08:51 -0400
X-MC-Unique: 9pv0A832OzGQ9SjaN3FE1w-1
X-Mimecast-MFC-AGG-ID: 9pv0A832OzGQ9SjaN3FE1w_1751508530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3877180034E;
	Thu,  3 Jul 2025 02:08:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171F9180045C;
	Thu,  3 Jul 2025 02:08:44 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:08:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Remove queue freezing from several sysfs
 store callbacks
Message-ID: <aGXmJg-ZIuFO9WnP@fedora>
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250702182430.3764163-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702182430.3764163-2-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jul 02, 2025 at 11:24:28AM -0700, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.

Please add commit log why freeze isn't needed for these sysfs attributes
callbacks.


Thanks, 
Ming

