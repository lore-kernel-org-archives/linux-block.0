Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A73AEF5F
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274342; cv=none; b=n/V4G1UmuGtsfMFRvcwY4KU5NKqw2VkF4I3qZwYA8fkmV8S72caG11rqzUPvK6BeNSAKdYtZdvTFqIm4LwW8TkNwAyA72Ki/nX90Tqy8GQ9RsOA1SjYC7Jl6F23gmkJHL1iLUVJm2P8yZ1Iss3Ku6cj4YRkfyNa2XG6PoLGRwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274342; c=relaxed/simple;
	bh=rSFFQwAlcJFSejGg0S1xj7/aZ9GazUUwXz3HrS6KQRI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ph7hKkLGMBnPp5jLOhqj0bHJ6Iauv/ggEUTxrYi/nNG+MQUkMemAO64MRiN/IXq1b++Q81JAHkwGJrzHgFCNbigXBe3cPGsawoNBMTwfWvk9UwB9oJgXdXgleJsz+2+3iZAp8QzUedas4b/hOmVvFnNVIFVKaVf2TYdd9IxNx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x8LARbD/; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x8LARbD/"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4670bcc40d7so1318589b6e.2
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774274339; x=1774879139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SiMLqfAQ771SuuVb3rxYiyzSC6xGBdAgUWTLNVjX14=;
        b=x8LARbD/uLpd735iB7+GKPQXU2Jg/wWsYUowZqZ9W0oX75FpvDVAOAD3+R/VLKYBfh
         QP/s3q0/b3DMWrFnT9G37ZbEivaevF4rzJPjhr8hpxzxBTKMmUQB9RUeSnO7AsleO9Fp
         ENVwyZiTbx2pKMP0xZrHhOdegLT6bChkMJXOJ9MryFWwRS9ijF7PmpVc0mPqcrqk1N/i
         EF5WIre+HZ3M0fTk4xClIqzm3XcGM5NHYGcjjmt/D6WxTq3bO8sTNsBydNPZP9Wmo+Z+
         koRHeE56kOLRMb56A25LtaqsKIQxP3YA9CHupEuqh6sJ7Kp6GSVG7zP4rUgqzqAu8T2Q
         WYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274339; x=1774879139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0SiMLqfAQ771SuuVb3rxYiyzSC6xGBdAgUWTLNVjX14=;
        b=Ar6fuIb2ZNh4DHR2jK6qsewPCeLfzZVbwaXXMH6wzAXD2O93w/+9NVQ6YyUuuBvXvq
         kTaV9/PIvCdlih0+5qLcZKSFC/TVc3fiMGDeMIzfiAjTqfk0+i8k7OWrpbUQlGC8AWbH
         OKpAQWfYRPlySPPI64YymtPw2QPG1iknZJ5B8T4mMKi2dHrcsqC4rcFDH7VqlX2Uh6tz
         mq7q+XDBwl8eXJOBYbR+aK5UYHCAc9DVRIgjzRw/1wFcrzMDMIPYkelQUcWIXg3f+bo8
         5XWI4yrY1Lav4n2F3GqpFtneo6Yr2BlyIxcGsi2atLQmdx9KVYJ7CMuRqoIJRFfxClwg
         kEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVtQgZZ0IgI1PH+trW5uq7zLXhqY2LqwIxVPT7HSMP7QJWY2vlxcoUm49HhhKa5X7jaLhcr9hqlBoq6Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++K++Ua7fOsBbrZTXI8P+25t8dVfxKt6p8UCoPvqr92v0uUv6
	R/nyIYBSy9kyW8aeGHHYpATL0QPRFhBfM4E3L9sUG2V4N7l5VPtAHPxKVsD86l7J0GnJ8mh+Zvj
	YnXX05Rk=
X-Gm-Gg: ATEYQzxpJ8S3lA9uCXSQL4fh7jWNQeFIANQOIUMyvTrFBVw2bzvONlWiRs+1IkV5Jbd
	yTi0X/HGrTt1fG69t0D8BEb0FpMpAbcVdYsRJpK83DkWwa0x/jbqGzyi2sQxdGwPYc0m7Y5Xws5
	sWaEfSg4yGFgvxP47W89Ofrh8KLxHEkZWb2kk6xHOjNbbVjfAqTY6YWe0sj8XQ1HpMM1SMdRP7d
	ZVK+c+kVMqsH+OdEOcx7YnzCy1YL6Kpf8zNUdPSqbPieksGexXD2mXl+1HyIwfIPCryUVUT8kvd
	AyuhEwooKnRNZaBYKMRWS6qnN5B/1NEISkZmvSPknfmGTyZHQZ2MvIn8/7Ueu+sGv3PBbLT6ZJX
	MZXz0RpRH5cUbS4+vVT6qoR07Ra2Alvuo5AeI3ibKnklHR38R78olkyf83lqdKyqSjsDSv2kGJ6
	uJU+1xF2fcV9fVG1vBKEkTlDcq0a/xoLC3y9c65AqXjGMslNp/9c57xejyH+S18Zq5oqNExlwdL
	N0p9OAX0AmV9OE=
X-Received: by 2002:a05:6808:4cf:b0:467:3f4:907b with SMTP id 5614622812f47-467e5d427aamr5628729b6e.7.1774274339320;
        Mon, 23 Mar 2026 06:58:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d19abfsm6791883b6e.2.2026.03.23.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:58:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
In-Reply-To: <p01.gc6e9ad5845ad.ttca29g@ub.hpns>
References: <p01.gc6e9ad5845ad.ttca29g@ub.hpns>
Subject: Re: [PATCH] block: fix bio_alloc_bioset slowpath GFP handling
Message-Id: <177427433809.393949.8310090043584070057.b4-ty@b4>
Date: Mon, 23 Mar 2026 07:58:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0


On Sun, 22 Mar 2026 03:35:10 +0100, Vasily Gorbik wrote:
> bio_alloc_bioset() first strips __GFP_DIRECT_RECLAIM from the optimistic
> fast allocation attempt with try_alloc_gfp(). If that fast path fails,
> the slowpath checks saved_gfp to decide whether blocking allocation is
> allowed, but then still calls mempool_alloc() with the stripped gfp mask.
> That can lead to a NULL bio pointer being passed into bio_init().
> 
> Fix the slowpath by using saved_gfp for the bio and bvec mempool
> allocations.
> 
> [...]

Applied, thanks!

[1/1] block: fix bio_alloc_bioset slowpath GFP handling
      commit: 67807fbaf12719fca46a622d759484652b79c7c3

Best regards,
-- 
Jens Axboe



