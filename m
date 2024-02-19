Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B02C856
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344289; cv=none; b=Qhs4KiE1PX2LFM1mn3gPyuxu2DS8i5EhV/lXotwtdNChQOkKqRIZbSGjiiIV2QT7Ijrunb2+9d5vwQlpyjTk6TO2KncoV4Wrp+FplomAf6ZREASFHqxATts12kD6rNAbB4xXM8o4YkkWHVbPjTJ30TRmplgWHy4Q+NQjH4Ij/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344289; c=relaxed/simple;
	bh=zDbj09vXhQ9a99MHLCKO+w+Rwn+2vxV620SpE5+aZl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIq0sE7oETGJyIbroriKB06Mdpy+Bxa9lVFz4D77pWtp2djKSssCzbWi4X5nInoq4qR4GT5qrR158yJqV9XacGitlsZsurpam5c1ON7o17XFx/SJXb3flEe3hSM8P7ezuMuXxorVcdwoVLSAl/UQdPFgDDEuHxuPUvvyJ3Z+Ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R7qtCaZN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7qtCaZN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4047938a12.1
        for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 04:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708344286; x=1708949086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD0Q+YuM0aYncw1zT/Ixj8YCSgfiS1s5vMLj9q2v0Ag=;
        b=R7qtCaZNUKh5QFooyHccPMDt4FajVt9G2m7Ve7QRuTVd2EtTdRLdDjGT8N/wifzIDb
         ZSCvr+irs1Y25nQ4kZUmTWsk1fzVY/O7j+9KsK8gBEwe/ilk9H139A8fwi9fkW9mp3lw
         nb6BGzhypxsptP/RiawM9y/LEiWQbntszHmpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344286; x=1708949086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD0Q+YuM0aYncw1zT/Ixj8YCSgfiS1s5vMLj9q2v0Ag=;
        b=bx2iK34oqg75oHl8JWpm1wBqkkrIoA2p3UVY4iAY/2VVknJnPPK+1xXvihjP5oAA8j
         3b9q+fZaLkmLAwEe/fckJvzV94w6UwYzZ+JqjU2XDztZfGy+sA7abewfpQwUjwM30Y9e
         asXNc4T0t60GF6cMbez2sPi7o0GjRpRxWtmPhrftHQ6njTdd/4crMcNW9miuBQ4flQRC
         Zw1NqhOO4qyUUdl9mUe2QxlzavitqR1SWPXo7CeJ4SIvI9L9fyiDPK3AkHD0hGB4baE9
         mRjnOuQZOp7dhnhaXCiKudHoR+9eDGcSF18R6kZBXNsin5QHVXXoxqA7CjCUmz+Pn3tU
         ZiDw==
X-Forwarded-Encrypted: i=1; AJvYcCULBoFq4ky/GH58UdC0GmDiThUwOCMnw55cO8sUhp3LbGgn25ecREBHuEwbbIH2nYGdc9Hejtq7xGHHcDAGBZyNTFF16npKwA0evx8=
X-Gm-Message-State: AOJu0Yzf17IxM89CxOIxHQ24el5OA0mnqKj/2ja0iKE1q8f389U+1diS
	/wbbXGxMQbBWPCyOkPXoVO1W2few4U9KzXkR4U2oWNNxXfvq6KAUOB88tbBrsw==
X-Google-Smtp-Source: AGHT+IGI3q8seWzsit4w49RmDdpR7qXA23sSQ+6AKRh25Sx/UF2Jg2gSUuWiILezaNCe3BsJyRg1Qg==
X-Received: by 2002:a17:90b:607:b0:299:69c9:da3b with SMTP id gb7-20020a17090b060700b0029969c9da3bmr2641050pjb.38.1708344286161;
        Mon, 19 Feb 2024 04:04:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8998:e92c:64ca:f09f])
        by smtp.gmail.com with ESMTPSA id sl14-20020a17090b2e0e00b00296d9c4d5f0sm5125314pjb.10.2024.02.19.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:04:45 -0800 (PST)
Date: Mon, 19 Feb 2024 21:04:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	linux-m68k@lists.linux-m68k.org, linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/9] zram: pass queue_limits to blk_mq_alloc_disk
Message-ID: <20240219120440.GA11472@google.com>
References: <20240215071055.2201424-1-hch@lst.de>
 <20240215071055.2201424-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215071055.2201424-6-hch@lst.de>

On (24/02/15 08:10), Christoph Hellwig wrote:
> 
> Pass the queue limits directly to blk_alloc_disk instead of setting them
> one at a time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
