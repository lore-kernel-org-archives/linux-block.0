Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BBC2EA
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838546; cv=none; b=iB/ilsoIAyQONud7qZSfqSsC2S1kDAvkIOiIviI+sYBmhA8be9isNz0bfert6WXsus6ZKgXqScyVNgQ0exMjvjs4+znqeVJ2BcOGsWd8YDO7yoHy5JnIKL/+0zM0e66SQbeHkci/LddVPgKFhY3T8z+z5pp7JogBg7kvaXx6a2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838546; c=relaxed/simple;
	bh=uXchtAgIJ0fURM9ygukRqhjROnhWDMmRQ7wlREF2dTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmAdCRwNoqrybvWA0FJwclHfAqHoXWDOtsPrCVNS/dVSpqS9ebm7NIEdPMBq+3LsTbHFVudWNkEjGEUYatcILw974psJW3GEkeeLb4rlihvZMpmV8EY0a1afcNHAsEH29OBLeMYy3HGJkGhYFBaQd9fpqQtjRgM0BKvNmdcQBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wKF9FK4C; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wKF9FK4C"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a45b3f0becso1491894b6e.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838544; x=1787443344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6liC8uD3F6/S6ZJfKuSXQx8GeoIfO2pZ4/+PmXMPPM=;
        b=wKF9FK4CbPXJJtkrxhSXVfyAaFw/G1dFG9qGWNv3SuLl9afv3L4Ro2JD4WizODXvRJ
         UC4AuigLKvTJ1yK2/jGJ+iMyijPz1qtLC/eoNdq3bG6Kra245qPKL3cNPI1xBkcijD1w
         b0cc4A6+3SIcLZ0tUTKJRZO5KCGtXLMMr2LIXteGamMuz9vH4756Jz6mKawS6bTx7g7e
         S1umDhYilud8n2CMAZEfts9HzY2t85X6CCXItwWpkQF/AReGrtUYZ3mU9JmoOFUTuy7O
         wi+WdwANFSlOZXmgtYQcX5WyMXxRVEQtZUGOuSRHHg7KdQkpjfksExVT7dd/xWecqP1C
         UJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838544; x=1787443344;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6liC8uD3F6/S6ZJfKuSXQx8GeoIfO2pZ4/+PmXMPPM=;
        b=Mfaq3HAaNG29qKPdWwG/xHB8qsihdonncRv2Rvuh6vG05AgvgE1a8CO3sjjAlPl2Tn
         3IB0G5AEj/eXvS4tGP9+InYU6P1W+t3DMp0bLSPZKEE05rXSxVwVQzTWhs1EAVBXahRC
         bhC9BKVSpWDCIjDE32RB6v57JR4GstIOIIYxTGNLqFq06aqYemQEv8EbIPOwFs8QGZiQ
         k2Tlh3X6UucOplzPAFNlkBKJbxvh4nPfu9xF9AmqJ2hwaI8Gz0MwV4jAVklKtPiyhfOi
         vwXBofTUHaM5IvfvZRo7V0EC46JTmY7RxgC8LCpfr5DjP5hjkZjqYsSiti1sO/c8ke2Q
         Wk9Q==
X-Gm-Message-State: AOJu0Yx8TbIGRLLDJ5h5bzPBmAT/5CzC1RbOGxxr8CGRiqjEgOtsdUiD
	OQKpqGOwkfWWx0eYFBobT+BcxyxMm2AIzWc794ID7gY5KwWamRFT5iEebcBtr/yTf68=
X-Gm-Gg: AR+sD12jZ6+9wXdG8IYS8M+bwLTKR2S5fprsYQhfJwGRQQsbp8LLXfwhtyw+bLckMMP
	M9Rqvby5iW4t5DMV1j7vPtqwKLRIIJs6eVJtEu7Tp/J8b74lXdEgi4CfX00c/tg2KGsuXPVEz7l
	pdAbTHCnaCyDzdO4h6o8gkWYwThbxUO5kmy2AQfk7QGfrW3JSKFt1TgcX5y8Hu6WRadKM0FBPdU
	OSHvmM7Jw1u/9HdIcSp/+qo6/VHd78auslZNDRA4x2Oe+steGFo/qgcOjSVqumEoTvYeTtq8FzI
	iQ4N83BmctUQLNbrfjscpCOO5gHFbpf483Ghf9VfrkJALYKw4MzghjVJmnZJZ1aXZPjbRAs0vSv
	mqjcn9B0EKyd1avRrG1Lg7GQckt45BlzhPFyowROcC85AQis07EYYTh7oerp+x9Zud4oNGNI74t
	AFNofD1dfoLk2Z4AFbWiKDfGySJwfA9QzaJZWS7Mo53LTrqAbncuniOe0NumtH3weYTTayvPBfc
	ABU8e1scRVtWmspL9EO3YrAz1OKHbDm64wwGTFgBw==
X-Received: by 2002:a05:6808:1918:b0:4ab:32ea:95f6 with SMTP id 5614622812f47-4b241e5f0c0mr15455005b6e.13.1786838543975;
        Sat, 15 Aug 2026 17:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Carlos Maiolino <cem@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
 Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260810-xfs-dontcache-double-defer-v1-1-aea7484b3e49@columbia.edu>
References: <20260810-xfs-dontcache-double-defer-v1-1-aea7484b3e49@columbia.edu>
Subject: Re: [PATCH] xfs: avoid double deferrals for RWF_DONTCACHE writes
Message-Id: <178683853844.1984298.10537884425177679953.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 10 Aug 2026 12:39:19 -0400, Tal Zussman wrote:
> XFS already defers some writes to a workqueue when transactions are
> needed to process the I/O completion. Disable the block layer bio task
> completion in this case to avoid a major performance drop.

Applied, thanks!

[1/1] xfs: avoid double deferrals for RWF_DONTCACHE writes
      commit: 913dcbc5670cb772bddf9799d17f975e020e8326

Best regards,
-- 
Jens Axboe



