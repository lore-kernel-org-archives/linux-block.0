Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624106;
	b=AVy/crvx5QpPMx6QiMYVnlgk9dOgNDulxi9SAEddnE8CqxZZApXM5JtJXqvVAzSInfuA
	 bUvEuUVhOg8wmc/dE5GkIy141s+IucYI2Dd3BEbCDrURlL2Py2AFxsu5N3pXuKTcz72hw
	 kNtptTlRYTl941kUGatl6qjuOdoVetvQm2BWebzHQEtr1BGjJEuzTWRIfO8Ktbs7PujZ2
	 9YaGGDYGA9AbkhlikuYmlCI7tAdVIuTqpTimiTsDv7n6B1km3dcyy1mGjWZ9VAldAuOrP
	 zD3Y18oBBq3sMl+pAAkbkfe7GT2xyZiXbZ6njlCFIP49yqIuRbUrN02WEWlyqCE3XRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BRx4eAMdYV73QvASEjGEoxzHdyiMslK/yjtX9V0T5Tc=;
	b=cRMmTVYvsLbmTkwmRVFQgKU3jTZ2vr46I6RFznmy7LRinWYmMBnrK4RDBLRAA62yZLLw
	 VoYIOgteG1roS1JTDqAf0wchkBmfWzDMlWJtu0BnjLHqzLV2sFYGq6V3FyGDr/aK4NojU
	 bKTVL5kuDiN1qgfGosDxRU4Z7UPd6u/m38CAkC3SrjhLiFF8xtqKyeMKs/XJqYfP7Xegm
	 d8ZwS+1fZJrR894wyy90VGpBue7esGVZhLQkY2dP8MWTWKjBxN2PsROd8eyP9R0PToNbR
	 9Wt1ObkTxckkwoMWsZ12sKXH9mg1zDn3aYZGCNBuUks1Yp6qTpKgEcHxuZgyMOhsBCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Oh/A7P2y";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F64606A323
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 02:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F64606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Oh/A7P2y
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3720addb068so2586584eec.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 18:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794624105; x=1795228905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRx4eAMdYV73QvASEjGEoxzHdyiMslK/yjtX9V0T5Tc=;
        b=Oh/A7P2y/i7OaeP0elOfugLH6LZVJdGwvDVLLPQTYFkuyjrI4DXSuTCQml9Ay2xisC
         p01/pRceBbJVM+EvcmMhUNVKptbnP9KgK26AntLzuPB6BuW/azxZEzQL0GGB5nK7ZO4B
         Rrx3Z04RzaYdTvWnLNvyHSTZIn9QXUy4Gd3gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624105; x=1795228905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRx4eAMdYV73QvASEjGEoxzHdyiMslK/yjtX9V0T5Tc=;
        b=XMlScc3I5ZRA+o519QjaUpK7IURyrO2/Ns40Hcfmtw3AbXepe2Wgw79320SV/Xd/ip
         85/Q/v1EtvwGRX4V51UToSGpcEFy7Aey/sNU65xsOsGRJXByeowfoGRyrx1BZZZ0j4Y9
         RXz0ma/M4VIGTm3nqgJUeM8MZfeJDnRQR1K06TJVpNg7CNoIEYW4/UmwGgQ4RHBYBZRs
         xXvlv/ywv/g28+9zWxnm/AbZJckoisVCMaoANwxbsKo9UhBX5jMIcwFmSnahWswn0SYo
         sIIzfXRK2pPBEukWPq5oe4U7j4P8z+VDtUrfRU2dJmcUQb5PiiMLlPQycMQDVnYQ3zZ7
         zVSQ==
X-Forwarded-Encrypted: i=1; AL+hErH7kxmuEm8Z9Hc7UTBDMpqpPY92SZly77SE1M10rMFsoSpRTtntvc2GRULpX6Q0Tov2WcwcBSNq4BbIQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+YrUWzzPkaWvuFbeVG145AL8tTVL6UnBypY9fDv8Lfk2z5U1K
	R9B/YBQQBJ5/hkoPMBH9uv1kghNEsD3P0SZ9WVKtYRJqRxyBH58uTzONPiRZcwrk+A==
