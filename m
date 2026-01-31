Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF793816EE
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896610; cv=none; b=IPq5y4rvbPfKY0YnI26kOtbo72S7JZ157UC9mzKNKqOd0i/4B1sEOH9Z5/8o74+DVG5uhbW6f987QNpLl6cFUYtYNZmYfMnkSucCr9ww8sUah+JXZIPkGflaRu58MSOlHF3Ne8H9p4lN1tUsgi6Fajvla20Sdw2J4x9roj0w+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896610; c=relaxed/simple;
	bh=Cnde7RT7deu0GiX3Nv+i2rIR0zxPjjjarC87IOuNe0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NDEHnB6EVq9TDq4lHw1JrEVwpcNT0un3wVReHBW/4hJqd4NDQd/rvJqz/C8ld/dnZGC+AYa0e3+kJPJLT2RoC64xY5AIDX4f/yuyQ3k+9gRSq2zzoWG1SAfJyB7EO6+3KAjyUFXK4th+tW+F5Eayot58pVvPwORA+0sPcNxdqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WhpXkmBF; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WhpXkmBF"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f18e8f2f5so2188356b6e.3
        for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769896607; x=1770501407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptL9k6O4m1hRyeAjWpsh/OFfaDo41W1gBK3nnyvFljY=;
        b=WhpXkmBFNtPj4If20hHz+EjGW8/yhZMhyxvdUwycg49ITVvG6gQprGqZK2gUos08iw
         68uy2wTeGi6n33pdjBcnazkKfa+QvN2SSxhOMBPrxx6HFYvGC8uZwbMA7UTN15QfNJA5
         5qny6HIwB5ixPyhd9vGCsIvtVkTqb+9c55chzlMCf3rIdM2VD1IjZ7JjtIgEaPj3rgYK
         9vkDhXq2jI3Uiru97DMSWOLBZm5r1I9+Og82QmqngwsPgMqa/cEa4yP70RTY6aH4DRH5
         kcYHSltdvphccBAJnDDopYQHWiDUkHTgzUEGRdDdSW/HtyA/OmnlPRMXRnkafcobJ6jL
         DqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769896607; x=1770501407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptL9k6O4m1hRyeAjWpsh/OFfaDo41W1gBK3nnyvFljY=;
        b=nd/lHx+GCGRkyja2Muo2JjUfC7xJ8Mu1n7z+Ag53kafNBidQXnrO8fv8Cu/p5dHbNu
         cnznrOH1jCiX7zdfyMT6kDguYba/7DKz6LwpiOeNEnRp81Q1kWW839ysURj44iMf8AP6
         3v+yaZ08z8OO0DgwX4Tp+TzlfaRGfEN78gjaeK8UuDfbIoKnQ1kPb0IlXoQ7my/yUmuD
         2aLynSq3liZeDzXcsFUlnZxXEEUn2uO2WsnPXYP/H2gkW/4XleYzgUAWF1Wn/hcCnl1L
         13VNBgE2mZ9EakfzhXZrS7Sf7CHQ/cDs+lbFTTJM7yy5ejwD9THHmPY/sXPm6EDYShlw
         HRow==
X-Gm-Message-State: AOJu0YyT4VyPKJqlix0YLBB3fmAx60ZqHzY3ZvOMnzZ96urG5X33cQ/U
	X14GWHKIYaZbNuFh+cTmAtqz81eUi2eR3dDl4jkLdoA6+3VKt+nzEHzlNi2A2MhlJ9uC3k3EP9k
	bWebiGro=
X-Gm-Gg: AZuq6aJF4H0U4Ik4SSbX95Byxx5M9u2KppIW9FFaKGVsMRe3tuRNyjAPkYzsOnRgYYi
	ZZJHfyUaZ38yF4qBQeD0d/fJQjB+yOWcMrv+PkSrO5p+QK+TPyTessrRE8Ou/+g1Nc/gU0kp1Hy
	Y/+xqHDJooBpVDOCgIe4GC2kuyrPi8/UUjFk58uLwGNg7rWrchfA3o52CmsJWWwZPN3RWNnouWH
	OXpVMefTHBmW6yWnbLJH81mo3g+rRIuu484EchrOfcEhQ+kBPLeHPvxPVcLAW9FlBuVZBH1rTJZ
	7luqesOGTgik5xUfa5yfb1bS8HQGWyatvYSYg5Gag24BjHrPvMb/puP8xj4vNMNbpklKQEP5O37
	mGzuzu6H9Ynv7IAnmN2rAQGuZ8VzLZ9wFiA9S6itKACnrRBPVtxpYB3743SIfMqW3vUAcUc9Gx+
	uqqf9YDFVowgYtQWca9W14qd31qvuFe8m2J1EOQLEdDXAhl9UuQU4v0r8h+yu3pW2h
X-Received: by 2002:a05:6808:15a6:b0:45e:6560:9be7 with SMTP id 5614622812f47-45f34c17011mr3543667b6e.30.1769896607013;
        Sat, 31 Jan 2026 13:56:47 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40980497603sm6590116fac.21.2026.01.31.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:56:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 Alexander Atanasov <alex@zazolabs.com>, linux-kselftest@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/9] selftests: ublk: test infrastructure improvements
Message-Id: <176989660568.986261.3271100183902901255.b4-ty@kernel.dk>
Date: Sat, 31 Jan 2026 14:56:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 01 Feb 2026 00:23:31 +0800, Ming Lei wrote:
> This series improves the ublk selftests infrastructure with better
> organization and parallel test execution support.
> 
> Key improvements:
> 
> 1. Infrastructure enhancements:
>    - Add helper functions for device cleanup and parallel execution
>    - Implement group-based test targets for running test subsets
>    - Track created devices for proper per-test cleanup
>    - Increase timeouts to accommodate parallel test execution
>    - Test time can be reduced to 1/3 with parallel execution by passing JOBS=8
> 
> [...]

Applied, thanks!

[1/9] selftests: ublk: simplify UBLK_TEST_DIR handling
      commit: 5af302a15a1d628a025a78892001fe8afea90c60
[2/9] selftests: ublk: refactor test_loop_08 into separate functions
      commit: 842b6520e579b8bd7d6ea09937e1fb7729cce1c5
[3/9] selftests: ublk: add _ublk_del_dev helper function
      commit: 92734a4f3a7a5449b0c7d0160ba658a2b665c31b
[4/9] selftests: ublk: track created devices for per-test cleanup
      commit: 2021e6109de3e97adfce262c40a657ff206ef495
[5/9] selftests: ublk: add group-based test targets
      commit: b6bbc3bec19efd557f888d78865b627b80b37a32
[6/9] selftests: ublk: add _ublk_sleep helper for parallel execution
      commit: 64406dd2f69fe27921c7bf06088871c002cf6186
[7/9] selftests: ublk: increase timeouts for parallel test execution
      commit: 56a08b87f9f2a763cb5546f83b78ebe1e96260af
[8/9] selftests: ublk: reorganize tests into integrity and recover groups
      commit: d9a36ab302b1c90d8f03a3b13538b8676eb6ed3b
[9/9] selftests: ublk: improve I/O ordering test with bpftrace
      commit: 5314d25afbc44d0449fa2519d2c9d7f3c319f74c

Best regards,
-- 
Jens Axboe



