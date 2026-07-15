Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54913D5252
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154881; cv=none; b=nhm9SEWhTVKdU1b7BXb7fCHvxbudJ0D9Gh87Ni4flPofsMjHNyPfmDjtZCzEYZ9mjAgzmq3YRhHw7BjCw1q6cAsS3fAQkQKnXUzibNd9OAkWgkHh0VpBDzIafUfOmGRRZWr3xMPpKm9AlWJp9BUWppcbEOFzTM1+ylfzIxDCrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154881; c=relaxed/simple;
	bh=MAbe7FFOxvk/HvR5Y86UBIzMmuEkVFfK1ZfCexZxO8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MZn8l+JAqPFS50sukKbm14fnzaANm6/aVZn9BdwLPwi5BQ+7UoVXIb79b7uM9E35v655ucIeoLHSuQVDz6lSyCJ768rsBlk8coCFqCut39xu1qVzgGmsdRRgr2C7JpLvjCj/TDMBE7S6Zy9JFgQsZTsWzx52Je3YxuFPYeQzanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JAkHSR+J; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JAkHSR+J"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-455a61c53d3so2301008fac.2
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154878; x=1784759678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niLd5/LGzk3n5S3gnqCqcM7O0n/4L/Fl7i1GyHScQFo=;
        b=JAkHSR+J/lKZzFfSOa+qcnjWG4jwFN5eXGXjHUilfSDLw85wx8gmkaVKT5dfkfeJ1p
         qgK856/YYTvmGVmLPybXiValbIHUROtU81Ad61lUyEIKZpCq8BjK90yEFseI3JaM3XfY
         KL2SYa2uxzZaUwb6lDVrMSGOlN9kA6rXVkc1ZP+ANLAiRfqbyF53tnvD1fv5EU/mSDRA
         D/s3aIYzO41WBl39kdU2NWzgeymXwp9HMuclsS6QGAlcBhHAPL881pShUZXyUEFBtrVN
         b64zJEcIgtFYvSqGCnIJzRl9SMSNuEkTu+r6C4Dl06r6tTrZWU/r9g7kTCKrbqrwlMdw
         pDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154878; x=1784759678;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niLd5/LGzk3n5S3gnqCqcM7O0n/4L/Fl7i1GyHScQFo=;
        b=nRJOgDwBytkE7He53oP4ug/MIY5ZuR3DheFv29qC4QhgaBAt+tpP2w9YcdROV10/kP
         4+cYKBCvTNIfQhdgKqbfDP3fLHt08WCaVOcNP8nXGtVyc26onX6tSlb6rj9uA4vFMeUA
         IUR9eJ2XrtsZv0CEHlQuTePKoFaZw/lK3vRqDHL6PwA0ucwNeDKZw1NNByj1mVEXPwR+
         MACvH0MI6xPbECM/sFCatbUZBY5PPUlqH3FrvDwTV1JNWSpgvYONpqNBOjbDB4ePC4fB
         JrjFIPuubHxjHd3+NP7CHkxtKHnNudLlMtXLt4mcE7vOTPFOKYe+8baVYcMKTK/ORnY+
         J4GA==
X-Forwarded-Encrypted: i=1; AHgh+RqGE8GcsIVTSRQG+5reFH0sQffG6jmYqkaji8cs7zIeSUFuG6DqEIFE9y5+m075nnSeOZPL6N/M4Jtj4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9T54CT7wjISSI3HzW8G2zDvvrENeQI41WqaaE6g/neZfUkeY
	BIeBdsukCJFJ8Nff/N28FKDKK3XW0/hdJZ/AUM1dpK26cIVqGAdD+Lvf/cpW0YApUXo=
X-Gm-Gg: AfdE7clIMTr5tfPOgcDkfBZjxBoSbAEdZHRAlTfBe+reZ2ITfntbN3fUmXimK7GIv1a
	F52E3v0Sk/kNh0Om98dqADmT+hpBqgakP05V50xxXjxJjyIy7aaO48SFKH1wkIZ6UMS11euiXgC
	oC9agBjmtQQZyGvrcfOND0U9FulZYrOw+6w8apRa7LSubQll4q+e5t2aCrMJq3OjtkEFx3zFdWM
	sfQtnH6eauZNwaXom0xMG/A4JplFQLy95oKIzm/kBqydNWxQrPfa93IBEfN76YNVjm3pT/I2XL1
	2VirMKGQM3I7CcZpGbJUIJfNkZmAn4kH1ySNLeiCw2VBP0V2eirFcUUaTot6lA2a4+SVDkY955k
	qhcAW41+Xv65yVrLIdTQFwnNmgphyy/YOSK+pFi2MmEULY7cus3TDh9sI1vTp5gQinrH8U1Ip8Q
	MzZjYQ7FeVzcjaM0EMhrzl4QKNBx2zOkwCGyBVvCOyM7g1Ydz4uquEtDA=
X-Received: by 2002:a05:6870:70a1:b0:451:738b:79a9 with SMTP id 586e51a60fabf-4560b3f2edcmr4833708fac.4.1784154878606;
        Wed, 15 Jul 2026 15:34:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Tao Cui <cui.tao@linux.dev>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260715132407.1469777-1-cui.tao@linux.dev>
References: <20260715132407.1469777-1-cui.tao@linux.dev>
Subject: Re: [PATCH v4] blk-cgroup: fix leaks and online flag on
 radix_tree_insert failure
Message-Id: <178415487685.159585.7452024735126853374.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 21:24:07 +0800, Tao Cui wrote:
> When radix_tree_insert() fails in blkg_create(), the error path has two
> issues:
> 
> 1. blkg->online is set to true unconditionally, even when the blkg was
>    never fully inserted.  Move the assignment inside the success block.
> 
> 2. The error path calls blkg_put() without first calling
>    percpu_ref_kill().  Because the refcount is still in percpu mode,
>    percpu_ref_put() only does this_cpu_sub() without checking for zero,
>    so blkg_release() is never triggered.  This permanently leaks the
>    blkg memory, its percpu iostat, policy data, the parent blkg
>    reference, and the cgroup css reference — the latter preventing the
>    cgroup from ever being destroyed.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix leaks and online flag on radix_tree_insert failure
      commit: dbbca20764382b4d411ec2918f4e278ffe547acc

Best regards,
-- 
Jens Axboe



