Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE61F3FDC
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467515; cv=none; b=bMFFuiR6Ayt2QGglefGYds6ZND/q1kng8Dmc5jvv4rpsPH3dVYESQREfAy2kgjAAL+n8q+wWygoXKRQkJl+80KTyZ42o8pC3Oo73IOEQKw10gvyupXKtThG+xS+MGOwFL5c781UaxdLkgc2KYl7ODz8PgiTPUXZt2FxO7vZurtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467515; c=relaxed/simple;
	bh=aQdZvcnOJD9tDUKv6+VfIIAENJ7jzQBXlhfABnT/vog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHNCjdSnRtZG+8eFDUuuZNSCgX4ErHhxvHSKYQhCASFdQgKSUhu3tv9xFAlNxCGP/BE0xAzaAlDl9unObRNcD5px3L/ndpvH1SJvLuyCNnEqDvVi2kSZ9BbWuyZs0T+w0QCdWiwtOurVgFChHQK9ZdIcKx/+LV4MhmeyOCZfzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dbj182ml; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbj182ml"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7494999de5cso2378704b3a.3
        for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752467512; x=1753072312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvCBTfIWmWtgk9rP9nhlNrNCUoxPn8lBKMavjp2yAb8=;
        b=dbj182mljzoe+XyvAp9fnZoe5uAMOyH8kH72Ef3YB7KLo0hga+5ElJiWeBMITGg/a1
         43hj9l1b7obaboeyzTTtVjhdDtFMd4CIupTqrALBylJCoMpIcNj3JdChnFCt+kzKZuVV
         p9FkQJ3H9bt1t2vS9llnUO+a1rIb9zVEkNjtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752467512; x=1753072312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvCBTfIWmWtgk9rP9nhlNrNCUoxPn8lBKMavjp2yAb8=;
        b=htIKE0bjHzBA8Pc+ZTcX+DwZP9go9CL5oCD67lP3gMvaMKf4ho6fxIy9XL+PZBXAX/
         sWxdFDdZOsDxQfDqFrh+S7Qyb7u3ctq4nezFLNNKgpkCEwJ+/gcdyaWAPQPGTvX4Q49T
         2ny0aRScCeO6/qzz0CpvFEti37n7xNjhEXIa5yc6noHK6qFtScI1yhlTpqDRy516JjQr
         /1gtPsD/woX4u+aIxAMNoZN/3Otbb/REM1V8AR3aAKDDLML86k72z4O+6AzuFI/5SLiF
         ilUVz8tbpTWInPK/8Ylli1kOpYBkSXCKScmmZh7KJ/lic0T1vQG3tg9XRQOJlQVK8nRA
         Ij7g==
X-Forwarded-Encrypted: i=1; AJvYcCXZECKUGi6ybuEqRTgTFMfTFPoOED4CmJeTKxkLqLj5Cj68qaiKRSyHwo/Or/m92ZrXGRNB3Ttfqcm6Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9ZXAh3hIJ5soQ7xHZLOK2PFY3hfpwsU0zB607rlmCucA9ZBy
	OI0LeauSmsW3bgV/lc/RgIlj8dHHc2dQDAdYA3It6jvKNzvqUQswCp1PEjf+i1wWXA==
X-Gm-Gg: ASbGncuNCu/we3homTbJD7ywSgtVDzQHIZ81oGmjJpqEO2Ska+VFtxbyUM000j+5INW
	THGNrntQ/p1ug/tXTcMg2wIICro51N7ilZweuV5OwHDRzGqgeLUEx+gE3lF7pgJAPxMYwWaKY3Y
	QG44QhcCdaytQ6EqBghgrOmOD/TkBeF6PzjYubkNzn/r82K1DNsPbQhPL6KQo3a7PlE6Zine1Tf
	S3+lR8OkAuh+nZb0S5r3DOb5nli0dlCiyTQ06SN7a/dH0vHGiFF1orPUMOOMpv01pccQZYZXX6Y
	d47qGJmgZMIbme4/Ngc2ApDzo6VDPhKKUiB9aofrufx/kyGa+OT5oq6iiFHhVRRTQMrcatJt3GX
	e5vbsh3Ed+nyUHC8RmQNZu0patg==
X-Google-Smtp-Source: AGHT+IEawOYnl3pwZDteQ7eTr43CIgn4Vq7oK91QQprO4uKRidMBQ0k0pNSfCJmsSZKDPQI5rAbS+g==
X-Received: by 2002:a05:6a00:1304:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-74ee05abc06mr17572958b3a.1.1752467512268;
        Sun, 13 Jul 2025 21:31:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d84e:323a:598d:f849])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f2251bsm9953809b3a.100.2025.07.13.21.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:31:51 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:31:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <nqlxu2zgnf2z3qyncdkhk5juov656fzysgj7jkwvvcrayvsvzz@wuwav7xu3fjl>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
 <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>

On (25/07/14 12:29), Sergey Senozhatsky wrote:
> [..]
> > The device is detached already, I assume there isn't much that
> > cdrom_mrw_exit() can do at that point.
> 
> If I read it correctly

Hmm, I don't think I did.
