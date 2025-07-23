Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901444A1A
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233278; cv=none; b=Ie8uykq1S2qdjKxZnUL5FR3G/yVDVrFMvCVd/owNfd/CWvPVw+z3tp6AisGX07dXw4sLLTHnlBmXGuGCVCTQYlo9dp9roCiNXYdJebW+hsNECw7vMmhM9r38WJ3ProPG0a7C9KEH9TFH3/ZhyJ1CRV5myfWrXsb8mw7QdlAslVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233278; c=relaxed/simple;
	bh=JcJgKNnTHj8vX7MpYvazLsGMhel08hAo1LltIV3vqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG2smvoBVGVlasbDYjmZRAI5dYOc26lcU9eIrROborOkjfb2fLUEJMOKXej3ZYZfDnnupIpLgBySy3XfYkkuA6b2lxN8pxK5iooQbuR/5k/9KggZuqLu2SnLImZ8V4hGE8li0LLot2+5UzfBz0LWk5/J+3rgErelmbTpm5106dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dGtjZO9d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGtjZO9d"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso6195525a91.0
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753233277; x=1753838077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1gp7JY68r71znkwnVBWesr0kQc8oTF6uDq6pszfl4o=;
        b=dGtjZO9dHOE35xmEJDbKo6A/dkDMQQvhf6NQNvLl6JZdx//S6LUvGa3Koodrelei8p
         GUYIAwxMwzQGjMQqLOSwM99y+h2xbVkCg/xOvt/GN7HPfDaJ2mfI35KX7NAZkCUavgck
         BazdzYzs9KldV36cUJxk7ylp5NIB7pd/GKiNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753233277; x=1753838077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1gp7JY68r71znkwnVBWesr0kQc8oTF6uDq6pszfl4o=;
        b=Mf5RG7x7yvAUYMyTMxMe4sr8q3R+nFMTw0d4crt3HgkRS0TXIB8dPstMTdogfxJV5b
         v2b7Avffirv8GyD31qB5f0LB4Cs2IphP31XT+6UtcXdMnbRQsVfgERzdYpvZw++jSF6q
         4reuqJHsxwYwhPD+HPuuszHkkiaP73jbPH9wwcNGkLavvQTWULJEnxgVSIj67tnmLYfa
         4da9CYXy2cUDs7NUJW5T1I9k7heTyZIsto0lazqpGanW50jvXHaYdu4ybj+oSDJJG+hV
         sIXMRYed16WH5WmkL3P+NIu6s3v4PQ7tDZDDUgdKUJ3/fxLM+go1WOlRXas9i5LszTdU
         7pxA==
X-Forwarded-Encrypted: i=1; AJvYcCXwgaNfJYaX1zqm8td68KMRfhq5yYCyHm/K0SgRy35a5zpzNhDFSIAm4/sgEWEjeo22dEdREUIABf++oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOekffIUTcCyPDl4kW/QzAa3DVidWxIc/NSjX7DSl0XIbfuhy
	PEBj0GjRKOpHfXb43bQVSnqq5sal3uHxlTie5LxVC84YZ9jYoI6ItvOH1z+HjEJAz11Zaj36s68
	RxKs=
X-Gm-Gg: ASbGncsR7JeYat/rreZh7JuTWXRxGB17L2PKcwIM3u4YveENnqV+5LJR/rzFlWEnrj/
	wzaeZ1G9RafrAy04qDpZzWE+assVFBtKVAK2BJMp2PvtKiLfrWniLK6ZP5kgMGL9a/1Krgwa/7f
	inIbSqIb3vttWgDMaopKyziirYZKzO6JZCN8zFM45jN1lVsKEUFn/h6VFs54bihTAylng8VAegy
	YBA/fM5RIr+nD/JefQPOFi+dVZi1W3coRDTPYXAmCvotfX0vtcvt2R9J6I2gLdy1J3GdlfBPmqv
	4UsAknWp+2Q63+hwuHnUQHDbTLaLXhMruXyUeGq0kgkNHVYSzvxj+fO5aDcYmtzrLeyDEriiXDh
	8TviublAXO8XcmZIRUsDwi0DRnw==
X-Google-Smtp-Source: AGHT+IFldo8mVFdXKh+UiKvwMGAiyHjybyxb585rrzs4kjVrvK0tbOIlV7r3zsqA2HqjS9fAk5Bu2Q==
X-Received: by 2002:a17:90b:58e8:b0:311:ba2e:bdc9 with SMTP id 98e67ed59e1d1-31e5082bb99mr1891484a91.27.1753233276680;
        Tue, 22 Jul 2025 18:14:36 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fad8:2894:2c8d:4d33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51a2ffcdsm313781a91.41.2025.07.22.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 18:14:36 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:14:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: axboe@kernel.dk, senozhatsky@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722231900.1164-1-phil@philpotter.co.uk>

On (25/07/23 00:18), Phillip Potter wrote:
> [..] I plan to do more digging regarding this, hopefully
> this weekend when I have some free time, as I'd really love to replicate
> the original crash.

I waiting for LG GP65NB60 shipment (arriving today/tomorrow), which
shows up in crash reports (it should have CDC_MRW_W.)  So I'll be able
to run some tests soon.
