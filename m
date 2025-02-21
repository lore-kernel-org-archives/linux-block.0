Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661733EA
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128382; cv=none; b=DFBT1QSes8PEIDkqZFX1KUxQCn/Ac2M6lCUXl+2mNKH0e3mni13oUMXcpujKr3xFsXLNl+iiX8XcNybPtl83bdMVzJQ9VpZgswCNwHBb0Y4akqlnQBfMkb0yv3XLB8pTN2Rf2oK1GPv/XbOXFLPs7aTcXakjD1S78ajyRGYVAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128382; c=relaxed/simple;
	bh=CA8LTXn8ZMHHebfLWlgceog1R7gKYe/0qGQCgAmZlZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvwmyuc7McBp1BG6mRjJwqunbTi8BspQ9OgTU7RAUoJ5plm4R74qJGFeb76ai9TalOPGKTj4zGB6ozdY3DF2BEwC1Bu3JYMPdMhZyM8dRjOkX3W62u+1r0hC9GWrCx1LlidpGhW0TO6iZITnHnbYO9MS5bhXeiTcbF03WoPglUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCMF1+E3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCMF1+E3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740128379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEWjJtZj4Y0k3MpCiI/jOjIXUqUv0vkp0Kvjw7S1vN0=;
	b=cCMF1+E3OwrvGkKTOUEOkXUMYjT1AHHG+KtCT8zfPPcKxYjTHoxEhxS4HLH8EskScLx0Yl
	pOQT2dyQqrZLxCgH8u3jGO30JhbTCD1peFoynfdYGaskv7QWazFtSuMXLTe6Bebknk499h
	TOWksQ5VIn4qpyLJ0Io6uJKDvrHkjI4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-WB9LAomCM9KnLzjtlHJmiA-1; Fri,
 21 Feb 2025 03:59:35 -0500
X-MC-Unique: WB9LAomCM9KnLzjtlHJmiA-1
X-Mimecast-MFC-AGG-ID: WB9LAomCM9KnLzjtlHJmiA_1740128374
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4C04193578F;
	Fri, 21 Feb 2025 08:59:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B8B51955BCB;
	Fri, 21 Feb 2025 08:59:28 +0000 (UTC)
Date: Fri, 21 Feb 2025 16:59:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly
 for bps limit
Message-ID: <Z7hAauGfBrwNBRkz@fedora>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
 <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
 <Z7f-jx9LRXUrj_ao@fedora>
 <7a113162-a2c1-fad4-3395-7bc39d05b5c4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a113162-a2c1-fad4-3395-7bc39d05b5c4@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Feb 21, 2025 at 02:29:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/21 12:18, Ming Lei 写道:
> > > -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > > -
> > > -       if (!jiffy_wait)
> > > -               jiffy_wait = 1;
> > > +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> > > &carryover_bytes);
> > > +       tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
> > Can you explain a bit why `carryover_bytes/HZ` is subtracted instead of
> > carryover_bytes?
> 
> For example, if bps_limit is 1000, extra_bytes is 9, then:
> 
> jiffy_wait = (9 * 100) / 1000 = 0;
> carryover_bytes = (9 * 100) % 1000 = 900;
> 
> Hence we need to divide it by HZ:
> tg->carryover_bytes = 0 - 900/100 = -9;
> 
> -9 can be considered debt, and for the next IO, the bytes_allowed will
> consider the carryover_bytes.

Got it, it is just because the dividend is 'extra_bytes * HZ', so the remainder
need to be divided by HZ.

> > 
> > Also tg_within_bps_limit() may return 0 now, which isn't expected.
> 
> I think it's expected, this IO will now be dispatched directly instead
> of wait for one more jiffies, and debt will be paid if there are
> following IOs.

OK.

> 
> And if the tg idle for a long time before dispatching the next IO,
> tg_trim_slice() should handle this case and avoid long slice end. This
> is not quite handy, perhaps it's better to add a helper like
> tg_in_debt() before throtl_start_new_slice() to hande this case.
> 
> BTW, we must update the comment about carryover_bytes/ios, it's alredy
> used as debt.

Indeed, the approach is similar with the handling for
bio_issue_as_root_blkg().


Tested-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

