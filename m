Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BA37BE83
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373594; cv=none; b=uhVHPmGAvf0dtUrfzuE04azL64f8jqkvLsMEUlHe84hzGy0UED/eikFtkZxTRbgc6f3yb4hKIaWzO3mRb8FvAo8jsOtUHXIeaLv5hLAkp/8X+r48CTDVu6c6L7WVj07hEfTgOc9IGY/S13pYPCSqEy016ovaemHlBbijxWrEPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373594; c=relaxed/simple;
	bh=70OW5ShH/kqO2yK+u932q94LT0CG487EPQmNfC7PiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qONoFmOZ3DixlLl0R2UOrtgNM74Ehl0otOCTX3Y7Yijw3aCU1HcjkjJhMGNCKqk/3s/ij4SC4do8bSh7DSmLRoMScvhAwZCcsOzpb5Ga8pE4Jcolosn9zxXUB4m5wBuoWhjONZZ6suc2AuAxTzOY4pM+BIUmxen53ZbuKffg0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkxEfUUD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkxEfUUD"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1148801a12.2
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373588; x=1788978388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x8T9r1V4Fm4dLLkn3wT9Y3iOMgRpVRxafH+zo6DqTKc=;
        b=BkxEfUUDNANV4O2DWZ0eVqYWDrHlc771B7XO0TJOLmKh3V7pm4+9jF3XC8cpilQOdi
         KbfrxQVnNX6bt46umzb2r7Zo/MFXZWRMUMPQi1jNTN/NCr1gqnGjY2r11Q5PaclLLXMZ
         lPINfJAK9Re8ud30nLnxnVj0guoOh9srhbKvzsQ/pDfZlLiDuu/38hAuB9vbxurnmZIA
         4yto63/5vOhZUgw0I/M5ReJG0hPv2Gs5JKnK6j0vc63N+WKkwrvo5NQf3CDP8rpxnrfV
         /5KnKfgK9d09X9+7Xt+ffrkMTovDTdD7pVDGoTkzLfv+EGvx3VMmU40Tvf4z5Xs6IBYu
         3R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373588; x=1788978388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8T9r1V4Fm4dLLkn3wT9Y3iOMgRpVRxafH+zo6DqTKc=;
        b=hy5krRatAJUtU6k1B8XzawXNh2P6qjkxTp72LAjXLH+4MO6NfwlovOVBaHcXoEIWqb
         HHC991dWaF4JER03W3P7Z9iCYbUNGxJH20u+ifWttdibTpquJo2sZ2wYN+MER4MQbLd1
         nl3YC5M8sxG3Px6bF3oSQucnP+4OWpWs2/vmAch/zHKqev4gUW4cRy059OuGzyTjVhKR
         K+jV1aO4fGpTOuRxiEDmByVzPVo8OdptSF8pvkAEeNQ66W8AiqY+y8GnkewWrsAA2r81
         fu0ZChtba02zaKhAOq1a/YwczZTNtdioW+fHSpHXXX8AKteqtkK67SiSPkgcUG+nNhfu
         4+ew==
X-Forwarded-Encrypted: i=1; AKwUvBxcFyQ4w2/Z1aenbyUE4SRmWKxI/nP32YTHEUPx3nZLoca2pZCa8ijLUWqlexENQMhi/IdBmyAA42SxSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njXwRJgH4LbrjaFt2nh+SSlmq3naVBbpKyHMvoTk8344BD1Q+7
	AnfSED0xkZFSDtK3eDbuI0kVydaqS0R2eiwDVCUuSguoMwYs1JqXdOg=
X-Gm-Gg: AYBFou1oJ2Adho5vw90TTBs39NvzY/cLBt0YZE7QgFSSg7F+rlmdfeIi0Rg6Wa6Noww
	IsVQcTVRUVMNA0cykaC98wN4VAnkHL+q582zlZVSAK8CvFgLvi0+vUjsAKOzbAOSf3mTSy9jg3u
	xxt7TlnVmI45clhDjs4XzsbrCYOGVOpPxQsrrxLGlZoUG4C7K649k4dwWuKIQRtKA0hBj7MepSz
	N7SjN8ev10h2gN+BLUYTno3jCfZPFaN5FIiljWcO7Tq5++Tj5AfmPihCmFkMbpAj/EREr0WnfDn
	IGUIQSDNT7v6qEiKufEhlOZHb49NEk7dovI9ehP+gb6pP2K/u1dMdvGvy0qht0+GS5Q2cTBlKKU
	yqESCZ7or1Ws6EFLZkxqYrNp+KRoRcS0uluq3fKPv6tSFSGhOtzrO+PAxigrOe8vKRukCN4VfuR
	u4IANvPRDT9zRajZBmsDvYGD0c2iHgKDQMvOXvO6Gnqw+cbFqAf+drh6WNXI4FubeJtb4mwf0qn
	4moVe3idhogib5+rI2jFCvZ8/Y=
X-Received: by 2002:a17:90b:5288:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-39aedfbb2b9mr10243473a91.6.1788373587474;
        Wed, 02 Sep 2026 11:26:27 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:f76b:3efb:3463:cad7:ba39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430ea2d3e7sm15195061c88.6.2026.09.02.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:26:26 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:56:19 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/17] xfs: add error injection for lazy bounce buffering
Message-ID: <hvosc4jkifetywtlktfn6wepezuckp4hb3qlctq6xqoq5glh3b@ri7b6u4r5eod>
References: <20260831064010.2574896-1-hch@lst.de>
 <20260831064010.2574896-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831064010.2574896-16-hch@lst.de>

On Mon, Aug 31, 2026 at 09:40:03AM +0300, Christoph Hellwig wrote:
> Add an error injection know to exercise the lazy bounce buffering

s/know/knob
 
