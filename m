Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428B39ACC
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342057; cv=none; b=YQU8/2UpkegH54cfYD3rfirwpFbHks5TCvpy5YFno3QfUukJgIPvbXHkQsN/phx2SPwXOlFXJOsBUteKNNSWDD2CdJVkl/H6uynJo5zyIFrYpCTG67UXBTxBaH3BDFN23dOytup/SZJ4lf4jiMkxskgakH9GoM/6wwpolu3F/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342057; c=relaxed/simple;
	bh=Gr80+VG7J/BXlMJjw8FPIb7lsgXVutSgJO+NHKLGMP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VMtsRzPh/y+7ORUKMUg+5VgRt9caq/ZbhRPq5IGs6S43oWopmhIue8bmLW+Sag4XjYJ6odsIBhVfk5e1NBTETOr057Lcf65GyXGpGF/9sJ6RHVZ8NBHTJj82eQDbwETWUZiI+zp7axWT41VFL14dTMrqB9kMorJLaY0rqJmLbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oSt/OytT; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oSt/OytT"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-290ff24354dso2044302fac.0
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731342055; x=1731946855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8E0oe1Bn/VItUcYMvLcUh14F0RpsrF/kYUOTvmjo10=;
        b=oSt/OytTtzcZydIFmrRN2AqCUJ21BeXV0dKlzpeFZUpvR9RQzEJkXIad50i9ftuqjP
         DanXX9NV+kiSlixfbSdcJt/09NtxI/RK2zn71wPKfWxr0AL2OhhVnQ1mqbjcEIc86hwI
         T3Md4wwXjmjpbXylDe1PI5tB+xj65B2v6F15nt5TY3CAisTsY2KPATvZNani6fjX413x
         QIK8+4EtYBX+GSXv+/akznZKNIHvgJ/lI/lIgE21xhn2sEs6WjGTCWTlTDpePfR78eUB
         +ALUSc+puBhcAgpbPzPt51FfbDLaN+N+LHb5wW/8vpKXuDaUBeixY2xwJns5Qv/j6RWZ
         zh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342055; x=1731946855;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8E0oe1Bn/VItUcYMvLcUh14F0RpsrF/kYUOTvmjo10=;
        b=vofLL+gPm6gwlv4uSqTp9wzW9RW/gSkf5iTqK0mGjAgboz7DT7hs3h18RjRQqNHmz0
         InSLhn3lnLdSQ60/GGrGQm60aYkiYDWRMEABTCjAu6dvqYWA1YCWSvhSEc2w5trBxuj/
         /vZNSitoSjx0o4TjVHUT/pXotM51//6oI36yp7Y9iH6xfhIjjvaFjR6kijS78sQI8Aa3
         Yi9+68d7fj5zMFPGFdSMA29rFkU6R48vNJgam7Pz6p+HcYtSK06PUJR4rlxt0dyAILBU
         OpZ+bNTQIunF4U67j1WECjIWOlXCU6Hz75kbgotZsIZ2rP3lRXK9nlfsPzBR1TKWwyZY
         Dmsg==
X-Forwarded-Encrypted: i=1; AJvYcCXFPc6oBA7oC7n1cJ0ZDk7fONjRloD3eGsAtL0m4hITAspK5Ch2VUHKhOKzpgfX7nzYI+6BQmfZWDEqmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgzEnWS6hisc7vPbdvCAcrjSBo+J2rFBEw4GLCDAK8Yx1z4TN
	HHXlZ+lN4u0r+ABTyy892qUx9RENt2gf3YOB6HvtBGcWo1Pj+AE8E+bKLAk2Uv/DTLDNmGmfHZM
	1P04=
X-Google-Smtp-Source: AGHT+IEqbL/XLujJeiHX0bUsKtZMEDX13bH7NGSuhQ5qyhhQ/3gVPpJHqC0jtcydmzbbJoZZ0nz+uQ==
X-Received: by 2002:a05:6870:209:b0:26c:5312:a13b with SMTP id 586e51a60fabf-295603611e8mr11017504fac.30.1731342054703;
        Mon, 11 Nov 2024 08:20:54 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c3d9cdsm2893893fac.1.2024.11.11.08.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:20:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20241108154657.845768-1-hch@lst.de>
References: <20241108154657.845768-1-hch@lst.de>
Subject: Re: pre-calculate max_zone_append_sectors v2
Message-Id: <173134205389.1888032.3263693227897431533.b4-ty@kernel.dk>
Date: Mon, 11 Nov 2024 09:20:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 08 Nov 2024 16:46:50 +0100, Christoph Hellwig wrote:
> this series makes max_zone_append behave like the other queue limits in
> that the final value to be used for splitting is pre-calculated.
> 
> Changes since v1:
>  - fold in the previously posted fixup patch
>  - add the nvme cleanup patch
> 
> [...]

Applied, thanks!

[1/2] block: pre-calculate max_zone_append_sectors
      commit: 559218d43ec9dde3d2847c7aa127e88d6ab1c9ed
[2/2] nvme-multipath: don't bother clearing max_hw_zone_append_sectors
      commit: 0b4ace9da58df62c1763635ab10ae1bc8ed8182a

Best regards,
-- 
Jens Axboe



