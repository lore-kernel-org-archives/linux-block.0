Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F843019AF
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228953; cv=none; b=E9Dy2H8H2YOZJUitHFDgXr0gqFvq4xq7fv0CfyYLUftOmec5Z90mbnMzmQbH37GogbtwxEptiN0Va9Vjj39fOb9T8YRwkHjoDvXmYKfkqje+Uex+ESnYy15YQSJ2tee5AoZS06paFnetbM54Qiax73Azm0eu7QUlRXEF04BAIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228953; c=relaxed/simple;
	bh=pV3milonySx194556fLjFE1CkBYhgM1q57A3zSR7KqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJzbTUqNmlC+ZM09OAoQSRTolr+Dncg8BfmdD96Yld6jazAz/Q+5Ed26yaCEC8zLKH3m6Y1evnATMLFmtCTmTDnVlJm5vVqsKF7sWHd1nibh5X1e774h7ojxnY9zTVE7w+QXhSce1uIG5skKfEwgdPfmvenTtuYhJHRfPgwTuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZQJUsqv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZQJUsqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OoBw4X5J8IOFkHxmvfVVsLn51quArP6beYx8yplddU=;
	b=bZQJUsqv0U6e3KlxysY9TUK44bPkSuehrPiUaXqcJgpx3V/16C6lFjPcNRDgnbxhA06Okf
	+F3kfrGnrYVIu2q29goAafgR/gAUFVG5WBLd6grhXB17Y8ALq2T87fQBChrk1ujV7irUFM
	VnqhgeWm7FzLJDX9uVCCxnpTJYLulXo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-90ZP4OXFMsi0m51ncbRlKA-1; Thu,
 23 Oct 2025 10:15:47 -0400
X-MC-Unique: 90ZP4OXFMsi0m51ncbRlKA-1
X-Mimecast-MFC-AGG-ID: 90ZP4OXFMsi0m51ncbRlKA_1761228946
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 412D918009C0;
	Thu, 23 Oct 2025 14:15:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBF9719540E2;
	Thu, 23 Oct 2025 14:15:42 +0000 (UTC)
Date: Thu, 23 Oct 2025 22:15:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: fix user_data truncation for tgt_data
 >= 256
Message-ID: <aPo4iHZt8sO9wJvT@fedora>
References: <20251023105141.2515921-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023105141.2515921-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 23, 2025 at 06:51:41PM +0800, Ming Lei wrote:
> The build_user_data() function packs multiple fields into a __u64
> value using bit shifts. Without explicit __u64 casts before shifting,
> the shift operations are performed on 32-bit unsigned integers before
> being promoted to 64-bit, causing data loss.
> 
> Specifically, when tgt_data >= 256, the expression (tgt_data << 24)
> shifts on a 32-bit value, truncating the upper 8 bits before promotion
> to __u64. Since tgt_data can be up to 16 bits (assertion allows up to
> 65535), values >= 256 would have their high byte lost.
> 
> Add explicit __u64 casts to both op and tgt_data before shifting to
> ensure the shift operations happen in 64-bit space, preserving all
> bits of the input values.
> 
> Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi Jens,

Looks this patch can't be applied cleanly, please ignore it, and sorry for
the noise.

Thanks,
Ming

