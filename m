Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66E1E9B04
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834628; cv=none; b=cmIQx6yCBCzw+r3jqz/H4AjHFtXbb7xuXgxM8rYzfLi/dHLZA/vTrK+AQNGxy69YP7deh+aV3V/uvP7hjHvpM42Lzeo6n6jhc4B8fAP1mSyIdC3UBGhH4N0jRjzUvImftaLZh57lrtyGHASvBHoXucfWF3dH5t3A2YSQfIsKdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834628; c=relaxed/simple;
	bh=emIdjklLhXRPN9iCN99PJ8XS+KXF7eAa5OOPoHhNNxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FzdieS5UZDtN/ccdRXqxqwV44EgSsTDXXXduv0cb6f+7hAmP/ivdWPtNnBIIx4X98RFzU4wpxnB+dSveNdNg7+dNUpTPBJXOYfejOL7/SYk0000JX2lBxaZvovzprMbY17C8J3F5oZNuYWk4d57CquI4m8FsWeoCK5zeISvn/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h8sXR08h; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h8sXR08h"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso1115739f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744834624; x=1745439424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ1+azVlpagzxbvle48R1UawSO5mKpg582yin44wCyo=;
        b=h8sXR08hprvZ1AOiU19ulTHOkSF4x5qF0uG5kqDSPBvY53h3ckJpZlpA8jMJulB5Wj
         5TtABJZXxwlfiC4pS7hioWYFMbFg04pLiX5IaoanFywFQlYvERj9QKKHT0/ysg4JVqSu
         3jQOZk9lxg+ZQp7lRpVpMre6p6XY5ioGUurmVXDnb5dXLoaJUxRaHEtVW/50agi1zLDe
         Xfg3eHPSZDguRiYYaCvW72qTgku5WqLxyNvva+IZrtlB8bfuLkixX77+gbsbuQUxXKZm
         OfuNKet6ZL1I26ew0OQI7ObJQmui6GkUm3aENhmDOa3skvmdMfW2Jx179EZCgqR211rm
         LP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744834624; x=1745439424;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ1+azVlpagzxbvle48R1UawSO5mKpg582yin44wCyo=;
        b=GmaeOg6vIiRUWfR8uTWz0m8elR8ZLGc2KE0kh9hbXQvaWtd4NsuWsU1JolxFs2kvY+
         LmQHLya9JRxcsQeCRfzQCrRloYzsFXPMSmVOT0wQh/BzHLKB6lFCQhB9MvZR0/tPJ9dL
         Khvi2P4jgmNsJLCOy3JIz4kRGzBqClOGJ66j+mXyKxXvJsLJOAKl4OwjUVPTGI7/KThj
         JTAJJOX1YNZ7xnAfHOI4ntXD1Q98lamiPEOnz8cnit9Dem//q06Wf6kdiEjYq3zUZYzC
         VeHHKzYO4gVUIGdMLSmvJSlI8sPKaZuyklWv5/Ls8Mu+OgS5OzHM1qgcaQ5glIdmvJnH
         v+qw==
X-Gm-Message-State: AOJu0YwT/m3GaLphXLcfabfOsfZ1h7zm3lretoPXlRo7bOfJWn9cXReo
	kvJRdsA51sbLzzZNim0BXykgQ5sp4TIfgdq/r2bv8FMgpgPlk4+FdQAu4YK9kAY=
X-Gm-Gg: ASbGncvF9XnGIvP+X/Q0nBxsQylaP0DzOB6VE8mt4eYEML0B/LknSyTXaT+bqCDoMbA
	2r0tOj01nkLLIwmEIi2EisGs2sMF2hyfnF95Z/0v2lfiI8Hoy++oeQnLUDUrKyQ6YROflT2xP9u
	KbhLpremAAItMAmPEb8kM7cfeGEpsexOLS92X22eSmtKOQ794p5vIsGq4VTuEOxiEA77BDn0+yr
	BnqFdcFqc5FR9IE9s07nVNDviXzAW3iwJbLscIlT+ytuL7itebDNPRIZI5/YlfNv8lXNHYYrNHE
	qs8SZsAi3HsNuOkA7GJYEK5nP5Vdkec=
X-Google-Smtp-Source: AGHT+IEOaeIO9Gt/L015JgtSy0Yjh7ok9c3NQ5XSD07RYKDCvQLoKxvbv80EQgdKkcX4PpJfBmmPgA==
X-Received: by 2002:a05:6602:418e:b0:85b:435d:2fcd with SMTP id ca18e2360f4ac-861c50bb2a6mr367223939f.8.1744834624169;
        Wed, 16 Apr 2025 13:17:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d3b95csm3806584173.71.2025.04.16.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:17:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-Id: <174483462293.432978.6652209332572343720.b4-ty@kernel.dk>
Date: Wed, 16 Apr 2025 14:17:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 16 Apr 2025 16:04:10 -0400, Martin K. Petersen wrote:
> Placing multiple protection information buffers inside the same page
> can lead to oopses because set_page_dirty_lock() can't be called from
> interrupt context.
> 
> Since a protection information buffer is not backed by a file there is
> no point in setting its page dirty, there is nothing to synchronize.
> Drop the call to set_page_dirty_lock() and remove the last argument to
> bio_integrity_unpin_bvec().
> 
> [...]

Applied, thanks!

[1/1] block: integrity: Do not call set_page_dirty_lock()
      (no commit info)

Best regards,
-- 
Jens Axboe



