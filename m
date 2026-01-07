Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDE332EA5
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780902; cv=none; b=R0CkS7CxyCiIZ+JNJTR/j/f2J7+tZzue5GxqkIGsyymg4ZOJ3r9M1E2PUGlaMUoj8cjPR5zxq0R/8o3hO2klPh12ufc12w1WqOaTlIYs+slg8QQQlmnLEwFPTXaigI5E3apnNi1bv0viBqLgzoc7GXKntOZ5XmAsGSaJFDTNhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780902; c=relaxed/simple;
	bh=wJLA2xxFpLquTlbeTeBMe+zONj/3wOFgCXqPIKl0czI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3BMKH0oQFl0+8aXPy6UY91e02htG3Q+DdhVYKFROlyYyeUuOL4j59xYKnTVAAO1i00L7Rg0D2DxzJuW34MEc24q1RHAe0aFvb3l35VvF9OH4CDHffpU4j3/EOnrTkW4MaNHRsJrVm5fQAKIg9q3Ye21MHn3EqyNwHNg0lq94hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oTUpIV3D; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTUpIV3D"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a12ed4d205so14755425ad.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767780900; x=1768385700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bceZUEvCu5KrQ/L330EZO18iOd4Vxp4vClh5tI+Gek=;
        b=oTUpIV3Dg3s5XhhHOeQeDN7ZHItZ5FXoNRJS9o4HwkxH9ekgYmRiyeYcZ4Hft9kyFO
         IbyYKRMHXrrHoZqwj4H6A2V3Jc8nS2Gc4x48c2YJF6qPcGJuoffNXq2IWAY2vdxvOFPn
         +aX+gKK3QM3XlBF7pjtYseuPVvNRxlsrinAKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780900; x=1768385700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bceZUEvCu5KrQ/L330EZO18iOd4Vxp4vClh5tI+Gek=;
        b=kQqdIkzWEdJ/eLFlTB3sGMSnHdKzpJ0kj49ZjLadtd65H4ow2EJPub2W9NCL3EQOyh
         qpWkQ35Me6A1vOcBu3TXoZUpe3B04mUqG0k7JOJHaRGH6/ONzhK0iyIp9D00Zb3/3RI0
         QV2ytGG9qGgtGOgqp0EKMRWBdrj/Dlwxow1VbVRs4/mRX9NQfMShL2IVjKRByYyFCi37
         INMOLjvOIrok4uWAL1BGJ/2qv2CS+xn4XBQaX7fA/MzaRXTYvk7W9eN7K3smYwb2vy62
         sQ4xoHPz9PQiqP0ZKpa08WxC04cCOA7fthhOelCphCbTQn24pcdzfNK/M8Y1yUMhMIRV
         GA+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9KFObo/nExDELRcEJyJvC6kopYT5CS0DChW2oL/UNX03qQ9pYMY45XTIEjH5SjVOmdtyGn+rWrPxYdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+//AQOqsw3ju9+Xd+ZHnORfGIt0D0HsapPY5K7WkY6frR+3v+
	UmLUc+n0E9KRWBIVk/CrrxzcPB0UwDXKAhJr2ZvIsWJ50uN9197CMsR+NwZrq6PaIQ==
X-Gm-Gg: AY/fxX6pGa9RJASbCVYuSbl+v148qe2B8b7udzrQFEZvKHdDW29rQxU6sLwmPUhA3tL
	yICqiC0sNzVubkruspNIXYrOA8bQS7ZgQ6kTa8WuS9xTpFTqPvDYk9gq967m7zsEUHwDlXT547r
	MsSyP0NcsPDqBQ60oya3i7sOzF4NE8BaNveOTm4rNLSuTEJSKPaeAJGe1ROvAMLlP0Wy0OY+18q
	MWf7jl52CWgdh9baxJZE4VsgBqgfpAUm6KieCEBZHhJGfIaB/u0xCQsTCLVwIsrtdi6O8KiymDF
	+H66Xrf7K+gqaIWyG1k+UdPH0v27vLr3hQKCCWOiCEW8KsKWKhUvHOIQ7pMcS30IXktZRV29WzH
	TVrpKCado6cGJKnJxy/u9GpDy4UFJGrTT+P4QhZJ+USowAdXGOgqiPmsBYhXEPLmemP1Wy8TreW
	qjbUq10bbT0eIsBimlQUXRkG4qsDRUylv89xgXWHpt4i7pTo6j6yfSOb4+Gsgdyg==
X-Google-Smtp-Source: AGHT+IFQ1af01hhk8mScP/1n6gA5Kz+2eLZd+kVW9ydONrfQdZgC8g2moml33TCqjBCfPWZdXb3RBA==
X-Received: by 2002:a17:903:2ac4:b0:2a1:3ee7:cc7a with SMTP id d9443c01a7336-2a3ee43434cmr16758185ad.17.1767780900130;
        Wed, 07 Jan 2026 02:15:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:7bef:7c13:79b4:e9de])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4795fsm47255015ad.33.2026.01.07.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 02:14:59 -0800 (PST)
Date: Wed, 7 Jan 2026 19:14:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangdongdong <zhangdongdong925@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Richard Chang <richardycc@google.com>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
Message-ID: <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
 <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>

On (26/01/07 15:28), zhangdongdong wrote:
> Hi,Sergey
> 
> Yes, we have tried high priority workqueues. In fact, our current
> implementation already uses a dedicated workqueue created with
> WQ_HIGHPRI and marked as UNBOUND, which handles the read/decompression
> path for swap-in.
> 
> Below is a simplified snippet of the queue we are currently using:
> 
> zgroup_read_wq = alloc_workqueue("zgroup_read",
> 				 WQ_HIGHPRI | WQ_UNBOUND, 0);
> 
> static int zgroup_submit_zio_async(struct zgroup_io *zio,
> 				   struct zram_group *zgroup)
> {
> 	struct zgroup_req req = {
> 		.zio = zio,
> 	};
> 

zgroup... That certainly looks like a lot of downstream code ;)

Do you use any strategies for writeback?  Compressed writeback
is supposed to be used for apps for which latency is not critical
or sensitive, because of on-demand decompression costs.
