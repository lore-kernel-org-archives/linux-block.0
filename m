Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EE1E51D
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753012558; cv=none; b=Gfk6r9QQspKLIQt9SZiKDyXnpIhUsGb6tCpLIWnsnFqXPrJk5hp0RtH0BbM8U3aP9QWqlwRXbqou+PvSAl6VGWNiOxO/+b7EAKYDkxrvl9cdPGR6vNh7eo7QJ6CmTgufAJJeS/zQeeQC1tiUs3oo+xahZaA6yoCcwssm1Tzjmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753012558; c=relaxed/simple;
	bh=bqtLagOldK/7/rLLesSOOYtHy7Mg9Lw7Y7rhG6Cqw+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyjO2cQaHrG69TWaedxemhWu+7Goptdd5cNI5bGxM+BUmPlpWelRrkskOH6kxJtY/uGhqFV7YgkOeWUH4Vzk0/aFJOS20yD2/Her0ZEPFsb2Gujrrp5FL25vuWQ89dYNNwuKJB7J32RQJb2xrUB9HcXSCwDCSr+i1V3x40MtAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=EznbldHq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="EznbldHq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2023594f8f.2
        for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1753012555; x=1753617355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekTGTFM7E4ZDOmzsJ2i/EMbwRasN0mNK3easuArwKgE=;
        b=EznbldHqYP5HWQbczWTXmBLbLJ61Ug8h1S10Ur+MfEC78ldGlwQCg0yprf7TMox8i7
         IFqqcXSTSpmtL1XX6YSC9HSdYBwMGKqIQ3doNJePVO0uwm+5KTZk/jQLd8Y/7zkUTFSy
         i/E7+5a+ufMd6EQ5c58bVZTg4Mmin9LjZSODz16wlxNs287fkAOoOMpoB/9owl/0mJUa
         PXGKyFHvctyGZ8RwqCRaVadawcVWwbNZ4P1TAmBehaMU5kjZzECDVLVGspAsfVkyQc4c
         mVIjSRPirpd3ruhdOD7zghkWPuS00Lp+EGnI82r9BUtoJeDVStaaAd9KweVadUKo8aOh
         Q/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753012555; x=1753617355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekTGTFM7E4ZDOmzsJ2i/EMbwRasN0mNK3easuArwKgE=;
        b=q1cjG094zJkKxkhiE2djkSNC5ZnCXnIpVWzf1VTH5xkD05r9JQlnWI5Or4AAWvQxpm
         FyA6cgg27M9Z1A765smQsJnebMfpr+/kCZ+uILheMAtwgZTQ/KuCRHi5l26HybFSXsuD
         CvU2sXyq7pR//sKF+QvP7SfNMe0M1X6OIXVV2XGUfJ/3/ajbjs/eZ9myh6+ff5GknIk6
         rBcOXD195vJjy7jMQ6PiKIzBddBSzhmKl6lp1tORPm3xYVIusZrk7KBOWFCsrg3PsxDr
         0Mk063Z1TL8G59LMCexFDwUQ9IL5cXspQqiM2CZVyk9I6v2CXYVH3+9eEh6EOOwrY5zN
         h42g==
X-Forwarded-Encrypted: i=1; AJvYcCWcOm6c2e/c+Bq8b1nU6GucvFm10WFcyw1D6riuACdL+T5WlTgzEDbIFVAyFT/gkHV/aIRiiCT8StXo8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHD2H8yZZvzHFNnO34LFC4PLe+LuZVTaNLOixQpXIiMJs+Bfh
	LgwoCwxZr4WwsUxbD/ABAFOD+iUMY2VBlnsI01qhpOOTYoCG5U/sUiykDv1qyxICXdQ=
X-Gm-Gg: ASbGncsEdmgBPZnK+2dUH9gx/tt5Es1+1LaygJZULWDdX2aCDFO9nckmH5i8qiHM0NF
	qz/Y4uDHfiSJjjq5o36gY3CjTeJXvhxTA6Pk9AXQz3nyu2WCzIfmbABKQoFrFw3ugAhGJBugm0T
	OxqbRfOERC0Ofk2vVrDOzVA9ulpIqANA/QSnLOlS0i//TsUr5t8XB/buBsHCAqjVUX7CRLjRID2
	vyBG9YKXhNQyY2JSUX20WLsKGYUtgsVW6soV+pjfQmo/Vi2ae7igReaHK0LkeklGNVnX0qugzFh
	91jW2utYa7/rsCdlwWoDoLKGiq4E2IDFn3zDdXjhAylmg2DHULe5c4620MISagZCbJ+Q5nmHO7r
	lnECLD2rJn+L0BBRGcedfB4LfL9E7OoEwOfRnmhVR4O3qFyqCUoDS5Mqm4wna+vYYhcFRo8smWf
	CUkJP/
X-Google-Smtp-Source: AGHT+IGGUFEr+7C/4OxnMXUzeaPEVFQDSDorVA0J5gtJQJrY0CrSSiN5h/kxV+Hu3G8D2M+DmNs7Dg==
X-Received: by 2002:a05:6000:40e1:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3b613e7763cmr10718325f8f.23.1753012555023;
        Sun, 20 Jul 2025 04:55:55 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb96sm7396721f8f.30.2025.07.20.04.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 04:55:54 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:55:52 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHzZSKqAJR9Wk7SX@equinox>
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

Hi Sergey,

Just to say, I haven't forgotten this :-) Have run a few tests with the
patch and so far looks all good. Still been unable to replicate the
specific issue though. Assuming my testing uncovers nothing else, I will
revert to Jens with fully crafted patch submission in next day or two.

Regards,
Phil
