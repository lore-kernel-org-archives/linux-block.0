Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80928136F
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310986; cv=none; b=CvpE0utd4Vd3M4SLpAgWZAIRGSb3BwanKZoHkyr8Q+EY9y+E7sAFxFKqY7BLmeX6SUiNRIaVC461KIc8Ti869uwZahv/OvdLJXcpvPrPpQ28woXq2of/hCHo+2WnPAWKtE3qgYASQX0u+6vjeXQ6uHcpqweKENRhmS18hIo3Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310986; c=relaxed/simple;
	bh=HTKnEnOyNhGaaCSV8ePLqo+XLWkrpvK3Ja9Zk2icg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYOWGjLu4dcbq4XZ2Oys7Sit3HyYea/T8hyrXuHvweZbDKyCdDIwzMoerH6z6EZvnwes0AGH/kK7CtuwO3isp/V8gEWb81+aNKB55dG/9zYwwmx0PkVWFvFk3MwhsEKQB1NOKIjyMUayCdeAMvB7Dqmb0k8LpVPfjnIHctanE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6ww6/3W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6ww6/3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745310983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s36yVikPePWiSaoHWsydroo9bketI3mdsqKBQ5GYE0o=;
	b=I6ww6/3WfZQU3TmIRMNTAkQpCmnhLuWqKzCp5FdPCO/DAGWVhc4sEPx9UeTg9TvU1R4OgU
	RJZxEmlRHxcI4jOukiIkubfXFbIfas4A2pQJaXGOs83nw0XB4kCnbo9g+8PQxfCTMODMCh
	WQZfp3FAykUd3dbcqwf6hMHsFSykP1Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-Aq7rS-SHMjmbTSf-Y9FUbg-1; Tue,
 22 Apr 2025 04:36:19 -0400
X-MC-Unique: Aq7rS-SHMjmbTSf-Y9FUbg-1
X-Mimecast-MFC-AGG-ID: Aq7rS-SHMjmbTSf-Y9FUbg_1745310978
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AD4A180034A;
	Tue, 22 Apr 2025 08:36:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.157])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC411956095;
	Tue, 22 Apr 2025 08:36:13 +0000 (UTC)
Date: Tue, 22 Apr 2025 16:36:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V2 12/20] block: add `struct elv_change_ctx` for unifying
 elevator_change
Message-ID: <aAdU-LSFxLTcwwnZ@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-13-ming.lei@redhat.com>
 <20250422070739.GC30990@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422070739.GC30990@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 22, 2025 at 09:07:39AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 19, 2025 at 12:36:53AM +0800, Ming Lei wrote:
> > Add `struct elv_change_ctx` and prepare for unifying elevator_change(),
> > with this way, any input & output parameter can be provided & observed
> > in top caller.
> > 
> > This way also helps to move kobject & debugfs things out of
> > ->elevator_lock & freezing queue.
> 
> As pointed out last time, please move the entire loop body that
> calls __elevator_change from __blk_mq_update_nr_hw_queues into a
> helper inside of elevator.c, which means that this structure can
> be kept private there.

Please see the following patch of 'block: move elv_register[unregister]_queue out of elevator_lock'
in which elevator_change_done() has to be added, then the context structure
can't be kept as private any more.

> 
> Also please use a flags value with named flags instead of the various
> booleans.

'struct elv_change_ctx' has to be parameter, so it doesn't matter to
use flags value any more, and 'bool' should be easier.


Thanks,
Ming

