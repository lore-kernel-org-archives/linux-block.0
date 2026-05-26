Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBC3B9933
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813443; cv=none; b=kVqZOMDnDRDup6vo8WhG5BV2Fnrvz3a3yNaWXQgjEYVLv/64Zt/die6NVNFs4BpNL+VBrs7NvKJujZeA3JHC8czXzcco4hSCm1aW4z6vlgfwWNcFfYWjLI5u1H70R9Q/uh2o0apRCxpEqKw+NTZE/SKPSconBJ13cbb5JjRBbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813443; c=relaxed/simple;
	bh=IOdIghetUm7YEIVhoFsD4bolj70PLJLBshaT8vv9Ntg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=megjO6r6XVGHJu1McxnpY3hpQujR1FcV01oz9PE01EkygHGnunFBCDwAGYMO7LGft4gj3oQsyB2nFWG1sFy9weVXpJkRTpLMyaP6at89WqjvCuVB1ac+3ASwLmBh98HqjDwyLYJX4Myo8TsiidjlXdTO6233iNJhfjJAjzUyiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=iR7HBk2h; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="iR7HBk2h"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4854c4040acso2375131b6e.0
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813440; x=1780418240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJZjQ9AoSJtgE2AIvKKEKZkHWzYYNReJIQs5kdd+rPI=;
        b=iR7HBk2hgyOQ3HYm5c92QWMMnpOQFQvUbBGrvH09Vsxo00wYvcxp9LSLhwW6Zxg+Bw
         Jv8FbIfp2/DDcJZJysaHXuLIV8Z5pITvJYbwwcWjTiDOXhbjD/JHE1PI6hylVSnG/yNn
         slzU2WuyqaV/HTzQp5/RL8c2ui2SdZl95OcSzD9ls3G+vTtlhrVUkPjMyHw5m7zG9aI1
         LZQ/ZXY6iPllVr3yXiy1zhkrWLJLTg1VO9mglPU1Puau2rHJ7H1FvjPRrQlZuPlbwj0/
         xRlY9slYDJYPD7WA/Heo7aYmx/F+oWRCoVMlj1I81PaU59qxe+0FuioVTUgjdUYEMzuN
         Puuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813440; x=1780418240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GJZjQ9AoSJtgE2AIvKKEKZkHWzYYNReJIQs5kdd+rPI=;
        b=TaJ0XWfG8KqWuhI2DX6I03P7eHlV+vuiNZX3029QI5GdETznVnod7CM90ndlxrHLNn
         Ew3uHlcqdORZ22aFsZK4i+oR471D/lixpfFpJqXEykXMCeGWe2y1eYKnXRsTvZr3DcN6
         akhcbScjq3eYRZ8ZF+iyO36aAAZQq6fICh8PGPzI1KAPz7PSAYlSrey2E8aFNtpEOAQg
         WC9rMEfWynBwWo6gYXL9vpEFyN4LWM4hY5KAjxznXeG+wGkGSMj1t0Ve/nWtX+QWbJIG
         K6gI12ZSRrQb8ZVeFGsAVG+CivYSPVGoJiDjhL/+/YHRRLQzY/nKC65Blpkn8u3Ay2le
         EGgA==
X-Forwarded-Encrypted: i=1; AFNElJ/akpbXkVAIBsOhNUzUZQEELfa2gof7NJy34a3FtUOLl1QV1wuTtu3LZC/RomqjSc2vKWmM7F01GTYj7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx24UwPj08gaj1p7qtFnLq25ZVrsvtkgLmFceR2jTpdGxF47Mj
	ojBQ+gmV4LwM47Gk2Ry34nkkQJIvwBgnCLrzJPQkK/ueqGBvaIWrai2JeADyvkGet/g=
X-Gm-Gg: Acq92OEtPPFaeF4H3ARHdb2/n1/qHHcQ2y2+URg1SawFSrO6qNnxIL4khlnHWR/Aa1+
	+1C0r+5lK0hWAGxG9Aj+zqlkDwZzmxQzqu8U3YaKY85U4+qkOX8nF8U12KHS5ZOwaNw0mIjaeOu
	U3k0Wf0OXB7GYnCfT3Jv220Z7ZGwF/EmLAwyWOEjg6yIF/p94n3COP9UCqjOLxqxyym+Rwkv5ue
	usnDVqR8uJJ9CGeQFhVgk3SS5CmXzK2CAQrNq7jpZ6zi7O4S583NfU1YmXq3OJ2o0E0+sdhQ7T0
	1utWi9sFqNDh7Zhl3sjz46ZeCjN2syaBvdsl9AqsoAZdKELY5381Pe48/TO7Rj2WstJENckZjYq
	b2XLuUNZhs0xm+0txrh0gzzRHZuK6f69/JXcai6I8/gSPdusX8fB0nFgftrl/riXw+WLjbJr0cw
	3wbn0oKXTBMPYOjFl8jvIuhH03MCEGX0pZBj/Um+Lys22Vk1ud9zoJhV4XSZmlieJGQz8Ip5JDo
	oo=
X-Received: by 2002:a05:6808:222a:b0:482:aa9a:e576 with SMTP id 5614622812f47-4852dfdc3a6mr11088278b6e.32.1779813440589;
        Tue, 26 May 2026 09:37:20 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chao Shi <coshi036@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
 Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
In-Reply-To: <20260522220025.1770388-1-coshi036@gmail.com>
References: <20260522220025.1770388-1-coshi036@gmail.com>
Subject: Re: [PATCH] block: skip sync_blockdev() on surprise removal in
 bdev_mark_dead()
Message-Id: <177981343047.464267.10378401249582627288.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 22 May 2026 18:00:25 -0400, Chao Shi wrote:
> bdev_mark_dead()'s @surprise == true means the device is already gone.
> The filesystem callback fs_bdev_mark_dead() honours this and skips
> sync_filesystem(), but the bare block device path (no ->mark_dead op)
> lost its !surprise guard when the holder ->mark_dead callback was wired
> up (see Fixes), and now calls sync_blockdev() unconditionally, which can
> hang forever waiting on writeback that can no longer complete.
> 
> [...]

Applied, thanks!

[1/1] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
      commit: 304f384f34af98a205086ce67331cad4fea6504d

Best regards,
-- 
Jens Axboe



