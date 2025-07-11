Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C352D3EC8
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241573; cv=none; b=qx0L29yCcyBgzp9GQlUeDDj5Y5QTMToJNEpqDWaBPoVE3kaQShdN33o3xqprTS67uGbXoEl76faCxTLxBdhoCNS022s+VgJS9lJZ7jcF9cF1EaSsHNdz7dsD3eR9XA6pG21JFVBXsMUbIuwpO4BOELD/sfYAMyyJ14BH7b0UN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241573; c=relaxed/simple;
	bh=J4sU6VTvWKKTAwDD7WfZnoaI6D0zzyXD9dtPfdGAk7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/2JgymQZOrzw1ReH+auakNC+DlG5L7cilbgsq4IsMGVxtY6yCmPYSm/rJKOKpGxMv0YZdFTouPOo6ucZDKccyqKcJ2rFtPzIquvLjQ/WmO/XAYtoIUqAs6pVhU/xNpSQmSs/H3yew5ipOv9o425q6ITXNg+Y42rkw7cgZpXdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HbHox6Jh; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HbHox6Jh"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so7154715ab.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752241569; x=1752846369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGoi4r9NKJs+rl11znJ79jmIWSjCjlQ97Hi9PxhBxVc=;
        b=HbHox6JhCMXR/UjSgVMjM9kfdzIkkgGlSTWJc17b/Foo5XKaktey7FdvBPEyMf8MnX
         u0qXC0dZbG/zngRiZBqXJepTr+SAIWpWd7hBT0RNzwdS+BTyvlkblnETMG/QSEYWr46A
         DKD0oWtq6GfNU6tKCIwlLU6G/gviHO4VpD/fP4XCaS6Z6LmZ+PgKwr/VL4gXqGg6R0Eu
         oswqbexe+Rss/x6OF6cUFQ5YDf2HBiQnh9eFk+X5RHH2AwbzV8fv5aE5lOx2yRD9obBo
         NYy+HYWVoeKfr2Lg8SUDvMmwzksXytHR4EhMXZgnR94zcbxtjl/a0We0oddOZFzkQqr9
         vw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241569; x=1752846369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGoi4r9NKJs+rl11znJ79jmIWSjCjlQ97Hi9PxhBxVc=;
        b=H+XVw2rJEqsh4RJRIdv3av6EzMNQeErx5QmYErflh/QkNFb7/Rfyc+zslsn5ozfl4K
         pam9KY5EcHCsSzWigULYfHIZrwhFeQa7/e11XmOjKBKHcMuAvazkAIiaySJ6v+DPWYnW
         JY4f1ei24xGoxGWsT7eTFXS8lxG6ZQmBJHGvpfRH3A5MhWyWtJioIWCpuIlUHsXmvjpK
         ENn7eQfxO9lQBG8/B/qvcfzrESXZg0buMXeiXGLo8pujrxzZ9EXMVU/SrRyQdrrmQM3S
         LMYUEGvsqZBJqEY0XB3sJewWpN3VRkdk1FAFPc/MaozUAMioghU0pRlXwmK2rD83ll20
         DRlA==
X-Forwarded-Encrypted: i=1; AJvYcCWKl6zupTAAwx+kK/G7T6dhTge/jNKkXw+q5/UNSicC6vugoBYwWqRPeVAjBCFt1EvbDKpp7WaDF1UxmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIt68MAhsRaByfDBUq4+G9GuXotGLmexaA8zOyg2OZSsmHpat
	p2OsAdg1Vl+nbIcZskSjUr163leQMufCD2iq7aG+HVyp0DKOQsSwm7GUnLH8a/5B248=
X-Gm-Gg: ASbGncvzMlfaBvEAC+e9t3eo2dUMsMUU5mBUBjUiShWK3JkbWZKgc/R4WBzLCgopBif
	JrJJuNOLtSBFJmPyhXObOjGkIgxULoKmIdUzgpy3ix2DVWKXJ2hVhiQc9jGKyIoL6ROqXvtsa98
	5IAU3htaBrelXAEFwLiyszMHFVGKhKfye+om5FGrG6nzgcJ/Ie1NkqB7R2yKFQg9W/rFfLdFFyC
	iugdT68qJPwJl7YEaoMnlMtp3y4BZNI3r80UTYzQNVnTnBh79/VC/hL9RCW5N9XkjFAUx0Fqd5t
	1JNMAab/M4cc2YwkTpcCgEGDsxhmCRsM0FR7PzVI4ESh0hFRWe3KB6PdeD/8C2HtVc8hVT/ZVjJ
	ViL+k9pmdAHBrCDFdjXI=
X-Google-Smtp-Source: AGHT+IEyicA1J20nDNiTVC2pjs5quNqkKDeOeKrXMpB1/yVxblKgbnjmlVmI6B21RyzWKcGzAV1WfA==
X-Received: by 2002:a05:6e02:198b:b0:3dd:d33a:741a with SMTP id e9e14a558f8ab-3e253325ffbmr37975045ab.18.1752241569426;
        Fri, 11 Jul 2025 06:46:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055653244fsm853838173.21.2025.07.11.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:46:08 -0700 (PDT)
Message-ID: <3ec40c94-ad7f-4985-bb40-275ebc6427bd@kernel.dk>
Date: Fri, 11 Jul 2025 07:46:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
References: <20250711112250.633269-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250711112250.633269-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 5:22 AM, Christoph Hellwig wrote:
> Not only do IOVA mappings no need the separate dma_vec tracking, it
> also won't free it and thus leak the allocations.
> 
> Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
         ^^^^^^^^^^^^

b8b7570a7ec872f2a27b775c4f8710ca8a357adf

-- 
Jens Axboe

