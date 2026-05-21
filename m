Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48627349CEF
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406428; cv=none; b=ONWykw5eNlRGR9iswOwk3fHDAr/m2y0IOPz+XpWxDdoLsxwxJrh2KsRIjSdkxjwBvc/cl9S8USPf/Sncw5fKqgy1aZp1wqVRbQJ+MU9JU87KG8eAKLX4PSq45wiRmWL3ZjajLthvEQLNHGNxBA8T25eCvVRouhxYZiNZshJhqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406428; c=relaxed/simple;
	bh=YbFR5JRQAlPvBvB4RnhwxFz6PMxsno+6Ov9x+1df3KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrIAPHQuKJZ8vMHzBr2XX9PlryYqv0UQYyDJPvED0hEEOXR01ZpmimGzDtx4jsy/uUST150jAFnFptlNKs3W3BepfuAU6C56zEx3cdtW0loQdD6LPhwBuFw2Jsv9RTy2WOLo6IKhcfdBWtkiVKyDhDgS+FtPq2yDDSWc3cKHCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB38jBHx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB38jBHx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8be236ce888so65719876d6.3
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779406424; x=1780011224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FssOPHIlgpeqKut1/nr9FWA/mAFcN6bKyXEkArdgQjU=;
        b=iB38jBHxVuiyBtRiG42SEat4eswPknXtSQDHNFbPEMSChG7U+u9bZlx+XCGlsfJo+P
         Vptc5vmTm9c6DOJT3kHWieh8GC/O6RAzcGwGUTl3zHpuLi4reidf6fwoqAwweYT6jAdw
         tZPWpCxi/+sfZ7HkPNrM0EHn6rdVCVRx8c9l8OVn/gpW7T1Dx8HiF332Ee7G8UEQ/jdU
         yFH/nMjnBZd052qubeQGjdK8/ZutcXBFN4qD8wnOp0VXoC7/m8Br4wSV5IiBOVEY/6UV
         CZB5XKxspiRb5BVKz6ITDk6Hw+hb4kl9pM0sbuhojiYOLxmbLZbXI0MpheycBuIC9W+Q
         kJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406424; x=1780011224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FssOPHIlgpeqKut1/nr9FWA/mAFcN6bKyXEkArdgQjU=;
        b=cMc1Gu1ySgx8y7OAEmAa3BNOyZcjr2ECiVxvNtbosnxpgnS6jYL9K603T79Dsc8Luf
         lz25eC/b0bbV2RW+SgmgW2tCXDR7IXT3OshwxD42uGqsTjWqrWMg4NHjK3w2ICWCsdu2
         Z5FXvWhOsfbZYXpQ8zQGthh7i9+xdwY9ym7e5iArVXl/SgHCxuJypz3gEGVc6aJ94iJg
         P9+GxGxguQ1Wb9TJLvQFG1WFGTfO1C4Q4Hp5OvKKUh/zhKFwseaD0e0m+ls5DaCVwM5a
         o5F/o3WwWZ9o4G8S72WEYR4mfZ28cfZA9xCjq5craB9pA8jJUepHPGWzoSdT9KK4fksd
         WiYA==
X-Forwarded-Encrypted: i=1; AFNElJ9gtBx0rQUETbnnOZtp0h9UPH4h4w0bDEp19MqRZEaGmnQvtp/5hIAWS19bjfbALf0JoCupTH420LKCTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznUa52MG7+lwufXUhP37Tztn7J/jEbajFU7vKuknUFmzfu9kVo
	Zska4O6b/Cvjr0belKMzAa8cCO5tWnFJwUipuVnG2M540zSG4/B1VJhq
X-Gm-Gg: Acq92OElT4BBHuYcUQsSgBXPQAfr9KwqGiClGYx75Lymq/W4Pus6iknC9kWbUWWUYIH
	InWHGcjvY5yVJdMa9IUbxsw1y+Wzgmqkdogkfg4LHLg8M7HnAmcjsb5Gd8DVxJmW0+Rakerz4Hf
	09u8rZSWSfwGsfpRnX9c+fRw89LDLtHEt5sTZaRHQCL2OWwcyfEBrRV1v5q4xnPdA5SLgr3PAsi
	Aj52B4QNf1H7004q8QAu0PVsg5fW2pLnmqWRrd9kjcMyQ8W0BPF6mVnyu2S8doIVaJddaJzhpTH
	bLRxmgcvismOstjwY/wpIbwGR7T8GO0C010hl7mOQ2DnBxjmYzOIL5k4DzvULbXohnIBeP5Szm4
	Zaxh/wL0ZROu2Kl/S+30RonoPsrHueBk9K55HxQa0QafRjeIR6zuYyw9qhwQVohHfipC0fq3zLm
	TtZPawEOOJEvC9bXij6luvX8/x+4UCL3ZmoT4bt31ScxGqeYIe8YEvlmiHIhMwip9sYfPICOOrH
	a/kY5PhLNyWmGGYZRXCsrjqLtGKrC2qMYqNSOVEWQ==
X-Received: by 2002:a05:6214:4a07:b0:8ac:b31c:9961 with SMTP id 6a1803df08f44-8cc7b6a0f22mr23701116d6.43.1779406424215;
        Thu, 21 May 2026 16:33:44 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm1787816d6.24.2026.05.21.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:33:43 -0700 (PDT)
Date: Fri, 22 May 2026 07:33:39 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ag-WUymW2vwVyMJB@fedora>
References: <20260521190253.242065-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521190253.242065-1-kbusch@meta.com>

On Thu, May 21, 2026 at 12:02:53PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug. Fix this by popping the cached request before any
> possible blocking calls if it is suitable for use.
> 
> Popping this request first holds a queue reference, so avoid any
> serialization races with queue freezes and can safely proceed with
> dispatching that request to the driver. This potentially increases a
> timing window from when a driver wants to freeze its queue to when
> requests stop being dispatched. That scenario is off the fast path
> though, and drivers need to appropriately handle requests during a
> freeze request anyway.
> 
> The downside is the popped element needs to be individually freed when
> we performed a bio plug merge. The cached request would have had to be
> freed later anyway, but this patch does it inline with building the plug
> list instead of after flushing it.
> 
> Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for bio_integrity_prep()")
> Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using queue limits")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
> 
>   This pops the cached requests first. It's simpler this way and I don't
>   see any strong reason against it.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

BTW, as mentioned in v2, the request may be added back in case of merge,
but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
in batch.


Thanks,
Ming
