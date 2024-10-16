Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E42071F8
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087719; cv=none; b=fi7hVQLrbUaIIuPGC5DzVgJHrkyxInherkqWhms6X/gBizlFDa0KyeLK/jTwg4fTJE6j2aCf4FKyq3Ls9RgX+ZN2b6q5dH8h8gJWm77/8Oh6gbiBkuWdpOXfxDXmc2heP5RYH4ZssMS7w11DMzHGtge94IV0WoZZhJ6R9NY84U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087719; c=relaxed/simple;
	bh=PS1FdrTKbnIDdkOC+D3Nb5orQ02UkG2CduMcOr5bLzU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GnvalCych3fI4DH+5Z9sqGDLyGUgGJCuKw1Q9h5dblacBfW65YN+4iZ5Dlt9UsevWkgisjjTdCQkHVK/vgW0zAIG5DKHaVo1VDxZ7X0gxC0wI7bGsnRI3snFCenXujViWyp/hYFIm1chXuPrJfhwFijZH0S+XhFFOXFQEH7kXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=voAxgxDu; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="voAxgxDu"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so21704245ab.3
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729087716; x=1729692516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKcAJrsMT6v1EJVRGfh/ABrvXvKqs+PkK6NkGIgrV2k=;
        b=voAxgxDuHbmwYC3huppaDu/KXWEJFLo6Re2QXGptppnwmYoNrc78tVDv98AqGjArjW
         wY708e4OWj6z1i1SIYnm6ML4Lto9fg7KmS9sg+64KmPQdow6/eWEIf1LAHd/es6mpJmD
         WiaTdiBWZ6A6S18OW8K2mXCWNDT6+Ski996/yrXm9IdRSRX9GHYPXDWn4plr6YmXaeyn
         EzKXN9rer8drqAzULuePYk+51a9ElF3Ca9c4gasrW0/mK8kT/pfMb5ai+5P2S/j8DGBf
         W5ZoIQNF2c1sN6FkvC1Wk80pechRnGjI+Wxov0fF8mvkh+HDcxZN+sD2/KlTQcg2c1UJ
         5Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729087716; x=1729692516;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKcAJrsMT6v1EJVRGfh/ABrvXvKqs+PkK6NkGIgrV2k=;
        b=ekRx4e4Mx4fDdE9ThWWMWAef08m8qzs1c1bGWGtFrLXYgEgjmYy9VM9udtARRUXolb
         y+2U3J8H3u6OQtb8SESlAtdKjKnd549cqrh0mI6MaWbHi0ZsXNmMGp7xeW+L/rUyMOiO
         4t86SZUTUxeRhEcpA/8JdkqMhs+DAyISF6NNAxET7xuM371s4o3BcLuuTh+GflF5ARsB
         l8/8kqRUg+KvE2SJ8rRdmWzVccNdnwAzzpp8NJjIzLecniTJybRXmfufHZsXhKwujWmH
         rFxrpuhEtSC6jj+BHwprNx67ALmxu47G81IVdbGpxqfd2ih68TE5o2Zc7VeE7CQpTfWX
         58AA==
X-Gm-Message-State: AOJu0Yy6Ye2XPu57kf/rURA7GwecwqNqMMia+vM6IkG9iuGWjlLYTSNa
	kRtwJJ4M0IB6CPFrn1lNhxCOuqvYyc5rZxZuGEzBh8gw2y4x4NxAU6U8S7dqgU+7ucilEaAaV7c
	5
X-Google-Smtp-Source: AGHT+IGdDjZuMmb+MY28FT9rHcKllNprqDnweo3KftlNd0C2m7Hj+r7n3A4gyxBMkQbFHQich3bsbw==
X-Received: by 2002:a05:6e02:1a4f:b0:3a3:b254:ca2c with SMTP id e9e14a558f8ab-3a3bce11c80mr144485285ab.25.1729087715535;
        Wed, 16 Oct 2024 07:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70cd606sm8284545ab.52.2024.10.16.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:08:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241016134847.2911721-1-ming.lei@redhat.com>
References: <20241016134847.2911721-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: don't allow user copy for unprivileged device
Message-Id: <172908771463.7156.1054660987028664043.b4-ty@kernel.dk>
Date: Wed, 16 Oct 2024 08:08:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 21:48:47 +0800, Ming Lei wrote:
> UBLK_F_USER_COPY requires userspace to call write() on ublk char
> device for filling request buffer, and unprivileged device can't
> be trusted.
> 
> So don't allow user copy for unprivileged device.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: don't allow user copy for unprivileged device
      commit: 42aafd8b48adac1c3b20fe5892b1b91b80c1a1e6

Best regards,
-- 
Jens Axboe



