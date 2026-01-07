Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE632470A
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779322; cv=none; b=ZLf0jIic+ubgiiRw/t9NzjxncoLxRmizbHTJaq2EYDOlfKXbYe5GGGkYMCLr2fHjWIv0HPOJHuWhTcLc4REqLrnflzs0EagKiwozRaSrJVymD317W7DwO1lI6+DhfahhliZwNrNRizxLsSSWrMH0w/QrevKjjeHorQXckz8WrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779322; c=relaxed/simple;
	bh=uVRmdGCSayyGjI/b7AL/T79yXt1DSW5tjzBwgib8s0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPeESHLpIJelKTDL8AIkcuVwl3pxcbEyemdBd39t5AJqqCHbctFfyG99Eur3Wrv7IpxKlWLySarlilmAQ+r9vOxKsgUC79bXmNOhzr64fPLx/fTje6cNsyNaG7pyjSNSF/f1NxA32CrbwYQPp0Kd+NFvjbD6Pz7p/iBuZb3R9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JR8EAZK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR8EAZK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767779319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUpP78PSALste0yX423rkzHxQgZmH0i5Q7OsoeOml6w=;
	b=JR8EAZK/+I+DF4YHri+3KI24ndxPSszfI6UY2XRxRbiBkGa52AYdn6SGkQO0tjr7Blx5H6
	DPEHY36U3++b+pUxzCMSQo+J5Pa7qfK7+UYkL5S+bOTqm6Z5y/cONqGg2bQPwcJBpspKAS
	iaSSBSLpmmjGsgClcYq1muRuS3Rlf1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-U7kLOQZiOWa9UO66jn2lww-1; Wed,
 07 Jan 2026 04:48:36 -0500
X-MC-Unique: U7kLOQZiOWa9UO66jn2lww-1
X-Mimecast-MFC-AGG-ID: U7kLOQZiOWa9UO66jn2lww_1767779315
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4E1A1956054;
	Wed,  7 Jan 2026 09:48:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45DAE1956048;
	Wed,  7 Jan 2026 09:48:31 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:48:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 06/16] blk-mq-debugfs: remove
 blk_mq_debugfs_unregister_rqos()
Message-ID: <aV4r6p3x7gCa4-AZ@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-7-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-7-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 31, 2025 at 04:51:16PM +0800, Yu Kuai wrote:
> Because this helper is only used by iocost and iolatency, while they
> don't have debugfs entries.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

rq_qos_del() is only used by iocost and iolatency, so looks correct:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

