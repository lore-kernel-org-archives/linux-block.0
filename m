Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBE1DFE3
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932336; cv=none; b=PTeyX+ZkoQ0hslSsTBvdDlBu1KcP98lRPwgdYw7rXy9nklh1nn2yQG2v1gtGsVPAkiLAex3jypO1yN+w04vJSrvc0o3qKzdChZlQa9WBojiwJoUuSnd4V10KHrZUepHIykEkGL3Fk+DXDNeRa+CAKuOgdObkiLqv6Fw2MWLKhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932336; c=relaxed/simple;
	bh=eA6ldqBRhAHLvq3jjuRFuFQnb7+rmFvFT97u4ZFg3Vo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KMwCB//MoYsTYhr97BUiJUr3Q9BEZAl3ySTwhcSdOVSvU4bebYtsxGIyPjIKcf/eebBhHQf9hGFx0GwxsHWPcONF6u17bN8McfBTx00LFrp5i29ELEmpbp5RvVmdB1O586iSyQesoiGRjXEwZB4SL7cpBzRDS+6nEixwJe1ov78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0VlIElt9; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0VlIElt9"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d5657327c1so133409b6e.1
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719932332; x=1720537132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC5w4Z7NhZzZ22h+VavAi5K8iam6rpcEiHjH6VyIkHY=;
        b=0VlIElt98UxcUmmTsQh6uZxmlio77fACZxPK40UAK+FySDTPkDZwDILoX1UTlVidRI
         o5SsV8cXkY/O2OzRCCC2ryexUBq0S/r2zt6bO78o1OIyJy+H19dDKAH350HZUqFTRu+E
         IJ7P+cARTnSqA99assHreCzkSEMgg6VvgDdthgO2XA6NVM9vUAs+t6reEOcN2Im/UQW2
         +SlRjJyMuofZ4BhQsHG7JJ3H3sXmg77m3cUzjNj8Ekz2ylgDTauw0/vV5ieX3tsgEck0
         4/M+lsaadfdLoOaw8v/mMFEjo40H5lX1nY57Ov7kSHO8SzquqrZWchGF6o16sh7lkETp
         7PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932332; x=1720537132;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC5w4Z7NhZzZ22h+VavAi5K8iam6rpcEiHjH6VyIkHY=;
        b=bEd5LHQ5Z7yirSqHjI2nCp9XexWaT5uq9/41vBh+Y63Pbc8KT4tC0zVzDA1dxjxV0d
         TaIKd4UWefJnQ3wbxQ/lpIX7jJPNGXornS+zNFsRAp9/tKfyRQZU2zj7THfSdKij9A1t
         2gPdSqw1D0ytFIM0tC1AQHuOX4bVnyaQQ2+Tc/r9bPJSdMBMtImP1qqUK3h8eA/Jsb6g
         puqJnyj2RCLI1zNy5A6pSF1YXVxUKEAE0m4RM9jjxNeX/YR+sd43Y+3BBVYMzmTbTOr6
         tLVT1xoIovpGqoO8H4hNpGTqNJbm5NSXV+4i6z8dTa/NiFc6cBjuyvtbhXpXFS34cweN
         YTmg==
X-Gm-Message-State: AOJu0Ywqwc0n+d5X0HFkAbDibvlUXSHlgv1xIEvM6eo7xPfQhmT2Rj48
	/29MVBS3o2feDfcdMHJnDrMiaOWmlRYAxISEw9OBcj5xRVA9j2JRr+Lqi2XODpVeANuKEVmrGcT
	lyyU=
X-Google-Smtp-Source: AGHT+IHjXyBegweuP5shI8xgqg2TwdZiFDH/mXHt3bHx/1loEH0dybyJHoCDbm6GRfPM/LF6lGfY6g==
X-Received: by 2002:a05:6808:1494:b0:3d5:6728:74a8 with SMTP id 5614622812f47-3d6b2f087c9mr9233703b6e.1.1719932332531;
        Tue, 02 Jul 2024 07:58:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fb48ab1sm1698965b6e.54.2024.07.02.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:58:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240702073234.206458-1-dlemoal@kernel.org>
References: <20240702073234.206458-1-dlemoal@kernel.org>
Subject: Re: [PATCH] null_blk: Fix description of the fua parameter
Message-Id: <171993233179.107674.11009315552790935060.b4-ty@kernel.dk>
Date: Tue, 02 Jul 2024 08:58:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 02 Jul 2024 16:32:34 +0900, Damien Le Moal wrote:
> The description of the fua module parameter is defined using
> MODULE_PARM_DESC() with the first argument passed being "zoned". That is
> the wrong name, obviously. Fix that by using the correct "fua" parameter
> name so that "modinfo null_blk" displays correct information.
> 
> 

Applied, thanks!

[1/1] null_blk: Fix description of the fua parameter
      commit: 1c0b3fca381bf879e2168b362692f83808677f95

Best regards,
-- 
Jens Axboe



