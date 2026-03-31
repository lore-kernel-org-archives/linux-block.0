Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF5331203
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986977; cv=none; b=NUPEXjxSEVmiyvl0WdzwhthCNNwpOTaIJ/lZO6GydvHGVa+V/WlxW1NbZkD6BQlf1pypnRHQybFz/dqPXsL6GEuDAUret51c4HcvnaZtjLgUFYcfe5SRaDRXT+VXcJC1+7JvZJ8YU3E+Ttj4EwrhKcWnr3+7aHDzgavnqppY8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986977; c=relaxed/simple;
	bh=rkHmVUtsQzhqawcRPwquKhHQClG9apHQr96kTX5/KFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j9iE1gQ+PEHsi0hfM3OQ2AogEuuCTZVrV4XqOBJjg34R3CMlB53yv0REAMAtdEXSU4tZ2+hr8kXQG2+xtK/ToF8Jl09azzEjrEaagYH0Uqm3GfVBUnj7PkzPRL7AeSUuxe9sBNcqyaekdEXLRUTMOL8BnpFaB87lT+gaHRDs4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O1cot/KJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O1cot/KJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46703fb602fso2029805b6e.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774986974; x=1775591774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSRNbCN7FvakZDv0uIBWT2PiYN6gmrhFgGcsWQJHNZw=;
        b=O1cot/KJnoDlOO9yjjCSf45LoRjSeA8VE4gcpBtFZ2s8YOWLdVUUmwGHdG0VxWZihF
         LMUO84Fw6tsn+wA2OViJtMgcuNVpqigUxTAb9/7RZUqKra/XYOvRgDQSrlE1G0QGuVuu
         H5e/mjFTTTY/MsQBzo2SFWcAGJ+EthWqO3lTNSwt3u/SlkiF08jqg8CMMtw1FI7Rswu0
         Yp6J8sTzMtJpbxLCOMml4xlyWpkkxtzNEZ92apF7Xu1VwrFGpeI7X/Ck3lFrIbU/eFdD
         OM8LGOkO3vM0/kmEyvezHg7DNFizrzlDkEpmTh4fIDd2zW6zxGG76SnSNf9JUgpq8GPy
         N5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986974; x=1775591774;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSRNbCN7FvakZDv0uIBWT2PiYN6gmrhFgGcsWQJHNZw=;
        b=VIKdSbdyhUve468wBE77rkZLaxB1O8dN4Jxz4Jlv2gkjuQW8mHEDUl9sP6R4mnhb18
         SEGodej+mcMNPRn1qFMj8o9SpRuGCiVWTWrNGOea/UbqSgTU2UnAavqv7T//kXqFL5/P
         eAQ+BT69KVHg82QpgE/zGRZ/1W702InXBCq/1gtz6N+APDXkF67+4heEUOij+2klL/x0
         KJVYILZox4JcAs5zjwwQ4HzcTPQd7nigCNZfaGvfFs1b9A1ejSxo+hg0MMO1FCPEXDHB
         rzyJiYoEvtYRJHO8nD8xzezCsO3208jfciF1DghiPzgROyJvugmyDM0yG92FWcwRs1it
         0zXA==
X-Forwarded-Encrypted: i=1; AJvYcCWHxWuOnGle+8tuA/YicQ4mb31s9i7gcDnQYtKe2grkUfLwgbsBffq9nj5q0/qIfG86RNkHhYV9lM9IVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmkTNq9XocoHhUC3RjwFsqLekzXNohBi6EZ3TUH94lsxckc7v
	jVasO6PergBVjJoUuq9562sZf2AaiZh+hmaoruHC/dUWLLXq/EZcqxwHPRwpEROiWEaEJIF/rYT
	3uzPA
X-Gm-Gg: ATEYQzwhZ0i7goKnK+9g8OtRR/8JcpCy1YG0b12lSHlYmRtY9pfu/4Zm0zyawy0Ky+a
	x7BspII5lRfUOlOuKhSiUhHQZosZziOwYUqJd8E0sUhBLued6udUcFT1ngLKug+P9vSlbKvV2Nv
	DZ80wiMcGGjve1WalTqKS3vKbwo+ta3fw4Y5LIZ32dVbT9AUihGVxoVGOcgBkD75JPNxibVGFaf
	7eqU3j9x7qKX6+S4Oz3PeB0ix1RjXFRMxCZRt+phPiDiqDGX76Fidr2INKmRruIj0g/F93qjhw1
	zz3L41K1+oKNVknqPo2wiO/DMUrYPWRXvpTqbZG9P1EweIhL65vhIr/WVK+YF3OFRknXHc0W9Ye
	gLLWFrVa9YhDzEPR67xOK13jyRE63udpXllAbz67nwmTBfpfOCHM3VjUYeME895kd3ai3cdjDLo
	JDk5xxvzUyzcZDHWIYZXlbBW86f2zOsQfSwcVjr2NfjniduzrcfSqA89qBe6wsdpoLNWMfOg5qW
	9Q=
X-Received: by 2002:a05:6808:c168:b0:467:f567:d609 with SMTP id 5614622812f47-46ae01b5369mr410934b6e.34.1774986974504;
        Tue, 31 Mar 2026 12:56:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fe94ebdsm7360212b6e.4.2026.03.31.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:56:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, hch@lst.de, Jackie Liu <liu.yun@linux.dev>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260331085054.46857-1-liu.yun@linux.dev>
References: <20260331085054.46857-1-liu.yun@linux.dev>
Subject: Re: [PATCH] blk-cgroup: fix disk reference leak in
 blkcg_maybe_throttle_current()
Message-Id: <177498697359.21114.114115026638001310.b4-ty@b4>
Date: Tue, 31 Mar 2026 13:56:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 31 Mar 2026 16:50:54 +0800, Jackie Liu wrote:
> Add the missing put_disk() on the error path in
> blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
> blkg_tryget() fails, the function jumps to the out label which only
> calls rcu_read_unlock() but does not release the disk reference acquired
> by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
> is already set to NULL before the lookup, blkcg_exit() cannot release
> this reference either, causing the disk to never be freed.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
      commit: 23308af722fefed00af5f238024c11710938fba3

Best regards,
-- 
Jens Axboe



