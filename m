Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8F25DAE8
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206300; cv=none; b=qKEDKQOdtl6bS8ou6TYcK315HmYr6ewTmEf6xUlIcmtGX7erTf+PocbZcFUBoG87GayUiwX1z184IAiqNWn7Hd6eCwfoHMC8PNvl4Z1Goi8LNiWSHqAAyKt86ua3eWSPz1roZ5PLoX2mkzSWC8QEnJIeuNfykuXYIFwXgtGj0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206300; c=relaxed/simple;
	bh=uTFkzj67ddRxFFhZq157cYNrnjsukUgynX3BYIAV7zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks3tuueT/Iot5yTN/FMc8di45H6b/W+e5Iqxja1fZ9jf5+phx+LdHvZ7wbVQzrgvzWK+UGRngHSejI+vFZe4y7yWpqMg8zYshws+ecuujUfA94ck63hAp6zlSuy14Hpq2WJ+hJrFlZpzKOF0DnGCOGFTKZnhDxV/YZNlIvEkhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WP4uN7No; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP4uN7No"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744206297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c4rRcuYcKyDjp3Vzjp4yHtgd6P/QYWgzDtJiPE416Ws=;
	b=WP4uN7NoOne3dU+nsTorkw7drrUy9S+lrza/bSr0Hsp2Y/H+xa7bFaHiue364hRsX5Ga2f
	qdaOlaSQWCoQmO3RbL+cw3uFAy+C+Bv3tQL8jtn1d/ouig42J3wdp8UKHn+Ik0IRIPMPO1
	NAF8hSUMpNqTF9jSAJxom/YhHrZk5KY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-jcuWI2gwNBa5F-akOfcCeA-1; Wed,
 09 Apr 2025 09:44:55 -0400
X-MC-Unique: jcuWI2gwNBa5F-akOfcCeA-1
X-Mimecast-MFC-AGG-ID: jcuWI2gwNBa5F-akOfcCeA_1744206295
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90EA8180AF57;
	Wed,  9 Apr 2025 13:44:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F9A1955DCE;
	Wed,  9 Apr 2025 13:44:48 +0000 (UTC)
Date: Wed, 9 Apr 2025 21:44:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, djwong@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <Z_Z5ydIl7UGkFrz6@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> vfs_iter_{read,write} always perform direct I/O when the file has the
> O_DIRECT flag set, which breaks disabling direct I/O using the
> LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.

So dio is disabled automatically because lo_offset is changed in
LOOP_SET_STATUS, but backing file is still opened with O_DIRECT,
then dio fails?

But Darrick reports it is caused by changing sector size, instead of
LOOP_SET_STATUS.

> 
> This was recenly reported as a regression, but as far as I can tell
> was only uncovered by better checking for block sizes and has been
> around since the direct I/O support was added.

What is the 1st real bad commit for this regression? I think it is useful
for backporting. Or it is new test case?

> 
> Fix this by using the existing aio code that calls the raw read/write
> iter methods instead.  Note that despite the comments there is no need
> for block drivers to ever call flush_dcache_page themselves, and the
> call is a left-over from prehistoric times.
> 
> Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")

Why is the issue related with ioctl(LOOP_SET_DIRECT_IO)?


Thanks, 
Ming

