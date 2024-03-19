Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1E64CC9
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812463; cv=none; b=J1eoIDOSgoztIRFQ5F4WWdEQ1x9lvVFD8IN2V/JNibVt+GwIuhNIyW5KWQIDNPOco/iwDfyXTJGz2TmIqUH34MZcuYt/ob3oyvckhzc0KebUIzn68SWcF1mi/rOJIZ+LUOQ+hBPMIzLUs0y5l7p+xFD2Zk8dr5HwDVYO0BWKt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812463; c=relaxed/simple;
	bh=DL130D1m5hHx98ks4p5tnYm1aS1Aem3Q7VMSzR6cqJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avP+sf8i8MEC7llXISysyky/Xt3YW3D52iO0v7Sz+LmMRwol10RKZggSQ9+Fz3ezEY37sz+44diJsvZ3teaRFTdAswf2nsJC8CK3CCICJvLvrv0/1UI6L6Yrs0o3+BM1BKDBfnLyMOjltZheihuBNtjAWhIHWnACos9WWoc2Kpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itIo4YMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itIo4YMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710812460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZG56Lfo0zpY/lukwuE8pY4w/TzfHFRrqkvDul4/6020=;
	b=itIo4YMumhSbmXPtMynfB6/kJ236UrvxM8IYWLPGbOIjV9yxqE66EdsWdLKzwPEclcB6nD
	4DCWexYUl2oUqjnKYZY+KPeej8B47yjWG/pNjd1Y5gGi/HlH0OvqqWuj3+nszVhFOyQIgi
	TkgxU/zendSkMcf/taLk0nhQlJL4mE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-NIrMnVSkPLCGYv95P7SFOQ-1; Mon, 18 Mar 2024 21:40:57 -0400
X-MC-Unique: NIrMnVSkPLCGYv95P7SFOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C01CF800262;
	Tue, 19 Mar 2024 01:40:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AC1931C060A4;
	Tue, 19 Mar 2024 01:40:53 +0000 (UTC)
Date: Tue, 19 Mar 2024 09:40:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 05/13] nvme/io_uring: don't hard code
 IO_URING_F_UNLOCKED
Message-ID: <ZfjtHSSwvkvW35oa@fedora>
References: <cover.1710799188.git.asml.silence@gmail.com>
 <f5e1a1f344a7ccce485a45badf02a792e77f18cb.1710799188.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e1a1f344a7ccce485a45badf02a792e77f18cb.1710799188.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Mon, Mar 18, 2024 at 10:00:27PM +0000, Pavel Begunkov wrote:
> uring_cmd implementations should not try to guess issue_flags, use a
> freshly added helper io_uring_cmd_complete() instead.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

