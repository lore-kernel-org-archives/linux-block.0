Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41007BA53
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055241; cv=none; b=Kc45EoxeBdghYEVcJvvtx6uYxoCoZHFf/+4ZjESdzUtZOI+Q7lLsVr5SkDCf9mRTBmtpCxNzBRVh/9SaA2xlDrNVsu19FS+F7nXVwwsCkEHo0QkIZyoFN1BUgC71H174bXpA2kI6GdkDp8UoS0cUVI+SU0wdQf3MJmCeHpm/v/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055241; c=relaxed/simple;
	bh=buULX/biLNfpQWt9Mna3yQW1BJEl70+0XF/7gWHaAEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edmDc+UI0PFqIVB0pjk8U5xBLbflW/hfvcsecf2w50AqNFOvV3F2r+ReDUPyNczkm7TKaz9b9TGBL8pLdgZ9jbDOQONr1hK9Je/iUEPaMLOTcnVUJ+MIgRV2vN9aDjdmRT+axppitQd7F2Mr1YhDGl3TyztQulctn5qWjwbamok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cr4HfB4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr4HfB4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741055239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gevkeJNrT8XLhEqQ0slpt2KmluU7L0uyIyBEiHMMuN4=;
	b=cr4HfB4+FjAfYBcqIZuDvTrGrOC4+0Vuq6oaC8zPEGtjjaa1g8vWjERkJjvDebqUzJDA/o
	19XK57NOoJYN8bXw8RuUJFBsnLRBjyRNGvKMX6GidIVSwd1hQExnzla3+xdftXADysbowm
	0+Pw8LnvsDqCGN1TQjC8eppt98zH/00=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-tCNgY_YvPmim-NmOeE4VOg-1; Mon,
 03 Mar 2025 21:27:16 -0500
X-MC-Unique: tCNgY_YvPmim-NmOeE4VOg-1
X-Mimecast-MFC-AGG-ID: tCNgY_YvPmim-NmOeE4VOg_1741055234
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 919A11800877;
	Tue,  4 Mar 2025 02:27:14 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2C66180087C;
	Tue,  4 Mar 2025 02:27:08 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:27:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 6/7] block: protect wbt_lat_usec using q->elevator_lock
Message-ID: <Z8Zk9l8sgYS6LeZE@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-7-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-7-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 26, 2025 at 06:09:59PM +0530, Nilay Shroff wrote:
> The wbt latency and state could be updated while initializing the
> elevator or exiting the elevator. It could be also updated while
> configuring IO latency QoS parameters using cgroup. The elevator
> code path is now protected with q->elevator_lock. So we should
> protect the access to sysfs attribute wbt_lat_usec using q->elevator
> _lock instead of q->sysfs_lock. White we're at it, also protect
> ioc_qos_write(), which configures wbt parameters via cgroup, using
> q->elevator_lock.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>


Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

