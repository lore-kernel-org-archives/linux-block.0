Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE017A2FE
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956832; cv=none; b=Zrs/bhOIZv2dCow5tZg4fx6wI5B10LwmDgYUpoi2xrjjwKnlILg7OGQuWYyGpUkqkln+kwP2nrkRIfqoxeQeRPmQ/0fCGh63/61YKWjgQgdYP9lAsisAvXIX7F5vyJvHYkULfUWwpriSHd7VkQvm3W5PWzGJ0hJcG9IBx11g2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956832; c=relaxed/simple;
	bh=n4d7s4qcXE0ONQNWMNA/UN8TN/rqYQI+wiHcLG/hnzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUn/H+g/yz8zbrLL+OPmzSHK9Vj0/+C6+v0W/I+6MSUOOfT9slH98F3ATZWTqcW1D/q9vN5cQiMRw/rdEM4pMyZJ1+6RkmXwSkd4rpLdsUjtdzSbi7l2NjqgqG7FffFI1yN3sNlc3/M1SVptS9kz0omzNkbcYY0TFsLRnEC8YyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dleid41T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dleid41T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739956829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnWWeTVlKxODuPSlJupw9+xJIdk3WU9awhRGX0qHaww=;
	b=Dleid41Tws+ss50nyUdMYCBOGx/HxTl8tWZmX0rfuF3okXJGlss9QN6DJlbNyR94bzaJsb
	AN+r46dCGVvzFbLcDeyVavhH5Bzeekqe9LJamtWfWSKYv6mhSXUbmD2SE1hRvwceNX++qn
	nk3e6qvvBKvqkPXKj7Wt0qeXCKUFsCU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-2AhLoiQ6PuOoqu9qXH4ccQ-1; Wed,
 19 Feb 2025 04:20:25 -0500
X-MC-Unique: 2AhLoiQ6PuOoqu9qXH4ccQ-1
X-Mimecast-MFC-AGG-ID: 2AhLoiQ6PuOoqu9qXH4ccQ_1739956824
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAC2F1979057;
	Wed, 19 Feb 2025 09:20:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D901800359;
	Wed, 19 Feb 2025 09:20:18 +0000 (UTC)
Date: Wed, 19 Feb 2025 17:20:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <Z7WiTZKIKBeFHf4I@fedora>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com>
 <Z7R4sBoVnCMIFYsu@fedora>
 <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
 <Z7SO3lPfTWdqneqA@fedora>
 <20250218162953.GA16439@lst.de>
 <Z7VO-z1cZfFLYaMt@fedora>
 <c83dff74-e1d8-4f17-979d-9f5e9ca16adf@linux.ibm.com>
 <d00f7633-c54c-4abf-b36d-eb941a6dcc5c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00f7633-c54c-4abf-b36d-eb941a6dcc5c@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 19, 2025 at 02:26:49PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/19/25 2:04 PM, Nilay Shroff wrote:
> > 
> > 
> > On 2/19/25 8:54 AM, Ming Lei wrote:
> >> On Tue, Feb 18, 2025 at 05:29:53PM +0100, Christoph Hellwig wrote:
> >>> On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
> >>>> IMO, this RO attributes needn't protection from q->limits_lock:
> >>>>
> >>>> - no lifetime issue
> >>>>
> >>>> - in-tree code needn't limits_lock.
> >>>>
> >>>> - all are scalar variable, so the attribute itself is updated atomically
> >>>
> >>> Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.
> >>
> >> RW_ONCE is supposed for avoiding compiler optimization, and scalar
> >> variable atomic update should be decided by hardware.
> >>
> >>>
> >>> Given that the limits_lock is not a hot lock taking the lock is a very
> >>> easy way to mark our intent.  And if we get things like thread thread
> >>> sanitizer patches merged that will become essential.  Even KCSAN
> >>> might object already without it.
> >>
> >> My main concern is that there are too many ->store()/->load() variants
> >> now, but not deal if you think this way is fine, :-)
> >>
> > We will only have ->store_limit()/->show_limit() and ->store()/->load() in
> > the next patchset as I am going to cleanup load_module() as well as get away with show_nolock() and store_nolock() methods as discussed with Christoph in 
> > another thread.
> > 
> 
> Sorry a typo, I meant we will only have ->store_limit()/->show_limit()
> and ->store()/show() methods. Also, we'll cleanup load_module() as well
> as get away with show_nolock() and store_nolock() methods in the next 
> patchset as discussed with Christoph in another thread.

OK, that looks much better!


Thanks,
Ming

