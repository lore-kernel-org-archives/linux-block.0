Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656A3595C
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055529; cv=none; b=NkeQDgtNvKajYPrexFL8mmfBNX+MdUNiDryYXX3a4nf08BxNxI6gje9xYbqEMm4b+atuhsOpFSmu3Z3HjeIkFSO3dD4noSzfIP58UVypcAjNfuGWsgaKAkIyi3zhS8lsuNBc1YUxQ4rxx+k9uWpX0k2jQKHrGlzv/4tqJj+jhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055529; c=relaxed/simple;
	bh=QfMusq5MH/Tsn0V/bJvNcEle8wyKC7nFpRLhUbJQt3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWYeCttLWVujRMxESb96o/batSiQO6WpDYctDn4dib1eRLZoy87ObzmZFH8oETjepEOCU4iOtrO94SMUdvMUApLzlx8oLtS3zoaI7nCQsq4YiY5zsKWJdkKUliu59zhBDfw4znhRJKAJ5ltfZZhOQqIXKV12AWo2p0wup77PJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tn5lxMqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn5lxMqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741055526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tM3+yw2MzUdlDaAmKXln52aAQPa0wkKU6AdHg+swWf0=;
	b=Tn5lxMqEZU6PhQFiTeH3IKzrTtwlOG5UYzXB0ffD140YSoiWz9kBCL9qmvA9Ms36gi7PCT
	ujC8Ne83TQ75ZCdaAwrQNgpXeHENkU34ZfmIUnFGsPQWpIvRoqUcwXh2mMp32yr59RpqaQ
	LqZDDKxyMOM8mYzeIDnmUIY/4pzeP2w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-hkM2Y7UjOe66L_X6Som6yQ-1; Mon,
 03 Mar 2025 21:32:03 -0500
X-MC-Unique: hkM2Y7UjOe66L_X6Som6yQ-1
X-Mimecast-MFC-AGG-ID: hkM2Y7UjOe66L_X6Som6yQ_1741055521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94ADF1954B1D;
	Tue,  4 Mar 2025 02:32:01 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A47D3000197;
	Tue,  4 Mar 2025 02:31:54 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:31:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 7/7] block: protect read_ahead_kb using q->limits_lock
Message-ID: <Z8ZmFJKu2uBgZgDl@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-8-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-8-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Feb 26, 2025 at 06:10:00PM +0530, Nilay Shroff wrote:
> The bdi->ra_pages could be updated under q->limits_lock because it's
> usually calculated from the queue limits by queue_limits_commit_update.
> So protect reading/writing the sysfs attribute read_ahead_kb using
> q->limits_lock instead of q->sysfs_lock.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