X-Gm-Gg: AYBFou1LYccgcy5Y4PSw8YFJWL3F+ftuxpDMIOVCQmzlAwcxQ3abAzDcJtt6aPxj+R3
	yRA+ORYsHD0+lctmJROMjte/A5mAI34ZeVFCpmM2qrUrZ1hRf8agGZB62//Fyp5elE1d9ET6EjP
	q87FQac7sCxiANihzV6ardlwbE9BlawDaEUxhVw/Lj+buNr4KpNUwi/1rH6wA/yTeWh/gFbARwo
	GVXUbVb1Yn0VJTy2vvHWxqE8ZOEuZLe11ayqn0VgDzq860l/QxJhEYngSea+1rwy1ZUDGw0kAvP
	K/6Xb3Fn3JzKAuE+fcbFJR1NXzW8w7DeDST/v4iwIZbj7jHX86DKWxBcynpruZviMVHBjsWOFPH
	qH6XfJEGEk6TWWVPEizpcpUGVnH3gFSplS0FJBKd4LkkymKOL78YKKYyuCilBDnWZfjF2nlSxDc
	JDvKkrYTFeXXT/mKtLZw126LjDScBoJ8ZuKq1zsuHKooe1c+8Fc6cP3okBiqfeg5/oyk3Y35MCt
	fQtdmNeGcyVZYujxMe/BIR9aUWl1YeMWb3lS03K5YBQzDNHUcSRT8cXmdWu4qnxdzgj35qyK/YV
	ZC7zyymhx5qqvukO2ZnRenUlfzp4xG2aNAGXiv3juQeovIOic1lOvQ6GN3qbcrIRUE5N9wl7daw
	/dB/thovBbF4fWKw=
X-Received: by 2002:a05:693c:864b:10b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-37960384530mr3982500eec.0.1794624105009;
        Fri, 13 Nov 2026 18:41:45 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d97f:ef68:a8e1:6af5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm10977717eec.16.2026.11.13.18.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:41:44 -0800 (PST)
Date: Sat, 14 Nov 2026 11:41:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, raoxu <raoxu@uniontech.com>, 
	minchan@kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Avoid duplicate slots in batched writeback
Message-ID: <avfJOxrS2l-f5ZA3@google.com>
References: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>
 <avK6Y1VmIYIBrorl@google.com>
 <20261112232621.6e8916a6e92bbb1afeb1e2a3@linux-foundation.org>
 <1707907e-2261-4d3b-87fb-3dfc662e0347@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707907e-2261-4d3b-87fb-3dfc662e0347@kernel.org>

On (26/11/13 10:50), David Hildenbrand (Arm) wrote:
> > I grabbed it.
> > 
> > I did recently attempt to pull zram out of the mm project, by moving it
> > from mm.git's mm-unstable branch and into mm.git's mm-nonmm-unstable
> > branch.  Because "why does the mm project contain a block device
> > driver".
> > 
> > I undid that change after about a week - it didn't work out because
> > zram is joined at the hip with mm/zsmalloc.c.  zsmalloc is also used by
> > mm/zswap.c.
> 
> Are there cleaner ways of isolating both things?
> 
> Like, many drivers use kmalloc() etc, and they are not part of core-mm :)

This dev cycle is a little unusual, because on the zsmalloc side we
removed that "kmalloc()" [1] (along with other exported symbols that
both zram and zswap use), introduced new "kmalloc" API and this
happened atop of a very large and intrusive zram rework [2].

We don't change zsmalloc exported API too often, but it happens,
sometimes.

[1] https://lore.kernel.org/lkml/20261111064707.2568433-1-senozhatsky@chromium.org/
[2] https://lore.kernel.org/linux-kernel/20261025021839.1542805-1-senozhatsky@chromium.org
