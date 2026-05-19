Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271893403F5
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197472; cv=none; b=rXSnLYUeRb8ZnNDwMXyjJC1xtut4m65sPGELzdkA815nz28ZoVGapqr7FUF8qALPl+zQ4xOC52/wzOCVocrAK1tvr/fB99M7LX97MCO8xc9zwtwsqnk8h8ctrzYWqJjOmhli3HWfh0qPlMqAnfOOhNCvu81boKSrMJuS0D9fKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197472; c=relaxed/simple;
	bh=cQfqwd26YUI5HKJmLNnNCKTFIVep/IiRKLhHKf88LKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F34JKA7IJM8g2rBRHG3JZWld7DergyrAhS9dGIpHk2pfSbmPfYVvJ7O0eMACdK6tlS+DTqAgGLN9FJH6vmcL9F6DX/M+UjVGKa/o1HUxqrxuYbmd6QRrwrXtaj/A13ZgwpWT4CWQ6x2buA0el+YZXkS1eZ0ZuwubR4dHAIrR1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e+P4GhVn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e+P4GhVn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso37168975e9.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779197469; x=1779802269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMuix24tB7G1AW6X0LFMwywjbQdUm3ZzZkjLLW/cxg0=;
        b=e+P4GhVng5P4j4PrfDZpRC5DVtrte85tqYcDvCZLzTnUSP/c8hF93SAKTVLADTwkze
         vOwRlvVtklAMlhLjHBkPqgHIox4V+rZUKlUXW99UQYHOEumdBjy0ffY4Y0Ggf3wKRlWy
         v2JjVCd95lGaCb73kcrIp8wJvDWFtNjfvDrO52vPeRictOxc+fyQQ1nu8mXUp1fVpr9O
         VOVe6/MsUHXVMqCqQiW6CrbWkUuGU8DUq0v6sObQWiMyRJm0UiIrqKE+S6N7G5hu8b5L
         WGtkj/8K3RhlIoZT5EbydyWyWLVqooxuJInMhBcygccxMU7+ni6/E60Ptblfb40FMKeD
         bW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197469; x=1779802269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMuix24tB7G1AW6X0LFMwywjbQdUm3ZzZkjLLW/cxg0=;
        b=pGpJ90wFT9PqASvAoFTowU36mzFmymTiQbzLJ2zX59dsgeTskWTrJE7l3rXA+LEWVz
         4HdpzlSt9AlAGxTEUw+lQdtC2z27sKd/NAWcT8w1rac4Wc2muFX1MkV0ZlbhHmdo0W6L
         3um/feRAq+9QUT0ucWHKE1FyEmREADzIpdT9pJrTiOR6SrRjNxGiuXy6vZGSVmehTVNe
         +63A1MR/aPWVe9YfBqRcsakLkmEMN15rGar4rxZQyMgt4G5STN2Z51C7ENxRaweEHill
         GjzM2qELZc8Ytu5roQ64xG1hsx+eATW8jXs66DwdF5uYl8SbfzEZiIH7P0xwhgz5wzSp
         SJWw==
X-Forwarded-Encrypted: i=1; AFNElJ+XiUJ3RDQI89Z9TCUIJu/VDvJ33hP5zkJ+pnBg5y/EGKK0slh/hoZLFRrf0gJxvmc2JOCt9rtM9Pinyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoATvSfEu0jIpvjiu02lXwNmd53BvztcOOJJyF4cwS3Yyb0XOM
	lPkbdGgg/UvK48sjmBciQPFF2xX4POB+FLLzCO+XNAmdwsoJC2MCu3kx8/4HBNfQ7XI=
X-Gm-Gg: Acq92OHllJVGz7C3cKdGIil9/rO4dORxQnN6G8uZ1h9VxcxariqpcWC4TsT02eraasi
	N3X/2JonCzDec0MopJ+g0O53lhGxqeG7S35VxoZ1Lr4qchik6+ukpsV1zE9htmUJx9ZUFyMA/BX
	xT05ABlEVdSQ1L0EB1wHZOOqmDGAi/hQO69uOlzCzNNn1XuFQRKeBgxFzWBUy6llWljzcShD4z9
	R8cOyk0QbLryMDV7B25Wf/32eCIgEi27t475ImCHGuAL6zqvvy9x86aABRZDQfeOcAIwzOMrTS6
	+d3fFpK0HzVqo0xUgNq3sQvKQnvvFJa4i0xWBscyPNYn0YvgXtBlUddPznOCaPhEYyd2KYMMJnV
	PdP8hW8M4NARZa538w0e0fe6o8KUoqlOG1WZ5KJ5HWjLU6bzk+ci2F8+/ehsyGPs0u9REk1J4ig
	M7C8K8qfBxmIcpN8SieJmbTA==
X-Received: by 2002:a05:600c:49a8:b0:48f:e230:d5ad with SMTP id 5b1f17b1804b1-48fe6617012mr184377675e9.33.1779197469349;
        Tue, 19 May 2026 06:31:09 -0700 (PDT)
Received: from localhost ([104.28.20.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm392412255e9.9.2026.05.19.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:31:09 -0700 (PDT)
Date: Tue, 19 May 2026 14:31:08 +0100
From: Matt Fleming <mfleming@cloudflare.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: 10x I/O await times in 6.12
Message-ID: <agxkk_jWd-qbg4t8@matt-Precision-5490>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
 <aepfV6Gp2uKbHi2N@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepfV6Gp2uKbHi2N@matt-Precision-5490>

On Thu, Apr 23, 2026 at 07:18:39PM +0100, Matt Fleming wrote:
> On Mon, Apr 21, 2025 at 08:21:13PM +0800, Yu Kuai wrote:
> > If nsecs - plug->cur_ktime is still milliseconds, can you check if
> > the following patch can fix your problem?
> > 
> > Thanks,
> > Kuai
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index ae8494d88897..37197502147e 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1095,7 +1095,9 @@ static inline void blk_account_io_start(struct request
> > *req)
> >                 return;
> > 
> >         req->rq_flags |= RQF_IO_STAT;
> > -       req->start_time_ns = blk_time_get_ns();
> > +
> > +       if (!current->plug)
> > +               req->start_time_ns = blk_time_get_ns();
> > 
> >         /*
> >          * All non-passthrough requests are created from a bio with one
> > @@ -2874,6 +2876,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
> > bool from_schedule)
> >  {
> >         struct request *rq;
> >         unsigned int depth;
> > +       u64 now;
> > 
> >         /*
> >          * We may have been called recursively midway through handling
> > @@ -2887,6 +2890,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
> > bool from_schedule)
> >         depth = plug->rq_count;
> >         plug->rq_count = 0;
> > 
> > +       now = ktime_get_ns();
> > +       rq_list_for_each(&plug->mq_list, rq)
> > +               rq->start_time_ns = now;
> > +
> >         if (!plug->multiple_queues && !plug->has_elevator && !from_schedule)
> > {
> >                 struct request_queue *q;
> > 
> 
> It's April again, and this time we're moving to 6.18.
> 
> The I/O accounting bug reported at the start of this thread is still an
> issue for us, and we've been carrying the above patch for 12 months.

Hey Jens, any feedback on this patch?
