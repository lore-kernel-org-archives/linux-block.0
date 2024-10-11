Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495871E502;
	Fri, 11 Oct 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652653; cv=none; b=AjznsDuP/Br1Nm4/pfqEvjViZexfdWwrfm50SNm/M8WOggK/Qh8+TidaYPXWFm4MwyFUbsHVhJ7BhwZzgOgLy/C7SxrI7kFtAujmTxq6KloiK7dVnRDQen2lStQO7SA7knau9pr7HXBGO6mDdabHDAMEAMsElH9HSF/A77he12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652653; c=relaxed/simple;
	bh=Kq/IvEcbr0Ppgi+gMKR3bodZO8mVKo/H2Z3rATLOQtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbJGzZyQvBpGSoLHUNBB9kvEx5sHHKySbSs+h6+By7LKLngIU6dvk4NcOCFEA7pSsgzl0FhzTgSUrfsnx0fHFs758UU0dtCLpUaqyGWagSKsT5PfWiAIDd1tAN1x+ghJUasdRvfMQ0pckTaRojRhDGugQTGFv0F8MzokcPXQAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so2522922e87.1;
        Fri, 11 Oct 2024 06:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652649; x=1729257449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfW1cruP70qbfc8fGCdAsDZHmpmW3Yy+pxu/ro3VbRs=;
        b=ZRJ/BLqYVA3FydSqbHM5OkIPkMptBha9I2VQqQzbVNvegpwg0zdDE1QhpjVS+cnv6k
         CiBjPee56iblVftiJ+fCGkw7aA5ib1mTxfyLyC7ZyN90a5a0g257spbT0atevvPQ6XpU
         Ztlao+BUuAfllmMXKcHhWx37fWjBAZLtTYEQHGazdUlFySx291juE7OoRlsoOA4YTtqr
         pIopsWwvelIqUMWQTcQ3gLVjrKCBhRrhmS+uBUt3MV+USJm0/IRDt89V+ffog9oA56Gk
         KkuYZJ8sfSj1pPgeMlO99dseAXSvhaeqlkYJ7Shggg0R1k1qMrAS7bHmO7ZF9ihB4ANk
         UC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXF282PAGDX1s3txWzJHWf1EcGAY9WXmnZTG4/fwc6kbosCQmbXaF3s6RBkr8b8GDPm3Xe/ndZS1wNPpwgw@vger.kernel.org, AJvYcCXl17hCYpffTlZ1nlN6LxyUmVKJPEm69CPyDkKv/wn+jIduND5QIj2YKpFuZEFTerzwFA+htoLR3gu9bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Jjewp+SVGpdgmfYSwFdsgUXOZTPSceUFEgKDnpr3ISXO0dlP
	Uk+5RWG6VQh+ZOTgu97DfPKgdIMuPhG5UJFEV96AyPk2BWzBLvmh
X-Google-Smtp-Source: AGHT+IGyMZLjHbKn+BkG0J5N13o/9elpv8TXs4WkQgXjz/AG3pNzSUo6/eCAy/izA//xOvyPkmqy6A==
X-Received: by 2002:a05:6512:3e14:b0:52e:9dee:a6f5 with SMTP id 2adb3069b0e04-539da54809dmr1370319e87.46.1728652648897;
        Fri, 11 Oct 2024 06:17:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7929sm42256605e9.4.2024.10.11.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:17:28 -0700 (PDT)
Date: Fri, 11 Oct 2024 06:17:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, kernel-team@meta.com,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
Message-ID: <20241011-enigmatic-mustang-of-thunder-eae0d3@leitao>
References: <20241010141509.4028059-1-leitao@debian.org>
 <ZwjgrwSw2vUVP2cp@infradead.org>
 <1b4889f3-3140-4855-8c74-f0c9df7318ca@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4889f3-3140-4855-8c74-f0c9df7318ca@kernel.dk>

Hello Jens,

On Fri, Oct 11, 2024 at 07:12:43AM -0600, Jens Axboe wrote:
> On 10/11/24 2:24 AM, Christoph Hellwig wrote:
> >> diff --git a/block/elevator.c b/block/elevator.c
> >> index 4122026b11f1..1904e217505a 100644
> >> --- a/block/elevator.c
> >> +++ b/block/elevator.c
> >> @@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
> >>  			    size_t count)
> >>  {
> >>  	char elevator_name[ELV_NAME_MAX];
> >> +	const char *name;
> >>  
> >>  	if (!elv_support_iosched(disk->queue))
> >>  		return -EOPNOTSUPP;
> >>  
> >>  	strscpy(elevator_name, buf, sizeof(elevator_name));
> >> +	name = strstrip(elevator_name);
> >>  
> >> -	request_module("%s-iosched", strstrip(elevator_name));
> >> +	if (!__elevator_find(name))
> > 
> > __elevator_find needs to be called with elv_list_lock.
> 
> Doh yes. Breno, I just dropped it for now, just send a v2.

Sure, I will be sending soon. Sorry for not finding it earlier.
