Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955B1E51EC
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765763; cv=none; b=JKJFM16LRo5iW/4RgLDx11Kl8xChVtJ41RYeFlDxzqQnMLtHLJy3G1Wqd1BFWZhJbBwVc4H/KCCI8bw7Zuiik4rJFviCHKuL9yqksZfYAd8kED7Cn3/3+J6laWl+pXbYbaiPcMvj9TeEl/DCY9S6QCMcnghO4j072TRhvXbPL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765763; c=relaxed/simple;
	bh=qmqcyk6xnedgg91YlJ2HdeOFRq0RZKZOgU/0cgyE3Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBcAVEbey2d6Fwj1z943gUIOKq49XVINLv6qTUk5GHdwrEjmPDsKFWHRW3cpXmFoRriX4Z+zA22utt9le1Ehu84B1Fd5N/o8xDnU4ia7atWpVojfGUZfJF790mWKzqNwW2E47bR350sUTN77i6Mm5QTJoeN5/ROYaiTTcNog3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JN0R0lok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN0R0lok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744765757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMaHqC5V5R1lqiKZoGLX6CMNwZjUuzJ0WQAUPiqQipE=;
	b=JN0R0lokzOPzzVveeythcvqVEUpm5ZyPbjIE7cMJZIsDuFSzcxy5SHJU7JEj10SkiA8HcV
	WUp5K8POVlOh5hPshFC/D+MX8UZpXz0mjSWm0uY9srWdhTpiHoap0WFzLTynlb1N+inVHI
	BcVr+19AxZlFCqYhthqWndniBB7KQYY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-7VANHsVkP6-1NjQ4bFXa6g-1; Tue,
 15 Apr 2025 21:09:13 -0400
X-MC-Unique: 7VANHsVkP6-1NjQ4bFXa6g-1
X-Mimecast-MFC-AGG-ID: 7VANHsVkP6-1NjQ4bFXa6g_1744765752
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB4D619560B8;
	Wed, 16 Apr 2025 01:09:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E63761955BC0;
	Wed, 16 Apr 2025 01:09:07 +0000 (UTC)
Date: Wed, 16 Apr 2025 09:09:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y
Message-ID: <Z_8DLhbp3GBQGI5t@fedora>
References: <20250416004111.3242817-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416004111.3242817-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 15, 2025 at 06:41:10PM -0600, Caleb Sander Mateos wrote:
> The CONFIG_BLK_DEV_UBLK help text suggests setting the config option to
> Y so task_work_add() can be used to dispatch I/O, improving performance.
> However, this mechanism was removed in commit 29dc5d06613f2 ("ublk: kill
> queuing request by task_work_add"). So remove this paragraph from the
> config help text.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

