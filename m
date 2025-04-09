Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528B2FB2
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161004; cv=none; b=Dr/eV2V+35DF3G6Z/alML3635+IS3u7uxMNThYp10RmNmg3kFgJ3+z3/OQEQXas8Ui3PYXCXf4mPV24EmPgAytld39AmMSdbqxXe4AGhgRHYe6G151BTFYVpFXR2aJ6B98PGf/Veg+dOlcwSfxc62roavE8D0XkF8jB7/AIj9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161004; c=relaxed/simple;
	bh=PCTb8zrHnCYjIh6Uc/IpD0Tt48F6f9xr3dBXb1HAKBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVH5vwGKHU4yLS91FE/GcPC0JiW9OQOxM4liOdeige8G8YdyPAuBzKNiyz9+AZGtY3gCoPhQHjgvbKVe5+8mXrOK93+A1cJcSrbIfeUdaOoOOchAJQvfmbwX9DmuY5gKlLAzBSeHgaOhdLIMZcM5Td8t2RaG4ENSKAKSRBxsKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx0GyniW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx0GyniW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744161001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/bvoOwMCSXvHxY6UBgZ3uXIPkuq6pzaXuPsC3rgHco=;
	b=Lx0GyniWqN8gexKCkGQGPh4VR/JCDL+lpCo78z+cSN2Vscnzl3V5dTKTavQ9agrPMsq5Hd
	xHOs3KT5V7SMQuSBEsZLz6gIeEp4pdRYFz9Q/balZITjeDHgJLyF5k98+lFJwuvOWUG5lz
	Y4kajwUZuhpCWz9rMwXdfGm0ZXHt/LI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-Kvav9N7qN8apr_NQhZTYVg-1; Tue,
 08 Apr 2025 21:09:57 -0400
X-MC-Unique: Kvav9N7qN8apr_NQhZTYVg-1
X-Mimecast-MFC-AGG-ID: Kvav9N7qN8apr_NQhZTYVg_1744160996
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A483F19560BB;
	Wed,  9 Apr 2025 01:09:55 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99DED1956094;
	Wed,  9 Apr 2025 01:09:51 +0000 (UTC)
Date: Wed, 9 Apr 2025 09:09:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/2] ublk: don't fail request for recovery & reissue in
 case of ubq->canceling
Message-ID: <Z_XI2TdYF-HV9DIO@fedora>
References: <20250408072440.1977943-1-ming.lei@redhat.com>
 <20250408072440.1977943-3-ming.lei@redhat.com>
 <Z/V0+NnMBFlPGaBX@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/V0+NnMBFlPGaBX@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 08, 2025 at 01:11:52PM -0600, Uday Shankar wrote:
> On Tue, Apr 08, 2025 at 03:24:38PM +0800, Ming Lei wrote:
> > ubq->canceling is set with request queue quiesced when io_uring context is
> > exiting. Recovery & reissue(UBLK_F_USER_RECOVERY_REISSUE) requires
> > request to be re-queued and re-dispatch after device is recovered.
> > 
> > However commit d796cea7b9f3 ("ublk: implement ->queue_rqs()") still may
> > fail any request in case of ubq->canceling, this way breaks
> > UBLK_F_USER_RECOVERY_REISSUE.
> 
> This change actually affects UBLK_F_USER_RECOVERY as long as FAIL_IO
> isn't set (regardless of RECOVERY_REISSUE). RECOVERY_REISSUE only
> changes behavior for requests that are already in the ublk server when
> the ublk server dies, but the code change only affects requests that
> come in after ublk server death is already detected. At that point, both
> plain USER_RECOVERY and USER_RECOVERY|USER_RECOVERY_REISSUE should see
> requests queue instead of completing with error. See below code
> snippets:
> 
> static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> 		struct request *rq)
> {
> 	/* We cannot process this rq so just requeue it. */
> 	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
> 		blk_mq_requeue_request(rq, false);
> 	else
> 		blk_mq_end_request(rq, BLK_STS_IOERR);
> }
> 
> /*
>  * Should I/O issued while there is no ublk server queue? If not, I/O
>  * issued while there is no ublk server will get errors.
>  */
> static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
> {
> 	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
> 	       !(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO);
> }

Indeed, will update commit log.

> 
> > 
> > Fix it by calling __ublk_abort_rq() in case of ubq->canceling.
> > 
> > Reported-by: Uday Shankar <ushankar@purestorage.com>
> > Closes: https://lore.kernel.org/linux-block/Z%2FQkkTRHfRxtN%2FmB@dev-ushankar.dev.purestorage.com/
> > Fixes: commit d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> 
> Will this upset anything parsing these tags? The syntax I've usually
> seen doesn't have "commit," i.e.
> 
> Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")

Will fix it in V2.

Thanks
Ming

