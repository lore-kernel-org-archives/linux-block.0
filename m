Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835E28EC
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591354; cv=none; b=Dn0Vl2VmKOsCrgy7GVYrMrS9964Qv0GbjuZo3LVD2UrJnBz9Xy9ogzK2euPz4dbFgNEMv2Lf8SjMF88T1hIU/Fha5LxFe9v3YB4YtMHIlTqPWDZwyEqLpQr3HZE0TCVueP4bKRFOsrHlIuf+lDnR18woKqdzgW97Z7oUIgLpPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591354; c=relaxed/simple;
	bh=x6o11HgfCw63Oj8sACBMIx9/VqGjasbymGXBoKXjkZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO5Aha1ZM2YY2kReHd/P+O9oZtGTF45zgCQ9cEQoqefBQHgNskjBdCZ9Mmc5qzqHqTG7EboTwixRg1LSWUcF7legFPAq/r5kqKKKU58lDgH/GFvBs1X7iOY7TPoKHThbWS6rhhbEKQKiZl91upixeZzEslcqdTBl6rLtYU8EKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev9PBA2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev9PBA2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744591351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INuEAnMsIT9BhOalS2oIWXA8c6pF+9+2d/NxT8KpyuU=;
	b=Ev9PBA2wzbZMca3wXPI9cAid7LAEzgu5rE5zQqjmk3HvV8V5z8LJ66tJkZSTNNDVqPPw2r
	X6890lDIMCTSWey5+q6omzkzXtHxr9otBDPrNc7TYwXg/ZlVQl3HjfOd90ZMkM+o41UyPF
	b9pxfJdIkX4xBrLAHuK+plep7cyYeY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-pZ3n9T20ONeDFRUVPNUvKw-1; Sun,
 13 Apr 2025 20:42:26 -0400
X-MC-Unique: pZ3n9T20ONeDFRUVPNUvKw-1
X-Mimecast-MFC-AGG-ID: pZ3n9T20ONeDFRUVPNUvKw_1744591344
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 250AA19560B7;
	Mon, 14 Apr 2025 00:42:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A46C4180AF7C;
	Mon, 14 Apr 2025 00:42:19 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:42:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 03/15] block: move sched debugfs register into
 elvevator_register_queue
Message-ID: <Z_xZ5iV74Ar4nLP_@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-4-ming.lei@redhat.com>
 <20250410142720.GB10701@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410142720.GB10701@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 10, 2025 at 04:27:20PM +0200, Christoph Hellwig wrote:
> >  	lockdep_assert_held(&q->elevator_lock);
> >  
> > +	if (test_bit(ELEVATOR_FLAG_REGISTERED, &e->flags))
> > +		return 0;
> > +
> 
> This looks unrelate to the rest of the patch, and I also don't understand
> why it's needed as the callers of elv_register_queue don't change.

The check is actually missed, I will move it into one single patch.

Thanks,
Ming

