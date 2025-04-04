Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280372E62A2
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743738411; cv=none; b=XiBx9svjq1+Z+VNob8mVk16KP/kzbdlZ8DrkS96gJ/SwT7CHiJnBv03dYYaavNjNDfnGN2rU5K1dfOq1GvNkcffNiQoFBxJZHzZzVQLh3apFGVuMLMsuS9QGBr7pKa9d3h9qRWrL3PcNB3cuKSsYy5CWhZJBJSgSIJUFXEsEDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743738411; c=relaxed/simple;
	bh=w5X/jaCe7ri912P/vMX809Gcd7JQm/JDs2LvPBbruIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB40eE+6ovXP98H71nS9aI08uwrkXPrsuxbfkWAZ0UBQLrFIRjzCMtFOqzJ+ZaeorwThLeA3C/HHF1fWFS4xBpeoxh9TcxthRCEuXDzkFtmUkFrJsO1abItJ1nNN4HQk/7UuUd6R+q+QBsMV32O5+HR8NBuljljjJShAgNLH6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7ESeXHH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7ESeXHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743738405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INWHs+Or4iog6uMxjsayHfcr6SLEGcZ61h3hQKkUjH0=;
	b=Y7ESeXHHgjzFuV2UQLvQnfMFXOpLPvLaGbWPGFj8bWdhWFICW176tSO5bikeTI91iRgIPY
	kW+uR58WFlGi9YW0AXxruKann3p9KwCIz/LGxV3bkji3o7zU6UIiyLb2og/rQqAQOHYb3p
	Yimnjv5jeAxghXhdoDtth7rJmkq3B1k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-6qCXVuV1Ne2_QFsdJINZ2Q-1; Thu,
 03 Apr 2025 23:46:40 -0400
X-MC-Unique: 6qCXVuV1Ne2_QFsdJINZ2Q-1
X-Mimecast-MFC-AGG-ID: 6qCXVuV1Ne2_QFsdJINZ2Q_1743738395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 278A819560BC;
	Fri,  4 Apr 2025 03:46:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AC0F3000706;
	Fri,  4 Apr 2025 03:46:29 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:46:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: fix test_stripe_04
Message-ID: <Z-9WD-sqnPEzUqyh@fedora>
References: <20250404001849.1443064-1-ming.lei@redhat.com>
 <174373319721.1127267.3756134797323684566.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174373319721.1127267.3756134797323684566.b4-ty@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Apr 03, 2025 at 08:19:57PM -0600, Jens Axboe wrote:
> 
> On Fri, 04 Apr 2025 08:18:49 +0800, Ming Lei wrote:
> > Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
> > added test entry of test_stripe_04, but forgot to add the test script.
> > 
> > So fix the test by adding the script file.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] selftests: ublk: fix test_stripe_04
>       (no commit info)

Hi Jens,

Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
is in io_uring-6.15, so this patch should be merged to io_uring-6.15 instead
of block-6.15.


Thanks, 
Ming

