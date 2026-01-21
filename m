Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B424C77B9
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006886; cv=none; b=JjLJixg88UW1Ubg2dvesF2zBo2wIWur0CyaxFNx/qCryMdppreLLiTDxI6fbV8c+0TsxkBlYCNNhRbgnygu/GqCmqYHgDK//4EsBtW+bFfiIgc4x8fssU9tBGSbhCORTS/pJPLHfXB4m+9zzRhX/GTymiwyTFvikk1NTdqslUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006886; c=relaxed/simple;
	bh=ebMYlosgitqS1TbekxmBlDp0biRPUSqSkXMGl/HkukU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bdlkxSxTPRscK6Ygm0GtCnGqvYiaGrF30MJsAubLw6QS5zDXzAowpmbj5iQOX39CVIHK1/rm/nXsXaTRmZKb2QUkd9LYhQjjQb/GKw91/Dt0z0reamGYdH0Ms276ZzT7hcxXWZ3xxcnQ+BLuOjmZ3JQQ6GKbSf6KOY++CKVFm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q7jUbTm7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q7jUbTm7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45c7400259bso2475420b6e.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769006883; x=1769611683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLG7d0VkjGE3d64B0EnEsuq4Qe/nnfPrewItu9809qg=;
        b=Q7jUbTm7kBX4uji3W5E/ZUXD4F/4nMnbERvcAaO7PZw/i0UR4DXBdndHBcOuyZGBFx
         VGFD8PG3TeupYGLhcm53o8mMyfw+iSPzDxWQj/kdgOfI+KMg+vZiaJNcIKi4ZHbAFnDS
         6kGtYGO5jQFRqsmjwkXF4sJtUw/XRbgB0ld+TNbJ2Zt0q+2IB0GKa1Ndnr7FAfg54Fo8
         7uJhU66TSemZlNw2zcX25xu2hLW43EIWUHcqtIyx2jbxGkFWlN6+zQgA3v/2e5DLDYzx
         ikeEMQLSIXhSrJd3X6tWluNXsnluW5lp3z78RlfSt3ufJLtPzRDkXplnsNLUEML3i5ek
         3Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006883; x=1769611683;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLG7d0VkjGE3d64B0EnEsuq4Qe/nnfPrewItu9809qg=;
        b=uVcQ/lo2zxACZv57sxqBj9u0SiRGpzEoOVPU62uugJUlr68CBRkLqwMHXDjD8thbd2
         le7ZJbEZT8dYn6yLk0qGLnkVNGWKc2N+/EkPRe+EYvUq0x4zc8H6GxcvtsXmDpu26GT0
         IraaXHQ/s3WSTS0aWcp6hC44uHgNywb4THb12IiAQkcUPw20PA3c7u4/eA7DnB//PXld
         yMf3rovQK2Gsxoex3STYgmJddcoYSuYFLvaw8NKDdRDSVJdi7rA5uMotr79Hihelzerw
         lEVtDIx2NhmI9067GumGHIpMWG2MgTxK2+Ycde1/gXHN6sCP5EVpMKTJfyHcnxrHdOVT
         TfuA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1wQQ0mL/rkU1qUD3IOGJQo1iE96G19E7tjHiOCZVpbZvLw9g2Zxj2/wY/eARbpqDocjf2QNdvImNVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZu4HCYBPEQAqtAAFkwYI+BtBPrTchMH8lrclQ8N39DGaIum5
	TE0XYS0kn8/reHUpLQmFmUjgcQoIPU+5Rv4fhJmUSmBHavIW8beu99BZ/DuqOcfAj4o=
X-Gm-Gg: AZuq6aItseVC2gpkQOhzcgqspEL/TPz5poEcQqsNVkwVA9/XcRBiPwKFkdRDXYmkLYY
	bVMeDZEhCdApuh5wu21pr/b6w3SdgTMaEgHScZ5ScjrhfqTBwi9i4cyC6L8FI8PPpJ71Jo2nXqa
	8HfeqBmJ5n8ErDkihLx60UI4EDUee3M70nmOyHlitEhq4DJW4CFhso6k7QSE6Q4ZSzTjef1TOik
	NfqHy9bwZo3bNVCy3mbMmOQSNOVVogc5FCTJU6mxAt8Hmwb89mvPCSkfRLCCt8EFbn4Yu5/6aOE
	jWBkAKhI4LXij63tmBRNHwE0iZSgeRA/XuS0TUhmQHEObib1w3Z7rLwYCvBI1xmWeRL0x6NHjmA
	7MPQCRIRK5Tq5kBEq5LqIoTqi+z0H+1OFkSHimjezRkuo2RuRdV9YLwEIqNPAUawZj8SV8E3+V9
	dzxR36V5/nVHgTP6LLE42mwMevPxpV54cmTUvuf1K/RUBjI+/8bylRTkOAPAIq630=
X-Received: by 2002:a05:6808:318f:b0:45a:6d59:44f5 with SMTP id 5614622812f47-45c9d77f4b8mr7683811b6e.30.1769006883084;
        Wed, 21 Jan 2026 06:48:03 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03e82esm8760513b6e.15.2026.01.21.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:48:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: dlemoal@kernel.org, linux-block@vger.kernel.org, aalbersh@redhat.com
In-Reply-To: <20260121073203.234429-1-hch@lst.de>
References: <20260121073203.234429-1-hch@lst.de>
Subject: Re: [PATCH for-6.19] block: make the new blkzoned UAPI constants
 discoverable
Message-Id: <176900688193.9724.14031357578315902713.b4-ty@kernel.dk>
Date: Wed, 21 Jan 2026 07:48:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 21 Jan 2026 08:31:49 +0100, Christoph Hellwig wrote:
> The Linux 6.19 merge window added the new BLKREPORTZONESV2 ioctl, and
> with it the new BLK_ZONE_REP_CACHED and BLK_ZONE_COND_ACTIVE constants.
> 
> The two constants are defined as part of enums, which makes it very
> painful for userspace to discover if they are present in the installed
> system headers.
> 
> [...]

Applied, thanks!

[1/1] block: make the new blkzoned UAPI constants discoverable
      commit: f5f2bad67a45cd1ef6f5b727da104694a81b3666

Best regards,
-- 
Jens Axboe



