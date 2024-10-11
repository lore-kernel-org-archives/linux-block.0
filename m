Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60C1E529;
	Fri, 11 Oct 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650283; cv=none; b=K1iXlZp/BFZELNlXvyVVUjm1vXeY5X0P35wC5pUPPXwuasSGz7WafPAhqImTykmry1cKEWnBK/73tdF5vIfXmg9jqk0KH3xPk6mqiHzFcAP3ftBAQnToZGg7oY5NZTqqYENoMc0qpuJynVjfeweFouJ8Twl1Pr+9318ertfUaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650283; c=relaxed/simple;
	bh=NPzh69hoN8vFI9CF1VPACZHxMWIc4wZatQ/5mYKrXDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=excdHNfcrMon/8olnmHwtrvll7U4tCn0A98XRXOpwT4njfkBg9Eqc8yOFb0OgxxsBzD37JO3CSQXY8otiCToFUSUeJSTyiClBdsRMSjUh1tRHjb7gSLZzn6TGVzHVYW5rmVm/JiESt9KjRGCcjSGRLOGdGcp7DKftqDq/j+Lb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311420b675so17255165e9.2;
        Fri, 11 Oct 2024 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728650280; x=1729255080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBVz48o1g1I9UbDwyYUHJZKRlpZFQBxOo57xFoBIM5Y=;
        b=GrZJRu/R4UAMyurPUzakYHfIfPkOGkSPcdsd6b487C3nXdpjhs9y8xdseK+T3ORHx8
         NmxUlK+z5cmoyIRkh4Uo8E/41QRPwoPHrSsUkvecOHLeSccRDLQ41uGETaupLzCstkDI
         aP9VyluKDIvZETHealzxTlcj+8uRRGa/NvU4amu4rr5oJE1OP+il3Uu3wPqys6BnNPJx
         WU7+NYcA8NaWRL+ZEAe67iP903KOVxXCUXL9xZCZNyWslgh563pF/fT/Ny260hi/H9z9
         5q1KGwYnieMOvXmQNi6lPCf/XHsJjDGTbeCzlwokSl8f84OLKp7OwUs/xZ/DK68bSagX
         eZLg==
X-Forwarded-Encrypted: i=1; AJvYcCXAtLcv87gKckM9psHs1k274sPanRtbEd/0d0XMwtrXNerG1SruYUoWKdJ6sgphnXulitNtF88rGLJne8P9@vger.kernel.org, AJvYcCXt6Fkz5jGS3IwANu1HLe/8awHNF9GDA6hJJJMM69UWfzT+6FZGRgiu59CHeo8iCAChObI9arig8xeceA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmbRVbQ/N+ZsTTeF6ciCBTfxoII5LA95HRd25k0NT3vwyuI8V
	7jaX206GhBri/7UtCSZQUjKdBMkUwALlMVprT+9vM5xNzMIQ6qnJ
X-Google-Smtp-Source: AGHT+IF5hkoRf5hvMwE7/tXuKWAa/AOI0qaH49G5wqKQcdVxB+jGdrNe3l78p49k7EDh0XwDTCVT3w==
X-Received: by 2002:a05:600c:1c06:b0:42c:a8d5:2df5 with SMTP id 5b1f17b1804b1-4311df1e6b0mr22330915e9.24.1728650279553;
        Fri, 11 Oct 2024 05:37:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f797sm74072725e9.4.2024.10.11.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:37:58 -0700 (PDT)
Date: Fri, 11 Oct 2024 05:37:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@meta.com,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
Message-ID: <20241011-spotted-cormorant-of-research-0d8184@leitao>
References: <20241010141509.4028059-1-leitao@debian.org>
 <ZwjgrwSw2vUVP2cp@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjgrwSw2vUVP2cp@infradead.org>

Hello Christoph,

On Fri, Oct 11, 2024 at 01:24:15AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 07:15:08AM -0700, Breno Leitao wrote:
> > Whenever an I/O elevator is changed, the system attempts to load a
> > module for the new elevator. This occurs regardless of whether the
> > elevator is already loaded or built directly into the kernel. This
> > behavior introduces unnecessary overhead and potential issues.
> > 
> > This makes the operation slower, and more error-prone. For instance,
> > making the problem fixed by [1] visible for users that doesn't even rely
> > on modules being available through modules.
> > 
> > Do not try to load the ioscheduler if it is already visible.
> > 
> > This change brings two main benefits: it improves the performance of
> > elevator changes, and it reduces the likelihood of errors occurring
> > during this process.
> > 
> > [1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  block/elevator.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 4122026b11f1..1904e217505a 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
> >  			    size_t count)
> >  {
> >  	char elevator_name[ELV_NAME_MAX];
> > +	const char *name;
> >  
> >  	if (!elv_support_iosched(disk->queue))
> >  		return -EOPNOTSUPP;
> >  
> >  	strscpy(elevator_name, buf, sizeof(elevator_name));
> > +	name = strstrip(elevator_name);
> >  
> > -	request_module("%s-iosched", strstrip(elevator_name));
> > +	if (!__elevator_find(name))
> 
> __elevator_find needs to be called with elv_list_lock.

That is right. Thanks for the heads-up.

I will send a fix soon.
