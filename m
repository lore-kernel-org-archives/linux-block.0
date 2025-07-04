Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C112DE718
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632578; cv=none; b=F1ZwEhqK/kmh/nbsWhqOsqLSALpiFxnE8H5C2DsEHiuCE8pSwl9ACrJn1eZVnnBPGhdKj8ZsVPMJ83+4CmB8gxQspFZNIp83SpEkUvtMvUpYOTVE1WyTvYGLYwdXtPoMJNd/7qS2lJy+0fnGUd/9FnJy3DUgh2lN1DT8UjHjfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632578; c=relaxed/simple;
	bh=1cMEumu8x15iU8LnBS5LWQDpEzhwTBOjXKozgW8HEoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiZIPy2C6nwhoHiQRoCFdMUOhytI6O5smZRvf4QKuAzptw6H7KQZx+qvHzHiBk2rkO28WE0YV0zeExseVw/jtS28YY6hluCXkd8gLoml8c/SpXByf13dvDteRsZNbBaZHymj1Rj8t8L4BGGGYjd+OQfOXh3OJJmg1Dk4pDtJjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2cvbx4i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2cvbx4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751632576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQEvdZVXYD4Rzfbfk/BzwhMBQ2uGxip6fuxj4Mmr9Fo=;
	b=W2cvbx4iToM7kFqtvTQs7t7ANV6rz/1cyGX7N9nWzr0H9Llyauz5diAFInw6MFLZyWleaj
	cc9fGb8oud7VIlxRH3Wz14EYJtAbI+nqIN8OieechXBmnhkFLIKIEQmQgT63gtLPc6cmxH
	Me7sGNQmg7ATvulJ7qp/ueIP8i4W0xY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-McGDwrj_PRGc61KfI6uB2g-1; Fri,
 04 Jul 2025 08:36:12 -0400
X-MC-Unique: McGDwrj_PRGc61KfI6uB2g-1
X-Mimecast-MFC-AGG-ID: McGDwrj_PRGc61KfI6uB2g_1751632571
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 684F3180028C;
	Fri,  4 Jul 2025 12:36:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688BC195608F;
	Fri,  4 Jul 2025 12:36:05 +0000 (UTC)
Date: Fri, 4 Jul 2025 20:36:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ublk: introduce and use ublk_set_canceling helper
Message-ID: <aGfKsZgztW53svl-@fedora>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
 <20250703-ublk_too_many_quiesce-v2-2-3527b5339eeb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-2-3527b5339eeb@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jul 03, 2025 at 11:41:08PM -0600, Uday Shankar wrote:
> For performance reasons (minimizing the number of cache lines accessed
> in the hot path), we store the "canceling" state redundantly - there is
> one flag in the device, which can be considered the source of truth, and
> per-queue copies of that flag. This redundancy can cause confusion, and
> opens the door to bugs where the state is set inconsistently. Try to
> guard against these bugs by introducing a ublk_set_canceling helper
> which is the sole mutator of both the per-device and per-queue canceling
> state. This helper always sets the state consistently. Use the helper in
> all places where we need to modify the canceling state.
> 
> No functional changes are expected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

