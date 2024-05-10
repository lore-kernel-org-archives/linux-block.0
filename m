Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBCEAC0;
	Fri, 10 May 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353051; cv=none; b=n2zm3+PKevpMhh/F5A0Yt0wBivSgLeebY36l+i3Yv88N5MnAzXPKE7/uZcVTqU7P59ntH7HJnGs128nWtZfxKin6um2lGfGZFId4ca7nauavk1jyFJxqGiwLeQMk5dH/ASV/xZYCUf9+LqmhXDKKKPsG6bI4vYQEo3N/rfdriTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353051; c=relaxed/simple;
	bh=U7C++UZ8Ckt4orfC7xx+jCKetrNe3QBnPE/FhNdCFiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQJmQu7UJrDD//2Y9EfyCbcGvnFF2mq9Vwe+rAJOSQ5FDoknGlCcuy8GFV4cCvFJjubLJbynZj10YMICdIgrGhlheXJui2uKeDwz6l7hlOOOWE27KC4rJFKyUH08fUeZ0E8Fvf13jcCO8OQbzZdKRmlINQJZPLyDY5ctD4wDI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so551865966b.0;
        Fri, 10 May 2024 07:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353048; x=1715957848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmPX0pe9l4LhCeCJ9RFzXwq04vOIoS39dg64tvVpZjk=;
        b=NNn6SLB8JpuEkJfvo3cUVp7nc1mh2qpZQ9cTcefa/IBahy5RWwkib6LwQkDr1Sf3TG
         0Ddr+ztQl+juI+UDkLRK7SbpHqTE+hDZhcBh0WOmq9CeUfCPD6l9yowIOiKnZJJ1rZ/V
         IDr1Zm1LbpOeEpl7G6ifWHa9AUIw289QY6YoCWG2cz3EaC9Q/bOjOFRAWiGslTZX2RHZ
         MwVezosBcY32KzhL/ChUS0uw5qRSfS9N8BQYDl83p2ubBllJmHVQLXuBHWtl5Gbfedee
         ievWMEVvK/NIFWhFrx2yHlb9ScM52He+qDh1HebY5p6Y+YZQUqn6DoWItFepFZzY37LS
         3lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyQREAEx5LVER8fiLon0DjtuTCitcuDEfUbZUaLSxqHo6RwrABxIzz6IDpAdk7Hl+zrLSxSBfglNGElPQRQpjLkCh2hKxJlbh//S9XnLCPjJPrrgk2V6ptlG5vIfdWpc3MKEy2AV59H+Q=
X-Gm-Message-State: AOJu0Yxh8M4TN1WVL73ik6ZAJHCPZSDM/46H2PmJnkt8f4X6YDkYT1KB
	EXPdmNaMCPnFY6g75p4aqPpyixQGfKC0p+ae19R4Yzj6n9lKkUvItZ5IsQ==
X-Google-Smtp-Source: AGHT+IGGA/8ZLCXE/dv5h5A0DSdUWkY1ph/S9vsyAXGZVdS97Q4Grrs19CnXBnC8zxpU20db+5ZmZQ==
X-Received: by 2002:a50:f699:0:b0:570:369:3e06 with SMTP id 4fb4d7f45d1cf-5734d5de84emr2201724a12.19.1715353048169;
        Fri, 10 May 2024 07:57:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfcc1sm1838512a12.45.2024.05.10.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:57:27 -0700 (PDT)
Date: Fri, 10 May 2024 07:57:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, paulmck@kernel.org,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
Message-ID: <Zj411QK+K+CmXaVi@gmail.com>
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>

On Fri, May 10, 2024 at 07:28:41AM -0700, Bart Van Assche wrote:
> On 5/10/24 07:19, Breno Leitao wrote:
> > diff --git a/block/blk.h b/block/blk.h
> > index d9f584984bc4..57a1d73a0718 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -353,7 +353,8 @@ int blk_dev_init(void);
> >    */
> >   static inline bool blk_do_io_stat(struct request *rq)
> >   {
> > -	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> > +	/* Disk stats reading isn’t critical, let it race */
> > +	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> >   }
> >   void update_io_ticks(struct block_device *part, unsigned long now, bool end);
> 
> Why to annotate this race with data_race() instead of READ_ONCE()? Are
> there any cases in which it is better to use data_race() than
> READ_ONCE()?

data_race() doesn't not emit any code, but, keep KCSAN silent.
READ_ONCE()/WRITE_ONCE() emits code.

So, if you do not want to change the current behaviour, but, keep KCSAN
away, data_race() is preferred.
