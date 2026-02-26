Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B93803FF
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076903; cv=none; b=YwOr1jI6NyFZjTfIYFvEGxPB+r3DhBuTRkz9649WidEzvMxEGip/AIaQFkqq3/ZxW/gmxK1i6IRo903BafhYLa/n0Ft4fjfCKc8gKcgJ2jj+pB8cnMIOhgPIuMwKhkMCx+ZSEJEojv4Fhz4FyMHWd+SL1PWuzrAFsNR/L1Tl7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076903; c=relaxed/simple;
	bh=i/NTjeuLnse6p6g7kBeWZuyZfgSD4fLROke7iVDX8dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+p8MgPynnpQ6ymYCrdgjmSrEQBJu6o5ve5JNRsV0IlwmI4ZU2uEAcJAeaKiW7+KfF9V1m3V1+viGIhzpaYq9iPPaME80sH9NR3gy7JagmrEf3QuswG9YHzCSrHIzQ5Hcc+pPd9f/t84agSV8pCZ/26Pn0QNF/gnLju4KkTjCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVwsXcMQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVwsXcMQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8230f2140beso953384b3a.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 19:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772076902; x=1772681702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyaVGnjfNzlE1ptyk6n5dAoHe2pTLjJWHR99F+D6o8Y=;
        b=PVwsXcMQfll9dApnBn2YqWwWB0AdiAK17ce0qHg/li8HP/8RuHUvH7RXXJvsDZn6O5
         b1QUArCnB8gPk+rkoRGe6nzBlzOR8Z1TmkkxYUptlNSxK8vytbQ+5veXKLnoH695QBcp
         xyKZ4YUYIr/bTVo0srI20J1M1PiJ6OubFc9Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772076902; x=1772681702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyaVGnjfNzlE1ptyk6n5dAoHe2pTLjJWHR99F+D6o8Y=;
        b=sM+y+1Y1F/s5IWxsX7ZjhGEXKGazuib3zVB5qmfh6VBtNV7LQEKAeAQysVxzpiyIWm
         mOsMggPrpdhfZPIK6B/C+fY9ORAL2QlIdTxexr3hy+KuUJ8Kl6NE6MrbmT0FDcUL1JzC
         ftnbXDTK+ovbh7l/tbRG7vJA2ArkzfV1v6p3TnpiIbiaID0xEI6oGrMvEemDwlbsFBik
         MXEck8JkCRK0rKl0fBdkHT4aBWKLiWGX3xtR2l36XgmjSBItv1gjnrf13wuthuHFAbxm
         zUvtwxxdgTc/07Z4PmgifWBLvQxgUvfMdatLEUDKpQ9xwtFWaUpw2N//0YJWtNIBCgbZ
         m8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWCryH03kt+5yYQYbCxdWDIHdSL2OxzvNZBOg98/XhZ58ChqV8ek5EpbAYblq8eqiCth2qZi8JCLtxbUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRmQuaa0vxuhq35JJbsFQauPu9AkSq9rE3Vjpd1dF2UltasuQ
	6tX4SvR3ogkaoFtWRU9DrHN1eokOjiPfcZbtk7NDZq/pYR5xIAscnOs5V1hP/YgejA==
X-Gm-Gg: ATEYQzzJ4f2ik6ECcYOO36RORNaV61/8EcluqTcIYtISscnlUi6ybwFoJ7siPj9mWEq
	YEicoNQLhoqX5pTLbg+pMtTzwWZ+I69YTZjiuGs4X8VyvPztbTmpVZxby3CoTzrnzMaaAtWeSL5
	RtKSnkhrhqec6OhHA7/DQGXKLYLfz69bAFd9Z4oVv+/acU59MZ3IVuCn3Fk8JdvzsRj0wJgDugx
	y6Lg1ysqstmlNKmbCo1/iDt6LPa9aLCwzu4goCiYz51xc8lAUbXr9rlrCesAcGhGJekQVNgZW/J
	yIr9WGygreB3lpN8yjaB5p8M7GEvAS5qcKXA8lG+8oetVS/eZhJ6DiQMkuWOWkWcbs86LZEpB1Y
	2TNeHtas4d6UutYite4f3TD6vHEHS7bBXN59rVXAtAG19dPBcB36s3joDbTAApVZT5zP5Y2l7c7
	+6WW/GzSlhe66SUg+txVID7WfMNXFQKiAvGqCaKF1zaWsPuCArOzQaZojiiG8bg81uui4IFcYH1
	Q==
X-Received: by 2002:a05:6a20:3ca0:b0:375:4503:ef0e with SMTP id adf61e73a8af0-395b1d2376bmr1303951637.14.1772076901993;
        Wed, 25 Feb 2026 19:35:01 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:f7cc:c9c1:b4d7:b50d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801849sm431165a12.20.2026.02.25.19.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 19:35:01 -0800 (PST)
Date: Thu, 26 Feb 2026 12:34:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, Richard Chang <richardycc@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] zram: rename writeback_compressed device attr
Message-ID: <5mpns2z54isunnwyoembp5xuip6jzcivzlxdomrohtlooedqfu@ymznfhwglrsd>
References: <20260226025429.1042083-1-senozhatsky@chromium.org>
 <20260225190329.8f76b847d391c71d58988234@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225190329.8f76b847d391c71d58988234@linux-foundation.org>

On (26/02/25 19:03), Andrew Morton wrote:
> Fair enough.  I'll add
> 
> Fixes: 4c1d61389e8e ("zram: introduce writeback_compressed device attribute")
> 
> and shall queue it as a hotfix.

Sounds good, thanks.
