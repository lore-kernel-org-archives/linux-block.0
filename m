Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A125A645
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058305; cv=none; b=s/N/Uhj8vf+BgTFYNgyR7UX1fP0xfiqBY9znW0djo8ocyoy2sSFBBiK2SAfj8vsiTiIL0lKopLSjC319/CwlXx+QtBdXt+IHsC2T9liomLay7dC9DJjNh9kCsYT7J9AkO3bON0omuTKdc3WP4smkLuSdX/By3mJr7n9M2cEy2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058305; c=relaxed/simple;
	bh=8jQ4TUqv7DI5JRmBXygaR7YDbLyTrmFdg9rRw2xLItE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeHp8s3Wm1WkHg1iaDpXxzBgRo1RwWNzcHptt4mxp82SyJomFVwnJNeAHZhmSAeNxIzl+n/UgjZRmKW992MZ0JoCYj4zzfNorfMP/WgbLXH/blGfvzoIyhlhRsUE1Ced8W9/cS1sR6hZ4QUmawu+KsYqIix0mp3T6LixtgY/w3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHY/6eQU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHY/6eQU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915c48e6ae2so289204385a.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781058303; x=1781663103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkZa/2d8VlJ70HvnjEWIYq5vhxifkFARYYl9Ej67UyQ=;
        b=jHY/6eQUDRC3uPscwjkouLT5j0MLCIhnTlnvWV1vmvlM0eRMem3zI+zwDCHbPXE5eW
         vvEJUFs/77wkItTAPSJ2fHB2EvoYlF00bgQw+1NHedmm4Cgqymu6CO/XhC77dPpV39wp
         pgV+hJri76ZaLgRdjXvz7D/8nKThFkwvabAsR5A0bgNFA2+yfUvKeszY+WNe6jJJebYN
         jYtWtuU3noSHA95HOHBY8IG0/hd3nQgNeV8IW4Cx4aBw0X3JFERdQi1gETVRQUwvOdrM
         OXfTGFgGow8+KchbexWIY1LQRe7mT/2nYhuquZl1tdCc04w/9PMRRKbal4pkaa2IJjyn
         CdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781058303; x=1781663103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkZa/2d8VlJ70HvnjEWIYq5vhxifkFARYYl9Ej67UyQ=;
        b=llVmW07FFEKYvlDAJmwNasjWoS45P/RNTt8NdUpOjmDSwkASbJu45OUbwqj17H3TGF
         nbTHHc9FiCXaCm2lLTZ7NgjqxhN4Bk5aBzJgNgMDYxdn1zkzNICgJ8nfc+xNHTqLJKAq
         yhhYAU2TcWLGDF52lMjy9lfn2VLOaVIT0jTaaeOXxqvY3lxSM8d8hsAk19hzUzWGHi3D
         K92YTKCFmCbK+f6ZNL4xTpuRpC3Vt9qvfM+Td98ssgoYlvySd9OqngNAvxvbqci1SMPD
         o23DEwxxIEGGEVs8hQLMP+sLuUcJU0dQwqvEmBG87MCsL9EBRyMGXGrazjQ8harj2+en
         FMyA==
X-Forwarded-Encrypted: i=1; AFNElJ8AWTPHUZ9lyTORZw0z5X04u50HmwZZPTXrITAqEEuxGhesMwATMc4mF/kN/tK/Wgtnlvj1ldE0QUiSuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpKBRBfofoXVBKJiNx1HekJx8JE/7nXM3R7VmUGojvzozwJoG
	Lvd4yuZbZ2zDlfKeBVzpdQAm9k4qaynygjUPPM2yW/gTbTP4SwYY6dQj
X-Gm-Gg: Acq92OFcyyEq/UYLWAHtKIAa4wk+xjq2yLmME9zt0/296KwJ/PJSLY8G6bClsrs8oSJ
	zJSU3qUBmHZ3rygq4NAQ1bKq/cKBj7Pk8resUgo77ez5vWp0MsMwhZ3MbQzJF4OVP/GXLoJnBX/
	n/dJ7bEtkIeNOB9+ORReV0oQ68HcGPvDCC6NReHp7m+Z2L6yXrQiP6tVNJIIJe5ntY9h28O6+ID
	f2NhuRJLp+BV9uncSCqThAe6Avb8q+cVofhwl7yvt04gptZ3z95A8j51/CqOFACdio3oCrH70im
	6KSEIiQt54acUcyKBEoBG3d61xpF7vAKwrgAxCSjOb3ygb13o/a4glO245txxASwSPUaJRaZrpi
	CNMSfdcmC8T1fJo0rHVxJnu9B/nuy645kRac0Q7S/C/u/qESBSTblE4YEQBRkaQGELrx8wx+T1Y
	QfEF7hGWpu68OLn4AC1t8kUbip0dvlI2QZ1Iv6rg+Q6Hq3QBeUfslCiBiVMyMcyTnQCflIjgx3v
	tlkYdJznxvbb5ikCGpHtO+xmAqfTjcLehNMXp1LI4M=
X-Received: by 2002:a05:620a:1a1e:b0:915:6432:b0f4 with SMTP id af79cd13be357-915a9df50bemr3893866185a.48.1781058302791;
        Tue, 09 Jun 2026 19:25:02 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afbcsm2334280585a.9.2026.06.09.19.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:25:02 -0700 (PDT)
Date: Tue, 9 Jun 2026 21:24:56 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 23/27] ublk: Enable lock context analysis
Message-ID: <aijK-EvUSF7LnnnO@fedora>
References: <cover.1781042470.git.bvanassche@acm.org>
 <0a98c4c6a776f88e8e300ef9b205c190a3857609.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a98c4c6a776f88e8e300ef9b205c190a3857609.1781042470.git.bvanassche@acm.org>

On Tue, Jun 09, 2026 at 03:05:10PM -0700, Bart Van Assche wrote:
> Add the lock context annotations that are required by Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
