Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF5B22616
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425174; cv=none; b=L151N6odlSw0djo0n1eSiXIOXoEJMvXzXwhwcX24Hj+gU05ZrgDF5hbGDqjWHA8TUDnKSKEf7sR2iFMeqtXQEQ1Edqk2MQaTWvbIvUAY5vyen+1F2uHCsrFH+be2YXIAWoKizRjDv20zNDGWf3SJqlabA5FRrlhnEP6O19egrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425174; c=relaxed/simple;
	bh=ZfHW5ORT7XRzcUKfRQooCszf25nFi1jIGLevVygjuRI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y71HdZYTid8r9viJEtxwm2AC5YaXeHYdm9v6sPRlXgmpYuRvr4dUQtlTUvErh8SB4sQXJ1sxxtQfx1e4w8TWt55jPS+uiHdcGO15YzpVh9aB+6NECzgkKiyYobDZfTUTPM5P91m/UFtkU1nVPmuyt8KwBZtZlkZjCcQFQUWzaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=trKWiKFR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="trKWiKFR"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e9ebb9cbaso428284e87.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2024 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720425169; x=1721029969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMzImep6xXcG1FqSzXqaB7PgKUzLlMXPs4ycuRjSr0k=;
        b=trKWiKFR2r1BwA5i+VQDH56QiPOz/gcJUXoWx6ZHIY2F8RSPruyhvGov91zHYp/9u0
         GW+91ecf0rmB1K/6SVY/ZBnno8eN4/RZ1Syyge+i7Gb0Y9yC3y6+6bxnYRQuZowrXD0P
         i5IntiqYQDgO4+Ftrma4XMI3CTTBENbqRu5tYulSrAEnCW//SseywlI7dBtYFcWbD+ri
         uV6ypC4uq+UC7MNGF2YrBqFpX0NV2lxBkaSQiZTNj8jjKaZOazxc7oBI5TUuFTvWawv3
         hMbu8hooqYtOcTfGrpD0fCPT5ydi9qwfPJ6RQ+Dnnmwi2ofDCf2kVHi2zm78ie8NCkiX
         zwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425169; x=1721029969;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMzImep6xXcG1FqSzXqaB7PgKUzLlMXPs4ycuRjSr0k=;
        b=ORhRsqDJP4WCydckXiy+GXYaiR8yVoYihtT/GUQpDMhmo8nBk6AOUf7RyCdnCLLepU
         3YKZcgpnAbFbTznYPfsUnPAJ0DTJ75BOPijOE3xRjav2WJIeBlx+0ZdN2HG5cEkSORws
         y9j3V8h+xVBlPIaHDs2QGQnmpBgDubYeF7RI9vKS8UHevp14tmnUHssxNjkpAZCP+oeo
         SsjL48XWyTSRzbWEeIxFO1A8qas9PNTRF13cYkpYA3Xs4O9ZSqgfKQUZtHR87Foq/qoY
         64i+aXuS9AEVqV7xyhsbLkKEtmMAP85QPzU2+difQHXml392JaaK2p3pWOT5yNd1RVca
         QftQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYrssjUaYlN96NQHO4rm4DaxqTZE9aa+O9BC1lsITJJwSlriIrIYmrmS2QDOTweS/bZUqkkKhIpGZAnRx/Io+ZnUKYf/0ZgjQNoTk=
X-Gm-Message-State: AOJu0Yxnn433JG8s8o8aW+NIL7cNpz61BtD2UneStFnHwQ75Nkz8zgs5
	9NojzXewYTqLzaLITdvZTKnyDBEIofWbHgCn6ESYsrqOKyrqVo4RXxGmH6edJg8=
X-Google-Smtp-Source: AGHT+IF3T7f31ZJ4Mx7HP/jTJqQaeYo/dymdJ107qP3vvORyiIRo8c3L1vdrMw5ECn3l2NYvwc6aAA==
X-Received: by 2002:a2e:8ed9:0:b0:2ed:59fa:551e with SMTP id 38308e7fff4ca-2ee8edff698mr67592251fa.4.1720425169089;
        Mon, 08 Jul 2024 00:52:49 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee8481aac1sm15375011fa.21.2024.07.08.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:52:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
In-Reply-To: <20240706075228.2350978-1-hch@lst.de>
References: <20240706075228.2350978-1-hch@lst.de>
Subject: Re: add a bvec_phys helper v3
Message-Id: <172042516810.332984.1933565483350043014.b4-ty@kernel.dk>
Date: Mon, 08 Jul 2024 01:52:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sat, 06 Jul 2024 09:52:16 +0200, Christoph Hellwig wrote:
> this series adds a bvec_phys helper to get the physical address
> of a bio_vec so that callers don't have to poke into bvec internals.
> There aren't a whole lot of user of it yet, but with the new proposed
> DMA mapping API we might grow a lot more soon.
> 
> Changes since v2:
>  - keep the existing (somewhat weird) description of get_max_segment_size
> 
> [...]

Applied, thanks!

[1/2] block: add a bvec_phys helper
      (no commit info)
[2/2] block: pass a phys_addr_t to get_max_segment_size
      (no commit info)

Best regards,
-- 
Jens Axboe



