Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE883DE449
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941730; cv=none; b=WRwPvVQNgyp4LHBokFHHucTE88E5q5ku7uTTSfcvlp3x5+2oIJGh4n1AqpldC1w1MmVl7K+vb5GzqiUWWuzXxBYD/E5QDXOAr8wb2dZm68rd3NReOlhBSTkGNRNBPAVsJ7Pi1k+a+DmUecKT3nnsslfh+pKBXPw6nDaMzMUBKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941730; c=relaxed/simple;
	bh=pvJy4XoPA08OgYgyJv3+TZY8tAzaddSqYrTzmZYcFyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rBJrbSq/iLS8+Vf8zPC7qoKyxSm1fk33zkNcLYgsQfmtsBOWpzvpU7LPvNXoAWtwwUW27ZUn/ceus8LzrJE/iDrIgs9ohHkgXziUvAi2x/wJua+8NKhgg56WvoOLzjOt537wMUEsxdqGUyUD9t59VV52UCGaqgV25VvT20s9gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=uK85VbPT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="uK85VbPT"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcd9061b1aso2483181a34.2
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776941727; x=1777546527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYtgUUohrG04y637tNioUplal/P2BJhv32a2stXTadc=;
        b=uK85VbPTR0P7EfMVUHg/UnmO5w+8zocmcKguc0w9RDe7xyeK8Ft0UjZlFDIaPBMspa
         5c3xG6JRS30sutpkjbztD/2RHUHvKaRgvlX/SQ8I+bG7xf+LUHn1Ezmk1RBg72GZKu9n
         ue37M+yBB/WQgdYRbUa6exIAAGVK3819k107FK5jsxwN3vOfPCMEMKScUNwGaBtmP9Y4
         JMO6l2mHuJ/W5UVW98rfPDlExJSvUHyDaRUqGVQWAp+5rKbSNO65PGgqo+H6JneLpKuv
         7Hr/glZ5iNeFP7yVxZGG7xqEpoFtiguUrB7AUSEeamrdLOdZUFAWcqFbVjcJDdnQ8Ykr
         tMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941727; x=1777546527;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYtgUUohrG04y637tNioUplal/P2BJhv32a2stXTadc=;
        b=d6lA6O3kqnPwCkC7vJH4aFEIgk5RWiJnE9/ajWbx9u6KgGjL71t5ibqOQWS5GCOwzz
         wT6TTyoXHa0hpRbsX/LgJWUFHJWgAv4Y8W6p+59IHLDWSd/zDWaMJCYIzlgQJ+tunoQR
         E0qozctZGIw3RKqpFEtcuRP24R+4GyPOcFt6t6zM1AModrzE7WERa9LyCCWT23Son6kN
         S31Z4f6/IZqzvdEURLLr2mibAFyme2tE2uaXh6UHJjHqoxxFDIukOzG9PWpgEydEaprs
         gyN859FjLh+WnnOrw8yjMeWLI7eOHfUJqXJncJZw7xNC4itc2hrfOgwvhclafvmm920A
         BChA==
X-Gm-Message-State: AOJu0YzFQJA9djH/+OICz6u6aVIFJK5aIKC5CNRuySAV1RbGi1Vk33UR
	l7HMNc/HtLcVtjG2jOF7UqBTcohUDLhzG2/w5aPQaa/UxB6atSP+cm4yELVhHMhMbZQ=
X-Gm-Gg: AeBDiesugdLB915evvzEBwOM7M+ZXLqu/2ynoR8hhlKJtE/Cpoud1RbFTdG/BBvcDnr
	v2DIk5fzu9Swike29gYSj4OZ2R6QJteyjyeNFgeB9361Aq860m1+IW32KO9mJQQZOA7M8QHIb8+
	TzwTLISB9XEM36xu78CLmAwur6j3qCWOlQgqDpEKzENbcAfKExjahh0SV36ef5NzBQCp1wRq0zW
	uu4j1C4sj7Jys2GgRR8PEws74ClYWhoPNF0l0YO0V08gnMPVzrLEsCqoLdkK4wO9jj8XEyySIot
	hIolFddoPDXVzXt7vFD5Cr4lPZnh3e+O9RAPsduh3e3dccepoU0z9rmqZ0AlqQA/BMkpKOijEks
	NGh6NA3224b90uKXNOP4RpuKJON2g834DOGNtQ/W/8iA8yhsBqS9fL12Gq6BbZk81kspV+A1Mlv
	+P/Eda000b6somgEApqCaxi8e390I3TUGjzbrJ875YXvNuqH1Qdc+WQjBAl0uBc8HQ8IJuEhbLB
	u7CwIh7ns+m7NM=
X-Received: by 2002:a05:6830:911:b0:7d7:e3b9:58d6 with SMTP id 46e09a7af769-7dc9523a18dmr17849757a34.22.1776941727605;
        Thu, 23 Apr 2026 03:55:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdbef352bsm6106065a34.10.2026.04.23.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:55:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 "Liam R . Howlett" <liam.howlett@oracle.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260423033058.2805135-1-tom.leiming@gmail.com>
References: <20260423033058.2805135-1-tom.leiming@gmail.com>
Subject: Re: [PATCH 0/3] ublk: fix maple tree lockdep warning and cleanup
Message-Id: <177694172652.1095312.8652905229824633846.b4-ty@b4>
Date: Thu, 23 Apr 2026 04:55:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 23 Apr 2026 11:30:55 +0800, Ming Lei wrote:
> Fix the lockdep warning reported by Jens when running ublk selftests
> with CONFIG_PROVE_RCU=y:
> 
>   lib/maple_tree.c:759 suspicious rcu_dereference_check() usage!
> 
> ublk_buf_cleanup() was iterating the maple tree without holding
> mas_lock, triggering the splat from mas_find()'s internal
> rcu_dereference_check().
> 
> [...]

Applied, thanks!

[1/3] ublk: fix maple tree lockdep warning in ublk_buf_cleanup
      (no commit info)
[2/3] ublk: refactor common helper ublk_shmem_remove_ranges()
      (no commit info)
[3/3] ublk: avoid unpinning pages under maple tree spinlock
      (no commit info)

Best regards,
-- 
Jens Axboe



