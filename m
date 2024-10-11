Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADA198A31;
	Fri, 11 Oct 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664254; cv=none; b=Y3Qj8Lj2MsGIIn4V6NiD8OM1ZLR1cQvsCWtQahg8ykMxYSU8EOz0wXAODEgxgVnjOJNcmtqaxaF2ceY3iH1d3vB47cDQqFOVOUH0cK/Cr+zFMTENl9xTgRZ2aPFr12og+yMi41AkDNerrUoRc/ejWEsqWI7OJ4VYCEeGRv6fYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664254; c=relaxed/simple;
	bh=/EJHBPWentdZxGJnMZbykxCABGXKDJ8dS55hQVseJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLluxcy6cgVNp1oNszc4iGFEgPCy7kIfHd1WceE8fyT9hqiTI8mXUq+PM1RCkOKu6NtbJfvZQK0oS5oQtKpmm75iUJBvvEIAd9LoxUd6M8Dw8uphzyju4J4GEsv+aCe8cw94HFpVWf7sgG+CoETLfXlYw/KpYXm5iaIElLDNr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d533b5412so748889f8f.2;
        Fri, 11 Oct 2024 09:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664251; x=1729269051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDuPL9iTF5w9nW0WT7Ci53olsjxaXCwj92D1mWW3ONs=;
        b=gLUTuSLT1zTkutWHfsleKt20e0VpvngKmo9MzShu+w/9bUF/JsmaI7TXPcH75/lWc/
         TBfoDUgViZIEi7esO7XzPIxEDIqOu/FGcTXdn+9kW3VSxRZtovE6oSZrbU/WNCLwfUUM
         YwpyW9PwRqX+TQxAvyRY4k/Fr97SBygpfkSmPysCnEFA/XjxLyF5au48i34d+xJmY1jx
         pHPNH54UWx9JTHtipayMnmmElmEoY35ZswzJnp4fx5ORIs9j225SYj1NBdXoc28OYU2C
         bTaV3Lbp3HbbLcpr6eFCGndXM3ZhzrXM6JWvso+Scm35QNI+P9zzu/UDjvQKJeAy/VTA
         jtNw==
X-Forwarded-Encrypted: i=1; AJvYcCUobSXtpbdipG7HBPeKlcvaBWPkCaqrhopT6gIpfpTGNKVZUhAqV3KR/t81tuUM+LljhtAvZPTHzOqrnmbt@vger.kernel.org, AJvYcCUuTCdeyyAiXEmSmQiuyIP/OAxrFzwMA0SelNfdYPPSRM3Ljypd1C1uakm1Bmivictx0LemSZrw5CWZvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRhC2jm7HoftfWiK6OdPfeeTjlpDhZlKws13DSsIM6YJsGn+y
	BMfQYjy29P5DoqTxtmc3/av9wXAIwxJVcXz9w+9hypBC2Aj92Mjw
X-Google-Smtp-Source: AGHT+IE0WZNOGK7zfQ/pppsXZF28iSqSs9lw+Zb5XenGl8JRgrukHeZ+jxNkxvX2jn1g2OfzAwhOsw==
X-Received: by 2002:adf:f1c7:0:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-37d552fd763mr2262289f8f.44.1728664250494;
        Fri, 11 Oct 2024 09:30:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7f2c1esm4297371f8f.109.2024.10.11.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:30:50 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:30:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	kernel-team@meta.com,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] elevator: do not request_module if elevator exists
Message-ID: <20241011-strange-incredible-grasshopper-acbee6@leitao>
References: <20241011154959.3198364-1-leitao@debian.org>
 <b63b487a-09fc-4519-ae5b-dabf1fcf05b1@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63b487a-09fc-4519-ae5b-dabf1fcf05b1@kernel.dk>

hello Jens,

On Fri, Oct 11, 2024 at 10:02:13AM -0600, Jens Axboe wrote:
> On 10/11/24 9:49 AM, Breno Leitao wrote:
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
> > Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> >  v2:
> >    * Protecet __elevator_find() by elv_list_lock (Christoph Hellwig)
> >  v1:
> >    * https://lore.kernel.org/all/20241010141509.4028059-1-leitao@debian.org/
> > 
> >  block/elevator.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 565807f0b1c7..1ac9be3e47d1 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -106,6 +106,17 @@ static struct elevator_type *__elevator_find(const char *name)
> >  	return NULL;
> >  }
> >  
> > +static struct elevator_type *elevator_find(const char *name)
> > +{
> > +	struct elevator_type *e;
> > +
> > +	spin_lock(&elv_list_lock);
> > +	e = __elevator_find(name);
> > +	spin_unlock(&elv_list_lock);
> > +
> > +	return e;
> > +}
> 
> Probably just drop this helper. If it's only used in one spot, then we
> don't need to add a helper for it.

Sure, let me send a v3 without the helper.

Thanks for the review
--breno
