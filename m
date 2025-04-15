Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9A2DFA2D
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688478; cv=none; b=HeKYcpx1vo3ivZNcTa86mv2b4DhQdF6Q/L57IzEr/gstkn99rjZuD2PFx3Deab0is0G99zxgP4Rvh2I9gKnNihWS7jSoB/dmAWBVTunYzPd8haXmjF5wUHFBZgErGsWQM1PLEbNPYO3Z7rkO6Ds5Rw0z4gNAe0bbypFGT8cuW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688478; c=relaxed/simple;
	bh=DeAcC7qb9J5+OWpC3mHQ35/IgV9CvYwBBKInwwwE7wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg3Qbo2MSRrr4ibSOWTwjpYFKX+2AjhSSWQeOhFPT7qOGY29azOJo9yMa96u89yKsiNFbsnbaeBkBrmpuYI5HOETedCAaRKyADxWRtOlCfnpkbEH5h3nPyNknWWCoaMwHe3X6rdr5LbW6i2OOgtKusqwSxlk8gX53byZdsIBdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhNLHymT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhNLHymT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744688475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOim+E6H7+9bD97lNM+whuRWC0q1RKmjCT4iiA7s74g=;
	b=dhNLHymTSijiFuHz2yDMbiJ0gfEbWEXs4zEZRGyHBK5w6EyWjgIkCTMndWUdQKFp1AI/ir
	VweeWVOduHNtPEb6qDqhJgA3qUxHjY/SYbFAzcGWNWPaXDl8Pa/K9Y1t4WvuLl7/b7jLzL
	InfcUtagXiDNoHSWCjtzp6o5/ceBK08=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-YJTTBBgFMz2AGcGGeGeqZA-1; Mon,
 14 Apr 2025 23:41:11 -0400
X-MC-Unique: YJTTBBgFMz2AGcGGeGeqZA-1
X-Mimecast-MFC-AGG-ID: YJTTBBgFMz2AGcGGeGeqZA_1744688470
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AE421800259;
	Tue, 15 Apr 2025 03:41:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 079681956094;
	Tue, 15 Apr 2025 03:41:05 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:41:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, djwong@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <Z_3VTGpuLQ1BcqvG@fedora>
References: <20250409130940.3685677-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409130940.3685677-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> vfs_iter_{read,write} always perform direct I/O when the file has the
> O_DIRECT flag set, which breaks disabling direct I/O using the
> LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> 
> This was recenly reported as a regression, but as far as I can tell
> was only uncovered by better checking for block sizes and has been
> around since the direct I/O support was added.
> 
> Fix this by using the existing aio code that calls the raw read/write
> iter methods instead.  Note that despite the comments there is no need
> for block drivers to ever call flush_dcache_page themselves, and the
> call is a left-over from prehistoric times.
> 
> Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

