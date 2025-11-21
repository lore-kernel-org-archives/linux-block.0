Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114D3385B8
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711928; cv=none; b=YYqj7hp4euL6nxB0mGO/XPNm0Aq9xb/TDHEFCK0+15WLaqTHRp7bCJJvz4M5Tq67f+CNAF67q51pBROpgNCXDWNp3rw4DJndn1GlfFi3txm3uAqtt55MRtqRnR/JPw5qUMA5jsJWgLhkYtkQs6fLhNPtTG8C2JVUNbtHaBCf/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711928; c=relaxed/simple;
	bh=nwE8YCPVNZ28lrH7hSXOu7NmJ8vcWDs3VtzUQRGqXGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caFzVPZi7UyzTAOHJoOBU4h7PyKZ8mdiQYS4lY125DuBpbMF26Xahc3MZaihwQTfKOXRntPUcrBIlcJqfa1eHRbWPKzgrpTwKKjeu2022VzinrZR75i2f5W9KL6qS0Sp2j60DInCaPys0J6Alj7MyFbyHUt3fWiCr3SA5FE2Gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RAWGectf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAWGectf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso1177285b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 23:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763711926; x=1764316726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULtA7+no79tQHYGo+HGcPlA57KIY7uM5/EPUmiOFSmo=;
        b=RAWGectfa588WAMVmpAlKpRYyTq91Q3g/fuZ17pt+ooCiEXzHn/jL9ya2mbl2tgD9L
         oPdwhGLl9CpryIj0d6+j5kmot3usXmEVkoMTtxnbyLCfU/Mkv8UM73oobNUt5T64VPEI
         1ZbTcniIcQA+TtDaTSV0FISmO1oC/ZPqgALjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763711926; x=1764316726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULtA7+no79tQHYGo+HGcPlA57KIY7uM5/EPUmiOFSmo=;
        b=dHrMNn4y/XTwym1Bqs10XbtX1WTGRR3IhwuHeJJZ1Tu5Y0XwFS5YNiDZMSuI8XdwIU
         GWiNj23NXn36s1cFCf/dYeW5m1xzW0fUJ27O1QA32/yj1OL++0aH2rL6BHzcLJakMSQv
         duttlSekQq7mdY9ghmTryol/T+U6LRYCWru3026prmtzMv1A0sb6slWs1ztTRrZS/rtt
         xr0272jMfyAjptDfXMzKnc+R18SunFo5IA1r/KZZ+MLHhnmwhuS0YXUkrhUisCY1TIzB
         aDmm8hUANx7UBQvCGBT9rSeg6GcEVfqCT23ckI8RwLsXNMGsYYfwmp/KSJWgU1aIMFZk
         bnNw==
X-Forwarded-Encrypted: i=1; AJvYcCVuJ1swl17SdVlzhvenJox6as6xr5O9Y8dU4zFtwfRxFN5LuFRHMNJb3AIuhvIbuGHHsd9tVAMZT+JGMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVDjSl4CLbrb4EoSP13wNqonInFnxcc2H8jtxbXijvvtBKdw7
	eaCvwlA2/A9rr0C+AjSVkYktcZ8uHsxa1kduSBCsW7LGRqYLacz/i3CA92hxYUD2kQ==
X-Gm-Gg: ASbGncvVZCUAMw3oopJjuUYYzLfAouwv26Ua1Vtrs2UIDEga65VUhKJ0GODfthSOb36
	MgF63OxaOLj+S9XDHdy2+7ugdA7vG0GlI/8KrCLVaDJjGSnNVGFq3kw3tcm0RJ9K1Ici24U2JA+
	DjbKK/ses78OfxqoZAnh1WpbbDIIyuoNO1CAr2eoiBpqfG86SRCI2ngrhkfVvwUhNtOCVnGMm51
	hrJ2wfObr1h34nWQZ9C0+pd1qmyoiSDMd7e2U600KZmacrrT40CD/U/HEGQYqdgCSg0dKN60ONf
	RfSQ1uRWuOLs+dBEbFs/KXsR7mDWQRH3ibGfg+3nC8Av62AkDfXUh+7Gy6dJRTGsjIOhMD8SZhN
	kw2Ha6fJAuNgSbm+Wliemrg12vj/NZ/reCxXz0o4GTeGdmBco4vWlGHegF/XLYDmBwWbUQBxKdc
	DxY7xwwSJaLMl7e/bM4bHP6oD1
X-Google-Smtp-Source: AGHT+IF8r+u0PMm2TNqKDmt9NgdUlfFVT/4Cdqlq2JQX3RkS5uXvuVrL+4bKtdDMN2zzv+JF+RTdLA==
X-Received: by 2002:a05:6a20:7289:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-3614f506763mr1920075637.21.1763711926304;
        Thu, 20 Nov 2025 23:58:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed47b388sm5171421b3a.27.2025.11.20.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:58:45 -0800 (PST)
Date: Fri, 21 Nov 2025 16:58:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
References: <upyms2wnksojg6ix7dha74bjm2gfhv6ieef65k3f2our4r6fp4@kjtpmu4mtbay>
 <tencent_7F5D453FDCFFE315AE59E73779635F865D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7F5D453FDCFFE315AE59E73779635F865D08@qq.com>

On (25/11/21 15:44), Yuwen Chen wrote:
> On Fri, 21 Nov 2025 16:32:27 +0900, Sergey Senozhatsky wrote:
> > Is "before" blk-plug based approach and "after" this new approach?
> 
> Sorry, I got the before and after mixed up.

No problem.  I wonder if the effect is more visible on larger data sets.
0.3 second sounds like a very short write.  In my VM tests I couldn't get
more than 2 inflight requests at a time, I guess because decompression
was much slower than IO.  I wonder how many inflight requests you had in
your tests.

> In addition, I also have some related questions to consult:
> 
> 1. Will page fault exceptions be delayed during the writeback processing?

I don't think our reads are blocked by writes.

> 2. Since the loop device uses a work queue to handle requests, when
> the system load is relatively high, will it have a relatively large
> impact on the latency of page fault exceptions? Is there any way to solve
> this problem?

I think page-fault latency of a written-back page is expected to be
higher, that's a trade-off that we agree on.  Off the top of my head,
I don't think we can do anything about it.

Is loop device always used as for writeback targets?
