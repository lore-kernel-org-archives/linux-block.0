Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA522D4B4E
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745908; cv=none; b=W9vCbEeWUzZntgGxB9Ytk7RGAv1ADxqo0lQMIPGZH9TwVZY72TyWKLWrJbYtHpPqcx0sS94FKPdcQMIeqW+VhaNHPd2g6M1QKs9m+Ktos0Itzy8p9hbHQznbv7LaSvswA/ekgp02PEyRQCmAoHvK+bm15zIBc6cBRdeCIkcmC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745908; c=relaxed/simple;
	bh=3Yf64pfcogQlk4v2s2J2th+rjyDqCfKUN+6JYBEbPuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBbqe7PE/VDE6/JHDzQLjuwThSW4I/9GkN/JaNpmBXxmgjAB7E2ollKfHViZbyNBv34T6XPt2MAm4VrXHrjQDnq+qDsIUv2KVYp9tmXgCpK+iBwJIiOxYV8jnBWu8ZZUaMCggJyRddQWs61yBLK4KnqMdV/2pQPwC7MY5i+P5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bt8D3ZiA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bt8D3ZiA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so522854b3a.2
        for <linux-block@vger.kernel.org>; Wed, 20 Aug 2025 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755745906; x=1756350706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PwWYwojP48UP6NxxlGldKYH4e+LIBgJy3s1OksGbUiU=;
        b=Bt8D3ZiApfUY996bUuWIFwEUiiPgeeyxVMK2FlISwK+q79MdZLp+o6XlzPx/CpQus4
         xoMBV+YYHlcgN5V18OUoOkzPWQ/B3jWnTEXBsM05moCcBzoqpssl8I1OZ78T7sQKj/E5
         rtBPm3TbAbK0nXGxGLvRnC0gLf2fKrB92/ih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745906; x=1756350706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwWYwojP48UP6NxxlGldKYH4e+LIBgJy3s1OksGbUiU=;
        b=NTMenHtbgyAqnfwOzscNvKE7gblOX+EotX2n7QdBbdEv7Jle8RmCTGaBb+Tapkhh5A
         RtaVKJnskDHvlVa8M/tSdQ14F0wCiBZZEVPVPF0QXkgmdQYGI2xbjZpxKPRKa4hHJG3M
         bJg9m5xv2cLJiuCSnqI6Wb5uNZaXsCk5NKRn59XUU8oQeleHWf1Tx4M10KlGHktDIrH6
         N4htL/Q+OpZAqdzxi3pYQv/H+wzm6i7nRgtbBRQG4DEf69CmhCQ2Bb+b+MsEP8PoSpmZ
         tBVbSO4zjTQrYmwj7S3ruR0R595JfQRdbIOtDTX8w+BxkjD5oZGN/v57XM7f9VvQJt6K
         b8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXLOBskA583XQ1ysWTPbIjuO3er0C4LmsLhK62Rb2hxOikCV9YeUU1iJ944mzbWzAW48iRsZi2ZKQMDrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwUy1MxRM66+9kzliWFcxq3I+R/vgTDw8QNuH4csQjbZ4EmTk
	JIUpDQLt84HsguUY3A35Ts95O/C/4sQNDroB2fZodxafgNjM0Yp6Mc9KWPpp7xwhWQ==
X-Gm-Gg: ASbGncsgFwEVF/qeWCtplCHqFRSwsui4cxjfGTAp28GMx/nDPUGFs8MxpmjfrMLFcuy
	XfclSIK58FuIwX5Zb68CYYSyWamTdJ+m97S7y2fd1BId2O2Vl1iPGyBjxAagFwYghRjEmyKAEHM
	d1B1EKNz08dZjTHR8iHTsRUzkSe9pIEqn6XCtEjcBfbEwOZ64awNBQqi914FQ7iQ9n242lFndoo
	1blcIs3w5J9FVZS3huNdzCpG7uYAWpnLvL+k8DElKiMtyhKCAUQAfSI3Wx4amlnSBiZTXLRcKF7
	yJL6mv2IarGWbTMul7u3inEPqXhllm5HYWEdR1k6xm8nCBDrSFsbsAbjD2Oh0vHU1csf6bDFG9h
	oMlVobtGCqJQNEqbWOEc19cZ2Yw==
X-Google-Smtp-Source: AGHT+IHT17C0Q/6Um/csBodwgEZCS+XLQhXWDgMHeLxbo55N/1nXjbuRKVPPv1kJrzzv/ZBDssvW9g==
X-Received: by 2002:a05:6a20:a122:b0:243:78a:82bf with SMTP id adf61e73a8af0-24330b1656dmr1182926637.57.1755745905918;
        Wed, 20 Aug 2025 20:11:45 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:389b:e3de:fe43:6aa0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1b63sm6911845b3a.7.2025.08.20.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:11:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:11:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: =?utf-8?B?54mb5rW356iL?= <2023302111378@whu.edu.cn>
Cc: minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH/RFC] Zram: Improved Compression with PID/VMA-aware
 Grouping
Message-ID: <a2xcxelvtrmclzkedyfavynsptiwmeky73esh4ekxzbyuicem6@6atx6b4cgwdp>
References: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>

On (25/08/19 19:43), 牛海程 wrote:
> My recent work introduces the following changes:
> 
> 1.PID and Virtual Address Tracking: During page swap-in
> operations at the swap layer, I've implemented a mechanism
> to record the Process ID (PID) and the corresponding virtual
> address of the page.

Just curious, how did you do that?

Otherwise, I agree with Barry, this looks sort of very complex.
