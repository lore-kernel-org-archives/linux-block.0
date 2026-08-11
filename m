Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DF2EBBB7
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446492; cv=pass; b=MGtiALqFxY1nAWlWqe7a7qgHwQatSB3kJ6sng85tObU5GYmlgK90FIsbblxg7u+3hvGsutPH5S9Z5SPG1yNQCtIcNMDWuBGsm5Wku1iG5rGO7PM2bjvx5Cw5JV/7aR9W6N+twtHemH64SAQuDWiigPs1DSwn40WMGptXFMwE5rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446492; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl8RAW3EMIWltPrEO63HMcZCcUpEnL0wBWvdTwWJc8MPJa9ha9kX3BZ/8fOW6NEzoRlpOu2NAYF97NhgAEEjoLIHMDEMc+wv2ybYI775qWFOkqvtdNk0ZcBvTFCOrzsxjQ/N1X0w3QfwfMT9MV724mZX+rP7GXaXnhnh1z2exZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmW85Ayx; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmW85Ayx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so4490744a12.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 04:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786446489; cv=none;
        d=google.com; s=arc-20260327;
        b=NRGhIY/lciycVCLNtqYce8KOyVuotvjLOjzoHOwaNVeB+BCgvGedyZ7qbPB5oFOfH9
         Bd0B7Roo5vojSrLLgw7MKrUEYRNkpynGMjD3JKwrtVeAmzZ1gCY0D1ZKQUKC5bWC9SOi
         qQ57sOos6PuoJVQQ9fEDZemKuYSsDvGX9X2Y6i11GcxRKBJRBy52m7l4diYO76WZch0m
         sCRj/lGrNsSo/VS73YOVxY4Q/xLf54jRcUj3Qtq3K++2KjWtBQ585bkuY3pgTIO8NTgX
         D9HaquA0Nxm83k6VTD7VQhrK8R5DtOw/OBYhwc5cuDQig1HrIUFBwNFCxGgwAGlPVh5c
         Z/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=3LUhGZBtNU8kbRsMrIUQGXSxHAUIOSaOCrkfu6dbtIY=;
        b=ooFHR31yWch2szrp3XzP7cc7nw5LRYGS9oK3JVVEwuVgiZmLBn/IXAPK8KJcsTM7Nu
         XDaplcp0mGcQwszR6Xzb20z7HoATkBtxg2H1LsPWFN4cLcz0b+JZ+DWYHdK6rbHkhAdD
         L4GhBE+QqjIzPT/6lJ4kh+95xi81gDCfAULAtlE4rW7dvG/wBWPSQvG+yrTQMUUN5NUT
         rhnTlZE0KVzqEcbI75P+8Q1bNr8dG2LxOL/NOlG1l+G3FZ/Q2vLe1JPnxO3yNiGCMkcn
         UG1k29QyQMxFywxoP1jYDuOQJ2mMsC2PsAZpGE4kw6AfoWq1iQg7hGDCf0Fs3yE8dhSV
         3+Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446489; x=1787051289; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=MmW85AyxSVub7iSmGuL8+l1XrOpn5E3ZEez9HVzIAo2SkctNXwWymyuLYGCTC2XhvZ
         MTwyShMvqa09PCmtSdwR6eeJ0VHAEQE7oiniQGIQDr+O/kavLcv1sC3bczSDrJaD9ISw
         tRjvou4festeHzTC4vu9pVTJk1uw5fgK8A8Pe2gk6xOEtHkKLJoHVGgcZ0/dPSdLSLQt
         /7F/Y2q+cKNCSElgk5CSCFziTmpO2K3JR/7BAglZK7ySN4l/oexDTidCPxS1T+yLxQfa
         cM21xsIGMGTYtphBR8btdUVFooqHQzx3rQtMXSLKfsbRK8Tphohujs8S6p2qN/UM0oXZ
         oZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446489; x=1787051289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=o/KMK8mYq5oJCJOQ82cKT5orqWUKGY28iKaxWYlKI30iShFyEoQ+N1V4eJZUiheoSt
         yQC46IODWDAYNsbLGR1gj6bnFpeIBBfgZ9XStMvLQLZk+dfwKdUjOSGlldDpCnacCIO2
         3o8AHcezY5fUn/L7OAL11eb2Fkw1z8nS+8KH9u41K/9kkmm3uCGUV/ZNkrzIxipbdo2X
         bDCzTlEoly98Db4qzKT5N7v+oP1HcgoyM1rZ9AVzObxK6DA0jL5XXJDb/B5NTzADAeEb
         3IMBT+9l/EFSGrZL6s15gVry1FfFhumZ9TYmWkkwgrrM1LrazsHkGuw+xh6Zn6KTsM4A
         kOmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrIe0nBzkx8dLZkRe1jdxq2o/TN6OHgG/At+g4r8zdipizVuo5HTURj0akn/TKIkAXMBm7wVbkm/jHDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwsGdR/LJC5SMz0zHBkmn/ApEl+7rTM6Vzm2Dp6tn679I2Ecy
	sk5GHBiuY3ycggPzYsAALOltr3ZmAxRsv2OvgjBkjaRZTtkoK7/O5oZkTfQV0g3/s9MBhmnNhCk
	3rQuVTIZ4bN13PLlqPKT5HoQiB6AIAfSkURJoLQ==
X-Gm-Gg: AR+sD11cuchYcoP5/vrHRjm6N77HNPVv6CczRGzYyIn3oVsnPXqkJZshWIyO55QI559
	C7Pqvt+7N/Y5JWyo9n736ZUIxo9ocE0hkgyDVI6SHXdV1XY18Jby8Pw9nBXL1tmtiTGy5Y+QoIh
	2WcI6xptZs0hLahBGF3SvKcnAFOQfeSx1trizvH+SzDPysvxJ3nVGL5/UL+v2E6xrO38ePTr2Bc
	OjjOu7jYDJ0tW9tD2LWP7Dj+GNXlGZiapcI207POU2VvoQiTuCoPPh9w1jEkVOzS/r0bsu3/NbG
	h9yE4+0sU7450wHaxs9IeCmf6m2mUzwQR4lQZ3r/9TR8tAScswBUNkJ8GbRQzlkXJbMZaIMBOW1
	ud6Nn77Y+MnM+inY=
X-Received: by 2002:a17:907:724d:b0:c16:8931:245c with SMTP id
 a640c23a62f3a-c20e61cac5fmr120251466b.21.1786446489149; Tue, 11 Aug 2026
 04:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810144603.453283-1-hch@lst.de>
In-Reply-To: <20260810144603.453283-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 11 Aug 2026 16:37:32 +0530
X-Gm-Features: AUfX_myHmGbFEXKp6M95JNFkw23HSXySkJbqoCUR9q271Ff28QlL8Dk4otBiLYA
Message-ID: <CACzX3Aty5Q16MFGHXBCiVAZKJ8rJ+1PrC6uJ7ojMckwdZeb+Ug@mail.gmail.com>
Subject: Re: [PATCH] block: don't include blk-integrity.h in bdev.c
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
