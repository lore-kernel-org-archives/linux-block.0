Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58B2DC323
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765252584; cv=none; b=KDFXpw8N+zVwPr/o4W0BGKT9iBgQ3yXkMFt+loCefKlpk2CxlES5b6g3xCMjlV+m/7QA/09RMkl0AVZ5dPAwbiAvddGFcZJ9scnnr23A1J0mNlLtnaRvsQ9LZbg/cRZ4cgQK0QF0jRVdQqHq4pz3ggphLhKnauJZZQXxbZmyP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765252584; c=relaxed/simple;
	bh=Pt/yL8jhIuuI+Olw+LENAXuzzSVhwYgK2Vp/7fu6AO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvab+eG+QLdOdr7Zj7Ed4z59wSd5zCUbrSy15SiFYcTW2DmMk2L5ThrQ5C9W7OLFO4apBI1XZYbeGhiO5JdU3Sd9wK7tOjGQnYsg/gc1HtFT6Wn5071QEyk+UW4fxLdjsyVAHdxsXBTpMylwJt1/WPDDmIct/28booW5vPXFuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sre+EYKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sre+EYKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765252581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlKzrZ6YiAKa1SyDGiDafkUHDxF+wGhpI9yBxR4dytk=;
	b=Sre+EYKuatgxpn4x89FjEhprgfamyjKdRpD0Ox8HN2UHjXRjjH+Tk7Y6VIoVVOyVixNyTT
	8Myi/dVdDqSPGVsXN0QNeSPxEXrAz3+nBkI7o3ATq3BEZrTJcZQ11Vm8tbWVjaxPBmPzTV
	F9udGYbop0zgPCyZ5UMyvVbH3pjisHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-7EhqRthtMwOosvwhO0Zgpg-1; Mon,
 08 Dec 2025 22:56:20 -0500
X-MC-Unique: 7EhqRthtMwOosvwhO0Zgpg-1
X-Mimecast-MFC-AGG-ID: 7EhqRthtMwOosvwhO0Zgpg_1765252579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFB0119560B3;
	Tue,  9 Dec 2025 03:56:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.98])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23DB71956095;
	Tue,  9 Dec 2025 03:56:14 +0000 (UTC)
Date: Tue, 9 Dec 2025 11:56:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't mutate struct bio_vec in iteration
Message-ID: <aTed2XpmSJXOZW9j@fedora>
References: <20251209031424.3412070-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209031424.3412070-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 08, 2025 at 08:14:23PM -0700, Caleb Sander Mateos wrote:
> __bio_for_each_segment() uses the returned struct bio_vec's bv_len field
> to advance the struct bvec_iter at the end of each loop iteration. So
> it's incorrect to modify it during the loop. Don't assign to bv_len (or
> bv_offset, for that matter) in ublk_copy_user_pages().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: e87d66ab27ac ("ublk: use rq_for_each_segment() for user copy")

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

