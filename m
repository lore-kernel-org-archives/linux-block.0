Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4F17BA6
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390236; cv=none; b=KT354WlxxAniTT+/kbaTpgzbvLJ6W1o6WsJPfV3++/9jEzU+dxnW+5ArS3wnmaNC32S5Joea+LkzB6iyaHhfmrLO3LaaEPDQBrlEzEYl/0/laZYWRymBiEkFojpOW7AzDN2KpZB70Lj2FJhtCglgmZJUx9gXSONnuAbmFDBAGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390236; c=relaxed/simple;
	bh=D47VypazdbU4fqhF0bTU3OX18kv0Xc7Ljtwoo1I84YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I3/O7SAGWcdqzkIrCrPNVpr5dp9m0M+NVfDr/MyOfD6Zet+JvRa/xmUaRnaoBaPuecjPlyNa+bbDVbF9fbtlcRkevIq09AlHy6+vDj+KG7hTO6dXBdMUFzQ3RKbEzLgKheI2VvfC3CjS1r2jS3tWGwLW1pmvB5PIULYzaDBfq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vc9hBrap; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vc9hBrap"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so77909175ab.0
        for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742390233; x=1742995033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSHoB0s0coctjvbY3kKqqVrIVzw0mCbNKlZ4oqh6wdQ=;
        b=vc9hBrapUr301yEj8tJtS6ATIpG1HYkmkomLax3Ku3o+guzXrme2DoDnXadEIgukda
         FyCvoNsqDoQhK/N8XIyCkenUhw1AG4noqFPEEzV80Ick0OYljw2Ou/LM68L+nYFiDa4B
         7sts+3oSc5slhEy57I0kwvIri7NevgTIBNZq+rF9HWQMmOSdVZsKHr6NDlyFioBcAtk5
         e1le0+m7DjaVu+RZ6wNcs6rDI42Inim6IOgZr+8H4eOADOdlRiDgpXWd3Gxrjc6bIGQb
         IbFqygV2fUNMGJYw/HALBjkRkW2oK3GPbDYKRS2bn+xDYvpcruJGJG/CGyruu327yIXy
         117Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390233; x=1742995033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSHoB0s0coctjvbY3kKqqVrIVzw0mCbNKlZ4oqh6wdQ=;
        b=urhEUW2JYMAy7+e4IdG3nq3TiAAI1XiIvctnz1MlR6WFWN0SYYS4SJ6V8HFoQn5y+P
         +7OU59702zuaYvwd5Iy9y5tJRQpIn3GshzFLSoquFzPU/UDHLh+zhaP6YvJI3rSRsL1T
         S6fo+P1BrLZCfyYnTXxhGVhuj0pI7veBgNVP6dPaA6zWNXfhRkroS9+xuj/XuMoQjclm
         eSTRLmxVArbMUxGeoqpVr7bIw86ZIMmBtEvY2Ve4X2NMi5qlyfkBxE5olnVB/BU/aEN0
         UTyxMt+nVyMtjrWCcWqoF48webnrA5dja35mbkziQGHtyim+FixjGsKWQfK+7f8KGbE2
         jQsA==
X-Forwarded-Encrypted: i=1; AJvYcCXThcbizS33VdsDsNEtOb3AuIybWyyZSixv83rFGxyGfBd++bSW8td/E+96lcInNT74WcAxby/PyHC+eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ot46O77vPFSJEDgIqWnbBwe6BVSj0ePjFiY5uyR74Q/jlcm0
	6hbXdYEtMMonnIRoV0UZ+O8PWRwkTUaVkistA9DHZgfRv6eBSfnuuWoTOHwW/6hmH0EKFiyfECt
	i
X-Gm-Gg: ASbGncvSuqfNjXHoTFoCY3gg3EmQLDPeFSZLZU8oW5xCFmPmG+jd7EabqNQmab5srfs
	G8bI093M966dJHjfC0VyZxl6IHGZpXi96xL7GzMgz14u/VFS3mFY1oqBkjVtkKyKMLzNts2i1ph
	0XZrpgX7VbURhegbwA1cZ06T2TKkaOG/lF7zxpwRWcoZdopAbf35p5DQpSopaNv59My3v4uMjDa
	tmM5XqE1HukDsel8boOf/t4vE7phpzVy8W0JLx30AsV26AuGz9BAvfNxUGTnroc7LArQ44qt3ZC
	pCGKVLR5x8aDVdnCNFyUJsX2G/RGq856nPZRhP89
X-Google-Smtp-Source: AGHT+IEXpD47cRg6Bku6LXrgHWdfyHM2OHeGwIiM+rS5wNtVz0eHSBfmYPQUcjCZ1Dfr00bKDqC30Q==
X-Received: by 2002:a05:6e02:2788:b0:3d3:e41b:936f with SMTP id e9e14a558f8ab-3d586b1b1c7mr28926755ab.3.1742390232640;
        Wed, 19 Mar 2025 06:17:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6691d1sm38857155ab.27.2025.03.19.06.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 06:17:11 -0700 (PDT)
Message-ID: <8281b548-8801-42a7-973e-9d06a1ef3c35@kernel.dk>
Date: Wed, 19 Mar 2025 07:17:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't define __blk_mq_end_request() as inline
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20250319021343.3976476-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250319021343.3976476-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 8:13 PM, Ming Lei wrote:
> It doesn't make sense to define one global symbol as inline, also this
> way cause __blk_mq_end_request become not traceable.

It does for the local scope though, it'll force it inline for
blk_mq_end_request(), for example.

-- 
Jens Axboe

