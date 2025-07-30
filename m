Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775E296150
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878074; cv=none; b=XIx5QfiOJfL6kBYrbAy3Wlvi3xrI9tVGnBl8sSt57HGaDS5a2mXF+lfNyU+eUGhTBMwOcK+JgRHk1xs0UNCpVjZtYmssnAgR2qKu8wxZhkrUHUZeNG0/8Bz1bEkjS5OjEI+BASlCyT1iofoVmI8pbHZeMOcr09mGs7x5m2f5IPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878074; c=relaxed/simple;
	bh=xyL0W9oMMG9Q+BL0I0RaMFupEGbaZQQcbSubaHBCBMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=drTUn0Psmhluq58Lrx0VYpbhT8EoVdqB83XfKBFcS9k0soxvowWL0dUyXoJCzjU41Tw5F96lntavmNZSGTpk9SFm1s+eO3crABIRuG7l1QfcSz/o9N2SVTaSbqdHNm8RsKUnVCppcdowDIXiSdqwTsDOdFEHR1eHHJYhh0xxMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f9CYLlcZ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f9CYLlcZ"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e3faafe30fso4040995ab.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753878071; x=1754482871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obHk5cpW8ibOsQkdHT5W5Ic182JVr6ixisD7Divi97s=;
        b=f9CYLlcZRJkM8a1L2E5X7DwQrsHKqu3pv4pP4zxe03+kal9k6gFTkBw+0SPj11rw/A
         uGv2DHSQU1POUB1XE2A9vyqWVnwiSPJt6mLlPG7xRpuLPqHPvb9dWz9gf/nNsxW5x54r
         TXoNGzkpjA1c3QcLE4s19ATO3yXaV+SHpyFFiN0rufQifLhyPsh1IGYuiSUarQoAEDnI
         ZCE6P+dcwI84poYIGwhkLdpES/a/VrlOB52T8NqEODLHtM1XDNByUCeWC9I1Wy4sM/Y8
         aM2bvTSa3mMNqbb+M28h5Ef3WHbdhydUAzZgMki3mmcK0Gz3BxzbwXb/OIIps0ItrHb6
         2Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878071; x=1754482871;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obHk5cpW8ibOsQkdHT5W5Ic182JVr6ixisD7Divi97s=;
        b=I0lbWGp93etxJKNhhb/AXqpDMmKPkaY/VQhXHqrVgboLPmYnOBgMT74TYNSjseBLL+
         AEqs4nqLSC2ulwQdvgURGYoD6UDCQesCLW9U/8/I4Ovo0fqeItjbnONrkYp1+npT4+ff
         RIgVud/6UHQD06u7ip74i3VXbseWKIo2+QfG7dIWK9fd8cdC4kAApNnk5eoj1DFA5wz0
         nb3qdPf64AQYYvtBr4Q5Lkm7mLlscekxObmbYNibeAcrvl8xxd2KsHmdhxaeazveccOv
         ZbthQZjtTVSQS91Dcy3SgEailJhSbly59ebomYvvafjprWXsU/8+6Ycs9OC9JH0n90Ze
         +tkg==
X-Gm-Message-State: AOJu0Yxau9iuKcM1/N65ebb+nL6SIOK0C9ENYtlK3U21NAefC6fLb5xs
	xSl1VpEKn0GIwa/h1684ygQnyA1SRprXUNGvJ3JKbJY/IMsE1n3PimoQBZmSSsnpdFI=
X-Gm-Gg: ASbGncsxqtr/UigU+YjH38LyN0xdOLK0Q150jiIoUID3+BpaMK9miBMufSIf/pkOVF+
	mCN+Q5WvA7c0jy/F9Gillcpcp7dpRC6Rn1nKAw0CNriEO/jEfCkoLuXiRF0D9fdv7ND3A4Hytdm
	Hr8zIl4yiw83axuuBu0gX+GXV/PM9OM1zERbvFuN9MaBIE3mVhUrEJW5fZYk5pc14b+WgJcGlDE
	9uhXx4nFyLg1C5jiuveQM7MoHjbcsCRTZ9YbhpoIrdYx8IIHrlWE8us6G4BmjYpKvZQJbOPfYsZ
	RKJHxFitf4WSmom9f1myee0Sapc0p14LuwuSoAJw8DInXZq0vmJvQtPjuCguDg4ekhCIHAs6EDh
	BCRBXN6jhzj9GBrx/lOWCZxoo
X-Google-Smtp-Source: AGHT+IEXZm7hsJK9+77SrWdtms3EovYGXTxLBi1zK9QtC61vxfRt7sURKTFvkgS2FndxrbjubbBpVA==
X-Received: by 2002:a05:6e02:3003:b0:3e2:c5de:5f8 with SMTP id e9e14a558f8ab-3e3f60cd827mr44902505ab.9.1753878070706;
        Wed, 30 Jul 2025 05:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3f0d669d5sm11555045ab.35.2025.07.30.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:21:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com, 
 gjoyce@ibm.com
In-Reply-To: <20250730074614.2537382-1-nilay@linux.ibm.com>
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv8 0/3] block: move sched_tags allocation/de-allocation
 outside of locking context
Message-Id: <175387806915.286703.17580606581278989033.b4-ty@kernel.dk>
Date: Wed, 30 Jul 2025 06:21:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 30 Jul 2025 13:16:06 +0530, Nilay Shroff wrote:
> There have been a few reports[1] indicating potential lockdep warnings due
> to a lock dependency from the percpu allocator to the elevator lock. This
> patch series aims to eliminate that dependency.
> 
> The series consists of three patches:
> The first patch is preparatory patch and just move elevator queue
> allocation logic from ->init_sched into blk_mq_init_sched.
> 
> [...]

Applied, thanks!

[1/3] block: move elevator queue allocation logic into blk_mq_init_sched
      commit: 49811586be373e26a3ab52f54e0dfa663c02fddd
[2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
      commit: f5a6604f7a4405450e4a1f54e5430f47290c500f
[3/3] block: fix potential deadlock while running nr_hw_queue update
      commit: 04225d13aef11b2a539014def5e47d8c21fd74a5

Best regards,
-- 
Jens Axboe



