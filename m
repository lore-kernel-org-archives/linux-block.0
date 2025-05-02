Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E425524C
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193164; cv=none; b=JN6Mmfvw564DMVe3WWgVe2dTmHbrlwEU9YNTxX95+KvGWGa3kykeLm3tBTqRIxnTSTbEWcWld+h4pUYFgKZ5Ss8VW75iMXQubclnn3eVPbVjUCUQwPK8+ew9Pfwnh7SZMusuKgSaGFS1M5tpwhGXdtzeA0LBTtMtWnGY/q61LOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193164; c=relaxed/simple;
	bh=ei9NJ049uGIX5yQhrHbMy78H/I6x/HWbcZ6Sft85qyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRGCcQdB0frH6i3OKC1dH0PqKhOvBbStDHrWFJdMPLCp50Lb9MkgQg2xbOlhVZgZozLivxVLGOYJ6Pvt0h2DY109/99Qc9sUcGu80w+mbTsvfmMS3FIv7YwRQLf5mgNNPq5vBiOUh+kb7+G/lk0zR7MnsK0ib8KGsIrHTzaq7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfcBwFyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfcBwFyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746193160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0hWQbEiVuqrU1ymk0jKVlMwDBtK6gb14Cqvrvj+pXI=;
	b=IfcBwFyVDxfg3R++qNJabK5Z+njkRAHW7rn0Cf5VJhKEKvLPv9l4UK6FH+wSox/bDi53Ju
	HnZR7OgqZYr1mIb0Dt0b5GalCmmId7bZAJqOXoPpeaduZl5uF1VNZE8QK+UCtW6+aYUEb7
	TLt13rI9YUhl6bYLQcfTYd7Y9UF3oas=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-6xq3AcOBM7mdk4HaYssYfg-1; Fri,
 02 May 2025 09:39:19 -0400
X-MC-Unique: 6xq3AcOBM7mdk4HaYssYfg-1
X-Mimecast-MFC-AGG-ID: 6xq3AcOBM7mdk4HaYssYfg_1746193158
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDC60180087A;
	Fri,  2 May 2025 13:39:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A41A1956094;
	Fri,  2 May 2025 13:39:13 +0000 (UTC)
Date: Fri, 2 May 2025 21:39:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] ublk: take const ubq pointer in ublk_get_iod()
Message-ID: <aBTK_ObSmaG6NXlA@fedora>
References: <20250430225234.2676781-1-csander@purestorage.com>
 <20250430225234.2676781-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430225234.2676781-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Apr 30, 2025 at 04:52:29PM -0600, Caleb Sander Mateos wrote:
> ublk_get_iod() doesn't modify the struct ublk_queue it is passed.
> Clarify that by making the argument a const pointer.
> 
> Move the function definition earlier in the file so it doesn't need a
> forward declaration.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

