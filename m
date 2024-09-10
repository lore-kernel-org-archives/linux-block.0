Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036AA1ABEB9
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007979; cv=none; b=p8UtqLtpkdbpIQ5NbSrpBUIXmQf3zURM6x3BcfvJYzZXvky+6P4GWY5wCRBNsECNkIpGbfSpULEAWL3yURgVrxefv4THoxx9ilASmVvLLbrsuVZgRkJMTz5byk8darX5mOVWmkQqwhjTRJcbACBChjnhwd4wNYGui44pwguMix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007979; c=relaxed/simple;
	bh=9lozWcbmWLbcepezHSOWbdICzaNXH073+Xycr1gGoPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hV0syCbwRevYQTnlT43M2Hwz5hfLHeCBJoZZS9lwgTVTBblsZ2okpWb/noY3qe0pvvRg2SYy38jNTEAekOsjzDFKKjV3adFtPHgLHvrYVm9Z8d8VZY4F2zEN27jx9Y8YRU7A7/u8mIuQfrcGYteMBRBsYeCnhSODmm1FoJaDfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ft3wyKVk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ft3wyKVk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso3949933a91.2
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726007977; x=1726612777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEgf48d3Npdbvo6EbFMiLCDqMwGMD0QaDq1MPdaUUIE=;
        b=ft3wyKVk3aMT1GXHejUXbtmXvku6W/ZTXY/WOJH0UNfc+InzxSYO/BJDgdoepcnA8l
         MnOzvKDJTali7k4VBrlQhLUiNGa1J0mRQ2CI1c1sI7L/9r2WHKcbYWU5C0EeBhpVH3Vx
         VeyaoJ+PJRBVqKkizoOLKwKM3cKQwXtb2N9n/bZAcIw3zZLTeJdgypmhkbyS/O+8MMPX
         rzhPHOrdKJFWQ3HGCSAYW+TUSjLtX+F7mEUQds6RTwQEnL8mGUWueBxpawJD9Ny37Cqo
         MPVdtkuTWE9egvs7Mg0SiMgi/CA0yl1fH7rYXgZ0/IyqRItCfchsI8sZ5WpypJB2GcP/
         l81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726007977; x=1726612777;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEgf48d3Npdbvo6EbFMiLCDqMwGMD0QaDq1MPdaUUIE=;
        b=YXRaEA291sImQ4IATqal2RaGVNb05Wv6YB69NjUeopCAKqMxvUCXtoDQDW1veDR4m9
         cxzXPGildXqIftl4BF6C0bjv+FHVDEoklM2Lu+NJ4DiPPrXad0ROC/FsZ87blzJ66Apm
         py/5bUpGY66XShwPLpecSv4V4eh1CdOhL3b4v0DiZX0bGf/ge/NvYfnhCKGpRT845TT/
         nnlRTJ4rwMTdY1uI0OplhgC1oX9RC2AcutvsQx/UD7apXiDFd0l8SopQVn+vtDWHskLb
         0TUozfqknmhDIiSgJZfCZY3Qu5Hjsc+2ekd0ycDOhLUu1Vg+DnEK7/c/k+nIq9BR1lLJ
         aFaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WdxRXAxFU3KsnG4dCcvD4tkv+GORJfUEt+3Qnu9CDVQb6Pu+yQQzfPOF67r4MxoJ0kVsuSb2Y7ccKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq27zTiZ2LiUEt3xqzYHvjnJRIDLDN7y1PL61WoZXc6AXS6pe/
	TBWYmr7Lkgk5Loo7ytiPlrDhHV5GAyK19dvEf5QepLq4uD6RHoWuCnGZ+MTkzUM=
X-Google-Smtp-Source: AGHT+IHCH2U+Pd8pCtG0FiLuc/i8oC84BPGovGTV+RXsztdpQ8wULTsd+XipxuU/K/xfaYWjQ1mgAA==
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr12858061a91.40.1726007977323;
        Tue, 10 Sep 2024 15:39:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc127c5bsm9023783a91.52.2024.09.10.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:39:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240909134154.954924-1-yukuai1@huaweicloud.com>
References: <20240909134154.954924-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.12 0/7] block, bfq: bfqq merge chain fixes and
 cleanup
Message-Id: <172600797599.158663.4657437776130763939.b4-ty@kernel.dk>
Date: Tue, 10 Sep 2024 16:39:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 21:41:47 +0800, Yu Kuai wrote:
> Patch 1 fixes a problem found by xfstests generic/323, tested on scsi
> disk with bfq.
> Patch 2 fixes a problem while digging the above problem, by a debug patch
> to print procress reference.
> Patch 3-7 are cleanups while reviewing code.
> 
> Yu Kuai (7):
>   block, bfq: fix uaf for accessing waker_bfqq after splitting
>   block, bfq: fix procress reference leakage for bfqq in merge chain
>   block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
>   block, bfq: remove bfq_log_bfqg()
>   block, bfq: remove local variable 'split' in bfq_init_rq()
>   block, bfq: remove local variable 'bfqq_already_existing' in
>     bfq_init_rq()
>   block, bfq: factor out a helper to split bfqq in bfq_init_rq()
> 
> [...]

Applied, thanks!

[1/7] block, bfq: fix uaf for accessing waker_bfqq after splitting
      commit: 1ba0403ac6447f2d63914fb760c44a3b19c44eaf
[2/7] block, bfq: fix procress reference leakage for bfqq in merge chain
      commit: 73aeab373557fa6ee4ae0b742c6211ccd9859280
[3/7] block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()
      commit: bc3b1e9e7c50e1de0f573eea3871db61dd4787de
[4/7] block, bfq: remove bfq_log_bfqg()
      commit: 553a606c25f8ff5c518c7fcf488dd4dd5fbb4795
[5/7] block, bfq: remove local variable 'split' in bfq_init_rq()
      commit: e61e002a67da9ec36571af743c94a968cf1ce116
[6/7] block, bfq: remove local variable 'bfqq_already_existing' in bfq_init_rq()
      commit: 3c61429c297582e0da7231fb29fc5ec1d2c7d1b2
[7/7] block, bfq: factor out a helper to split bfqq in bfq_init_rq()
      commit: a7609d2aec67ec16220036a5b1b14610883cdbd3

Best regards,
-- 
Jens Axboe



