Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED91F9DA
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680778; cv=none; b=L/BcnzC2q/eLcYUr+ZBFc0ooRLQ1gEz8CXicZZBCabRF+nAtqS1B0Sejvmu5SzJ8pKCs63Lq7S7kQSk12lhT7g0faplOMHNsmmFI93ABFpITbzbbF4FXezScW12aM41yhKHNyXpDojvi4PmWXjtQNvDU6KFeKXKOjmvY4GJRHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680778; c=relaxed/simple;
	bh=Jf8bB4o+ns7Wk3y4TdJPoFxrmSi4DwWUhJ8fGuaLGiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7kY4Df4Rd2hxhD4jP6N1Hqu2HX0u0GpRVUUKdrK1Z6Sa7PlwAXRNYdKWeITX7Ge+BGrHEc8CGGNJho8nKsaQHt9jQrwhvb8JM7lYlDV9YViIo+a1MUzZJOVYzgIFoc0lUJnb08zbl8KMckASEqwXQzHK7Vt/wBZ1Iv84e1y/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jv5jqCOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv5jqCOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744680774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JcMYEciBzTMlXECv4QLMrvNLarmdu9OY5+/YDk72U5U=;
	b=Jv5jqCOXyW/BY5wCXcIgL/uq++5zhvefVroU6/tGoQo1X86+gG2b8WWvvVUf10BHCkpmAh
	YtiB+K08F/JPcJct3JjxaZ1QrJT1lNKhVnexkXcyQVKdLQWklx8TyExIQ+ckyYs+Uiv0sl
	moKsYBVTbkwbvKAW+RDnrJ7ojqralEc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-YJpGH6bINMi7ti3GgPsf_Q-1; Mon,
 14 Apr 2025 21:32:53 -0400
X-MC-Unique: YJpGH6bINMi7ti3GgPsf_Q-1
X-Mimecast-MFC-AGG-ID: YJpGH6bINMi7ti3GgPsf_Q_1744680772
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFE2A18004A9;
	Tue, 15 Apr 2025 01:32:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9336B180175D;
	Tue, 15 Apr 2025 01:32:48 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:32:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 1/9] ublk: don't try to stop disk if ->ub_disk is NULL
Message-ID: <Z_23OxWATqNr1fcy@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-2-ming.lei@redhat.com>
 <Z/1lr233+THpllVI@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1lr233+THpllVI@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 14, 2025 at 01:44:47PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:42PM +0800, Ming Lei wrote:
> > In ublk_stop_dev(), if ublk device state becomes UBLK_S_DEV_DEAD, we
> > will return immediately. This way is correct, but not enough, because
> > ublk device may transition to other state, such UBLK_S_DEV_QUIECED,
> > when it may have been stopped already. Then kernel panic is triggered.
> 
> How can this happen? If a device is stopped, it is in the
> UBLK_S_DEV_DEAD state. Won't that make us fall out of this check in
> ublk_nosrv_work, so we wont transition to UBLK_S_DEV_QUIESCED or other
> nosrv states?
> 
> 	mutex_lock(&ub->mutex);
> 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> 		goto unlock;

You are right.

I just verified that all tests can pass after reverting this patch.


Thanks,
Ming

