Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BF163
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763856513; cv=none; b=jlSetYtgK75rjN8xQGW/DRAqOSSrNVZID3dt5AwXiYJVPONoV/vr91a6u+HvqijwaSn7BF/LG23y07337AnM8Ph3q+NinlG101Lj+V+1njmkaIqg5UGO3X9tCczEcdnCmWwxR/6PShXn9khVCpRtVPCZPTnr5Z1mp7qmW5DRqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763856513; c=relaxed/simple;
	bh=bfMP2Or8DYbGDeFbBYIms1w/uF2Mcu1FRwx9qTFL2/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljH4GCGhszI6nFgpg4vTMgaDfjnVO6DKQLM+XKLGKuQkh3zs4Yd20uscKyOdgtpvmhz5Mf8EnLtO8OKgu5sgi3j8D8ogpOiC/H9RZhjPSpS5nFtTmR6NxhGoeLA1TONse7NKtBCXxgH8ymnYNaHT2o9U/7rypwSltbWa7J+23IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DdUAI22/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DdUAI22/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2631439b3a.2
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763856511; x=1764461311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2muAciBOaE/k7xfizoYb3tuAX3qHAGDCvnzhObdNAnA=;
        b=DdUAI22/HcVfvgPryNayYk/ZsGvkIgWnQKYtUkC59UGeH6JDcBdVytTHkA92jt+aA4
         a/mXP5guNgK+00QiZcb30WFcENACKeSc+EAGL/nY7RCusoeqiL9JN9z2n31NjRQJwgfd
         LL9MgNwapG9k4zioemdsY1uj1eCkyPNvIhIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763856511; x=1764461311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2muAciBOaE/k7xfizoYb3tuAX3qHAGDCvnzhObdNAnA=;
        b=xH6LTPDNdiHqb6DR/eA4/Thf1D8RAZ+TcYqpL++DtQq41KH6d4RYHS6pQoMOV20oet
         vfufcKh43cKl4xh/HqCFD5lIHINBe68qWSkayyA0CYBGSTACSoBjvrVeoB11OX5EqyaB
         QjzsnZsaLeEE8GcwV+RgofM5PRG7cWAno4lmD8/2RJJ+I5A4aI13eyPaE+c8CYDZbM7O
         dJSLgq1oHyWaJOKvWKZLN2GQinsp69UwwmvURHnDG/Y68WU4HTHKoXzel+9WABULGgZC
         RdQR/12EJ1EX5nWQqxogVC1dO1PwH8LNr9Wl9UpFavmNLpkyFv8H2GtSgBCH+Wnpja78
         t+3g==
X-Forwarded-Encrypted: i=1; AJvYcCXLese6G8ujTekktpQV+GopuKDAlS+aKLdvme6Q/yPhPxRtasiWC48gTM3YGjzLLQdzogHA4VFZI1oGsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzloSMTIA7xWeewxWdv+4EZBKM7lUvXdadFFGvwnE6uQUaOrz+1
	+xSvfoALBR7Rq0CqGkMoxPKl5UAY13dUas0hWw6kNjm829ZcuWwCEfoy2ORf355x/g==
X-Gm-Gg: ASbGncuSZtvgqrL26KgVvu6o+bw+tAaLAE3ruQpxdaY02Ug9lA/FmGDO7kBJcbCVEit
	EjouxbzR6wAeF1HMAstA5X0I/VBheX0FppuHfveT86JjhEmhTaz6LhrmIyRWdhIl73IZ3piEiis
	xdzz0dLEKrXoPIb74CEyYy52/t3csgvuwshUDgZNJ+05UBMCKimpU2VcNQrgewV7ZM1GIApkhIP
	aHkTRBCDCO7LFBWbyuLRFRGpsqFWOZJMeJ2SihPRecauW5BJN7FMwOkMPntcrzC7p1+K+qYP9Sj
	Uxb+Nsi3jQa8W6JP8e+BmlhXP/GEDlluPziwJylIwEDmRTOuICTwVF9V/YCt0gSmM9RBIWPqNdI
	eE0A2uoh2Nu7azz+Yv0htFJwvwmyKk5eORWlXX9XDIuwaNh+hi3hgdQXgcvf4gGDlMmV8tReONW
	EiSi601kU5cSJw1jPagtv8nUhYbIrdRGtMv1LbfHNLLzDnMBsk+Q==
X-Google-Smtp-Source: AGHT+IGDke1OPproyf8Ea7+53qXNHLy3i8Pk7zk6unoaUI5Yq/mG08AMT5TtfH2aktdVFzwpQF96lg==
X-Received: by 2002:a05:6a00:1ad1:b0:7ac:9d93:3efa with SMTP id d2e1a72fcca58-7c58c2b0f28mr7440867b3a.7.1763856511542;
        Sat, 22 Nov 2025 16:08:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:296e:57d:751e:5598])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d70asm10039686b3a.13.2025.11.22.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:08:31 -0800 (PST)
Date: Sun, 23 Nov 2025 09:08:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <nx6o4gwpetxjeyfbu4xyibulvldr3xz6lyfjrar62cidy5gxum@xmx4ojyq3mbf>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
 <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
 <853796e3-fd44-4fc2-8fd2-5810342a6ebe@linux.alibaba.com>
 <ztqfbzq7fwa5znw5ur45qlbnupgepaptzjaw2izsftbtth6zca@db4ruyaulqab>
 <2c6906d1-132e-401f-830f-ae771fe836c5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6906d1-132e-401f-830f-ae771fe836c5@linux.alibaba.com>

On (25/11/22 22:09), Gao Xiang wrote:
> > I thought you were talking about the backing device being
> > ext4/btrfs.  Sorry, I don't have enough context/knowledge
> > to understand what you're getting at.  zram has been doing
> > writeback for ages, I really don't know what you mean by
> > "to act like this".
> 
> I mean, if zram is formatted as ext4, and then mount it;
> and then there is a backing file which is also in another
> ext4, you'd need a workqueue to do writeback I/Os (or needs
> a loop device to transit), was that the original question
> raised by Yuwen?

We take pages of data from zram0 and write them straight to
the backing device.  Those writes don't go through vfs/fs so
fs on the backing device will simply be corrupted, as far as
I can tell.  This is not intendant use case for zram writeback.
