Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5523C4E9
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709506; cv=none; b=NR0LzSVDKqaw1kLL2L3U6mFuQgdAA7K4dWmrrJpxd9mYispVIzP7moCgaQEIFsQGVoizCUGEFAfVFvUf6AAiC7lIl95K+GgXfqdI97D2dQA6Xt1hE22ju11cnRBLeMPxnIVnz/9ps7T4MNZeM7BceLwIN/gj7/o9avTz1pZkw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709506; c=relaxed/simple;
	bh=LEKf7ReBBW4x06sP8voH0gmMNtCB/3WFy5yhruvMchc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7msPGRPJGtBooZTCa7aCbC1l0cWy8EF9yDV9HV6viyUHcXCY/MVumNCPZ9PNCN5FaLPQrTermm/5G0xt2z02CWfbgaSaUOGuGuPHRivwTVGhXJCCeaJ1z09Zukw3oM+EKK/xtZXRkCjKbXV1zvlmjeb2rI/G9VaDck7Y2W4dhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SlsatugQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SlsatugQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2953e415b27so20464245ad.2
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 23:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763709504; x=1764314304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLVy4PqtSP9d08BCyr5MQS6G9NM16pJbK5CN3ue32T4=;
        b=SlsatugQJrcBJC/vy2cDPrFDSWYNzDDiBRXnr6nJ1VvzR9trf083jR9G0uaItHxkPA
         W9vteJe1KVF6A0CahQJh+7URaCRM4Lzx+yint+gEPcURdJNcbMR92P2NHqi38GhrHgHt
         +e25HCF3x+R6TzCZ4py0iFNVQyQlsHljhWriE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763709504; x=1764314304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLVy4PqtSP9d08BCyr5MQS6G9NM16pJbK5CN3ue32T4=;
        b=UODaDtaHdw2Qk1UINyEK5yfSfQsbHg/d4MrhhpLupah/WXu0mJD0Jfqvz3qY/FRdj0
         /CiHAkaWEAqn2LG9JKhH0UH2+dm/YUjqFCEd98ZPpN7wfYWh/osVCUi+AJt+xIKAIRlN
         A0+H3jzTQ+9Hf9SipbecggQl45WBVcmb/or5OQv7ZCOxOqZ8x4xs4Oj2ZHQM2+sKcs/A
         OdEUpTLPTP6BSJHuHuSc0VXYMqw5DoK8qS6p03/HDdwtX4LIrM+PvebIWwul8oTdmDEV
         5KM+UOK5RPbU3AsaelLJqCWBpGGTXK9JkOZNma+PKQssYfaT7tJ1Q1/gwAilkNCxEtAn
         nybQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnhvBGBjXe/D7oAHV4TS/yWQnGQGXCjVNLZW30ZFGf4aFzHsIdyykHw2OrBTuSbvTAHgzNvQFChNlP2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NSVvVgNSjITTvnXzWuePGj1XXmBDINvoawPVGMkJeErdmQMc
	nKme0A5xGJa8/pU1MBKwrJlaZkU1AizeiUGoVxsGW1ckwVyyaOLBtSHUGqN8usHllw==
X-Gm-Gg: ASbGncvA0cokEwfTVoiqeMuX/bFCtxHb44NcmQMk7b34G0D6GWa3mlpLAI1WhFiZyfU
	6C8jAFs4YcdNZXDOQBKR48zEeSxFJwRH/Ma7U9MJMyPBmHA6+pw8RQnFcd4fTGtqZeB4psrPgCe
	fUQjfRRc6di3GFeVZCVjTwabBUnnSr2P/9ldt/trkAfeJu0Vmh+e+ULyOPqGZpPsYQwScfTKOwq
	+WRzwiJke8DM592djJ2J3sdog3B3NdD52MwpOM0ErD+8fee7gTLRs0skh7xyShVq8a75fRLodA+
	rDulU6uhrx8vmhmXEolr/eIyl3fbUk6KxhMQipuTOX2PjAmKEerXSWv8p1srANcD8TgSUfI8GdX
	Eqs4JdnDWTqb5H0eL6eBdGpBXypzAsJ6UvcW1sIJMFd4AhNS+fGxIiRuH3LMK73tuBEaxQf26nd
	oX5EO/nSzFcLYT6w==
X-Google-Smtp-Source: AGHT+IH0iPbPk8WqFVSMBUDAjWKZ19pwNO2jNUWnRPqVPFMVDfJcWBYAmp1qCPR2gPCRKcs7y+CAGw==
X-Received: by 2002:a17:902:e950:b0:295:96bc:8699 with SMTP id d9443c01a7336-29b6bea56bamr22043195ad.20.1763709504342;
        Thu, 20 Nov 2025 23:18:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a6b22sm46552195ad.86.2025.11.20.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:18:24 -0800 (PST)
Date: Fri, 21 Nov 2025 16:18:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@google.com, minchan@kernel.org, 
	richardycc@google.com
Subject: Re: [RFC PATCHv5 1/6] zram: introduce writeback bio batching
Message-ID: <b4okc36gfk23jbkba5ar7rsrgjvlicgpacf4ms2qpzhhjv6xyg@vgftkihnkx5x>
References: <20251120152126.3126298-2-senozhatsky@chromium.org>
 <tencent_F47110578F73D23CE92FD0AE86A27F6ED507@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F47110578F73D23CE92FD0AE86A27F6ED507@qq.com>

On (25/11/21 15:05), Yuwen Chen wrote:
> On Fri, 21 Nov 2025 00:21:21 +0900, Sergey Senozhatsky wrote:
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Co-developed-by: Yuwen Chen <ywen.chen@foxmail.com>
> > Co-developed-by: Richard Chang <richardycc@google.com>
> > Suggested-by: Minchan Kim <minchan@google.com>
> 
> I rarely participate in community discussions and I'm not familiar
> with the processes here! I hope the community can be more friendly
> to new members. Indeed, you wrote that patch all by yourself.

I apologise if I was "unfriendly" to you in any way, that was not
my intention.
