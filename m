Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B72D1F61
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477974; cv=none; b=KNGkdLUGxzwjiUkYHr8nqPA5QiZMTIuDYP6K86UazA9pAwr1V4hS7FuQZgoyj9+EtcL+oOwOHaOhevwA3nS+M2jig+9fV3RLXJY6SSg2pN0LNf7EgzrfPC040LAX/seOr9TTBAC0bHXz2951mSbDUKz6YAmzHkvUr0/BaCKfgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477974; c=relaxed/simple;
	bh=TXfPs8U5Pn1VLYMUtih6S9uM2WWcoOlBB5kquS12WRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MN3N/i2dRTUeBWhqHrM/Z5qgSvW988M0HD9hY1N7HqSddpYGx5RfOGQcipNFTRyPV7kuFhzOORIULQSAu3Bv+IAr6b7ikLxVUmV8qb1ytb5mJuxJr6CgKv8OW8wyI+h5vPbpunIPWeht487RTrOXkb+os5ySnjip6C+qhePiOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=On/9qxRh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="On/9qxRh"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed7024c8c5so1884411cf.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 17:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762477971; x=1763082771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWqJnsp4EvW5NsB0ZoZZ38wCK4yHD8qklQbwS0U9mKY=;
        b=On/9qxRhs2q4mkZ/I3oZxuzaHv2b+XAsCufrV9Sbb85Kv8Q7Y7ZSAOgYeALpBRLkQl
         p97qE/vW4mEwfENNX7q18DIm7vE3QL62OGBfe/IC0u1YyrZAhob+6IIpW9B3y/Ci2AW4
         VALKlLhXgoV0skAZUmK2ohv1r3leKFyxEy4Wk4mz1AC7urYZN5Srayj0X80AHkeMNwY9
         YESHTBQt932N5tNW3eSUBa88Jc0ZAVvzRrKejB3Axrji473qFtHH3ueSSnqaO4uO8jMT
         TzRAuvnIRef7gGR61MTWBEsm0PgMEZwpJHep6/TrQUiPtTkr+7pRTlHzVWQeI4TB/adW
         DXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477971; x=1763082771;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QWqJnsp4EvW5NsB0ZoZZ38wCK4yHD8qklQbwS0U9mKY=;
        b=Ota6txa1cT0xLxy4PlQpaRo2pXmvFhgJQL2AfTk49JQBPxJL+RMDBoNwNX8o+RAKgw
         730MxVUW2nI+mZ/dTjMBDooREowhyLS5Ttb4bEkOZdtj689M5Iw1lXiX1PIkp7anGs6n
         v2NcGMXjiqtn3WKIdpBkGk066GZO0d4vIWzuS/o0i7boHHkx6Pd++zYDSFJtzTnrYlw1
         rJu7hrUDnaqRfZHekkx14JnLduFcz6vXAw1OOBUBi4EXaN4GjO32EXZ7v8QGW3o4slpY
         eNOBsxOtvyPTmCgABS9wF1SSb9FzWAlrlKEx2XJjtDWgVZMiuXyIRlNUcxD56G/Gi1cw
         487w==
X-Forwarded-Encrypted: i=1; AJvYcCW/tE2XJWxQMgl8/Iln7gzHntkWIQ20cQF5Hetov1ngXFfdkRb4cYJLTV9sAI9VqTy6H58R1j6jTArEFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uwgRUjYje2lr39utDZMjghWpjG1gUFBqwgj7bKAdtLBRCx1B
	82cSAeCbSlR/nHupHHvii8KnhvAycw785On5mhLEMLYTzrpe8ZXLQQp3DsnRoGD7JE8=
X-Gm-Gg: ASbGncv+iaJAzJcuQdm/0EHhAvOl2yqKlTAt38VHZ+uyasOczBbEqMx+/e7TX1DAAdx
	91LWikwShECjqodMB6FGJJ49gEoA6QOskpBkqS9TzX1qtMOiAbs2mZYxiwSqn80IoiK3ZON+YbW
	R1PqUsbjUP2vhU1sqdlstd1JwILXhLIjmaHk0qZkMeKCcjNz8K0Ag+BSNWz1SmgDM953mSYx8GY
	wuId8U3k9LkMnNk3ykz6ybmekOyaM0kTATXq8dEGOqHufvI1lF0zrMj0EWBCQbIRg116k7ttMQ0
	b2rg6jV4iwnMT7E/S8JT+DNAC5W2Lyisye8n/0iYep7p7M5OZDa22sB/Vk9229v4SNIW6kMS5+Q
	3GzKtFbCqMAyYBvDywWTASzmbjm8ICPaVYT/InSn2ry/GSmGoNLlqYQ0tYkC5KoVQ7YB+TKo=
X-Google-Smtp-Source: AGHT+IGNXhFRusyfcqPZnRs/xowsTaaRiEB+Y3/HUpSQ552W130CtgBm5ZhdeFImdQj8FqUNsa7yqQ==
X-Received: by 2002:ac8:5704:0:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4ed94988f21mr16234581cf.37.1762477971052;
        Thu, 06 Nov 2025 17:12:51 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed813b79cesm27827041cf.23.2025.11.06.17.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:12:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
Message-Id: <176247796912.15650.4766342820181408947.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 18:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 14 Oct 2025 08:04:54 -0700, Keith Busch wrote:
> Previous version here:
> 
>   https://lore.kernel.org/linux-block/20251007175245.3898972-1-kbusch@meta.com/
> 
> The purpose is to allow optimization decisions to happen per IO, and
> flexibility to utilize unaligned buffers for hardware that supports it.
> 
> [...]

Applied, thanks!

[1/2] block: accumulate memory segment gaps per bio
      commit: 2f6b2565d43cdb5087cac23d530cca84aa3d897e
[2/2] nvme: remove virtual boundary for sgl capable devices
      commit: bc840b21a25a50f00e2b240329c09281506df387

Best regards,
-- 
Jens Axboe



