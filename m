Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE862BE628
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616525; cv=none; b=G4d999Yppw6nAeGOEDmv2xhp/XKFQC5LGE7p66GHKufYbYpyR6Rgfvpw01tWB+x31iciKnYIecnbQuqBshvkNND7/2bCiTrQi9udPdT76UQIkq9bHlhe7l7qXroYFRy/zqSTlraSVSRyeSgzGRKFXhi3UqPlzjeYUJqrnFlTFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616525; c=relaxed/simple;
	bh=uSa2VfNIC2bUvG4Euf/Cfaqx0rIPulEfsctVWLSShMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHfIRn6sOA/M0t5IE+sIkxHWgEHy5U8eyvMjjt1QW5YWia91rOJjadjmuCuS7k/+R9Vd9Fuo4PeXpZcxgI2r/jrHe1XWValDe2aXIEX/wPWcNmDjx8K3kLFo+irIHvvBtWR5VS0sErPd8y1JLlQ0lFvu6PNk4LnKUzrG0aHJuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=eGjwOSiJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="eGjwOSiJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45555e3317aso26703475e9.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1752616521; x=1753221321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYqbfvHtl3I2Hgu1RhHFaGq587PWx3usXypktcWVEN8=;
        b=eGjwOSiJjTlzmRTNFYM9EIU0SfrbrQF6qcu5eZMrnzy00W2SvLcfZVSoXdbX67rlds
         vbxX2359jePX6DES7qFkXVNJOw1ONCWbJpeZaRUlqeRjE91WkRHGz4BrrAQkDAvvcLIf
         lFrTxnFBfteRTRNQBwhZHFm8VRY3nNWYOC3q4ZKKIszBc8hbPYHRtkHy8aUAl6w414zj
         iOnOS0PzNmQo5y96IdQpJ2ZHhuzIK3B0qEevNhyRkq2wLwgLO3oGW5wq2QkAOL5LIFPm
         Ah9CqAW58As4li/twWuTWp9vF609DLuRvk5uarX02VE5P++ouzapYUJ9y8HJZx5Z6u2z
         thsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616521; x=1753221321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYqbfvHtl3I2Hgu1RhHFaGq587PWx3usXypktcWVEN8=;
        b=eBGuQp4c+KPvSm0qc4W0TGnxzSoaSUc82bABa9WJN0+2RzsBFzuqEyeK/3Bdx7siie
         oBPcBW1sReOw9oZQU7Tc1x5KV2D8vut/xmeUBF3uyRn6Yy7WxnevEGgto+MqcDF7/Vie
         YgHwcefwxGXi1KFdxgm0kqsUCHTMvI8Cvee3l4C8RRzQM1JwNyTqm1yOQHG2ucJQPVGX
         q7YF0C8msXazBDPqcRgXiuya+NeMT0FFH3/aTSeR15+l14avjzwJbmbapL1qQKU6ATCH
         rJbKtjqkICgCpZa46E54aFJ4V96dvCpjkhiN0nntFh7PDsFfU7BDQUepV6G0savg8IEt
         HrdA==
X-Forwarded-Encrypted: i=1; AJvYcCVBwWCp1TFp0XFgzcaItAvE5C/wEYBzufuaL7lxpZSy2DHaaHKg5ZTWtbNHPFua7W7yVlwEIfetG3yWAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIhmNnHRTzPDmK5rGDOqOaY1CeH7eVW0GaofrE/nElNFEfCqr
	uAELh6R0XSoHEgYd4M5/8/1NRPc2p1uF/33tTgm9gzDyi823d7mPqDRJkwMR4EULPso=
X-Gm-Gg: ASbGnctC8T4bHajvyu1U85GDJDfv9c3z4jvlkY2o1lrZy2IL6MdmL3SsM9hXpSu5pzh
	zHagpFGkxpdnhPJBuojBhI59Ui5DoiLUovgQdIXZle5WB+I9k7itIM25w/jHGZrBDC/Gov/h4Xx
	mV280K2INzb7kouncl3WQmsXHt/1HDKEbUXBjxSCbJD5iOwYAVuKlakrR2OE3R52q/FKH6KDUMH
	csMMIM5yzxcDP17abraZ4aGmRwVJo2OpSw3o6sY+qqu/qVL1uP0NR6l+YniW31IWPcvddzJJjGJ
	2gXqGOuluT/DsCSJnZ0Vf4fWMmb1vuulDAO56GO2JF7ruY4HFtG/dbAr7vxDn7fcdNjkbYeFcRN
	0obL8xIl4gGkCUpafhYzLOWtBixvks4rQ01vXS74Drb2x+ms9iMP1ydz0ruVBtUhgLi6hMRkGbD
	P7sLN40kkkZUqZdJA=
X-Google-Smtp-Source: AGHT+IFTidfwH97rQ2023GFUBHQgO95HSIPTMN85e2HJPZK6py5Yrf+Wy4WLqy1eMhf9ap/5fowLyg==
X-Received: by 2002:a05:600c:314f:b0:445:1984:247d with SMTP id 5b1f17b1804b1-4562e349e37mr3129455e9.7.1752616521053;
        Tue, 15 Jul 2025 14:55:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1932sm16383685f8f.17.2025.07.15.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:55:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:55:19 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Phillip Potter <phil@philpotter.co.uk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHbOR4IANvJWfG-L@equinox>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
 <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>

On Tue, Jul 15, 2025 at 12:32:22PM +0900, Sergey Senozhatsky wrote:
> On (25/07/14 08:22), Jens Axboe wrote:
> > This just looks totally broken, the cdrom layer trying to issue block
> > layer commands at exit time. Perhaps something like the below (utterly
> > untested) patch would be an improvement. Also gets rid of the silly
> > ->exit() hook which exists just for mrw.
> 
> I don't have a CD/DVD drive to test this, but from what I can tell
> the patch looks good to me.  Thanks for taking a look!

So thus far I've not been able to reproduce this. I've just ordered some
more rewritable discs though, so once they arrive I will produce some
proper sample discs and attempt to get it to crash again.

I will also run Jens's patch too with one of these discs to verify things
continue to work (and indeed that it improves things in the event I can
reproduce, which I'm sure it would).

Regards,
Phil
