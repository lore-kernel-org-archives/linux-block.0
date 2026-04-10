Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0162D5C8E
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783483; cv=none; b=P5Q5SHKxlibbGimAIFVI5LflsK6V3w/MLgUqMSsf1R2cpBH0r4Eds6muCaYJFSvI4zMCraMiaQa+1RgMwequ7g6MPjX4pN8b5AqieVGdaInT2K+X6koc5yak2JGUmgZLsj28eKK4Aw1+bap5d2qaVtlAjnlgXvudIDGhhUMMZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783483; c=relaxed/simple;
	bh=FLqv1MPCw/yWdJO9BTp34ptrOXgv+tQnf/D0Sd0i/Z8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HbBge1rS1h6VesCsuCjfm6E3COP2WanUAVMMHYEJw4QIcYGEgsGWOLx1MUsziJZKLXfY7hVdB/GMeHxfYQNgTZwkoVRSeqKRaKrdPP4D3kalrpmTjEHq5VA/O9RS5a73eiGz5ddPxwF3UiEP8RHg3bG8fc5YA5LjJpB+g0KGMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=W+ZeAieI; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="W+ZeAieI"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2168510eec.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 18:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775783479; x=1776388279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D9UITiClzw+Ud2bwsY5/xcCroP5xGUK3d4IAAtUen0=;
        b=W+ZeAieIOBysYDrpEpq2AZXSQAfgy7refCJT6jjnY0eXPBb62WpkQ7CNRG0WOdJxl7
         D6fzydTZCMtX3xUHQT9Qg0KSY1na+pqKTCXfLGKPMVHjhOxw5NYB4/X2jrgIlT3BO1La
         MTn5+mng1TkWKomDbiRlvw5hmhpLC/0ddJcTONCys8j2wbbOJ6euLw2sMnUCyIQ4LuBE
         mzuVnN01isnRwQI0u4593tPLkJ6rbG25UwX2IMF9d4lS0t/SZ5Sc2xmerpPN6xkik9Z4
         DK+ds5qhqHZZBEKe6zZDIGGGbCsy2DBnj4gU17iKMhd5fWjoyW2TLuDB9qTrzxKBzjr0
         8nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783479; x=1776388279;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5D9UITiClzw+Ud2bwsY5/xcCroP5xGUK3d4IAAtUen0=;
        b=UEmeb/87a6OEkg6WLDIOBe+/ccYYfdB2aR5BL9kf3/YWt0CHihAD9cnOP54DSRHgX0
         76WJ75X6HtuozAjhtS96JTAufh+qE/J2qZLaxxewW/Ym4ctk3rAXUFvVG7mdHmpP9Ees
         /2BqV3TA7tUGoxn6Rl2DUwkhOYtRFCCqbmE29d1wG4VjlYJ1/OWbY00EdAz4tRH1P5Ix
         aTCpO7JQOtF59h01xr4Vg0npXGAcGTEsiNQFqsRaC7QD/rtbpoGserXrFmg6fObVDPuD
         Lb5UYr9fU1VfUQf58Twz6t5SgRTCyGFvN2yY3K+0uEgo5EQwhEYfqfa2cYIP0+XIBQkY
         EyyQ==
X-Gm-Message-State: AOJu0Yzks4DTySHr6X58uU7zB2qD3L4ErCKrOP68Ve1eY5ZdF64hiKjS
	pE3eVn3BW6B+0wMN2Sq+GnZ2L/JClo+spl0LTQJojk/msi97bUElMqb9guHLcA3L2j8vyMscpwl
	PIT/4
X-Gm-Gg: AeBDieu24xJFYvUD99g2Mlxwdv9C6HGqUrzfd8T+6DXYNv8HCehiBqjSc4/1zr9Mqc5
	K1z2DSAoPk8rCrnGqtw4dIEXW9+jBl9L9UXvCbg7/ci8KesjYxLt4+suW2WOKX9cIMxRzd0E99J
	wS2z+6OjrkVX9utTuj8ro8lfot88CiKlBycXe/U6pXh8hsRG9Q1N2ABfkZLJxu4yLIQtny47//8
	FeO5mIK51/QHIlAYumBL8/15UV/2eA2nC5ybwOtcbJjusfq1pDZ8+VV3kdaWqOnU7y7nbOJ7cMj
	eGun/VhbUSQIeko7cvGhNZksvfgxMxtFASUWqBpUTG2Yki+uuo1f4Qkn5r051mfDcbYL0Jzi7q4
	R+vqkdm0YqNxiEhz9QuQwiYKTi/5wjTgJXf5FDj8LF+nyx0kc2oMVkG6LS5ruyshQvvUlI0q2p1
	q9mkhuRSzxxFlwX7HkpA1gCy/cv4t+jJD+WQKjBcHIx6XlaDjw0m0z23oBPlMHF1Y7oVEbOoby7
	sB+BEY2fQ==
X-Received: by 2002:a05:7022:fd01:b0:128:d23d:81a2 with SMTP id a92af1059eb24-12c34eeb982mr674969c88.29.1775783479337;
        Thu, 09 Apr 2026 18:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:873e:380f:e9e5:ea98:a905:9cbb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa571csm2462450eec.10.2026.04.09.18.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Subject: Re: [PATCH 0/7] ublk: followup fixes for SHMEM_ZC
Message-Id: <177578347806.487779.11672124480014086344.b4-ty@b4>
Date: Thu, 09 Apr 2026 19:11:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 09 Apr 2026 21:30:12 +0800, Ming Lei wrote:
> Followup fixes for the SHMEM_ZC (shared memory zero copy) patch series,
> addressing review feedback from Caleb Sander Mateos.
> 
> - Widen ublk_shmem_buf_reg.len to __u64 so 4GB buffers can be registered
>   (the __u32 field overflowed to 0 for exactly 4GB)
> - Verify all pages in multi-page bvecs fall within the registered maple
>   tree range, removing base_pfn from ublk_buf_range since mas.index
>   provides the range start PFN
> - Simplify the PFN range coalescing loop in __ublk_ctrl_reg_buf
> - Replace xarray with IDA for buffer index allocation, removing the
>   unnecessary struct ublk_buf
> - Allow buffer registration before device is started by taking ub->mutex
>   before freezing the queue (same ordering as ublk_stop_dev_unlocked)
> - Address documentation review comments
> - Update MAINTAINERS email
> 
> [...]

Applied, thanks!

[1/7] ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support
      commit: 23b3b6f0b584b70a427d5bb826d320151890d7da
[2/7] ublk: verify all pages in multi-page bvec fall within registered range
      commit: 211ff1602b67e26125977f8b2f369d7c2847628c
[3/7] ublk: simplify PFN range loop in __ublk_ctrl_reg_buf
      commit: 8ea8566a9aeef746699d8c84bed3ac44edbfaa0e
[4/7] ublk: replace xarray with IDA for shmem buffer index allocation
      commit: 5e864438e2853ef5112d7905fadcc3877e2be70a
[5/7] ublk: allow buffer registration before device is started
      commit: 365ea7cc62447caac508706b429cdf031cc15a9f
[6/7] Documentation: ublk: address review comments for SHMEM_ZC docs
      commit: 289653bb76c46149f88939c3cfef55cdb236ace2
[7/7] MAINTAINERS: update ublk driver maintainer email
      commit: b774765fb804045ee774476ded8e52482ae5ecb7

Best regards,
-- 
Jens Axboe



