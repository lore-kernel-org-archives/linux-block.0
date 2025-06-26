Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A922E6133
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944838; cv=none; b=Efu1FHoRbIjajpLuwsN7O+i6tT49SA2tiZg0FA1EkYss6CoM9JubduGkXN65d4OXr7OGHxA88cMwLJFuwhTDxEFssA8g20tJudWPC7KTafKSLNTCs6JI30ik6yZ3WkFgxym22JwlRT9gfwpzopdnz/p74jyTQxHHQ2uwpxZXgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944838; c=relaxed/simple;
	bh=PN7pFyp1br0SfNu6SAtLQZUwe3ne1FMTQlinDRXq0wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzl2BIi5aIi2+EAGUkQNBXClaGy+Zvws0BA2fXIcrgqldspwgcQQCwyAXusnLGbNaItn3Cl0jdGtjfC306iUVJm/ZmFnxErZ0F4MhtVI7tULNW+QrvXDKoWtQkdS9zsMX5kQQFC+tpiKW57PTh9a7UKmj9kyIA/sPFqgjLJlmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qtLQNlYh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qtLQNlYh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9e87f78so13414695ad.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750944832; x=1751549632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC0OiGu+HpG53VjMVvJGK6xBtdg+U1oBtGISu/VLg+M=;
        b=qtLQNlYhGfYP5XYJ/1FBzqFv1TV56CZT795IkT1BL1Rhx+0l/Fk3NhekJr1tL6+aAo
         qF1VCBV1IElwwDPPUOO5mIK4bYmTsFacjmLOfjSYxfnSCiTUhCX6MLktYi0qB7KBBJiS
         18hH1vicx6i4pKbsrDEL86DRqdY+AAMZPw9Lu2x260FQKDM2JNy8Keu9I7WzAGthR6uJ
         2rB5kvb6ZRBQBUmpdndZupgoYfVn8Z11k9NK/WI7E0kqKX4wK5UO1M7DWaa4bxxaW6q8
         +SpELqkpvkK0w5pW41a/hgTYMC0dIpqhGBHu0McSg02QGvvot5imLrvs8h18s7YFWFWp
         95ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944832; x=1751549632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC0OiGu+HpG53VjMVvJGK6xBtdg+U1oBtGISu/VLg+M=;
        b=vqdppirnpYR4NiPeunzd2BhtDOphKKTInSCk7D3sMk4TFOjWIAoIPwblNvEKQaEPV5
         O+QNnedMm3NiVVDcbBVSp3iGR9GzE3a6D5nLZx/PqMeVKhSat4HaCeDnhE3KDr5yfefD
         Kuq8EScxmu75PVzro5IuO8A7bc39oTuCQxvDf88iTm5PWpPCG5Bwo6sHAUn7mrpSPvru
         ybcJK+ir/jUOz1s0VfY6NwdrZayxltQNZ/jEL6Jfs3NX6dBEXdN8DF4DP/ipXyfUfre2
         zpVDIW2OuVhteA+DvRrbjQ/19MvzP7sOJ3sKXl8ebnrEQ7jTF/ZUdT4h2rNe+N+tVHzy
         BWcw==
X-Gm-Message-State: AOJu0YwBmYlQ0sZbOzdHjYgK0feI8lUkizeLXHnsQiOR9xJnpm9IK86m
	bqOyS8NMLb4A5gatpXZbE3rpRaWnoXziMQyDSSMYM9AOFNO2kLhGUKyZ1B7bPziP1k0=
X-Gm-Gg: ASbGncuHUDlEtCTaurKpiB4mcExYJZHdJPtMMuM5VQb5wayElvKHNTtOKFq+QkcVG7D
	vREHwt8X/sB6mRJDwi8nsiXXwnrJpqDMhSP4I7QlO37Ek9JxQHRzHFaZTFlhWM25oVbXTF7a0T6
	eLAjDVsFfbLgPM9fnWj3GXRJ2AmPfcRnK7M5aCBkMBNjuTBZnN5x9vvm9ynxx+pJscez9I3UDRk
	FluBFi3TmcYp5cPBp3KpNzp9N3xEhQ8iYepUMeuifm4D26JXElPN2wiHkZ169tFFZt/3IPwWCA3
	LRIQkg3fKp6Rfne1aOyaPowmGvchVbbtvjFQ7bkvt216SGbZPYpwEbIFSw==
X-Google-Smtp-Source: AGHT+IFT9J6+igjlnsWk9/MBbtfEL/lvJB6RyoRwy5Ug8IZaAgpB13e+C+AhPihBSlpF/uw8wW13Ww==
X-Received: by 2002:a17:902:ccc3:b0:234:8ec1:4aec with SMTP id d9443c01a7336-23823f920a2mr81921445ad.6.1750944831975;
        Thu, 26 Jun 2025 06:33:51 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d873845esm167705555ad.243.2025.06.26.06.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:33:51 -0700 (PDT)
Message-ID: <3a148e8b-86a1-415d-b05f-237d40596d0d@kernel.dk>
Date: Thu, 26 Jun 2025 07:33:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL, resend] nvme updates for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aF1H_345SuVYxoCW@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aF1H_345SuVYxoCW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 7:15 AM, Christoph Hellwig wrote:
> [note that the commit dates are very recent.  That is because somehow the
> tree the ran through the build bot had me as the author for the commit
> from Keith, so I did a metadata only rebase just now to fix that]
> 
> The following changes since commit 4c8a951787ffc4b61a547db9866196104971b5fd:
> 
>   ublk: setup ublk_io correctly in case of ublk_get_data() failure (2025-06-24 20:45:31 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-26
> 
> for you to fetch changes up to f46d273449ba65afd53f3dd8fe0182c9df877e08:
> 
>   nvme: fix atomic write size validation (2025-06-26 13:04:37 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.16
> 
>  - reset delayed remove_work after reconnect (Keith Busch)
>  - fix atomic write size validation (Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe

