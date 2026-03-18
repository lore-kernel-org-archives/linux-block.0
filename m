Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623B19CC28
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797578; cv=none; b=iBVJzpz1ZkMqWCMmmnscu5PBbqOXkiOvqR1M+qTeoETyQp6n/ymw0Q5JPdOHrscYQQIUNAcwDhhNdZiniTq0tcZ2blV5sGsMNkzXuhXCII6uwje1PwK0zMbGdokHWl8FayTjzoKRCoYv8knom4BEV+NUjTgMz1qGezub0hyu8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797578; c=relaxed/simple;
	bh=GRstfBVXNlbiYAxkAU3SHSfOiFMDR6YnMSauQ2q6p+U=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XjMtjhQG1jIz90ahUeesMFc0uiiwFfnpHQ+h6uT8ivphpg+BUTQ8pshpQnsw474zfy7ui7D4kwYA03PzcGSiuvVbKhnS1BBtWNgSuWY8MUMD9X0uRjgf4xi8rr26Sm+hc+m2VOE7N6CjIpJBz0OkHsnoQgzXcrEP132lmTIcPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bPgpq7S8; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bPgpq7S8"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bb5e4d06eso2220722eaf.1
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 18:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773797576; x=1774402376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLfhLlYzRdtJlSsGGbMPLpW3sMVv8KiDOySz/m154e8=;
        b=bPgpq7S8OX6ruhD9/Poy0Ac5fuL52BD8oidqgl5OTrOo48Gu+gfrabpg4ViBnH0TjK
         BK1DPrAv6mCcrdv+3K/VnrqasDyUwAVNqvXvyW2wOnUAPHyEnAQakMSiB6gm7y2hbG8n
         EdCLNkbtKsKORt6N8SpAxruDSk2f4seFgZgWDfv/3MD5hpZ/or6fWeGK/mvTnrtMj5a9
         uezAR+lzxfUbvv3y2TxY1WHE7L+9GJe5S8Eg+Qw8mYoSK6JLhCpL7atRi1hhYDt279q+
         WHjihurxJxJ1PFKHCzlLctBbBqkzZEByjLXI4CefT3CROCCUhtEZPqslAtc6qZhYserE
         /ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797576; x=1774402376;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLfhLlYzRdtJlSsGGbMPLpW3sMVv8KiDOySz/m154e8=;
        b=eXLkp7WY0ln9xKYBedHjxWvO9QGP3c4uTIU7erVOs0ycizf4o9UtMe0UXcknPg35zf
         OxAXcRbDHm6Fif8T01GKwuhnH/2iV2Nlk6ymvHp/MhOiyuY+hfq/kgcXfur74vZ4p9t1
         RGMKNrADhH0fJ3KNIX4Lx4Aatv9K3suFPncM6ioNbhUFPj+eMTdpHYVglqDs6gWVun4Y
         4k+ipIlRNtLjDX98B48oalyLzdwn7taXV92f+vZsQdHX3VFfU5WemkdvzLQtBpMFtqvo
         9BbqscgH3gpDM6KVLSq5tzkOAUDTWCvVijQ9/O/Z2RmcyU7HzqZxvWsGdIBm6oog9STY
         rz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJCBVxPYuJwg0MhYRvLZ8mEzjYu5q6Q3gjwTbBcnazJaKVB0xRnXH+ZiV6oPiEg0+JYAR3gT8jnA3WYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71TYk5SIYtJ7U+Iy7AJky6onoA2TmjiMqp7+Fw1k7L46u+NEm
	ffNCB3JQjiwIjKu/bxygiD8Xq+xQGe//xZ4d54yxE2/OWn5uO4BS9+lKSY/j3sfGGh7ZbkyGHE7
	a1StkQug=
X-Gm-Gg: ATEYQzxe+kjV5GU19jFBFczA5SzW/RfY7zsuuqSonFDXwNjeqmaEhp2S46UtY4ySf2A
	L2AbFzbk3QzxJmWYU7e8GKGyj+6mRvkNRTRtZt4A1y+1bJpjuA6k6xMHXqh4b0pTGhqhg8PBhBn
	Lbv/t7auzjCE9X8y5ehlutaAgE/2C0iKPfBV26Bgo9dlv5dRPK50iGYGcgQrV+tlJFyUBOWPRH8
	cYiB3yl2yiM2Y3HQTrWO+nq3lc6ueLLkzW6A/6j/OzP73H0l7hu6L7lfS9com32TQVrvEKgAWIT
	7Uij8lrur3sRjq4O5XIEZYscNP39116DXWayBesd0aQ1WCYBDDd2yS2rxpp/Sx2ZSjDLJabiTa9
	6KMogsZifK/OppaGrg8Hd1lT5oaTmQ9whNt8wtljGEJxDYsVxVUfBVsBCYtkwSrl8h4crpY1aYV
	62/BYpAl3dxT1AgoB5R8MwMWTaKGwVpFrkEmw8DqLX5ZXDzFGjAUAuqtmEzr+MuEPHXSZHBqox8
	M+5+GmozXk/a2k=
X-Received: by 2002:a05:6820:2d43:b0:67b:ba75:3eaa with SMTP id 006d021491bc7-67c0da9512emr992362eaf.11.1773797576434;
        Tue, 17 Mar 2026 18:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd288d791sm1441221fac.7.2026.03.17.18.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:32:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
 Qu Wenruo <wqu@suse.com>
In-Reply-To: <bc2223c080f38d0b63f968f605c918181c840f40.1773734749.git.wqu@suse.com>
References: <bc2223c080f38d0b63f968f605c918181c840f40.1773734749.git.wqu@suse.com>
Subject: Re: [PATCH v2] block: reject zero length in bio_add_page()
Message-Id: <177379757513.1036731.13768359483777366854.b4-ty@kernel.dk>
Date: Tue, 17 Mar 2026 19:32:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 17 Mar 2026 18:36:34 +1030, Qu Wenruo wrote:
> The function bio_add_page() returns the number of bytes added to the
> bio, and if that failed it should return 0.
> 
> However there is a special quirk, if a caller is passing a page with
> length 0, that function will always return 0 but with different results:
> 
> - The page is added to the bio
>   If there is enough bvec slot or the folio can be merged with the last
>   bvec.
> 
> [...]

Applied, thanks!

[1/1] block: reject zero length in bio_add_page()
      commit: 643893647cac7317bafca4040dd0cfb815b510d4

Best regards,
-- 
Jens Axboe



