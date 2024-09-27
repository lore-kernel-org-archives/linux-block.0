Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C804482E9
	for <linux-block@vger.kernel.org>; Fri, 27 Sep 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432413; cv=none; b=BDRoJbytjVLheFrPixlYbwRaA1TTfc2n9bj/lbvAsjyVo0uUzJAGIoeIDlxMCQl713/Siotqp3KPsLtdzbdV11anisA8W1l35DGXRfRhxbHVRKg9LuMTXHB+QuZwPJlVY3gTMQg+WhjMTVit6Y0PDWhgcWToVOtaBlQy5UiaALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432413; c=relaxed/simple;
	bh=Rjs22Co8nk2nq9i4KhxQVxh5qEHtMc7khpGkpOvsGlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=huCSiLOPNQg0/tGmWEfLRe8Y5qM8tRRjcO3OniGkT1G4qjPOdo30usv+YsRW6uwTVtN3UoaMA5lIi4yPtWUnunmERLQmYfy6Glp0pm/gl/r0kCsjwQpibvhDHGKQTfj1GYtXPG3IpTmhU5HV5pIIcLiAjPjl1GZU2+oFZzDaBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XdYBXjwg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XdYBXjwg"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71b0d1c74bbso1423940b3a.0
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2024 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727432410; x=1728037210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV8fGTl1dfQ1KXlRiYrNMw6Yh7z+4ykj0RenPd/rTII=;
        b=XdYBXjwgWv1j3OPGrg9Ftws8SuKD5zQWAayTm/2LGf8S8MRoeDTJ/dJwdKVI4CEE0k
         NxoiuXZmxLShrpbeAF+S1BpXzzIpTBkBOILzWXhZyeXzU95TshYyt3w/C8ahEvK5/50D
         L3iZJ0C+8dbr/PoW7z30hXlA3unUUzi/XdW3ylolp/vIitDYQCOu4w1dt4UaWcvbDgnd
         4h7gzXjUE/8uNnZz0O5J6D0HjOnExOcLWW6TNhRy2jdSiCnFtbA+eXxcgd0Zxj/LAttv
         cy/ikdsSct0gBTiu+244oLRXPLkOLpKsrypj4OoUCLKz4fd8Y80n6VVrw4cQ+IRTiJz5
         wpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432410; x=1728037210;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV8fGTl1dfQ1KXlRiYrNMw6Yh7z+4ykj0RenPd/rTII=;
        b=kW2yWkad4vg0Txj0Iv6XUBE93v31TDJzBZmOFKdtvzO7LGoTGEbeqkgkA/+dDusKlj
         lEAMKmhUvYfeYQluWAW6BzyTOK6KxHJtKTxvLqw0r0J6kPeG+Kyd9kFSJrDaKp9bxPEs
         2NixemRtUyenRHGGGwBAKQvv6KXpFuWwEbl6DeLPm8GUpB9CMBTnTxt6lPf+nhtid6Em
         8hiMHJt61ewW5T3EwQvtiIgrwcNwNzkUTWHgj7dXRESeQJ0fKkmu4dR+miX2SS7cjiJS
         7arj2O45xnhibJZIuccXD2rMfs8zsiJYI74Nqm1hdNpr/rb/1FB/mTUV1XLs2kdHiGsM
         efpg==
X-Gm-Message-State: AOJu0YzuK1g2joK3ZUM3WahWJ1Yqbd6mgzfiFWWJwt3yosI6qKHOo4HW
	ksBsU2x/ERk1F1zVfMMtzOyHjVBDB751Jv2VTH3YQl0Kw/UG4zuekxqyGZVSoTeosRvhRBPRBvX
	xP04=
X-Google-Smtp-Source: AGHT+IGkI/j4jJeTJBSmlaZUyP6OKV6RWz3WOuJyN9fBa2ZIvGkSirQjXZ4i4EINKXJHD5c3DFyhEQ==
X-Received: by 2002:a05:6a00:4b13:b0:70d:1b48:e362 with SMTP id d2e1a72fcca58-71b2607a58fmr3786604b3a.26.1727432409978;
        Fri, 27 Sep 2024 03:20:09 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515da6sm1269982b3a.122.2024.09.27.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:20:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240922141800.3622319-1-kbusch@meta.com>
References: <20240922141800.3622319-1-kbusch@meta.com>
Subject: Re: [PATCH] block: fix blk_rq_map_integrity_sg kernel-doc
Message-Id: <172743240872.34486.17230454018472013287.b4-ty@kernel.dk>
Date: Fri, 27 Sep 2024 04:20:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Sun, 22 Sep 2024 07:18:00 -0700, Keith Busch wrote:
> Fix the documentation to match the new function signature.
> 
> 

Applied, thanks!

[1/1] block: fix blk_rq_map_integrity_sg kernel-doc
      commit: 8be007c8e0911d0450b402ca8cbb1a8cbd00e8f2

Best regards,
-- 
Jens Axboe



