Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19915A0
	for <linux-block@vger.kernel.org>; Sat,  6 Jan 2024 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQ+JiCKH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso110379a12.3
        for <linux-block@vger.kernel.org>; Fri, 05 Jan 2024 17:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704504688; x=1705109488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/x4G2NOGgkM4BomWa1Jm3/3G3KxEzXzbUkcF+2T2yU=;
        b=MQ+JiCKHDV0jVrLKvks/XAxKdeeTasd80luFrSE/VCdX+Me4StfRo7h9iGjR+zIjvs
         r5wpw31bq+XgTBNEFjLc5gSNc8zNjlDl4Cvogl7Ce9+ltH5kz2dhani2PiDCXDoQkrUi
         XoYuzatdykpFkD4c+FQxZWYS4uZf5YpyvBves=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704504688; x=1705109488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/x4G2NOGgkM4BomWa1Jm3/3G3KxEzXzbUkcF+2T2yU=;
        b=q9B4N1h56nco32Da/D1BvhbH2HQ6XRKoIYdTOzI9bZrM+0H6qCEkPYzEzz6PQ6fjGS
         x0du3ZgRbTFpfHZXTTiUQXzJ18ajtgbGg5dpR0h1NTt1XCF3qPXYTw8RLFhCG7z2nQ0v
         2AMSoK4tUlYxERig1v9yTE5EXnLM+/7cESsurBDuSRY0Fk9soGha02wecA739noq4rIf
         mxRxzWFenU+XU19NMyMCcNezyIWDEk/ZL5c2gsfMbCnLaEcd+VFsrjNNAYfjFvKkQPC9
         nX+ueLdWkPTGzC9d1+XNTjXVHfqIdH3HCIdRKHVvZ7VfciA6w8S2uaSlmKhY81HyWr4e
         m5+w==
X-Gm-Message-State: AOJu0YwtxMVgQkupYnRKE+X4eav4pS+hrrT69P6rO+8MRJA+wmE4eRGX
	m31VJSkmE2+B444f4FZdg2DhzjByUcy8VSNfNhfsf3Pwxw==
X-Google-Smtp-Source: AGHT+IGd6y4CdhCnCbgjPkYJoLQYfN6tyXTRC4ag8VhPIlTdgxtTGW1VOdYxuPA4v42yaV+NbWCAQQ==
X-Received: by 2002:a17:902:7ec1:b0:1d3:62b9:838a with SMTP id p1-20020a1709027ec100b001d362b9838amr251868plb.132.1704504688232;
        Fri, 05 Jan 2024 17:31:28 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id o23-20020a170902779700b001d4f119de21sm1576270pll.112.2024.01.05.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:31:27 -0800 (PST)
Date: Sat, 6 Jan 2024 10:31:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] block: floor the discard granularity to the physical
 block size
Message-ID: <20240106013124.GB123449@google.com>
References: <20240103081622.508754-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103081622.508754-1-hch@lst.de>

On (24/01/03 08:16), Christoph Hellwig wrote:
> 
> Discarding less than a physical block doesn't make sense.  This fixes
> the existing behavior for zram before the recent changes to default
> the discard granularity to the logical block size, and is also a
> generally useful sanity check.
> 
> Fixes: 3753039def5d ("zram: use the default discard granularity")
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
